Return-Path: <linux-wireless+bounces-15298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03599C8B6D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D8C1F255E8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CF1FAEE4;
	Thu, 14 Nov 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJa/4KQb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EA1FAC4A
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589545; cv=none; b=HA6vD/z9COUXOV30/djmYSh3yxRKn+tu0kjmTm5/CoBLaO6TtSmrl9585ANmk96wWzRGZbl8dHHAGEiWZRQxaTyCCdG2vYXPiPt/iuiBJJanfsgP+AkYldLEpaMZbC2VML1C0kqbvKEj1n6g5VigxasvX5omKQioHcvZjjXfCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589545; c=relaxed/simple;
	bh=03pVQOsqjc+ihn8R9Go+2ucelPDmfRs09TW2p/sUvi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar+wPP+QN+TT9uqYyuysXmNRi1QKk6JRjYxDoFPRPLyYDBRrolF7jA+aVTy9v7oO4oQhDfpk16ZnjY+Qp9FdsopFGvsZWDWV7EMFczvbF6chRuXnap5M7G5ILYcGQ0RAztBTAo4i33X1bWs91WJq/29OcRH+SNR3IpalwLB+vEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJa/4KQb; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d3f3925f52so2387626d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 05:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731589543; x=1732194343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NN8OwI9ZXG1Q3BR0z5YzegWZISJzOoW0OKggYiGEENY=;
        b=UJa/4KQbZbY+WGY71liSyp70Q9VbUe13ZNdTohWDfHUO9Dfohk/fZfDMdmoZjDjNhj
         OK/tPRchtTlENtC3ruDJHyK2i7W5WwsegCB+YD2mubYGmhoKIhUSRinnTr+lPDXLHANd
         GqATfBdHXZfUK2PziyTt1iyBFE57SdIrt30umukOmqJcbdoRNmq1yE2HnhDprNOhFMbB
         tCUe6/1OGNkQdM65D/8t9/upK27U9MOjy5US4Kt1kWSVVJrJeObPycBADOQ4rirGob0K
         x2AGfZH359WBU6ympFrp5uNV/4USLoZ19EU/OisItCBDMQPpc1TvsOfFLA/2dxMEmq9y
         wm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589543; x=1732194343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN8OwI9ZXG1Q3BR0z5YzegWZISJzOoW0OKggYiGEENY=;
        b=N/OstNM91HfjMP7ei5OYumgkiG05YoCQFF1o0gXr7XKEhPZR8rZ3Lg0PJlnQ2lIXDw
         cuOY9AgsUJZNMqKZR6v0EBCvdYbh3Qo4ixQqDQWNpawIj1GLLJgGO8cnlzou8xGuVBJJ
         39aynbi10r4/WdNKSy6/xqq5oahk7b8jJZEn3A2440ft+kCNY7R3+WL5T4F+FZ9D6Lzr
         mVNTN/Vn6YzKhMxK/LGS/tDWbzdAA0/usXoN/KUTnv7VPvF17Aq5kaz8asNfmSgbCGcO
         Y2WXFY2vOmdfb11PJjEgbNgRpcTUs1D8cd5n0DJSP6VYk4cBa3/d2Gq8nQ6K0WxHEVLc
         w9BA==
X-Forwarded-Encrypted: i=1; AJvYcCXAUpPsdrArrTrgrjlKqV4LcQTH45yGshJz1tf+n2c6A0kYRxrmEVQK5TPB3FNr/r6QTln3f/6Q+6VbL7quKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxilhAcakKGpBe89HvW6x+sHizuanXIk+sRwKtmRvQobasgvsKS
	BrQ6+0AVBdlLPl4lbCBmo48o2vHpzKS7shW5zQxXz0Z58GB3DmyA
X-Google-Smtp-Source: AGHT+IFiUH5MnyfeW9nYEwRUTtURU1g2uQ8y6dF5acQF9VeFvP/r5AsAqGv70gNbq2g/eHMypq0TSA==
X-Received: by 2002:a05:6214:5245:b0:6d1:9f1b:587c with SMTP id 6a1803df08f44-6d3dd080505mr76133276d6.46.1731589542684;
        Thu, 14 Nov 2024 05:05:42 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee771d69sm5206336d6.15.2024.11.14.05.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:05:42 -0800 (PST)
Message-ID: <83d2b40c-3c24-47b3-8e76-7f5778f843f5@gmail.com>
Date: Thu, 14 Nov 2024 05:05:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw89_8852ce + iwd stuck in (dis-)connect/-auth loop
To: Philipp Matthias Hahn <pmhahn@pmhahn.de>, iwd@lists.linux.dev,
 linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
References: <ZzW9IIrc-HYQuD6-@birdy.pmhahn.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ZzW9IIrc-HYQuD6-@birdy.pmhahn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philipp,

On 11/14/24 1:04 AM, Philipp Matthias Hahn wrote:
> Hello,
>
> I finally switched from `wpa_supplicant` to `iwd` after having regular
> issues with connectivity issues, so the following problem is probably
> not related to `iwd` at all.
>
> APs:
> - FRITZ!Box 7490 one
>    - 34:31:C4:27:99:ED (2.4 GHz)
>    - 34:31:C4:27:99:EE (5 Ghz)
> - FRITZ!Box 7490 two
>    - E8:DF:70:4A:46:AB (2.4 GHz)
>    - E8:DF:70:4A:46:AC (5 GHz)
> - FRITZ!Powerline 1260E
>    - F0:B0:14:88:AC:43 (2.4 GHz)
>    - F0:B0:14:88:AC:47 (5 GHz)
> - FRITZ!Powerline 540E
>    - 5C:49:79:E1:C5:94 (2.4 GHz)
>
> Debian-12-Buster
> iwd original: 2.3, now: 3.1 self-compiled
> Linux 6.10.11
> 04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 15)
>          Subsystem: Hewlett-Packard Company RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller [103c:8b7c]
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 64 bytes
>          Interrupt: pin A routed to IRQ 19
>          IOMMU group: 16
>          Region 0: I/O ports at 3000 [size=256]
>          Region 2: Memory at 80804000 (64-bit, non-prefetchable) [size=4K]
>          Region 4: Memory at 80800000 (64-bit, non-prefetchable) [size=16K]
>          Capabilities: <access denied>
>          Kernel driver in use: r8169
>          Kernel modules: r8169
>
> After a suspend (to RAM) overnight the connection cannot be
> re-established and `iwd` is stuck in a re-connect/-auth loop:
Maybe someone more familiar with this driver specifically can comment, 
but historically on the mailing list I have seen a number of issues 
surrounding suspend/resume with wifi drivers.
>
> Nov 14 09:11:35 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:11:36 phahn iwd[179340]: udev interface=wlan0 ifindex=14
> Nov 14 09:11:36 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: 34:31:c4:27:99:ee, signal: -78, load: 1/255
> Nov 14 09:11:36 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:11:37 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:11:46 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
> Nov 14 09:11:46 phahn iwd[179340]: event: disconnect-info, reason: 4
> Nov 14 09:11:46 phahn iwd[179340]: event: state, old: connected, new: disconnected
> Nov 14 09:11:46 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:11:47 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -62, load: 23/255
> Nov 14 09:11:47 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:11:47 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:11:50 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
> Nov 14 09:11:50 phahn iwd[179340]: event: disconnect-info, reason: 4
> Nov 14 09:11:50 phahn iwd[179340]: event: state, old: connected, new: disconnected
> Nov 14 09:11:50 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:11:51 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -56, load: 34/255
> Nov 14 09:11:51 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:11:51 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:11:56 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
> Nov 14 09:11:56 phahn iwd[179340]: event: disconnect-info, reason: 4
> Nov 14 09:11:56 phahn iwd[179340]: event: state, old: connected, new: disconnected
> Nov 14 09:11:56 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:11:57 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: 5c:49:79:e1:c5:94, signal: -61, load: 27/255
> Nov 14 09:11:57 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:11:57 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:12:03 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
> Nov 14 09:12:03 phahn iwd[179340]: event: disconnect-info, reason: 4
> Nov 14 09:12:03 phahn iwd[179340]: event: state, old: connected, new: disconnected
> Nov 14 09:12:03 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:12:04 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -57, load: 33/255
> Nov 14 09:12:04 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:12:04 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:12:07 phahn iwd[179340]: Received Deauthentication event, reason: 4, from_ap: false
> Nov 14 09:12:07 phahn iwd[179340]: event: disconnect-info, reason: 4
> Nov 14 09:12:07 phahn iwd[179340]: event: state, old: connected, new: disconnected
> Nov 14 09:12:07 phahn iwd[179340]: event: state, old: disconnected, new: autoconnect_quick
> Nov 14 09:12:08 phahn iwd[179340]: event: connect-info, ssid: WBP4a Hahn +491702827535, bss: f0:b0:14:88:ac:43, signal: -55, load: 40/255
> Nov 14 09:12:08 phahn iwd[179340]: event: state, old: autoconnect_quick, new: connecting (auto)
> Nov 14 09:12:08 phahn iwd[179340]: event: state, old: connecting (auto), new: connected
> Nov 14 09:12:16 phahn iwd[179340]: event: state, old: connected, new: disconnecting
> Nov 14 09:12:16 phahn iwd[179340]: event: state, old: disconnecting, new: disconnected
>
> Here's the dump of the kernel log:
>
> [87572.028075] wlan0: authenticate with 34:31:c4:27:99:ee (local address=40:1a:58:f6:ca:6f)
> [87572.028079] wlan0: send auth to 34:31:c4:27:99:ee (try 1/3)
> [87572.031085] wlan0: authenticated
> [87572.036527] wlan0: associate with 34:31:c4:27:99:ee (try 1/3)
> [87572.039534] wlan0: RX AssocResp from 34:31:c4:27:99:ee (capab=0x1511 status=0 aid=2)
> [87572.158153] wlan0: associated
> [87572.158264] wlan0: Limiting TX power to 20 (23 - 3) dBm as advertised by 34:31:c4:27:99:ee
> [87581.686018] wlan0: Connection to AP 34:31:c4:27:99:ee lost
> [87582.508317] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
> [87582.508323] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
> [87582.517681] wlan0: authenticated
> [87582.524152] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
> [87582.530272] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
> [87582.646537] wlan0: associated
> [87582.646704] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
> [87585.790526] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
> [87586.681575] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
> [87586.681579] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
> [87586.684607] wlan0: authenticated
> [87586.685919] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
> [87586.691733] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
> [87586.806412] wlan0: associated
> [87586.811404] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
> [87591.935894] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
> [87592.828319] wlan0: authenticate with 5c:49:79:e1:c5:94 (local address=40:1a:58:f6:ca:6f)
> [87592.828324] wlan0: send auth to 5c:49:79:e1:c5:94 (try 1/3)
> [87592.831876] wlan0: authenticated
> [87592.834046] wlan0: associate with 5c:49:79:e1:c5:94 (try 1/3)
> [87592.844654] wlan0: RX AssocResp from 5c:49:79:e1:c5:94 (capab=0x1431 status=0 aid=1)
> [87592.962487] wlan0: associated
> [87592.962615] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by 5c:49:79:e1:c5:94
> [87598.534139] wlan0: Connection to AP 5c:49:79:e1:c5:94 lost
> [87599.413011] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
> [87599.413015] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
> [87599.416010] wlan0: authenticated
> [87599.418127] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
> [87599.428534] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
> [87599.542784] wlan0: associated
> [87599.542912] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
> [87603.006507] wlan0: Connection to AP f0:b0:14:88:ac:43 lost
> [87603.894465] wlan0: authenticate with f0:b0:14:88:ac:43 (local address=40:1a:58:f6:ca:6f)
> [87603.894470] wlan0: send auth to f0:b0:14:88:ac:43 (try 1/3)
> [87603.897501] wlan0: authenticated
> [87603.902232] wlan0: associate with f0:b0:14:88:ac:43 (try 1/3)
> [87603.909625] wlan0: RX AssocResp from f0:b0:14:88:ac:43 (capab=0x1431 status=0 aid=7)
> [87604.022839] wlan0: associated
> [87604.022904] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised by f0:b0:14:88:ac:43
> [87611.261845] wlan0: deauthenticating from f0:b0:14:88:ac:43 by local choice (Reason: 3=DEAUTH_LEAVING)
>
> I have seen that "Limiting TX power to …" before with `wpa_supplicant`,
> which also lead to a disconnect there, which triggered me to try `iwd`
> now.
>
> Last time unloading `rtw89_8852ce` and re-loading it did get it, but
> only after switching Wifi off and on again in NetworkManager.
Seems like a driver issue to me. As you said, I suspect you would see 
the exact same behavior with wpa_supplicant as you see here.
>
> If you need more data, just tell we what you need.
>
> I'm not afraid of compiling my own Linux kernel if that is needed.
> I already switched from the regular Debian-12-Buster-Kernel 6.1.115 to
> Debian's backports kernel 6.11 as the original kernel did not have the
> `rtw89_8852ce` driver; I tried <https://github.com/lwfinger/rtw89> back
> then, but did not get it working properly, which prompted me to switch
> to the bpo kernel, which was easier.
>
> PS: I'm not subscribed to to both `iwd` and `linux-wireless` lists.
>
> Thanks in advance
> Philipp Hahn
>

