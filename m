Return-Path: <linux-wireless+bounces-37108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJQvJEBOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:28:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E55725FF275
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 711C3308B20E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50175367297;
	Fri, 29 May 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xe8fonNA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66563537F7
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043213; cv=none; b=p5Ztvag1MjftsC1r33vfO4wyqxWHYRMoi8Y6Bf8ZPzwe/vQXql6uBaUQv47buxqIQQiEbKBx7doAbFPsPynBlm1k96xtBC3ck8EiOCFT9kFzpZHjP68HF1NQUrUiMqoVYxpRdbyn9s4wtom/VMrBo4DPnMU3LWbD1e75u8HB0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043213; c=relaxed/simple;
	bh=1J53UR8OSX761VaM1h8uiuzJwDhl4PriXV9Kzy94nWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6U4i0xh5eE9aoc5w2CoOfb/9Fr1bbfWbeZsayARk3hJSD4KritsdYl7PDQJZRPEm9ZVFZtdVZjCumpsalQwE81XwIYwgULC8/S7FXM0NvsoH6R+JlRABEof+KXaj/tbt31GQNHlUNW+PlnhDd+Y8bnrjdpSGWPN1clKLmTtdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xe8fonNA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dcIiGLGdqIi+iPNnLWHtda2cRCT+FOhtTwkGlUBJQ/o=;
	t=1780043211; x=1781252811; b=xe8fonNAnjy6RNmMMUJt6ow9//S0xNmbTiN9t7QxTAFEXAd
	FtQFgIUL0+M3NMgZfQ2zSsTkiBgnav0318bYhNEjTU1XRss629wbsy3WazoTAg2E9tGJkcbRD1pWZ
	hKxZ2AjGlkq4Y9e2dlA7wMvT/uocsaTJzrUa9/RFpCaROZ09uDq/zWFfTq2EUHM9quRoeJWJPwx5J
	aKZAJLXgneZ4D0X3YQpBjmCDSs4UOHJIboKsPHRLaDjxJ6fnv7THyNW4ledIH9XCUlt4LVoVnjS3Z
	JpiGctqpm2czB6STvGnKomq91sxQI35NtBOPcWtY1loS/HoOqQ1CicJEjjHAhUDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYL-00000009bVp-1gCe;
	Fri, 29 May 2026 10:26:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 02/16] wifi: mac80211: unify link STA removal in vif link removal
Date: Fri, 29 May 2026 10:24:55 +0200
Message-ID: <20260529102644.c352f73a4658.I7219a5d72dab2abcecea9b5c52e7eb7a50e68d9b@changeid>
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
	TAGGED_FROM(0.00)[bounces-37108-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: E55725FF275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There are multiple cases where interface links are removed
and the station links need to be removed with them, e.g.
in mlme.c we have both received and transmitted multi-link
reconfiguration, doing the two things in different order,
the former deleting STA links when the vif link change may
still fail.

It's also not clear that userspace (hostapd) couldn't, at
least in theory, remove a link from an interface without
removing the station links first, or even leave stations
that aren't MLO-capable, using that link.

Unify this code into ieee80211_vif_update_links() so that
it always happens, always happens in the right order and
is transactional (i.e. failures are handled correctly.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/link.c | 30 ++++++++++++++++++++++++++++++
 net/mac80211/mlme.c | 19 -------------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index e81dd02de12e..d0535268962c 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -292,6 +292,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	u16 old_active = sdata->vif.active_links;
 	unsigned long add = new_links & ~old_links;
 	unsigned long rem = old_links & ~new_links;
+	unsigned long sta_rem = rem;
 	unsigned int link_id;
 	int ret;
 	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *link;
@@ -299,6 +300,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
 	bool use_deflink = old_links == 0; /* set for error case */
 	bool non_sta = sdata->vif.type != NL80211_IFTYPE_STATION;
+	struct sta_info *sta;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -402,6 +404,34 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		goto free;
 	}
 
+	/* try to remove links that are now invalid from (MLO) stations */
+	list_for_each_entry(sta, &sdata->local->sta_list, list) {
+		unsigned long rem_links = sta->sta.valid_links & sta_rem;
+
+		if (sta->sdata != sdata)
+			continue;
+
+		/*
+		 * skip stations that would have no links left,
+		 * those will be removed completely later
+		 */
+		if (sta->sta.valid_links == rem_links)
+			continue;
+
+		for_each_set_bit(link_id, &rem_links,
+				 IEEE80211_MLD_MAX_NUM_LINKS)
+			ieee80211_sta_remove_link(sta, link_id);
+	}
+
+	/*
+	 * Remove stations using any removed links. Note that due
+	 * to the above station link removal, this only removes
+	 * stations that were skipped above because they'd have no
+	 * links left after link removal.
+	 */
+	for_each_set_bit(link_id, &sta_rem, IEEE80211_MLD_MAX_NUM_LINKS)
+		sta_info_flush(sdata, link_id);
+
 	/* use deflink/bss_conf again if and only if there are no more links */
 	use_deflink = new_links == 0;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e8d6f6a95c0a..c2ef6c66acde 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7171,7 +7171,6 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		container_of(work, struct ieee80211_sub_if_data,
 			     u.mgd.ml_reconf_work.work);
 	u16 new_valid_links, new_active_links, new_dormant_links;
-	struct sta_info *sta;
 	int ret;
 
 	if (!sdata->u.mgd.removed_links)
@@ -7207,16 +7206,6 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		}
 	}
 
-	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
-	if (sta) {
-		unsigned long removed_links = sdata->u.mgd.removed_links;
-		unsigned int link_id;
-
-		for_each_set_bit(link_id, &removed_links,
-				 IEEE80211_MLD_MAX_NUM_LINKS)
-			ieee80211_sta_remove_link(sta, link_id);
-	}
-
 	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
 
 	ret = ieee80211_vif_set_links(sdata, new_valid_links,
@@ -11073,14 +11062,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			goto err_free;
 		}
 
-		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-		     link_id++) {
-			if (!(req->rem_links & BIT(link_id)))
-				continue;
-
-			ieee80211_sta_remove_link(sta, link_id);
-		}
-
 		/* notify the driver and upper layers */
 		ieee80211_vif_cfg_change_notify(sdata,
 						BSS_CHANGED_MLD_VALID_LINKS);
-- 
2.53.0


