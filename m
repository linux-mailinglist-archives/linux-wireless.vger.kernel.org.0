Return-Path: <linux-wireless+bounces-11401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAC9517ED
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9772814EE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5FF166F38;
	Wed, 14 Aug 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OClIq9ZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265914A60E
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628667; cv=none; b=HBv2kz+UCwtMp3DKzuyNj8u9rPeAvkV4Qo6mmb9xhUPAlRirMihelt/q08ye/K43XgDSyREcFwu6kftlzsnR0u0ZRtG2TAJ0gysyDEQxRsaRgy1DFwYkNR2vdgRa3LU6QjWXECaB/rq4uULGe9TGKiIFtpNw1BGClCOxdNndcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628667; c=relaxed/simple;
	bh=TGxKXmvUX6FCr07xiHj9PMvmLaePTOFO6h7c7/khNU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6UomF4yak953jGKdiCKUq5GJ1Hf9L9O4RpV08EHXuEy647j9qDMmdaVu7Chv/M3rtI0ZFKxIwwhYooOYOwc5pVlRxIQw1euKJRuD8iLbwa2+MeGej/NHsggYPVtGHy7Bxeo5XQQnZBvfsLg1FV/uuFHRvIXICnxivPhR+ZDYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OClIq9ZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNAT0J009054;
	Wed, 14 Aug 2024 09:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f2ZukGABYXU+YZF2cvy5V6
	Gbqu04XveWtelZ1jhfnq0=; b=OClIq9ZKKo9x4APXKwZn1Ae1QBqg8SpZ5zN0pD
	rGJMKzTXJbw9TUDf5hURJ7zBew+PF2EFuHOQeFinVTrceITBbEtdGmI4cWslv/Ys
	oMkDVJJQ6WjN5yzAfQATTf0ubYLNbCwYhkcLlXGOCaKj/I4WeJZJwsSuDUA8aV+Z
	4+nnhmh9i49W7b/qaK2bAlmQ9jW3BB1oUPZGJ2jeBbqR+0CTLw2yyh6EuOYpaUAo
	few1YxHOQ3X5VP87pwcbL63A3EjraaSZvJchLsCSW1RR6MNAqRqJoXF/M+TVbwgR
	dGaRA0pTieFCZLc89aD/wixVveUIMPBWeYq1Ig6OKUPiOeBQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4108bc2vre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9iJlH021204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:19 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:17 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 00/18] wifi: ath12k: add Ath12k AHB driver support for IPQ5332
Date: Wed, 14 Aug 2024 15:13:05 +0530
Message-ID: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i5CSvSrGrOA9Lrzg_MqGJ-CerNV2JgRg
X-Proofpoint-GUID: i5CSvSrGrOA9Lrzg_MqGJ-CerNV2JgRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=724 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

Currently, Ath12k driver only supports WiFi devices that are based on
PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
Ath12k AHB support for IPQ5332.

IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
device:
- Add hardware parameters for IPQ5332.
- CE and CMEM register address space in IPQ5332 is separate from WCSS
  register space. Hence, add logic to remap CE and CMEM register
  address.
- Add support for fixed QMI firmware memory for IPQ5332.
- Add ath12k AHB support.

Depends-On: [v6] Add multipd remoteproc support
Link: https://lore.kernel.org/all/20231110091939.3025413-1-quic_mmanikan@quicinc.com/

Note that the dependency patch series - [v6,00/11] Add multipd
remoteproc support, has the below issues:

1. The remoteproc maintainers don't want any userpd code in remoteproc.
   As a result of this, the approach being taken by this series may
   change.

2. Due to latest changes in linux-next/ath ToT, [v6,00/11] Add multipd
   remoteproc support is unable to compile. Below compilation fixes are
   required in the file "drivers/remoteproc/qcom_q6v5_mpd.c":
   - Add "#include <linux/of_platform.h>"
   - Change "static int q6_wcss_remove" to "static void q6_wcss_remove"
     and remove "return 0".

