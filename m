Return-Path: <linux-wireless+bounces-4158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA686AA91
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D391F25060
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60272EAE6;
	Wed, 28 Feb 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tYiWLN2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011522DF73
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110647; cv=none; b=vEzjCQHD88JCguYIzirQDnZ/X2oK8uipnBvifI9HrczC/HGCbZCpX9fQCKNxsiEE+pppUu8gsAxY+wwBJp4SkVwMQSwAUTD7t5kKBtl3fARr7SHM90Lk3yYylsT9KChAdCyTZ22QfSKRsEEx5/+8BKk5+DT+NcYLUcZRb06pQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110647; c=relaxed/simple;
	bh=jehfpEUOojSxp+NUxZSFTsmG4m8FP1HwbBnfTxGnihM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIxJt6Pl4HDNL/8Va4E/I74r6fTFqBHIeXWgT6H6+GQKEMse7/Pq6cAYZ+MNQKqx99RgSOLri7wttQMfkWC9j14km55iHH4Wc1seThX1oTOXh6qPOPtyRpPc0ds5VC3iGDD/l2hXvJROQFyWXRH7fExzWSbeL7AM6W2YefR/sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tYiWLN2E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Z5HmwqvUC3DM6A9bUaOQrUg7mSwYcpP7QGNDUK+qUu4=;
	t=1709110646; x=1710320246; b=tYiWLN2Eb6qaE6aN4nxY66JM/uq0FpNXs03+gtQ+WW2h5vr
	kYnVboiH3l8vMKhVXKjUU4eLTTyI54r+JvhSXS3DWMSBuKKxoZ+cTyaJ2/wOZH7p+AanZxgp4HOHm
	BUW+T4VI9B9o2L9Hlfa5HRHXcZ9rJBnjxS9J0c1OtmJr00i3lCFdV3AeTt5cOsaKHCDbtROStajt5
	HqR2jemtquPbTugCICua3PKaZAQH+J1Xf5PI3m5OqBfpEFz0NEGqmM0WDqL6gupuLh1ZntRTnyTtj
	k0IgqB8/F59W6Na5Wr8K/KCSH0PjOTcpNz5fZwyl/0fmYo3toTPoUqhgNUfzzUeg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkh-0000000C0hJ-1OPA;
	Wed, 28 Feb 2024 09:57:23 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/8] wifi: mac80211: pass link_id to channel switch ops
Date: Wed, 28 Feb 2024 09:55:43 +0100
Message-ID: <20240228095718.b7726635c054.I0be5d00af4acb48cfbd23a9dbf067f9aeb66469d@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For CSA to work correctly in multi-link scenarios, pass
the link_id to the relevant callbacks.

