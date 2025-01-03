Return-Path: <linux-wireless+bounces-17061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BDCA00ECC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 21:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4970C3A40B5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3E84A5B;
	Fri,  3 Jan 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvKwzJik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504B186A;
	Fri,  3 Jan 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935594; cv=none; b=P/6xh7X5LwZ+b3KGmDXIJ98o77fHResfi0WYbyI0L5AmicOej8TQKo4re3cJhoK9qvRioCshO5YkFKkRuBCkNbUWsycMq1y2Wz+xr4DxmeWggpTbS92w38Ry8UNzBC+mTz+ecV2PtOtOHp+CnxgwjXX5OZew423KqAoLxkpPWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935594; c=relaxed/simple;
	bh=T7GbSaihl+sYiS3Na4luZzFpX6FX6h6b/0EoQiY6ek8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXkhg7K1H3rdOL10+LzfQaX59AXt1LG1PJguxC35MSU+kRCG7oFEYa9UThME0hQQ+DY9eai+pRw+lIGVZtMEhZ0LPoXESpnDVOgHXt3R0qpShtNsZJWoF+6xP8U9QdIEcioNzl3PI0J7Z+DgondUgx9jrkABY5UvYEchW8/+d00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvKwzJik; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3047818ac17so108933751fa.3;
        Fri, 03 Jan 2025 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735935590; x=1736540390; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lCPgeCPRbL8gK7a6TzW+xRG1AXhdLNpWqRZxQpTyiI=;
        b=gvKwzJik6cYZeH6OlMEzQo4TvxJwW0731q7VEneaRUGvQEIazmQx6nAtUB7xs4S6CW
         BkOMUYlbqM8jsUKtIw4vXCdVjbOiGi2DFUUG5M+pniYxBGAxXF3voEAOGZNRn8G5ftSA
         XOde5hP9lsZBYCyDlGRDjK6WIjwaBYBiqru6gs9dSCEwuTXksrw20Abav9Rj5EQEp9nn
         2ezkNpvx6PbPbLbRYVPR69BnZrkLzq9PnKA4INRBKzQQlsh8bYiUUk+PUQPYRasboscH
         1bjw/zcq14OAABYdc4okG0szw+/shn0LY32OOrSSxJKFiIFHZFaf9aB5EsPGrlbA/Tgr
         KyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735935590; x=1736540390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lCPgeCPRbL8gK7a6TzW+xRG1AXhdLNpWqRZxQpTyiI=;
        b=QRcqrxeZz5glEq++GcDMldR5vx7uET/QSoBMyoKW9ClrhhcKx+a2A3MO8EWHywJqQk
         rLlw7EYAvTErz7+QohKAH7tf9g3vO837RokwHnlr2rMoHiYdbGiuxc2lvq4AhXnFdRG3
         KAlmLh6CF/7DAr/JcrZrS/atnVAi1Ci/zV6k3tqXCAeGl6rtziyYGtTYJuQI5bLA2Bry
         ccSc/k95jeYl1/NVhONBE0FE9MK++SSGwjf1ruMzUYQ1Ox06qC8cJJ0xOCHaMoEnezsF
         5xGrThwpSCEql4L+IwO3SZijrtY5suVI8hoCRmkYzPM3PggVkuUzyQY7Owlcx31Sxofp
         ABug==
X-Forwarded-Encrypted: i=1; AJvYcCUIQN36g0m95xnGzoPfkpEjb9Ov/wOzIyUjK9+IQcxiwA6EFK7R5i410n8W2gKNaTYcHftGSc5Xei8GI556d7c=@vger.kernel.org, AJvYcCVv8TWwcOq4vG8SYubwmM4nOjqXb+1vwYOUoJUTrVY0g9xgHzQOmqrKI425cQbH+Jncz/cO7D1x@vger.kernel.org, AJvYcCWg+84FldVLRZ2G+CleD1AnpIw+DnmqglVyozDEuh4kqixlnEhIM038UEs2EQdx79Vc4+7iGG/KLO9SZL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTTkGWPyHlMZkYzqmwYJXNcMSIvQ7tPX4kHMOHx+StpNkfxWS
	/WJJIPQYPJYwnOTH7MnDHn5OZS7DQ2iwJ5LteYQF8OEkww24Q9di
