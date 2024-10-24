Return-Path: <linux-wireless+bounces-14439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D299AD8F2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4851F233ED
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6B18035;
	Thu, 24 Oct 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YKIbY8zF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CEC8F0;
	Thu, 24 Oct 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729595; cv=none; b=Pnq6RaJYmzTf8mVr/NVtHKYd0YX428IfmU241Our9/Ctz6LVkFQxZvqNUPtrpowR05x2HH5FGFRcS73wbnhVzAolQ63rawsVhPaMk2U68mxZMO+LHG2mCG9+LYgS3Wauf7HqQR+ZfAhOybBoVhSQOaj+jrdsLzc0j/LGR/gahDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729595; c=relaxed/simple;
	bh=YrpthfNQ+GbzT8ZULqGupYFXckIUsqgDSEk29sp/mao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jh2/OFcIo6OSlhTp31XjkHPgnePU4+rIjb6Xj7uAL/5GXgNkKhL55KvXjWdrBt4aVTZGGoDyYt+vQw1WRfwiGuvVxMN4WxNsh/vUQUo5fTSTum/7uB7ShNTcENv3ht7Y1hg4Wj+bzvB/6iI8xhnq3pcbkW69MRv5Utfqaj600fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YKIbY8zF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NMZ7U8009410;
	Thu, 24 Oct 2024 00:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nveTTtWi/IOzGp+i8IafJAXKLu4PpCQzTMgEOopL/30=; b=YKIbY8zF9m81YdLY
	eDqZgjebdjMgDPxKaAgnrrAtJpxJb7zTMeCqHuC354iKKOYCFfTHG++Waf7vsoYg
	AE4YpT0uWzVbkOSzBF1NigyG2kV8kq4bI4JsRfRRVtvJs9oHDz+Ql+5Hvmrq10IU
	ormAlqoo8Soe7tqvZNoLPfwNbyMKAJn7zBPmuiFlY3blUAmvFSZRlPyo1GHjOb91
	kfUtQlBQ0Wm4izjU7G0WD7SrD2H1zksUSo72hWKRJjo5Att7KBM3FBKmJ3n8yBtP
	58y9TZEzEJIbOjaP8Ja3nFWx4Ap9YFZYey4XOSXJTQgKIKfuUzxMDXuqa1x22reH
	rd9iow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em43bu7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O0QOTI007707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:24 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 17:26:22 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: net: wireless: ath11k-pci: add firmware-name property
Date: Thu, 24 Oct 2024 08:25:13 +0800
Message-ID: <20241024002514.92290-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-GUID: GzuOzPjS9vULtfaAwblaFWC9LftpY708
X-Proofpoint-ORIG-GUID: GzuOzPjS9vULtfaAwblaFWC9LftpY708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240000

This is the same optional property that defined in qcom,ath10k.yaml. It's
useful for the platform / board to specify firmware through device-tree.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index a71fdf05bc1e..2aa81690f7d5 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2023 Linaro Limited
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
@@ -29,6 +30,12 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup firmware
+      files for the device.
+
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
-- 
2.25.1


