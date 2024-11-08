Return-Path: <linux-wireless+bounces-15132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B019C17D0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5232F1F2426E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CC1F5FA;
	Fri,  8 Nov 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XRSCQR14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C91CBE89
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054154; cv=none; b=ZIGpnN0sWunmv7kFU/jyHv1g0iCUgFlDKK0fQpOKeAwwQ+SAjnAzQ7zTM/bQPl9rJTA2e08j6bEvDtt+vpCexmM1qzpqKvgcgNxj5ZhioDIix6LqIQGawOmdiAR2rfvUwStK1ncrnRtQ4nKorBSvI9mJd9e2WGdJs/QGynzm3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054154; c=relaxed/simple;
	bh=eBXUIoY0PAfZwIywxjDlHaOSbCkgT8gC6BYT+9E/jAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwPhgvCez8ot3WQ/F6nSkpkCERfF233gOjyiGcbwYoLEdIL56eYG1oxmZAtNv4tm6XpB/niprLTK//ZjcuZj6gDj8YdhP2balWZvocu4NKXAyyIzjWR+rtk9aSFuYJZ0u0EoVr4WAzQ15MAItLk0PJxspv0NQlzNXbmNrKsmork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XRSCQR14; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FQeHemll8eJ6xFGML3YYQVNXMnHaZ9+dyOAKJuRc/2Q=; t=1731054153; x=1732263753; 
	b=XRSCQR14f+bOVkXII4G2KNsX6yElIs5rZRaa0/+p3w7T4yAFMm3A6xsBQTrllVVr5EsF+NNpqIk
	k5f9siHDhItmWvf4STtC9+AkudjCK9W6T5prXgdY4GbsdLUSM/3n7vPeVDfFT2liz7msGTzWUlFHK
	J3CjSuHAQ+/H521loG7dSdZOir5X061azUzoHYc5gFRdWMmvfO1T56V7Q40qEjalEuwQu4JJ0GjfZ
	dId0WwmXixBovPyzjCqNoeU705Z/bcBz15uDkrw4469SDO5Avyqd16RvkZxm5f/Ss+Z29vosKfxh/
	K3hIxLePZt6wNx+LZE/Cxu19Dj+XAEol5nCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9KGD-0000000HAqN-41oe;
	Fri, 08 Nov 2024 09:22:30 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: pass MBSSID config by reference
Date: Fri,  8 Nov 2024 09:22:27 +0100
Message-ID: <20241108092227.48fbd8a00112.I64abc1296a7557aadf798d88db931024486ab3b6@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's inefficient and confusing to pass the MBSSID config
by value, requiring the whole struct to be copied. Pass
it by reference instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6c0b228523cb..132e194c8d72 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -143,7 +143,7 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
-					   struct cfg80211_mbssid_config params,
+					   struct cfg80211_mbssid_config *params,
 					   struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_sub_if_data *tx_sdata;
@@ -154,10 +154,10 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	if (sdata->vif.type != NL80211_IFTYPE_AP || !params.tx_wdev)
+	if (sdata->vif.type != NL80211_IFTYPE_AP || !params->tx_wdev)
 		return -EINVAL;
 
-	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params.tx_wdev);
+	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params->tx_wdev);
 	if (!tx_sdata)
 		return -EINVAL;
 
@@ -166,9 +166,9 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	} else {
 		sdata->vif.mbssid_tx_vif = &tx_sdata->vif;
 		link_conf->nontransmitted = true;
-		link_conf->bssid_index = params.index;
+		link_conf->bssid_index = params->index;
 	}
-	if (params.ema)
+	if (params->ema)
 		link_conf->ema_ap = true;
 
 	return 0;
@@ -1414,7 +1414,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-						      params->mbssid_config,
+						      &params->mbssid_config,
 						      link_conf);
 		if (err)
 			return err;
-- 
2.47.0


