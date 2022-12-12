Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A85A649A23
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 09:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiLLIhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 03:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiLLIgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 03:36:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2BDFC8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 00:36:49 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC7Smn4011817;
        Mon, 12 Dec 2022 08:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zSsSrMavnr2QQ0fZ6L2RfBsL+8OLTpE4t6Xwq6UO/Ys=;
 b=lH7DQEzIIxzdhQg1ZP+E2ETtELdwzCYTFN6dkOcW+5cI6Lx6fPjSf9XDRvyyPI4XUVBt
 4BidInjcwcReyMaCRMDM+0UYgP02BzhM2WJ3HoK93Zn73uBJEtwdsOW2Ih0gQdlvY+U7
 htcrY3ehgC8hYJ1RIRdSHYrNDB/qxr6fv64ilrKSa7HAC+bfyHK3gNr+fWe1QuDhC9tG
 E9l6L9UZmgsLIeCAnBJaniYEmyOk8TkPQGBb6va3bdIp766Xe27XRepK8WEZrwAE+Ntb
 yNyBYlDYZPy/rQ9CA4Ec8WztLONx4e8XekRk5wg4dijSpTB++XyelmxD0TSK95Vygy1z pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mch4euk3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 08:36:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BC8agro020750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 08:36:42 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 12 Dec 2022 00:36:40 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: mac80211: change initialize for sk_buff in ieee80211_tx_dequeue()
Date:   Mon, 12 Dec 2022 03:36:07 -0500
Message-ID: <20221212083607.21536-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pEZLZMwcyTKWKV-QH7rnipQFVdDzOJW6
X-Proofpoint-ORIG-GUID: pEZLZMwcyTKWKV-QH7rnipQFVdDzOJW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_01,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=697
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sk_buff is only set to NULL when initialize, sometimes it will goto
label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
which is already freed. If it run into the "goto out" after arrived to
label "begin", then it will return a sk_buff which is freed, it is a
risk for use-after-free.

Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers without holding fq->lock")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2171cd1ca807..0b23cc9ab9c7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3776,7 +3776,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = container_of(txq, struct txq_info, txq);
 	struct ieee80211_hdr *hdr;
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb;
 	struct fq *fq = &local->fq;
 	struct fq_tin *tin = &txqi->tin;
 	struct ieee80211_tx_info *info;
@@ -3790,6 +3790,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		return NULL;
 
 begin:
+	skb = NULL;
+
 	spin_lock_bh(&fq->lock);
 
 	if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||

base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.31.1

