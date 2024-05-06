Return-Path: <linux-wireless+bounces-7243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AE8BD550
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0451C21873
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68B13DDD8;
	Mon,  6 May 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SHXULqIb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841A13C69F
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023181; cv=none; b=BrUsbdV03hR/tWB7BIROosvE3U9xCSsz1Yfmzezp5XHU560WKoatAS39Q0QbMm/9VZ0PC0NlIHVDgPVws1EXW5XJgiSNAP7DCh32BhWagLn6wp952JDMX8VRBFWpQnraph+3nDi4+kYR5+3qbb9EiuPxjDBuJG28nx9fOgjjpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023181; c=relaxed/simple;
	bh=I2jxgKXaZiWm56yioXnPJyVLju5sjHSKYM3jexzR4v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUGxIO4RGMj2gElinV5Ibfo/1L+JkOz7y+9oA6p7zyIMgGG2pYw6X+Ync+VonNpXN4q5gs42KL+fegpl37AICoKa2BKCukr5jfxM9m0/hEe3OK0/gUF2jfoKLBhJfFl5HNcPX/3yFXaGGXkISGd6qH95287wRvMjitFQLcyttfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SHXULqIb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=rtblHLXMoIuLQOqJcXFxi4KtnNHksMzzdAa3PnppvpA=; t=1715023179; x=1716232779; 
	b=SHXULqIbiX/jSYQnsm5o0FCq49kAMN1SjEIKuKQ07SzeIcdl7DjrrsfeHg6iq2HQYyXhKoZe0v9
	jQjBWc+7sQ5w9j5MjYEkIstZjzht19NsjDhCE3Plf5ZKnk1xJEAYA8yHIWFRqqEWAtk1MBGoT5mrB
	juBPDvCqnxTneM9tdLGSuLhlSPUY0y6Y0z6UQu2+4vqn1GCVl4FzLWgjiB5YSpMAOKe13girP1AAs
	MvtEkO+Z3TH3uV9Cp4xJg+cQe3cdNPOrGTzcAmq0fMhPCKvYSYalVdvFafFqvXexepfdwoJTJ+Bwe
	69Gi+HVUkZ/ijVJ6TiNVuCPQx9/2XVvdH1qA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43s8-00000008AR0-38ZJ;
	Mon, 06 May 2024 21:19:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: remove extra link STA functions
Date: Mon,  6 May 2024 21:19:34 +0200
Message-ID: <20240506211934.9759564a25f4.I88d43aa459d15c1d6230152e76b7757c2cdd6085@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to have a lockdep assert and then call
another function, just move everything into one place.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 69 ++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bbb07ba8793b..0ed7e8bbf5c0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4974,13 +4974,17 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
 }
 
-static int sta_add_link_station(struct ieee80211_local *local,
-				struct ieee80211_sub_if_data *sdata,
-				struct link_station_parameters *params)
+static int
+ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
+			   struct link_station_parameters *params)
 {
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct sta_info *sta;
 	int ret;
 
+	lockdep_assert_wiphy(local->hw.wiphy);
+
 	sta = sta_info_get_bss(sdata, params->mld_mac);
 	if (!sta)
 		return -ENOENT;
@@ -5005,51 +5009,35 @@ static int sta_add_link_station(struct ieee80211_local *local,
 	return ieee80211_sta_activate_link(sta, params->link_id);
 }
 
-static int
-ieee80211_add_link_station(struct wiphy *wiphy, struct net_device *dev,
-			   struct link_station_parameters *params)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = wiphy_priv(wiphy);
-
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
-
-	return sta_add_link_station(local, sdata, params);
-}
-
-static int sta_mod_link_station(struct ieee80211_local *local,
-				struct ieee80211_sub_if_data *sdata,
-				struct link_station_parameters *params)
-{
-	struct sta_info *sta;
-
-	sta = sta_info_get_bss(sdata, params->mld_mac);
-	if (!sta)
-		return -ENOENT;
-
-	if (!(sta->sta.valid_links & BIT(params->link_id)))
-		return -EINVAL;
-
-	return sta_link_apply_parameters(local, sta, false, params);
-}
-
 static int
 ieee80211_mod_link_station(struct wiphy *wiphy, struct net_device *dev,
 			   struct link_station_parameters *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = wiphy_priv(wiphy);
+	struct sta_info *sta;
 
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return sta_mod_link_station(local, sdata, params);
+	sta = sta_info_get_bss(sdata, params->mld_mac);
+	if (!sta)
+		return -ENOENT;
+
+	if (!(sta->sta.valid_links & BIT(params->link_id)))
+		return -EINVAL;
+
+	return sta_link_apply_parameters(local, sta, false, params);
 }
 
-static int sta_del_link_station(struct ieee80211_sub_if_data *sdata,
-				struct link_station_del_parameters *params)
+static int
+ieee80211_del_link_station(struct wiphy *wiphy, struct net_device *dev,
+			   struct link_station_del_parameters *params)
 {
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	sta = sta_info_get_bss(sdata, params->mld_mac);
 	if (!sta)
 		return -ENOENT;
@@ -5066,17 +5054,6 @@ static int sta_del_link_station(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static int
-ieee80211_del_link_station(struct wiphy *wiphy, struct net_device *dev,
-			   struct link_station_del_parameters *params)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-
-	lockdep_assert_wiphy(sdata->local->hw.wiphy);
-
-	return sta_del_link_station(sdata, params);
-}
-
 static int ieee80211_set_hw_timestamp(struct wiphy *wiphy,
 				      struct net_device *dev,
 				      struct cfg80211_set_hw_timestamp *hwts)
-- 
2.44.0


