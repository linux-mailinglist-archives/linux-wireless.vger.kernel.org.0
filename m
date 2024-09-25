Return-Path: <linux-wireless+bounces-13169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D892985AEB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3428213B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729A18FDB9;
	Wed, 25 Sep 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biwR2LcK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B318FC74
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264776; cv=none; b=XhE4o1zpOmYglCGXEIXvTEzVv5Oe2i5ZX9E5WdL0s67CQ0yDsztS3UDuuphQTEUAJm00bOLM7lawV205YmDG39XdeeLVXTi/x3ugFtCfCOiLb+Mm3r5/gt5j0arIOyO5jqlSSS7mXn4l4gUlzApKl/tILLnlc6Ub1k8kh+Q7nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264776; c=relaxed/simple;
	bh=v9Ae7jmMHQFlMZbF32j43dVF7Z2aG+EUS6iAxFUVHpc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hCnEPRwiVooYqzN0CxJzPUM/LVFwaoQo8tKqxxgUguFIpxVJaopacrvUhvPw+DLafamlnVqOflETbO6gtf6W3nAfRq+0bw7UH/g28t/Ozl9ecTNHA8fnvLBoGVXZ/h3tQGgv2uB0onX/nxYtYwAV1sIW1QYs9lqhmAIy3zZVt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biwR2LcK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so54241825e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727264772; x=1727869572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kSH3gAmDvaE0TWu0Zw1tqUtUV0KUVsDtyl6cBRmYm4=;
        b=biwR2LcKsvTJakT56vf3OL+C26ggHnAotYzYzj8PY+ZKJkxVgKnEjFiFtTHobdApr/
         SRIX5B1BFhr3piMb613B7eWjjQxJ60/RKqgNRNbEiEg2oOhot//bSL75W2psVR9pXdkA
         nRYjcHTJVDPIZ7wj6czQYYMC8y/XFR5mL2UPanIw61J9pUcKvhFBjK+ShtGtTyYyf7+x
         6I51FMHNcYjMTfTir2vF+nByVshyhd3opomoOv15xFtzh7Z7bprOFpTgYiK+xqkgw7dd
         wYAgAj+lCTtOIdIGBA1c8D/AlApHzQ7GcmJXt4f1+shH5m7nDz6+LTkcrS8IYSwrs5tA
         bywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264772; x=1727869572;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9kSH3gAmDvaE0TWu0Zw1tqUtUV0KUVsDtyl6cBRmYm4=;
        b=R7BAbjqVfr2mpF8Gd5MarJZpAizLIywEb2hy2JRgRjIylc9XY25wUoWNbPclWMHWI+
         GHftLaTcS63Sl75QrZ/t+qQfbqLLUPmaQ+C0qlQgpZOgcv3pE2aZ/f3/rShGZbj50LvE
         xIjiTuNzoe+ow43wzPJXUhc2fXqTC6ep/fQLdfoJoPjOuB0raLN6EJFQlnp745ep3/gW
         ug+1DpbkPKhHQeeeKrAWOpDr2vm/PN0Ero8KXlUA3jzNaQZVox9IrB/7kjNChjZjU6sW
         bb6ElJQxxQO1pdiypTeUBWxYdPVgtFX+cTu4U68nTKjHODRjZmHAcwRKvouyjuQw3bIS
         dk0w==
X-Gm-Message-State: AOJu0Yz8DnYraYT0IunJF6qA+sa5PYWTHpFYJshCG+tAp0jKx244g8DO
	IunLS8mk0lz7Zmx6Pc/2Tqpaj1wXubCxW1KdJ5nBoSlMpKeJx2jVLEc6vA==
X-Google-Smtp-Source: AGHT+IE9bV1ugpIU4zBrLev1tRW11fTNLqfQ5ku0FKbvcZiGSSYCzAcLrVD7uGQmqQc0U8p75iHK5Q==
X-Received: by 2002:a05:600c:3b87:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42e961173e8mr13054495e9.18.1727264772084;
        Wed, 25 Sep 2024 04:46:12 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31f3ddsm3731628f8f.103.2024.09.25.04.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:46:11 -0700 (PDT)
Message-ID: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
Date: Wed, 25 Sep 2024 14:46:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtw88: USB devices randomly stop receiving anything
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I have this problem with RTL8811CU, RTL8723DU, RTL8811AU, RTL8812AU.
I assume all USB devices are affected. If I have qBittorrent running,
the wifi stops working after a few hours:

Sep 24 00:48:21 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:21 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:23 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:23 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:25 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:25 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:27 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:27 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:29 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:29 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:31 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:31 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:33 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:33 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:35 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:35 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:37 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:37 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:39 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:39 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:41 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-BEACON-LOSS
Sep 24 00:48:41 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: CTRL-EVENT-DISCONNECTED bssid=... reason=4 locally_generated=1
Sep 24 00:48:42 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Added BSSID ... into ignore list, ignoring for 10 seconds
Sep 24 00:48:42 ideapad2 NetworkManager[433]: <info>  [1727128122.0377] device (wlp3s0f3u2i2): supplicant interface state: completed -> disconnected
Sep 24 00:48:45 ideapad2 NetworkManager[433]: <info>  [1727128125.6030] device (wlp3s0f3u2i2): supplicant interface state: disconnected -> scanning
Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: Removed BSSID ... from ignore list (clear)
Sep 24 00:48:47 ideapad2 wpa_supplicant[1290]: wlp3s0f3u2i2: SME: Trying to authenticate with ... (SSID='...' freq=2472 MHz)
Sep 24 00:48:50 ideapad2 kernel: wlp3s0f3u2i2: authenticate with ... (local address=,,,)
Sep 24 00:48:51 ideapad2 NetworkManager[433]: <info>  [1727128131.2488] device (wlp3s0f3u2i2): supplicant interface state: scanning -> authenticating
Sep 24 00:48:51 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 1/3)
Sep 24 00:48:51 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:52 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 2/3)
Sep 24 00:48:52 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:53 ideapad2 kernel: wlp3s0f3u2i2: send auth to ... (try 3/3)
Sep 24 00:48:53 ideapad2 kernel: rtw_8723du 1-2:1.2: failed to get tx report from firmware
Sep 24 00:48:54 ideapad2 kernel: wlp3s0f3u2i2: authentication with ... timed out

After this all scans return nothing. The chip is still alive,
though. The LED blinks during the scans (it's hardware-controlled)
and another device in monitor mode can see the probe requests.

I confirmed that even C2H stop coming. I used aireplay-ng to send
some authentication or association frames (can't remember) which
require TX ACK report. I saw "failed to get tx report from firmware"
and no C2H.

While qBittorrent is needed to trigger this bug, simply downloading
a random Linux iso did not do the job. "Other" torrents did. It's
unclear why. Maybe it's uploading that triggers the bug.

I left iperf3 running all day and nothing happened. Only qBittorrent
can break it.

RTL8822CE doesn't have this problem. I can use qBittorrent with it
just fine.

I mounted debugfs and dumped the MAC registers during a scan using
this command:

for i in {00..20}; do sleep 0.5; cat /sys/kernel/debug/ieee80211/phy2/rtw88/mac_{0..7} > dead-$i.txt; done

I thought maybe some RX URBs failed silently and rtw88 stopped
sending them to the device (== stopped requesting data from it),
but that's not the case. [1]

I have the device in this state right now. Is there anything else
I should look at?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/wireless/realtek/rtw88/usb.c?h=v6.10.11&id=25eaef533bf3ccc6fee5067aac16f41f280e343e#n641

