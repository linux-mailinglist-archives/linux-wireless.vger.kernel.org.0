Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8AC666859
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 02:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjALBYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 20:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjALBYw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 20:24:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1140850
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 17:24:51 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BNv75W005899;
        Thu, 12 Jan 2023 01:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=uVztuqDWIKbMZqamyBCdGiGm8jAW3lJd/CD2iK1lQMU=;
 b=P1l3A89YOz8n5BEz7hoTbD3PzhF4rlU/UMVXGkCg6RZxxeDVxNRIlzFY2bpcUZ7barbM
 bJg/ZEzhbngNDlqtxF/mnFpTFzLLMNod6USzAKBit3cMBM2NwEhc/tU1vLgeui39Kidw
 fvi1T0QBCd0KDIuNbax31Y1KpaBwhmaY9kHVPLZxBZ5H+Yfly/dpFrn3N2D1oJsxFBT6
 wvkywa3QCEywPVv/AA97Chszr4aLVDbzuCOzFzcGEd4HLA9CDptaj/Mjr4QjL/hg2u/9
 KfdnxZrlgSLx5hQYeHvztX5MljMDeaUwGInwfvQjTHqy0PLgy9/+oxGX9FkHtGDInAnh YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1m6p2gxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C1OjCD024738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:45 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 17:24:44 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 2/3] wifi: mac80211: Add support to randomize TA of auth and deauth frames
Date:   Thu, 12 Jan 2023 06:54:14 +0530
Message-ID: <20230112012415.167556-3-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
References: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4jkx7jvHBiiNZz1PekPFJj982c6EkaRa
X-Proofpoint-GUID: 4jkx7jvHBiiNZz1PekPFJj982c6EkaRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=790
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cache the TA of the authentication and deauthentication frames
temporarily till the response waiting time offchannel period complete
and indicate the temporary address to driver when driver supports
randomizing TA of auth and deauth frames. Driver should allow TX and RX
of the frames when the temporary address is TA and RA respectively.
Allow the authentication and deauthentication frames with cached
address as RA in RX path.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - Modify the implementation to allow the authentication and
   deauthentication frames with the random address till the response
   waiting time off-channel period complete.
 - Use BSS changed flag to indicate change in allowed random address to
   driver.
v3:
 - Fix warning reported by kernel test robot <lkp@intel.com>
