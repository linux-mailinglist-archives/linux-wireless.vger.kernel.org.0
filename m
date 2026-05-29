Return-Path: <linux-wireless+bounces-37121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMeiDqNOGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36A5FF319
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388D431B5856
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE3348C56;
	Fri, 29 May 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ciZAW3Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BA3A0E8B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043225; cv=none; b=SSH/yC58VJJtMBbw44kUx8ncrLojW7dPKnzebQoIamQTtYJJ+eudY/X2jaWdvhPzMDgAoaYJ+QvtVlO8AO6hkLb5C4U0IEd8zDeL4T+YK9xZzan6RTc4tTP44/bWz6ucv8w1SAn4UQOgdZRgTYk9S+Q9tf71gMRWy3BBCw57JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043225; c=relaxed/simple;
	bh=QZZP+0j7S+c3beR1heN2X6mwDH71+roB8UAJEw/3UMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZJ11G3H/jk3TwZJdTfpEejjp9oKGxOH2jIqkulCeWQg1XHvgVi12FIBQzXYDcbsn0cBVsedk1yu8pcBda4SPh8JFLptLB31dLPEagM/EzeRIi0bZOABKASY0V6uD4IAg05GZmz1aSMHScOx37tVwNOvcg2blL89U/xQWCIYWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ciZAW3Lt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RwMwep/6VFabJcslUJZghm8wvU/vh+AW95jJhCzP2mI=;
	t=1780043223; x=1781252823; b=ciZAW3LtJaNs3wZqFIrw579btMBlh+izDuXILXn97o28mS4
	G0EzrbzIftvR13hr6PatOG5ZA1F6z+4xo8VElbXNjI3Ak72DNE48PoGjTFtiy5SqWCFwr+sanOZYH
	30JjIEdTu9DaCNSiMYJwYn110nnpzg4RNg/iYnQS97tntiNs6rRkzsfQe6uUEgw6bRQzkONn1Z3Yb
	P4PWaUPrdqyN8y5RWZA/wvN/yNtUpD1Xw4CFO0xLCyvYerdRJQz2NcxMxIL+li+C9/A8RlCjrzlEm
	BWASn2nzroeNRkoYuHogFGEH5lx83dv3plbRGV25D9iPocZNOH3l8LrvX8n+s20g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYW-00000009bVp-058h;
	Fri, 29 May 2026 10:27:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 15/16] wifi: mac80211: AP: handle DBE for clients
Date: Fri, 29 May 2026 10:25:08 +0200
Message-ID: <20260529102644.be84f2b055cc.I4d2c067dfe54c47621d5a872ca07a0e754d6c20f@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37121-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: AA36A5FF319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

In AP mode, track the BSS non-DBE bandwidth and apply
that to all non-DBE clients, then track OMP updates
from the clients and enable/disable DBE accordingly.

For now don't send a response, clients need to have a
timer anyway (it's up to the driver to set the right
timeout in UHR capabilities.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-eht.h |  16 +++-
 include/linux/ieee80211-uhr.h |  16 ++++
 net/mac80211/ap.c             | 146 ++++++++++++++++++++++++++++++++++
 net/mac80211/cfg.c            |  35 ++++++++
 net/mac80211/ieee80211_i.h    |   2 +
 net/mac80211/rx.c             |   9 +++
 net/mac80211/sta_info.c       |  10 ++-
 net/mac80211/sta_info.h       |   4 +
 8 files changed, 232 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 73e97fe30724..18f9c662cf4c 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -393,14 +393,24 @@ ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
 	return len >= needed;
 }
 
