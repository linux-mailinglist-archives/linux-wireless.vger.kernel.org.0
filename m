Return-Path: <linux-wireless+bounces-21942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D177A99D77
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 02:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBA6446D1E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 00:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3236913AA2A;
	Thu, 24 Apr 2025 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FVnaROU9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11660DCF;
	Thu, 24 Apr 2025 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456264; cv=none; b=FKXKok1NSDDDVbsSeMB1CCSxuHv4g4HeGMIbeTxa0+DdBn1gEp9WulXFcBXdFAuHcb/WNdrAHqDGZpwDom853r8Si9BEHzQTqZOxtfY4EjXJxSRxrKH7vM6ON8zRhD47SeyyzA/mnwkxFUdg74tA3dd/3yCxZoqC3DC4lsmi92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456264; c=relaxed/simple;
	bh=tICTTbkkKbPe9yy/OqPL1wz9vsXO9gGz9tnHagt7+Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlM4/o5sQ5PDlDratSQU0BxPF9wzYBomxlG6MhYKqbs+/QNdfrSIzEc7+P5xk5LaTiJVE3B3xsbqHphKLdtsfoUlaRHWyCCwfUM0qUnJhVMl83uBnudgC8IQeaZrutw1owqcmNv5uez9SuBcTTll6Q0rt0g6mEbL6VCjAuAz25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FVnaROU9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FHOF010443;
	Thu, 24 Apr 2025 00:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rxw+NfrdMPER0fLgTceGWbFR63MWOrOr6EROBNXigRo=; b=FVnaROU9FUJqrRn9
	6m33bnNCIGqUfnRfYLuJgmBtf1qj3P7rll6QsLmFT97WHTZ/92TD/TZO0OTL6TmQ
	rr+nnS7b9vZfdIBsOFipa34mIlpPkakcOumQQOvenEJLUX3yJI7nsPaMhiAwmFpC
	ecPjhMjPrzcTHww8HI8LRTGeKKt2UFkzC/f6pvaEXTfH7M9zokoF5s+9ue5miAZd
	kAladg4Wip0DKYPfuj3LUVt2pG0ZjrTAJmlBqYXWKMrHc4kjaLOA251BqNa5nWqL
	9C72prXVgp2yx/tyl2Oe+elEJKq8gQ/SMZInbMgRt9wLWvOISYg0gZKuGe/WrGNl
	t7F40Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3ksa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 00:57:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O0vVIt014691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 00:57:31 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Apr 2025 17:57:28 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <jjohnson@kernel.org>, <johannes@sipsolutions.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [RESEND ath-next 1/2] dt-bindings: net: wireless: ath12k: describe firmware-name property
Date: Thu, 24 Apr 2025 08:57:02 +0800
Message-ID: <20250424005703.2479907-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
References: <20250424005703.2479907-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m-52EevU8MlSSyt468fHo5aR28Sz8YrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwMiBTYWx0ZWRfX3xqsIDnHw40M iuw4PtkoEqyM+vnvkYbQrd8lD+qGBHjwdfzDeh9ks/x9HmyS6eSbyJ8pmBvJepsz4DlZgOs/Qzu Qkj0nllMwLkC1bPcpQCPQav+ltWBxB6inPgeDMbHrp/19I/97E5BCIHkWQMXPKUe+1teBWXWytF
 7sC5UqSVo2CECFjZp2LVUQwIv3jvpZ3AtdskOWlq3kSRVoUjWvxu+5dv6z0Uu9q9hMj2cjuFdFz FRzL2wWMktPkA9ZleZNO6AQxjWpYzmn1zNXS8sRgeC5dKtWjRoI1kbkoBm0iAs4ldZl4Q545uUT cQXZpZi4vQt5Hg4ZUZ4oW2SMeeO/FCEoPN7gjHHAVCEg3uGXltyw1x/HhvCu/oQQyrko1fbtyOP
 bUZy8nOaTPz4oFfjVmBiHWzzxwXedyT6Ofjg/bMP6/aZEea01+x4ePNJ27GQ8giqT8Ep7SjW
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=68098c7d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=Hda1I3ypr0uxOpTqMjQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: m-52EevU8MlSSyt468fHo5aR28Sz8YrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240002

Introduce 'firmware-name' property to allow end-users and/or integrators
to decide which usecase-specific firmware to run on the WCN7850 platform.
This is necessary due to resource limitations such as memory capacity and
CPU capability, or performance and power optimization for different
application scenarios.

Two firmwares are supported: 'WCN7850/hw2.0' and 'WCN7850/hw2.0/ncm825'.
The former is the default firmware, suitable for most WiFi 7 STA
functions. The latter adds support for commercial-quality SAP and
optimizes power consumption for IoT applications.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath12k.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index 9e557cb838c7..dc68dd59988f 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -21,6 +21,12 @@ properties:
   reg:
     maxItems: 1
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup
+      usecase-specific firmware files for the device.
+
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
-- 
2.25.1


