function prob = comMeasure(s, m)

[Tcom, Ncom, Bcom, kcom, tcom] = frenet(m(:, 1), m(:, 2), m(:, 3));

prob = kcom;

end