+/* must validate ieee80211_eht_oper_size_ok() first */
+static inline const struct ieee80211_eht_operation_info *
+ieee80211_eht_oper_info(const struct ieee80211_eht_operation *eht_oper)
+{
+	if (!(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT))
+		return NULL;
+
+	return (const void *)eht_oper->optional;
+}
+
 /* must validate ieee80211_eht_oper_size_ok() first */
 static inline u16
 ieee80211_eht_oper_dis_subchan_bitmap(const struct ieee80211_eht_operation *eht_oper)
 {
-	const struct ieee80211_eht_operation_info *info =
-		(const void *)eht_oper->optional;
+	const struct ieee80211_eht_operation_info *info;
 
-	if (!(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT))
+	info = ieee80211_eht_oper_info(eht_oper);
+	if (!info)
 		return 0;
 
 	if (!(eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index f9592ffae3eb..bbfcb53f5987 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -628,4 +628,20 @@ struct ieee80211_uhr_mode_change_tuple {
 	u8 variable[];
 } __packed;
 
+static inline int
+ieee80211_uhr_mode_change_tuple_size(const struct ieee80211_uhr_mode_change_tuple *tuple)
+{
+	return sizeof(*tuple) +
+	       le16_get_bits(tuple->control,
+			     IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_LENGTH);
+}
+
+#define for_each_uhr_mode_change_tuple(data, len, tuple)		\
+	for (tuple = (const void *)(data);				\
+	     (len) - ((const u8 *)tuple - (data)) >= sizeof(*tuple) &&	\
+	     (len) - ((const u8 *)tuple - (data)) >=			\
+		ieee80211_uhr_mode_change_tuple_size(tuple);		\
+	     tuple = (const void *)((const u8 *)tuple +			\
+				    ieee80211_uhr_mode_change_tuple_size(tuple)))
+
 #endif /* LINUX_IEEE80211_UHR_H */
diff --git a/net/mac80211/ap.c b/net/mac80211/ap.c
index 6c7d2d51a372..e7ac99c5a22e 100644
--- a/net/mac80211/ap.c
+++ b/net/mac80211/ap.c
@@ -8,6 +8,7 @@
 
 #include "driver-ops.h"
 #include "ieee80211_i.h"
+#include "rate.h"
 
 static void
 ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
@@ -186,6 +187,113 @@ ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);
 }
 
+static void
+ieee80211_rx_uhr_link_reconfig_req(struct ieee80211_sub_if_data *sdata,
+				   struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	const struct element *sub;
+	struct sta_info *sta;
+
+	/*
+	 * rx.c only accepts IEEE80211_UHR_LINK_RECONFIG_REQUEST_OMP_REQUEST
+	 * which is valid, so no need to check the frame type/format/etc.
+	 */
+
+	sta = sta_info_get_bss(sdata, mgmt->sa);
+	if (!sta)
+		return;
+
+	struct ieee802_11_elems *elems __free(kfree) =
+		ieee802_11_parse_elems(mgmt->u.action.uhr_link_reconf_req.variable,
+				       skb->len - IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_req),
+				       IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION,
+				       NULL);
+	/* STA will assume we processed it, not good */
+	if (!elems)
+		return;
+
+	if (!elems->ml_reconf)
+		return;
+
+	for_each_mle_subelement(sub, (u8 *)elems->ml_reconf,
+				elems->ml_reconf_len) {
+		const struct ieee80211_mle_per_sta_profile *prof =
+			 (const void *)sub->data;
+		struct ieee80211_chanctx_conf *chanctx_conf;
+		struct ieee80211_chanctx *chanctx;
+		struct ieee80211_link_data *link;
+		struct link_sta_info *link_sta;
+		const struct element *chg;
+		u16 control;
+		u8 link_id;
+
+		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
+			continue;
+
+		if (!ieee80211_mle_reconf_sta_prof_size_ok(sub->data,
+							   sub->datalen))
+			return;
+
+		control = le16_to_cpu(prof->control);
+		link_id = control & IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID;
+
+		if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+			return;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		chanctx_conf = sdata_dereference(link->conf->chanctx_conf,
+						 sdata);
+		if (!chanctx_conf)
+			continue;
+		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
+				       conf);
+
+		link_sta = sdata_dereference(sta->link[link_id], sdata);
+		if (!link_sta)
+			continue;
+
+		/* do we need to handle any other bits? */
+		if (control & ~(IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID |
+				IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE))
+			continue;
+
+		if (u16_get_bits(control, IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE) !=
+				IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_UHR_OMP_UPD)
+			continue;
+
+		for_each_element_extid(chg, WLAN_EID_EXT_UHR_MODE_CHG,
+				       prof->variable + prof->sta_info_len - 1,
+				       sub->datalen - sizeof(*prof) -
+				       prof->sta_info_len + 1) {
+			const struct ieee80211_uhr_mode_change_tuple *tuple;
+
+			for_each_uhr_mode_change_tuple(chg->data + 1,
+						       chg->datalen - 1,
+						       tuple) {
+				u8 id = le16_get_bits(tuple->control,
+						      IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ID);
+				bool enabled = le16_get_bits(tuple->control,
+							     IEEE80211_UHR_MODE_CHANGE_CONTROL_MODE_ENABLE);
+
+				/* only handle DBE (for now?) */
+				if (id != IEEE80211_UHR_MODE_CHANGE_MODE_ID_DBE)
+					continue;
+
+				link_sta->uhr_dbe_enabled = enabled;
+				/* also recalculates and updates per-STA bw */
+				ieee80211_recalc_chanctx_min_def(sdata->local,
+								 chanctx);
+			}
+		}
+	}
+
+	/* TODO: send a response */
+}
+
 void ieee80211_ap_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb)
 {
@@ -203,5 +311,43 @@ void ieee80211_ap_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
 			break;
 		}
 		break;
