Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A735BCB85
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiISMMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiISMMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 08:12:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80468A1B7
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 05:12:12 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J8Ii4F009247;
        Mon, 19 Sep 2022 12:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=T4jwKNSPgfdG/oaSUFg7J31xSxRg48n34avFdwEcAV8=;
 b=R5AUiG+9xkjJ9x0Xbus0+9Pi3qcmedpjSwmiusDyUjynJw+AErk9mhylB4kRRNBPecEk
 UWBplhyUhoz1alrT+D8NugpOyLD/Vdh2+/U2Bq+2yxJIsimbB7+Hin4bdBrBINl70hH1
 m3JYtQ9cgAqCN81tL1n9e6SUMYc71bj3HEMTb/x3tsrrTA9EhuoNi76OuDndK/3yfxqW
 i6KK86UqC7KEAdvMStzpeD6/9hqfjcWbSgh9cQKHxozY5OwrCdsBPHoSKmdhzZxwCrMn
 GXmCTrQ1UI7d/cfnAKHJC8mrWuyl3GuTUoGLP7oHJBNLWIpqvgHWFBeF2I1bJUrwBuwb gQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6f84jux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JCC8E5020125
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:08 GMT
Received: from u20-san1p10030.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 05:12:07 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/4] wifi: mac80211: Add support for randomizing auth and deauth frames TA
Date:   Mon, 19 Sep 2022 05:11:53 -0700
Message-ID: <20220919121155.3069765-2-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
References: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9CT4wJlWCWaxrrYvQqxQL1LYF1RTMOT5
X-Proofpoint-ORIG-GUID: 9CT4wJlWCWaxrrYvQqxQL1LYF1RTMOT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure randomized transmit address of the authentication frames to
the driver when advertise NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA
to enable receive behavior to accept frames with the same random MAC
address as RA also those frames need to be acknowledged similarly to the
frames sent to the local permanent MAC address. Disable the random MAC
address configuration when deauthentication frames with same random MAC
address received or transmitted.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/mac80211.h    |  9 ++++++++
 net/mac80211/driver-ops.h | 10 +++++++++
 net/mac80211/main.c       |  5 +++++
 net/mac80211/rx.c         | 45 ++++++++++++++++++++++++++++++++++-----
 net/mac80211/trace.h      | 19 +++++++++++++++++
 net/mac80211/tx.c         | 27 +++++++++++++++++++++++
 6 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..662b5db84fe3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1832,6 +1832,7 @@ struct ieee80211_vif_cfg {
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
  * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
+ * @random_addr: random address in use for this interface.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1861,6 +1862,8 @@ struct ieee80211_vif {
 
 	struct ieee80211_vif *mbssid_tx_vif;
 
+	u8 random_addr[ETH_ALEN] __aligned(2);
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -4164,6 +4167,11 @@ struct ieee80211_prep_tx_info {
  *	Note that a sta can also be inserted or removed with valid links,
  *	i.e. passed to @sta_add/@sta_state with sta->valid_links not zero.
  *	In fact, cannot change from having valid_links and not having them.
+ * @config_random_mac: Configure random MAC address to send acknowledgment when
+ *	RA of the received frame matches with configured random MAC address.
+ *	Also, clear random MAC address configuration if zero MAC address set.
+ *	Driver must register callback for this when advertise
+ *	%NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4519,6 +4527,7 @@ struct ieee80211_ops {
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
 				u16 old_links, u16 new_links);
+	void (*config_random_mac)(struct ieee80211_hw *hw, const u8 *mac_addr);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 81e40b0a3b16..ea2cd8048638 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1479,4 +1479,14 @@ int drv_change_sta_links(struct ieee80211_local *local,
 			 struct ieee80211_sta *sta,
 			 u16 old_links, u16 new_links);
 
+static inline void drv_config_random_mac(struct ieee80211_local *local,
+					 const u8 *mac_addr)
+{
+	if (local->ops->config_random_mac) {
+		trace_drv_config_random_mac(local, mac_addr);
+		local->ops->config_random_mac(&local->hw, mac_addr);
+		trace_drv_return_void(local);
+	}
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 46f3eddc2388..707b38865227 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -953,6 +953,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	     !local->ops->tdls_recv_channel_switch))
 		return -EOPNOTSUPP;
 
+	if ((hw->wiphy->features &
+	     NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA) &&
+	    !local->ops->config_random_mac)
+		return -EOPNOTSUPP;
+
 	if (WARN_ON(ieee80211_hw_check(hw, SUPPORTS_TX_FRAG) &&
 		    !local->ops->set_frag_threshold))
 		return -EINVAL;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a57811372027..e76653795c1c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4211,6 +4211,21 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
 	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
 			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool skip_addr1_check = false;
+
+	if ((ieee80211_is_auth(hdr->frame_control) ||
+	     ieee80211_is_deauth(hdr->frame_control)) &&
+	    wiphy_ext_feature_isset(
+		   sdata->local->hw.wiphy,
+		   NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA) &&
+	    ether_addr_equal(sdata->vif.random_addr, hdr->addr1)) {
+		skip_addr1_check = true;
+		if (ieee80211_is_deauth(hdr->frame_control)) {
+			eth_zero_addr(sdata->vif.random_addr);
+			drv_config_random_mac(sdata->local,
+					      rx->sdata->vif.random_addr);
+		}
+	}
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -4220,6 +4235,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (skip_addr1_check)
+			return true;
 		return ieee80211_is_our_addr(sdata, hdr->addr1, &rx->link_id);
 	case NL80211_IFTYPE_ADHOC:
 		if (!bssid)
@@ -4232,7 +4249,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return true;
 		if (!ieee80211_bssid_match(bssid, sdata->u.ibss.bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->vif.addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4252,7 +4269,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (!is_broadcast_ether_addr(bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4270,10 +4287,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (skip_addr1_check)
+			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_AP:
-		if (!bssid)
+		if (!bssid && !skip_addr1_check)
 			return ieee80211_is_our_addr(sdata, hdr->addr1,
 						     &rx->link_id);
 
@@ -4285,7 +4304,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 * and location updates. Note that mac80211
 			 * itself never looks at these frames.
 			 */
-			if (!multicast &&
+			if (!multicast && !skip_addr1_check &&
 			    !ieee80211_is_our_addr(sdata, hdr->addr1,
 						   &rx->link_id))
 				return false;
@@ -4657,6 +4676,21 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	} addrs __aligned(2);
 	struct link_sta_info *link_sta;
 	struct ieee80211_sta_rx_stats *stats;
+	bool skip_addr1_check = false;
+
+	if ((ieee80211_is_auth(hdr->frame_control) ||
+	     ieee80211_is_deauth(hdr->frame_control)) &&
+	    wiphy_ext_feature_isset(
+		   rx->sdata->local->hw.wiphy,
+		   NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA) &&
+	    ether_addr_equal(rx->sdata->vif.random_addr, hdr->addr1)) {
+		skip_addr1_check = true;
+		if (ieee80211_is_deauth(hdr->frame_control)) {
+			eth_zero_addr(rx->sdata->vif.random_addr);
+			drv_config_random_mac(rx->sdata->local,
+					      rx->sdata->vif.random_addr);
+		}
+	}
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
@@ -4690,7 +4724,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	 * punting here will make it go through the full checks in
 	 * ieee80211_accept_frame().
 	 */
-	if (!ether_addr_equal(fast_rx->vif_addr, hdr->addr1))
+	if (!skip_addr1_check &&
+	    !ether_addr_equal(fast_rx->vif_addr, hdr->addr1))
 		return false;
 
 	if ((hdr->frame_control & cpu_to_le16(IEEE80211_FCTL_FROMDS |
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9f4377566c42..4996fd5a6887 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3026,6 +3026,25 @@ TRACE_EVENT(stop_queue,
 	)
 );
 
+TRACE_EVENT(drv_config_random_mac,
+	TP_PROTO(struct ieee80211_local *local,
+		 const u8 *mac_addr),
+
+	TP_ARGS(local, mac_addr),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__array(char, mac_addr, ETH_ALEN)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		memcpy(__entry->mac_addr, mac_addr, ETH_ALEN);
+	),
+
+	TP_printk(LOCAL_PR_FMT ", addr:%pM", LOCAL_PR_ARG, __entry->mac_addr)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 24c0a1706b92..76e2457050cb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2048,6 +2048,7 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	int headroom;
 	enum ieee80211_encrypt encrypt;
+	bool our_addr = true;
 
 	if (info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)
 		encrypt = ENCRYPT_NO;
@@ -2071,6 +2072,32 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 	hdr = (struct ieee80211_hdr *) skb->data;
 	info->control.vif = &sdata->vif;
 
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_OCB:
+		if (!ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			our_addr = false;
+		break;
+	default:
+		if (!ieee80211_is_our_addr(sdata, hdr->addr2, NULL))
+			our_addr = false;
+		break;
+	}
+
+	if (!our_addr &&
+	    wiphy_ext_feature_isset(
+		   local->hw.wiphy,
+		   NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA)) {
+		if (ieee80211_is_auth(hdr->frame_control)) {
+			drv_config_random_mac(local, hdr->addr2);
+			ether_addr_copy(sdata->vif.random_addr, hdr->addr2);
+		} else if (ieee80211_is_deauth(hdr->frame_control) &&
+			   ether_addr_equal(sdata->vif.random_addr,
+					    hdr->addr2)) {
+			eth_zero_addr(sdata->vif.random_addr);
+			drv_config_random_mac(local, sdata->vif.random_addr);
+		}
+	}
+
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		if (ieee80211_is_data(hdr->frame_control) &&
 		    is_unicast_ether_addr(hdr->addr1)) {
-- 
2.25.1

