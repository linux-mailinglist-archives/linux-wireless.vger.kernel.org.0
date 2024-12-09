Return-Path: <linux-wireless+bounces-16098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A19E9C66
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297DE188858A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407414F121;
	Mon,  9 Dec 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnZDB9Dm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291C14F9F3
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763565; cv=none; b=pwpRi/0r7/UUuTyCScCb2dEE4TNJ0hXpvS8TBTIPhk5CQm6D90bNKMD1M4pbtjCfQI/RwJcMHjwOia8n69//qlf7g3UsIOddtRTMPoYeo8EIy/+Guso4PhSvNMmemh0AYiuMPeyJJSekpb6AzftXWeLvDFp+fHoXks/X98hXEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763565; c=relaxed/simple;
	bh=FbVMyUbjHZe0YiaBg4dwHYEgjTViDfUdOA0iGinnFF8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=LJxkhWGVCONpGlzxOo+JJmrSzUMPu+8Lslntl18mzgfqRIPgwOkF5fH9+2/iHeI+UHx+zKeHCbL4ZEQ6tNPPJdrlJnmQcThfjVG/zrxtCEzEMTsQUk37rYyZ19wOBBPiEO2p2QnerUPajxKDrLX5V4kjSo09lA2b3SwBg8zFMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnZDB9Dm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Aw5cR015555
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 16:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Cqe63yc5xMHZNxkyy44oKS
	u0NiQwLPXvmI/sCAdZVs4=; b=KnZDB9DmYlvUmWzXYdoGodEbX4bfnwZsP2SFG2
	jTYaAGOrO5PoChf0XgDWuIqyJPvyottdzc0Cyjl+CgDMTcl1J8vC/qO22wATaFqV
	RN2P8jir0x7vTLe/G3Z4QJBPIVODhTC4k29Dse/U1i2eeY76BFRJkix2v5hUC5je
	GC0nqQQ18FGrO3uMDvSLftSowubRI9OFHR1YoMWIny318hmxELAY1+EHzHubxqT6
	z9c6hxOe5nfan/00P6UHbbeg+UR7ZRHYKkXgvpX+5+pgkffFT8mXXkFJQcNPCvoe
	tWKSpvqgpU0vV89UbS3v2jTkVRk/I+kVHCiX74/7gQ4lkqXw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dy8ts75v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 16:59:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee6b027a90so7214979a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 08:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763562; x=1734368362;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cqe63yc5xMHZNxkyy44oKSu0NiQwLPXvmI/sCAdZVs4=;
        b=N1F8p2pJg41yw3wZT3Z1vSqpHWenKzdofNR0YkmTxVkR7kHik1PmdnCfZPk61WLdI2
         i753H9TS4+pzjKwLwNgzOmRPn/cJKJu2SNuDKTic4AFH7mCWyxBkQZdGA1Fhbln+C/VC
         KR2Mlt6sXgnEnWsFv3WxUA1cpXNGodr9SXjb6q7ZdMRUTYdhyMytIizwiMotMVsylsc1
         hkLKWEh5Vs3Hb2wrMXFAx344+bEbJmo3tTlN5CNjTqjtAY9V9UInW4wNyR9PTdjsDftt
         gJ8Jqg6z/mF9fqvMlNhQxR788zH+8KL2/JyYhylMW36Bj1PiVaMBwovv1NT26MTVdPu9
         tjzg==
X-Gm-Message-State: AOJu0YzOzP742jURUCB1eiPf9g3DRm0ER3/N5/ZpgZw0mkgqcXh9C2JN
	7I5dQdXoNHbZZ19tz+TCAx6FFkPrMd6yKeu3WmZ/T9WXbe7SyEjnS21Zqk6VwP/Vcx/eKKJfmUt
	8BAhn+lZYrqNTl0O+ArYHeOLVFedmtX9kYNcCBtCA0mHwS6gZ2h8Pkw8RJ+EFVKfhFpanQr3c5Q
	==
X-Gm-Gg: ASbGnct0W0Xrm+anSUraiWMxgSy5dtlPavrbfVpH7KgyJxjudj7yQGiWl4yVXSM+Gs6
	WgEr/+0cBgngUFKDzG7S8MsqRhCyovkW9ppOswa+EdVot9RBLoBPATjCqSIPTuArZaI7oup7G+L
	0eTmTc2rFNWCJgnmTGwjawzPqcvxK3yQaqRHM41jOtLbZsJDTR3ReyWLdIC5VPE7+ThdBNoyHKK
	f16ZIdcRLzzsE5tjzldWQkGu02O7EZEweN6RPkfVJrl2FBDNHQfKMZGhQuiZeyE26AIR/dHlC2i
	gPmf3Mftraw=
X-Received: by 2002:a17:90b:4a:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2efcf136579mr1784495a91.3.1733763561666;
        Mon, 09 Dec 2024 08:59:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZTS9C4BJCt9kyZwlO+HpR3HB57Lvf55z4w/IcHcKXNKbG36kHwnh/zlS856HJiwhcX+J1gQ==
X-Received: by 2002:a17:90b:4a:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2efcf136579mr1784451a91.3.1733763561217;
        Mon, 09 Dec 2024 08:59:21 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701def5sm10113787a91.31.2024.12.09.08.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 08:59:20 -0800 (PST)
Message-ID: <1bcdaf98-6078-4f79-a989-2e5db9400585@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 08:59:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org, kvalo@kernel.org
Subject: pull-request: ath-next-20241209
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SrUKrMipqPqjI-PRW3fosgC7Hml9r4_W
X-Proofpoint-GUID: SrUKrMipqPqjI-PRW3fosgC7Hml9r4_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090132