---
 include/net/mac80211.h    | 12 ++++++++++++
 net/mac80211/main.c       |  3 ++-
 net/mac80211/offchannel.c | 38 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c         | 18 ++++++++++++++----
 net/mac80211/util.c       |  7 ++++++-
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 689da327ce2e..a6f0987f88a1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -340,6 +340,8 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
+ * @BSS_CHANGED_TEMP_ADDR: Temporary self address allowed for authentication and
+ *	deauthentication frames is changed.
  *
  */
 enum ieee80211_bss_change {
@@ -375,6 +377,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
+	BSS_CHANGED_TEMP_ADDR		= 1ULL<<32,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -1771,6 +1774,14 @@ enum ieee80211_offload_flags {
  *	your driver/device needs to do.
  * @ap_addr: AP MLD address, or BSSID for non-MLO connections
  *	(station mode only)
+ * @temp_addr: Temporary self address allowed for the authentication and
+ *	deauthentication frames till the response waiting time offchannel period
+ *	complete. Driver should allow TX and RX of the frames with the temporary
+ *	address as TA and RA respectively when it is non zero. This will be set
+ *	to zero address when there is no temporary self address is active.
+ *	Change in the value of this will be indicated with
+ *	@BSS_CHANGED_TEMP_ADDR. This will be indicated only when driver supports
+ *	%NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA.
  */
 struct ieee80211_vif_cfg {
 	/* association related data */
@@ -1786,6 +1797,7 @@ struct ieee80211_vif_cfg {
 	bool s1g;
 	bool idle;
 	u8 ap_addr[ETH_ALEN] __aligned(2);
+	u8 temp_addr[ETH_ALEN] __aligned(2);
 };
 
 /**
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 846528850612..238cbf05d08d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -205,7 +205,8 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
 				   BSS_CHANGED_PS |\
 				   BSS_CHANGED_IBSS |\
 				   BSS_CHANGED_ARP_FILTER |\
-				   BSS_CHANGED_SSID)
+				   BSS_CHANGED_SSID |\
+				   BSS_CHANGED_TEMP_ADDR)
 
 void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				      u64 changed)
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index d78c82d6b696..54233be31e9b 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -187,6 +187,12 @@ static void ieee80211_roc_notify_destroy(struct ieee80211_roc_work *roc)
 					 roc->mgmt_tx_cookie,
 					 roc->chan, GFP_KERNEL);
 
+	if (!is_zero_ether_addr(roc->sdata->vif.cfg.temp_addr)) {
+		eth_zero_addr(roc->sdata->vif.cfg.temp_addr);
+		ieee80211_vif_cfg_change_notify(roc->sdata,
+						BSS_CHANGED_TEMP_ADDR);
+	}
+
 	list_del(&roc->list);
 	kfree(roc);
 }
@@ -234,6 +240,36 @@ static bool ieee80211_recalc_sw_work(struct ieee80211_local *local,
 	return true;
 }
 
+static void ieee80211_config_temp_addr(struct ieee80211_sub_if_data *sdata,
+				       const struct ieee80211_hdr *hdr)
+{
+	unsigned int link;
+
+	if (!wiphy_ext_feature_isset(sdata->local->hw.wiphy,
+			NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA))
+		return;
+
+	if (memcmp(sdata->vif.addr, hdr->addr2, ETH_ALEN) == 0 ||
+	    memcmp(sdata->vif.cfg.temp_addr, hdr->addr2, ETH_ALEN) == 0) {
+		return;
+	} else if (sdata->vif.valid_links) {
+		rcu_read_lock();
+		for (link = 0; link < ARRAY_SIZE(sdata->vif.link_conf); link++) {
+			struct ieee80211_bss_conf *link_conf;
+
+			link_conf = rcu_dereference(sdata->vif.link_conf[link]);
+			if (!link_conf)
+				continue;
+			if (memcmp(link_conf->addr, hdr->addr2, ETH_ALEN) == 0)
+				return;
+		}
+		rcu_read_unlock();
+	}
+
+	memcpy(sdata->vif.cfg.temp_addr, hdr->addr2, ETH_ALEN);
+	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_TEMP_ADDR);
+}
+
 static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 					 unsigned long start_time)
 {
@@ -245,6 +281,8 @@ static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
 
 	if (roc->mgmt_tx_cookie) {
 		if (!WARN_ON(!roc->frame)) {
+			ieee80211_config_temp_addr(roc->sdata,
+						   (void *) roc->frame->data);
 			ieee80211_tx_skb_tid_band(roc->sdata, roc->frame, 7,
 						  roc->chan->band);
 			roc->frame = NULL;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7e3ab6e1b28f..a611697cecd0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4192,6 +4192,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
 	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
 			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	bool skip_addr1_check = false;
+
+	if ((ieee80211_is_auth(hdr->frame_control) ||
+	     ieee80211_is_deauth(hdr->frame_control)) &&
+	    ether_addr_equal(sdata->vif.cfg.temp_addr, hdr->addr1))
+		skip_addr1_check = true;
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -4201,6 +4207,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
+		if (skip_addr1_check)
+			return true;
 		return ieee80211_is_our_addr(sdata, hdr->addr1, &rx->link_id);
 	case NL80211_IFTYPE_ADHOC:
 		if (!bssid)
@@ -4213,7 +4221,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return true;
 		if (!ieee80211_bssid_match(bssid, sdata->u.ibss.bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->vif.addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4233,7 +4241,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (!is_broadcast_ether_addr(bssid))
 			return false;
-		if (!multicast &&
+		if (!multicast && !skip_addr1_check &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
 		if (!rx->sta) {
@@ -4251,10 +4259,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
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
 
@@ -4266,7 +4276,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 * and location updates. Note that mac80211
 			 * itself never looks at these frames.
 			 */
-			if (!multicast &&
+			if (!multicast && !skip_addr1_check &&
 			    !ieee80211_is_our_addr(sdata, hdr->addr1,
 						   &rx->link_id))
 				return false;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6f5407038459..fd7e77938023 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2663,7 +2663,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	/* Finally also reconfigure all the BSS information */
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		unsigned int link_id;
-		u32 changed;
+		u64 changed;
 
 		if (!ieee80211_sdata_running(sdata))
 			continue;
@@ -2712,6 +2712,11 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			  BSS_CHANGED_TXPOWER |
 			  BSS_CHANGED_MCAST_RATE;
 
+		if (!is_zero_ether_addr(sdata->vif.cfg.temp_addr)) {
+			eth_zero_addr(sdata->vif.cfg.temp_addr);
+			changed |= BSS_CHANGED_TEMP_ADDR;
+		}
+
 		if (sdata->vif.bss_conf.mu_mimo_owner)
 			changed |= BSS_CHANGED_MU_GROUPS;
 
-- 
2.25.1

