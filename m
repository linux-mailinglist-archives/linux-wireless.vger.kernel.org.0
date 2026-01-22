Return-Path: <linux-wireless+bounces-31083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBRKKqRBcmnpfAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 16:26:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51868BEA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A96165AAF9B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7C322DD6;
	Thu, 22 Jan 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMiy49vY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592330596F
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089918; cv=none; b=sOsDv6jt0/WwPe6FGf+gjgrLmVC1lZm9QUEVI9njXcXjhCxhmL2Irw+vrFJIA1f87LVvQJPzgaf+GzBHL9srgRwiamBjeORXuLPG1jM8MMfY/HitRXJ49vxRUwBXBTkzkeWIwyO/r/M87rdKhAT04WpDahUvZBEAjBBB4mOoI4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089918; c=relaxed/simple;
	bh=yCWEKOTHUdqxQ+46aWuYxCX4M3hhc3zYUc8tigX9Uzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJNBgFjaoprcDozd+dxODiY2TNPUbSc4Dw3FijPJ2uhoRLeo6TMR4Z7VSkaXd8F8d6wy5Vmy7XT0fxazqNxScfZQnNxvDfItvQSLwXxD+PUmK7tmRp8YusAwL/mF/kEvv/QAwu9AAnU/LmPr9C8BvvSDE5FhvDNBP5Ir3QJj+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMiy49vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D171C116C6;
	Thu, 22 Jan 2026 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089917;
	bh=yCWEKOTHUdqxQ+46aWuYxCX4M3hhc3zYUc8tigX9Uzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iMiy49vYVcc4ohcM7RYxaJPelOLCrhAHZDK+edBFQXt2ROcACsSvMeUqo0ZEdOI1j
	 9fI/yUUK/Rm7da4xHcC7ETrR1dLdLcSK4EpfxGC7JS7MHGJktH+Z9QEPxSjsKODp5n
	 waCJVSJ6V5oKRKLB613TAr57T/4KoJ28/onNyrYoF4uT1T/rSondpsh9WRdYUCXCKe
	 dN9meY13CUmTFh9gFCh2e5CVjbG/lbDsMdQfNsLeTUPxZ2hQIva+9YDOERA5BdIrmB
	 cdWIZZZ2dI3xOkYF/kutbqrSOfg4qF6kD+CIhMi6qzrjQ9aqhtNf+OzZvydXaA+uK8
	 nL2HKCUJsLBjw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 14:51:34 +0100
Subject: [PATCH wireless-next 2/2] wifi: mac80211: Add drv_set_eml_op_mode
 driver callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mac80211-emlsr-v1-2-f0e43bb6d95a@kernel.org>
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
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-31083-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D51868BEA
X-Rspamd-Action: no action

