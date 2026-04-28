Return-Path: <linux-wireless+bounces-35452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKaPEZx28GkMTwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:58:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E310F480B8E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805143239907
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A123D9DA7;
	Tue, 28 Apr 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T1TxDbgh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F23D8107
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365424; cv=none; b=G9Uw5rHoVN1CvMV2P4d05Yv+aIehFxc5qC/F/Q20PyqxFGDYPNQ3iZk1BNbcjOKgU+Z8UrC6wA7O2TDU9Y2UQ519OnVv9xjaziHYtiRj8xo2hr0ZyqW5N4grOxdJnaMso1Oa56zOgIXGvBmBJ4RcK42JWD8TfWv/tGBZLPzqgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365424; c=relaxed/simple;
	bh=VhCy+qR4FxaBBz9c/tmgXwyZL13A4nLqCj0bMh7vW4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6Vfh/Zc+8trBznWx5DssY/TI//FTyTypzw3+HLDP+2bD5Mj82cz2tvlkpohX9GR+gUBTNv++mnb82R+XfIw6g3aqyDUmWow92kd5tKuaAjPAgk3fYgsk4+riYqXM5yuyxKCs8YWW2xDZQyE23gwiLtQttjI2aDVrF2h0jeYR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T1TxDbgh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=pRNCvcWxfZMXLz14cdYR7smA7dYaUm54GFePpTyljgA=; t=1777365421; x=1778575021; 
	b=T1TxDbghoJfcAUdUbZqsl50CyaiW0Wsyc+QIVnJOrQKEwqDPdbFNr+ormtEJ3EOkFllIe76jNlb
	gY2igPeUb3XsEZgtGUW4xYQ7+TyEb9WRrIng1AGWNJJtAme9qII8dMdxV+95L2yajbNolb+BBN5Zl
	CTJWLEjlrU4VBJ2riQToYZyuUclRtJqgmT1RUr5uQoAcbxU+s+xTAuON6qn0de7tSm17wQ/9MSEyu
	CXEVX05xeDB6egeqOR8BV69jIF/lxvlFPSb79qbHrQN14sT7NcCKBPCUOtxiyI/+8Ox/334KmXQws
	4anxVKKFGPN3GlcnE0ChdVTtn1q/QS9WuqQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHdw4-0000000HAS4-3BAg;
	Tue, 28 Apr 2026 10:36:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: move frame RX handling to type files
Date: Tue, 28 Apr 2026 10:36:49 +0200
Message-ID: <20260428103649.c00059e68a07.I2269130278390f534d6051fac424402a854a54aa@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E310F480B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35452-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Johannes Berg <johannes.berg@intel.com>

The interface frame queue processing code currently
differentiates many frame types and below those the
interface types, but then falls through to per-type
processing. Move this code to the per-type functions,
creating a new ap.c file that gets relevant code, and
this way reduce the number of non-static symbols.

This also helps with adding more cases for UHR later.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/Makefile      |   2 +-
 net/mac80211/ap.c          | 207 ++++++++++++++++++++++++
 net/mac80211/eht.c         | 174 ---------------------
 net/mac80211/ieee80211_i.h |  23 +--
 net/mac80211/iface.c       |  49 +-----
 net/mac80211/mlme.c        | 312 +++++++++++++++++++++----------------
 6 files changed, 394 insertions(+), 373 deletions(-)
 create mode 100644 net/mac80211/ap.c

diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index 20c3135b73ea..36f1e3e2222b 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -30,7 +30,7 @@ mac80211-y := \
 	key.o \
 	util.o parse.o \
 	wme.o \
-	chan.o \
+	chan.o ap.o \
 	trace.o mlme.o \
 	tdls.o \
 	ocb.o \
