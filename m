Return-Path: <linux-wireless+bounces-19808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51EA50692
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DC3A6E43
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63C2505A3;
	Wed,  5 Mar 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxRii8EJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CF17B401
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196389; cv=none; b=jTvayDYh+DRTNuAnRKM0Yhswl14RKyHkvfueUaBCOJv/Mib+QiDDNXCZyDlwGJvSWfwDuchcnu6eRGYvSC5T0O1HXRkhfvcnbr6zrNsQgzXqR+XefjobbKTQ+iI6mLHphVnb4d46kZKEczrnRl7bm58mn1p/1sIRiHGYPzc3fAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196389; c=relaxed/simple;
	bh=IbJGM9Luzn2IbaUD7adD67xMxUcNd0Xq0y9tW2polO4=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=fjavBYq44f9PQ+n41vnJyoSs6igwyLhTIAlH42XR4i4Q5ozCD+NQvv90uMqq/A4iHtrxLCdNJtauJQxPyqCqhCweWJbBP5bWtN1AjY70mRY+dfufx+QGHzuzkGDyjvuTKHn7AFoQkLlCqRAVupt/RyHtwKtwbj5ZWxFLBTEBcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxRii8EJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525AuIYY025299
	for <linux-wireless@vger.kernel.org>; Wed, 5 Mar 2025 17:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cGIt4hQ8/FjHyi9qtjWxy0
	UB1GewtFV5N4FW9f4nxcU=; b=nxRii8EJ1eJb86NEzgHLw1wLjmrz2BIs3N9GCL
	0Piq3S2bAg2x45GRVlzhGenY8lXs4xRAAz7lfVdsRpaDF0FScjnEyAU4k7X8kJLM
	rp34S/VFZEQJbRcWBauiBeL0Ce9D/g19mRn/COd9m3ze3Bhm1iW8xicTnCFWmARF
	JrLrfD9dnIPzkddrquLz2wVlbG6j3o+zT+ESXnDIL28aTE3C1WiVzVej5fIUDKhf
	Zzuil8/ckv24VEB1n6coNDW8x8WEpMlWrL1snC0grncX+vCEIRNQCk4HlYKsdwsY
	8Y0EZG7Ls3OJYQm3s+g6nuyoRNTGuTNTOEX7fILEZ+Ocp2/g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p9365af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 17:39:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22334230880so96355785ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 09:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196385; x=1741801185;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cGIt4hQ8/FjHyi9qtjWxy0UB1GewtFV5N4FW9f4nxcU=;
        b=Ut7L9gbsJPaSb1HPvChJoUnt4MTSRnbLzKyP8R6wJ+HBXAqr+yV4WoxromTZ88e3u7
         zndJM18AQ7xNMrHFnD1ayNxGygOCfU86Is0WipyXAYfAJV7MvDAk3xslBRsITAKNnEpq
         CGU4yP9Pf4kgpwVAhueiFg6HhWGipGciQRC8HTnny/E8G8Y94j8ek3+y48+MsePUUatT
         7zHqg58cEufgI6MDl8Adihoq37JLkR8nOBQmzaoAnR+Hb/9ZDvq8DjmOQ/7irX6YzqNd
         dEFKA1TF8Yqhy945mqlinMsMv1fbI6kTF5FIqlEN55DvxhUQHRCRW0EytF1hsadTngjW
         mD8A==
X-Gm-Message-State: AOJu0YzqwxIHM0jqYSqfuAZbQyfQ/Bqb21lvxRqKN0x4X7YC3d3kHY+0
	+rg35cwG57zRrvgieBPuE93Ac2beRwE0lo7fqLJKKfTY1dC3/iVTyc1TiGfR94TVe+AxJ+l4cnv
	hoblx/hpdRO6w+EdINCc3dAuAQ+LZoQk+liiomkHlTmsi2vw2vgXK4AynqNWy34r0RKSaETDMcg
	==
