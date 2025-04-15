Return-Path: <linux-wireless+bounces-21542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7031A899DA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2BC16ACFA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24328DEE6;
	Tue, 15 Apr 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8jAvsMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5728BAAF;
	Tue, 15 Apr 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712598; cv=none; b=OMaU9l6HJeW6R5IETc7Pk7E/l0Pp2DsdUqTcVkkVQYyLClpE2RnASC57rYyZraBe+VT2AmT2OYMNx4CM/suWXYn4fAV8wyNMDheBITLzwRn/2Pe9UjDE4lt1flxhyf5Jcnxeex9DH+5qko0EBHj7SL53q5Pg2dmGXkwRZQD1Cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712598; c=relaxed/simple;
	bh=NPa4awM7I7hGZLAl4aKwu/YdFYX8ogKw+lDBM2iQt+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S4ROI+h2AfaOQGTh8RvF/fyyCCu2JoBv3fmcrj2AtYV21UI6h7YKHbv7lOwvoZqiedpuUbeVUCK+/vTbC5HhcS4QjIE5iR/7bA6k0xDcFnW8nUDHzSIsfiFxsSNDY6rrYOSQ6AXb/GpzI1oHktYpBLE/Q88jjnJF6uPzxt7j6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8jAvsMq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso6503768e87.0;
        Tue, 15 Apr 2025 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744712594; x=1745317394; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uao6/Ti1i3X1THeMp6nNBUEKYqad2oiW1pAWYGTbXGU=;
        b=i8jAvsMqdiCwBSifTqnVCauNaZD3g1RqjtPrxluOLaly6bEqeB+D5UIic5rPF4eofR
         K29aCSKqPiE66hU9fEt+nM8f/iBjtHI+XN/TC8W1ntKvFhBRjfsjd6gwyXwZA0M0Qhuf
         diymGWXlvNOlrh5xpNuAfufcN88HThXWqPMxXm1T78Z2fMQEDPUHRTxJOAHWEMneSqjR
         h3xo9bUQs8CWxQQQYE3v6sgeNoHNGOyA+t9csaV7WFp+lX7ACOo64MJloDDPMvh1Ej09
         w8/1WDXcEW6IlLKB3TV3h4K3KSk/ERP0CanFGVfvtOpVpCdKX2LGbmhyY0yUUjbZwfUd
         vBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744712594; x=1745317394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uao6/Ti1i3X1THeMp6nNBUEKYqad2oiW1pAWYGTbXGU=;
        b=M0pqfLC82/C2e1nkvlpRDIoImr5gvERA9X6EcOD9CgTPcwKMkBQA+TqI7eLcBtMPOn
         /hsl4AdNb9zWndWZPE2ORjcMWUWRmz8CEoglp/qVDOeqPl9MKNr8i33M/r8uCWCghouW
         GMmNXKdg702bq8XqIugSegFPLaL2LhLi3CfTTOcQnebAk91/Tu5okBeOdOHiebDBxmLL
         0vNWc9CVhXZuHvVSAM/M5cYAnRl54LmV9pl3pxlSyr8RArpl9PeUN5Jb/Hx5Qt9eIuN3
         5N9vGzHvWDpoK9EQRbUQI6/R/jwMAGF1HYzf1lBLZN0MRkWVavyH485hPRJdgjLmi+hO
         FRZw==
X-Forwarded-Encrypted: i=1; AJvYcCUQoeqMBHn996vGkGxaBXIpoQ64e73QQelT8hXYryj/aOvXB4l+l1zjzP5/LwEitIFjmTFo7zUzZhnFmkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4wOvIMX3oGVmoRrQSU7M1l7UeWFC4WqyKdv+cLrWIETG4eWg
	yaNWmgFxWTeQcpaSZdipSodSncnjw3itTWG1OYwobZk77Wevl7LAox4uJA==