3. The IPQ5332 firmware patch is pointing to ath11k firmware path, but
   IPQ5332 is Ath12k chipset.
   In patch [v6,10/11] arm64: dts: qcom: ipq5332: Add nodes to bringup
   multipd, firmware path should be: ath12k/IPQ5332/hw1.0/

Balamurugan S (9):
  wifi: ath12k: add ath12k_hw_params for IPQ5332
  wifi: ath12k: add ath12k_hw_hal_params for IPQ5332
  wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
  wifi: ath12k: add new CMEM read-write ath12k_hif_ops
  wifi: ath12k: remap CMEM register space for IPQ5332
  wifi: ath12k: fix incorrect CE addresses
  wifi: ath12k: remap CE register space for IPQ5332
  wifi: ath12k: add AHB driver support for IPQ5332
  wifi: ath12k: enable ath12k AHB support

P Praneesh (4):
  wifi: ath12k: refactor ath12k_hw_regs structure
  wifi: ath12k: add ath12k_hw_regs for IPQ5332
  wifi: ath12k: add ath12k_hw_ring_mask for IPQ5332
  wifi: ath12k: add CE configurations for IPQ5332

Raj Kumar Bhagat (5):
  dt-bindings: net: wireless: describe the ath12k AHB module
  arm64: dts: qcom: add wifi node for IPQ5332 based RDP441
  wifi: ath12k: add support for fixed QMI firmware memory
  wifi: ath12k: add support to read board_id from device-tree
  wifi: ath12k: convert tasklet to BH workqueue for CE interrupts

 .../net/wireless/qcom,ath12k-ahb.yaml         |  325 ++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |   56 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  131 ++-
 drivers/net/wireless/ath/ath12k/Kconfig       |    6 +
 drivers/net/wireless/ath/ath12k/Makefile      |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c         | 1028 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h         |   50 +
 drivers/net/wireless/ath/ath12k/ce.c          |   90 ++
 drivers/net/wireless/ath/ath12k/ce.h          |   18 +-
 drivers/net/wireless/ath/ath12k/core.c        |   35 +-
 drivers/net/wireless/ath/ath12k/core.h        |   19 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   10 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   82 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   69 +-
 drivers/net/wireless/ath/ath12k/hif.h         |   13 +
 drivers/net/wireless/ath/ath12k/hw.c          |  478 ++++++++
 drivers/net/wireless/ath/ath12k/hw.h          |   14 +
 drivers/net/wireless/ath/ath12k/pci.c         |   28 +-
 drivers/net/wireless/ath/ath12k/pci.h         |    2 +
 drivers/net/wireless/ath/ath12k/qmi.c         |  188 ++-
 drivers/net/wireless/ath/ath12k/qmi.h         |    1 +
 21 files changed, 2525 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h


base-commit: 1462e8e1c93ecb96b5820ec28f7cbbb8a5aeb732
prerequisite-patch-id: 0c516eb530339e5398eaaf8ece5e72dfac419f93
prerequisite-patch-id: bfefff55ba6a3fdf8930b3b4d48746bc9cd5a0a0
prerequisite-patch-id: 9e143f9cd10add55d2fd52bac0e538b904d6dee5
prerequisite-patch-id: cb987ee3dbc145fee1135307badb61c0e21f0ccd
prerequisite-patch-id: 14b990ceacec658b924c78d91ce33b45f70ca112
prerequisite-patch-id: b1f6cc6ae066f3e10b5626ff0af3267449d613d3
prerequisite-patch-id: 06bbcd43424f4ee2f116372855665f7dc932158d
prerequisite-patch-id: 73a4b0a87c136697874bb120a3bf0a7ec6e54a32
prerequisite-patch-id: 6cab6a588aa5479276228e60693ea6d472e2f844
prerequisite-patch-id: df1119a31756da103188d8880077ce0bcec3d352
prerequisite-patch-id: cf47f0a66dbe5f11d50ce2e62682b0f48dfc4e76
-- 
2.34.1


