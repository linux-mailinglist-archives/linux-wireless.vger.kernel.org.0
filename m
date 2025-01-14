Return-Path: <linux-wireless+bounces-17514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3DA113F0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 23:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1012B3A407D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EC19007E;
	Tue, 14 Jan 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAlNg6DG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE994644E
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893032; cv=none; b=ic0GSoW/lBe5AAoRHAxClYvyjH0ioILJUq4BWPw59+nE5x+3WLv/rNA7pZTzRI4GN/S28LWRYOkHNifzRCr2nOLAIHdBm9miw6PEsFU2e3tASGynBKGYbDRbRbTSOF0VcDIYWfC/QoqL+xpZKoozt8zqmpJqtWhl5/ASkfGmP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893032; c=relaxed/simple;
	bh=ONsCDJD32bM0wVSRrWAecj+R8bB4EFQT+YMgf3YUDEc=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=EkwEFYxugC6GCs6saMkBtwDTmi4sfmgBO5+juBS+Pi2iBlDw7AyiuJCGwr3iohPIkGBLVrt9mNDhYzFyDxOiOHdx0tTIrNiD2Zkh2YFGyGpUKsVRce2XXdB/5uXpOQpiRBYdp8fhfHzfk04iX7azdR+fOBlLyWfIPBbrNM7MMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAlNg6DG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EGjpOr024804
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1RHWBdNZUnUTK4wDA9eiUV
	BPsy9tVBsZ54RGxAuJwR8=; b=TAlNg6DGJQZ07Bk6SnMVblHeH4jjyDQq8g/EJ4
	isKQzuSW2Wz9mx2WGgnlscFJ7pHLeed19YBgXXnKv6DCDgaWcXd7aoPOxnJGAplY
	aIU28t6Ybjiprtfbf6F8OnSeAiKsHgNkVYS2qhfFECR4f4Si3r7K7zh8y8ZtbCuM
	HqPwi1Y9IcNOteKVwRDkznIy/UQxUpe8+GZ5FtJsn3aZoFfhrNy3LsSpxoyyRhAW
	fCDimQiqJ9jM2RpmrtyPh+wBwgZANN6DP4Vfygsc3lSKKHv5vU3+4URz7Xj9Aejn
	bT/2FjQQB2846795WIZa2j3tzhSRJpqPhlFoyc5Lr2vHSEAg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445uqs0pxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:17:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2162f80040aso98959435ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 14:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736893028; x=1737497828;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1RHWBdNZUnUTK4wDA9eiUVBPsy9tVBsZ54RGxAuJwR8=;
        b=kNb7WTLPprbkKOg4RVHRD7GDqGRZzWDhjqO/5WpBRKb5ox3/TZ3hZeLfgctCuD3Tiu
         LMOyT1FobO7ckyv/w6/pJl8baDSsXNXDobrVTEOObBw90Ech4la3/ujjPNeGo5WnfFWt
         5E9gf8j201fqdCnb06mxnEJncUVVHz4hZpZAXETgA9waxl66GzKLmigWkvcMDkz2UsoR
         okMY7Fdxx5dEzEM0VGY+2TvjzBdFq/tICNYIneDV7b1Pim+6pjpDMLDeviH1tCzz2CCi
         HbEyFYHFv7bg19lq76oWjf/R9gZkNixfxB3wUFGzPy6lP94IBosIm01iWm/5INQTkSUD
         iutg==
X-Gm-Message-State: AOJu0YwIdpjDw8xnObEQ58VwcER7SlgMQX8vCWTlUPqHQ5pt+MoiCSck
	TqytDRbyCDSQvmmHzS7sNCfSqI8e6+Whr1CQRpISICVWzcIO3VizJp60ZBGNQkjwPkfPq6sIMgq
	vq2l7Qt3O3+SY34j8PMvUujOfzlU5kQBJ2p39+fCx0g9cpePJSpONVZR9vPtq2WHnkITLr0jIIg
	==