diff --git a/net/mac80211/ap.c b/net/mac80211/ap.c
new file mode 100644
index 000000000000..6c7d2d51a372
--- /dev/null
+++ b/net/mac80211/ap.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AP handling
+ *
+ * Partially
+ * Copyright (C) 2026 Intel Corporation
+ */
+
+#include "driver-ops.h"
+#include "ieee80211_i.h"
+
+static void
+ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_mgmt *req, int opt_len)
+{
+	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+
+	len += opt_len; /* optional len */
+	skb = dev_alloc_skb(local->tx_headroom + len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->tx_headroom);
+	mgmt = skb_put_zero(skb, len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, req->sa, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
+	mgmt->u.action.action_code =
+		WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF;
+	mgmt->u.action.eml_omn.dialog_token =
+		req->u.action.eml_omn.dialog_token;
+	mgmt->u.action.eml_omn.control = req->u.action.eml_omn.control &
+		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
+		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
+	/* Copy optional fields from the received notification frame */
+	memcpy(mgmt->u.action.eml_omn.variable,
+	       req->u.action.eml_omn.variable, opt_len);
+
+	ieee80211_tx_skb(sdata, skb);
+}
+
+static void
+ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+			       struct sk_buff *skb)
+{
+	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
+	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	u8 control = mgmt->u.action.eml_omn.control;
+	u8 *ptr = mgmt->u.action.eml_omn.variable;
+	struct ieee80211_eml_params eml_params = {
+		.link_id = status->link_id,
+		.control = control,
+	};
+	struct sta_info *sta;
+	int opt_len = 0;
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return;
+
+	/* eMLSR and eMLMR can't be enabled at the same time */
+	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) &&
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
+		return;
+
+	if ((control & IEEE80211_EML_CTRL_EMLMR_MODE) &&
+	    (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE))
+		return;
+
+	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
+	if (!ift_ext_capa)
+		return;
+
+	if (!status->link_valid)
+		return;
+
+	sta = sta_info_get_bss(sdata, mgmt->sa);
+	if (!sta)
+		return;
+
+	if (control & IEEE80211_EML_CTRL_EMLSR_MODE) {
+		u8 emlsr_param_update_len;
+
+		if (!(ift_ext_capa->eml_capabilities &
+		      IEEE80211_EML_CAP_EMLSR_SUPP))
+			return;
+
+		opt_len += sizeof(__le16); /* eMLSR link_bitmap */
+		/*
+		 * eMLSR param update field is not part of Notification frame
+		 * sent by the AP to client so account it separately.
+		 */
+		emlsr_param_update_len =
+			!!(control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE);
+
+		if (skb->len < len + opt_len + emlsr_param_update_len)
+			return;
+
+		if (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE) {
+			u8 pad_delay, trans_delay;
+
+			pad_delay = u8_get_bits(ptr[2],
+						IEEE80211_EML_EMLSR_PAD_DELAY);
+			if (pad_delay >
+			    IEEE80211_EML_CAP_EML_PADDING_DELAY_256US)
+				return;
+
+			trans_delay = u8_get_bits(ptr[2],
+					IEEE80211_EML_EMLSR_TRANS_DELAY);
+			if (trans_delay >
+			    IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
+				return;
+
+			/* Update sta padding and transition delay */
+			sta->sta.eml_cap =
+				u8_replace_bits(sta->sta.eml_cap,
+						pad_delay,
+						IEEE80211_EML_CAP_EML_PADDING_DELAY);
+			sta->sta.eml_cap =
+				u8_replace_bits(sta->sta.eml_cap,
+						trans_delay,
+						IEEE80211_EML_CAP_EML_TRANSITION_DELAY);
+		}
+	}
+
+	if (control & IEEE80211_EML_CTRL_EMLMR_MODE) {
+		u8 mcs_map_size;
+		int i;
+
+		if (!(ift_ext_capa->eml_capabilities &
+		      IEEE80211_EML_CAP_EMLMR_SUPPORT))
+			return;
+
+		opt_len += sizeof(__le16); /* eMLMR link_bitmap */
+		opt_len++; /* eMLMR mcs_map_count */
+		if (skb->len < len + opt_len)
+			return;
+
+		eml_params.emlmr_mcs_map_count = ptr[2];
+		if (eml_params.emlmr_mcs_map_count > 2)
+			return;
+
+		mcs_map_size = 3 * (1 + eml_params.emlmr_mcs_map_count);
+		opt_len += mcs_map_size;
+		if (skb->len < len + opt_len)
+			return;
+
+		for (i = 0; i < mcs_map_size; i++) {
+			u8 rx_mcs, tx_mcs;
+
+			rx_mcs = u8_get_bits(ptr[3 + i],
+					     IEEE80211_EML_EMLMR_RX_MCS_MAP);
+			if (rx_mcs > 8)
+				return;
+
+			tx_mcs = u8_get_bits(ptr[3 + i],
+					     IEEE80211_EML_EMLMR_TX_MCS_MAP);
+			if (tx_mcs > 8)
+				return;
+		}
+
+		memcpy(eml_params.emlmr_mcs_map_bw, &ptr[3], mcs_map_size);
+	}
+
+	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
+		eml_params.link_bitmap = get_unaligned_le16(ptr);
+		if ((eml_params.link_bitmap & sdata->vif.active_links) !=
+		    eml_params.link_bitmap)
+			return;
+	}
+
+	if (drv_set_eml_op_mode(sdata, &sta->sta, &eml_params))
+		return;
+
+	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);
+}
+
+void ieee80211_ap_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
+				  struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	/* rx.c cannot queue any non-action frames to AP interfaces */
+	if (WARN_ON(!ieee80211_is_action(mgmt->frame_control)))
+		return;
+
+	switch (mgmt->u.action.category) {
+	case WLAN_CATEGORY_PROTECTED_EHT:
+		switch (mgmt->u.action.action_code) {
+		case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
+			ieee80211_rx_eml_op_mode_notif(sdata, skb);
+			break;
+		}
+		break;
+	}
+}
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 3fb469ef27b7..23fe82df6abf 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -100,177 +100,3 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
-
-static void
-ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
-				 struct ieee80211_mgmt *req, int opt_len)
-{
-	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_mgmt *mgmt;
-	struct sk_buff *skb;
-
-	len += opt_len; /* optional len */
-	skb = dev_alloc_skb(local->tx_headroom + len);
-	if (!skb)
-		return;
-
-	skb_reserve(skb, local->tx_headroom);
-	mgmt = skb_put_zero(skb, len);
-	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-					  IEEE80211_STYPE_ACTION);
-	memcpy(mgmt->da, req->sa, ETH_ALEN);
-	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
-
-	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
-	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF;
-	mgmt->u.action.eml_omn.dialog_token =
-		req->u.action.eml_omn.dialog_token;
-	mgmt->u.action.eml_omn.control = req->u.action.eml_omn.control &
-		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
-		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
-	/* Copy optional fields from the received notification frame */
-	memcpy(mgmt->u.action.eml_omn.variable,
-	       req->u.action.eml_omn.variable, opt_len);
-
-	ieee80211_tx_skb(sdata, skb);
-}
-
-void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
-				    struct sk_buff *skb)
-{
-	int len = IEEE80211_MIN_ACTION_SIZE(eml_omn);
-	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	const struct wiphy_iftype_ext_capab *ift_ext_capa;
-	struct ieee80211_mgmt *mgmt = (void *)skb->data;
-	struct ieee80211_local *local = sdata->local;
-	u8 control = mgmt->u.action.eml_omn.control;
-	u8 *ptr = mgmt->u.action.eml_omn.variable;
-	struct ieee80211_eml_params eml_params = {
-		.link_id = status->link_id,
-		.control = control,
-	};
-	struct sta_info *sta;
-	int opt_len = 0;
-
-	if (!ieee80211_vif_is_mld(&sdata->vif))
-		return;
-
-	/* eMLSR and eMLMR can't be enabled at the same time */
-	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) &&
-	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
-		return;
-
-	if ((control & IEEE80211_EML_CTRL_EMLMR_MODE) &&
-	    (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE))
-		return;
-
-	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
-	if (!ift_ext_capa)
-		return;
-
-	if (!status->link_valid)
-		return;
-
-	sta = sta_info_get_bss(sdata, mgmt->sa);
-	if (!sta)
-		return;
-
-	if (control & IEEE80211_EML_CTRL_EMLSR_MODE) {
-		u8 emlsr_param_update_len;
-
-		if (!(ift_ext_capa->eml_capabilities &
-		      IEEE80211_EML_CAP_EMLSR_SUPP))
-			return;
-
-		opt_len += sizeof(__le16); /* eMLSR link_bitmap */
-		/* eMLSR param update field is not part of Notfication frame
-		 * sent by the AP to client so account it separately.
-		 */
-		emlsr_param_update_len =
-			!!(control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE);
-
-		if (skb->len < len + opt_len + emlsr_param_update_len)
-			return;
-
-		if (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE) {
-			u8 pad_delay, trans_delay;
-
-			pad_delay = u8_get_bits(ptr[2],
-						IEEE80211_EML_EMLSR_PAD_DELAY);
-			if (pad_delay >
-			    IEEE80211_EML_CAP_EML_PADDING_DELAY_256US)
-				return;
-
-			trans_delay = u8_get_bits(ptr[2],
-					IEEE80211_EML_EMLSR_TRANS_DELAY);
-			if (trans_delay >
-			    IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
-				return;
-
-			/* Update sta padding and transition delay */
-			sta->sta.eml_cap =
-				u8_replace_bits(sta->sta.eml_cap,
-						pad_delay,
-						IEEE80211_EML_CAP_EML_PADDING_DELAY);
-			sta->sta.eml_cap =
-				u8_replace_bits(sta->sta.eml_cap,
-						trans_delay,
-						IEEE80211_EML_CAP_EML_TRANSITION_DELAY);
-		}
-	}
-
-	if (control & IEEE80211_EML_CTRL_EMLMR_MODE) {
-		u8 mcs_map_size;
-		int i;
-
-		if (!(ift_ext_capa->eml_capabilities &
-		      IEEE80211_EML_CAP_EMLMR_SUPPORT))
-			return;
-
-		opt_len += sizeof(__le16); /* eMLMR link_bitmap */
-		opt_len++; /* eMLMR mcs_map_count */
-		if (skb->len < len + opt_len)
-			return;
-
-		eml_params.emlmr_mcs_map_count = ptr[2];
-		if (eml_params.emlmr_mcs_map_count > 2)
-			return;
-
-		mcs_map_size = 3 * (1 + eml_params.emlmr_mcs_map_count);
-		opt_len += mcs_map_size;
-		if (skb->len < len + opt_len)
-			return;
-
-		for (i = 0; i < mcs_map_size; i++) {
-			u8 rx_mcs, tx_mcs;
-
-			rx_mcs = u8_get_bits(ptr[3 + i],
-					     IEEE80211_EML_EMLMR_RX_MCS_MAP);
-			if (rx_mcs > 8)
-				return;
-
-			tx_mcs = u8_get_bits(ptr[3 + i],
-					     IEEE80211_EML_EMLMR_TX_MCS_MAP);
-			if (tx_mcs > 8)
-				return;
-		}
-
-		memcpy(eml_params.emlmr_mcs_map_bw, &ptr[3], mcs_map_size);
-	}
-
-	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
-	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
-		eml_params.link_bitmap = get_unaligned_le16(ptr);
-		if ((eml_params.link_bitmap & sdata->vif.active_links) !=
-		    eml_params.link_bitmap)
-			return;
-	}
-
-	if (drv_set_eml_op_mode(sdata, &sta->sta, &eml_params))
-		return;
-
-	ieee80211_send_eml_op_mode_notif(sdata, mgmt, opt_len);
-}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e23e347f870d..89214b37edf1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1973,6 +1973,10 @@ void ieee80211_clear_fast_rx(struct sta_info *sta);
 bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
 			   const u8 *addr, int *out_link_id);
 
