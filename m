Return-Path: <linux-wireless+bounces-35455-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL5FNB198GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35455-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE67481582
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 858F23080106
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7D3D904F;
	Tue, 28 Apr 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x91lrYmW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C83D88E0
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367363; cv=none; b=p5I6LEkGZtVXHMigVezRq05lZG32hEFwSqC0nZpR10lWkI5kI/LYx8Uq0WZPzeg2WMUny2W4xsBCEPutN18cbuIdFmpS9kN0rM8ASpjui3r2ZOOk9xCJVBxkRFZlqXa6QUsBrC+Q3saA8dTy8NFgx4Kp5YPvmVzSX0GgrtWUbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367363; c=relaxed/simple;
	bh=zFBNIq5ChhjqHKz0FWU8EoRE+oN8uVRnto2hwdrlvG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMPECO4VMpLSkeTEXkekljblV++Du/J75niMdTBzW07EPdPpWnWWvzIKGnCpJtP+/+je718+OWTjIU7tnA2ZLTicTgDuMrZ1tgZn137XOynNvqNgQqHBBgW6VtKsPYW/yzisShHjx6LZNhZzOtUapo70k/v1t/f2MuFvpyFgF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x91lrYmW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zTfhJEZsOIrcGBspTnNail7eznrxrDjEYuDaIFENY4U=;
	t=1777367362; x=1778576962; b=x91lrYmWH6Sjbx/kHkmTxl0ewTVar8Y4Ra9K6i/q02k9dtU
	OdK4iqO73neVyWOXzlVJ5F4N82ZQTiyMRzgibI++61/54+neqvVZAPeQA1Zl9AwjDDkKQLCBOUtc6
	HzQ8ZSy8mcg1p7dtJOMz+dhVfCJ7KsA0RJ6CsSxKHYTxUpNRynZtJCXS5zSAztshAKIPfS9xxsrV6
	pIP8HhfkT1o6+pRJVOL4TeoRx11bc0YXMMMXz5wNjC8wc7uBjwujSML1wZdV3bF4FZyN18qZg+zgT
	s7rzWaJbGQG0PnFaJDaRYH95WMXO/SgM84CAUw62p9ytKePs+oAQYQT5iuTpQ4NA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRU-0000000HGH2-0Q7U;
	Tue, 28 Apr 2026 11:09:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/5] wifi: mac80211: track AP's extended MLD capa/ops
Date: Tue, 28 Apr 2026 11:06:57 +0200
Message-ID: <20260428110915.e4038a00e4b2.I323686be5d4a73e8b962019a30d51309496b86a6@changeid>
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
X-Rspamd-Queue-Id: DFE67481582
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
	TAGGED_FROM(0.00)[bounces-35455-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Johannes Berg <johannes.berg@intel.com>

For UHR multi-link power management, the driver/device needs
to know if the AP supports it, to be able to use it. Track
the AP's extended MLD capabilities and operations so it does.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/mlme.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 02318a4be0e1..5dc4ac08606f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2674,6 +2674,8 @@ struct ieee80211_link_sta {
  * @epp_peer: indicates that the peer is an EPP peer.
  * @nmi: For NDI stations, pointer to the NMI station of the peer.
  * @nan_sched: NAN peer schedule for this station. Valid only for NMI stations.
+ * @ext_mld_capa_ops: the MLD's extended MLD capabilities and operations
+ *	NOTE: currently only tracked for AP STAs
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2698,6 +2700,7 @@ struct ieee80211_sta {
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
 	u16 valid_links;
+	u16 ext_mld_capa_ops;
 	bool epp_peer;
 	struct ieee80211_link_sta deflink;
 	struct ieee80211_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 00b4beff0e43..d24db2c2cde9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6462,6 +6462,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	sta->sta.spp_amsdu = assoc_data->spp_amsdu;
 
 	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		if (!elems->ml_basic)
+			goto out_err;
+
+		sta->sta.ext_mld_capa_ops =
+			ieee80211_mle_get_ext_mld_capa_op((const void *)elems->ml_basic);
+
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 			if (!assoc_data->link[link_id].bss)
 				continue;
-- 
2.53.0