X-Gm-Gg: ASbGncs2M8YvfAwVU5wdAX9l3/LvWPTAA4wfpWq5CEQ8BbHDiZTEHtMKDdaDi94oFft
	WrK44XuPA5GTmnOQToLfkzOKg1ncdXeJvqhuqBwCIPQEhwlHgyD32ZFgykSCHVnCvgpTM/RSLlx
	HxwKYu/4iT31JRFa2N3e7bqv9D6GiH+LyyJKH1vFUudBrAPHLX2ipEdRWD+RTwxZ1Oa0nb7PHjp
	6rkDtBTXwRPaWds0Tr3Rr1sPKiOmAFEBWQvvF0+2FrEtqYROe34ugC3U9HiLo8XXoL9TNG+Ib9z
	2UmO10X3eTKjjmfHzbrVuiJSJtkGbyPna9THTXr3cgHsaaXgVHotaszS34az8dJxKpDMoev9/1s
	5A+C+
X-Google-Smtp-Source: AGHT+IGvbnNAM38KMqnm7kN7j3B3Qq+Ey3J+AmZunx72XZzz3frEHYkjPQBTWAQ+LSso33hJb1OiKQ==
X-Received: by 2002:a05:6512:158f:b0:545:22ec:8b6c with SMTP id 2adb3069b0e04-54d452cc1d3mr4482045e87.35.1744712593922;
        Tue, 15 Apr 2025 03:23:13 -0700 (PDT)
Received: from localhost (broadband-5-228-116-177.ip.moscow.rt.ru. [5.228.116.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cc096sm21003591fa.29.2025.04.15.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:23:13 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:23:12 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Po-Hao Huang <phhuang@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter feature
 enabled
Message-ID: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

there are IO_PAGE_FAULT errors occassionally thrown into the log with
rtw89_8852be-compatible device in use:

[    7.135509] rtw89_8852be 0000:03:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[    7.135610] rtw89_8852be 0000:03:00.0: enabling device (0000 -> 0003)
[    7.137074] rtw89_8852be 0000:03:00.0: Firmware version 0.29.29.8 (39dbf50f), cmd version 0, type 5
[    7.137079] rtw89_8852be 0000:03:00.0: Firmware version 0.29.29.8 (39dbf50f), cmd version 0, type 3
[    7.423852] rtw89_8852be 0000:03:00.0: chip rfe_type is 1
[    7.452843] rtw89_8852be 0000:03:00.0: rfkill hardware state changed to enable
[    7.478466] rtw89_8852be 0000:03:00.0 wlo1: renamed from wlan0
...
[ 1361.803384] rtw89_8852be 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x0 flags=0x0000]
[ 1434.918012] rtw89_8852be 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x0 flags=0x0000]
[ 1551.553344] rtw89_8852be 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x0 flags=0x0000]
[ 1649.346804] rtw89_8852be 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x0 flags=0x0000]


address and flags are always all zeros. It is reproducible on the current
mainline v6.15-rc2 kernel and v0.29.29.8 fw version.


It is most probably related to the beacon filter feature enabled in the
firmware. Bisection in the kernel leads to

commit d56c261e5214e51e2c6d22149f63555039b5601e (HEAD)
Author: Po-Hao Huang <phhuang@realtek.com>
Date:   Thu Nov 28 13:54:29 2024 +0800

    wifi: rtw89: 8852b: add beacon filter and CQM support


and in linux-firmware to

commit 20cace1adf6a33cac73595ea3202eb784dea98a6
Author: Po-Hao Huang <phhuang@realtek.com>
Date:   Thu Sep 19 17:02:28 2024 +0800

    rtw89: 8852b: update fw to v0.29.29.7
    
    Enable beacon filter feature.


Hardware info:

$ lspci -nn -s 03:00.0
03:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller [10ec:b852]

$ lspci -vvvk
03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
        DeviceName: Realtek
        Subsystem: Lenovo Device 4853
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort+ <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 93
        IOMMU group: 15
        Region 0: I/O ports at 4000 [size=256]
        Region 2: Memory at 98900000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: <access denied>
        Kernel driver in use: rtw89_8852be
        Kernel modules: rtw89_8852be

$ lspci -x
03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
00: ec 10 52 b8 07 04 10 10 00 00 80 02 10 00 00 00
10: 01 40 00 00 00 00 00 00 04 00 90 98 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 53 48
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00


--
Thanks,
Fedor

