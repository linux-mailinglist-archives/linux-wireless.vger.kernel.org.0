Return-Path: <linux-wireless+bounces-35458-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIFMKo+C8Gn6UAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35458-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:49:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF02B481D49
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5639D30AFE7A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F33DA7ED;
	Tue, 28 Apr 2026 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DpRrim9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6303DC4D1
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367368; cv=none; b=ox0mNL2aEGUmy1JGuVX63Veth3Pu1s03WXqDZUZ8mrUm5IxU73c1HQfhn8iU0NqYzkBdYoQGA16Acn7UrxUpo6K0q1ks/YR/zcinuP/SrzrvE0jEQHbfBW1/vdxEbxMq+4t4lJ52xyj8CA0lXp8lKk70ZkHhuE23yCXIscD0fSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367368; c=relaxed/simple;
	bh=j3oJ2MitbT6lA0NYcTciUZ+2LhvnU/kRpLwHOFQpEw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxgrVt6U4BUMFJdLf+oXPdbmjJzlRbQSM/z6MBw2cGiviHx/AX4eKWCR2RVlb+Sj9sZ/4FiIimMxCX9T5ma8k+UwaHEUzNXswPJ7tzHHj3TKYav2ut2oC6c7yfp9DJvTdmKNJfLoH5vSmFwrrJUW3zSy0+bYpqUU327F8P7A1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DpRrim9q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RR4l2o76C713bB/VYAIisHjTOsvYzKXJHO9MVh+nPyc=;
	t=1777367367; x=1778576967; b=DpRrim9qpzqCXh4j0z+Tpq/i0HmYjs5QcspFoUw/OsDJkFe
	QtBE0urtuj55Ggh8qWr628ys8D/VYKcdSziboRLbiQnvAEQWeeBDFUj6ZsLaOS+CKLPQU1DsmVDJk
	I4fTBpWW66ignueRNy5uTmx2oOZqlY218T1trIAYWJdgrOC4Q9OcBt5YjJb11vGF7T/4CaEuxN3xb
	cdSLdDbck1bZFrFLof5A6oFr5SKt7dzxgpKzk3tO2rYsqriE+nZbOSnuNjIHKh/2vHYFKotbIjbEJ
	ztmOaG1Lp861kaUezoxFyBicX04RQ/US/2oM2iYjV2mpPpGtyKV/HNZ0bnM8cHkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRX-0000000HGH2-29Lf;
	Tue, 28 Apr 2026 11:09:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 5/5] wifi: mac80211: mlme: advertise driver's extended MLD capa/ops
Date: Tue, 28 Apr 2026 11:07:00 +0200
Message-ID: <20260428110915.8ddef945c81e.I43e05e424ff50a1d88b18161b843c1125c3e07fb@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428090915.54717-7-johannes@sipsolutions.net>
References: <20260428090915.54717-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF02B481D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-35458-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

If the AP has extended MLD capa/ops we may advertise our own
from userspace. Also add the driver's in this case. This is
fine since the only one right now from the driver is UHR ML-PM
and that's only relevant if the AP already has it too.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d24db2c2cde9..9d7afbf3700e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9849,7 +9849,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data;
 	const struct element *ssid_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
 	struct ieee80211_link_data *link;
+	u16 driver_ext_mld_capa_ops = 0;
 	struct cfg80211_bss *cbss;
 	bool override, uapsd_supported;
 	bool match_auth;
@@ -9888,17 +9890,26 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
 
+	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy,
+						    ieee80211_vif_type_p2p(&sdata->vif));
+	if (ift_ext_capa)
+		driver_ext_mld_capa_ops = ift_ext_capa->ext_mld_capa_and_ops;
+
 	/*
 	 * Many APs have broken parsing of the extended MLD capa/ops field,
 	 * dropping (re-)association request frames or replying with association
 	 * response with a failure status if it's present.
 	 * Set our value from the userspace request only in strict mode or if
 	 * the AP also had that field present.
+	 * For UHR we may want to advertise ML-PM (per driver_ext_mld_capa_ops)
+	 * but if the AP doesn't have it then it's pointless, and if it does
+	 * then it has to have the extended MLD capa/ops field.
 	 */
 	if (ieee80211_hw_check(&local->hw, STRICT) ||
 	    ieee80211_mgd_assoc_bss_has_mld_ext_capa_ops(req))
 		assoc_data->ext_mld_capa_ops =
-			cpu_to_le16(req->ext_mld_capa_ops);
+			cpu_to_le16(req->ext_mld_capa_ops |
+				    driver_ext_mld_capa_ops);
 
 	if (ifmgd->associated) {
 		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
@@ -10892,11 +10903,13 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 				  struct cfg80211_ml_reconf_req *req)
 {
+	const struct wiphy_iftype_ext_capab *ift_ext_capa;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgd_assoc_data *data = NULL;
 	struct sta_info *sta;
 	struct sk_buff *skb;
 	u16 added_links, new_valid_links;
+	u16 driver_ext_mld_capa_ops = 0;
 	int link_id, err;
 
 	if (!ieee80211_vif_is_mld(&sdata->vif) ||
@@ -11054,6 +11067,11 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
+	ift_ext_capa = cfg80211_get_iftype_ext_capa(local->hw.wiphy,
+						    ieee80211_vif_type_p2p(&sdata->vif));
+	if (ift_ext_capa)
+		driver_ext_mld_capa_ops = ift_ext_capa->ext_mld_capa_and_ops;
+
 	/* Build the SKB before the link removal as the construction of the
 	 * station info for removed links requires the local address.
 	 * Invalidate the removed links, so that the transmission of the ML
@@ -11062,7 +11080,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * on which the request was received.
 	 */
 	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links,
-					    cpu_to_le16(req->ext_mld_capa_ops));
+					    cpu_to_le16(req->ext_mld_capa_ops |
+							driver_ext_mld_capa_ops));
 	if (!skb) {
 		err = -ENOMEM;
 		goto err_free;
-- 
2.53.0