X-Gm-Gg: ASbGncvbCm7syFBPSuBnGtjlHW5kExv74durXW5VwshVZMoNX5EbooH5qXbNbEyTe/I
	cruxUwP40VvMCp0GaikSAHshn2tKIxkTPw38iyq/KF1R22kYTkfYGUZ4AEGY8a0spRIYKFHY5XE
	rc7eUE8VOz06bq94pS5ZuGl2zHfZa8uP2lPkr+vUYmr3Eo8/KDnKsKGzAST/1ETechKMZE6kRiu
	NBNDev4b/KzUj6tjAskowyOD+ncN9RRxqggrWncRe+GUirifuWus3kd+HKbzAlQhkhlnRUOGEEq
	dMd60tHXjQhyggodxg==
X-Received: by 2002:a05:6a21:7905:b0:1e8:a13b:3885 with SMTP id adf61e73a8af0-1e8a14a7cbemr35716816637.35.1736893028344;
        Tue, 14 Jan 2025 14:17:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbyluAjpJq8odQjUMCSxIVZNb9qWFEI4mQubixdyHIOpCN5uYWi2rRp/hKmkz0FiRHZYYYGg==
X-Received: by 2002:a05:6a21:7905:b0:1e8:a13b:3885 with SMTP id adf61e73a8af0-1e8a14a7cbemr35716785637.35.1736893027891;
        Tue, 14 Jan 2025 14:17:07 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a862a22fee0sm1473537a12.13.2025.01.14.14.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 14:17:07 -0800 (PST)
Message-ID: <b03d2e2c-3f11-427d-a156-eaa0be48078c@oss.qualcomm.com>
Date: Tue, 14 Jan 2025 14:17:06 -0800
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
Subject: pull-request: ath-next-20250114
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kg3_54mhz_Taxt5xADnbNA7sCiiEJ9QI
X-Proofpoint-ORIG-GUID: kg3_54mhz_Taxt5xADnbNA7sCiiEJ9QI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140168

The following changes since commit b20821248e262a7d16882137419460030c1aead6:

  Merge tag 'ath-next-20241209' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2024-12-09 20:41:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20250114

for you to fetch changes up to 336097d74c284a7c928b723ce8690f28912da03d:

  wifi: ath12k: fix key cache handling (2025-01-14 12:53:01 -0800)

----------------------------------------------------------------
ath.git patches for v6.14

This development cycle again featured multiple patchsets to ath12k to
support the new 802.11be MLO feature, this time including the device
grouping infrastructure, and the advertisement of MLO support to the
wireless core. However the MLO feature is still considered to be
incomplete.

In addition, there was the usual set of bug fixes and cleanups, mostly
in ath12k, but also in ath9k.

----------------------------------------------------------------
Aditya Kumar Singh (14):
      wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
      wifi: ath12k: fix ath12k_qmi_alloc_chunk() to handle too large allocations
      wifi: ath12k: fix ar->supports_6ghz usage during hw register
      wifi: ath12k: pass link ID during MLO while delivering skb
      wifi: ath12k: symmetrize scan vdev creation and deletion during HW scan
      wifi: ath12k: add can_activate_links mac operation
      wifi: ath12k: add no-op without debug print in WMI Rx event
      wifi: ath12k: remove warning print in htt mlo offset event message
      wifi: ath12k: add ATH12K_FW_FEATURE_MLO capability firmware feature
      wifi: ath12k: assign unique hardware link IDs during QMI host cap
      wifi: ath12k: rename CAC_RUNNING flag
      wifi: ath12k: fix CAC running state during virtual interface start
      wifi: ath12k: handle radar detection with MLO
      wifi: ath12k: fix key cache handling

Baochen Qiang (1):
      wifi: ath12k: fix leaking michael_mic for non-primary links

Bhagavathi Perumal S (1):
      wifi: ath12k: Add MLO WMI setup and teardown functions

Colin Ian King (1):
      wifi: ath12k: Fix spelling mistake "requestted" -> "requested"

Dan Carpenter (1):
      wifi: ath12k: Off by one in ath12k_wmi_process_csa_switch_count_event()

Dmitry Antipov (4):
      wifi: ath9k: cleanup ath_txq_skb_done()
      wifi: ath9k: cleanup a few (mostly) TX-related routines
      wifi: ath9k: simplify internal time management
      wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()

Jeff Johnson (4):
      wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
      wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
      wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
      wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage

Karthikeyan Periyasamy (23):
      wifi: ath12k: send partner device details in QMI MLO capability
      wifi: ath12k: refactor ath12k_qmi_alloc_target_mem_chunk()
      wifi: ath12k: add support to allocate MLO global memory region
      wifi: ath12k: enable MLO setup and teardown from core
      wifi: ath12k: avoid redundant code in DP Rx error process
      wifi: ath12k: move to HW link id based receive handling
      wifi: ath12k: add partner device buffer support in receive data path
      wifi: ath12k: add helper function to init partner cmem configuration
      wifi: ath12k: introduce interface combination cleanup helper
      wifi: ath12k: Refactor radio frequency information
      wifi: ath12k: advertise multi device interface combination
      wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
      wifi: ath12k: Refactor monitor status TLV structure
      wifi: ath12k: cleanup Rx peer statistics structure
      wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
      wifi: ath12k: fix incorrect TID updation in DP monitor status path
      wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
      wifi: ath12k: Change the Tx monitor SRNG ring ID
      wifi: ath12k: Avoid explicit type cast in monitor status parse handler
      wifi: ath12k: Refactor ath12k_hw set helper function argument
      wifi: ath12k: Refactor the ath12k_hw get helper function argument
      wifi: ath12k: Remove ath12k_get_num_hw() helper function
      wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function

P Praneesh (1):
      wifi: ath12k: Add support for parsing 64-bit TLVs

Pradeep Kumar Chitrapu (2):
      wifi: ath12k: Support Transmit Rate Buffer Stats
      wifi: ath12k: Support Transmit Buffer OFDMA Stats

Raj Kumar Bhagat (3):
      dt-bindings: net: wireless: Describe ath12k PCI module with WSI
      wifi: ath12k: parse multiple device information from Device Tree
      wifi: ath12k: Include MLO memory in firmware coredump collection

Rajat Soni (1):
      wifi: ath12k: Support pdev Puncture Stats

Rameshkumar Sundaram (1):
      wifi: ath12k: advertise MLO support and capabilities

Ramya Gnanasekar (1):
      wifi: ath12k: set flag for mgmt no-ack frames in Tx completion

Roopni Devanathan (1):
      wifi: ath12k: Support AST Entry Stats

Sathishkumar Muruganandam (1):
      wifi: ath12k: fix tx power, max reg power update to firmware

 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     | 204 ++++++
 drivers/net/wireless/ath/ath12k/core.c             | 315 +++++++-
 drivers/net/wireless/ath/ath12k/core.h             |  63 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |   3 +
 drivers/net/wireless/ath/ath12k/coredump.h         |   1 +
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 502 +++++++++++++
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    | 155 ++++
 drivers/net/wireless/ath/ath12k/dp.c               |  14 +
 drivers/net/wireless/ath/ath12k/dp.h               |  30 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           | 156 ++--
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 231 ++++--
 drivers/net/wireless/ath/ath12k/fw.h               |   3 +
 drivers/net/wireless/ath/ath12k/hal.c              |   2 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   4 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |  14 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 794 ++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |  11 +
 drivers/net/wireless/ath/ath12k/peer.c             |   2 +
 drivers/net/wireless/ath/ath12k/peer.h             |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c              | 324 +++++++--
 drivers/net/wireless/ath/ath12k/qmi.h              |   1 +
 drivers/net/wireless/ath/ath12k/wmi.c              | 225 +++++-
 drivers/net/wireless/ath/ath12k/wmi.h              |  56 ++
 drivers/net/wireless/ath/ath9k/ath9k.h             |   8 +-
 drivers/net/wireless/ath/ath9k/beacon.c            |   2 +-
 drivers/net/wireless/ath/ath9k/calib.c             |  24 +-
 drivers/net/wireless/ath/ath9k/channel.c           |  29 +-
 drivers/net/wireless/ath/ath9k/hw.c                |  25 +-
 drivers/net/wireless/ath/ath9k/hw.h                |   2 +-
 drivers/net/wireless/ath/ath9k/main.c              |   9 +-
 drivers/net/wireless/ath/ath9k/recv.c              |   4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |  52 +-
 33 files changed, 2723 insertions(+), 547 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml

