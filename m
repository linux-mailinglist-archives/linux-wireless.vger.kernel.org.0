Return-Path: <linux-wireless+bounces-22004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9DA9B025
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504937AB3E6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3512CDA5;
	Thu, 24 Apr 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="YhLGNQTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887C15E5DC
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503671; cv=none; b=SpMsNfcymi3SF/D8lrp0464KVgLjAZquradstm3D69RjzVJtMqXtozCnLC4v6VquEllhSTxGkivPcE/oXuGKy1F17w+Jr4RC2f+9bRB/dFhNFoRYA+t4H0UY1jPbEY10MNsTFPFy1IebH6Bt2qqoGcJoR1cegafzmLOj4t/HlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503671; c=relaxed/simple;
	bh=Zsx8+PoFy4NLxrjMCAlC8nNCC64ib3oExbTa5bDB7WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkuE3Zeq+m/YPZGVDQxZuPuC+J0N6D2Ee8P4M0CDTIHW9Fgqu/PQtLu6ePapq/T/iyyYVYaw5dS2PLw5hUmMoN62vWdF+CW4u3kuthu4RjHNknc8KJcclMIxEzo0yQGTqW7TLoOsMl2QUElxwS4MkqtTRYMfR6gxUzQ67YTSV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=YhLGNQTr; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240764f7c1so441121e0c.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1745503667; x=1746108467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdmvGtQ89u3GR+RFOjou40UjczCb89acby3lLgdG7oo=;
        b=YhLGNQTrfqzVAMgCe4F6IX1cD/GpcFzYRzIB3u6VBSjH3miWJ+UXVC84M4zHqnf8sI
         kNrB+nJgVLDEjsbC30PTgKmyLIcurT/IwumOJpniE5sUVFNQgMgXBwRaOVMP7gYB19Pu
         9lfN01CA81i5ZBAqDAYOwbkXCOXAfpfFL5S4Qxxoi5ydQ1aYIQSFTQ3KQHG4mash58f1
         JePQueg8EigjFVugybERpiDncc5sc70zMHVkg8JVEkPLFUJcxwSz5kSiZXwvMvNsSGwy
         T0r10DRa4tAYNaa4l5HyYyvrptTbUdRFXweCyAR5vEimioF7uFRLWQnak6tvKKi/AaA4
         OsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503667; x=1746108467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdmvGtQ89u3GR+RFOjou40UjczCb89acby3lLgdG7oo=;
        b=ce7TgdDWWX1wh7mSDYCZh3TQfSgGvCJ3CJpfvKfi3uqL+yc6lhbKR2MxVk+DsH6hzU
         EkP4O/ZXTXbFUuZTtw3BDmURbDdHFvz10wCwPqbKqBmhwdlAvX1+7o5u06PVP6cZOxVc
         Lwht6gFEv6CdxdJQR0CBJNAMJunhkJTvP2vTeRXctlJJjjPmuYLZNREtZ1MHwDNoMsZn
         7oZKwhmOYrReiROSWF/UbcDs88myHa7itE82duVuDPnwWJ+tmkVa5YuH36JG/CJbfJx5
         cnubo+p4WH+EPReGlgd6mlM5Ua04DAV4o/YXGPWZ31GLqe5MFbHQjc15MR7JcCNnX3VM
         29Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVJoJ1K1w2eJEvGsVDINHq6KNDtyybTAwxF8gNLBMsKpSzDi5T50EHEkqOw0GkqUX309WegGFGuQxjwCKOibQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFGENR7zNxFh+oasxHCI6wY/IWEFQnDis/EvH6DPsCMSaLa3b
	CmpYaCVN+OTg//TcFBfiHp0m5saOIgdYVDoQB3WXkgE0zjUTq0BGVrZk1VV0QfVJdGJ+RV2c0Yn
	0Bsq3WX3uLKD6Ff/UaZ6ICYNCdQXTseXllzUi8I1/1TR9MHqsbD1MWg==