+/* AP code */
+void ieee80211_ap_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
+				  struct sk_buff *skb);
+
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
@@ -1988,10 +1992,8 @@ void ieee80211_send_pspoll(struct ieee80211_local *local,
 void ieee80211_recalc_ps(struct ieee80211_local *local);
 void ieee80211_recalc_ps_vif(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata);
-void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
-				  struct sk_buff *skb);
-void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
-				 struct sk_buff *skb);
+void ieee80211_sta_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
+				   struct sk_buff *skb);
 void ieee80211_sta_reset_beacon_monitor(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_reset_conn_monitor(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata);
@@ -2877,8 +2879,6 @@ void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
 u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata);
 
-void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
-				    struct sk_buff *skb);
 void
 ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
@@ -2886,28 +2886,17 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
-void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_mgmt *mgmt, size_t len);
-void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_mgmt *mgmt, size_t len);
 int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 			   struct cfg80211_ttlm_params *params);
-void ieee80211_process_ttlm_teardown(struct ieee80211_sub_if_data *sdata);
 
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 int ieee80211_mgd_set_epcs(struct ieee80211_sub_if_data *sdata, bool enable);
-void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_mgmt *mgmt, size_t len);
-void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_mgmt *mgmt, size_t len);
 
 int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_ml_reconf_req *req);
 
