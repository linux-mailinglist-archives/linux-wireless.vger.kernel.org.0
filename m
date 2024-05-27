Return-Path: <linux-wireless+bounces-8149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F698D106E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 01:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A710B20FEA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74A13AA37;
	Mon, 27 May 2024 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/eH+xGL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337E383B1
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851189; cv=none; b=TlW72HC1D6lvGB5r4yp0nVzwLm0MIWGfprvcncMIIPBdwYK/OZqsZrK5fNAgYl+HfLW5s5iP9szxSDzY2bLSszWW6ctq4DAu8tCnieMe8WI6yLka+EY4ov9jwU/2F7v/u1yY38uZh06BJzjZ1Fdlb/fLlU4MMXpDmrzSyTFFgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851189; c=relaxed/simple;
	bh=iO9QNvXPI4Qq//1logaEi/fTGWVm7ptkThrPT8ZFwrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtdOqOCDDr7qPclVZesCT5T1WvWrB49pWxb3CdGlqKV4Lf0Eq96nwhDwQQZEZmezAwXFG+97SoAboy52K9SdAGAKDVn1xctVwuTVhqf0X4CgQVM4SLesLFCmoMtoBk3Isr44I6i6nV/CXeor4sAWRk2thzqob4kTa/IdG8Hfqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/eH+xGL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b5922so1829985e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716851186; x=1717455986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQipq0Jbti0lXoSeuuTzKQ7+a/UI44bEQNQKIxlpNmI=;
        b=a/eH+xGLiHcKZChhFwoQmFG8ABG9s9wv9g8iu/Sid6e0ut0fjVqHO+qIEH6cjUC0Oa
         zKP6qgtb4UTbrulbvj8QHGbqF54oTRxL3zus/caN++FZ/m5Ingz2ZdOge3owDSMpFCcc
         3S2z9iJkOQh6P1a0ccKi+mxU0lnPe0N4P05VS5M3MOWgWVCf5E80hwea3TdqD7WCPF11
         BnDqM73vJT2UacyqO9L3oUYiqFJDVwGOOx7gzI8/MjdI8bkLmaWzL9dJpNt81IMDqxaK
         E5TRxlGpD09DtbsctT26y+RVgR4a9zH5p70wV2/QcjNq6tZ/St5wmIlKeGJb9ESnbA3H
         ibJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716851186; x=1717455986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQipq0Jbti0lXoSeuuTzKQ7+a/UI44bEQNQKIxlpNmI=;
        b=FjMzF/4JgCf4+Btgj6wegCNAJT+KYIu+3pv8eNWFTQSF9JoJL1qeq2H7kSzmdjTLOo
         UtWz83vxMwqGKrc7BH8Ay952noEusURlTIRLkrPATMefwbNnd6Nl4d6oZwpPP/F8pjTW
         YQuCBG2HSBb7Ghgexgd0HKbxYhj64qjeAhAPoAtxnSqZhbzU6R4X2Vswz8YDPfcyiajT
         7A2iZEvzOgs2ABtk9W0UcLneHOni/+L7C+bWHbOZtaSUmEsS8bxVrpfE3+42OcuVnJxs
         e/ZO115RxP7Nm31n3fLBF7oLt8rSr0akObNOWAfv7Oag6ldJGAPWuNzjygtPOsaxuY0w
         4P0g==
X-Gm-Message-State: AOJu0YzAcRktmDj4SLUoyZIxsdMBGyr02UCz0sU7uif/cgqUTBoW9O9x
	12L7MRoQQrLcjFtRuHvjZtWcZy0iOkzMSQ7aWZMO+klBDWdd87VO2MDg2w==
