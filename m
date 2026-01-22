Return-Path: <linux-wireless+bounces-31082-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAc3LT4zcmmadwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31082-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:25:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3E67E5F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF04578C0D8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD96325727;
	Thu, 22 Jan 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv3oSPZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2331A7EA
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089915; cv=none; b=Fdu4WW2rE6Vmd/J87lluwVSqFFT+aJzGogXrxMhpoxxQvksIt15mOiu+F3O8l1puG7GgS4hB9OmYoQLQvz8lnFT3nSMECYXjq1ugAoEdnt0J0WKLmuLDF4fa/chPyrZThMUJmriXN5oz3uSGxoecXygUJ139mbua7+ETA5PVo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089915; c=relaxed/simple;
	bh=QTkWYKw57wG56SDMJhyvx/sMmU7Pdrz2QkwuQ6hivis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0BarFUq6qnAQUidhtMl8yU02291hPTgugo4Ox/af1i+qgWW+L6B+1A8/V26EQ9kdY3uoB3MOnp3Rpdk4RZXU1OIQYacEtbn2953Z9j3HA/uM8HNHo7mQkdDsFkbyUNMHO/ESZoXW+wRujlYja/ZjGfmmX/8HoNO8P9e+kmy07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv3oSPZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A386DC116C6;
	Thu, 22 Jan 2026 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089915;
	bh=QTkWYKw57wG56SDMJhyvx/sMmU7Pdrz2QkwuQ6hivis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cv3oSPZ1nb+lA5ik5dCnNfWvS/VjFZv0d8xLhl/iLebAyJxT1kmZo2zO8wQOWXruE
	 YWev48rbsU7OWYj/tWJoPJtempuddVeDqdhyI0QPDg1b/qO/Eu9N1s3KzNuK0ZxG9k
	 s25M9dyMcwxf25A4ln2ciC+P48HO1XFzanKSCcmPrVgl8bpGvLks6CnsY6FfGoVuN6
	 d2Dz/AzmzkOoH0YYWpPKpYH2Mri64KuwtpU0kXwYx5dsBQJDnsFD2vabkt8+VtNdYU
	 9VBctbpqE22GeiFlaHS/czUKHvsqnWwgbPQVHfJyDYTpH5uUIIo6F034ssHAgSqQjA
	 yA8qyl4f7LDVw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 14:51:33 +0100
Subject: [PATCH wireless-next 1/2] wifi: mac80211: Add EMLSR/EMLMR action
 frame parsing support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mac80211-emlsr-v1-1-f0e43bb6d95a@kernel.org>
