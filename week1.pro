function time_3_2, N
  time = findgen(16000)/(6.25e6)
  return, time[0:N-1]
end

function tseries_3_2,D
  GETPICO, '1V', D, 1, tseries
  return, tseries[100:227]
end

pro change_frq, v_sig
 srs1_frq, v_sig
end

pro plot_3_2, a
  v_sig = (a*0.1*(6.25e6))
  v_sample = 6.25e6
  change_frq, v_sig
  tseries = tseries_3_2(10)
  time = time_3_2(128)
  plot, time, tseries, psym = -4, charsize = 1.5
end

pro plot_3_2_ft,a
  N=128.
  !p.multi = [0,1,2]
  v_sig = (a*0.1*(6.25e6))
  v_sample = 6.25e6
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(v_sample))
  yinput = tseries_3_2(10)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft,  xinput, yinput, xoutput, youtput
  youtput = (abs(youtput))^2
  plot, xoutput, youtput, psym = -4
end

pro plot_3_3_equal
  v_sig = 6.25e6
  v_sample = v_sig
  change_frq, v_sig
  tseries = tseries_3_2(10)
  time = time_3_2(128)
  plot, time, tseries, psym = -4, charsize = 1.5
end

pro plot_3_3_large
  change_frq, 30e6
  getpico, '1V', 400, 1, tseries
  time = time_3_2(128)
  plot, time, tseries[100:227], psym = -4, charsize = 1.5
end

pro plot_3_4_vs, a
  N=128.
  !p.multi = [0,1,2]
  v_sig = (a*0.1*(6.25e6))
  v_sample = 6.25e6
  change_frq, v_sig
  xinput = time_3_2(N) - ((N/2.)/(6.25e6))
  yinput = tseries_3_2(10)
  xoutput = ((findgen(N)-(N/2.))*v_sample/N)
  dft,  xinput, yinput, xoutput, youtput
  plot, xoutput, real_part(youtput), psym = -4
  plot, xoutput, imaginary(youtput), psym = -4
end

;  N = 128.
;  v_sig = 30e6
;  v_sample = 62.5e6/400.
;  xinput = time* - ((N/2.)/(v_sample))
;  yinput = tseries[100:227]
 ; xoutput = ((findgen(N)-(N/2.))*v_sample/N)
 ; dft, xinput, yinput, xoutput, youtput
 ;; youtput = (abs(youtput))^2
 ; plot, xoutput, youtput, psym = -4

pro plot_3_5
!p.multi = [0,1,2]
N = 128.
v_sample = (62.5e6)/6175
change_frq, 1e5
tseries = tseries_3_2(6175)
time = findgen(16000)/v_sample
xinput = time[0:127] - ((N/2.)/(v_sample))
xoutput = ((findgen(N)-(N/2.))*v_sample/N)
dft, xinput, tseries, xoutput, youtput
plot, time[0:127], tseries, psym = -4
plot, xoutput, (abs(youtput))^2, psym = -4

end

pro plot_3_6

!p.multi = [0,1,2]
N = 128.
v_sample = (62.5e6)/6220
change_frq, 1e5
tseries = tseries_3_2(6220)
time = findgen(16000)/v_sample
xinput = time[0:127] - ((N/2.)/(v_sample))
xoutput = ((findgen(N)-(N/2.))*v_sample/N)
dft, xinput, tseries, xoutput, youtput
plot, xinput, tseries, psym = -4
;plot, xoutput, real_part(youtput), psym = -4
;plot, xoutput, imaginary(youtput), psym = -4
arr_real = real_part(youtput)

for x = 0, n_elements(xoutput)-1 do begin
if xoutput[x] GT 1000 OR xoutput[x] LT -1000 then begin
youtput[x] = 0
endif
endfor

;plot, xoutput, real_part(youtput), psym = -4
;plot, xoutput, imaginary(youtput), psym = -4

dft, xoutput, youtput, xinput, filtered_y, /inverse
print, filtered_y
plot, xinput, filtered_y, psym = -4
end


pro plot_3_7
N = 1024.
D = 1
!p.multi = [0,2,2]
v_sample = (62.5e6) / float(D)
change_frq, 0.1*(6.25e6)
GETPICO, '1V', D, 1, tseries
tseries = tseries[100:1123]
time = time_3_2(N) - ((N/2.)/(v_sample))
plot, time_3_2(N), tseries, psym = -4, xrange = [0,1e-4]
xoutput = ((findgen(N)-(N/2.))*v_sample/N)
dft, time, tseries, xoutput, youtput
plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.8;, xrange = [-5e6,5e6]
plot, xoutput, real_part(youtput), psym = -4
plot, xoutput, imaginary(youtput), psym = -4

;, xrange = [1.5e6,2e6];;(;,yrange = [-0.5,0.5]

end



pro plot_3_8

N = 1024.
D = 1
!p.multi = [0,2,2]
v_sample = (62.5e6) / float(D)
;;;;;;change_frq, 0.1*(6.25e6)
GETPICO, '1V', D, 1, tseries
tseries = tseries[100:1123]
time = time_3_2(N) - ((N/2.)/(v_sample))
plot, time_3_2(N), tseries, psym = -4, xrange = [0,1e-4]
xoutput = ((findgen(N)-(N/2.))*v_sample/N)
dft, time, tseries, xoutput, youtput
plot, xoutput, (abs(youtput))^2, psym = -4, charsize = 1.8;, xrange = [-5e6,5e6]
plot, xoutput, real_part(youtput), psym = -4
plot, xoutput, imaginary(youtput), psym = -4

end
