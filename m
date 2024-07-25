Return-Path: <linux-wireless+bounces-10521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00993C761
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 18:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539E41F23828
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A519D091;
	Thu, 25 Jul 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K5sYpMIz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908919D085;
	Thu, 25 Jul 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926130; cv=none; b=lSivFaGpg3UdaRHB8Ax0NKgduI/ZNoF7J2iEZYU28MN+LHEqqrU160eLyjbGZBQ2FMaEtBVVcJycYxia11UfsyNLOcuofQ89H8fse9egcVaLLwSQNXvE0w3Eb1hnML3JpvbwvInm4Z8IDAkKtO/x26LJyN88LuSRzW+EhcjP2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926130; c=relaxed/simple;
	bh=mNxRZhWTYWvjQ6GbpTd0Q2gN6C9WNjC0Ku45YF3VtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2nmvFy67gCC4xPZZz/OeYMZhOI09gefz6CWhGKu5jh1uLxP0hP/EZiYLWe5ZvtIRZ2Cj9UHaSXrI2/AUWjS+ypjM2ltzkgfTkcR0BHyhi24AS+RZiiO0DtFaNJyoSxCqvkXslGny6pDGB3YQpjLeI4gwvfK8B39f7TNfmTye9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K5sYpMIz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9GRXsqtJqB+zxLU2hhsgTH5dKFuuY+T9Igyf7NLYpJc=; t=1721926128; x=1723135728; 
	b=K5sYpMIzDi9Xex9sdVGZchMK4Zccr7n/Eus26g/dn7+O48xHPXfJCSxUWylsExGfcXMA1ZBXhGA
	GrJ9ZEsZHd2R4bfvzuG9tL0Dh8uSq6dEeWKDldVFaZI1whg1WHk2zR+JWx/Rp2SBx0Wz1DxGsaDNi
	NtilueQnEmvkl047vq2SprJIByIvT/dUjhAY4zWvjD5fItppT84wZOym3zb1njZQf1G90Kq6qvbit
	4A3vWH5nz9RL9y0rJIgkQ3oduGNsX2XwvfVinFUrlLSPJ9K3Nbcw1Q0yMGgoXWB4neLQWcsW+tNEu
	HsqnT60VunpO2iEIe3iUUzaduYf/m9p24tyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sX1dv-0000000GkhZ-11ST;
	Thu, 25 Jul 2024 18:48:39 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	ZeroBeat <ZeroBeat@gmx.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH wireless] wifi: mac80211: use monitor sdata with driver only if desired
Date: Thu, 25 Jul 2024 18:48:36 +0200
Message-ID: <20240725184836.25d334157a8e.I02574086da2c5cf0e18264ce5807db6f14ffd9c0@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In commit 0d9c2beed116 ("wifi: mac80211: fix monitor channel
with chanctx emulation") I changed mac80211 to always have an
internal monitor_sdata to have something to have the chanctx
bound to.

However, if the driver didn't also have the WANT_MONITOR flag
this would cause mac80211 to allocate it without telling the
driver (which was intentional) but also use it for later APIs
to the driver without it ever having known about it which was
_not_ intentional.

Check through the code and only use the monitor_sdata in the
relevant places (TX, MU-MIMO follow settings, TX power, and
interface iteration) when the WANT_MONITOR flag is set.

Cc: stable@vger.kernel.org
Fixes: 0d9c2beed116 ("wifi: mac80211: fix monitor channel with chanctx emulation")
Reported-by: ZeroBeat <ZeroBeat@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219086
Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c  | 7 +++++--
 net/mac80211/tx.c   | 5 +++--
 net/mac80211/util.c | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 85cb71de370f..b02b84ce2130 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -114,7 +114,7 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 
 	/* apply all changes now - no failures allowed */
 
-	if (monitor_sdata)
+	if (monitor_sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 		ieee80211_set_mu_mimo_follow(monitor_sdata, params);
 
 	if (params->flags) {
@@ -3053,6 +3053,9 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+			if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+				return -EOPNOTSUPP;
+
 			sdata = wiphy_dereference(local->hw.wiphy,
 						  local->monitor_sdata);
 			if (!sdata)
@@ -3115,7 +3118,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	if (has_monitor) {
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
-		if (sdata) {
+		if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
 			sdata->deflink.user_power_level = local->user_power_level;
 			if (txp_type != sdata->vif.bss_conf.txpower_type)
 				update_txp_type = true;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 72a9ba8bc5fd..edba4a31844f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1768,7 +1768,7 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 			break;
 		}
 		sdata = rcu_dereference(local->monitor_sdata);
-		if (sdata) {
+		if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
 			vif = &sdata->vif;
 			info->hw_queue =
 				vif->hw_queue[skb_get_queue_mapping(skb)];
@@ -3957,7 +3957,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			break;
 		}
 		tx.sdata = rcu_dereference(local->monitor_sdata);
-		if (tx.sdata) {
+		if (tx.sdata &&
+		    ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
 			vif = &tx.sdata->vif;
 			info->hw_queue =
 				vif->hw_queue[skb_get_queue_mapping(skb)];
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ced19ce7c51a..c7ad9bc5973a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -776,7 +776,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 	sdata = rcu_dereference_check(local->monitor_sdata,
 				      lockdep_is_held(&local->iflist_mtx) ||
 				      lockdep_is_held(&local->hw.wiphy->mtx));
-	if (sdata &&
+	if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    (iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL || !active_only ||
 	     sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		iterator(data, sdata->vif.addr, &sdata->vif);
-- 
2.45.2