-void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
-				      struct ieee80211_mgmt *mgmt, size_t len);
 void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
 
 void
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 95b779c4d627..e7131fb86c12 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1713,50 +1713,6 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		default:
 			break;
 		}
-	} else if (ieee80211_is_action(mgmt->frame_control) &&
-		   mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_EHT) {
-		if (sdata->vif.type == NL80211_IFTYPE_AP) {
-			switch (mgmt->u.action.action_code) {
-			case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
-				ieee80211_rx_eml_op_mode_notif(sdata, skb);
-				break;
-			default:
-				break;
-			}
-		} else if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-			switch (mgmt->u.action.action_code) {
-			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
-				ieee80211_process_neg_ttlm_req(sdata, mgmt,
-							       skb->len);
-				break;
-			case WLAN_PROTECTED_EHT_ACTION_TTLM_RES:
-				ieee80211_process_neg_ttlm_res(sdata, mgmt,
-							       skb->len);
-				break;
-			case WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN:
-				ieee80211_process_ttlm_teardown(sdata);
-				break;
-			case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
-				ieee80211_process_ml_reconf_resp(sdata, mgmt,
-								 skb->len);
-				break;
-			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP:
-				ieee80211_process_epcs_ena_resp(sdata, mgmt,
-								skb->len);
-				break;
-			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN:
-				ieee80211_process_epcs_teardown(sdata, mgmt,
-								skb->len);
-				break;
-			default:
-				break;
-			}
-		}
-	} else if (ieee80211_is_ext(mgmt->frame_control)) {
-		if (sdata->vif.type == NL80211_IFTYPE_STATION)
-			ieee80211_sta_rx_queued_ext(sdata, skb);
-		else
-			WARN_ON(1);
 	} else if (ieee80211_is_data_qos(mgmt->frame_control)) {
 		struct ieee80211_hdr *hdr = (void *)mgmt;
 		struct sta_info *sta;
@@ -1788,8 +1744,11 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				true);
 		}
 	} else switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		ieee80211_ap_rx_queued_frame(sdata, skb);
