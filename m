Return-Path: <linux-wireless+bounces-31326-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P2wpFpdde2kdEQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31326-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:16:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB5B04BB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CD130107ED
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193142A80;
	Thu, 29 Jan 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/l0SDB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5F6FC3
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692564; cv=none; b=JPk6vm38yUYlMXxwrsg5UX2WOBLG0RbzC6UfYYA3QXYJakinc4bFZm/hKeCsvsRoOIIJ0JT0NxhI0jvXCQHl+3BUnmcQ/SKlO1WH5imUOVyuFfY5LGXkomY16SYxFtN/Pziccc93Z6aSizQQVxcHa19OWmFNfGpILRxSdym2HBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692564; c=relaxed/simple;
	bh=YEbMLf0wwzn4zQ2AJDape8vX5gzPi4ez4n/GKO6BByI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfShFvLd7BuGnczi/6qzMexPk9dAkT739W2JF3Nm4xO7y4Mnhuw3hzt0bC3yJ2mQSohbJ8JkMsl3pPjtfisth0cU0uFUTE6tTRdvxzHNvUROFPI9IZqM7m4wxvXMelqMU+QnO/v2WcjWiWYdv/2rTz4lu/G9z7vmiGyFC+Upv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/l0SDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC5C116D0;
	Thu, 29 Jan 2026 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769692564;
	bh=YEbMLf0wwzn4zQ2AJDape8vX5gzPi4ez4n/GKO6BByI=;
	h=From:Date:Subject:To:Cc:From;
	b=Pi/l0SDBbi/5ZY5sj8BsawHFzDchVNX9pjF9AKRxuHLdUbhGN8Rkdsvwbi9MA0fOv
	 sKZ0Cv6qB2yp4WNnYXLxo8xsgJZb96+zLt4l4obNs9oz8xvlBRJYXR02QYXiEW8arq
	 UTu38YDXlToVtcA8aGUBXZ/U5O0DsqxUEaFFUHpOl/qELL7Xm95fi6whsgb18/ffG3
	 z9q+ku3JLjaaVbbm0fcYeJ3Hx6OPRkk64UHvKKxMQTPEs47+OU+Kt2KEVdpkzLHL1d
	 fBruKhalsPV39t/gNTZKFrTqN2xl5/Aq2gS8k4620SRAk5mFOXcDwVNNOrqrHEfLse
	 HiYis4uXB/qow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 29 Jan 2026 14:15:46 +0100
Subject: [PATCH wireless-next v4] wifi: mac80211: Add eMLSR/eMLMR action
 frame parsing support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-mac80211-emlsr-v4-1-14bdadf57380@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMSw6CMBSF4a2Yjq3pvS2lOHIfxgGUCzTyMK0hG
 sLeLSQmKMNzku+fWCDvKLDzYWKeRhfc0Mehjgdmm7yvibsyboYCtQAE3uXWCATg1LXB8yRNlTB
 YVcZaFtHDU+Vea/B6i7tx4Tn499ofYXm/KfxPjcAFrwQpWRS6zJL8ciffU3safM2W1ohbn+w8R
 q+0lpiVGqwxOy+33uy85MBVKgthocysVT9+nucPXD2SXy0BAAA=
X-Change-ID: 20260121-mac80211-emlsr-5774082ff8cc
To: Johannes Berg <johannes@sipsolutions.net>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 Shayne Chen <shayne.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31326-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BDB5B04BB
X-Rspamd-Action: no action

Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.
Add drv_set_eml_op_mode mac80211 callback in order to configure underlay
driver with eMLSR/eMLMR info.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.
Add drv_set_eml_op_mode mac80211 callback in order to configure underlay
driver with eMLSR info (control and bitmap).
Implement drv_set_eml_op_mode callback for MT7996 driver.
---
Changes in v4:
- Fix link_bitmap sanity checks
- Link to v3: https://lore.kernel.org/r/20260128-mac80211-emlsr-v3-1-473b0c1d9cc4@kernel.org

Changes in v3:
- Get rid of ieee80211_get_emlsr_pad_delay_update and
  ieee80211_get_emlsr_trans_delay_update routines and add sanity checks
  for pad_delay/trans_delay directly in ieee80211_rx_eml_op_mode_notif()