+	case WLAN_CATEGORY_PROTECTED_UHR:
+		switch (mgmt->u.action.action_code) {
+		case IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_REQUEST:
+			ieee80211_rx_uhr_link_reconfig_req(sdata, skb);
+			break;
+		}
+		break;
 	}
 }
+
+void ieee80211_uhr_disable_dbe_all_stas(struct ieee80211_link_data *link)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_chanctx *chanctx;
+	int link_id = link->link_id;
+	struct sta_info *sta;
+
+	chanctx_conf = sdata_dereference(link->conf->chanctx_conf, sdata);
+	if (!chanctx_conf)
+		return;
+	chanctx = container_of(chanctx_conf, struct ieee80211_chanctx, conf);
+
+	list_for_each_entry(sta, &local->sta_list, list) {
+		struct link_sta_info *link_sta;
+
+		if (sta->sdata->bss != sdata->bss)
+			continue;
+
+		link_sta = sdata_dereference(sta->link[link_id], sdata);
+		if (!link_sta)
+			continue;
+
+		link_sta->uhr_dbe_enabled = false;
+	}
+
+	/* also recalculates and updates per-STA bw */
+	ieee80211_recalc_chanctx_min_def(local, chanctx);
+}
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fb4c1c298159..19550ed3b908 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1391,6 +1391,36 @@ ieee80211_calc_ap_he_and_lower(struct cfg80211_beacon_data *params)
 	return IEEE80211_STA_RX_BW_20;
 }
 
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_calc_ap_eht_bw(struct cfg80211_beacon_data *params,
+			 enum ieee80211_sta_rx_bandwidth he_and_lower)
+{
+	const struct ieee80211_eht_operation_info *info;
+
+	if (!params->eht_oper)
+		return he_and_lower;
+
+	info = ieee80211_eht_oper_info(params->eht_oper);
+	if (!info)
+		return he_and_lower;
+
+	switch (u8_get_bits(info->control, IEEE80211_EHT_OPER_CHAN_WIDTH)) {
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ:
+		return IEEE80211_STA_RX_BW_20;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ:
+		return IEEE80211_STA_RX_BW_40;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ:
+		return IEEE80211_STA_RX_BW_80;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
+		return IEEE80211_STA_RX_BW_160;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
+		return IEEE80211_STA_RX_BW_320;
+	}
+
+	/* invalid setting, assume 20 MHz */
+	return IEEE80211_STA_RX_BW_20;
+}
+
 static void ieee80211_update_ap_bandwidth(struct ieee80211_link_data *link,
 					  struct cfg80211_beacon_data *params)
 {
@@ -1415,6 +1445,8 @@ static void ieee80211_update_ap_bandwidth(struct ieee80211_link_data *link,
 		return;
 
 	link->bss_bw.he_and_lower = ieee80211_calc_ap_he_and_lower(params);
+	link->bss_bw.eht = ieee80211_calc_ap_eht_bw(params,
+						    link->bss_bw.he_and_lower);
 
 	chanctx_conf = sdata_dereference(link->conf->chanctx_conf, link->sdata);
 	chanctx = container_of(chanctx_conf, struct ieee80211_chanctx, conf);
@@ -4469,6 +4501,9 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_uhr_disable_dbe_all_stas(link_data);
+
 	ieee80211_vif_unblock_queues_csa(sdata);
 
 	err = drv_post_channel_switch(link_data);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 29bdfd2a39bd..34a9ea8b6f85 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1146,6 +1146,7 @@ struct ieee80211_link_data {
 
 	struct {
 		enum ieee80211_sta_rx_bandwidth he_and_lower;
+		enum ieee80211_sta_rx_bandwidth eht; /* and UHR non-DBE */
 	} bss_bw;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -2003,6 +2004,7 @@ bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 /* AP code */
 void ieee80211_ap_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
+void ieee80211_uhr_disable_dbe_all_stas(struct ieee80211_link_data *link);
 
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4579ebdebdf5..e4bd58c02c8f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3952,6 +3952,15 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 
 		switch (mgmt->u.action.action_code) {
+		case IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_REQUEST:
+			if (sdata->vif.type != NL80211_IFTYPE_AP)
+				break;
+			if (len < IEEE80211_MIN_ACTION_SIZE(uhr_link_reconf_req))
+				goto invalid;
+			if (mgmt->u.action.uhr_link_reconf_req.type !=
+			    IEEE80211_UHR_LINK_RECONFIG_REQUEST_OMP_REQUEST)
+				break;
+			goto queue;
 		case IEEE80211_PROTECTED_UHR_ACTION_LINK_RECONFIG_NOTIFY:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
 				break;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6b44030659fc..873077dbd65b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3691,10 +3691,14 @@ ieee80211_sta_usable_bw(struct link_sta_info *link_sta,
 	if (WARN_ON(!link))
 		return IEEE80211_STA_RX_BW_20;
 
-	if (link_sta->pub->eht_cap.has_eht)
-		return bw;
+	if (!link_sta->pub->eht_cap.has_eht)
+		return min(bw, link->bss_bw.he_and_lower);
 
-	return min(bw, link->bss_bw.he_and_lower);
+	if (!link_sta->pub->uhr_cap.has_uhr ||
+	    !link_sta->uhr_dbe_enabled)
+		return min(bw, link->bss_bw.eht);
+
+	return bw;
 }
 
 static enum ieee80211_sta_rx_bandwidth
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 6974fccb839f..ec0bf56bfb05 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -514,6 +514,8 @@ struct ieee80211_fragment_cache {
  * @uhr_usable_tx_width: bandwidth restriction for UHR for TX, only when
  *	the link_sta is an AP, to restrict TX to BSS width during DBE
  *	enablement
+ * @uhr_dbe_enabled: for STAs as clients to an AP interface indicates
+ *	DBE is enabled by the STA
  * @debugfs_dir: debug filesystem directory dentry
  * @pub: public (driver visible) link STA data
  */
@@ -567,6 +569,8 @@ struct link_sta_info {
 					rx_omi_bw_staging;
 	enum ieee80211_sta_rx_bandwidth uhr_usable_tx_width;
 
+	bool uhr_dbe_enabled;
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct dentry *debugfs_dir;
 #endif
-- 
2.53.0