Introduce drv_set_eml_op_mode mac80211 callback in order to configure
underlay driver with eMLSR info (control and bitmap). eMLMR is currently
not supported.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/mac80211.h    |  7 +++++++
 net/mac80211/driver-ops.h | 21 +++++++++++++++++++++
 net/mac80211/eht.c        | 26 ++++++++++++++++++++++++--
 net/mac80211/trace.h      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 36ae7fe9ddf35190921f4fee0fe3294418007a56..3920135595c545a4255bf513c2c8b0525a383c71 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4513,6 +4513,9 @@ struct ieee80211_prep_tx_info {
  *      interface with the specified type would be added, and thus drivers that
  *      implement this callback need to handle such cases. The type is the full
  *      &enum nl80211_iftype.
+ * @set_eml_op_mode: Configure eMLSR/eMLMR operation mode in the underlay
+ *	driver according to the parameter received in the EML Operating mode
+ *	notification frame.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4908,6 +4911,10 @@ struct ieee80211_ops {
 			struct ieee80211_neg_ttlm *ttlm);
 	void (*prep_add_interface)(struct ieee80211_hw *hw,
 				   enum nl80211_iftype type);
+	int (*set_eml_op_mode)(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_link_sta *link_sta,
+			       u8 control, __le16 link_bitmap);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 55105d238d6bc5963eb2863575805bee72c42399..a3f2a38241edbea62698cb1104a11a80681983a0 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1772,4 +1772,25 @@ drv_prep_add_interface(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline int drv_set_eml_op_mode(struct ieee80211_sub_if_data *sdata,
+				      struct ieee80211_link_sta *link_sta,
+				      u8 control, __le16 link_bitmap)
+{
+	struct ieee80211_local *local = sdata->local;
+	int ret = 0;
+
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	trace_drv_set_eml_op_mode(local, sdata, link_sta, control,
+				  link_bitmap);
+	if (local->ops->set_eml_op_mode)
+		ret = local->ops->set_eml_op_mode(&local->hw, &sdata->vif,
+						  link_sta, control,
+						  link_bitmap);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index f1f60d41fccfc2da4ecd2961f6a524e94a6bfa6c..cb5d0ca08ac3aa81f928ab4e05107515dc111858 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -5,6 +5,7 @@
  * Copyright(c) 2021-2025 Intel Corporation
  */
 
+#include "driver-ops.h"
 #include "ieee80211_i.h"
 
 void
@@ -136,17 +137,22 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 {
 	int hdr_len = offsetof(struct ieee80211_mgmt, u.action.u.eml_omn);
 	enum nl80211_iftype type = ieee80211_vif_type_p2p(&sdata->vif);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	const struct wiphy_iftype_ext_capab *ift_ext_capa;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_local *local = sdata->local;
 	u8 control = mgmt->u.action.u.eml_omn.control;
 	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct link_sta_info *link_sta;
+	__le16 link_bitmap = 0;
+	struct sta_info *sta;
 	u8 act_len = 3; /* action_code + dialog_token + control */
 
 	if (!ieee80211_vif_is_mld(&sdata->vif))
 		return;
 
-	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy, type);
+	ift_ext_capa = cfg80211_get_iftype_ext_capa(wiphy, type);
 	if (!ift_ext_capa)
 		return;
 
@@ -160,8 +166,10 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if ((control & IEEE80211_EML_CTRL_EMLSR_MODE) ||
-	    (control & IEEE80211_EML_CTRL_EMLMR_MODE))
+	    (control & IEEE80211_EML_CTRL_EMLMR_MODE)) {
+		link_bitmap = get_unaligned((__le16 *)ptr);
 		act_len += sizeof(__le16); /* eMLSR/eMLMR link_bitmap */
+	}
 
 	if (control & IEEE80211_EML_CTRL_EMLMR_MODE) {
 		u8 mcs_map_count = ptr[3];
@@ -176,5 +184,19 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 	if (skb->len < hdr_len + act_len)
 		return;
 
+	if (!status->link_valid)
+		return;
+
+	sta = sta_info_get_bss(sdata, mgmt->sa);
+	if (!sta)
+		return;
+
+	link_sta = wiphy_dereference(wiphy, sta->link[status->link_id]);
+	if (!link_sta)
+		return;
+
+	if (drv_set_eml_op_mode(sdata, link_sta->pub, control, link_bitmap))
+		return;
+
 	ieee80211_send_eml_op_mode_notif(sdata, mgmt, act_len);
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 0bfbce1574862b5a6a2ca39794abea7fe9a3f34a..584658bd4640c72aef3199cd9341699924fd5fea 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3353,6 +3353,37 @@ TRACE_EVENT(drv_prep_add_interface,
 	)
 );
 
+TRACE_EVENT(drv_set_eml_op_mode,
+	    TP_PROTO(struct ieee80211_local *local,
+		     struct ieee80211_sub_if_data *sdata,
+		     struct ieee80211_link_sta *link_sta,
+		     u8 control, __le16 link_bitmap),
+
+	TP_ARGS(local, sdata, link_sta, control, link_bitmap),
+
+	TP_STRUCT__entry(LOCAL_ENTRY
+			 VIF_ENTRY
+			 STA_ENTRY
+			 __field(u32, link_id)
+			 __field(u8, control)
+			 __field(__le16, link_bitmap)),
+
+	TP_fast_assign(LOCAL_ASSIGN;
+		       VIF_ASSIGN;
+		       STA_NAMED_ASSIGN(link_sta->sta);
+		       __entry->link_id = link_sta->link_id;
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


