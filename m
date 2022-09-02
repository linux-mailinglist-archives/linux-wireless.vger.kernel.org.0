Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5465AADB5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiIBLbo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIBLbV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 07:31:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E12ED57;
        Fri,  2 Sep 2022 04:28:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282AZ0HU011955;
        Fri, 2 Sep 2022 11:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GFKlOK2MHqrQ4/ulA3KE7mAQxG5Fey86F/oL7hzKte8=;
 b=NEGy2A1TfEjXOrXdkqS+x3BxIIez01KhJPdu9lZ07z76973AADudc95gD4dPN1hlgtzY
 M/9tZBaC076yi1AxLyCOVqz6oxySta+4NfMBlXy4OXulAzCyjZHw1R0Urzb9M1uPn+8o
 z+7FUygvzbvIVPdMnIrqTXX508Ecfk8YlKK8sMmgnDtsEq40YrKxhVSzBSsfVsGttVL2
 ZfDHB13t6Lmd9/4VEHmQ9oRh2RGq2xDfSUh0QdtssXcsuWTln/4V17oISWa8S80UhwX2
 dsXNcaTYo/BKsJ1iZjC6+e5tORcY/LQfKwzux1212X8a1ZEjrA0rH1dcHfJqZqyh1Dg4 9A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb7hasmj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 11:28:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282BS35Z006226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 11:28:03 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 2 Sep 2022 04:28:01 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Manikanta Pubbisetty" <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 1/2] dt: bindings: net: add bindings to add WoW support on WCN6750
Date:   Fri, 2 Sep 2022 16:55:19 +0530
Message-ID: <20220902112520.24804-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
References: <20220902112520.24804-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cG38xICLmF4NTy4KzXm4Bsm1aJlNAn2o
X-Proofpoint-ORIG-GUID: cG38xICLmF4NTy4KzXm4Bsm1aJlNAn2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add required bindings to support WoW (Wake on Wireless) on
WCN6750 which is based on ath11k driver.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../bindings/net/wireless/qcom,ath11k.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a677b056f112..f7cf135aa37f 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -66,6 +66,18 @@ properties:
     required:
       - iommus
 
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: State bits used by the AP to signal the WLAN Q6.
+    items:
+      - description: Signal bits used to enable/disable low power mode
+                     on WCN6750 in the case of WoW (Wake on Wireless).
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output.
+    items:
+      - const: wlan-smp2p-out
+
 required:
   - compatible
   - reg
@@ -448,6 +460,8 @@ examples:
                      <GIC_SPI 799 IRQ_TYPE_EDGE_RISING>;
         qcom,rproc = <&remoteproc_wpss>;
         memory-region = <&wlan_fw_mem>, <&wlan_ce_mem>;
+        qcom,smem-states = <&wlan_smp2p_out 0>;
+        qcom,smem-state-names = "wlan-smp2p-out";
         wifi-firmware {
                 iommus = <&apps_smmu 0x1c02 0x1>;
         };
-- 
2.37.1

