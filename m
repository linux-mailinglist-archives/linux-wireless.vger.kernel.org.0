Return-Path: <linux-wireless+bounces-25775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA6B0CD9F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED503B759F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8C243374;
	Mon, 21 Jul 2025 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVhPaw6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DA22F16C
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139587; cv=none; b=ksx4dbEVHTGydlsgv44SDpWVEAEa24pFHbNUFf9+OrMLvUOIUhzDVueleDSe7OLeJZ+LDqaN3GLlVWPqT3thEkVy3Sr79JbXbptAx9ghb2uE2XvGDnsUofdXkX8ey1XJm5NDKHG8hYilA1Nweb3Hx/uHLgCfUYEMHT2f2fBq4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139587; c=relaxed/simple;
	bh=eoDabLjrs7tjKsa4WGsQ+/MO0HYAgLNw3D5VXh4ZDXU=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=hfM83BHd+GExD99J7Vwawjr8VFRVQIcdZ/vjfGZUJ4jNKIeBdTieOHdnjZ7NeCkWAmYG36jYOyuYnBKY2AaDWCFWBxsguFkbOWXijc26Uw1u39FMoLdZOHwKhRqnySOF3irV+cVkVa6tccJhDewGDa8TnfdV7pxHVlutmKz9NFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVhPaw6E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIhHaV005066
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 23:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UD7kEq3kjBGfnHnxGteIlK
	swmtx+ENzmKSEZ2T3PVsk=; b=YVhPaw6Eq2LWfMDalc5SgS7VFDIgwsQfLQ8eAy
	EjLsEdgz6wzaoGl9MDe8RgRiGfEHJYNfmy0Mdd2IbE6BOtc7RdNDJXOFU86VbVhs
	KexuOG9YFpotEBQXvVlj+Hz9NDy8p2oStxpzRweoUNcfOHIGb0wJQi8zLkGp0QY6
	ejKaKCnP4B1IOBF5E/HUkGtMtsRaaDYYVLsRowdZboxmpq/AX1oIcfSmT2qpognl
	LhLlUzoK+i+qOxhnHwGapgxFiEFJa4b1cGpwG5SaNKBLR+R9AiwKYHA/jFT9dXwo
	ifG+YHC4oIEDlX6Jnd/+yje+CYJOgcCnzojeGecIIDt2pyCA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v5rgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 23:13:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2363bb41664so38220995ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 16:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139583; x=1753744383;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UD7kEq3kjBGfnHnxGteIlKswmtx+ENzmKSEZ2T3PVsk=;
        b=TRuK0LM+xJfUimHLcns/JQD0e9P7ZNdGBWpAYy5PvD4gdl0JfI5UUSXWvV9/gwAfnH
         m5YO3Us+kfD2mLcg+6t0x8XLg2f0myjMq7Xx4mDsnDzr8Nn5DGGw+QFI7AycHkUhYDxJ
         A6wR7tGtG1OVvhLa4oywBP1gfqi9ez4ZsAR/YlTdawpVhyAzylniaAVYqTU1xUzQtCHT
         TY05+sJlYi8G9BL9/Sk4fllo84ZX1r5iSdtAb6XHXTDJDlj2BjeDSKSRYpUZvvWyW7qR
         PoKIHQ7Z5uLAyaiO3VzEz2MYucWsZR7ZQJZGDHq1FkQ+aNyY5BeyY6Shcrrtg1vjbjHU
         riAQ==
X-Gm-Message-State: AOJu0YxmQOHeriZpMDWfWZiKJ4HGBn8Gapf7aecLkflxBvcvpf+TbqCq
	lBC++Yp3YaVeKG1dN8kUQYI17mykpZmIZRrLEdl0yqbmVDu7kvP5OSjIGMFEkbSR+vzM3ry8XEp
	KBo3hoQbSbevX5doxnUYr/YKCvFinoBR5w4KQ9PDLefZRDkQY6qfpY7AF+FvsZhcOiV4bk+R063
	FlRg==
X-Gm-Gg: ASbGncvzvm5oykLRtTejayz97KGPMhKiBhsNrjkC7hubcEx0jcb3KysO6P1qtuCZZIc
	lRJ8yWjpkyjT1U1PNwja1Y2FDO6B4lcYLvaT3AgAiRvg+VkvRaYg1J5tuDjFxAKqy/e5D9GtWP5
	LEKYTnuf+XZ0l6NjXCF4BybMNEjtHmBFo8DHEqzM+n35KwGm/GTAqVYozK+7WgP1bLVvLkkVmCW
	WeAiV4ED0NFVd4OZJgnHrjCA4+XD9j6E7SwscoOIZ8h+/TuhYO16iD3cexBKculqBOGnv724fd3
	UFmMyiDcJXc59vh4MbD8V7rjYiYDfxugXMO4gczVdYgwBNYF4BJRIEqFdRZCLZW+JCiwa7JXM5H
	C
