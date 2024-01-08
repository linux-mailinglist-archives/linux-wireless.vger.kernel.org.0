Return-Path: <linux-wireless+bounces-1587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A206C826F7C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 14:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74BF1C220FE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA264174B;
	Mon,  8 Jan 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIV1N0ql"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B41745
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dac225bf42so462108b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jan 2024 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704719836; x=1705324636; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC7iHZohfe8Z7hK315FAJWhAQs5UW7J26YTfmYEyJTc=;
        b=WIV1N0qlHzEZWkKPICfA58uecfNVbw9ZL0L8/mlrowOwGiICgBiU9rQ++DnBVcfZSn
         WNdYpstX/1GulDl+ep5rDW/WoBW1f0QoMtMPgt4G7PKY2z4tfWHAJoudaMR0v4oYmZ++
         DJHFnivoKLehoSNoIp5pN3ZaRCVPj3xwxlc2rV30Yn/zSPYfEB/SU2hhDuXycVb2E1PU
         aV2L+T/hHjyuBWb75PKlUWRr63D7SystAkTmrxZBaqqjtBGDZmUVa33qzyUXUBFcKS9T
         MBHoSMpqvk3sioN4+X3x+bH6MVRjz1TRDs8Uvb54GFWRznCBtz6nKpg1hL7tY6lyoCfn
         eR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719836; x=1705324636;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tC7iHZohfe8Z7hK315FAJWhAQs5UW7J26YTfmYEyJTc=;
        b=iFVTatbCSinEfRlwBtdnUE40erm/ba11zgQcctH035chQJQXRfa/MjvdHu6Q/VqrEf
         ebQtz8C5ROKrl91HYMd0nZPKxNZbulHBaBCUrxPpV7SJR5zvq1yoTsCI2Hxn4yrI0Xep
         O9Fe2MtPFHw4B3xMxoCNaAspv+1UrNBtMEBNuz3L9aeQp2yRYbTwizK987HfHZ84lMqA
         jrUEgGWGDOGaJleY2fbzCCwXhk72XjHNWpKNNBMwwAN0FWwp+3aZyqjlWZRPMgvXKYP2
         bjQEyywK67rkqz9j/fXhwxCkV/Po6N0vDuixcGTQJOEqT7PwwOUiiF9RIuKBuCWNtgUv
         aDcQ==
X-Gm-Message-State: AOJu0Ywdfi6D3mOKqw7msEv6dfwmcttoglX4iBbIEDE6C++yq7EPYmDo
	BCWjsC3adDwofJ4t1q//79IjQjfzwW0=
X-Google-Smtp-Source: AGHT+IG8tSnoWwwAjErdYxujkYL5PGgs52JLu1Bm0JPkgGLtr80qU848cu6T2bQOIAGiNtt1nCmIaQ==
X-Received: by 2002:aa7:87ca:0:b0:6d9:ecbb:effc with SMTP id i10-20020aa787ca000000b006d9ecbbeffcmr1274919pfo.33.1704719835847;
        Mon, 08 Jan 2024 05:17:15 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id p5-20020aa79e85000000b006d9ef76732esm5954022pfq.213.2024.01.08.05.17.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 05:17:15 -0800 (PST)
Message-ID: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
Date: Mon, 8 Jan 2024 05:17:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: ath11k and vfio-pci support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

For a while now I've been using vfio-pci to pass through wireless 
hardware to a Qemu VM. This makes testing kernel changes quick and easy 
compared to swapping the host kernel for reach iterative change. So far 
I've had very few issues doing this, maybe I've just been lucky... I 
tried doing this with an ath11k (WCN6855) card and ran into issues with 
the driver starting up. I'm wondering if its a configuration issue or 
just a lack of support by ath11k? The card works just fine when I use it 
on my host machine. Based on the logs it may not even be related to 
ath11k as wmi-bmof seems to fail first, but I'm not familiar with 
anything at the PCI level so I've got no idea whats going on.

My host machine is running 5.19

Booting into a 6.2 kernel with Qemu

Below is a partial kernel log of relevant messages:

[    0.318120] ath11k_pci 0000:00:06.0: BAR 0: assigned [mem 
0x100000000-0x1001fffff 64bit]
[    0.319006] ath11k_pci 0000:00:06.0: MSI vectors: 1
[    0.319075] ath11k_pci 0000:00:06.0: wcn6855 hw2.1
[    0.475326] mhi mhi0: Requested to power ON
[    0.475333] mhi mhi0: Power on setup success
[    1.440375] Driver 'wmi-bmof' was unable to register with bus_type 
'wmi' because the bus was not initialized.
[    1.459667] ath11k_pci 0000:00:06.0: chip_id 0x12 chip_family 0xb 
board_id 0xff soc_id 0x400c1211
[    1.459674] ath11k_pci 0000:00:06.0: fw_version 0x1109996e 
fw_build_timestamp 2023-12-19 11:11 fw_build_id 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36
[    1.528705] ath11k_pci 0000:00:06.0: leaving PCI ASPM disabled to 
avoid MHI M2 problems
[    2.537835] ath11k_pci 0000:00:06.0: failed to receive control 
response completion, polling..
[    3.562151] ath11k_pci 0000:00:06.0: Service connect timeout
[    3.563511] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
[    3.565375] ath11k_pci 0000:00:06.0: failed to start core: -110
[    3.776067] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
[   13.802149] ath11k_pci 0000:00:06.0: failed to wait wlan mode request 
(mode 4): -110
[   13.802163] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode 
off: -110