+		break;
 	case NL80211_IFTYPE_STATION:
-		ieee80211_sta_rx_queued_mgmt(sdata, skb);
+		ieee80211_sta_rx_queued_frame(sdata, skb);
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		ieee80211_ibss_rx_queued_mgmt(sdata, skb);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 00b4beff0e43..05e9644d4917 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8172,8 +8172,9 @@ ieee80211_parse_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_mgmt *mgmt, size_t len)
+static void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_mgmt *mgmt,
+					   size_t len)
 {
 	u8 dialog_token, direction[IEEE80211_TTLM_MAX_CNT] = {}, i;
 	size_t ies_len;
@@ -8235,8 +8236,9 @@ void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
 	ieee80211_send_neg_ttlm_res(sdata, ttlm_res, dialog_token, &neg_ttlm);
 }
 
-void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_mgmt *mgmt, size_t len)
+static void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
+					   struct ieee80211_mgmt *mgmt,
+					   size_t len)
 {
 	if (!ieee80211_vif_is_mld(&sdata->vif) ||
 	    mgmt->u.action.ttlm_res.dialog_token != sdata->u.mgd.dialog_token_alloc)
@@ -8257,7 +8259,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		__ieee80211_disconnect(sdata);
 }
 
-void ieee80211_process_ttlm_teardown(struct ieee80211_sub_if_data *sdata)
+static void ieee80211_process_ttlm_teardown(struct ieee80211_sub_if_data *sdata)
 {
 	u16 new_dormant_links;
 
@@ -8315,8 +8317,8 @@ void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_send_teardown_neg_ttlm);
 
