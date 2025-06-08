Return-Path: <linux-wireless+bounces-23831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812EAD1384
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57093A83E1
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9381C8611;
	Sun,  8 Jun 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/VhF9hO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BB1A9B46
	for <linux-wireless@vger.kernel.org>; Sun,  8 Jun 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749402476; cv=none; b=sjE6gjKiLMF0VQzDKFdkn3G6xXyrwLz0sicfM9nJrtNsj+YoLjV2AweRBNrL2KOKjYFfroxPiknNYbYZEYyWGT1Lh/R6S8jUzxn4b62aehWPLhamOBTTzb/VhC4TmH0niVxlQTb8hy0FUCasV5H2QojNL/n/4qzOXHTdDNV9UJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749402476; c=relaxed/simple;
	bh=ePLUCSl7yLU6VvqpJ5kFqijSK+jlZUxZTtLO7Ad/UrQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=L2zPekFQXnyKrmEY5P9HEchWwLdXdw1wLhUH/3FUEM7QiMXyOXLlyTcC2Evh7fAgy16lydZLXKsxAb3Im9WSH6NGmwevvc8rZV71o4mU2P9pG+f9tnc4bkwvESz6TNcEgz5ujCIgyzTMkznFp/ysM1A2ruhl8Lvhjynd0/+UZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i/VhF9hO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558G05Zu032750
	for <linux-wireless@vger.kernel.org>; Sun, 8 Jun 2025 17:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y3MrT2w0E4SzGXJtrJUWL3
	yg93uDkQIiRATI5H081pc=; b=i/VhF9hOuJOWkT1hD10lbSs6B80dUFT0/z7evu
	B5vIj8f+c8w1DfKYdX3MF4TeI9U2JWkxH8fhwpoJz1wvd4xVh7lyLXxHsQ6hpxNk
	RCpulA+xGwgSf68ff9BAVYwIzR/RwC0VczeooET0d4++gF61nadvJiyLNaz3WYik
	8qQHtx7xeo16I65Ey02xt6YGWHaTm9Aspf8KD51KrEEUIppAs58bRzTQ/lWKiPcl
	k7CaDWNUbm/ikRs0kLtoK4xCsjlN4bE9/wcfG04m5yzUgexY7/BONWSarWmVOGgc
	5I4zBTH2gRVLwAmaybtZDL5rR0Ut3nv76i2h4UDL5CLNIjxQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d11um1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 17:07:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234dbbc4899so58205275ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 10:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749402472; x=1750007272;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3MrT2w0E4SzGXJtrJUWL3yg93uDkQIiRATI5H081pc=;
        b=RdXmql6klBCBBWnuXHeyXvjQUjDPMr1xhY84fcV9zPqWdMrkO/3hzHPAl+dCDMuqQ5
         5hUgEPVSqvHpudHh5lz/qQWxpCp/C8fqyv3tNCmLeCT0HTXhBZLUbbqnRMxVWO7sbfnq
         p+EN+hcVczzcWMpS4a2scMbVHaRvYY95qdEoDR39HwlCvMN5em9qg0vwaZ3pSLAvodF+
         ccmlmuhWMB7TWqQ/SP4G115bxyJEewLy2sZ6gGf4FStygC3TRehGtnycpL3gQFw4UIQ/
         I3fH/8B6hLzQoUrwhJ18BF0Y8FWPXi79iDCywHJF5tgd68m5p+m/xgLoBrD4JSXNAjzd
         pvVQ==
X-Gm-Message-State: AOJu0YyUTIjWC1J2F49stYKYfEXFtwEMIrwwwcRKUMVk0R8SfWZqd2je
	ju5Jgtp3OtKv8xwwm7s0VkKK/+ewUJjppLPjJtyJsWJxh9ZrpGUmhnH1GftDPwPPfQTntWOrGm0
	VYeftYNP+g21Og/Uii5BHQnWQ0496ZtuCxvo82/o/WiZSckZ6WVoA/JQau1XeMyL9m9Cfg/ce9V
	KPdg==
X-Gm-Gg: ASbGnct99NYL599pc2OaiDrLr/a/BgDdIt+3XvOaPzRJkNU8XAZTKQ7lcwkOAVaLF0j
	1ntjdvjrvnZWYJnzXen57RWfgK68DAqcWa1Xyuv8xq1Pscc/7tirkP8ce4m9Ifdjz6LWyYnNNlu
	DxeQgOqyrZyXEBFqRzul0egjFnMDHiS35RtJb1H3Ed0nS5JOKgbe67+JZv5x7A7fz7nHnqYThfj
	zOIooBbkB7QiOOBEksy5QcR+5dPaF28FrV2625U+Kl/LSZcgLx78/kGgi5j6z7hOep/MJdJnist
	biyNFutvCllxC+9guZEbu/TsSZiXMdeFKk2LT3c+0n05krA6
