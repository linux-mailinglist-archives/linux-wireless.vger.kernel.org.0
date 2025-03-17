Return-Path: <linux-wireless+bounces-20461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A06A65F78
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 21:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C709189ECCB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B121B0434;
	Mon, 17 Mar 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OX2n7+nS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2857E9;
	Mon, 17 Mar 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244453; cv=none; b=WipX5nGdUwLYZAm87T9Gtoq83VaPkVj9Rq23ybQ/bN3TpJ1lOhnWoM4MBryqm+Dcw6IDsdke8/nQ6ALTNanYohcC8KXn/OcRpkXrX/BUtxL+/dEn6O6PL4cwlcsut21iwe43L2dvklzNggcgkG6DiU4KyfkXRKJcunNXvhZ6u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244453; c=relaxed/simple;
	bh=b/kT5+frsFPpZ6i4jP+FkiD5AWLdARFriqqiGRjAaAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9lKYlbvjnnrJzG7ZSuSInqaLXNTVSaDqfgba+LQ1CIXc2gf9eXqx0lhHB+ZGB2/DHiCA08D8XivlA/vknW4raS/41WL1RDeWEEzfWqC+k2qzlR/3tYAWK3KgQWhsOSWoA8kFuqEoruqklx63JpGmlL8+MK6wEGCq8V/EKUXws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OX2n7+nS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKPF4D000404;
	Mon, 17 Mar 2025 20:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qHFMSF2J0hoO8CX7rduNt5
	R7fNPutEv2J045HaeLztQ=; b=OX2n7+nS/5iU7IRk06n1MxuD2slDcdhlnlVWPw
	pUMePqya4OfvsnKFdWIohyPZocvsWCuk2L/oWLJK6ItGyjeu/xfq1vpTD/SaPdUw
	lu8S0EFsTc4O2omy22GMPpBCretOENKUGIxSvgyAEeJGBhEwZOeY/pR4JIdwYeFj
	GV5VaV4wLaTdVTwHXGRTL0ZwZClRdSlRt5niqXCFYn73c7d+JqjUD2XwFjzFA/0e
	KCdJ2Auv6KviAElzeKLX0TE2WvdvH/spC3akzvOquWQ4yQdIGG9/QNmSMCkWizMK
	mzeJlMSsCHYpJoRGyyEkifsWajbdNXgkASr1l7rk8Al4x8VQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1x7ww31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 20:47:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52HKlKFi016252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 20:47:20 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Mar 2025 13:47:17 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Raj Kumar
 Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH ath-next v11 00/13] wifi: ath12k: add Ath12k AHB driver support for IPQ5332
Date: Tue, 18 Mar 2025 02:16:26 +0530
Message-ID: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hAXf2oedASGYz8_Huttswqq5D6pnTpEd
X-Proofpoint-ORIG-GUID: hAXf2oedASGYz8_Huttswqq5D6pnTpEd
X-Authority-Analysis: v=2.4 cv=Jem8rVKV c=1 sm=1 tr=0 ts=67d88a59 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=esBEnaimTLd1uYCVZSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170150

Currently, Ath12k driver only supports WiFi devices that are based on
PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
Ath12k AHB support for IPQ5332.

IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
device:
- Add hardware parameters for IPQ5332.
- CE register address space in IPQ5332 is separate from WCSS register
  space. Hence, add logic to remap CE register address.
- Add support for fixed QMI firmware memory for IPQ5332.
- Support userPD handling for WCSS secure PIL driver to enable ath12k
  AHB support.

