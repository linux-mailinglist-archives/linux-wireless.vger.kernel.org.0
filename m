Return-Path: <linux-wireless+bounces-24555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A825BAEA135
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A196C7ACCF5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16328934F;
	Thu, 26 Jun 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrW7wgQS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E322E4274
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949302; cv=none; b=Ju2R5K73dE3AXThJS8mTeuyZ+hm5AQk+VahRizZZCod75iZtR3vKVAyn7vIfjK4CxqQDLHThCotS4t4RYRW4aetVlw4BsJNuvvBAAWxt7gvOJXfFVr4C6r7ZwL3L40B5Sb7H9ylbfA3UXxsW7FsNjJRy/p+Dja09Q0FSgVKB3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949302; c=relaxed/simple;
	bh=aiw8VEIBdfphQwyrfdK4iKbqclBGgU7G8SNbgjBdszU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=nXFOqd1H5+q9mNh2SUCt0Y4Zouoyb73uFus3mqzoO5/rSI2+2RdUlOSQsvrgGJ/V5v170CqclO3uy6Gmwj/voCYvTpnxRCDn7wjgf8bnn0wWMzNf32GffX2a2lVmeA0gYk9FfY45VhOJjVYupMLyj8e1CJMETHqQnVwROgebuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrW7wgQS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so11288755e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750949298; x=1751554098; darn=vger.kernel.org;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJwlXkm7kquT9VL2iSx95X+5Uf83x9tlRzgwBHxTlN8=;
        b=UrW7wgQScxzg0bjJSKS/HtTHQ3IcilHwo8gSai6kzj001+HRsKBiQvnhHnNXxhoV78
         TLyqd6ZsE3ZRnZiUnsMAH3tW46N4yV+PxuMLZBBMqzkXkqz+80HAnZH/rmbVKOiA3V0V
         uIkOz3T/vlv5qdwxlYoBE4CBv9978lwyM0Y4XTy4znWADqGOTRhmaSiTD14UpK8ZvLS+
         NIoHCwbizuiIlIA/wso0I1ph81guPx3Pkd7Tu6auUNFZmtfSi+aIY1Wq+kPBCDB7Q7/R
         geR0nVKmpp5vo3NT3lcFeKaPVZ1QrRgZOd3/Yr2WLLbLOwkUcIVshrIwTSJncmWKdixg
         llrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949298; x=1751554098;
        h=to:from:subject:cc:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJwlXkm7kquT9VL2iSx95X+5Uf83x9tlRzgwBHxTlN8=;
        b=iK6qpZzMR76IriyVw/ZdgJeMz3iP5l67MnltGb2Lv3oLnkxrkJtZxnpVFuhY3trxUz
         FU07BNbGvA17VwauMc9gOF6Wud7miYB4oY7hdDmcEWFgSzcQkvMeIlGBXnffi8VrSS6O
         nvet1vb0zNiKQEZkTMVmV68GVvLhGApPe5nHwyfw2forjOa1p63gZN98SMv/LxowMg0k
         /sE92Tmf2hnCYBMlV9X5NksbT4bldXJPYE2tjfeE9PWYQyfA9h5O/CWt1Gx9pxxsX3ps
         LwE6mthneoNbqshmF5uXhSq9Ko9LMj1xPSawW/PI+J6HXx9qct22idUjMCinbehhMv46
         tMag==
X-Gm-Message-State: AOJu0Yxqyor/j7/4BBD9orysB6QWlFmiOxmeuRTybcE4WOojanO2HB3R
	gDqoBnoxRQV+BJAAKQv2RDwGE8E6xk7xm81tdyRY3X7VnOR/HvgDBHC7T6UJ5UU8068=
X-Gm-Gg: ASbGncuJMl8qDpArnD86B3v7US5RVBKaWzbBqf9EszvlTFkt1U1PG6IYbxXHV81qrh4
	BGnsHe2m9g4jCtgH3OP0iSvtP9fCXPX/zsBAFWUpvaytuAAFwlAksT5gG1/mgQT7WfX44bFXMif
	tJwdjv+q4gVFXSJDkGjRaJADIzRFPL/4gBHvOKyFXtWY9tITShbxEiOuDpPIgS+KIDDATkmW/z9
	uwwDO4/sEQHrJkKWi/P44EY79RPvOWOwcvuN1x3IbkKk4lN5svemBpVmS1BC6u5wogRNey468bx
	3zJNIf8EETH/jMkVxnD0Sbsiy/VczT8dX7NvkS1Swu6+HdZHVmjtqQdLo2EFRpzDBqFJ6iiWb2t
	LQA==
X-Google-Smtp-Source: AGHT+IFeME8z8xyt10nAyrnqInmUfp/yZ6rndW5t7mimqK/e6IHzphs36nsFBZGRV/KKh3o/5tTo2w==
X-Received: by 2002:a05:600c:8b45:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45381a9f5a2mr69583125e9.4.1750949298311;
        Thu, 26 Jun 2025 07:48:18 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3b3213sm21843175e9.18.2025.06.26.07.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:48:17 +0100
Message-Id: <DAWJQ2NIKY28.1XOG35E4A682G@linaro.org>
Cc: <linux-wireless@vger.kernel.org>, <jeff.johnson@oss.qualcomm.com>,
 <linux-arm-msm@vger.kernel.org>
Subject: [question, bug] regularly disconnecting wifi on RB1 and RB2 boards,
 ath10
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <jjohnson@kernel.org>, <ath10k@lists.infradead.org>
X-Mailer: aerc 0.20.0

Hi all,

After a long time of testing it seems the problem narrows down to qrb2210 r=
b1
and qrb4210 rb2 boards.

After booting, the board connects to the wifi network and after around ~5-1=
0
minutes it loses the connection (nothing in dmesg). A simple ping of anothe=
r
machine on the local network doesn't work. After, I guess, around 5000
seconds the GROUP_KEY_HANDSHAKE_TIMEOUT message is printked:

[ 5064.093748] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 16=3D=
GROUP_KEY_HANDSHAKE_TIMEOUT)
[ 5067.083790] wlan0: authenticate with 8c:58:72:d4:d1:8d (local address=3D=
82:95:77:b1:05:a5)
[ 5067.091971] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
[ 5067.100192] wlan0: authenticated
[ 5067.104734] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
[ 5067.113230] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11 sta=
tus=3D0 aid=3D2)
[ 5067.193624] wlan0: associated

and after that wireless connection works for ~5-10 minutes and then the cyc=
le
repeats. The longer log with more info and some info with firmware versions=
,
ids, etc is at the end of this email [1]. Simple wlan0 down and wlan0 up fi=
xes
things for a few minutes.

iw wlan0 link reports the following when wireless network is working:

root@rb1:~# iw wlan0 link
Connected to 8c:58:72:d4:d1:8d (on wlan0)
        SSID: void
        freq: 5300
        RX: 45802 bytes (424 packets)
        TX: 71260 bytes (125 packets)
        signal: -66 dBm
        rx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1

bss flags:      short-slot-time
dtim period:    1
beacon int:     100

and this when wireless connection doesn't work:

Connected to 8c:58:72:d4:d1:8d (on wlan0)
        SSID: void
        freq: 5300
        RX: 850615 bytes (9623 packets)
        TX: 20372 bytes (247 packets)
        signal: -61 dBm
        rx bitrate: 6.0 MBit/s

    bss flags:      short-slot-time
    dtim period:    1
    beacon int:     100

This was tested with three different routers and different wifi networks.
Other devices here do not exhibit this behaviour.

Any hints on how to debug this? Any debug switches I can toggle to debug th=
is?
I am happy to provide more info or test changes/patches if any.

Thanks in advance.
Best regards,
Alexey

[1]:

[    7.758934] ath10k_snoc c800000.wifi: qmi chip_id 0x120 chip_family 0x40=
07 board_id 0xff soc_id 0x40670000
[    7.769740] ath10k_snoc c800000.wifi: qmi fw_version 0x337703a3 fw_build=
_timestamp 2023-10-14 01:26 fw_build_id QC_IMAGE_VERSION_STRING=3DWLAN.HL.3=
.3.7.c2-00931-QCAHLSWMTPLZ-1
[   11.086123] ath10k_snoc c800000.wifi: wcn3990 hw1.0 target 0x00000008 ch=
ip_id 0x00000000 sub 0000:0000
[   11.095622] ath10k_snoc c800000.wifi: kconfig debug 0 debugfs 0 tracing =
0 dfs 0 testmode 0
[   11.103998] ath10k_snoc c800000.wifi: firmware ver  api 5 features wowla=
n,mgmt-tx-by-reference,non-bmi,single-chan-info-per-channel crc32 a79c5b24
[   11.144810] ath10k_snoc c800000.wifi: htt-ver 3.128 wmi-op 4 htt-op 3 ca=
l file max-sta 32 raw 0 hwcrypto 1
[   11.230894] ath10k_snoc c800000.wifi: invalid MAC address; choosing rand=
om
[   11.238128] ath: EEPROM regdomain: 0x0
[   11.242060] ath: EEPROM indicates default country code should be used
[   11.248582] ath: doing EEPROM country->regdmn map search
[   11.253950] ath: country maps to regdmn code: 0x3a
[   11.258805] ath: Country alpha2 being used: US
[   11.263466] ath: Regpair used: 0x3a
[   15.355756] wlan0: authenticate with 8c:58:72:d4:d1:8d (local address=3D=
82:95:77:b1:05:a5)
[   15.363942] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
[   15.372142] wlan0: authenticated
[   15.377928] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
[   15.386338] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11 sta=
tus=3D0 aid=3D2)
[   15.466514] wlan0: associated
[   23.167251] systemd-journald[195]: Oldest entry in /var/log/journal/ec3e=
0078e5e0499bac67949f3edf3fcf/system.journal is older than the configured fi=
le retention duration (1month), suggesting rotation.
[   23.185186] systemd-journald[195]: /var/log/journal/ec3e0078e5e0499bac67=
949f3edf3fcf/system.journal: Journal header limits reached or header out-of=
-date, rotating.
[   31.750177] l5: disabling
[   31.753382] l11: disabling
[   31.756385] l16: disabling
[ 5064.093748] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 16=3D=
GROUP_KEY_HANDSHAKE_TIMEOUT)
[ 5067.083790] wlan0: authenticate with 8c:58:72:d4:d1:8d (local address=3D=
82:95:77:b1:05:a5)
[ 5067.091971] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
[ 5067.100192] wlan0: authenticated
[ 5067.104734] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
[ 5067.113230] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11 sta=
tus=3D0 aid=3D2)
[ 5067.193624] wlan0: associated
[10437.346541] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 16=3D=
GROUP_KEY_HANDSHAKE_TIMEOUT)
[10440.340111] wlan0: authenticate with 8c:58:72:d4:d1:8d (local address=3D=
82:95:77:b1:05:a5)
[10440.348408] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
[10440.356698] wlan0: authenticated
[10440.361077] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
[10440.369516] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11 sta=
tus=3D0 aid=3D2)
[10440.446661] wlan0: associated

