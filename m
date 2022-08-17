Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F42596CF3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiHQKms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiHQKmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 06:42:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91542719A6
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 03:42:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HAgcvQ017819;
        Wed, 17 Aug 2022 10:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pyfUddjTOuQAKFwNh7FVZu8Pp5Qo+JD8pjyjHD1ulko=;
 b=Kx0KXjE0HCnKpRd8x3hBxp1DLEZe60SS+CDcB9u67ZfWch1BEqkGbOINO82bLSiQJiaW
 OfTm1L/eNI1UYSexqLWBHGaDV9KP9i0Dx+h2aUye7LRRFsROr1bQOzkeQ0h0q/kTg9Hn
 bQQyfSgRU3ZytkVMG7U5/OiFRoK1Xg70crG7rWJIIHplyfXBj0UBybpSgh5nptwrbRKA
 gVvPG1XQtVoevNAnO41Y1nsTzS2XsQrkhqzEvGyCZl5knmhZKfkQpDP8jtgrU9nGGuBy
 SQGhsIyIo4845Zo3YHYJk66csRKzPbc3nL3wc6ChjARsjwXMRXATh12gbeNYCFj1tDK1 7w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j05ev5uwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:42:38 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27HAgbmm008363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 10:42:37 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:37 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 17 Aug 2022 03:42:36 -0700
From:   Vasanthakumar <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Subject: [PATCH 1/2] wifi: mac80211: add link information in ieee80211_rx_status
Date:   Wed, 17 Aug 2022 16:12:12 +0530
Message-ID: <20220817104213.2531-2-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
References: <20220817104213.2531-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yw5vHuOY_SiY2vJjAQpLkriQGmSSExyA
X-Proofpoint-GUID: yw5vHuOY_SiY2vJjAQpLkriQGmSSExyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=745
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

In MLO, when the address translation from link to MLD is done
in fw/hw, it is necessary to be able to have some information
on the link on which the frame has been received. Extend the
rx API to include link_id and a valid flag in ieee80211_rx_status.
Also make chanes to mac80211 rx APIs to make use of the reported
link_id after sanity checks.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/net/mac80211.h |  5 +++
 net/mac80211/rx.c      | 95 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f198af600b5e..703f811c4711 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1480,6 +1480,10 @@ enum mac80211_rx_encoding {
  *	each A-MPDU but the same for each subframe within one A-MPDU
  * @ampdu_delimiter_crc: A-MPDU delimiter CRC
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
+ * @link_valid: if the link which is identified by @link_id is valid. This flag
+ *	is set only when connection is MLO.
+ * @link_id: id of the link used to receive the packet. This is used along with
+ *	@link_valid.
  */
 struct ieee80211_rx_status {
 	u64 mactime;
@@ -1504,6 +1508,7 @@ struct ieee80211_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	u8 ampdu_delimiter_crc;
 	u8 zero_length_psdu_type;
+	u8 link_valid:1, link_id:4;
 };
 
 static inline u32
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 57df21e2170a..80f2e3bc5e70 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4508,6 +4508,15 @@ void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->sta_mtx);
 }
 
+static bool
+ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
+{
+	if (!sta->mlo)
+		return false;
+
+	return !!(sta->valid_links & BIT(link_id));
+}
+
 static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 			      struct ieee80211_fast_rx *fast_rx,
 			      int orig_len)
@@ -4827,6 +4836,7 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 				       struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_fast_rx *fast_rx;
 	struct ieee80211_rx_data rx;
 
@@ -4847,7 +4857,31 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 
 	rx.sta = container_of(pubsta, struct sta_info, sta);
 	rx.sdata = rx.sta->sdata;
-	rx.link = &rx.sdata->deflink;
+
+	if (status->link_valid &&
+	    !ieee80211_rx_is_valid_sta_link_id(pubsta, status->link_id))
+		goto drop;
+
+	/*
+	 * TODO: Should the frame be dropped if the right link_id is not
+	 * available? Or may be it is fine in the current form to proceed with
+	 * the frame processing because with frame being in 802.3 format,
+	 * link_id is used only for stats purpose and updating the stats on
+	 * the deflink is fine?
+	 */
+	if (status->link_valid)
+		rx.link_id = status->link_id;
+
+	if (rx.link_id >= 0) {
+		struct ieee80211_link_data *link;
+
+		link =  rcu_dereference(rx.sdata->link[rx.link_id]);
+		if (!link)
+			goto drop;
+		rx.link = link;
+	} else {
+		rx.link = &rx.sdata->deflink;
+	}
 
 	fast_rx = rcu_dereference(rx.sta->fast_rx);
 	if (!fast_rx)
@@ -4877,7 +4911,19 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 		rx->sta = link_sta->sta;
 		rx->link_id = link_sta->link_id;
 	} else {
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+
 		rx->sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		if (rx->sta) {
+			if (status->link_valid &&
+			    !ieee80211_rx_is_valid_sta_link_id(&rx->sta->sta,
+							       status->link_id))
+				return false;
+
+			rx->link_id = status->link_valid ? status->link_id : -1;
+		} else {
+			rx->link_id = -1;
+		}
 	}
 
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
@@ -4893,6 +4939,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					 struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_hdr *hdr;
 	__le16 fc;
@@ -4937,10 +4984,39 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 	if (ieee80211_is_data(fc)) {
 		struct sta_info *sta, *prev_sta;
+		u8 link_id = status->link_id;
 
 		if (pubsta) {
 			rx.sta = container_of(pubsta, struct sta_info, sta);
 			rx.sdata = rx.sta->sdata;
+
+			if (status->link_valid &&
+			    !ieee80211_rx_is_valid_sta_link_id(pubsta, link_id))
+				goto out;
+
+			if (status->link_valid)
+				rx.link_id = status->link_id;
+
+			/*
+			 * In MLO connection, fetch the link_id using addr2
+			 * when the driver does not pass link_id in status.
+			 * When the address translation is already performed by
+			 * driver/hw, the valid link_id must be passed in
+			 * status.
+			 */
+
+			if (!status->link_valid && pubsta->mlo) {
+				struct ieee80211_hdr *hdr = (void *)skb->data;
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					goto out;
+
+				rx.link_id = link_sta->link_id;
+			}
+
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
 			goto out;
@@ -4954,6 +5030,13 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				continue;
 			}
 
+			if ((status->link_valid &&
+			     !ieee80211_rx_is_valid_sta_link_id(&prev_sta->sta,
+								link_id)) ||
+			    (!status->link_valid && prev_sta->sta.mlo))
+				continue;
+
+			rx.link_id = status->link_valid ? link_id : -1;
 			rx.sta = prev_sta;
 			rx.sdata = prev_sta->sdata;
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
@@ -4962,6 +5045,13 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		}
 
 		if (prev_sta) {
+			if ((status->link_valid &&
+			     !ieee80211_rx_is_valid_sta_link_id(&prev_sta->sta,
+								link_id)) ||
+			    (!status->link_valid && prev_sta->sta.mlo))
+				goto out;
+
+			rx.link_id = status->link_valid ? link_id : -1;
 			rx.sta = prev_sta;
 			rx.sdata = prev_sta->sdata;
 
@@ -5104,6 +5194,9 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 		}
 	}
 
+	if (WARN_ON_ONCE(status->link_id >= IEEE80211_LINK_UNSPECIFIED))
+		goto drop;
+
 	status->rx_flags = 0;
 
 	kcov_remote_start_common(skb_get_kcov_handle(skb));
-- 
2.17.1

