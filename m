Return-Path: <linux-wireless+bounces-13981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD299F535
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F331C22E33
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54C1FC7EC;
	Tue, 15 Oct 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U1eyWnlh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B61F9ED1;
	Tue, 15 Oct 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016846; cv=none; b=rrzfJ6LAqRTjXUJLWO82elCaEFr10c/XtVKWZQ/9F3ltEKovfOiJGoIdz4TOIUBI+u599oLX9p4TP/o0wSYouuOIHsosvtAvaTcgaH6MKCM78PZKfcCjjfJnQ5X5jdhq62F2atGuJ9xVNgp0YSPn4SzNTAbkpthjxq+fo2kNq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016846; c=relaxed/simple;
	bh=gJQ+QtaJu95zsVAAg22z4qlMvHm4Bi0RoYZIPGW4U+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KKbrKJvpicyYD2akBqWgiobASxPxrno1qYN09riPmQlt7NT0hzL7N2eYR5V8EG3Y58wqnKBf5zD4FezxS9AbMg/e7DLKUJhhE/gAf7iLnNXRIGlGP26SvKkteWFiK1ykckRGxd8GTHpXycsOUwoLEagfTyEFgRU6wTur0uARBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U1eyWnlh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBejj3019629;
	Tue, 15 Oct 2024 18:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZZiwqF20rDtQLdlXXlqvzw
	lZsLog4CB3TcNilWiCjSI=; b=U1eyWnlhg0VdjLhG3CVeVDC1XGDZMciZ3Q9xH/
	DCml/fOB0I4c53jvzjsWXWOx9LenuVY8BXEknscATh0HHQ3A/MzjLWqc9r9j9dG1
	QpCYA1+OMvaEVQiPr5f0l6ySbTscMhmlnec1uvZd5nyQm5aFlmMuac44csNRknFs
	VFGSSJkRYwnT1tj3UgVeWCsEdL+jaHk8lKocCWpamQ4iEedfnmhEhnYdg4I3OQhA
	1cbfrUlaSQSCt/jpEBNvKiZEwRU8zDJ22q4KVq08kvoM76lDnb3lIO/z7AXrfzOo
	gQuFEySi/+88Qerqsv0XmmZPMaS+ELFNObr6xO/Z7VPXZSnA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd90jpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FIRF0Z003860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:15 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:27:11 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 00/22] wifi: ath12k: add Ath12k AHB driver support for IPQ5332
Date: Tue, 15 Oct 2024 23:56:15 +0530
Message-ID: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: 4GOuJXn4R8GBzzws6oxtlsJKbqR3CP6Z
X-Proofpoint-ORIG-GUID: 4GOuJXn4R8GBzzws6oxtlsJKbqR3CP6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=850 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

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
- Support userPD handling for WCSS secure PIL driver to enable ath12k
  AHB support.

Depends-On: [PATCH V7 0/5] remove unnecessary q6 clocks
Depends-On: [PATCH V2 0/4] Add new driver for WCSS secure PIL loading
Link: https://lore.kernel.org/all/20240820055618.267554-1-quic_gokulsri@quicinc.com/
Link: https://lore.kernel.org/all/20240829134021.1452711-1-quic_gokulsri@quicinc.com/

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
  wifi: ath12k: add BDF address in hardware parameter
  wifi: ath12k: convert tasklet to BH workqueue for CE interrupts

Sowmiya Sree Elavalagan (4):
  wifi: ath12k: Power up root PD
  wifi: ath12k: Register various userPD interrupts and save SMEM entries
  wifi: ath12k: Power up userPD
  wifi: ath12k: Power down userPD
---
v2:
- Integrated the “Support userPD handling for WCSS secure PIL driver”
  patch series with the Ath12k AHB bring-up patch.
- Updated DT binding and DTS files to align with the new Rproc design.
- Addressed review comments on RFC patch series v1 of
  “wifi: ath12k: add Ath12k AHB driver support for IPQ5332”.
- Removed the RFC tag as all dependency patch series are now compilable.

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20240814094323.3927603-1-quic_rajkbhag@quicinc.com/
---
 .../net/wireless/qcom,ath12k-ahb.yaml         |  293 ++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |   59 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  108 +-
 drivers/net/wireless/ath/ath12k/Kconfig       |    6 +
 drivers/net/wireless/ath/ath12k/Makefile      |    1 +
 drivers/net/wireless/ath/ath12k/ahb.c         | 1326 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/ahb.h         |   80 +
 drivers/net/wireless/ath/ath12k/ce.c          |   90 ++
 drivers/net/wireless/ath/ath12k/ce.h          |   18 +-
 drivers/net/wireless/ath/ath12k/core.c        |   35 +-
 drivers/net/wireless/ath/ath12k/core.h        |   19 +-
 drivers/net/wireless/ath/ath12k/dp.c          |   10 +-
 drivers/net/wireless/ath/ath12k/hal.c         |   82 +-
 drivers/net/wireless/ath/ath12k/hal.h         |   69 +-
 drivers/net/wireless/ath/ath12k/hif.h         |   13 +
 drivers/net/wireless/ath/ath12k/hw.c          |  482 ++++++
 drivers/net/wireless/ath/ath12k/hw.h          |   16 +
 drivers/net/wireless/ath/ath12k/pci.c         |   28 +-
 drivers/net/wireless/ath/ath12k/pci.h         |    2 +
 drivers/net/wireless/ath/ath12k/qmi.c         |  169 ++-
 drivers/net/wireless/ath/ath12k/qmi.h         |    1 +
 21 files changed, 2793 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/ahb.h


base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
prerequisite-patch-id: bfefff55ba6a3fdf8930b3b4d48746bc9cd5a0a0
prerequisite-patch-id: 9e143f9cd10add55d2fd52bac0e538b904d6dee5
prerequisite-patch-id: cb987ee3dbc145fee1135307badb61c0e21f0ccd
prerequisite-patch-id: 14b990ceacec658b924c78d91ce33b45f70ca112
prerequisite-patch-id: b1f6cc6ae066f3e10b5626ff0af3267449d613d3
prerequisite-patch-id: be810c2435b44ea08527d739510d18770e732dfa
prerequisite-patch-id: 1a946f3d5f563f0de825606b276dbaee695aa5b8
prerequisite-patch-id: 97f4a586c7040822e0e7977bd1599333ad02237b
prerequisite-patch-id: bc306b2998d1afe66757052e33dc685ae4e7a627
-- 
2.34.1