X-Gm-Gg: ASbGncusW8FZz1Rm1BwXb8VON4uou5fhgh5VW0Cx0PgsKAIip/LAuBe/KFYPFVE19RT
	GPkZBsWcuMIxIb6pNvr7NoVCbFlWNBViwUmRsHgylfH0VOJUOIYm60KD6Cf7Doa3Mw58UTOQXmN
	qGQU3P6bgH4aDEVRz8AR0RsXLxokyJXAGhJSqyMbdy9vsJwDpD2+FqLtpCTWXEXcXi5Qw9sEaf5
	MifjEFlbMDTAJTYjTKtFvJegvc1rW6BShtGwf5pqYA97GtQH8MCALj91+qFmn/L0Ku3FLgxMVrg
	D9VMKnCJWz/lqtH0n98Zp8OYYQEUkgx82VkakyoA21qTXEqYUcdU
X-Received: by 2002:a17:903:2f90:b0:223:53f2:df0d with SMTP id d9443c01a7336-223f1b898b7mr65330905ad.0.1741196384599;
        Wed, 05 Mar 2025 09:39:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH69w1VlWC+cSwxs/9mPAnbBZCpfJL6S4wpU92o8KgJHTjuCjitqMfRJgv6FQxMxjo5xGxgYw==
X-Received: by 2002:a17:903:2f90:b0:223:53f2:df0d with SMTP id d9443c01a7336-223f1b898b7mr65330425ad.0.1741196384089;
        Wed, 05 Mar 2025 09:39:44 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f972esm116640355ad.58.2025.03.05.09.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:39:43 -0800 (PST)
Message-ID: <d01b1976-ebe8-48cd-8f49-32bfa00bed7e@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 09:39:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-next-20250305
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Me2Wu4/f c=1 sm=1 tr=0 ts=67c88c61 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=W93yEKBL2OK1zyp5blgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: JQaYLK3-chfEmiMyUXMRwsvPLDAEtTqT
X-Proofpoint-ORIG-GUID: JQaYLK3-chfEmiMyUXMRwsvPLDAEtTqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050135

