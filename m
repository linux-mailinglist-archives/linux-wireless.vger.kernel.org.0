Return-Path: <linux-wireless+bounces-20650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DDA6B924
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C025189E855
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E021CFEC;
	Fri, 21 Mar 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gtTP8J9j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654D1DE3CE;
	Fri, 21 Mar 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554388; cv=none; b=a3Y9R2PTMcVbhejJYeWr9rR+/lQOE+FQZyjzJCmzh9xmuRjsIZrD5upxdJRU8aTutG8+oQwGryMQ/KJVWO7gMfGVe+g4sgeM4pfkVN0q8jnfoKPbIMUV+hjF+Imp8eIiC/i0w4G0wRRm5iHDcZsdHd0RdA13P29QYYtUnizV4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554388; c=relaxed/simple;
	bh=NdAWhvI7CW4yoDmYUDA4RD6mPhaxnq2LB0AIthpqVlM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=U+yLqJuAasqKaymyPjaCpu1p5LkePQX9VCt6EfkzuzRvxOZJnuy7f7//fCXsba18upp+PPlowgb2+2WfAtElEbSy/k8Qx10ABWGLHyiNUUgSoNPHTEfJdII9upW3afKPrm5WfNyyzkF3Z8ERFD7OAkgef40X5f1NWXzVLrzMCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gtTP8J9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATCrt017992;
	Fri, 21 Mar 2025 10:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8crHDSyuz5jMlWAPfRbYV/
	vpE0fy+r6kaJpGOLnB4OU=; b=gtTP8J9j0CGdKYKTjDRPm3xxjz0OyNTHv8PDUq
	SrrFbScGdY1wxdwrGj22mmKzlgz+gWq3mBfinL/Tn1OwQPcRkdAB5elEQ+H1znye
	BXHUyEOAsGpIIRO9E3k8SP0ivUbT4iFpT4UPX2ZKZYvFOSM0TIshI+n+IzFjv0nM
	2ohV4ooKI47YIsJZ04BJqC52PA1kgEsAfRLqIb5Z1cPlrbhNER20FtersrMOf4vo
	zwM5U4b3fVkvL/Ri0BiJ0zpn6Dq7EjQzHqNjRuG/u1CqSES1NS19LWodY5N2PR8X
	p01SStjVS/gtZd68GjEb7JAEcolS/dIeoBiROCEQX5bEqH9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmx1jma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:52:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52LAqtcO027767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:52:55 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Mar 2025 03:52:51 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH ath-next v12 00/13] wifi: ath12k: add Ath12k AHB driver
 support for IPQ5332
Date: Fri, 21 Mar 2025 16:22:37 +0530
Message-ID: <20250321-ath12k-ahb-v12-0-bb389ed76ae5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPVE3WcC/x2MUQqAIBAFrxL73UJuRdFVog/LNZfAQiME6e5Jn
 2+YeRkiB+EIU5Uh8CNRTl+GorqCzWm/M4opAKihvmlJob6dogO1W5F7M+rO2G3oCEpwBbaS/rc
 Zioee0w3L+36Rro6RZwAAAA==
X-Change-ID: 20250321-ath12k-ahb-e5d8a4dfc742
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        "P
 Praneesh" <quic_ppranees@quicinc.com>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fuEI4vmvrlDWJDd3o35rrTUb9l0L1sx0
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dd4508 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=T_H_gAJgGU77I6uEl2wA:9
 a=JQuzT0wYMwQa0vto:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fuEI4vmvrlDWJDd3o35rrTUb9l0L1sx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210080

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

---
Changes in v12:
- Fixed warning reported by kernel test robot
  "cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'"
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [08/13] wifi: ath12k: add AHB driver support for IPQ5332
- Link to v11: https://lore.kernel.org/all/20250317204639.1864742-1-quic_rajkbhag@quicinc.com/

Changes in v11:
- Updated Kconfig for ATH12k AHB.
- Replaced the API devm_ioremap_wc() with devm_memremap to fix ath12k-check
  warning: "warning: cast removes address space '__iomem' of expression"
- Rebased on latest ToT.
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [11/13] wifi: ath12k: Power up userPD
- Link to v10: https://lore.kernel.org/all/20250317154150.1361364-1-quic_rajkbhag@quicinc.com/

Changes in v10:
- Removed config dependency of QCOM_Q6V5_WCSS_SEC for Ath12k AHB.
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [13/13] wifi: ath12k: enable ath12k AHB support
- Link to v9: https://lore.kernel.org/all/20250305185501.2400888-1-quic_rajkbhag@quicinc.com/

Changes in v9:
- Fixed memory leak in ath12k_ahb_probe().
- Removed tag "Reviewed-by: Vasanthakumar Thiagarajan", in the updated
  patch [08/13] wifi: ath12k: add AHB driver support for IPQ5332
- Link to v8: https://lore.kernel.org/all/20250228184214.337119-1-quic_rajkbhag@quicinc.com/

Changes in v8:
- Fixed format specifiers warning reported by kernel test robot in patch
  [PATCH v6 07/13] wifi: ath12k: add support for fixed QMI firmware memory
- Link to v7: https://lore.kernel.org/all/20250227191034.1949954-1-quic_rajkbhag@quicinc.com/

Changes in v7:
- DT binding: DT property 'qcom,ath12k-calibration-variant' renamed to
  'qcom,calibration-variant'.
- Link to v6: https://lore.kernel.org/all/20250225064834.2002499-1-quic_rajkbhag@quicinc.com/

Changes in v6:
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
- Link to v5: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/

Changes in v5:
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
- Link to v4: https://lore.kernel.org/all/20241210074159.2637933-1-quic_rajkbhag@quicinc.com/

Changes in v4:
- Missed to include some review list in v3. Hence sending v4 with
  all review list as per - scripts/get_maintainers.pl
- Link to v3: https://lore.kernel.org/all/20241209165644.1680167-1-quic_rajkbhag@quicinc.com/

Changes in v3:
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
- Link to v2: https://lore.kernel.org/all/20241015182637.955753-1-quic_rajkbhag@quicinc.com/

Changes in v2:
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
- Link to v1: https://lore.kernel.org/all/20240814094323.3927603-1-quic_rajkbhag@quicinc.com/

---
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

 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  315 ++++++
 drivers/net/wireless/ath/ath12k/Kconfig            |    8 +
 drivers/net/wireless/ath/ath12k/Makefile           |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c              | 1156 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h              |   80 ++
 drivers/net/wireless/ath/ath12k/ce.c               |   92 +-
 drivers/net/wireless/ath/ath12k/ce.h               |   18 +-
 drivers/net/wireless/ath/ath12k/core.c             |   60 +-
 drivers/net/wireless/ath/ath12k/core.h             |   14 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   84 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   68 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  479 +++++++-
 drivers/net/wireless/ath/ath12k/hw.h               |   22 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   10 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    4 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  210 +++-
 drivers/net/wireless/ath/ath12k/qmi.h              |    3 +-
 17 files changed, 2507 insertions(+), 117 deletions(-)
---
base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
change-id: 20250321-ath12k-ahb-e5d8a4dfc742