- Add mcs_map sanity checks.
- Add ieee80211_eml_params struct kernel-doc.
- Get rid of emlsr_pad_delay/emlsr_trans_delay in ieee80211_eml_params
  struct and rely on ieee80211_sta fields.
- Improve sanity checks.
- Remove mt7996 patch from the series.
- Link to v2: https://lore.kernel.org/r/20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org

Changes in v2:
- Improve sanity check against device EML capabilities
- Squash patch 1/2 and 2/2
- Validate link_bitmap with vif->active_links
- Introduce ieee80211_eml_params struct as containe for EML info to pass
  to the underlay driver.
- Pass padding_delay and transition_delay to the underlay driver.
- Implement drv_set_eml_op_mode callback for MT7996 driver.
- Link to v2: https://lore.kernel.org/r/20260122-mac80211-emlsr-v1-0-f0e43bb6d95a@kernel.org
---
 include/linux/ieee80211-eht.h |  11 +++
 include/linux/ieee80211.h     |   6 ++
 include/net/mac80211.h        |  32 ++++++++
 net/mac80211/driver-ops.h     |  21 +++++
 net/mac80211/eht.c            | 175 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h    |   2 +
 net/mac80211/iface.c          |  10 ++-
 net/mac80211/rx.c             |   8 ++
 net/mac80211/trace.h          |  32 ++++++++
 9 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index f9782e46c5e5241bccc84c3bbc18b1cc9ec1879c..11105528a2c60d8351a5c9be04fcb714878601fe 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -558,6 +558,17 @@ struct ieee80211_mle_tdls_common_info {
 
 #define IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR	0x0010
 
+#define IEEE80211_EML_CTRL_EMLSR_MODE		BIT(0)
+#define IEEE80211_EML_CTRL_EMLMR_MODE		BIT(1)
+#define IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE	BIT(2)
+#define IEEE80211_EML_CTRL_INDEV_COEX_ACT	BIT(3)
+
+#define IEEE80211_EML_EMLSR_PAD_DELAY		0x07
+#define IEEE80211_EML_EMLSR_TRANS_DELAY		0x38
+
+#define IEEE80211_EML_EMLMR_RX_MCS_MAP		0xf0
+#define IEEE80211_EML_EMLMR_TX_MCS_MAP		0x0f
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
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 36ae7fe9ddf35190921f4fee0fe3294418007a56..388076b1b17c2560756deb2966903e21049205ac 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1902,6 +1902,31 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
+/**
+ * struct ieee80211_eml_params - EHT Operating mode notification parameters
+ *
+ * EML Operating mode notification parameters received in the Operating mode
+ * notification frame. This struct is used as a container to pass the info to
+ * the underlay driver.
+ *
+ * @link_id: the link ID where the Operating mode notification frame has been
+ *	received.
+ * @control: EML control field defined in P802.11be section 9.4.1.76.
+ * @link_bitmap: eMLSR/eMLMR enabled links defined in P802.11be
+ *	section 9.4.1.76.
+ * @emlmr_mcs_map_count: eMLMR number of valid mcs_map_bw fields according to
+ *	P802.11be section 9.4.1.76 (valid if eMLMR mode control bit is set).
+ * @emlmr_mcs_map_bw: eMLMR supported MCS and NSS set subfileds defined in
+ *	P802.11be section 9.4.1.76 (valid if eMLMR mode control bit is set).
+ */
+struct ieee80211_eml_params {
+	u8 link_id;
+	u8 control;
+	u16 link_bitmap;
+	u8 emlmr_mcs_map_count;
+	u8 emlmr_mcs_map_bw[9];
+};
+
 /**
  * struct ieee80211_vif_cfg - interface configuration
  * @assoc: association status
@@ -4513,6 +4538,9 @@ struct ieee80211_prep_tx_info {
  *      interface with the specified type would be added, and thus drivers that
  *      implement this callback need to handle such cases. The type is the full
  *      &enum nl80211_iftype.
+ * @set_eml_op_mode: Configure eMLSR/eMLMR operation mode in the underlay
+ *	driver according to the parameter received in the EML Operating mode
+ *	notification frame.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4908,6 +4936,10 @@ struct ieee80211_ops {
 			struct ieee80211_neg_ttlm *ttlm);
 	void (*prep_add_interface)(struct ieee80211_hw *hw,
 				   enum nl80211_iftype type);
+	int (*set_eml_op_mode)(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct ieee80211_eml_params *eml_params);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 55105d238d6bc5963eb2863575805bee72c42399..51bf3c7822a76007e6ec59fb70e97fa50d43632b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1772,4 +1772,25 @@ drv_prep_add_interface(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_sta *sta,
+				      struct ieee80211_eml_params *eml_params)
+{
+	struct ieee80211_local *local = sdata->local;
+	int ret = -EOPNOTSUPP;
+
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	trace_drv_set_eml_op_mode(local, sdata, sta, eml_params->link_id,
+				  eml_params->control,
+				  eml_params->link_bitmap);
+	if (local->ops->set_eml_op_mode)
+		ret = local->ops->set_eml_op_mode(&local->hw, &sdata->vif,
+						  sta, eml_params);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index fd41046e3b681b753e6cc7ddf82046e4bc5df9b3..75096b2195d24358da4ae3abc595d0e349d17037 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -5,6 +5,7 @@
  * Copyright(c) 2021-2025 Intel Corporation
  */
 
+#include "driver-ops.h"
 #include "ieee80211_i.h"
 
 void
@@ -102,3 +103,177 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
+
+static void
+ieee80211_send_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_mgmt *req, int opt_len)
+{
+	int len = offsetofend(struct ieee80211_mgmt, u.action.u.eml_omn);
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
+	mgmt->u.action.u.eml_omn.action_code =
+		WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF;
+	mgmt->u.action.u.eml_omn.dialog_token =
+		req->u.action.u.eml_omn.dialog_token;
+	mgmt->u.action.u.eml_omn.control = req->u.action.u.eml_omn.control &
+		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
+		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
+	/* Copy optional fields from the received notification frame */
+	memcpy(mgmt->u.action.u.eml_omn.variable,
+	       req->u.action.u.eml_omn.variable, opt_len);
+
+	ieee80211_tx_skb(sdata, skb);
+}
+
+void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb)
+{
+	int len = offsetofend(struct ieee80211_mgmt, u.action.u.eml_omn);
+	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	u8 control = mgmt->u.action.u.eml_omn.control;
+	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
+	struct ieee80211_eml_params eml_params = {
+		.link_id = status->link_id,
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
+		/* eMLSR param update field is not part of Notfication frame
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
+			    IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
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
+						IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+			sta->sta.eml_cap =
+				u8_replace_bits(sta->sta.eml_cap,
+						trans_delay,
+						IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
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
index 30b9b4d763578feea179ad33be5174fc3fc19209..6a13460b8b6a9176f50ca9ec7fb365befc9b317c 100644
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
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 0bfbce1574862b5a6a2ca39794abea7fe9a3f34a..c04d4547e8f4655ad77b83bed6e5a832d959e61b 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3353,6 +3353,38 @@ TRACE_EVENT(drv_prep_add_interface,
 	)
 );
 
+TRACE_EVENT(drv_set_eml_op_mode,
+	    TP_PROTO(struct ieee80211_local *local,
+		     struct ieee80211_sub_if_data *sdata,
+		     struct ieee80211_sta *sta,
+		     unsigned int link_id,
+		     u8 control, u16 link_bitmap),
+
+	TP_ARGS(local, sdata, sta, link_id, control, link_bitmap),
+
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 VIF_ENTRY
+			 STA_ENTRY
+			 __field(u32, link_id)
+			 __field(u8, control)
+			 __field(u16, link_bitmap)),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       VIF_ASSIGN;
+		       STA_NAMED_ASSIGN(sta);
+		       __entry->link_id = link_id;
+		       __entry->control = control;
+		       __entry->link_bitmap = link_bitmap;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT
+		" (link:%d control:%02x link_bitmap:%04x)",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->link_id,
+		__entry->control, __entry->link_bitmap
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH

---
base-commit: c30e188bd2a886258be5facb970a804d8ef549b5
change-id: 20260121-mac80211-emlsr-5774082ff8cc

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


