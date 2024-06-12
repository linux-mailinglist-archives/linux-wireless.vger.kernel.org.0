Return-Path: <linux-wireless+bounces-8866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8079890527B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B241C21843
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0E16F901;
	Wed, 12 Jun 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Kp2pCGcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8D172799
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195452; cv=none; b=b7PyaotYdiPG41xSTeHy5dQLnHHk6HUVboKuwIzGJux5SKgX7VMMYubB2ITIcL61uFewe1IywgriKvdkMX0rvOBq+eyRMak8llLpaTmMPaV/5dWpDfMs/8zQAwscDNQl6uRCck/6KXoUbSADOIEheVKLc07yFYXBe2NFbTlRVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195452; c=relaxed/simple;
	bh=RywbknV8SP0fOLGcJYxg4qNIa4JkeIxwQQlegGFPnAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj4YGOmS0+FrVbyObKQd8r70IfEW6f/GlaXSPQ1DrIZ9D4Swy7Vx6O4wZuWUMliXW6cHcdQU9SzZekPN9oFvovCoU8wLEgTauJIe281NL6E92lf9Tf4HBortqaAIMsuGAIXqUFoC8fGd6VoadDpgLjijgxbYZFBIUmRoYA0Tloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Kp2pCGcJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LFVrlfKjtdFmRd6RQ+XaAHOlKyCDa66dUA8J2QyEWdQ=;
	t=1718195450; x=1719405050; b=Kp2pCGcJQanwpMesrAR7YdM0B8+YEuCSNbSstm62NyDxCI/
	BbBTUYMDxugX6ga9nU9x9yxvinOdAyFoyizZiP3ufH5WPw59FbdIz9ZSnQB72g4ryqJK+6rA1nKUR
	eEGKfrGJKqwtSrFPFhzrWYwCQdyYc1jfCnJUpa3EABo/gPl4UiRnXGP6wb9RQQi/kaicZCKOoaVIU
	hlr6r3ojyna/XaZWg3lA35hy3vS3LdRN7mdsJhR+0hrc9pJ5MCt0nRLIe0AMjGqXX+4XsGH2yacuP
	HrUjoH/xDYBxjEiZR0oNUDFgsdIM7XhyrUMNdOgbY1JY1oCBGQTbXvg92YrMgsdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHN7o-0000000AGRh-0dfg;
	Wed, 12 Jun 2024 14:30:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/3] wifi: mac80211: handle protected dual of public action
Date: Wed, 12 Jun 2024 14:28:37 +0200
Message-ID: <20240612143037.db642feb8b2e.I184fa5c9bffb68099171701e403c2aa733f60fde@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123037.36687-5-johannes@sipsolutions.net>
References: <20240612123037.36687-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The code currently handles ECSA (extended channel switch
announcement) public action frames. Handle also their
protected dual, which actually is protected.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 22 ++++++++++++++--------
 net/mac80211/rx.c   |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fff158b1615f..e76b887a46eb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7429,6 +7429,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_link_data *link = &sdata->deflink;
 	struct ieee80211_rx_status *rx_status;
+	struct ieee802_11_elems *elems;
 	struct ieee80211_mgmt *mgmt;
 	u16 fc;
 	int ies_len;
@@ -7472,9 +7473,8 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr))
 			break;
 
-		if (mgmt->u.action.category == WLAN_CATEGORY_SPECTRUM_MGMT) {
-			struct ieee802_11_elems *elems;
-
+		switch (mgmt->u.action.category) {
+		case WLAN_CATEGORY_SPECTRUM_MGMT:
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
 					   u.action.u.chan_switch.variable);
@@ -7498,9 +7498,9 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 								 src);
 			}
 			kfree(elems);
-		} else if (mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
-			struct ieee802_11_elems *elems;
-
+			break;
+		case WLAN_CATEGORY_PUBLIC:
+		case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
 			ies_len = skb->len -
 				  offsetof(struct ieee80211_mgmt,
 					   u.action.u.ext_chan_switch.variable);
@@ -7517,8 +7517,13 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					ies_len, true, NULL);
 
 			if (elems && !elems->parse_error) {
-				enum ieee80211_csa_source src =
-					IEEE80211_CSA_SOURCE_UNPROT_ACTION;
+				enum ieee80211_csa_source src;
+
+				if (mgmt->u.action.category ==
+						WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+					src = IEEE80211_CSA_SOURCE_PROT_ACTION;
+				else
+					src = IEEE80211_CSA_SOURCE_UNPROT_ACTION;
 
 				/* for the handling code pretend it was an IE */
 				elems->ext_chansw_ie =
@@ -7532,6 +7537,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			}
 
 			kfree(elems);
+			break;
 		}
 		break;
 	}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4914692750e5..0ff9062a130c 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3617,6 +3617,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
 		break;
 	case WLAN_CATEGORY_PUBLIC:
+	case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
 		if (len < IEEE80211_MIN_ACTION_SIZE + 1)
 			goto invalid;
 		if (sdata->vif.type != NL80211_IFTYPE_STATION)
-- 
2.45.2


