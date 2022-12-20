Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F919651EA9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiLTKUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 05:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTKUi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 05:20:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E077C16
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 02:20:36 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK7Oc3w027435;
        Tue, 20 Dec 2022 10:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=f0zNRHLa0LuAjyM3HtBA8mT0JPE4vYwJ/YDTqTzs/og=;
 b=EzoDAKOwmp1pyJavoFLJk/wH2w7ZZSDRBwQMgb+2t3daUQAzIzHh4my0V+F57UzzctD3
 w9tj38xXNqfnKb1KyelqVFYDt59rCLgUOjuS4+560OwAXoUT6+z1+tTum5+WYdK54qwh
 Tfz7zbWysH94reFkow4KCM/GNmUUUosLxtPqoLmeA6EZyEpKhgtFjUD0uhW8zPqcI6A1
 zx3mNRO993xxjext7vLLnuElw2gQfwZDPB0M+vZ/CCyo2T9jIsZAyEpOMIAaWSdS6neL
 pktjjxW95Fh9DiowMZwC5bz4uTct8dKywE/2bxDy+JqSnIs2b9y4v3wJ/gmIIMBeWxBD Gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk8mn0c7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 10:19:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BKAJRRM000515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 10:19:27 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 02:19:26 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath11k: add channel 177 into 5 GHz channel list
Date:   Tue, 20 Dec 2022 05:19:12 -0500
Message-ID: <20221220101912.30816-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qtfm7Pzm7wHoOCid1vaxn2pUenOCZ_F4
X-Proofpoint-GUID: Qtfm7Pzm7wHoOCid1vaxn2pUenOCZ_F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_03,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for the 5 GHz channel 177 with center frequency 5885 MHz and
operating class 125 per IEEE Std 802.11ax-2021, Table E-4.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 4 ++--
 drivers/net/wireless/ath/ath11k/mac.c  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a8acb8b7b8d5..1abd2a4c1bd6 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -520,8 +520,8 @@ struct ath11k_sta {
 #define ATH11K_MIN_5G_FREQ 4150
 #define ATH11K_MIN_6G_FREQ 5925
 #define ATH11K_MAX_6G_FREQ 7115
-#define ATH11K_NUM_CHANS 101
-#define ATH11K_MAX_5G_CHAN 173
+#define ATH11K_NUM_CHANS 102
+#define ATH11K_MAX_5G_CHAN 177
 
 enum ath11k_state {
 	ATH11K_STATE_OFF,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b198edba76eb..317b8ab734ff 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -96,6 +96,7 @@ static const struct ieee80211_channel ath11k_5ghz_channels[] = {
 	CHAN5G(165, 5825, 0),
 	CHAN5G(169, 5845, 0),
 	CHAN5G(173, 5865, 0),
+	CHAN5G(177, 5885, 0),
 };
 
 static const struct ieee80211_channel ath11k_6ghz_channels[] = {

base-commit: 58e4b9df840cad439a4c878f81bc105cac2197a7
-- 
2.31.1

