Return-Path: <linux-wireless+bounces-32757-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LX2MdKErmnKFgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32757-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:29:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFFB2357E7
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72CE30086CE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3236896F;
	Mon,  9 Mar 2026 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKn1iIF5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95E358379
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044921; cv=none; b=lvaexqGIWZ/2UTpvsBF6YTdDGxj4EwmWryQnBDBQnSwQ22qjQXszLM/m+gV3Y5zoZcZYHrXCCHFaupS8Ap9iMasntlxZDYRTdWsr6RmxupLiTg7z1Tu//kolg9bIx3NxW2XNVToUnxdGscjDeQ3zNz3kff38+x2cnTmgSZFNy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044921; c=relaxed/simple;
	bh=TZLMWXC3WOWrpM2Ow/Qd02r37mwN4URSVr9ATULcAFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NNXLZXPjVQprpUOjtvlUmeNE0NryBccaxEThtUeNTCPIp5AjBRCukCDk4Y5pcL9R+Lk8r242uXmdM9ir6GFCEqCA5b+1FLC5D1XDVEM4OTM0reNxUcdiLqexLtXP791MTtWh6BsmcWRRtSzVKc3ku1cxhICOdpHn0cG4vV6bfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKn1iIF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F17C4CEF7;
	Mon,  9 Mar 2026 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044920;
	bh=TZLMWXC3WOWrpM2Ow/Qd02r37mwN4URSVr9ATULcAFs=;
	h=From:Date:Subject:To:Cc:From;
	b=CKn1iIF5cxYzw4F5BjHcBiLO+NgEqfnYzJagol/CEfwrOB4YxZIE2uzy8L05zWKKX
	 g5eF5RaWAiwlgz9QGY9+zAUJk5rwV98CLonVPiKql5+078t3LWQH0Zg6A3kS6ImGvz
	 QDI8war6ZlMNb5KroGaOqGNfhVihnwLEjVvzo8GxTohFeoBpO0ye68sfAXk39vzCyh
	 sylHjRrSUkQVdq4o1RIXkUjR9yDLAUBo2TaqCV7p/yRZMyqUoQGGJG08sNHYas5avL
	 jvVaRc/5hBmHA1TTn4+c2EttRZR3BijbFq1pRvfMkj9dzHRsX03ezdkDMF/yzQ20gj
	 IN0JBULvNQa8w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 09 Mar 2026 09:28:28 +0100
Subject: [PATCH wireless-next v2] wifi: mac80211: Remove deleted sta links
 in ieee80211_ml_reconf_work()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-mac80211-reconf-remove-sta-link-v2-1-1582aac720c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr2K6dkxbhKIr72FYTMoUGqA1U9JoC
 He3cgJXP+8v3ttEIvaUxP20Cabsk4+hgD6fhB0xDAS+Lyy01I2spIEFbSu1UsBkY3BllpgJ0oo
 w+zABXo3DW01o0IhieTE5/z4Kz67w6NMa+XMEs/q9/7uzAgXkqG6lkbavmsdEHGi+RB5Et+/7F
 /7aYbLPAAAA
X-Change-ID: 20260307-mac80211-reconf-remove-sta-link-a47fa95ea7a7
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 2DFFB2357E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32757-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Delete stale station links announced in the reconfiguration IE
transmitted by the AP in the beacon frames.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Remove unnecessary read_lock()/read_unlock()
- Link to v1: https://lore.kernel.org/r/20260307-mac80211-reconf-remove-sta-link-v1-1-efe58070cd36@kernel.org
---
 net/mac80211/mlme.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5ecd3d1b172df70c6e447351c89f956b6d873c20..71b8aeb22ea9a77b8ae34397aeb03199c152d313 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7058,6 +7058,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		container_of(work, struct ieee80211_sub_if_data,
 			     u.mgd.ml_reconf_work.work);
 	u16 new_valid_links, new_active_links, new_dormant_links;
+	struct sta_info *sta;
 	int ret;
 
 	if (!sdata->u.mgd.removed_links)
@@ -7093,6 +7094,16 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 		}
 	}
 
+	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (sta) {
+		unsigned long removed_links = sdata->u.mgd.removed_links;
+		unsigned int link_id;
+
+		for_each_set_bit(link_id, &removed_links,
+				 IEEE80211_MLD_MAX_NUM_LINKS)
+			ieee80211_sta_free_link(sta, link_id);
+	}
+
 	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
 
 	ret = ieee80211_vif_set_links(sdata, new_valid_links,

---
base-commit: 97492c019da4b62df83255e968b23b81c0315530
change-id: 20260307-mac80211-reconf-remove-sta-link-a47fa95ea7a7

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


