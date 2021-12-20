Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9238547A7CC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhLTKgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 05:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLTKgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 05:36:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478DC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=0/GGYwNlwXk7CxYWyFBN4t+QEdtCOP+hC0VK91MO/AM=; t=1639996575; x=1641206175; 
        b=TDWu32sH0M0ydEMdkPW5ne5fzk85m0hR6ew4y3STrDeBi9YXRhfF9+6klupT6rQ2ucN9zvthsAm
        Pjt7o6wVX3dcaIRvSXW1+H9Ya+fRc5WbUsUcYzXlKse/wxuJvu91H3ZFj1NE1NCTGMIb+1meEZQT4
        nPPMehoFBN3xFnfzpubjvMpN2HrC4MKOI/0YQjizicsLdGv8uQ/aGuw5XNKlWZNMPOcQXWy+QZZTx
        bItKpdeKWfLhA7GOxDVERz2hqJetmep9DIVefjd8drwwOjmgz4fpsTuRx++mwE7Zc26j5sX+1N5Xe
        npeMUpOO+4kZU56aMsor1qFxFykIxuqEloUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzG1c-00E44M-HF;
        Mon, 20 Dec 2021 11:36:12 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: use ieee80211_bss_get_elem()
Date:   Mon, 20 Dec 2021 11:36:10 +0100
Message-Id: <20211220113609.56f8e2a70152.Id5a56afb8a4f9b38d10445e5a1874e93e84b5251@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Instead of ieee80211_bss_get_ie(), use the more typed
ieee80211_bss_get_elem().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0a854ca6aa58..cb2a89225543 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4899,7 +4899,7 @@ static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_bss *cbss)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	const u8 *ht_cap_ie, *vht_cap_ie;
+	const struct element *ht_cap_elem, *vht_cap_elem;
 	const struct ieee80211_ht_cap *ht_cap;
 	const struct ieee80211_vht_cap *vht_cap;
 	u8 chains = 1;
@@ -4907,9 +4907,9 @@ static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT)
 		return chains;
 
-	ht_cap_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_CAPABILITY);
-	if (ht_cap_ie && ht_cap_ie[1] >= sizeof(*ht_cap)) {
-		ht_cap = (void *)(ht_cap_ie + 2);
+	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
+	if (ht_cap_elem && ht_cap_elem->datalen >= sizeof(*ht_cap)) {
+		ht_cap = (void *)ht_cap_elem->data;
 		chains = ieee80211_mcs_to_chains(&ht_cap->mcs);
 		/*
 		 * TODO: use "Tx Maximum Number Spatial Streams Supported" and
@@ -4920,12 +4920,12 @@ static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_VHT)
 		return chains;
 
-	vht_cap_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_cap_ie && vht_cap_ie[1] >= sizeof(*vht_cap)) {
+	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
+	if (vht_cap_elem && vht_cap_elem->datalen >= sizeof(*vht_cap)) {
 		u8 nss;
 		u16 tx_mcs_map;
 
-		vht_cap = (void *)(vht_cap_ie + 2);
+		vht_cap = (void *)vht_cap_elem->data;
 		tx_mcs_map = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
 		for (nss = 8; nss > 0; nss--) {
 			if (((tx_mcs_map >> (2 * (nss - 1))) & 3) !=
-- 
2.33.1