X-Received: by 2002:a17:902:f650:b0:234:24a8:bee9 with SMTP id d9443c01a7336-23f8abefcd0mr16030765ad.4.1753139583042;
        Mon, 21 Jul 2025 16:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiXOoyw/3pUDeyM5jLlBxiHNJ7SLqzHGpr9fe0bHIzEuRwklScSGuJbZLYz8JuGnIgdx3dRQ==
X-Received: by 2002:a17:902:f650:b0:234:24a8:bee9 with SMTP id d9443c01a7336-23f8abefcd0mr16030495ad.4.1753139582478;
        Mon, 21 Jul 2025 16:13:02 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d4esm63646405ad.23.2025.07.21.16.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:13:00 -0700 (PDT)
Message-ID: <124a13a2-e727-46db-b1cf-d370088b7fbd@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 16:12:58 -0700
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
Subject: pull-request: ath-next-20250721
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h0jJv5_A_5lLQlPIC6Nnakhh9maRNWR4
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687ec980 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=cecSKI3_BKC6A8wipHcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDIwOCBTYWx0ZWRfX3uMf52CbPdZ6
 U8wBbYlxC9N0IvrJ61N13VOqw33x7JJub729GWbzJHiXLOsNIt6HDOsFPNI/HyGdMRR/IGFvCd9
 2ZwN3aJdfbEEwDblF751JM1YHWk7NnUvaiZlHCsNGfRNpwreLFD0JzGF2BOVXWwXV/TVMD5pqav
 6FQpl2jmFPgvSNOM/71aw4WDMsI4yA9OV/moA1CWfqB8rmwUoDadp4lgbfNLLwUx9hrG/6EEGHx
 B5fZICEDeYBeuZEfDqLM4EnGxKmcykrCcjx3gUkV7YotBzhEPiW65K3VyptxBjrHmHNgss3isFO
 6Knu92ebLMbVy+h63vvh6w1ZNJIiBeUa0OofzPVOH6uJy0a8fxT1MfLpY7K60thIO9Z/M9oXL1b
 ZzGZu3sdz0VlB2nQVAddL4K/HWfZiXBjj1Yi/hw9PeArD/ASAiFoqilhd7Vyijk83hhepRfx
X-Proofpoint-ORIG-GUID: h0jJv5_A_5lLQlPIC6Nnakhh9maRNWR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210208

The following changes since commit 28aa52b6189f1cc409f96910c63fa1b99370b99e:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 10:40:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250721

for you to fetch changes up to 4a2bf707270f897ab8077baee8ed5842a5321686:

  wifi: ath12k: Correct tid cleanup when tid setup fails (2025-07-21 14:34:01 -0700)

----------------------------------------------------------------
ath.git patches for v6.17

Highlights for some specific drivers include:

ath9k:
Add AHB "of" support

ath11k:
Support device-specific firmware override
Fix potentially reordered access to device memory

ath12k:
Add more Wi-Fi 7 functionality
Add more statistics to DebugFS
Support different memory profiles
Support 802.11 encap/decap offload to firmware
Fix potentially reordered access to device memory

And of course there is the usual set of cleanups and bug fixes across
the entire family of "ath" drivers.

----------------------------------------------------------------
Aaradhana Sahu (6):
      wifi: ath12k: Block radio bring-up in FTM mode
      wifi: ath12k: Add a table of parameters entries impacting memory consumption
      wifi: ath12k: Remove redundant TID calculation for QCN9274
      wifi: ath12k: Refactor macros to use memory profile-based values
      wifi: ath12k: Enable memory profile selection for QCN9274
      wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM mode

Aditya Kumar Singh (4):
      wifi: ath12k: fix timeout while waiting for regulatory update during interface creation
      wifi: ath12k: add support for Tx Power insertion in RRM action frame
      wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
      wifi: ath12k: Add num_stations counter for each interface

Baochen Qiang (3):
      wifi: ath12k: remove unneeded semicolon in ath12k_mac_parse_tx_pwr_env()
      wifi: ath11k: fix sleeping-in-atomic in ath11k_mac_op_set_bitrate_mask()
      wifi: ath12k: bring DFS support back for WCN7850

Colin Ian King (1):
      wifi: ath11k: Make read-only const array svc_id static const

Hari Chandrakanthan (1):
      wifi: ath12k: Fix station association with MBSSID Non-TX BSS

Hariharan Basuthkar (1):
      wifi: ath12k: Send WMI_VDEV_SET_TPC_POWER_CMD for AP vdev

Harshitha Prem (1):
      wifi: ath12k: update unsupported bandwidth flags in reg rules

Jeff Johnson (4):
      wifi: ath12k: pack HTT pdev rate stats structs
      wifi: ath10k: Prefer {} to {0} in initializers
      wifi: ath11k: Prefer {} to {0} in initializers
      wifi: ath12k: Prefer {} to {0} in initializers

Johan Hovold (10):
      wifi: ath11k: fix suspend use-after-free after probe failure
      wifi: ath11k: fix dest ring-buffer corruption
      wifi: ath11k: use plain access for descriptor length
      wifi: ath11k: use plain accesses for monitor descriptor
      wifi: ath11k: fix source ring-buffer corruption
      wifi: ath11k: fix dest ring-buffer corruption when ring is full
      wifi: ath12k: fix dest ring-buffer corruption
      wifi: ath12k: use plain access for descriptor length
      wifi: ath12k: fix source ring-buffer corruption
      wifi: ath12k: fix dest ring-buffer corruption when ring is full

Kang Yang (1):
      wifi: ath10k: shutdown driver when hardware is unreliable

Karthikeyan Kathirvel (1):
      wifi: ath12k: allow beacon protection keys to be installed in hardware

Maharaja Kennadyrajan (2):
      wifi: ath12k: Add support to TDMA and MLO stats
      wifi: ath12k: Add support to RTT stats

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath11k-pci: describe firmware-name property
      wifi: ath11k: support usercase-specific firmware overrides

Nithyanantham Paramasivam (3):
      wifi: ath12k: Fix the handling of TX packets in Ethernet mode
      wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
      wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211

P Praneesh (1):
      wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM error path

Pradeep Kumar Chitrapu (8):
      wifi: ath12k: push HE MU-MIMO params to hardware
      wifi: ath12k: push EHT MU-MIMO params to hardware
      wifi: ath12k: move HE MCS mapper to a separate function
      wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
      wifi: ath12k: add support for setting fixed HE rate/GI/LTF
      wifi: ath12k: clean up 80P80 support
      wifi: ath12k: add support for 160 MHz bandwidth
      wifi: ath12k: add extended NSS bandwidth support for 160 MHz

Qianfeng Rong (1):
      wifi: ath5k: Use max() to improve code

Raj Kumar Bhagat (2):
      wifi: ath12k: handle WMI event for real noise floor calculation
      wifi: ath12k: use real noise floor instead of default value

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP

Rosen Penev (4):
      wifi: ath9k: ahb: reorder declarations
      wifi: ath9k: ahb: reorder includes
      dt-bindings: net: wireless: ath9k: add WIFI bindings
      wifi: ath9k: ahb: replace id_table with of

Saleemuddin Shaik (1):
      wifi: ath12k: Add support for transmit histogram stats

Sarika Sharma (8):
      wifi: ath12k: Add memset and update default rate value in wmi tx completion
      wifi: ath12k: fill link station statistics for MLO
      wifi: ath12k: add link support for multi-link in arsta
      wifi: ath12k: add EHT support for TX rate
      wifi: ath12k: correctly update bw for ofdma packets
      wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
      wifi: ath12k: properly set bit for pdev mask for firmware PPDU_STATS request
      wifi: ath12k: Correct tid cleanup when tid setup fails

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Sivashankari Madhavan (1):
      wifi: ath12k: support average ack rssi in station dump

Sriram R (2):
      wifi: ath12k: Add support to enqueue management frame at MLD level
      wifi: ath12k: Validate peer_id before searching for peer

Sumanth Gavini (3):
      wifi: wil6210: wmi: Fix spellings reported by codespell
      wifi: ath10k: Fix Spelling
      wifi: ath6kl: Fix spellings

Tamizh Chelvam Raja (2):
      wifi: ath12k: fix endianness handling while accessing wmi service bit
      wifi: ath12k: Add support to parse max ext2 wmi service bit

Thiraviyam Mariyappan (1):
      wifi: ath12k: Clear auth flag only for actual association in security mode

 .../bindings/net/wireless/qca,ath9k.yaml           |   18 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |    6 +
 drivers/net/wireless/ath/ath10k/core.c             |   50 +-
 drivers/net/wireless/ath/ath10k/core.h             |   13 +-
 drivers/net/wireless/ath/ath10k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |    7 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    8 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c           |    4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   15 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    3 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |    6 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath11k/core.c             |    9 +-
 drivers/net/wireless/ath/ath11k/core.h             |   13 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |   38 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |   15 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   11 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   45 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |   15 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   39 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    2 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   28 +-
 drivers/net/wireless/ath/ath11k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |    3 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   12 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |    1 +
 drivers/net/wireless/ath/ath12k/ce.c               |    5 +-
 drivers/net/wireless/ath/ath12k/core.c             |   80 +-
 drivers/net/wireless/ath/ath12k/core.h             |   44 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |    3 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |    8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  564 ++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  207 ++-
 drivers/net/wireless/ath/ath12k/dp.c               |  138 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   43 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   29 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   72 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  155 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   40 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   55 +
 drivers/net/wireless/ath/ath12k/hw.h               |   32 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1669 +++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |   17 +
 drivers/net/wireless/ath/ath12k/pci.c              |    6 +-
 drivers/net/wireless/ath/ath12k/peer.c             |    5 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   28 +
 drivers/net/wireless/ath/ath12k/qmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    6 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   31 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  359 ++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  165 +-
 drivers/net/wireless/ath/ath5k/phy.c               |   12 +-
 drivers/net/wireless/ath/ath6kl/core.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/hif.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/htc.h              |    6 +-
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    2 +-
 drivers/net/wireless/ath/ath6kl/init.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/sdio.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/usb.c              |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |   10 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   60 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    2 +-
 drivers/net/wireless/ath/wil6210/wmi.h             |    4 +-
 69 files changed, 3532 insertions(+), 732 deletions(-)

