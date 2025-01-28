Return-Path: <linux-wireless+bounces-18054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BAAA206AF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EA818899E8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96B1DE4D6;
	Tue, 28 Jan 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TyziFVp1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA0194C6A;
	Tue, 28 Jan 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055459; cv=none; b=Z696GpbICuh0Hl3KF4+jfiR6D+ofQ8Y49LYiPa9+ZG9o78JeDfe7H4wrRlQmZLle5MHURQKe6N1fDsWTpEKAjWGI4Yw3N558l59LR5TQijCfBv74KbrjehhOdbaLb0ICZhztkGKNuZ+DhTUxxwaK3t5zy2FHAQyy3N6+9OTK0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055459; c=relaxed/simple;
	bh=4d3wHbF3wJIq/GwbBA3D5+nUUKLfYJpNy7Cr0NNkF28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVL1ovcuoqzSyj5e63UFpdw8S/4R03xrnOxiOI3RgkVvHjmiK/ERgykQJftcTfmg7KWk1xJdbeq2j+na/HRDbo4MB+4FaYVjWv+Uw0WzinuxMpgk7hA0JiEbe/syLf0vbdiAH4Tf0YCR1mPqsgOtONc3P7KpDpNx2+TeKS3SqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TyziFVp1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S1rXK4030333;
	Tue, 28 Jan 2025 09:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O86IUGSvbzSBBPJGLArO4m
	oxmwy/mflillW9udl+20U=; b=TyziFVp1GfdZ4ErQcBhPg4eVlV7ijsYFVNaC0+
	rtHMyduL/09eOcjCCfM64lD7lZiHcz2mVh0slTfcQQcuuu48sTsDK09bRUqLsY2M
	7HDsRfWi78XT1lifeDvUIHmRXztfuu2hwDSGQBDB4g/x7EguozIBu0SB+S3WgXpT
	ETUrBtwgwkHpRrSPnx3ZAIkelMmiW9ZuxShidBW+P5vnTxUpH8Vp51K0Yh6nVxbe
	Y3scyvNUU3iDr9Ocq+E0qnWxLpEF8PhucL1Y4SM+KVYvCif+HXsY6YXX9TEXzUfX
	DwyHjqZVDbvo7JtwxrIcIHSrweZyTogx+BdPv2J/BwUE1Ldw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44enyq0qyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:10:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S9Ao1e029469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:10:50 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 Jan 2025 01:10:46 -0800
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
Subject: [PATCH 0/2] dt-bindings: net: wireless: add wifi node for IPQ5332
Date: Tue, 28 Jan 2025 14:40:10 +0530
Message-ID: <20250128091012.2574478-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oTclhi1ceqE9v9nZuEXyXPa-ij4nACG9
X-Proofpoint-GUID: oTclhi1ceqE9v9nZuEXyXPa-ij4nACG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=731 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280070

The IPQ5332 has IEEE802.11be 2 GHz 2x2 AHB bus WiFi device. This patch
series:
- Describe IPQ5332 WiFi device for device-tree binding.
- Add IPQ5332 wifi node and required reserved-memory in RDP441.

Depends-On: [PATCH V2 0/2] mailbox: tmel-qmp: Introduce QCOM TMEL QMP mailbox driver
Depends-On: [PATCH V3 0/8] Add new driver for WCSS secure PIL loading
Link: https://lore.kernel.org/lkml/20241231054900.2144961-1-quic_srichara@quicinc.com/
Link: https://lore.kernel.org/lkml/20250107101647.2087358-1-quic_gokulsri@quicinc.com/

NOTE:
The Depends-On series '[PATCH V3 0/8] Add new driver for WCSS secure PIL
loading' do not apply completely on ath/main ToT. One of the patch
(https://lore.kernel.org/lkml/20250107101647.2087358-9-quic_gokulsri@quicinc.com/)
fails to apply. This patch does changes in the file -
arch/arm64/boot/dts/qcom/ipq5424.dtsi, which is in linux-next but not in
ath/main as of now. Hence, skip this particular patch while applying
depenency on ath/main for review.

Raj Kumar Bhagat (2):
  dt-bindings: net: wireless: describe the ath12k AHB module
  arm64: dts: qcom: add wifi node for IPQ5332 based RDP441

 .../net/wireless/qcom,ath12k-ahb.yaml         | 317 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  56 +++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 106 ++++++
 3 files changed, 478 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml


base-commit: b5aeca2e66899430827b8afcad061201f3b7861b
prerequisite-patch-id: d59a64ae7cc13f19fc6f27f8906c98ff5f97f3b2
prerequisite-patch-id: 6c4774dac182e3cc7fa830c06936e34b2c3f4e21
prerequisite-patch-id: 2ae372ac47365309e9d6a123dc9db69bd0f81cd7
prerequisite-patch-id: 4feb9dd9bfff074118dc0ee327b53a45ddb535bb
prerequisite-patch-id: efdd81a1f3309e3383ed996f3b1ebef8d2680705
prerequisite-patch-id: 2fb2bcb350efe9cb0f85aefa1849fccb5e13ebd7
prerequisite-patch-id: aea510292c2387e214523d6aaff52298f783e342
prerequisite-patch-id: 6ca17cf991617a9c5664b812007547e914f44562
prerequisite-patch-id: 74dc586eab1f42e73d53730084bc38be4677b816
-- 
2.34.1


