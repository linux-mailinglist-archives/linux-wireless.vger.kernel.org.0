Return-Path: <linux-wireless+bounces-14932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F50B9BD40E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA221C21CF3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF401E572C;
	Tue,  5 Nov 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j1rG60NL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248813D51E;
	Tue,  5 Nov 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829934; cv=none; b=upSkjd0RTD//6fFYZioJW31wiATy7m6rzfsXvbQsQO3zpovdQm9jfoqEFsbNRDyxdjnQdh8VPKRjKUz1c7ig0/XVx2Carbu8Hr1Q1hzWbkMLWmR5qMEUed7iGa4zwhoTVHK4AJAlyj+zZQYH7ktn/UnCikiyFKWDyIiwgs0YHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829934; c=relaxed/simple;
	bh=FgOMsDja6N6YWUbIeC0dZ5ENuFgdlachWEnmayDzoe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g33JAlxHJ49JFDLSife4U8fs1LUgJZ/TXUArxcnKvzP4C7nZ1VclpvnF2xdpfV0ZI9oKYRcWZhKAXmPhQGoSTEIxZ103MJI8wrYGn3g7S0Gwv+C+oWcinCC+aacRu9aTajfAY0r+H1pey/2m4dToHYYCK79NuAE6gbghhTLw6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j1rG60NL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FUmjs013143;
	Tue, 5 Nov 2024 18:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t1ruyxheKoHZkkLnp4sRQ+
	EdfzZQLNtKwSZr8rmZ0MQ=; b=j1rG60NLtbN6K9LUdnz+ll0/AVNZ7/gw0F2/9h
	2rT4KmiHNiqBeGp+XnNz9fwCen6FaswSqtoO5Aq7ACLQfca2wPamu6EaUrewHGhz
	fF8uZBhEU5ibnx66bZyzj8szcXIxDobkb9NntLFlw6smDokWo4WE3TYD45v36RmM
	+UmPiz9DriaXxa0v8701sgvZl3acEq6f2oMUQ28l5iRGGan9n96frmHrBxsn3GGt
	i/505lXogrbUSyi7+lO6scTtCzKaGHKj6RWgb+o+IkruSQJrMhzQWJxi73vdt7Oz
	HoYncxOl7E7IPjd8s/R4DKaMiqmn0eOkT3KcwVQYvP3yQlLw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2rrfb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 18:05:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5I5MPa022854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 18:05:22 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 10:05:18 -0800
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
Subject: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI for QCN9274 in RDP433
Date: Tue, 5 Nov 2024 23:34:39 +0530
Message-ID: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: Mp3u6V5Sgr_BqwKozbCfpFqrwS2VM3co
X-Proofpoint-ORIG-GUID: Mp3u6V5Sgr_BqwKozbCfpFqrwS2VM3co
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050139

The RDP433 is a Qualcomm Reference Design Platform based on the
IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
PCIe2, and PCIe3. These devices are also interconnected via a WLAN
Serial Interface (WSI) connection. This WSI connection is essential
for exchanging control information among these devices.

This patch series describes the WSI interface found in QCN9274 in
device tree and uses this device tree node in the Ath12k driver to get the
details of WSI connection for Multi Link Operation (MLO) among multiple
QCN9274 devices.

NOTES:
1. As ath12k MLO patches are not ready yet, this patchset does not apply
   to the ath.git ath-next branch and that's why the patchset is marked
   as RFC. These are the work-in-progress patches we have at the moment.
   The full set of MLO patches is available at:
   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274

2. The dependency marked below applies only to the DTS patch. The
   dt-bindings patches do not have this dependency.

Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/

v3:
- Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
  devices with WSI interface.
- The "wsi" node is dropped.
- The property "qcom,wsi-master" renamed to "qcom,wsi-controller".
- Updated description for "qcom,wsi-controller".
- The "qcom,wsi-group-id" property is dropped.
- The ath12k driver changes added to dynamically assign wsi group IDs.
- DTS changes done to make device node name generic (wifi).
- The patch series title is updated.

v2: https://patchwork.kernel.org/project/linux-wireless/cover/20241029173050.2188150-1-quic_rajkbhag@quicinc.com/
- "Graph with endpoint” is used to define the actual WSI connection in
  the DT binding.
- The qcom,wsi-index and qcom,wsi-num-devices properties are dropped
  from the binding. These are now determined in the driver using the
  graph with endpoint.
- The qcom,wsi-master property is added to the binding to define the
  WSI master.
- The qcom,ath12k-calibration-variant property is added to the binding
  for ath12k devices.
- DTS changes are made based on the “graph with endpoint” binding.
- The ath12k driver is updated to read graph nodes, determine the number
  of devices in WSI, and assign the wsi-index for each device.
- The ath12k driver now assigns hardware link IDs based on the order of
  WSI connections.

v1: https://patchwork.kernel.org/project/linux-wireless/cover/20241023060352.605019-1-quic_rajkbhag@quicinc.com/

Aditya Kumar Singh (1):
  wifi: ath12k: Assign unique hardware link IDs during QMI host
    capability

Harshitha Prem (1):
  wifi: ath12k: Parse multiple device information from device tree

Karthikeyan Periyasamy (1):
  wifi: ath12k: Send partner device details in QMI MLO capability

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: Describe ath12k PCI module with WSI
  arm64: dts: qcom: ipq9574: Add WiFi nodes for RDP433

 .../net/wireless/qcom,ath12k-wsi.yaml         | 205 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 105 ++++++++-
 drivers/net/wireless/ath/ath12k/core.c        | 178 +++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h        |  10 +
 drivers/net/wireless/ath/ath12k/qmi.c         | 120 ++++++++--
 5 files changed, 588 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml


base-commit: 7603a9349b2fc64152a734f253cf8d8e5befb6db
prerequisite-patch-id: d1334693a2e8da65ae7b458ee4adb459850ad2e7
prerequisite-patch-id: 87f73b342f67c2636390a7da1294cee90f1fff48
prerequisite-patch-id: 46d8302766527d16cdd90c59ded6cbae0ec4ad70
prerequisite-patch-id: b17db6783b1c35f3e8812f621730fe0a1a57a14e
-- 
2.34.1


