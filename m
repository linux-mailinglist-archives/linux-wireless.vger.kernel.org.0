Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5E575BC56
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGUCfQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 22:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGUCfO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 22:35:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD22691
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 19:35:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2NJhI010077;
        Fri, 21 Jul 2023 02:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=sV5mVQTFSBAoKndgZvN2bZw+Ayay3SN5ehEHo7rCePQ=;
 b=l4kPyJwNd3sTtYcY+XAZjS/+k+/aN54bcItVCJy4H62z8S+sSeqL1eNXxo4t/sIDXBmK
 7OyiBeiMM0bJ1B+TrJHGySt4NoXpmw1CnPuFqlhZX4JWXmSz2wdWNWedN2vNrdEbBp5R
 uRxgHdmj4e8cot0lzeKrjJSbYKHajH5j/0GFH1UrsBnWrYVjjpNqeJuDxwxhhYGLdJsD
 0xGhBllwnWzBQJZhaStrBLCoZrhF4mB2RjOaqUigCDlmb1GmopQuK6XFI/I7OF6/QFGN
 lGKdELpbbRh9F6yasBmDq/6EYn2UVYJkNUsGzOB6oHuDfBzD4AKmhBHUo0TpCsJJoQiW yQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxt18b1yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2Z1v0003017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:35:01 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 19:35:00 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 1/3] wifi: ath12k: Flush all packets before suspend
Date:   Fri, 21 Jul 2023 10:34:44 +0800
Message-ID: <20230721023446.3706-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721023446.3706-1-quic_bqiang@quicinc.com>
References: <20230721023446.3706-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3AkhWk55wVC5jCBLOSvFyFelOGe_V5td
X-Proofpoint-GUID: 3AkhWk55wVC5jCBLOSvFyFelOGe_V5td
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to send out all packets before going to suspend, current code
adds a 500ms delay as a workaround. It is a rough estimate and may not
work.

The logic of the fix is to check packet counters, if counters become
zero, then all packets are sent out or dropped.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 17 +++++++---
 drivers/net/wireless/ath/ath12k/mac.c  | 44 +++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/mac.h  |  1 +
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3df8059d5512..73065d38be2d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -21,15 +21,22 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
 int ath12k_core_suspend(struct ath12k_base *ab)
 {
-	int ret;
+	struct ath12k *ar;
+	int ret, i;
 
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
-	/* TODO: there can frames in queues so for now add delay as a hack.
-	 * Need to implement to handle and remove this delay.
-	 */
-	msleep(500);
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+		ret = ath12k_mac_wait_tx_complete(ar);
+		if (ret) {
+			ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
+			return ret;
+		}
+	}
 
 	ret = ath12k_dp_rx_pktlog_stop(ab, true);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1bb9802ef569..3e472afe09b1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6017,27 +6017,49 @@ static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-				u32 queues, bool drop)
+static int ath12k_mac_flush_tx_complete(struct ath12k *ar)
 {
-	struct ath12k *ar = hw->priv;
 	long time_left;
-
-	if (drop)
-		return;
+	int ret = 0;
 
 	time_left = wait_event_timeout(ar->dp.tx_empty_waitq,
 				       (atomic_read(&ar->dp.num_tx_pending) == 0),
 				       ATH12K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath12k_warn(ar->ab, "failed to flush transmit queue %ld\n", time_left);
+	if (time_left == 0) {
+		ath12k_warn(ar->ab,
+			    "failed to flush transmit queue, data pkts pending %d\n",
+			    atomic_read(&ar->dp.num_tx_pending));
+		ret = -ETIMEDOUT;
+	}
 
 	time_left = wait_event_timeout(ar->txmgmt_empty_waitq,
 				       (atomic_read(&ar->num_pending_mgmt_tx) == 0),
 				       ATH12K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath12k_warn(ar->ab, "failed to flush mgmt transmit queue %ld\n",
-			    time_left);
+	if (time_left == 0) {
+		ath12k_warn(ar->ab,
+			    "failed to flush mgmt transmit queue, mgmt pkts pending %d\n",
+			    atomic_read(&ar->num_pending_mgmt_tx));
+		ret = -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+int ath12k_mac_wait_tx_complete(struct ath12k *ar)
+{
+	ath12k_mac_drain_tx(ar);
+	return ath12k_mac_flush_tx_complete(ar);
+}
+
+static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+				u32 queues, bool drop)
+{
+	struct ath12k *ar = hw->priv;
+
+	if (drop)
+		return;
+
+	ath12k_mac_flush_tx_complete(ar);
 }
 
 static int
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 57f4295420bb..d0d48133e926 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -73,4 +73,5 @@ int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 enum rate_info_bw ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw);
 enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
+int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 #endif
-- 
2.25.1

