Return-Path: <linux-wireless+bounces-23249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 925D8ABFF10
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 23:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A141BA301A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE771F099C;
	Wed, 21 May 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcKW2Jr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2F1624CE
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863805; cv=none; b=kQRPyuxX+JPOn5e5LbsVVxHpbdA2CZPh4LHryYI4Bic3uY3NNtYhU4ITq1ZW35xoM/u18bTS7TaNW0+Pfd4VIAGqqS8Bl/XljFxUcTICtadGt0ulWeS5ZfEMThGGKGaR0afFgeSU7ywPc0pP30/2b0h3kbnAc57irbeRfshqNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863805; c=relaxed/simple;
	bh=C/0iTakit05qniI5qZTk5MBmoAxKP1m/hij5XdxiYT8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=iOXNq58U7PjnfeKki7ArDP/aoPeQu0IVtXRh3aCIPCseyJo3/2joQPczb9CuhgYQq9bpiSZoRK9G0wac+CO7Gpx92vx6wYitf8vkvVc+8459aT+28A+qocNXMofFUSY6SdseYwieiQluJ/B+56hQOMM1dA6xMB4+YdEhnlohBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcKW2Jr0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHQauK013417
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r/3UXMfb2V9/v+GzxFHw9E
	85/8iy/iR2RpL42+vKz6w=; b=XcKW2Jr0btNQoXWXue/2dhDd30xmh5mJq2JwIF
	/bS/z0C6ntI0/frtZNc1MoP/eDEyTy4U8Ti9f4AhqRsXimecgdsaQeLZVN+lLKCN
	f8ykyOwfvzFytgPMbvaRYd87AV63fwRV7Vaf3L7sEHXMQlICttffqli+ZI8u4Oee
	otdy4dSMOuX/Gjq4b1oCMEEExlw2rfwhKkl0GhwvRto4nq83xKcdlHPJp1e3vj3T
	B+pIUV7Vs7as68VSd/vVjB3DMLDLudiq1MnY7f04DVmdYUrI+3Zbh/huyouTcHdQ
	ri7la+SQ7KAR1za9R/++HOL/7EFSfLOR33AHSbTRHwgtZc7A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh5ccav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:43:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30e74ee960aso5724060a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 14:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747863801; x=1748468601;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r/3UXMfb2V9/v+GzxFHw9E85/8iy/iR2RpL42+vKz6w=;
        b=hCb367bJWqHXhv3nCh3WljZB7w5X+Qu6oy0BF9ZLT2ntILdFyWkeNvCy3ei2MUvy9i
         d+iNApw9ZIvNAkvpmyBJGReKGCJwRJiMwIrIYlLxd5Q6rIZ2FweQZXtYyjsMAIf2b9If
         stS9dlvkpDRaFHqHHeyN7wRWlm3l+VRZc+cU5VXDanKH9HlhyMc0jxbOFxyobn1rV+CO
         sHjETlyNc+y3mzJlh/+06soymgmWPxvgXAn+G8uWc7rR3h3bSPj8VQMKUTSTLEMubxbD
         raarJx/Ve3lt4x0ofY9yNHAAY5G8y3rf3qfypxKGyzpxZSGeNm4AIjaJv7b3Co2IlnfT
         hQkw==
X-Gm-Message-State: AOJu0Yz0sKc8ll3TEx47yFJDXzDf0CHrt6BHsmXT0biOy3h7ocHIjaQM
	6sj5t8muzm66v7TQk98nHhvAKgbRNVu5p1jU5zsY73mC4E1B8PhK+cSsr1V49ByVdawkxOr+XgS
	rlDrAgGKU15k4UOPeIHvJn/17zdJN9qgmJBx2MrfogETa1tWxttxQf5c13AIchFj9+J8rTRUDWp
	6h9Q==
X-Gm-Gg: ASbGnctIQMkmrLfRhsXLPx/taygtEYsjrvK0SNONo8qWMplpxHLn3ZRRUuDemMKMSG6
	GAQkIHugXe6zKPT5H/Z9beIMkiBojFIvySt5UjZCLEFePdr40KR9jWNh9nytFgIg9t4oZqiPZAl
	lvHfBjOP/DD5MVQV/9qYn2f+7ZZ8AWnMSlabJ6s4Oc7P9l0BJbudkCvvaxcotOE0iwN9v1J6dPe
	RLhk3QTu4tybuKG1rHkju7kYpd3Ep+wQH1DzqG3GGTMCpZoZb5b7uAqxajoOehFXvFGhIrQcFEd
	XRjAQVb3p+ANzgRf63wwtbfhxJeqsEMJi9FZkrwUq++9Tp5T
