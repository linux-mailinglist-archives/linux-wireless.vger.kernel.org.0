Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3241D876
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbhI3LN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350356AbhI3LNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1CC06176C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yGMnvVRzOYzDaByg12wg6haTJ5LaiHCV5/RnKZcdOgw=;
        t=1633000295; x=1634209895; b=FKffrZMpaTznN/14FKnnxnLkWM4bEXJMFfV4dWlYa4W5YUz
        54ODV1hAOgF2PgoJyCigm91PmYxtYh5mXHbB7OY9x0iRxvLwM0fLsNe1Lqfs9AGvFVHD6aq14Ec5e
        LVMoFa/nOe1B4gr1ECgZRJWMfMVRYh33oBpWdx4upjtRgdf1lSa5dL2Y9DhRLON8LGA16nfeGQ7Zh
        iq1lV6lYkoCSQu6Qu1G457F3Jey+ObgkMpzU4poKqycXMYSyT84zV0P+uy0ZDQFiYfcR0Z7iikkkD
        V0PWVXXF5bPm/uKwlSb6gZK7KF/8ywYFzQPK1kzOGVuhmpy+oM3ENPitm0qLR6Cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyQ-00Dlti-7z;
        Thu, 30 Sep 2021 13:11:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] nl80211: use element finding functions
Date:   Thu, 30 Sep 2021 13:11:29 +0200
Message-Id: <20210930131130.b838f139cc8e.I2b641262d3fc6e0d498719bf343fdc1c0833b845@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
References: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The element finding functions are safer, so use them
instead of the "find_ie" functions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3f37e4d5c5d2..e72efe146d58 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5338,21 +5338,21 @@ nl80211_parse_unsol_bcast_probe_resp(struct cfg80211_registered_device *rdev,
 }
 
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
-					    const u8 *rates)
+					    const struct element *rates)
 {
 	int i;
 
 	if (!rates)
 		return;
 
-	for (i = 0; i < rates[1]; i++) {
-		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
+	for (i = 0; i < rates->datalen; i++) {
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HT_PHY)
 			params->ht_required = true;
-		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_VHT_PHY)
 			params->vht_required = true;
-		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_HE_PHY)
 			params->he_required = true;
-		if (rates[2 + i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
+		if (rates->data[i] == BSS_MEMBERSHIP_SELECTOR_SAE_H2E)
 			params->sae_h2e_required = true;
 	}
 }
@@ -5367,27 +5367,27 @@ static void nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
 	const struct cfg80211_beacon_data *bcn = &params->beacon;
 	size_t ies_len = bcn->tail_len;
 	const u8 *ies = bcn->tail;
-	const u8 *rates;
-	const u8 *cap;
+	const struct element *rates;
+	const struct element *cap;
 
-	rates = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies, ies_len);
+	rates = cfg80211_find_elem(WLAN_EID_SUPP_RATES, ies, ies_len);
 	nl80211_check_ap_rate_selectors(params, rates);
 
-	rates = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
+	rates = cfg80211_find_elem(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
 	nl80211_check_ap_rate_selectors(params, rates);
 
-	cap = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies, ies_len);
-	if (cap && cap[1] >= sizeof(*params->ht_cap))
-		params->ht_cap = (void *)(cap + 2);
-	cap = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
-	if (cap && cap[1] >= sizeof(*params->vht_cap))
-		params->vht_cap = (void *)(cap + 2);
-	cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
-	if (cap && cap[1] >= sizeof(*params->he_cap) + 1)
-		params->he_cap = (void *)(cap + 3);
-	cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
-	if (cap && cap[1] >= sizeof(*params->he_oper) + 1)
-		params->he_oper = (void *)(cap + 3);
+	cap = cfg80211_find_elem(WLAN_EID_HT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->ht_cap))
+		params->ht_cap = (void *)cap->data;
+	cap = cfg80211_find_elem(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->vht_cap))
+		params->vht_cap = (void *)cap->data;
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->he_cap) + 1)
+		params->he_cap = (void *)(cap->data + 1);
+	cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
+	if (cap && cap->datalen >= sizeof(*params->he_oper) + 1)
+		params->he_oper = (void *)(cap->data + 1);
 }
 
 static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
-- 
2.31.1