X-Gm-Gg: ASbGncuUDYotFx8PD6xCu28bpvxliLjj0ciqPbMaCyK+5vDRg7LsloYBdotT+zq9Ih1
	nNo735PdXSz7XewsGQzWg2P2a9D0GNMadgzrSuJehf8vToAxPRlksljYfZY9QqOoohoPrYoHjSk
	n8A4R5Wx6JdbGpUEaRcBK+AgQk
X-Google-Smtp-Source: AGHT+IErhQUPnaKpU1zGFJ2/PkQnddkb7MAALj2W8zXHAMxbJSFnvaokxVPCygzxVqnmqKhgbkG9wcy3YrRYjiCEHV0=
X-Received: by 2002:a05:6122:20ab:b0:518:965c:34a with SMTP id
 71dfb90a1353d-52a7823dea3mr2333665e0c.2.1745503666453; Thu, 24 Apr 2025
 07:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com> <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com> <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
In-Reply-To: <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Thu, 24 Apr 2025 16:07:10 +0200
X-Gm-Features: ATxdqUGwtCFsT67ZYg7ZUzooAbjRkhLxFvzWycaGvXtqibopFchZNDxTQk0WmIo
Message-ID: <CAONkfw7xjJjMAZSfHg5avEV=Bc5aJZqrRxMDvKWK4g14bLNjRQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

I just rebuilt a clean disto and enabled the debug_mask=0x1020.
There are the logs bellow :

root@OpenWrt-WAP:~# uname --all
Linux OpenWrt-WAP 6.6.86 #0 SMP Sun Apr 13 16:38:32 2025 aarch64 GNU/Linux

root@OpenWrt-WAP:~# cat /etc/modules.conf
# examples:
# options mod1 option=val
# blacklist mod2
options ath11k debug_mask=0x1020

root@OpenWrt-WAP:~# cat /sys/module/ath11k/parameters/debug_mask
4128

root@OpenWrt-WAP:~# dmesg | grep ath
[   15.093627] ath11k_pci 0001:01:00.0: Adding to iommu group 2
[   15.099326] ath11k_pci 0001:01:00.0: assign IRQ: got 0
[   15.099512] ath11k_pci 0001:01:00.0: BAR 0: assigned [mem
0x2840000000-0x28401fffff 64bit]
[   15.107879] ath11k_pci 0001:01:00.0: boot pci_mem 0x00000000880f25e0
[   15.107886] ath11k_pci 0001:01:00.0: boot pci probe 17cb:1104 17cb:1104
[   15.108483] ath11k_pci 0001:01:00.0: MSI vectors: 16
[   15.113538] ath11k_pci 0001:01:00.0: pci msi base data is 0
[   15.113545] ath11k_pci 0001:01:00.0: qcn9074 hw1.0
[   15.118336] ath11k_pci 0001:01:00.0: FW memory mode: 2
[   15.125643] ath11k_pci 0001:01:00.0: boot failed to load firmware-2.bin: -2
[   15.125658] ath11k_pci 0001:01:00.0: boot using fw api 1
[   15.125668] ath11k_pci 0001:01:00.0: pci msi assignment MHI
num_vectors 3 user_base_data 0 base_vector 0
[   15.125675] ath11k_pci 0001:01:00.0: pci num_vectors 3 base_vector 0
[   15.129780] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   15.129933] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   15.129964] ath11k_pci 0001:01:00.0: pci irq 369 group 0
[   15.130013] ath11k_pci 0001:01:00.0: pci irq 370 group 1
[   15.130059] ath11k_pci 0001:01:00.0: pci irq 371 group 2
[   15.130110] ath11k_pci 0001:01:00.0: pci irq 372 group 3
[   15.130157] ath11k_pci 0001:01:00.0: pci irq 373 group 4
[   15.130204] ath11k_pci 0001:01:00.0: pci irq 374 group 5
[   15.130250] ath11k_pci 0001:01:00.0: pci irq 375 group 6
[   15.130295] ath11k_pci 0001:01:00.0: pci irq 376 group 7
[   15.130359] ath11k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
[   15.230443] ath11k_pci 0001:01:00.0: pci ltssm 0x111
[   15.230456] ath11k_pci 0001:01:00.0: pci pcie_hot_rst 0x11
[   15.235499] ath11k_pci 0001:01:00.0: pci pcie_q6_cookie_addr 0x0
[   15.235514] ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
[   15.255530] ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
[   15.255545] ath11k_pci 0001:01:00.0: pci soc reset cause 0
[   15.275554] ath11k_pci 0001:01:00.0: pci mhistatus 0xff04
[   15.285571] ath11k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
[   15.446403] ath11k_pci 0001:01:00.0: boot notify status reason
MHI_CB_EE_SBL_MODE
[   15.494739] ath11k_pci 0001:01:00.0: boot notify status reason
MHI_CB_EE_MISSION_MODE
[   15.515587] ath11k_pci 0001:01:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff soc_id 0xffffffff
[   15.524423] ath11k_pci 0001:01:00.0: fw_version 0x290b8862
fw_build_timestamp 2024-09-23 10:51 fw_build_id
[   15.534202] ath11k_pci 0001:01:00.0: boot using board name
'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.551970] ath11k_pci 0001:01:00.0: boot firmware request
ath11k/QCN9074/hw1.0/board-2.bin size 786836
[   15.551992] ath11k_pci 0001:01:00.0: boot board name
[   15.552001] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.552007] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.552013] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 30
                            id=160