X-Google-Smtp-Source: AGHT+IEKMS5uXwlUYeKSlXyhHG+jBdIJtnWvLWYYmxxJh38oMzDpERzTxN26S6eA0plE2wtBfnVPXw==
X-Received: by 2002:a05:600c:230d:b0:420:78f:3f9b with SMTP id 5b1f17b1804b1-42108aa76ddmr100736195e9.37.1716851185279;
        Mon, 27 May 2024 16:06:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm10004612f8f.29.2024.05.27.16.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 16:06:24 -0700 (PDT)
Message-ID: <29f850c5-4f61-466f-9a7a-437b05bc8251@gmail.com>
Date: Tue, 28 May 2024 02:06:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>, Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Christian Hewitt <chewitt@libreelec.tv>,
 Johannes Berg <johannes@sipsolutions.net>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
 <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
 <0002749a3b584bc39fa18b3137153fdf@realtek.com> <20240527112534.4dbcdf75@mir>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20240527112534.4dbcdf75@mir>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2024 12:25, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2024-05-27, Ping-Ke Shih wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>> The RTL8192DU is an older Wifi 4 dual band chip. It comes in two
>>> flavours: single MAC single PHY (like most Realtek Wifi 4 USB devices),
>>> and dual MAC dual PHY.
> [...]
>>> Stefan Lippers-Hollmann tested the speed in the 5 GHz band with 40 MHz
>>> channel width: 173/99 megabits/second.
>>
>> Could you please confirm this description is still correct in v7?
>> If so, your Tested-by tag is welcome.
> 
> I held back with a formal Tested-by for this, as rtlwifi needs
> some fixing after the chanctx changes
> (0a44dfc070749514b804ccac0b1fd38718f7daa1, "wifi: mac80211:
> simplify non-chanctx drivers") went in (for v6.9 and up).
> 
> So, yes, rtl8192du v7 itself works fine (as did v6 and previous), but
> the chanctx changes do cause a performance regression, resulting in
> lower (and very inconsistent) throughput and larger packet loss,
> due to the rate control being confused. As Bitterblue found out,
> rtlwifi relies on the previous behaviour imposed by
> 
> ieee80211_hw_config(local, ~0);
> 
> As a consequence of the change to
> 
> ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_LISTEN_INTERVAL |
> 				   IEEE80211_CONF_CHANGE_MONITOR |
> 				   IEEE80211_CONF_CHANGE_PS |
> 				   IEEE80211_CONF_CHANGE_RETRY_LIMITS |
> 				   IEEE80211_CONF_CHANGE_IDLE);
> 
> mac80211 effectively sets a retry limit of 0x4, while rtlwifi
> expects a retry limit of 0x30 (in STA mode or 0x7 in AP mode),
> causing rtlwifi not to settle on a good fallback rate (and thereby
> losing packets).
> 
> Disclaimer: the above issue and its explanation has been discovered
> by Bitterblue, I just did the git bisecting (rtl8192du on top of
> v6.8..v6.9) and performance testing to pinpoint the commit causing
> the regression.
> 
> rtl8192du on top of v6.9+ (with the chanctx changes):
> $ iperf3 -c <remote_ipv6>
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   384 KBytes  3.14 Mbits/sec
> [  5]   1.00-2.00   sec   512 KBytes  4.19 Mbits/sec
> [  5]   2.00-3.00   sec  1.00 MBytes  8.39 Mbits/sec
> [  5]   3.00-4.00   sec   640 KBytes  5.24 Mbits/sec
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
> [  5]   6.00-7.00   sec   256 KBytes  2.10 Mbits/sec
> [  5]   7.00-8.00   sec   640 KBytes  5.25 Mbits/sec
> [  5]   8.00-9.00   sec   512 KBytes  4.19 Mbits/sec
> [  5]   9.00-10.00  sec   256 KBytes  2.10 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.00  sec  4.12 MBytes  3.46 Mbits/sec                  receiver
> 
> $ iperf3 -c <remote_ipv6> --reverse
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  12.9 MBytes   108 Mbits/sec    0    629 KBytes
> [  5]   1.00-2.00   sec  9.75 MBytes  81.8 Mbits/sec    0   1.13 MBytes
> [  5]   2.00-3.00   sec  11.0 MBytes  92.3 Mbits/sec    0   1.63 MBytes
> [  5]   3.00-4.00   sec  1.38 MBytes  11.5 Mbits/sec    1   1.67 MBytes
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    1   1.39 KBytes
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    1   1.39 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KBytes
> [  5]   7.00-8.00   sec  9.88 MBytes  82.8 Mbits/sec    0   2.12 MBytes
> [  5]   8.00-9.00   sec  6.88 MBytes  57.7 Mbits/sec    3   2.32 MBytes
> [  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   2.32 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  51.8 MBytes  43.4 Mbits/sec    6             sender
> 
> $ iperf3 -c <remote_ipv6> --bidir
> [ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5][RX-S]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   0.00-1.00   sec  1.38 MBytes  11.5 Mbits/sec    0   90.6 KBytes
> [  5][RX-S]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   1.00-2.00   sec  4.12 MBytes  34.6 Mbits/sec    4   1.39 KBytes
> [  5][RX-S]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.39 KBytes
> [  5][RX-S]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    1   1.39 KBytes
> [  5][RX-S]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KBytes
> [  5][RX-S]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    2    106 KBytes
> [  5][RX-S]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0    106 KBytes
> [  5][RX-S]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0    106 KBytes
> [  5][RX-S]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0    106 KBytes
> [  5][RX-S]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec
> [  8][TX-S]   9.00-10.00  sec  1.25 MBytes  10.5 Mbits/sec    2    119 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][RX-S]   0.00-10.01  sec  0.00 Bytes  0.00 bits/sec                  receiver
> [  8][TX-S]   0.00-10.01  sec  6.75 MBytes  5.66 Mbits/sec   10             sender
> 
> Again, rtl8192du v7 itself is 'fine' and could (can) achieve 180/100
> MBit/s before the chanctx changes, so merging v7 might be okay - but
> there needs to be a fix for rtlwifi as a whole (and maybe even other
> drivers) for v6.9+ and the chanctx changes that came with it (not
> every chipset supported by rtlwifi might be affected equally badly,
> e.g. rtl8192cu might not noticeably be, according to Bitterblue's
> testing).
> 
> So with the (performance/ packet loss) caveat above:
> 
> Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> 
> I am running rtl8192du v7 on top of v6.9.2 now (and tested it on top
> of wireless-next as of last Friday (2024-05-24)), with the performance
> figures above.
> 
> Regards
> 	Stefan Lippers-Hollmann
> 
> --
> This is the result of my git bisecting:
> 
> $ git bisect good
> 0a44dfc070749514b804ccac0b1fd38718f7daa1 is the first bad commit
> commit 0a44dfc070749514b804ccac0b1fd38718f7daa1
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Mon Jan 29 19:34:38 2024 +0100
> 
>     wifi: mac80211: simplify non-chanctx drivers
> 
>     There are still surprisingly many non-chanctx drivers, but in
>     mac80211 that code is a bit awkward. Simplify this by having
>     those drivers assign 'emulated' ops, so that the mac80211 code
>     can be more unified between non-chanctx/chanctx drivers. This
>     cuts the number of places caring about it by about 15, which
>     are scattered across - now they're fewer and no longer in the
>     channel context handling.
> 
>     Link: https://msgid.link/20240129194108.6d0ead50f5cf.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
>  drivers/net/wireless/admtek/adm8211.c                          |   4 +
>  drivers/net/wireless/ath/ar5523/ar5523.c                       |   4 +
>  drivers/net/wireless/ath/ath5k/mac80211-ops.c                  |   4 +
>  drivers/net/wireless/ath/ath9k/htc_drv_main.c                  |   4 +
>  drivers/net/wireless/ath/ath9k/main.c                          |   4 +
>  drivers/net/wireless/ath/carl9170/main.c                       |   4 +
>  drivers/net/wireless/ath/wcn36xx/main.c                        |   4 +
>  drivers/net/wireless/atmel/at76c50x-usb.c                      |   4 +
>  drivers/net/wireless/broadcom/b43/main.c                       |   4 +
>  drivers/net/wireless/broadcom/b43legacy/main.c                 |   4 +
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c |   4 +
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c                 |   4 +
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c                 |   4 +
>  drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c              |   4 +
>  drivers/net/wireless/intersil/p54/main.c                       |   4 +
>  drivers/net/wireless/marvell/libertas_tf/main.c                |   4 +
>  drivers/net/wireless/marvell/mwl8k.c                           |   4 +
>  drivers/net/wireless/mediatek/mt76/mt7603/main.c               |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c                |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c           |   4 +
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c           |   4 +
>  drivers/net/wireless/mediatek/mt76/mt792x_core.c               |   7 +-
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c               |   4 +
>  drivers/net/wireless/mediatek/mt7601u/main.c                   |   4 +
>  drivers/net/wireless/purelifi/plfxlc/mac.c                     |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2400pci.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2500pci.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2500usb.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2800pci.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2800soc.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt2800usb.c                 |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt61pci.c                   |   4 +
>  drivers/net/wireless/ralink/rt2x00/rt73usb.c                   |   4 +
>  drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c             |   4 +
>  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c             |   4 +
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c          |   4 +
>  drivers/net/wireless/realtek/rtlwifi/core.c                    |   4 +
>  drivers/net/wireless/realtek/rtw88/mac80211.c                  |   4 +
>  drivers/net/wireless/realtek/rtw89/core.c                      |   7 +-
>  drivers/net/wireless/rsi/rsi_91x_mac80211.c                    |   4 +
>  drivers/net/wireless/st/cw1200/main.c                          |   4 +
>  drivers/net/wireless/ti/wl1251/main.c                          |   4 +
>  drivers/net/wireless/virtual/mac80211_hwsim.c                  |   4 +
>  drivers/net/wireless/zydas/zd1211rw/zd_mac.c                   |   4 +
>  drivers/staging/vt6655/device_main.c                           |   4 +
>  drivers/staging/vt6656/main_usb.c                              |   4 +
>  include/net/mac80211.h                                         |  13 ++
>  net/mac80211/cfg.c                                             |  42 +++----
>  net/mac80211/chan.c                                            | 111 +++--------------
>  net/mac80211/ieee80211_i.h                                     |   9 +-
>  net/mac80211/iface.c                                           |   6 +-
>  net/mac80211/main.c                                            | 205 +++++++++++++++++++++++++------
>  net/mac80211/mlme.c                                            |   3 +-
>  net/mac80211/offchannel.c                                      |  21 ++--
>  net/mac80211/scan.c                                            |  18 +--
>  net/mac80211/tx.c                                              |   2 -
>  net/mac80211/util.c                                            |  27 ++--
>  58 files changed, 444 insertions(+), 207 deletions(-)
> 
> $ git bisect log
> git bisect start
> # Status: warte auf guten und schlechten Commit
> # bad: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> git bisect bad a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> # Status: warte auf gute(n) Commit(s), schlechter Commit bekannt
> # good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
> git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
> # bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
> git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910
> # bad: [9187210eee7d87eea37b45ea93454a88681894a4] Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 9187210eee7d87eea37b45ea93454a88681894a4
> # bad: [9187210eee7d87eea37b45ea93454a88681894a4] Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 9187210eee7d87eea37b45ea93454a88681894a4
> # good: [a01c9fe32378636ae65bec8047b5de3fdb2ba5c8] Merge tag 'nfsd-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> git bisect good a01c9fe32378636ae65bec8047b5de3fdb2ba5c8
> # bad: [ca61ba3885274a684c83d8a538eb77b30e38ee92] Merge branch 'rework-genet-mdioclocking'
> git bisect bad ca61ba3885274a684c83d8a538eb77b30e38ee92
> # good: [f42822f22b1c5f72c7e3497d9683f379ab0c5fe4] bnxt_en: Use firmware provided maximum filter counts.
> git bisect good f42822f22b1c5f72c7e3497d9683f379ab0c5fe4
> # bad: [e10cd2ddd89e8b3e61b49247067e79f7debec2f1] wifi: rtw89: load BB parameters to PHY-1
> git bisect bad e10cd2ddd89e8b3e61b49247067e79f7debec2f1
> # good: [2594e4d9e1a2d79bf7bb262974abaf5ef153e371] wifi: iwlwifi: prepare for reading SAR tables from UEFI
> git bisect good 2594e4d9e1a2d79bf7bb262974abaf5ef153e371
> # bad: [719036ae06d4bfdb65139e3947a8404dec298bc5] wifi: cfg80211: move puncturing validation code
> git bisect bad 719036ae06d4bfdb65139e3947a8404dec298bc5
> # good: [1209f487d452ff7e822dec30661fd6b5163fb8cf] wifi: rtl8xxxu: Add TP-Link TL-WN823N V2
> git bisect good 1209f487d452ff7e822dec30661fd6b5163fb8cf
> # good: [4dbd964f33aab6f99891b9610ad4b36cc215be0d] wifi: rtw89: 8922a: add chip_ops::rfk_hw_init
> git bisect good 4dbd964f33aab6f99891b9610ad4b36cc215be0d
> # good: [2fd53eb04c492eb9a2b06f994b36e5cf34ba7541] wifi: mac80211: remove unused MAX_MSG_LEN define
> git bisect good 2fd53eb04c492eb9a2b06f994b36e5cf34ba7541
> # bad: [0a44dfc070749514b804ccac0b1fd38718f7daa1] wifi: mac80211: simplify non-chanctx drivers
> git bisect bad 0a44dfc070749514b804ccac0b1fd38718f7daa1
> # good: [61f0261131c8dc2beeb6b34781a54788221081e9] wifi: mac80211: clean up band switch in duration
> git bisect good 61f0261131c8dc2beeb6b34781a54788221081e9
> # good: [2d9698dd32d086e47b8bff3df4322cc017c17b55] wifi: mac80211: clean up HE 6 GHz and EHT chandef parsing
> git bisect good 2d9698dd32d086e47b8bff3df4322cc017c17b55
> # first bad commit: [0a44dfc070749514b804ccac0b1fd38718f7daa1] wifi: mac80211: simplify non-chanctx drivers

That's all correct.

Johannes suggested that we should set hw->wiphy->retry_{long,short}
before ieee80211_register_hw(). So that would go in
_rtl_init_mac80211(). That has the added benefit of making the
true retry limits visible to userspace ("iw phy").

The problem is that setting hw->wiphy->retry_{long,short} is
not enough. rtlwifi still gets the default retry limits of 4
and 7, because ieee80211_register_hw() doesn't set
hw->conf.long_frame_max_tx_count (and hw->conf.short_frame_max_tx_count).
Johannes suggested moving this code from ieee80211_alloc_hw_nm()
to ieee80211_register_hw():

	local->hw.conf.long_frame_max_tx_count = wiphy->retry_long;
	local->hw.conf.short_frame_max_tx_count = wiphy->retry_short;

I didn't do this yet partly because I don't want to compile
the entire kernel, and partly because I'm not sure how to handle
the different retry limits for AP/IBSS mode and station mode.

Can we change hw->wiphy->retry_{long,short} any time, not just
before ieee80211_register_hw()? If yes, what is even the point
of hw->conf.{short,long}_frame_max_tx_count ? It would be simpler
if we can ignore them and use hw->wiphy->retry_{long,short}
directly.

What do y'all think?