X-Received: by 2002:a17:90b:1946:b0:310:c609:5d1a with SMTP id 98e67ed59e1d1-310c609663bmr916782a91.14.1747863801113;
        Wed, 21 May 2025 14:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICPvVoHfG5rjo9uhkVj1agHjn28ykLeVhDszBE75AMJNR7yPFf8HzY23pfsdGzpp2iPLMdg==
X-Received: by 2002:a17:90b:1946:b0:310:c609:5d1a with SMTP id 98e67ed59e1d1-310c609663bmr916745a91.14.1747863800540;
        Wed, 21 May 2025 14:43:20 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365134e5sm4142241a91.42.2025.05.21.14.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 14:43:20 -0700 (PDT)
Message-ID: <8fdeef8c-b2ea-4f1c-8eb3-e600e5140f24@oss.qualcomm.com>
Date: Wed, 21 May 2025 14:43:19 -0700
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
Subject: pull-request: ath-next-20250521
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIxNSBTYWx0ZWRfX4JcXt0jb6BFi
 DC+CvD142garAcB3z7akz/PZqjdZL9XUcexb9bYHsToh6lSMtP1pD3HN3zPugEzh46c99Wiez1j
 V66ixETUPYmnUJXpvegV6NqI7VpROwE+JojffNcjsjJul1fAdPRvmKUBso4JvbxWxWJZl5EgNYq
 bGuXy1evo8Z3w0htxZx0E9gZ8hdXUlEqtEyLP0IcPoFBO/VwJL6o88kpdxPBHUt+yt1WGuzzFgr
 +vSLAthTHT/nXoELbK5DO3kb5zO+ALtlT2dLevl7QoKFNJCrUgOBC9ixGamg4lpec/Zb1nmcO1S
 uEpYqgBouD04XbermvbcWKvyYr/IQbK1JyWDBbcGtf2B7W9j3jxcgUHc1XtxgKN+gXP8cmQdABi
 gCdtewars9Pihu1hBFMsZ0J09b7t9qrhJg8tmLdlND4TZvpDUm+GLSAH+y2zbDTrX3AK8wtr
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682e48fa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=FKcf5NbGizdFyegkQZ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: me5V7gfRMhJTHflmEB9fU-DmGPNUjt8L
X-Proofpoint-ORIG-GUID: me5V7gfRMhJTHflmEB9fU-DmGPNUjt8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210215

