Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0941B5A4C8E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiH2MzF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 08:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH2Myg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 08:54:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9343313F83;
        Mon, 29 Aug 2022 05:44:04 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TBQEpF021570;
        Mon, 29 Aug 2022 12:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cK+q4IMfolQrGElm8ZRsIJD8/YAVzHULObkFxpXdCeM=;
 b=DxcN9KbG0zCe98LX2FMR1XAeSKbjmnhTwBxizH5Svz7t5QWEk1w13IMlIalFwrntLdII
 H/WwOiPa3gZr/pVPPV3w/H/0aiLQ7VHDK5tVP44x0C3up5I3Z/17HfGRCObi77dcDYXv
 +X/s/grI+C+eNoSTq6Cy7ShAH6n0shlsrZRelI3E5UWknowQvtg3KhSUzqU7WEH0W45c
 3Mpei/WnBrB9n9SzUi2peZzhPHPibFQ+4cotYXj9QPJaLLxWAPbMv35q3ai54UHXxyGf
 nNh3pC8uefOXAOdQbC1MrDepeqlq6mgK6VivxXRDLrm40MxMbOzBB7hahmF6mdPp4oph ZQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j8vjgg4yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27TChkjm005262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 12:43:46 GMT
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 29 Aug 2022 05:43:44 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 1/2] dt: bindings: net: add bindings to add WoW support for WCN6750
Date:   Mon, 29 Aug 2022 18:13:22 +0530
Message-ID: <20220829124323.26874-2-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
References: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lJ4p90ENCA8aIVT9tkzp1CR1Dh3tfCz_
X-Proofpoint-GUID: lJ4p90ENCA8aIVT9tkzp1CR1Dh3tfCz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=3 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add required bindings to support WoW (Wake on Wireless) for
WCN6750 which is based on ath11k driver.

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../bindings/net/wireless/qcom,ath11k.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a677b056f112..307a5b9d1588 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -66,6 +66,14 @@ properties:
     required:
       - iommus
 
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: State bits used in WCN6750 to signal the firmware
+                 to exit from WoW.
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+
 required:
   - compatible
   - reg
@@ -410,6 +418,13 @@ examples:
         };
     };
 
+    smp2p-wpss {
+        wlan_smp2p_out: wlan_smp2p_out {
+                qcom,entry-name = "wlan";
+                #qcom,smem-state-cells = <1>;
+        };
+    };
+
     wifi: wifi@17a10040 {
         compatible = "qcom,wcn6750-wifi";
         reg = <0x17a10040 0x0>;
@@ -448,6 +463,8 @@ examples:
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

