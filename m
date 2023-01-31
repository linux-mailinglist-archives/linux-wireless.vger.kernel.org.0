Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F78682071
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 01:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAaAMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 19:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjAaAMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 19:12:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863001A962
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 16:12:45 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMlMbE022903;
        Tue, 31 Jan 2023 00:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=g7CCOatVDL40xQeF9FxNnHWhNlNQcZk874SLDYqOZr8=;
 b=ih4cu9h0U4h3MdZXpm/eywacK2Xv/CsXA2VA971BwLoQSkqEq5UDNJkfzs63Oz+pwuae
 jHMWFdiVG6+mEuwbyf7/T0cfSCA3XCLfQ0GVFEpL5+IFcxUvLX9mx7gJhX+2060jGMwu
 CrGepJqc3WLYLwX6KKpDWltZNRxJczU4KClkcfL2V9z+kJLeicrr4k0/s5fzheWlTQik
 pAEwlx9chXBfFQohKYTUI5KpRbXtiOCNRYYhnQeXMaXD+cVxvEvh2XtvLrKlLBdXbZ69
 sfl3dw18V2kWQwpBcze8meLTBs5V/Ly4Yh8bsNks2nTRBcwwee/sIqNOjl2m64LvO4vR 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncw0g4u76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V0CfFh017807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:41 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 16:12:40 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v4 3/4] wifi: cfg80211: include puncturing bitmap in channel switch events
Date:   Mon, 30 Jan 2023 16:12:26 -0800
Message-ID: <20230131001227.25014-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131001227.25014-1-quic_alokad@quicinc.com>
References: <20230131001227.25014-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wlBltqV5OVyUhjQ3KR_D5J_PT516qktQ
X-Proofpoint-ORIG-GUID: wlBltqV5OVyUhjQ3KR_D5J_PT516qktQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300218
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add punctruing bitmap in channel switch notifications (CFG80211, NL80211)
and corresponding trace functions.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c |  2 +-
 include/net/cfg80211.h                     |  6 ++++--
 net/mac80211/cfg.c                         |  5 +++--
 net/mac80211/mlme.c                        |  4 ++--
 net/wireless/nl80211.c                     | 20 +++++++++++-------
 net/wireless/trace.h                       | 24 ++++++++++++++--------
 7 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index a20e0aeae284..0c2b8b1a10d5 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1119,7 +1119,7 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 					NL80211_CHAN_HT20 : NL80211_CHAN_NO_HT);
 
 	mutex_lock(&vif->wdev.mtx);
-	cfg80211_ch_switch_notify(vif->ndev, &chandef, 0);
+	cfg80211_ch_switch_notify(vif->ndev, &chandef, 0, 0);
 	mutex_unlock(&vif->wdev.mtx);
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 6a9d7bc1f41e..b0c40a776a2e 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -292,6 +292,6 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
 	mutex_lock(&priv->wdev.mtx);
-	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0, 0);
 	mutex_unlock(&priv->wdev.mtx);
 }
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f70f28776dc0..6b30ad4423f9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8280,13 +8280,14 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
  * @dev: the device which switched channels
  * @chandef: the new channel definition
  * @link_id: the link ID for MLO, must be 0 for non-MLO
+ * @punct_bitmap: the new puncturing bitmap
  *
  * Caller must acquire wdev_lock, therefore must only be called from sleepable
  * driver context!
  */
 void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
-			       unsigned int link_id);
+			       unsigned int link_id, u16 punct_bitmap);
 
 /*
  * cfg80211_ch_switch_started_notify - notify channel switch start
@@ -8295,6 +8296,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
+ * @punct_bitmap: the future puncturing bitmap
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -8303,7 +8305,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet);
+				       bool quiet, u16 punct_bitmap);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 24b8648cfafa..6e830d1b82b2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3587,7 +3587,8 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0,
+				  0);
 
 	return 0;
 }
@@ -3859,7 +3860,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &sdata->deflink.csa_chandef, 0,
-					  params->count, params->block_tx);
+					  params->count, params->block_tx, 0);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 09703cae2fbb..60792dfabc9d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1778,7 +1778,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0, 0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
@@ -1988,7 +1988,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	mutex_unlock(&local->mtx);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef, 0,
-					  csa_ie.count, csa_ie.mode);
+					  csa_ie.count, csa_ie.mode, 0);
 
 	if (local->ops->channel_switch) {
 		/* use driver's channel switch callback */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d2219f43a2ea..ed467ef3ee74 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18994,7 +18994,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count, bool quiet)
+				     u8 count, bool quiet, u16 punct_bitmap)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct sk_buff *msg;
@@ -19028,6 +19028,9 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u32(msg, NL80211_ATTR_PUNCT_BITMAP, punct_bitmap))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -19040,7 +19043,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 
 void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
-			       unsigned int link_id)
+			       unsigned int link_id, u16 punct_bitmap)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19049,7 +19052,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	ASSERT_WDEV_LOCK(wdev);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_notify(dev, chandef, link_id);
+	trace_cfg80211_ch_switch_notify(dev, chandef, link_id, punct_bitmap);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
@@ -19077,14 +19080,15 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false,
+				 punct_bitmap);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet)
+				       bool quiet, u16 punct_bitmap)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19093,11 +19097,13 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 	ASSERT_WDEV_LOCK(wdev);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id);
+	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id,
+						punct_bitmap);
+
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
-				 count, quiet);
+				 count, quiet, punct_bitmap);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..eee3e27e1652 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3245,39 +3245,47 @@ TRACE_EVENT(cfg80211_chandef_dfs_required,
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 unsigned int link_id),
-	TP_ARGS(netdev, chandef, link_id),
+		 unsigned int link_id,
+		 u16 punct_bitmap),
+	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
+		__field(u16, punct_bitmap)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->link_id = link_id;
+		__entry->punct_bitmap = punct_bitmap;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d, punct_bitmap:%u",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id,
+		  __entry->punct_bitmap)
 );
 
 TRACE_EVENT(cfg80211_ch_switch_started_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 unsigned int link_id),
-	TP_ARGS(netdev, chandef, link_id),
+		 unsigned int link_id,
+		 u16 punct_bitmap),
+	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
+		__field(u16, punct_bitmap)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->link_id = link_id;
+		__entry->punct_bitmap = punct_bitmap;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d, punct_bitmap:%u",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id,
+		  __entry->punct_bitmap)
 );
 
 TRACE_EVENT(cfg80211_radar_event,
-- 
2.39.0