X-Gm-Gg: ASbGnct8WWskGjIvzEatqF650pW1TunZPDaY/IZtIgTii/DwDtItaPGJmRJ3QXilP+q
	OSxtEw2T2LMx9oF+uInCiRPcGvF5hJO5iYYjn5DxCkQbod4E+bhSfniqXzCVci/kadPY6GMXaLx
	Y0nVbUnhcfLl0pD1CCwSLgkEelWFSQglHgOzSg/0mVVn1iOn7zHgZWRuW4sGAUqLRBKrbsuX8WV
	7wIbq6+03+jg33sl1NtIUt/cfdWAvXj7fFS3iadNufo1yaSEyKilBQP4oxd
X-Google-Smtp-Source: AGHT+IFnPvqWi2FDMbZQ2U2GcMYnYrRHFJsC5NyLzc8peVrUbft0Vyq4lWzKrIVQjJx9BdjvcFFwAQ==
X-Received: by 2002:a05:6512:110d:b0:540:2a92:7da9 with SMTP id 2adb3069b0e04-54229539f3dmr9847756e87.21.1735935590130;
        Fri, 03 Jan 2025 12:19:50 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542609a5de4sm885974e87.108.2025.01.03.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 12:19:49 -0800 (PST)
Date: Fri, 3 Jan 2025 23:19:48 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Message-ID: <Z3hGZLKQUvT5-8Al@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20250103075107.1337533-1-anarsoul@gmail.com>
 <Z3g0MLOJlLsPnF1m@skv.local>
 <CA+E=qVcmHzLkH9eijPqw0_o-pOZEhXpWoPGmRmzLRFGaZiNnwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+E=qVcmHzLkH9eijPqw0_o-pOZEhXpWoPGmRmzLRFGaZiNnwA@mail.gmail.com>

On 25-01-03 11:10, Vasily Khoruzhick wrote:
> On Fri, Jan 3, 2025 at 11:02 AM Andrey Skvortsov
> <andrej.skvortzov@gmail.com> wrote:
> >
> > On 25-01-02 23:50, Vasily Khoruzhick wrote:
> > > Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> > > fatal and do not seem to have any impact, just fix them to match vendor
> > > driver.
> > >
> > > However the last one in rtw8703b_set_channel_bb() clears too many bits
> > > in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> > > above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
> > >
> > > With the last typo fixed, the driver is able to reach MCS7 on Pinebook
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >
> > Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> >
> > Thank you, Vasily, for fixing that. Performance is much better with
> > the fix. Here are iperf results made on PinePhone:
> 
> Thanks for testing!
> 
> > 1. without the patch using rtw88 driver
> >   1.98 Mbits/sec
> >
> > 2. with the patch using rtw88 driver
> >   14.0 Mbits/sec
> >
> > 3. using old vendor 8723cs driver
> >   23.6 Mbits/sec
> 
> Interesting, I get 30-50 Mbit/s on both rtw88 and vendor driver on
> Pinebook for either TX or RX, however I am pretty close (a few meters)
> to the AP and it isn't a noisy env (Pinebook can pick up just 4 other
> 2.4G APs besides mine, none on the same channel). Could you try
> disabling bluetooth (run bluetoothctl, and do "power off") and re-run
> the test?

yes, previous test were done with Bluetooth enabled. With disabled
(power off) Bluetooth performance is slightly better.

Here is how I tested to make sure, that we are on the same page:
1. on device 'iperf -s'
2. on PC 'iperf -c <device> -e -i 10 -t 250'

Here are more detailed testing results:

1. without the patch using rtw88 driver