-void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
-				 struct sk_buff *skb)
+static void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
+					struct sk_buff *skb)
 {
 	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_rx_status *rx_status;
@@ -8336,129 +8338,6 @@ void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
-				  struct sk_buff *skb)
-{
-	struct ieee80211_link_data *link = &sdata->deflink;
-	struct ieee80211_rx_status *rx_status;
-	struct ieee802_11_elems *elems;
-	struct ieee80211_mgmt *mgmt;
-	u16 fc;
-	int ies_len;
-
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
-
-	rx_status = (struct ieee80211_rx_status *) skb->cb;
-	mgmt = (struct ieee80211_mgmt *) skb->data;
-	fc = le16_to_cpu(mgmt->frame_control);
-
-	if (rx_status->link_valid) {
-		link = sdata_dereference(sdata->link[rx_status->link_id],
-					 sdata);
-		if (!link)
-			return;
-	}
-
-	switch (fc & IEEE80211_FCTL_STYPE) {
-	case IEEE80211_STYPE_BEACON:
-		ieee80211_rx_mgmt_beacon(link, (void *)mgmt,
-					 skb->len, rx_status);
-		break;
-	case IEEE80211_STYPE_PROBE_RESP:
-		ieee80211_rx_mgmt_probe_resp(link, skb);
-		break;
-	case IEEE80211_STYPE_AUTH:
-		ieee80211_rx_mgmt_auth(sdata, mgmt, skb->len);
-		break;
-	case IEEE80211_STYPE_DEAUTH:
-		ieee80211_rx_mgmt_deauth(sdata, mgmt, skb->len);
-		break;
-	case IEEE80211_STYPE_DISASSOC:
-		ieee80211_rx_mgmt_disassoc(sdata, mgmt, skb->len);
-		break;
-	case IEEE80211_STYPE_ASSOC_RESP:
-	case IEEE80211_STYPE_REASSOC_RESP:
-		ieee80211_rx_mgmt_assoc_resp(sdata, mgmt, skb->len);
-		break;
-	case IEEE80211_STYPE_ACTION:
-		if (!sdata->u.mgd.associated ||
-		    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr))
-			break;
-
-		switch (mgmt->u.action.category) {
-		case WLAN_CATEGORY_SPECTRUM_MGMT:
-			ies_len = skb->len -
-				  offsetof(struct ieee80211_mgmt,
-					   u.action.chan_switch.variable);
-
-			if (ies_len < 0)
-				break;
-
-			/* CSA IE cannot be overridden, no need for BSSID */
-			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
-						       ies_len,
-						       IEEE80211_FTYPE_MGMT |
-						       IEEE80211_STYPE_ACTION,
-						       NULL);
-
-			if (elems && !elems->parse_error) {
-				enum ieee80211_csa_source src =
-					IEEE80211_CSA_SOURCE_PROT_ACTION;
-
-				ieee80211_sta_process_chanswitch(link,
-								 rx_status->mactime,
-								 rx_status->device_timestamp,
-								 elems, elems,
-								 src);
-			}
-			kfree(elems);
-			break;
-		case WLAN_CATEGORY_PUBLIC:
-		case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
-			ies_len = skb->len -
-				  offsetof(struct ieee80211_mgmt,
-					   u.action.ext_chan_switch.variable);
-
-			if (ies_len < 0)
-				break;
-
-			/*
-			 * extended CSA IE can't be overridden, no need for
-			 * BSSID
-			 */
-			elems = ieee802_11_parse_elems(mgmt->u.action.ext_chan_switch.variable,
-						       ies_len,
-						       IEEE80211_FTYPE_MGMT |
-						       IEEE80211_STYPE_ACTION,
-						       NULL);
-
-			if (elems && !elems->parse_error) {
-				enum ieee80211_csa_source src;
-
-				if (mgmt->u.action.category ==
-						WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
-					src = IEEE80211_CSA_SOURCE_PROT_ACTION;
-				else
-					src = IEEE80211_CSA_SOURCE_UNPROT_ACTION;
-
-				/* for the handling code pretend it was an IE */
-				elems->ext_chansw_ie =
-					&mgmt->u.action.ext_chan_switch.data;
-
-				ieee80211_sta_process_chanswitch(link,
-								 rx_status->mactime,
-								 rx_status->device_timestamp,
-								 elems, elems,
-								 src);
-			}
-
-			kfree(elems);
-			break;
-		}
-		break;
-	}
-}
-
 static void ieee80211_sta_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -10423,8 +10302,9 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
 
