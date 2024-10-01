Return-Path: <linux-wireless+bounces-13348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D16EB98B2B7
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 05:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B07B214EC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A31946B5;
	Tue,  1 Oct 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WICDhprr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F21193096;
	Tue,  1 Oct 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727753489; cv=none; b=bpoCO5t1F18YcCmns7CRXjELBYv7wT4+vKtfqo3CXTSqnmN0/7o9YtbD+PBtrrep1hxGF5mmaCRI6KB6EWJTcbC8sfa+QG3m7zR3JbPE6jRZT39vh2ugmhU/uM9xKyNvm3/8lO3zlY64m9EBtLteGgFQHXD3vS+Q6zI0H/TnyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727753489; c=relaxed/simple;
	bh=sXjxa40XVPmlPQCePEQZNZ9Ch7CRp3HaldAk54Ym+6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZYRwQ0dppvArUFxfAnt2ORhjWSEOQ5k5KfsP2NZWOP9DTJU4CNG2PDMqBe9D4s//UuPmDc/MuqEoE56au/zUwAwuc1kEngxB7XfzZwYFChxPPr2j4n1hqfAiYqYTpVoQNIYwXu4N3tNRkIAeHLW951SQf0rE+1xm+lFN5GQWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WICDhprr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UGkxGm014835;
	Tue, 1 Oct 2024 03:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	inn6pO+Fjh05RegTl6KsvviU/A4xm8resPRjG9kBF58=; b=WICDhprrcU9Auxw4
	sGlO5MrBqhn+xrxUg81fNWPYGW1WFyTV0N72O1bL+tB9O/QQ6c/dtmEGyhLyqIpY
	qwdG5eR1HbwmrGFAziZSmxq6mNphG9hzlZx9EoYk3kwG3pU4j8LdjoZQTEyNdrb1
	HW8cADWzDsCl4p4CwgBCQ7/lXUcu3ie0oK/pHiIXPzPjwuaQ3WafXN5ZsZ5Q0m9c
	lz1IxCOAjp4euDwsXHFc4jQXvnCmCUJKVkyYYXNJR5pGTobHwwAxd+6FvvwGeWy/
	MCe52BTgBIN6mhBHY1DtzxYGySgHA3G9eOqW28/Skh8714L+1wsI/Gsz/HijX8UC
	+2t3gA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41yprak25c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:31:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4913VMuQ026727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 03:31:22 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 20:31:20 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: net: wireless: ath11k: add firmware-name property
Date: Tue, 1 Oct 2024 11:30:51 +0800
Message-ID: <20241001033053.2084360-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xbHNDaSRKO9rD-P8OLQtQMDG3-S5MqDX
X-Proofpoint-ORIG-GUID: xbHNDaSRKO9rD-P8OLQtQMDG3-S5MqDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010023

This is the same optional property that defined in qcom,ath10k.yaml. It's
useful for the platform / board to specify firmware through device-tree.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index ff5763dc66a8..2f9fa96cbed1 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k.yaml#
@@ -61,6 +62,12 @@ properties:
 
   ieee80211-freq-limit: true
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup firmware
+      files for the device.
+
   wifi-firmware:
     type: object
     description: |
-- 
2.25.1