[  1]  (icwnd/mss/irtt=14/1448/66504) (ct=66.55 ms) 
[ ID] Interval            Transfer    Bandwidth       Write/Err  Rtry     InF(pkts)/Cwnd(pkts)/RTT(var)        NetPwr
[  1] 0.0000-10.0000 sec  2.38 MBytes  2.00 Mbits/sec  20/0        73       22K(16)/24K(17)/56167(15843) us  4.448847
[  1] 10.0000-20.0000 sec  5.88 MBytes  4.93 Mbits/sec  47/0        38      178K(126)/178K(126)/462265(40709) us  1.332652
[  1] 20.0000-30.0000 sec  2.76 MBytes  2.31 Mbits/sec  25/0       182       12K(9)/12K(9)/32519(11137) us  8.892008
[  1] 30.0000-40.0000 sec  2.80 MBytes  2.35 Mbits/sec  23/0        48       45K(32)/45K(32)/186889(21282) us  1.569355
[  1] 40.0000-50.0000 sec  6.31 MBytes  5.29 Mbits/sec  51/0        24      188K(133)/188K(133)/574842(11821) us  1.151013
[  1] 50.0000-60.0000 sec  5.06 MBytes  4.25 Mbits/sec  43/0         8      346K(245)/346K(245)/412227(75277) us  1.287768
[  1] 60.0000-70.0000 sec  4.29 MBytes  3.60 Mbits/sec  38/0        81      284K(201)/284K(201)/339931(17905) us  1.323076

2. with the patch using rtw88 driver

[  1]   (icwnd/mss/irtt=14/1448/40241) (ct=40.27 ms) 
[ ID] Interval            Transfer    Bandwidth       Write/Err  Rtry     InF(pkts)/Cwnd(pkts)/RTT(var)        NetPwr
[  1] 0.0000-10.0000 sec  22.0 MBytes  18.5 Mbits/sec  176/0         0     1069K(756)/1090K(771)/466471(10659) us  4.945374
[  1] 10.0000-20.0000 sec  20.5 MBytes  17.2 Mbits/sec  164/0         0     2075K(1468)/3919K(2772)/1453362(10765) us  1.479040
[  1] 20.0000-30.0000 sec  16.7 MBytes  14.0 Mbits/sec  137/0       140     2099K(1485)/2589K(1831)/1466588(44692) us  1.193315
[  1] 30.0000-40.0000 sec  16.8 MBytes  14.1 Mbits/sec  136/1       169      446K(316)/1914K(1354)/1511938(187) us  1.166601
[  1] 40.0000-50.0000 sec  14.8 MBytes  12.4 Mbits/sec  121/1         6     1278K(904)/1278K(904)/4145469(8168) us  0.374480
[  1] 50.0000-60.0000 sec  22.0 MBytes  18.5 Mbits/sec  177/1        26      905K(640)/1084K(767)/428675(700) us  5.389748
[  1] 60.0000-70.0000 sec  18.1 MBytes  15.2 Mbits/sec  146/0       247      229K(162)/254K(180)/129034(4979) us  14.74

3. using old vendor 8723cs driver

[  1]  (icwnd/mss/irtt=14/1448/91025) (ct=91.07 ms) 
[ ID] Interval            Transfer    Bandwidth       Write/Err  Rtry     InF(pkts)/Cwnd(pkts)/RTT(var)        NetPwr
[  1] 0.0000-10.0000 sec  38.3 MBytes  32.1 Mbits/sec  306/0         0     1938K(1371)/1949K(1379)/419011(4587) us  9.572087
[  1] 10.0000-20.0000 sec  36.8 MBytes  30.8 Mbits/sec  294/0         0     2258K(1597)/3809K(2694)/856058(270) us  4.501467
[  1] 20.0000-30.0000 sec  38.4 MBytes  32.2 Mbits/sec  307/0         0     2360K(1669)/3809K(2694)/727066(112) us  5.534450
[  1] 30.0000-40.0000 sec  38.5 MBytes  32.3 Mbits/sec  308/0         0     2371K(1677)/3809K(2694)/786411(100) us  5.133470
[  1] 40.0000-50.0000 sec  40.8 MBytes  34.2 Mbits/sec  326/0         0     2563K(1813)/3809K(2694)/652361(18130) us  6.549973
[  1] 50.0000-60.0000 sec  35.4 MBytes  29.7 Mbits/sec  283/0         0     2524K(1785)/5953K(4210)/670626(151) us  5.531157
[  1] 60.0000-70.0000 sec  39.5 MBytes  33.1 Mbits/sec  316/0         0     2502K(1770)/5953K(4210)/707670(140) us  5.852834


> I noticed that btcoex is implemented differently in rtw88
> and in the vendor driver, so it might not be working correctly.
yeah, I couldn't make good-enough VoIP-calls on WiFi
using PinePhone with rtw88, but I could make it just fine with old
vendor driver. But I've switched to rtw88 anyway.

-- 
Best regards,
Andrey Skvortsov