X-Received: by 2002:a17:902:c952:b0:234:d7b2:2aab with SMTP id d9443c01a7336-23601cfb69emr151020945ad.14.1749402472242;
        Sun, 08 Jun 2025 10:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPF5QYVXldVbJU9+uqJzs3oYWjXUWO5AZS79gxD1TIb8AWh0wWhXGKUy1/A7ATvW/Qpi4ApA==
X-Received: by 2002:a17:902:c952:b0:234:d7b2:2aab with SMTP id d9443c01a7336-23601cfb69emr151020725ad.14.1749402471854;
        Sun, 08 Jun 2025 10:07:51 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078ca1sm40900605ad.35.2025.06.08.10.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 10:07:51 -0700 (PDT)
Message-ID: <6574640b-a383-4c16-bbd2-710f362ed644@oss.qualcomm.com>
Date: Sun, 8 Jun 2025 10:07:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20250608
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5i7NrtQiuYasDaihxIripmrX7bDRVKL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDEzNiBTYWx0ZWRfX0bhfj7+3Fh61
 4jsoT1DzA0RmTyaCNjs2JgMfpXG7AfPCmYMChigsiEE16R+rvG57PosG2EBH8HN0U74d/d1n+8A
 X7q8GP0nP+HVBhw1iX1hr4cT4YIOXUvsaNQzQ7MwElazjNtyUVlrOVGOau+fAal5owaMzl1MC4O
 akx2Tf+ecGcSRJi3hbYfTkycvlm33wtd12LuFvk6ZWFx9rtmd6M5lT+gnEv3WafGrmoP9cJwbNh
 32qg9fRQ8SwWFOSY71CJeFNSGjsb+aeXVn/0D38wa76OnLC8L2XcR44fVaFsi0kRd01NvIrS3jQ
 wGVGaFdUSZ1+AOpst4tLXVgm/wXk9unjv6hWiA31VGfs7LB9AwVtmyDRikGbrBRWajHZe+ZybLv
 SyLzECeZaDf1sV7bOfPPVIc94wdQajxvcz8RyF8VqlqxEU18EjfpAzfU2uglbRIIYnN31u30
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=6845c369 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=wYb_BKVbZVJNipbyvL8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 5i7NrtQiuYasDaihxIripmrX7bDRVKL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506080136

The following changes since commit 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21:

  Merge tag 'net-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-05-28 15:24:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250608

for you to fetch changes up to f3fe49dbddd73f0155a8935af47cb63693069dbe:

  wifi: ath12k: fix uaf in ath12k_core_init() (2025-06-07 07:41:50 -0700)

----------------------------------------------------------------
ath.git updates for v6.16-rc2

Fix a handful of both build and stability issues across multiple drivers.

----------------------------------------------------------------
Baochen Qiang (8):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started
      wifi: ath11k: move some firmware stats related functions outside of debugfs
      wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
      wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
      wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
      wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Caleb Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Jeff Johnson (1):
      wifi: ath12k: Fix hal_reo_cmd_status kernel-doc

Loic Poulain (1):
      wifi: ath10k: Avoid vdev delete timeout when firmware is already down

Miaoqing Pan (1):
      wifi: ath12k: fix uaf in ath12k_core_init()

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Sebastian Gottschall (1):
      wil6210: fix support for sparrow chipsets

 drivers/net/wireless/ath/ath10k/mac.c        |  33 ++++--
 drivers/net/wireless/ath/ath10k/snoc.c       |   4 +-
 drivers/net/wireless/ath/ath11k/core.c       |  29 +++---
 drivers/net/wireless/ath/ath11k/core.h       |   4 +-
 drivers/net/wireless/ath/ath11k/debugfs.c    | 148 +++------------------------
 drivers/net/wireless/ath/ath11k/debugfs.h    |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c        | 127 +++++++++++++++--------
 drivers/net/wireless/ath/ath11k/mac.h        |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c        |  49 +++++++--
 drivers/net/wireless/ath/ath12k/core.c       |  10 +-
 drivers/net/wireless/ath/ath12k/hal.h        |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c         |   6 ++
 drivers/net/wireless/ath/ath12k/hw.h         |   2 +
 drivers/net/wireless/ath/ath12k/pci.c        |   6 +-
 drivers/net/wireless/ath/ath12k/pci.h        |   4 +-
 drivers/net/wireless/ath/wil6210/interrupt.c |  26 +++--
 16 files changed, 228 insertions(+), 237 deletions(-)