While at it, unify/deduplicate the tracing for them.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  6 ++--
 net/mac80211/cfg.c     |  4 ++-
 net/mac80211/mlme.c    |  4 ++-
 net/mac80211/trace.h   | 82 ++++++++++--------------------------------
 4 files changed, 28 insertions(+), 68 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6c6d8210d637..8ea9fa81e68c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1763,8 +1763,9 @@ struct ieee80211_conf {
  * @chandef: the new channel to switch to
  * @count: the number of TBTT's until the channel switch event
  * @delay: maximum delay between the time the AP transmitted the last beacon in
-  *	current channel and the expected time of the first beacon in the new
-  *	channel, expressed in TU.
+ *	current channel and the expected time of the first beacon in the new
+ *	channel, expressed in TU.
+ * @link_id: the link ID of the link doing the channel switch, 0 for non-MLO
  */
 struct ieee80211_channel_switch {
 	u64 timestamp;
@@ -1772,6 +1773,7 @@ struct ieee80211_channel_switch {
 	bool block_tx;
 	struct cfg80211_chan_def chandef;
 	u8 count;
+	u8 link_id;
 	u32 delay;
 };
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 821a83e487df..ed8d7919ef2a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3897,7 +3897,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_channel_switch ch_switch;
+	struct ieee80211_channel_switch ch_switch = {
+		.link_id = params->link_id,
+	};
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *chanctx;
 	struct ieee80211_bss_conf *link_conf;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e6a82f28a7c6..f32ed57c83ba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2021,7 +2021,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	struct ieee80211_chanctx *chanctx;
 	enum nl80211_band current_band;
 	struct ieee80211_csa_ie csa_ie;
-	struct ieee80211_channel_switch ch_switch;
+	struct ieee80211_channel_switch ch_switch = {
+		.link_id = link->link_id,
+	};
 	struct ieee80211_bss *bss;
 	unsigned long timeout;
 	int res;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 478b32d2520a..8e758b5074bd 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -1209,7 +1209,7 @@ DEFINE_EVENT(sta_event, drv_flush_sta,
 	TP_ARGS(local, sdata, sta)
 );
 
-TRACE_EVENT(drv_channel_switch,
+DECLARE_EVENT_CLASS(chanswitch_evt,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_channel_switch *ch_switch),
@@ -1224,6 +1224,7 @@ TRACE_EVENT(drv_channel_switch,
 		__field(u32, device_timestamp)
 		__field(bool, block_tx)
 		__field(u8, count)
+		__field(u8, link_id)
 	),
 
 	TP_fast_assign(
@@ -1234,14 +1235,24 @@ TRACE_EVENT(drv_channel_switch,
 		__entry->device_timestamp = ch_switch->device_timestamp;
 		__entry->block_tx = ch_switch->block_tx;
 		__entry->count = ch_switch->count;
+		__entry->link_id = ch_switch->link_id;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " new " CHANDEF_PR_FMT " count:%d",
-		LOCAL_PR_ARG, VIF_PR_ARG, CHANDEF_PR_ARG, __entry->count
+		LOCAL_PR_FMT VIF_PR_FMT CHANDEF_PR_FMT  " count:%d block_tx:%d timestamp:%llu device_ts:%u link_id:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, CHANDEF_PR_ARG, __entry->count,
+		__entry->block_tx, __entry->timestamp,
+		__entry->device_timestamp, __entry->link_id
 	)
 );
 
+DEFINE_EVENT(chanswitch_evt, drv_channel_switch,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_channel_switch *ch_switch),
+	TP_ARGS(local, sdata, ch_switch)
+);
+
 TRACE_EVENT(drv_set_antenna,
 	TP_PROTO(struct ieee80211_local *local, u32 tx_ant, u32 rx_ant, int ret),
 
@@ -2121,39 +2132,11 @@ TRACE_EVENT(drv_channel_switch_beacon,
 	)
 );
 
-TRACE_EVENT(drv_pre_channel_switch,
+DEFINE_EVENT(chanswitch_evt, drv_pre_channel_switch,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_channel_switch *ch_switch),
-
-	TP_ARGS(local, sdata, ch_switch),
-
-	TP_STRUCT__entry(
-		LOCAL_ENTRY
-		VIF_ENTRY
-		CHANDEF_ENTRY
-		__field(u64, timestamp)
-		__field(u32, device_timestamp)
-		__field(bool, block_tx)
-		__field(u8, count)
-	),
-
-	TP_fast_assign(
-		LOCAL_ASSIGN;
-		VIF_ASSIGN;
-		CHANDEF_ASSIGN(&ch_switch->chandef)
-		__entry->timestamp = ch_switch->timestamp;
-		__entry->device_timestamp = ch_switch->device_timestamp;
-		__entry->block_tx = ch_switch->block_tx;
-		__entry->count = ch_switch->count;
-	),
-
-	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " prepare channel switch to "
-		CHANDEF_PR_FMT  " count:%d block_tx:%d timestamp:%llu",
-		LOCAL_PR_ARG, VIF_PR_ARG, CHANDEF_PR_ARG, __entry->count,
-		__entry->block_tx, __entry->timestamp
-	)
+	TP_ARGS(local, sdata, ch_switch)
 );
 
 DEFINE_EVENT(local_sdata_evt, drv_post_channel_switch,
@@ -2168,40 +2151,11 @@ DEFINE_EVENT(local_sdata_evt, drv_abort_channel_switch,
 	     TP_ARGS(local, sdata)
 );
 
-TRACE_EVENT(drv_channel_switch_rx_beacon,
+DEFINE_EVENT(chanswitch_evt, drv_channel_switch_rx_beacon,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_channel_switch *ch_switch),
-
-	TP_ARGS(local, sdata, ch_switch),
-
-	TP_STRUCT__entry(
-		LOCAL_ENTRY
-		VIF_ENTRY
-		CHANDEF_ENTRY
-		__field(u64, timestamp)
-		__field(u32, device_timestamp)
-		__field(bool, block_tx)
-		__field(u8, count)
-	),
-
-	TP_fast_assign(
-		LOCAL_ASSIGN;
-		VIF_ASSIGN;
-		CHANDEF_ASSIGN(&ch_switch->chandef)
-		__entry->timestamp = ch_switch->timestamp;
-		__entry->device_timestamp = ch_switch->device_timestamp;
-		__entry->block_tx = ch_switch->block_tx;
-		__entry->count = ch_switch->count;
-	),
-
-	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT
-		" received a channel switch beacon to "
-		CHANDEF_PR_FMT  " count:%d block_tx:%d timestamp:%llu",
-		LOCAL_PR_ARG, VIF_PR_ARG, CHANDEF_PR_ARG, __entry->count,
-		__entry->block_tx, __entry->timestamp
-	)
+	TP_ARGS(local, sdata, ch_switch)
 );
 
 TRACE_EVENT(drv_get_txpower,
-- 
2.43.2