The following changes since commit 68b44b05f4c880c42109a91d2e0e7faa94f40529:

  wifi: mac80211: handle non-MLO mode as well in ieee80211_num_beaconing_links() (2025-05-16 10:51:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250521

for you to fetch changes up to 886bb3624e4c9914a943b63fcfdf30b8d2f2b66e:

  wifi: ath12k: fix regdomain update failure when connection establishes (2025-05-21 14:01:06 -0700)

----------------------------------------------------------------
ath.git patches for v6.16

ath12k:
Add monitor mode support for WCN7850.
Enhance regulatory support including 6 GHz power modes.

In addition, perform the usual set of bug fixes and cleanups across
all supported drivers.

----------------------------------------------------------------
Aditya Kumar Singh (3):
      wifi: ath12k: handle scan link during vdev create
      wifi: ath12k: Use scan link ID 15 for all scan operations
      wifi: ath12k: fix mac pdev frequency range update

Aishwarya R (1):
      wifi: ath12k: remove redundant regulatory rules intersection logic in host

Aloka Dixit (1):
      wifi: ath12k: pass link_conf for tx_arvif retrieval

Baochen Qiang (18):
      wifi: ath12k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: refactor ath12k_reg_chan_list_event()
      wifi: ath12k: refactor ath12k_reg_build_regd()
      wifi: ath12k: add support to select 6 GHz regulatory type
      wifi: ath12k: move reg info handling outside
      wifi: ath12k: store reg info for later use
      wifi: ath12k: determine interface mode in _op_add_interface()
      wifi: ath12k: update regulatory rules when interface added
      wifi: ath12k: update regulatory rules when connection established
      wifi: ath12k: save power spectral density(PSD) of regulatory rule
      wifi: ath12k: add parse of transmit power envelope element
      wifi: ath12k: save max transmit power in vdev start response event from firmware
      wifi: ath12k: fill parameters for vdev set TPC power WMI command
      wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
      wifi: ath12k: fix regdomain update failure after 11D scan completes
      wifi: ath12k: fix regdomain update failure when adding interface
      wifi: ath12k: fix regdomain update failure when connection establishes

Christophe JAILLET (1):
      wifi: ath10k: Constify structures in hw.c

Colin Ian King (1):
      wifi: ath10k: Fix spelling mistake "comple" -> "complete"

Dinesh Karthikeyan (1):
      wifi: ath12k: Add support to simulate firmware crash

Johan Hovold (3):
      wifi: ath11k: fix ring-buffer corruption
      wifi: ath11k: fix rx completion meta data corruption
      wifi: ath12k: fix ring-buffer corruption

Kang Yang (14):
      wifi: ath12k: delete mon reap timer
      wifi: ath12k: parse msdu_end tlv in ath12k_dp_mon_rx_parse_status_tlv()
      wifi: ath12k: avoid call ath12k_dp_mon_parse_rx_dest_tlv() for WCN7850
      wifi: ath12k: add srng config template for mon status ring
      wifi: ath12k: add ring config for monitor mode on WCN7850
      wifi: ath12k: add interrupt configuration for mon status ring
      wifi: ath12k: add monitor mode handler by monitor status ring interrupt
      wifi: ath12k: add support to reap and process monitor status ring
      wifi: ath12k: fix macro definition HAL_RX_MSDU_PKT_LENGTH_GET
      wifi: ath12k: use ath12k_buffer_addr in ath12k_dp_rx_link_desc_return()
      wifi: ath12k: add support to reap and process mon dest ring
      wifi: ath12k: init monitor parameters for WCN7850
      wifi: ath12k: use different packet offset for WCN7850
      wifi: ath12k: enable monitor mode for WCN7850

Lingbo Kong (1):
      wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion

Miaoqing Pan (2):
      dt-bindings: net: wireless: ath12k: describe firmware-name property
      wifi: ath12k: support usercase-specific firmware overrides

Mohan Kumar G (1):
      wifi: ath12k: Send MCS15 support to firmware during peer assoc

Muhammad Usama Anjum (1):
      wifi: ath11k: Fix QMI memory reuse logic

Muna Sinada (1):
      wifi: ath12k: Prevent multicast duplication for dynamic VLAN

P Praneesh (2):
      wifi: ath12k: Fix invalid RSSI values in station dump
      wifi: ath12k: fix memory leak in WMI firmware stats

Rajat Soni (1):
      wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Ramasamy Kaliappan (1):
      wifi: ath12k: update EMLSR capabilities of ML Station

Rosen Penev (1):
      wifi: ath9k: ahb: do ioremap resource in one step

Thiraviyam Mariyappan (1):
      wifi: ath12k: Enable AST index based address search in Station Mode

Toke Høiland-Jørgensen (1):
      wifi: ath9k_htc: Abort software beacon handling if disabled

Vignesh C (1):
      wifi: ath12k: Fix scan initiation failure handling

Vinith Kumar R (3):
      wifi: ath12k: change soc name to device name
      wifi: ath12k: Add device dp stats support
      wifi: ath12k: print device dp stats in debugfs

Wen Gong (1):
      wifi: ath12k: read country code from SMBIOS for WCN7850

Yingying Tang (2):
      wifi: ath12k: Reorder and relocate the release of resources in ath12k_core_deinit()
      wifi: ath12k: Adjust the process of resource release for ahb bus

Yu Zhang(Yuriy) (1):
      wifi: ath11k: support DBS and DFS compatibility

Yury Norov (1):
      wifi: carl9170: micro-optimize carl9170_tx_shift_bm()

 .../bindings/net/wireless/qcom,ath12k.yaml         |   6 +
 drivers/net/wireless/ath/ath10k/ce.c               |  28 +-
 drivers/net/wireless/ath/ath10k/hw.c               |  62 +-
 drivers/net/wireless/ath/ath10k/hw.h               |  34 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |   2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |  11 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  25 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  42 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   9 +
 drivers/net/wireless/ath/ath12k/ahb.c              |   5 +-
 drivers/net/wireless/ath/ath12k/ce.c               |  11 +-
 drivers/net/wireless/ath/ath12k/core.c             |  37 +-
 drivers/net/wireless/ath/ath12k/core.h             |  72 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          | 263 +++++++
 drivers/net/wireless/ath/ath12k/debugfs.h          |   5 +
 drivers/net/wireless/ath/ath12k/dp.c               |  66 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  28 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 816 +++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/dp_mon.h           |   3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 172 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h            |  10 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  66 +-
 drivers/net/wireless/ath/ath12k/hal.c              |  42 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   4 +
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   7 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           | 102 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |  12 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  12 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   1 +
 drivers/net/wireless/ath/ath12k/mac.c              | 674 ++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h              |  43 ++
 drivers/net/wireless/ath/ath12k/pci.c              |   8 +-
 drivers/net/wireless/ath/ath12k/reg.c              | 407 +++++-----
 drivers/net/wireless/ath/ath12k/reg.h              |  18 +-
 drivers/net/wireless/ath/ath12k/wmi.c              | 231 +++---
 drivers/net/wireless/ath/ath12k/wmi.h              |  64 ++
 drivers/net/wireless/ath/ath9k/ahb.c               |  13 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |   3 +
 drivers/net/wireless/ath/carl9170/tx.c             |   3 +-
 40 files changed, 2751 insertions(+), 670 deletions(-)

