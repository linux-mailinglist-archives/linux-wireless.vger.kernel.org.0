Return-Path: <linux-wireless+bounces-31141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG6TN931dWkXKAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1B801F3
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C0703007973
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294413168FB;
	Sun, 25 Jan 2026 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVlUycEN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069051DDA18
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769338327; cv=none; b=SgAWUQgGcet24ErxzzrbdqFUS3mR06WgGDXM45xA89NcKE5cSuxRo6JcqqLmEGOlgDEPTvEwDiSmutjp41EbIhNBFDpzdQ1YirxAL0qSbxVyfAP7WcX/x/AXctIywhJBgiQkdfXAf6/1QHASbVCYbLh3bVSObiZZmHL8Hp4Qc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769338327; c=relaxed/simple;
	bh=x49NqnhTD/pWlkEDuZUhA0jZq15rIJVe4sdMUDuxYFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtnBVnZmsc+aihEpdxU542mPaxv6yHVIiorDFQStQsme6nNbhctSY6GiETg9I7FzRQ2z/EAhzXlKWSvjx6DCBoAz0Zd+DM52/MYYouDGGuMSGqWxboV+LmWfweDBiBMwN/YEbqj40gVedcxMEkvgEknOCzpPtTIxN92G2gYScBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVlUycEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E8FC4CEF1;
	Sun, 25 Jan 2026 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769338326;
	bh=x49NqnhTD/pWlkEDuZUhA0jZq15rIJVe4sdMUDuxYFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tVlUycENE/VFJZ8tvL9FJgQKTNtwoXs6DY0C8BmEQuwU8CunEL/yW5uGBt2SbyDAH
	 4Lvk8yFCNacPCdfqd3G7vZluk3XLM/TQY5ltXksOeP0KkudMJmu3PCYAlKLazaXgrQ
	 PHy/1DaOCm1BNtMfkMs5wbGnyhlXcAMTWEgg5nsOFNb9NmbwQE/lXfd6NvPkJ8jTOD
	 B6EstIZ2uElLkezfOsxCEnveDiB7KE4LLgYaTuIy2RkvfB1Vcq2nNtRpYNdBj2eOXL
	 WVY5cQYpuMd0F0BJoJ3qG550hcUDB41k3b2Ved2upgV5/Ya2owcqqmLgB/7M/lDGFo
	 gEh/EXATLRmQA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 25 Jan 2026 11:51:30 +0100
Subject: [PATCH wireless-next v2 1/2] wifi: mac80211: Add eMLSR/eMLMR
 action frame parsing support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-mac80211-emlsr-v2-1-466329d61c88@kernel.org>
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
In-Reply-To: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31141-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sipsolutions.net,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 81C1B801F3
X-Rspamd-Action: no action

