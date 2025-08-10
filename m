Return-Path: <linux-wireless+bounces-26239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B49B1FCA3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 00:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69DC3B6B5B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1AC2C3268;
	Sun, 10 Aug 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F26lLuFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441112C3261
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754863954; cv=none; b=gS6eTxyFFX4/2Paeo5KfT0e1tbcSMjYHWaoBIIQ9yY1+FRtCcWfBOj5n+qe3gJJRy3679bwDtfjdRk7A8YBgYmTk/Ni6Gsiy8hoPUe1OJXMqa7oBkH2Q2znGCIy5SDzsm+vhVGnigsVPbFQ2aJw5bUiq6mHBaNRe06qvWSkmoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754863954; c=relaxed/simple;
	bh=o28l5PMWA788ICHV/wlCvqfXgrXCXQSpxNkVDhKZsp4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=CAa/IQvZc+P4X49fSPoWQVKL2hi+aMQGOMFY4EXZveIZtF1AEvqfm8D4Rpk0NHC8cxtV0qd9FJBHHvrdr2KCuD+dU6z06R7rWz2omZ5E9jrTIIvublv0kaqNU+GwsfskiFlCGPU1xbonYmcpF0t3Xo939M0wQ3bmN1aNN0xlXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F26lLuFU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso13464315e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754863951; x=1755468751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDqeurjOnoEIiR7QU7iOvFvcHziveqTFO86uqG6yBU=;
        b=F26lLuFUNkFrN8+bu2nXK/yVGdk+hl2Zw+IE1wI2pgMpv3rkjNy1rF/mW0agVfyjh4
         RONLlzAHP+LoYALih8awJQEmoRO4v9bi+qPl6nhqzsdU0hUEZh5USippcbpOZODnbWLs
         XeQ1DaNhAo2y9Iw72Ao0UZ3I9/QC8fpaqwKjCK30MsqGXh0LCEvstfN0/82NY1bFhroC
         fKc1sdy8cbHztxFEGOxnvGzN3/As92C96cAv+nQVD03+CctJmstr4F0iVpdiHKu7lpFM
         xOng2xZv+4xqXC/NDwJErKY2JDPkAWWdN1b4At/pquC+mjl+2Let8w7JUcYI/V1lsoAm
         Ot3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754863951; x=1755468751;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWDqeurjOnoEIiR7QU7iOvFvcHziveqTFO86uqG6yBU=;
        b=uUZ2REDNKkJjnAMiIvUfaDdL1lrPYN0NmwFNhnX5RHNm0hcSiw0ZCMRw5F9kWu4WMq
         JUnMQRCOvfTyQD4qG6SjmhqFQ5k/xMXgebM6vDIRdDICzap9FeT2gNIuTCp4rvNlt5wj
         ZwIKdShrmGr4ob3LzTWqhz7LgTjLv+vg4+bXsAMC5CCAXXsVKKNFyt8iVCsjEIataNxm
         HZXkGUlem3sOoCMvKW1+OpVgEjcwDQ48ZIZNis9AYRfHd0qrua7Nv/PYatoN+h96qZFY
         1tj9JAzNZnDSucRiu2DD3cUEXLoQcrHtUO21y12b/Ch3MzUt2ua5bPoKKOy3H05eyh3t
         dcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlFT3gRCS9SRb/qJzh6Ji3StVYLnoXMPUtWJ2+ZKcCnZd2q23U2L+iFsPvNBfw93edjwI/EVlJ/tDo6J3aWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydrXg/1wc/jdmxsuRoQlx/ymdnPtDvuYIIaiBTBsDUjyMkAXQ/
	Rzto8vUsa+behN32QumWZaHItbF9uB+NzDjy1XgqGz/Zrd+I8vh7+c9f
X-Gm-Gg: ASbGncs0hwsmhGkL6L8YlgpAorvx4wYugt1cZgcj2NCUKX8BCEHxghRQGaIWSFaiYUR
	J0Iuj5gIN1zNAvmrRDt52oA3WZ+e9awh8uTgphquD5adWmdpxMAS//gG/BP3XufUzrq9lYGNO91
	YNCcl5S+apb+gMfjyVDp+a0jR1om2Iqup3Jbxlrs5YP2NeM1j+Bdfm2TRLBhrN0lKbYpw/Vf1Yg
	ws0zxl20q9uavWOU2hL2CiR+TslSZyxQy/43H3gQuM0xM0uQvfV+gqrOQfv3guQP427G8F62aWB
	vTNboQ3wyGYlK7e7f+9Z/wLAXmBCcbypp8xtUukktlOuCNarhDkGhao7ijT0SQrS81oo2rJGRUf
	En82T0g7aKxhFTyyYLc95WsJXj3Caog==
