Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D8727833
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjFHHIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 03:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjFHHIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 03:08:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C2137
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 00:08:36 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3586UMjG018697;
        Thu, 8 Jun 2023 07:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ezuaKV7Ru7fkEQ4TT3CPshNPRFEfkXnKNCJBLNuM5lI=;
 b=d+ORN5hlvLsFZiG/eDqmtt9TKit9nhvHqdpi/TcqWlbz5QbJEI1e6GdvjwK2rEANkJmw
 /slGAGKq9JCai1gPmEdvDtV0tvoY7BZM0F8OFkdjiD5S6FLKoIjf4KN2mQsmxa7jcVlW
 lEbORqecj39NEvRR28CFa1tMpc7TDc+YFs38uDAUa8nigDNUoqiqA9eMTQAhcI/CoSCb
 9KEOZaAC8Lx74il/XY9tZM8+8FQxOb7TeaSCWBj5oVrNLNd+6D4ZxsQHu3ow3SIF2AcR
 iY0uZwTR4xVyQK9NvWTD6p6NXG2sZUTPpeYjICM/Lmjg1uBz/2FZAQ+w2//kVEYUh9Cd Ww== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33uygk80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 07:08:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35878J75015361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 07:08:20 GMT
Received: from aarasahu-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 8 Jun 2023 00:08:18 -0700
From:   Aaradhana Sahu <quic_aarasahu@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH v2 1/3] wifi: mac80211: Fix tkip encrypted packet transmission path
Date:   Thu, 8 Jun 2023 12:37:52 +0530
Message-ID: <20230608070754.7161-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608070754.7161-1-quic_aarasahu@quicinc.com>
References: <20230608070754.7161-1-quic_aarasahu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M0nGb7tR_An59GHohdb2QW0nvlelvm6m
X-Proofpoint-ORIG-GUID: M0nGb7tR_An59GHohdb2QW0nvlelvm6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=991
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

