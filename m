Return-Path: <linux-wireless+bounces-8875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E690529A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E134B20C2B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C816F0D0;
	Wed, 12 Jun 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dhxnSKI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E516F29C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195834; cv=none; b=nXHVlkyMmH/hBL4B4PBGSb8zGa2hZgKOKjlPTwuFfKGpt6yT23wjoW0dKApECP5r17ZhSgSkKZrKgO4DAovCpWsLfP+PDs/BH/qkub1fZGpkkXtB8bmORfQsjhkPQ/3qT++XcUe49z2oEMPfLanvml17ikaXJxKkTCEWanG83ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195834; c=relaxed/simple;
	bh=pOBzQxoEtjBHcwxTVXjwLyBrE6fXqjQVDD6au7sYBO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzQ+YGQobYmMGy3Iqnmlc0oMZyjaDYpCtZo9P4yTPe5a74XIbwFd14F/tNQm+Tv/4V/lY7gl+R6d9FrcCZdSVJBj0it6sClkQIdLIMwPB48GTLPtI2IhQz95H9Ol94P9DDE2H/iDfk1RC22r/heSl3R9gq535z0bfhxLhxbkAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dhxnSKI4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EOLbreBYqsnNHlSNBBbXkwdqpQdnYDVKuJtj5Y5rERY=;
	t=1718195833; x=1719405433; b=dhxnSKI4mgEY80wxclb2ymRLEiOxLFLiCgMiLpG1zTHU7J/
	tSm2Yx6iIlVJCTFOtK+o+LugRJbTq54lx4QHjgXpqsiKMCH/VRNKbThZjMuKIecMg641oy2vVdnqF
	TQ1SmnmFWs/AqkD95Hbi5MmCxWYT4a91C44YvwsIUUshl3sJ0UAsxDGGGLUj7n13j9f0Tx60BW9VE
	UBx4CrzbMizTP7Ws7xd1ntr7TfqHO8ZCaqkICcn7GmdC9i+OpnRJXktIBgLYaMTokaDMcd6s/5IvT
	zpHz6JOzfuY3Sro83VBqXDY39TC5qZBYHvwVk7/C9lIEYmeHwl0b0hBMG0H9rskg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNDy-0000000AH0b-3HRY;
	Wed, 12 Jun 2024 14:37:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: add ieee80211_tdls_sta_link_id()
Date: Wed, 12 Jun 2024 14:35:56 +0200
Message-ID: <20240612143707.9f8141ae1725.I343822bbba0ae08dedb2f54a0ce87f2ae5ebeb2b@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123707.38067-4-johannes@sipsolutions.net>
References: <20240612123707.38067-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We've open-coded this twice and will need it again,
add ieee80211_tdls_sta_link_id() to get the one link
ID for a TDLS STA.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.h | 6 ++++++
 net/mac80211/tx.c       | 6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index bd5e2f7146f6..9195d5a2de0a 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -727,6 +727,12 @@ struct sta_info {
 	struct ieee80211_sta sta;
 };
 
+static inline int ieee80211_tdls_sta_link_id(struct sta_info *sta)
+{
+	/* TDLS STA can only have a single link */
+	return sta->sta.valid_links ? __ffs(sta->sta.valid_links) : 0;
+}
+
 static inline enum nl80211_plink_state sta_plink_state(struct sta_info *sta)
 {
 #ifdef CONFIG_MAC80211_MESH
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f861d99e5f05..72a9ba8bc5fd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2774,8 +2774,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 
 		if (tdls_peer) {
 			/* For TDLS only one link can be valid with peer STA */
-			int tdls_link_id = sta->sta.valid_links ?
-					   __ffs(sta->sta.valid_links) : 0;
+			int tdls_link_id = ieee80211_tdls_sta_link_id(sta);
 			struct ieee80211_link_data *link;
 
 			/* DA SA BSSID */
@@ -3101,8 +3100,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	case NL80211_IFTYPE_STATION:
 		if (test_sta_flag(sta, WLAN_STA_TDLS_PEER)) {
 			/* For TDLS only one link can be valid with peer STA */
-			int tdls_link_id = sta->sta.valid_links ?
-					   __ffs(sta->sta.valid_links) : 0;
+			int tdls_link_id = ieee80211_tdls_sta_link_id(sta);
 			struct ieee80211_link_data *link;
 
 			/* DA SA BSSID */
-- 
2.45.2