[   15.552018] ath11k_pci 0001:01:00.0: boot board name
[   15.552024] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.552030] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.552036] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 31
                            id=161
[   15.552041] ath11k_pci 0001:01:00.0: boot board name
[   15.552047] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.552053] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.552059] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 31 36 32
                            id=162
[   15.552064] ath11k_pci 0001:01:00.0: boot board name
[   15.552070] ath11k_pci 0001:01:00.0: 00000000: 62 75 73 3d 70 63 69
2c 71 6d 69 2d 63 68 69 70  bus=pci,qmi-chip
[   15.552076] ath11k_pci 0001:01:00.0: 00000010: 2d 69 64 3d 30 2c 71
6d 69 2d 62 6f 61 72 64 2d  -id=0,qmi-board-
[   15.552082] ath11k_pci 0001:01:00.0: 00000020: 69 64 3d 32 35 35
                            id=255
[   15.552087] ath11k_pci 0001:01:00.0: boot found match board data
for name 'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.552093] ath11k_pci 0001:01:00.0: boot found board data for
'bus=pci,qmi-chip-id=0,qmi-board-id=255'
[   15.552100] ath11k_pci 0001:01:00.0: boot using board api 2
[   16.910820] ath11k_pci 0001:01:00.0: boot firmware request
ath11k/QCN9074/hw1.0/m3.bin size 340108
[   16.934188] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934216] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934228] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934238] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934249] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934258] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934273] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.934284] ath11k_pci 0001:01:00.0: pci msi assignment CE
num_vectors 5 user_base_data 3 base_vector 3
[   16.935322] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.935333] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 11,ring_num 0
[   16.937172] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.937185] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 12,ring_num 0
[   16.937196] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.937203] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 6,ring_num 0
[   16.937212] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.937219] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 7,ring_num 0
[   16.937489] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.937497] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 0
[   16.937934] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.938396] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.938405] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 1
[   16.938823] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939059] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939068] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 5,ring_num 2
[   16.939468] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939635] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939642] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 2,ring_num 0
[   16.939765] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939872] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939959] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.939967] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 3,ring_num 0
[   16.940135] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.940417] ath11k_pci 0001:01:00.0: boot htc service 'Control' ul
pipe 0 dl pipe 1 eid 0 ready
[   16.940425] ath11k_pci 0001:01:00.0: boot htc service 'Control' eid
0 tx flow control disabled
[   16.941453] ath11k_pci 0001:01:00.0: boot htc service HTT Data does
not allocate target credits
[   16.941570] ath11k_pci 0001:01:00.0: boot htc service 'HTT Data' ul
pipe 4 dl pipe 1 eid 1 ready
[   16.941578] ath11k_pci 0001:01:00.0: boot htc service 'HTT Data'
eid 1 tx flow control disabled
[   16.941633] ath11k_pci 0001:01:00.0: boot htc service 'WMI' ul pipe
3 dl pipe 2 eid 2 ready
[   16.941641] ath11k_pci 0001:01:00.0: boot htc service 'WMI' eid 2
tx flow control disabled
[   16.943010] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.943267] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.943476] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   16.943604] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.246410] ath11k_pci 0001:01:00.0: htt event 48 not handled
[   17.252661] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.253260] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.253871] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.254512] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.254528] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 16,ring_num 0
[   17.255170] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.255743] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.255759] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 19,ring_num 0
[   17.284419] ath11k_pci 0001:01:00.0: pci msi assignment DP
num_vectors 8 user_base_data 8 base_vector 8
[   17.284438] ath11k_pci 0001:01:00.0: pci ring not part of an
ext_group; ring_type: 20,ring_num 0
[   22.039565] ath11k_pci 0001:01:00.0 phy0-ap0: entered allmulticast mode
[   22.050081] ath11k_pci 0001:01:00.0 phy0-ap0: entered promiscuous mode
[   30.709682] ath11k_pci 0001:01:00.0 phy0-ap0: left allmulticast mode
[   30.716078] ath11k_pci 0001:01:00.0 phy0-ap0: left promiscuous mode
[   36.330610] ath11k_pci 0001:01:00.0 phy0-ap0: entered allmulticast mode
[   36.337503] ath11k_pci 0001:01:00.0 phy0-ap0: entered promiscuous mode

