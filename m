Return-Path: <linux-wireless+bounces-16084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A89E9C35
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249D41635CF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4714F121;
	Mon,  9 Dec 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PqZA7s3k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D02C9A;
	Mon,  9 Dec 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763445; cv=none; b=M16xWGsQR9eqPAgPShL7JNzHqQJslZtt+TtqWYbbu+YCSUsaPnAK8v7oM7dyp4mB+CZozcZvGmv90rjSXxpmPgVcwIkG1IwD/I4ojLi6fdoNgtvVYjHvdNsL+2J8GytpKt6pAbLyI7X4WX6bxzLV6rlJpM4+GxWXIFj5a+KlasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763445; c=relaxed/simple;
	bh=CwCiRZOzpt2LcrlLJ3Cm/hbQRluYhN3dmyi/tOmqa2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+4tK5Xcf2soc82Aj+ZwACejG2UlMp1++gGLf5TndNfHFmbo8TtEE3owjhSVMT6F/C1scPTp9CYlDNHnJlQE5a0yXO4MKzdR4dvFLg7V/Y4qX3oHKdHpTjGT+R5QAmaEIdiGfBS9vGKvdm43SHBZuoRW1xcD5cwK7bc1lxaZpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PqZA7s3k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FKuSU019489;
	Mon, 9 Dec 2024 16:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cjDpgIH8fj70T83+YQthxk
	75hzq900MWphzKgsCJSSc=; b=PqZA7s3k5pqz454OxLyJVFj1XlGkva40IheCUR
	iYXZo6kRXTumEqB+PYgOHUyqJh5vDyERPbR/vUoIwzN2xUSOGfGx4MkNHmvWUUUf
	OxYoySA/Lq5/hBVS+epJibNoOZXZDUHhEoPKV85dL0yMqvbR7QLztUH6NiSbO70l
	Pp3Z6BfYlyAHaNt7RUhXrQZnyiH+mvaISY/6hckfkApS5b4sn7OOQ5GIGXwHEMzi
	IZUVveJotSfo4mxw6uYVzLhJLxylotbiwFn7/YCn4oUz9FK2MjzWk44cbeMNVILF
	mlmPJ6Wy8AB6yJ6bLYenbpvlrDTZIm2ymRfeIHvQ1HlJzPLw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e3418a86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:57:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9Gv5TA003773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:57:05 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 08:57:02 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 00/13] wifi: ath12k: add Ath12k AHB driver support for IPQ5332
Date: Mon, 9 Dec 2024 22:26:31 +0530
Message-ID: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zhFC6i1OvMdIQx8cMPZsUzCiYBDhUVU8
X-Proofpoint-ORIG-GUID: zhFC6i1OvMdIQx8cMPZsUzCiYBDhUVU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090132

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

v3:
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
  dt-bindings: net: wireless: describe the ath12k AHB module
  wifi: ath12k: add support for fixed QMI firmware memory

Sowmiya Sree Elavalagan (4):
  wifi: ath12k: Power up root PD
  wifi: ath12k: Register various userPD interrupts and save SMEM entries
  wifi: ath12k: Power up userPD
  wifi: ath12k: Power down userPD

 .../net/wireless/qcom,ath12k-ahb.yaml         |  301 ++++
 drivers/net/wireless/ath/ath12k/Kconfig       |    6 +
 drivers/net/wireless/ath/ath12k/Makefile      |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c         | 1254 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h         |   80 ++
 drivers/net/wireless/ath/ath12k/ce.c          |   92 +-
 drivers/net/wireless/ath/ath12k/ce.h          |   16 +-
 drivers/net/wireless/ath/ath12k/core.c        |   35 +-
 drivers/net/wireless/ath/ath12k/core.h        |   12 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   82 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   66 +-
 drivers/net/wireless/ath/ath12k/hw.c          |  477 +++++++
 drivers/net/wireless/ath/ath12k/hw.h          |   15 +
 drivers/net/wireless/ath/ath12k/pci.c         |   12 +-
 drivers/net/wireless/ath/ath12k/pci.h         |    2 +
 drivers/net/wireless/ath/ath12k/qmi.c         |  169 ++-
 drivers/net/wireless/ath/ath12k/qmi.h         |    1 +
 17 files changed, 2520 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h


base-commit: 400568fb3b022247c1603fdbdd6444b3ef14ffce
-- 
2.34.1