X-Google-Smtp-Source: AGHT+IH/PxptJG+JOiMGledePF8BdQB1tm5RRBPuAcd45Yz+KbUBlLWrhO7X31YCGGeLWAq9fN3FJw==
X-Received: by 2002:a05:6000:4308:b0:3b7:915c:5fa3 with SMTP id ffacd0b85a97d-3b900fe7e69mr10225832f8f.24.1754863951443;
        Sun, 10 Aug 2025 15:12:31 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0bfc79fsm27820976f8f.56.2025.08.10.15.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 15:12:31 -0700 (PDT)
Message-ID: <015e5657-d21e-4214-9854-975c32b1990f@gmail.com>
Date: Mon, 11 Aug 2025 01:12:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: RTL8188S WLAN Adapter failure
To: Helge Deller <deller@gmx.de>, Jes.Sorensen@gmail.com,
 Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
Content-Language: en-US
In-Reply-To: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/08/2025 23:36, Helge Deller wrote:
> The USB dongle which came with my DreamBox DM7020HD years ago seems to fail now.
> Any idea or suggestion what I should try?
> 
> [427792.562049] usb 3-7: new high-speed USB device number 56 using xhci_hcd
> [427792.689358] usb 3-7: New USB device found, idVendor=07b8, idProduct=8188, bcdDevice= 2.00
> [427792.689376] usb 3-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [427792.689381] usb 3-7: Product: RTL8188S WLAN Adapter
> [427792.689385] usb 3-7: Manufacturer: Manufacturer Realtek
> [427792.689388] usb 3-7: SerialNumber: 00e04c000001
> [427792.695145] usb 3-7: This Realtek USB WiFi dongle (0x07b8:0x8188) is untested!
> [427792.695151] usb 3-7: Please report results to Jes.Sorensen@gmail.com
> [427792.934142] usb 3-7: Dumping efuse for RTL8188CU (0x200 bytes):
> [427792.934151] 00000000: 29 81 00 00 a9 16 00 00 b8 07 88 81 90 85 62 9c  ).............b.
> [427792.934155] 00000010: 06 00 ec f0 0e 16 44 3f 17 03 4d 61 6e 75 66 61  ......D?..Manufa
> [427792.934157] 00000020: 63 74 75 72 65 72 20 52 65 61 6c 74 65 6b 20 18  cturer Realtek .
> [427792.934159] 00000030: 03 52 54 4c 38 31 38 38 53 20 57 4c 41 4e 20 41  .RTL8188S WLAN A
> [427792.934160] 00000040: 64 61 70 74 65 72 20 00 00 00 00 00 00 00 00 00  dapter .........
> [427792.934162] 00000050: 06 02 00 00 00 24 24 24 00 00 00 26 26 26 00 00  .....$$$...&&&..
> [427792.934163] 00000060: 00 00 00 00 00 00 00 00 12 00 00 09 0d 00 00 00  ................
> [427792.934164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [427792.934166] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934167] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934168] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934170] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934171] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934172] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934174] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934175] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934176] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934178] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934179] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934180] 00000130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934182] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934183] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934184] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934186] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934187] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934188] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934190] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934191] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934192] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934193] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934195] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934196] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> [427792.934198] usb 3-7: RTL8188CU rev A (TSMC) romver 0, 1T1R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
> [427792.934203] usb 3-7: RTL8188CU MAC: 44:3f:17:03:4d:61
> [427792.934206] usb 3-7: rtl8xxxu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
> [427792.938371] usb 3-7: Firmware revision 88.2 (signature 0x88c1)
> [427792.939417] rtl8192cu_power_on: Enabling LDOV12D (24)
> [427793.115145] rtl8192cu_power_on: FSMCO_MAC_ENABLE poll failed
> [427793.115156] usb 3-7: rtl8xxxu_init_device: Failed power on
> [427793.116003] rtl8xxxu 3-7:1.0: probe with driver rtl8xxxu failed with error -16
> 

Your dongle has the RTL8188SU chip inside. rtl8xxxu and rtl8192cu
are not the right drivers.

The right driver is r8712u, but it was removed in kernel 6.13.
You can use kernel 6.12. Or you can compile r8712u for your current
kernel. Maybe r8712u could even be accepted back in the kernel if
you convert it to use mac80211/cfg80211.

https://lore.kernel.org/linux-staging/20241020144933.10956-1-philipp.g.hortmann@gmail.com/