root@OpenWrt-WAP:~# iw dev
phy#0
Interface phy0-ap0
ifindex 14
wdev 0x2
addr 04:f0:21:bd:d7:99
type AP
channel 100 (5500 MHz), width: 160 MHz, center1: 5570 MHz
multicast TXQ:
qsz-byt qsz-pkt flows drops marks overlmt hashcol tx-bytes tx-packets
0 0 0 0 0 0 0 0 0

root@OpenWrt-WAP:~# iwinfo
phy0-ap0  ESSID: "OpenWrt-WAP-5GHz"
          Access Point: 04:F0:21:BD:D7:99
          Mode: Master  Channel: 100 (5.500 GHz)  HT Mode: HE160
          Center Channel 1: 114 2: unknown
          Tx-Power: 0 dBm  Link Quality: unknown/70
          Signal: unknown  Noise: -101 dBm
          Bit Rate: unknown
          Encryption: none
          Type: nl80211  HW Mode(s): 802.11ac/ax/n
          Hardware: 17CB:1104 17CB:1104 [Qualcomm Atheros QCN6024/9024/9074]
          TX power offset: none
          Frequency offset: none
          Supports VAPs: yes  PHY name: phy0

root@OpenWrt-WAP:~# reboot
[  343.663492] Internal error: synchronous external abort:
0000000096000210 [#1] SMP
[  343.670992] Modules linked in: nft_fib_inet nft_connlimit
nf_flow_table_inet nf_conncount ath11k_pci(O) ath11k(O) rndis_host
nft_socket nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject
nft_redir nft_quota nft_queue nft_numgen nft_nat nft_masq nft_log
nft_limit nft_hash nft_fwd_netdev nft_flow_offload nft_fib_ipv6
nft_fib_ipv4 nft_fib nft_dup_netdev nft_dup_ipv6 nft_dup_ipv4 nft_ct
nft_chain_nat nfnetlink_cttimeout nfnetlink_cthelper nf_tables nf_nat
nf_flow_table nf_conntrack_netlink nf_conntrack mmc_spi mac80211(O)
ftdi_sio ch348 ch341 cfg80211(O) cdc_subset cdc_ether cdc_eem
usbserial usbnet usbmon usbhid ums_usbat ums_sddr55 ums_sddr09
ums_karma ums_jumpshot ums_isd200 ums_freecom ums_datafab ums_cypress
ums_alauda tps23861 tmp103 tmp102 spidev spi_gpio spi_bitbang sfp
rtc_pcf8563 rtc_pcf2123 rtc_ds1672 rtc_ds1374 qrtr_mhi qrtr
qmi_helpers(O) of_mmc_spi nfnetlink_queue nfnetlink nf_socket_ipv6
nf_socket_ipv4 nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog
nf_dup_netdev nf_dup_ipv6 nf_dup_ipv4 nf_defrag_ipv6
[  343.671198]  nf_defrag_ipv4 mhi_pci_generic mhi_net mhi mdio_i2c
mdio_gpio max6697 ltc4151 lm95241 lm92 lm90 lm85 lm77 lm70 lm63 jc42
ina2xx ina209 hid_generic compat(O) cdc_acm at25 adt7475 ntfs3 configs
sg hid tmp421 tc654 adt7410 adt7x10 adcxx ad7418 i2c_gpio
i2c_designware_pci i2c_ccgx_ucsi i2c_algo_bit gpio_pcf857x i2c_mux_reg
i2c_mux_pca954x i2c_mux_pca9541 i2c_mux_gpio cryptodev(O) hwmon_vid
msdos bonding nls_utf8 zram zsmalloc eeprom_93cx6 crypto_user
algif_skcipher algif_rng algif_hash algif_aead af_alg sha512_generic
sha512_arm64 seqiv sha3_generic jitterentropy_rng drbg michael_mic md5
hmac geniv cmac uas usb_storage xhci_plat_hcd xhci_pci xhci_hcd dwc3
dwc2_pci dwc2 roles ohci_pci uhci_hcd ohci_platform ohci_hcd ehci_pci
fsl_mph_dr_of ehci_platform ehci_fsl ahci_platform ahci_qoriq
libahci_platform libahci ehci_hcd nvme nvme_core exfat gpio_cascade
mux_gpio phy_generic usbcore usb_common microchip mii
[  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G           O
  6.6.86 #0
[  343.849746] Hardware name: LS1088A
[  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[  343.876070] sp : ffff80008d473b60
[  343.879380] x29: ffff80008d473b60 x28: ffff000005e88000 x27: ffff000000e7f138
[  343.886522] x26: ffff800080f20128 x25: ffff8000811b0028 x24: 0000000000000000
[  343.893664] x23: 0000000000000001 x22: ffff00000720ade8 x21: ffff800079a80be4
[  343.900807] x20: ffff000007200000 x19: ffff800083c80500 x18: 0000000000000000
[  343.907948] x17: 0000000000000000 x16: 0000000000000000 x15: 00004b0957e10d10
[  343.915090] x14: ffff000002f3961c x13: ffff800081113d10 x12: 0000000000000169
[  343.922232] x11: ffff800080d63a68 x10: 1fffe000005e7301 x9 : 0000000000000000
[  343.929374] x8 : 0000000000000000 x7 : ffff7ffffa960000 x6 : 0000000000000004
[  343.936516] x5 : 0000000000000000 x4 : 000000000007ffff x3 : 0000000000000000
[  343.943658] x2 : 000000000000003f x1 : ffff00000720ad58 x0 : ffff800083c00000
[  343.950800] Call trace:
[  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
[  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
[  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
[  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
[  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
[  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
[  343.986906]  pci_device_shutdown+0x34/0x44
[  343.991004]  device_shutdown+0x160/0x268
[  343.994928]  kernel_restart+0x40/0xc0
[  343.998594]  __do_sys_reboot+0x104/0x23c
[  344.002518]  __arm64_sys_reboot+0x24/0x30
[  344.006529]  do_el0_svc+0x6c/0x100
[  344.009931]  el0_svc+0x28/0x9c
[  344.012986]  el0t_64_sync_handler+0x120/0x12c
[  344.017344]  el0t_64_sync+0x178/0x17c
[  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
[  344.027102] ---[ end trace 0000000000000000 ]---
[  344.031718] Kernel panic - not syncing: synchronous external abort:
Fatal exception in interrupt
[  344.040513] Kernel Offset: disabled
[  344.043997] CPU features: 0x0,00000000,00020000,1000400b
[  344.049309] Memory Limit: none
[  344.052358] Rebooting in 3 seconds..