Introduce support in AP mode for parsing of the Operating Mode Notification
frame sent by the client to enable/disable MLO eMLSR or eMLMR if supported
by both the AP and the client.
Add drv_set_eml_op_mode mac80211 callback in order to configure underlay
driver with eMLSR/eMLMR info.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/ieee80211-eht.h |  28 +++++++++
 include/linux/ieee80211.h     |   6 ++
 include/net/mac80211.h        |  23 +++++++
 net/mac80211/driver-ops.h     |  22 +++++++
 net/mac80211/eht.c            | 135 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h    |   2 +
 net/mac80211/iface.c          |  10 +++-
 net/mac80211/rx.c             |   8 +++
 net/mac80211/trace.h          |  32 ++++++++++
 9 files changed, 265 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index f9782e46c5e5241bccc84c3bbc18b1cc9ec1879c..d78496d0307a1ff1e03a27b3491394166850f3e5 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -558,6 +558,34 @@ struct ieee80211_mle_tdls_common_info {
 
 #define IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR	0x0010
 
+#define IEEE80211_EML_CTRL_EMLSR_MODE		BIT(0)
+#define IEEE80211_EML_CTRL_EMLMR_MODE		BIT(1)
+#define IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE	BIT(2)
+#define IEEE80211_EML_CTRL_INDEV_COEX_ACT	BIT(3)
+
+#define IEEE80211_EML_EMLSR_PAD_DELAY		0x07
+#define IEEE80211_EML_EMLSR_TRANS_DELAY		0x38
+
+static inline u8 ieee80211_get_emlsr_pad_delay_update(u8 param)
+{
+	u8 pad_delay = FIELD_GET(IEEE80211_EML_EMLSR_PAD_DELAY, param);
+
+	if (pad_delay > IEEE80211_EML_CAP_EMLSR_PADDING_DELAY_256US)
+		pad_delay = 0;
+
+	return pad_delay;
+}
+
+static inline u32 ieee80211_get_emlsr_trans_delay_update(u8 param)
+{
+	u16 trans_delay = FIELD_GET(IEEE80211_EML_EMLSR_TRANS_DELAY, param);
+
+	if (trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
+		trans_delay = 0;
+
+	return trans_delay;
+}
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
index 36ae7fe9ddf35190921f4fee0fe3294418007a56..fb7ba70ffa639dabba4aa5760c27b2d70f030c28 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1902,6 +1902,21 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
+struct ieee80211_eml_params {
+	u8 control;
+	u16 link_bitmap;
+	union {
+		struct {
+			u16 emlsr_pad_delay;
+			u16 emlsr_trans_delay;
+		};
+		struct {
+			u8 mcs_map_count;
+			u8 mcs_map_bw[9];
+		};
+	};
+};
+
 /**
  * struct ieee80211_vif_cfg - interface configuration
  * @assoc: association status
@@ -4513,6 +4528,9 @@ struct ieee80211_prep_tx_info {
  *      interface with the specified type would be added, and thus drivers that
  *      implement this callback need to handle such cases. The type is the full
  *      &enum nl80211_iftype.
+ * @set_eml_op_mode: Configure eMLSR/eMLMR operation mode in the underlay
+ *	driver according to the parameter received in the EML Operating mode
+ *	notification frame.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4908,6 +4926,11 @@ struct ieee80211_ops {
 			struct ieee80211_neg_ttlm *ttlm);
 	void (*prep_add_interface)(struct ieee80211_hw *hw,
 				   enum nl80211_iftype type);
+	int (*set_eml_op_mode)(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       unsigned int link_id,
+			       struct ieee80211_eml_params *eml_params);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 55105d238d6bc5963eb2863575805bee72c42399..29f2b9bab859b50de5420beb4984211eb2270bae 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1772,4 +1772,26 @@ drv_prep_add_interface(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_sta *sta,
+				      unsigned int link_id,
+				      struct ieee80211_eml_params *eml_params)
+{
+	struct ieee80211_local *local = sdata->local;
+	int ret = 0;
+
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	trace_drv_set_eml_op_mode(local, sdata, sta, link_id,
+				  eml_params->control,
+				  eml_params->link_bitmap);
+	if (local->ops->set_eml_op_mode)
+		ret = local->ops->set_eml_op_mode(&local->hw, &sdata->vif,
+						  sta, link_id, eml_params);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index fd41046e3b681b753e6cc7ddf82046e4bc5df9b3..29cb348e9f1bbd541f6a6d82899087f36be4ef22 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -5,6 +5,7 @@
  * Copyright(c) 2021-2025 Intel Corporation
  */
 
+#include "driver-ops.h"
 #include "ieee80211_i.h"
 
 void
@@ -102,3 +103,137 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
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
+	mgmt->u.action.u.eml_omn.control &=
+		~(IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE |
+		  IEEE80211_EML_CTRL_INDEV_COEX_ACT);
+	ieee80211_tx_skb(sdata, skb);
+}
+
+void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
+				    struct sk_buff *skb)
+{
+	int hdr_len = offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
+	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	u8 control = mgmt->u.action.u.eml_omn.control;
+	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
+	struct ieee80211_eml_params eml_params = {};
+	struct sta_info *sta;
+	u8 act_len = 3; /* action_code + dialog_token + control */
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
+		if (!(ift_ext_capa->eml_capabilities &
+		      IEEE80211_EML_CAP_EMLSR_SUPP))
+			return;
+
+		if (control & IEEE80211_EML_CTRL_EMLSR_PARAM_UPDATE) {
+			u16 eml_cap = sta->sta.eml_cap;
+			u8 pad_delay, trans_delay;
+
+			/* Update sta padding and transition delay */
+			pad_delay =
+				ieee80211_get_emlsr_pad_delay_update(ptr[3]);
+			trans_delay =
+				ieee80211_get_emlsr_pad_delay_update(ptr[3]);
+
+			eml_cap &= ~(IEEE80211_EML_CAP_EMLSR_PADDING_DELAY |
+				     IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+			eml_cap |= FIELD_PREP(IEEE80211_EML_EMLSR_PAD_DELAY,
+					      pad_delay) |
+				   FIELD_PREP(IEEE80211_EML_EMLSR_TRANS_DELAY,
+					      trans_delay);
+			sta->sta.eml_cap = eml_cap;
+		}
+
+		eml_params.emlsr_pad_delay =
+			ieee80211_emlsr_pad_delay_in_us(sta->sta.eml_cap);
+		eml_params.emlsr_trans_delay =
+			ieee80211_emlsr_trans_delay_in_us(sta->sta.eml_cap);
+	}
+
+	if (control & IEEE80211_EML_CTRL_EMLMR_MODE) {
+		u8 mcs_map_size;
+
+		if (!(ift_ext_capa->eml_capabilities &
+		      IEEE80211_EML_CAP_EMLMR_SUPPORT))
+			return;
+
+		eml_params.mcs_map_count = ptr[3];
+		if (eml_params.mcs_map_count > 2)
+			return;
+
+		/* mcs_map_count_control and mcs_map_bw */
+		mcs_map_size = 3 * (1 + eml_params.mcs_map_count);
+		memcpy(eml_params.mcs_map_bw, &ptr[4], mcs_map_size);
+		act_len += 1 + mcs_map_size;
+	}
+
+	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
+		eml_params.link_bitmap = get_unaligned_le16(ptr);
+		if (eml_params.link_bitmap &&
+		    !(eml_params.link_bitmap & sdata->vif.active_links))
+			return;
+
+		act_len += sizeof(__le16); /* eMLSR/eMLMR link_bitmap */
+	}
+
+	if (skb->len < hdr_len + act_len)
+		return;
+
+	if (drv_set_eml_op_mode(sdata, &sta->sta, status->link_id,
+				&eml_params))
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

-- 
2.52.0