NOTE:
The working upstream DTS changes for this series have been posted as a
separate series.
[PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based RDP441

v11:
- Updated Kconfig for ATH12k AHB.
- Replaced the API devm_ioremap_wc() with devm_memremap to fix ath12k-check
  warning: "warning: cast removes address space '__iomem' of expression"
- Rebased on latest ToT.
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [11/13] wifi: ath12k: Power up userPD

v10: https://lore.kernel.org/all/20250317154150.1361364-1-quic_rajkbhag@quicinc.com/
- Removed config dependency of QCOM_Q6V5_WCSS_SEC for Ath12k AHB.
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [13/13] wifi: ath12k: enable ath12k AHB support

v9: https://lore.kernel.org/all/20250305185501.2400888-1-quic_rajkbhag@quicinc.com/
- Fixed memory leak in ath12k_ahb_probe().
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [08/13] wifi: ath12k: add AHB driver support for IPQ5332

v8: https://lore.kernel.org/all/20250228184214.337119-1-quic_rajkbhag@quicinc.com/
- Fixed format specifiers warning reported by kernel test robot in patch
  [PATCH v6 07/13] wifi: ath12k: add support for fixed QMI firmware memory

v7: https://lore.kernel.org/all/20250227191034.1949954-1-quic_rajkbhag@quicinc.com/
- DT binding: DT property 'qcom,ath12k-calibration-variant' renamed to
  'qcom,calibration-variant'.

v6: https://lore.kernel.org/all/20250225064834.2002499-1-quic_rajkbhag@quicinc.com/
- DT binding: binding doc renamed from qcom,ath12k-ahb.yaml to
  qcom,ipq5332-wifi.yaml.
- DT binding: rephrased memory-region description.
- DT binding: dropped description for memory-region-names.
- DT binding: updated maintainers in binding doc.
- The API ath12k_core_get_reserved_mem_by_name() has been simplified and
  renamed to ath12k_core_get_reserved_mem()
- Removed unnecessary NULL check in devm_clk_get() error handling.
- Dropped all ath12k_ahb_clock_* wrappers for single clock.
- Removed shutdown callback for the ath12k AHB driver.
- Reference count leak handled for rproc and rproc phandle.

v5: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/
- DT binding: Added `memory-region-names` property to address undocumented
  ABIs.
- DT binding: Added four complete items to `memory-region`, required by
  ath12k firmware.
- All calls to `of_find_node_by_name()` are removed. Introduced helper
  function `ath12k_core_get_reserved_mem_by_name()` to get the reserved
  memory by name.
- Removed unused include headers.
- Removed error prints for impossible scenarios.
- Used proper phandle API `of_parse_phandle()` to read `qcom,rproc`.
- Used `dev_err_probe()` API for logging errors wherever applicable.
- Changed hardware parameter `needs_m3_fw` to `enum ath12k_m3_fw_loaders`.
- Changed hardware parameter `bdf_addr` to `bdf_addr_offset` to store the
  offset for BDF memory from the q6-memory as base.

v4: https://lore.kernel.org/all/20241210074159.2637933-1-quic_rajkbhag@quicinc.com/
- Missed to include some review list in v3. Hence sending v4 with
  all review list as per - scripts/get_maintainers.pl

v3: https://lore.kernel.org/all/20241209165644.1680167-1-quic_rajkbhag@quicinc.com/
- DT binding: clock name changed from gcc_xo_clk to xo.
- DT binding: Upper constraint added for memory-region property.
- DT binding: The description for "qcom,rproc" phandle updated to represent
  the hardware aspect.
- DT binding: Added property qcom,ath12k-calibration-variant.
- Squashed patch[2/22] to patch[8/22] of v2 into a single patch.
- Patch reordering is done.
- The hardware parameter "m3_fw_support" renamed to "needs_m3_fw".
- CMEM remap and CMEM register handling are dropped. CMEM registers are
  accessed within WCSS register space (ab->mem).
- The devm APIs are used for interrupts handling.
- Logic updated in ath12k_ahb_map_service_to_pipe().
- Dependency path series from other subsystem are dropped.

v2: https://lore.kernel.org/all/20241015182637.955753-1-quic_rajkbhag@quicinc.com/
- "qcom,board_id" property is dropped. This is not the direct dependency
  for Ath12k AHB support, hence it can be taken up separately.
- "qcom,bdf-addr" property is dropped in device-tree and moved to ath12k
  driver.
- Currently we have only one compatible enum (qcom,ipq5332-wifi), hence
  conditional if() check for defining the binding is removed.
- "reserved-memory" node is dropped from example DTS.
- "status" property is dropped in wifi node of example DTS.
- Integrated the “Support userPD handling for WCSS secure PIL driver”
  patch series with the Ath12k AHB bring-up patch.
- Removed the RFC tag as all dependency patch series are now compilable.

v1: https://lore.kernel.org/all/20240814094323.3927603-1-quic_rajkbhag@quicinc.com/

Balamurugan S (6):
  wifi: ath12k: fix incorrect CE addresses
  wifi: ath12k: add ath12k_hw_params for IPQ5332
  wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
  wifi: ath12k: Add hw_params to remap CE register space for IPQ5332
  wifi: ath12k: add AHB driver support for IPQ5332
  wifi: ath12k: enable ath12k AHB support

P Praneesh (1):
  wifi: ath12k: refactor ath12k_hw_regs structure

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
  wifi: ath12k: add support for fixed QMI firmware memory

Sowmiya Sree Elavalagan (4):
  wifi: ath12k: Power up root PD
  wifi: ath12k: Register various userPD interrupts and save SMEM entries
  wifi: ath12k: Power up userPD
  wifi: ath12k: Power down userPD

 .../net/wireless/qcom,ipq5332-wifi.yaml       |  315 +++++
 drivers/net/wireless/ath/ath12k/Kconfig       |    8 +
 drivers/net/wireless/ath/ath12k/Makefile      |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c         | 1156 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h         |   80 ++
 drivers/net/wireless/ath/ath12k/ce.c          |   92 +-
 drivers/net/wireless/ath/ath12k/ce.h          |   18 +-
 drivers/net/wireless/ath/ath12k/core.c        |   60 +-
 drivers/net/wireless/ath/ath12k/core.h        |   14 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   84 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   68 +-
 drivers/net/wireless/ath/ath12k/hw.c          |  479 ++++++-
 drivers/net/wireless/ath/ath12k/hw.h          |   22 +-
 drivers/net/wireless/ath/ath12k/pci.c         |   10 +-
 drivers/net/wireless/ath/ath12k/pci.h         |    4 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |  210 ++-
 drivers/net/wireless/ath/ath12k/qmi.h         |    3 +-
 17 files changed, 2507 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h


base-commit: 7fd16d1de09e014b2419ddd1b03ff41d6ac131c2
-- 
2.34.1