The following changes since commit 2b94751626a6d49bbe42a19cc1503bd391016bd5:

  wifi: cw1200: Fix potential NULL dereference (2024-10-31 16:20:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20241209

for you to fetch changes up to da8656797ae10b524a7a0c3d5eeb6237fa3ddd70:

  wifi: ath12k: introduce mlo_capable flag for device group (2024-12-05 14:34:10 -0800)

----------------------------------------------------------------
ath.git patches for v6.14

This development cycle featured multiple patchsets to ath12k to
support the new 802.11be MLO feature, although the feature is still
incomplete. Also in ath12k, there were other feature patches.  In
ath11k, support was added for QCA6698AQ. And there was the usual set
of bug fixes and cleanups across most drivers, notable being the
addition of "noinline_for_stack" to some functions to avoid "stack
frame size" warnings when compiling with clang.

----------------------------------------------------------------
Aditya Kumar Singh (2):
      wifi: ath12k: ath12k_bss_assoc(): MLO support
      wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp

Balaji Pothunoori (2):
      wifi: ath11k: Suspend hardware before firmware mode off for WCN6750
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Downlink Pager Stats
      wifi: ath12k: Support phy counter and TPC stats
      wifi: ath12k: Support SoC Common Stats
      wifi: ath12k: Support Transmit PER Rate Stats

Dmitry Antipov (5):
      wifi: ath9k: miscellaneous spelling fixes
      wifi: ath11k: cleanup struct ath11k_vif
      wifi: ath11k: cleanup struct ath11k_reg_tpc_power_info
      wifi: ath11k: cleanup struct ath11k_mon_data
      wifi: ath11k: miscellaneous spelling fixes

Jeff Johnson (4):
      wifi: ath12k: mark QMI driver event helpers as noinline
      wifi: ath11k: mark some QMI driver event helpers as noinline
      wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as noinline
      wifi: ath11k: mark ath11k_wow_convert_8023_to_80211() as noinline

Kalle Valo (5):
      wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
      wifi: ath12k: introduce ath12k_hw_warn()
      wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work
      wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
      wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided link id

Karol Przybylski (1):
      wifi: ath12k: Fix for out-of bound access error

Karthikeyan Periyasamy (10):
      wifi: ath12k: Refactor core startup
      wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
      wifi: ath12k: add ath12k_get_num_hw()
      wifi: ath12k: introduce QMI firmware ready flag
      wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()
      wifi: ath12k: introduce device group abstraction
      wifi: ath12k: refactor core start based on hardware group
      wifi: ath12k: move struct ath12k_hw from per device to group
      wifi: ath12k: send QMI host capability after device group is ready
      wifi: ath12k: introduce mlo_capable flag for device group

Miaoqing Pan (1):
      wifi: ath11k: add support for QCA6698AQ

P Praneesh (1):
      wifi: ath12k: Fix endianness issue in struct hal_tlv_64_hdr

Rameshkumar Sundaram (4):
      wifi: ath12k: add reo queue lookup table for ML peers
      wifi: ath12k: modify chanctx iterators for MLO
      wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
      wifi: ath12k: defer vdev creation for MLO

Roopni Devanathan (1):
      wifi: ath12k: Fix inappropriate use of print_array_to_buf_index()

Sidhanta Sahu (1):
      wifi: ath12k: Support MBSSID Control Frame Stats

Sriram R (16):
      wifi: ath12k: MLO vdev bringup changes
      wifi: ath12k: Refactor sta state machine
      wifi: ath12k: Add helpers for multi link peer creation and deletion
      wifi: ath12k: add multi-link flag in peer create command
      wifi: ath12k: add helper to find multi-link station
      wifi: ath12k: Add MLO peer assoc command support
      wifi: ath12k: Add MLO station state change handling
      wifi: ath12k: support change_sta_links() mac80211 op
      wifi: ath12k: add primary link for data path operations
      wifi: ath12k: use arsta instead of sta
      wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
      wifi: ath12k: Use mac80211 sta's link_sta instead of deflink
      wifi: ath12k: ath12k_mac_op_tx(): MLO support
      wifi: ath12k: ath12k_mac_op_flush(): MLO support
      wifi: ath12k: ath12k_mac_op_ampdu_action(): MLO support
      wifi: ath12k: do not return invalid link id for scan link

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Add RX inactivity detection and reset chip when it occurs

 drivers/net/wireless/ath/ath11k/core.c             |  132 ++
 drivers/net/wireless/ath/ath11k/core.h             |    4 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    1 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   14 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    6 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    1 +
 drivers/net/wireless/ath/ath11k/mac.c              |    6 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    1 +
 drivers/net/wireless/ath/ath11k/pci.c              |    3 +
 drivers/net/wireless/ath/ath11k/pcic.c             |   13 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    8 +-
 drivers/net/wireless/ath/ath11k/wow.c              |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  482 ++++-
 drivers/net/wireless/ath/ath12k/core.h             |  134 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    5 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  681 ++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  218 ++-
 drivers/net/wireless/ath/ath12k/dp.c               |   70 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   96 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    6 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   12 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 2003 +++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |   16 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   10 +
 drivers/net/wireless/ath/ath12k/peer.c             |  223 ++-
 drivers/net/wireless/ath/ath12k/peer.h             |   23 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  167 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   20 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  207 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  115 ++
 drivers/net/wireless/ath/ath9k/antenna.c           |    2 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_mci.c        |    4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |    2 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    2 +
 drivers/net/wireless/ath/ath9k/channel.c           |    2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    1 +
 drivers/net/wireless/ath/ath9k/debug.h             |    1 +
 drivers/net/wireless/ath/ath9k/dfs.c               |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    2 +-
 drivers/net/wireless/ath/ath9k/hw.c                |    4 +-
 drivers/net/wireless/ath/ath9k/hw.h                |    2 +-
 drivers/net/wireless/ath/ath9k/link.c              |   33 +-
 drivers/net/wireless/ath/ath9k/mac.h               |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |    3 +-
 drivers/net/wireless/ath/ath9k/wow.c               |    6 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    5 +-
 54 files changed, 4042 insertions(+), 736 deletions(-)

