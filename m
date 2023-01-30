Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4C68066D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjA3HXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjA3HXE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B675E11EA4
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:23:01 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U5EbDd011214;
        Mon, 30 Jan 2023 07:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=syMCfit2w+FC5eycC3E8a1r4DJunZ5yZfaDTjB1kQUM=;
 b=bx20HRm3wqkqZTwN+4hoqVKe68BKr5HMOLzBEU8nGewX3yhI2dOKsVshrdJ7vq9VJElc
 xWG442Mzf1zIlYBEpUtsWfMjJzerK8NyuYvF9HlbQoygl+OFHbrgHrptqf14VkWKvt3X
 o4sUR3HV46IgeX6T5QfcadAJYcyOr4FswWOCuKRsH7kMgFuiNdwgxnRMRQLL+7KsAEBk
 jC9+N6UUq1KJD8Fer/9lBrqc5jsQRN0sdCNudruN1E0Oh2qYoRpRrWlCAXK/KgSo5CY6
 xLZ99VB26N0LXvt4wk/hrkH06GhR9NxBGkfkxVS+1GFwfxyXc97KmYerrEGEQZkLV0n5 vQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncs2x3e7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7MqTo008853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:53 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:52 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 5/6] wifi: cfg80211: add puncturing bitmap in channel switch notifications
Date:   Sun, 29 Jan 2023 23:22:38 -0800
Message-ID: <20230130072239.26345-6-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130072239.26345-1-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qJZwXmN5N0NdWAf-WR1pdZzGjA6WitUs
X-Proofpoint-GUID: qJZwXmN5N0NdWAf-WR1pdZzGjA6WitUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify channel switch notify functions and corresponding trace
functions to include the new puncturing bitmap.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c |  2 +-
 include/net/cfg80211.h                     |  6 ++++--
 net/mac80211/cfg.c                         |  6 ++++--
 net/mac80211/mlme.c                        |  4 ++--
 net/wireless/nl80211.c                     | 10 +++++----
 net/wireless/trace.h                       | 24 ++++++++++++++--------
 7 files changed, 34 insertions(+), 20 deletions(-)

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
index 7714a44d312e..1ac5befc3cc8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8282,13 +8282,14 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
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
+			       unsigned int link_id, u32 punct_bitmap);
 
 /*
  * cfg80211_ch_switch_started_notify - notify channel switch start
@@ -8297,6 +8298,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
+ * @punct_bitmap: the future puncturing bitmap
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -8305,7 +8307,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet);
+				       bool quiet, u32 punct_bitmap);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8a1cb2f083f5..1c40586b3d98 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3600,7 +3600,8 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0,
+				  sdata->vif.bss_conf.eht_puncturing);
 
 	return 0;
 }
@@ -3879,7 +3880,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &sdata->deflink.csa_chandef, 0,
-					  params->count, params->block_tx);
+					  params->count, params->block_tx,
+					  sdata->vif.bss_conf.csa_punct_bitmap);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 50efd5980387..e14799799dd4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1839,7 +1839,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0);
+	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef, 0, 0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
@@ -2049,7 +2049,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	mutex_unlock(&local->mtx);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef, 0,
-					  csa_ie.count, csa_ie.mode);
+					  csa_ie.count, csa_ie.mode, 0);
 
 	if (local->ops->channel_switch) {
 		/* use driver's channel switch callback */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index efe841ba8865..55daddb0e6ad 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19030,7 +19030,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 
 void cfg80211_ch_switch_notify(struct net_device *dev,
 			       struct cfg80211_chan_def *chandef,
-			       unsigned int link_id)
+			       unsigned int link_id, u32 punct_bitmap)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19039,7 +19039,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	ASSERT_WDEV_LOCK(wdev);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_notify(dev, chandef, link_id);
+	trace_cfg80211_ch_switch_notify(dev, chandef, link_id, punct_bitmap);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
@@ -19074,7 +19074,7 @@ EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet)
+				       bool quiet, u32 punct_bitmap)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -19083,7 +19083,9 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 	ASSERT_WDEV_LOCK(wdev);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id);
+	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id,
+						punct_bitmap);
+
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..e9db666e5a4e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3245,39 +3245,47 @@ TRACE_EVENT(cfg80211_chandef_dfs_required,
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 unsigned int link_id),
-	TP_ARGS(netdev, chandef, link_id),
+		 unsigned int link_id,
+		 u32 punct_bitmap),
+	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
+		__field(u32, punct_bitmap)
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
+		 u32 punct_bitmap),
+	TP_ARGS(netdev, chandef, link_id, punct_bitmap),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(unsigned int, link_id)
+		__field(u32, punct_bitmap)
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

