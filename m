Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35337722565
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFEMRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjFEMRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 08:17:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30DD2
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 05:17:52 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BIhBt027804;
        Mon, 5 Jun 2023 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ezuaKV7Ru7fkEQ4TT3CPshNPRFEfkXnKNCJBLNuM5lI=;
 b=AyBGTbSRbzeT3uICV9FMv1FHeFGX66jvffZTisAQMzZg1gkRJQDAtBZQi6DFXpo3uFDz
 pGgqtMpkO1zcBFJqSjOBVlIGdB4xn3WpoHbPEuMTSWJgC0BHfsP4zlzEAX1s/i7Kw7r4
 7fNApqRJISqk/UBZJtyrpQ30ApsRsGrL0IrTqOVc2XYOe7mipsUpJkr8dRtnifiiwqyq
 63J5iWsKxnZalpI7fTWGftaBEBjVrTJ7hLoiL2TzDCReMjTm1KLMqSibsih0xGpyN3i2
 aHhpC+rZeI5vcMgbiWdrUJP+A+jP/pTMRhjDTQgoNlv37MnDVb9Bd2yoE+Bd+fsCRXIX ZA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qyw46bjrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 12:17:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 355CHiBE015696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 12:17:44 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 05:17:42 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 1/3] wifi: mac80211: Fix tkip encrypted packet transmission path
Date:   Mon, 5 Jun 2023 17:47:20 +0530
Message-ID: <20230605121722.20797-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605121722.20797-1-quic_aarasahu@quicinc.com>
References: <20230605121722.20797-1-quic_aarasahu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K6-xvr-0aimn4QKdeWQE-4dwEZwG0KOg
X-Proofpoint-GUID: K6-xvr-0aimn4QKdeWQE-4dwEZwG0KOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=988 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>

Currently, TKIP encrypted packets are transmitting through fast path
and fast_tx, fast_rx is not assigned in case of TKIP cipher so
packet is dropped during ping.

Fix this issue by sending TKIP encrypted packets through normal path

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 net/mac80211/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dfe6b9c9b29e..2d9af96783f1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4681,8 +4681,7 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	if (!key)
 		key = rcu_dereference(sdata->default_unicast_key);
 
-	if (key && (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) ||
-		    key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
+	if (key && (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)))
 		goto skip_offload;
 
 	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
-- 
2.17.1

