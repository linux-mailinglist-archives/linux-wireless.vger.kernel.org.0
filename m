Return-Path: <linux-wireless+bounces-23129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56305ABB13D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D0F174C69
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED52D21FF44;
	Sun, 18 May 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aj6cDDWM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2C1D6DBB;
	Sun, 18 May 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592595; cv=none; b=PbVsKpw09brlAcr1DDBBrOVTo+n0GLh8m2bVnNEpeKvxh0aGvwo1aYTxWyqRBJ7md03cChmYcmElAeblXEYXvs8WaouvoizPYsjX8PpN0Sm60eQ79aDag7eRUUIvQ114XVdJBMwfc+Rlb3O/tn6IfmlqhZXKJ78kQQHe+NMSe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592595; c=relaxed/simple;
	bh=zNl9h3O7jsIZhxMwFXEXtHLEiIIC6nEFDyTIlIpgd38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tmj5h0G4nR8v983l2I8m0b/fiTbhy18yM3TT3uXBIgD/uHWVeN/F4v2y/W1i1+iEqte7YzM3qypqqyePabiyzxSvSwxpLxkdV5X/S5Bx8ubi2w1BSFVo2YX7M+GRW8yGK2cSVfdPuuV+XKntMdVNPocldwFo6ICwPhHblR9uHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aj6cDDWM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IIMxPO004036;
	Sun, 18 May 2025 18:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YL8DBcm48fjZT4qgabvudsfE3bZaf+cmnGd/EUz4ouc=; b=aj6cDDWMT3Y+2rgC
	tlK4kKlYxBHWiytTMfyWiEUJUl8+6cFTqcYCg5lNQVugHZTyWSBu5QXIcgSunCAj
	jdMyYfR4z8ZQzFEDUPg/PjQkNeIhUn9yEsi+VWbvVBPWRhFq/BwI53Whq1lWF2EN
	wXwKwOAhc6VVEHwdKLdy2UX3M5pHd1xdDjQGdvAIC7ff/XaCitvK6kTg7PegwuGb
	Ux/MB9ZTjpqtruoOI/vxrhlSSmvXDYlKAgFChMqsD3x4zZUt2A/7LmXEnKoOjA+C
	dtwIsM80jUa5lsKlNsa66anxmCrmAgkKSIdLQ7eYB4ctmJ9MlQka1HErjSohH2qS
	c2qWYQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7a9ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:22:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IIMwhU005293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:22:58 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 18 May 2025 11:22:55 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Sun, 18 May 2025 23:52:28 +0530
Subject: [PATCH ath-next v2 1/5] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250518-ath12k-ipq5424-v2-1-ef81b833dc97@quicinc.com>
References: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
In-Reply-To: <20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        "Raj Kumar
 Bhagat" <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682a2583 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=HmtOZnpMNtbFe9RdH4EA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QPMtm3cXt3JjQzzT9hYE1Zb3Hj5DBlBI
X-Proofpoint-GUID: QPMtm3cXt3JjQzzT9hYE1Zb3Hj5DBlBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE3OSBTYWx0ZWRfX4bE2Fp/WEMzW
 H6ZoOmHm4Xqh7TNil/1ZC2iqMAiZsU7/lMumwhukqLw9W1TJ5aAbkD5pPX5btst/PM0uA4lBGbO
 wCSxaVDqa5EG23jHYzx09mfT2iB2/ABVsEB+nSRGvr9u7kc5ZXf7CyVQygWFZ7YMsL6vaXXU7wb
 CndE+NkDzOd+ea4+2Q1gogcy2GchH3ljomHwoX705V5L5TYXD2mk9e3o0phGMUYcodVVRArMEFv
 13CZCK+Joj8WVtOfgVT6uidi2BwqBzz9nDNUSoLW+UqQ08xsb3gFupaXMR3X6WxqWbz8e7HV3x+
 KVHA4ZS1PnNcoGrjSVTLxQihJvF/7pKNQjUnasrufZrdzpjWUuQuAK+EaJhkEz/wVXvlHnrjqwC
 LUSQH05pfdgO61l75VbEGTOXwlWWEBRqEbSQ1YCm34nT0xhUCRe62WLvejJIhcD0vPWutuUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=925 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505180179

Add the device-tree bindings for the ATH12K AHB wifi device IPQ5424.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
index 363a0ecb6ad97c3dce72881ff552d238d08a2c12..37d8a0da778097b8bf7af2e8f1e920083a3fb81a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq5332-wifi
+      - qcom,ipq5424-wifi
 
   reg:
     maxItems: 1

-- 
2.34.1