-void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
-				      struct ieee80211_mgmt *mgmt, size_t len)
+static void
+ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -11247,8 +11127,9 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_mgmt *mgmt, size_t len)
+static void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_mgmt *mgmt,
+					    size_t len)
 {
 	struct ieee802_11_elems *elems __free(kfree) = NULL;
 	size_t ies_len;
@@ -11295,8 +11176,9 @@ void ieee80211_process_epcs_ena_resp(struct ieee80211_sub_if_data *sdata,
 	ieee80211_epcs_changed(sdata, true);
 }
 
-void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_mgmt *mgmt, size_t len)
+static void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_mgmt *mgmt,
+					    size_t len)
 {
 	if (!ieee80211_vif_is_mld(&sdata->vif) ||
 	    !sdata->u.mgd.epcs.enabled)
@@ -11305,3 +11187,161 @@ void ieee80211_process_epcs_teardown(struct ieee80211_sub_if_data *sdata,
 	ieee80211_epcs_teardown(sdata);
 	ieee80211_epcs_changed(sdata, false);
 }
+
+void ieee80211_sta_rx_queued_frame(struct ieee80211_sub_if_data *sdata,
+				   struct sk_buff *skb)
+{
+	struct ieee80211_link_data *link = &sdata->deflink;
+	struct ieee80211_rx_status *rx_status;
+	struct ieee802_11_elems *elems;
+	struct ieee80211_mgmt *mgmt;
+	u16 fc;
+	int ies_len;
+
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	mgmt = (struct ieee80211_mgmt *) skb->data;
+
+	if (ieee80211_is_ext(mgmt->frame_control)) {
+		ieee80211_sta_rx_queued_ext(sdata, skb);
+		return;
+	}
+
+	rx_status = (struct ieee80211_rx_status *) skb->cb;
+	fc = le16_to_cpu(mgmt->frame_control);
+
+	if (rx_status->link_valid) {
+		link = sdata_dereference(sdata->link[rx_status->link_id],
+					 sdata);
+		if (!link)
+			return;
+	}
+
+	switch (fc & IEEE80211_FCTL_STYPE) {
+	case IEEE80211_STYPE_BEACON:
+		ieee80211_rx_mgmt_beacon(link, (void *)mgmt,
+					 skb->len, rx_status);
+		break;
+	case IEEE80211_STYPE_PROBE_RESP:
+		ieee80211_rx_mgmt_probe_resp(link, skb);
+		break;
+	case IEEE80211_STYPE_AUTH:
+		ieee80211_rx_mgmt_auth(sdata, mgmt, skb->len);
+		break;
+	case IEEE80211_STYPE_DEAUTH:
+		ieee80211_rx_mgmt_deauth(sdata, mgmt, skb->len);
+		break;
+	case IEEE80211_STYPE_DISASSOC:
+		ieee80211_rx_mgmt_disassoc(sdata, mgmt, skb->len);
+		break;
+	case IEEE80211_STYPE_ASSOC_RESP:
+	case IEEE80211_STYPE_REASSOC_RESP:
+		ieee80211_rx_mgmt_assoc_resp(sdata, mgmt, skb->len);
+		break;
+	case IEEE80211_STYPE_ACTION:
+		if (!sdata->u.mgd.associated ||
+		    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr))
+			break;
+
+		switch (mgmt->u.action.category) {
+		case WLAN_CATEGORY_SPECTRUM_MGMT:
+			ies_len = skb->len -
+				  offsetof(struct ieee80211_mgmt,
+					   u.action.chan_switch.variable);
+
+			if (ies_len < 0)
+				break;
+
+			/* CSA IE cannot be overridden, no need for BSSID */
+			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
+						       ies_len,
+						       IEEE80211_FTYPE_MGMT |
+						       IEEE80211_STYPE_ACTION,
+						       NULL);
+
+			if (elems && !elems->parse_error) {
+				enum ieee80211_csa_source src =
+					IEEE80211_CSA_SOURCE_PROT_ACTION;
+
+				ieee80211_sta_process_chanswitch(link,
+								 rx_status->mactime,
+								 rx_status->device_timestamp,
+								 elems, elems,
+								 src);
+			}
+			kfree(elems);
+			break;
+		case WLAN_CATEGORY_PUBLIC:
+		case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
+			ies_len = skb->len -
+				  offsetof(struct ieee80211_mgmt,
+					   u.action.ext_chan_switch.variable);
+
+			if (ies_len < 0)
+				break;
+
+			/*
+			 * extended CSA IE can't be overridden, no need for
+			 * BSSID
+			 */
+			elems = ieee802_11_parse_elems(mgmt->u.action.ext_chan_switch.variable,
+						       ies_len,
+						       IEEE80211_FTYPE_MGMT |
+						       IEEE80211_STYPE_ACTION,
+						       NULL);
+
+			if (elems && !elems->parse_error) {
+				enum ieee80211_csa_source src;
+
+				if (mgmt->u.action.category ==
+						WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+					src = IEEE80211_CSA_SOURCE_PROT_ACTION;
+				else
+					src = IEEE80211_CSA_SOURCE_UNPROT_ACTION;
+
+				/* for the handling code pretend it was an IE */
+				elems->ext_chansw_ie =
+					&mgmt->u.action.ext_chan_switch.data;
+
+				ieee80211_sta_process_chanswitch(link,
+								 rx_status->mactime,
+								 rx_status->device_timestamp,
+								 elems, elems,
+								 src);
+			}
+
+			kfree(elems);
+			break;
+		case WLAN_CATEGORY_PROTECTED_EHT:
+			switch (mgmt->u.action.action_code) {
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
+				ieee80211_process_neg_ttlm_req(sdata, mgmt,
+							       skb->len);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_RES:
+				ieee80211_process_neg_ttlm_res(sdata, mgmt,
+							       skb->len);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN:
+				ieee80211_process_ttlm_teardown(sdata);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP:
+				ieee80211_process_ml_reconf_resp(sdata, mgmt,
+								 skb->len);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP:
+				ieee80211_process_epcs_ena_resp(sdata, mgmt,
+								skb->len);
+				break;
+			case WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN:
+				ieee80211_process_epcs_teardown(sdata, mgmt,
+								skb->len);
+				break;
+			default:
+				break;
+			}
+			break;
+		}
+		break;
+	}
+}
-- 
2.53.0


