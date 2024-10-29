Return-Path: <linux-wireless+bounces-14677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1049B50ED
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFEEB2532D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85D205ACD;
	Tue, 29 Oct 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g9XrPSva"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044181DACB4;
	Tue, 29 Oct 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223097; cv=none; b=c+jaZJgzUWpCsUPkAu/bl4HFpW5FBxK2IOh7CRoL1ZgcC+EYrXHIpJvQCCNlDv9r/AbOyFD+m1TKcI1PNS1TAboH8tA9k5I/IlHbya2wqEEDqg77albAwRQnEUzj5LGzY1g7AHIhuhs5Idbb0mo8rB4dg6PIAzn2UkV9mZNp4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223097; c=relaxed/simple;
	bh=oqdDJulZyveXg6sSuftDFq5/prYWQVimUskWV4M+QBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfXdEX7r8Tw3I/1n2aY3rKhOCtjJ5M/zO4UaZ7pFxceS0Rt3yR7e7snrZht7WvqocixIgJEz1zQfBI9UAVx0QcRSlNyZKnlai2r3IJ8/VvYSp+iSmUEA+jBcLE5WhPeyux9u1x7P3e8Hm+raxMhymMEVvLQBlXIq7NyeU1sQ4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g9XrPSva; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAoCN7008776;
	Tue, 29 Oct 2024 17:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8xDWTJaViFA2Yr7m9tjnqP
	oRinJf9qOTHmFFcVmroZ0=; b=g9XrPSvaMIkzzgC9z+9nUDUMyhrICfzcB/IM5g
	L0iIFvfllyu2EY/kSCowDHiqPKfeZvkDTXfzB4z8NBoEmq/uYODQFZK0bFtKJK0f
	vxNCWCZvUAhbOHFyApwVPkoR+k996S3acS+pq2EMR631QtZcy5BeAUnmjIq1IqBK
	Zj2wUboOedR04jrpUQAF3Ux7DEX5MUqHcDd0ZlpAuP+9rMjYl9YJInS9EO9HhikH
	fPPZ4HZbksk5GZtpk2anAWZgGCJqW4WMSiJB9M94hECs5pDv5NaYVxq7TVAfeC7t
	LsHa1eK2TdlKpoWPscIufiqShhpjvHUdqtzNpRwcy5UOzmYA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42jxa891xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49THVPUI014136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:25 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 10:31:21 -0700
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
Subject: [RFC PATCH v2 0/5] wifi: ath12k: Add WSI node for QCN9274 in RDP433 for MLO
Date: Tue, 29 Oct 2024 23:00:45 +0530
Message-ID: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: QNDW8eAx2SHQIxAtg8SV-Q5TR7mcoEmV
X-Proofpoint-ORIG-GUID: QNDW8eAx2SHQIxAtg8SV-Q5TR7mcoEmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290132

The RDP433 is a Qualcomm Reference Design Platform based on the
IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
PCIe2, and PCIe3. These devices are also interconnected via a WLAN
Serial Interface (WSI) connection. This WSI connection is essential
to exchange control information among these devices.

This patch series describes the WSI interface found in QCN9274 and
uses this device-tree node in the Ath12k driver to provide details
of details of WSI connection for in Multi Link Operation (MLO) among
multiple QCN9274 devices.

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

v2:
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
  wifi: ath12k: assign unique hardware link IDs during QMI host cap

Harshitha Prem (1):
  wifi: ath12k: parse multiple device information from device tree

Karthikeyan Periyasamy (1):
  wifi: ath12k: Send partner device details in QMI MLO capability

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: ath12k: describe WSI properties for
    QCN9274
  arm64: dts: qcom: ipq9574: Add WiFi nodes for RDP433

 .../bindings/net/wireless/qcom,ath12k.yaml    | 241 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 116 ++++++++-
 drivers/net/wireless/ath/ath12k/core.c        | 154 ++++++++++-
 drivers/net/wireless/ath/ath12k/core.h        |  10 +
 drivers/net/wireless/ath/ath12k/qmi.c         | 121 +++++++--
 5 files changed, 605 insertions(+), 37 deletions(-)


base-commit: 7603a9349b2fc64152a734f253cf8d8e5befb6db
prerequisite-patch-id: d1334693a2e8da65ae7b458ee4adb459850ad2e7
prerequisite-patch-id: 87f73b342f67c2636390a7da1294cee90f1fff48
prerequisite-patch-id: 46d8302766527d16cdd90c59ded6cbae0ec4ad70
prerequisite-patch-id: b17db6783b1c35f3e8812f621730fe0a1a57a14e
-- 
2.34.1