The following changes since commit 68abd0c4ebf24cd499841a488b97a6873d5efabb:

  wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize() (2025-01-16 21:26:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250305

for you to fetch changes up to 9a0dddfb30f120db3851627935851d262e4e7acb:

  wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi (2025-02-28 11:53:14 -0800)

----------------------------------------------------------------
ath.git patches for v6.15

This development cycle again featured multiple patchsets to ath12k to
support the new 802.11be MLO feature. In addition, there was the usual
set of bug fixes and cleanups.

----------------------------------------------------------------
Aaradhana Sahu (8):
      wifi: ath: create common testmode_i.h file for ath drivers
      wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
      wifi: ath12k: add factory test mode support
      wifi: ath12k: Disable MLO in Factory Test Mode
      wifi: ath12k: Fetch regdb.bin file from board-2.bin
      wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
      wifi: ath12k: Remove dependency on single_chip_mlo_support for mlo_capable flag
      wifi: ath12k: Enable MLO for single split-phy PCI device

Aditya Kumar Singh (14):
      wifi: ath12k: update beacon template function to use arvif structure
      wifi: ath12k: fix handling of CSA offsets in beacon template command
      wifi: ath12k: update the latest CSA counter
      wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
      wifi: ath12k: relocate ath12k_mac_ieee80211_sta_bw_to_wmi()
      wifi: ath12k: handle ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
      wifi: ath12k: eliminate redundant debug mask check in ath12k_dbg()
      wifi: ath12k: introduce ath12k_generic_dbg()
      wifi: ath12k: remove redundant vif settings during link interface creation
      wifi: ath12k: remove redundant logic for initializing arvif
      wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
      wifi: ath12k: relocate a few functions in mac.c
      wifi: ath12k: allocate new links in change_vif_links()
      wifi: ath12k: handle link removal in change_vif_links()

Aloka Dixit (5):
      wifi: ath11k: refactor transmitted arvif retrieval
      wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: refactor transmitted arvif retrieval
      wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: pass BSSID index as input for EMA

Avula Sri Charan (1):
      wifi: ath12k: Avoid napi_sync() before napi_enable()

Balamurugan Mahalingam (4):
      wifi: ath12k: Add EHT MCS support in Extended Rx statistics
      wifi: ath12k: Refactor the format of peer rate table information
      wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
      wifi: ath12k: Add support for MLO Multicast handling in driver

Baochen Qiang (1):
      wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()

Bart Van Assche (1):
      wifi: ath12k: Fix locking in "QMI firmware ready" error paths

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Sounding Stats
      wifi: ath12k: Support Latency Stats
      wifi: ath12k: Support Uplink OFDMA Trigger Stats
      wifi: ath12k: Support Received FSE Stats

Dmitry Antipov (3):
      wifi: ath9k: cleanup struct ath_tx_control and ath_tx_prepare()
      wifi: ath9k: use unsigned long for activity check timestamp
      wifi: ath9k: do not submit zero bytes to the entropy pool

Ethan Carter Edwards (1):
      wifi: ath12k: cleanup ath12k_mac_mlo_ready()

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Karthikeyan Periyasamy (9):
      wifi: ath12k: Refactor the monitor Rx parser handler argument
      wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
      wifi: ath12k: Refactor Rx status TLV parsing procedure argument
      wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
      wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
      wifi: ath12k: Update the peer id in PPDU end user stats TLV
      wifi: ath12k: Add peer extended Rx statistics debugfs support

Krzysztof Kozlowski (5):
      dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties

Lingbo Kong (10):
      wifi: ath12k: report station mode transmit rate
      wifi: ath12k: report station mode receive rate for IEEE 802.11be
      wifi: ath12k: report station mode signal strength
      wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
      wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
      wifi: ath12k: Adjust the timing to access ACPI table
      wifi: ath12k: Add support for reading variant from ACPI to download board data file
      wifi: ath12k: Dump PDEV transmit rate HTT stats
      wifi: ath12k: Dump PDEV receive rate HTT stats
      wifi: ath12k: Dump additional PDEV receive rate HTT stats

Manish Dharanenthiran (1):
      wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi

Manivannan Sadhasivam (3):
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
      wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()

Miaoqing Pan (4):
      wifi: ath11k: fix memory leak in ath11k_xxx_remove()
      wifi: ath12k: fix memory leak in ath12k_pci_remove()
      wifi: ath11k: use union for vaddr and iaddr in target_mem_chunk
      wifi: ath11k: Add firmware coredump collection support

Nicolas Escande (5):
      wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx() error path
      wifi: ath11k: remove peer extra rssi update
      wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
      wifi: ath12k: add support of station average signal strength
      wifi: ath12k: Add missing htt_metadata flag in ath12k_dp_tx()

P Praneesh (19):
      wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
      wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation
      wifi: ath12k: Add HTT source ring ID for monitor rings
      wifi: ath12k: Enable filter config for monitor destination ring
      wifi: ath12k: Avoid multiple times configuring monitor filter
      wifi: ath12k: Avoid code duplication in monitor ring processing
      wifi: ath12k: Restructure the code for monitor ring processing
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
      wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
      wifi: ath12k: Add drop descriptor handling for monitor ring
      wifi: ath12k: Handle end reason for the monitor destination ring
      wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
      wifi: ath12k: Handle PPDU spread across multiple buffers
      wifi: ath12k: Avoid memory leak while enabling statistics
      wifi: ath12k: Handle monitor drop TLVs scenario
      wifi: ath12k: Enable monitor ring mask for QCN9274
      wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
      wifi: ath11k: fix RCU stall while reaping monitor destination ring
      wifi: ath12k: remove redundant declaration of ath12k_dp_rx_h_find_peer()

Ramasamy Kaliappan (1):
      wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix pdev lookup in WBM error processing

Ramya Gnanasekar (3):
      wifi: ath12k: Request vdev stats from firmware
      wifi: ath12k: Request beacon stats from firmware
      wifi: ath12k: Request pdev stats from firmware

Remi Pommarel (1):
      wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics

Roopni Devanathan (2):
      wifi: ath12k: Support Uplink MUMIMO Trigger Stats
      wifi: ath12k: Add NULL check to validate tpc_stats

Rosen Penev (1):
      wifi: ath9k: return by of_get_mac_address

Sathishkumar Muruganandam (1):
      wifi: ath12k: encode max Tx power in scan channel list command

Sowmiya Sree Elavalagan (2):
      wifi: ath12k: Add Support to Parse TPC Event from Firmware
      wifi: ath12k: Add Support to Calculate and Display TPC Values

Vinith Kumar R (1):
      wifi: ath12k: Report proper tx completion status to mac80211

Wen Gong (2):
      wifi: ath11k: update channel list in reg notifier instead reg worker
      wifi: ath11k: update channel list in worker when wait flag is set

Yu Zhang(Yuriy) (2):
      wifi: ath11k: add support for MU EDCA
      wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability

 .../bindings/net/wireless/qcom,ath10k.yaml         |   21 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |    9 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |    7 +
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |   13 +-
 drivers/net/wireless/ath/ath10k/core.c             |   13 +-
 drivers/net/wireless/ath/ath11k/Makefile           |    1 +
 drivers/net/wireless/ath/ath11k/ahb.c              |    4 +-
 drivers/net/wireless/ath/ath11k/core.c             |   11 +-
 drivers/net/wireless/ath/ath11k/core.h             |   13 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |   52 +
 drivers/net/wireless/ath/ath11k/coredump.h         |   79 ++
 drivers/net/wireless/ath/ath11k/dp.c               |   35 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  133 +-
 drivers/net/wireless/ath/ath11k/fw.c               |    3 +-
 drivers/net/wireless/ath/ath11k/hif.h              |    7 +
 drivers/net/wireless/ath/ath11k/mac.c              |  145 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    5 +
 drivers/net/wireless/ath/ath11k/mhi.h              |    1 +
 drivers/net/wireless/ath/ath11k/pci.c              |  195 ++-
 drivers/net/wireless/ath/ath11k/qmi.c              |   17 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |   10 +-
 drivers/net/wireless/ath/ath11k/reg.c              |  107 +-
 drivers/net/wireless/ath/ath11k/reg.h              |    3 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |   80 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   11 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   11 +-
 drivers/net/wireless/ath/ath12k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |  202 ++-
 drivers/net/wireless/ath/ath12k/acpi.h             |   40 +-
 drivers/net/wireless/ath/ath12k/core.c             |  103 +-
 drivers/net/wireless/ath/ath12k/core.h             |  139 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |   10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          | 1191 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/debugfs.h          |  115 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1238 ++++++++++++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  453 ++++++-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |  337 +++++
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |   24 +
 drivers/net/wireless/ath/ath12k/dp.c               |    5 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   82 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 1419 ++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h           |   11 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   66 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  253 +++-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    4 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    5 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |  442 +++++-
 drivers/net/wireless/ath/ath12k/hal_tx.h           |   10 +-
 drivers/net/wireless/ath/ath12k/hw.c               |    8 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  870 ++++++++----
 drivers/net/wireless/ath/ath12k/mac.h              |   10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   22 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   23 +-
 drivers/net/wireless/ath/ath12k/reg.h              |    5 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   12 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |  395 ++++++
 drivers/net/wireless/ath/ath12k/testmode.h         |   40 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 1176 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  290 +++-
 drivers/net/wireless/ath/ath12k/wow.c              |    3 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    3 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    4 +-
 drivers/net/wireless/ath/ath9k/init.c              |    4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    9 -
 drivers/net/wireless/ath/{ath11k => }/testmode_i.h |   54 +-
 68 files changed, 9006 insertions(+), 1080 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)

