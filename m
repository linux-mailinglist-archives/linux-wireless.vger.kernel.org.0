Return-Path: <linux-wireless+bounces-35905-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENJbNe7s+WkLFQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35905-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:13:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9F4CE38A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37687304E090
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF114418CE;
	Tue,  5 May 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="voT0W1t7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDE42DFFE
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986773; cv=none; b=L6Jgxf3i9lf7jC/nzCu5okHCy5nOpq/3zh7zNyNI3k4qayfbigDa2hnyXM1Bgwei+hlpBa4K3XbAWo3DrHppdQUM+Z6WRDX6pCFAI4iEXM6xfMj6xejw/PxtGvl9OtS/qWSOsOb+hvHET/un+H/k53Fmv5I2WoS2qeyzrHi2Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986773; c=relaxed/simple;
	bh=KYgReFnOSiOh08fzcb9TucZdS6/tsBY8fBNawv4uq2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtYpiRe6s+v6fQ6tUIBQjYsHsHeqHm2RNMvMzjQYspBG1A5fT80gU7pCFJK89Iu3pt0euOYKbbMgFFIt3+MhXk31vrZUzr80OD9L24kdzkHEbe0PpsOlSI2IoJImJsQIWwjF+uw7kZlRMSTFYzTV27DIsqRmFdo4cYdr00xyxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=voT0W1t7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LUvjJVsr2OG78uRE0bzy95TNNvw6alHP4uuKeDEZncU=;
	t=1777986771; x=1779196371; b=voT0W1t7eNSKHF03KtkUFehGimYVYeJA8EPhCIGJx4Lv2zi
	l5TgtEBO63ZDusVxfZVcqwBCHd4EqA0u7qha/PPIc0wIPo22VmZZzyXwDwN6ifRwJxmFZBZWsEGVG
	SHtZp+g/KmxQf+e7YRMX2wRwGVi1KHnclge8nDYGcQmnTDtPKSyV+6DMwAK1TVjxWhYaXtD8KONVf
	n0OT/UQxkK2dvZl0+I5WYsudSqCeXDH9JuiqbxtW/TYoLmBI7Vphi+MpbUjGCJDphLwEi/6Jy5nuN
	IKdvApHWXoEJJ8VPsFbNsc1DQMQPffKEKHhCBkjnNiNp7csdk+whsIEN45ERtUzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKFZv-0000000GENC-0XYj;
	Tue, 05 May 2026 15:12:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: explicitly disable FTM responder on AP stop
Date: Tue,  5 May 2026 15:12:16 +0200
Message-ID: <20260505151241.f213196d7d6a.I95d65c030e986c5f7d63ecbd79596da890b9fc84@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505151241.285da8fbf7f4.I1b6922ca8d06d592356d7a5d190e6118fec1d5b5@changeid>
References: <20260505151241.285da8fbf7f4.I1b6922ca8d06d592356d7a5d190e6118fec1d5b5@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45D9F4CE38A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-35905-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]

From: Johannes Berg <johannes.berg@intel.com>

When stopping the AP, explicitly disable FTM responder while
disabling beaconing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0ebc58a768a4..0b1291ff7a2c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1990,6 +1990,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_link_data *link =
 		sdata_dereference(sdata->link[link_id], sdata);
 	struct ieee80211_bss_conf *link_conf = link->conf;
+	u64 changes = BSS_CHANGED_BEACON_ENABLED;
 	LIST_HEAD(keys);
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2039,6 +2040,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (old_s1g_short_beacon)
 		kfree_rcu(old_s1g_short_beacon, rcu_head);
 
+	if (link_conf->ftm_responder) {
+		link_conf->ftm_responder = false;
+		changes |= BSS_CHANGED_FTM_RESPONDER;
+	}
+
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
 
@@ -2060,8 +2066,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.cfg.ssid_len = 0;
 	sdata->vif.cfg.s1g = false;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_link_info_change_notify(sdata, link,
-					  BSS_CHANGED_BEACON_ENABLED);
+	ieee80211_link_info_change_notify(sdata, link, changes);
 
 	ieee80211_remove_link_keys(link, &keys);
 	if (!list_empty(&keys)) {
-- 
2.53.0