References: <20260122-mac80211-emlsr-v1-0-f0e43bb6d95a@kernel.org>
In-Reply-To: <20260122-mac80211-emlsr-v1-0-f0e43bb6d95a@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 Shayne Chen <shayne.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31082-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 18F3E67E5F
X-Rspamd-Action: no action

Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/ieee80211-eht.h |  5 +++
 include/linux/ieee80211.h     |  6 ++++
 net/mac80211/eht.c            | 76 +++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h    |  2 ++
 net/mac80211/iface.c          | 10 +++++-
 net/mac80211/rx.c             |  8 +++++
 6 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index f9782e46c5e5241bccc84c3bbc18b1cc9ec1879c..f409469d3db87c5714c68f8dada6fa212dff5c55 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -558,6 +558,11 @@ struct ieee80211_mle_tdls_common_info {
 
 #define IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR	0x0010
 
+#define IEEE80211_EML_CTRL_EMLSR_MODE		BIT(0)
+#define IEEE80211_EML_CTRL_EMLMR_MODE		BIT(1)
+#define IEEE80211_EML_CTRL_PARAM_UPDATE		BIT(2)
+#define IEEE80211_EML_CTRL_INDEV_COEX_ACT	BIT(3)
+
 /* no fixed fields in PRIO_ACCESS */
 
 /**
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fbde215c25aa79efd339aa530896a29dbb1a8ff8..f2c6f34f39f24ce59cbb2650f70e898d24d12901 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1186,6 +1186,12 @@ struct ieee80211_mgmt {
 					u8 action_code;
 					u8 variable[];
 				} __packed epcs;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 control;
+					u8 variable[];
+				} __packed eml_omn;
 			} u;
 		} __packed action;
 		DECLARE_FLEX_ARRAY(u8, body); /* Generic frame body */
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index fd41046e3b681b753e6cc7ddf82046e4bc5df9b3..f1f60d41fccfc2da4ecd2961f6a524e94a6bfa6c 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -102,3 +102,79 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
+
+static void
+ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_mgmt *req, u8 act_len)
+{
+	int hdr_len = offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(local->tx_headroom + hdr_len + act_len);
+	if (!skb)
+		return;
+
+	skb_reserve(skb, local->tx_headroom);
+	mgmt = skb_put_zero(skb, hdr_len);
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	memcpy(mgmt->da, req->sa, ETH_ALEN);
+	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
+	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
+
+	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
+	memcpy(&mgmt->u.action.u.eml_omn, &req->u.action.u.eml_omn, act_len);
+	mgmt->u.action.u.eml_omn.control &= ~(IEEE80211_EML_CTRL_PARAM_UPDATE |
+					      IEEE80211_EML_CTRL_INDEV_COEX_ACT);
+	ieee80211_tx_skb(sdata, skb);
+}
+
+void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb)
+{
+	int hdr_len = offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
+	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	u8 control = mgmt->u.action.u.eml_omn.control;
+	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
+	u8 act_len = 3; /* action_code + dialog_token + control */
+
+	if (!ieee80211_vif_is_mld(&sdata->vif))
+		return;
+
+	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
+	if (!ift_ext_capa)
+		return;
+
+	if (!(ift_ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP) &&
+	    !(ift_ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLMR_SUPPORT))
+		return;
+
+	/* eMLSR and eMLMR can't be enabled at the same time */
+	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) &&
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
+		return;
+
+	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
+		act_len += sizeof(__le16); /* eMLSR/eMLMR link_bitmap */
+
+	if (control & IEEE80211_EML_CTRL_EMLMR_MODE) {
+		u8 mcs_map_count = ptr[3];
+
+		if (mcs_map_count > 2)
+			return;
+
+		/* mcs_map_count_control and mcs_map_bw */
+		act_len += 2 + mcs_map_count;
+	}
+
+	if (skb->len < hdr_len + act_len)
+		return;
+
+	ieee80211_send_eml_op_mode_notif(sdata, mgmt, act_len);
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index dc757cb329740d621f6a9deb4e9ffe258e1b7d67..3ef93cd1fb33e2614c3e06c51d6b1ebcafa4824c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2837,6 +2837,8 @@ void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
 u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata);
 
+void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb);
 void
 ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3ce94b95decd64eea4ea063ae98c111bdfd57e9c..17476fd9259b68b3d9c649eabad10efa42d56cd7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1664,7 +1664,15 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 		}
 	} else if (ieee80211_is_action(mgmt->frame_control) &&
 		   mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_EHT) {
-		if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+		if (sdata->vif.type == NL80211_IFTYPE_AP) {
+			switch (mgmt->u.action.u.eml_omn.action_code) {
+			case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
+				ieee80211_rx_eml_op_mode_notif(sdata, skb);
+				break;
+			default:
+				break;
+			}
+		} else if (sdata->vif.type == NL80211_IFTYPE_STATION) {
 			switch (mgmt->u.action.u.ttlm_req.action_code) {
 			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
 				ieee80211_process_neg_ttlm_req(sdata, mgmt,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ac437256f5d5c4b34601fd4c8a6f6f80469b2522..521e44c9e8dac498122e7a595d1eb8bb5751789d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3928,6 +3928,14 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 					      u.action.u.epcs))
 				goto invalid;
 			goto queue;
+		case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
+			if (sdata->vif.type != NL80211_IFTYPE_AP)
+				break;
+
+			if (len < offsetofend(typeof(*mgmt),
+					      u.action.u.eml_omn))
+				goto invalid;
+			goto queue;
 		default:
 			break;
 		}

-- 
2.52.0


