Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE94115DB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhITNdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbhITNc6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:32:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7CC061767
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cuPlf9q6lmv22e44XBjq5lfgVM6nGftG3smhl81Bmrk=;
        t=1632144689; x=1633354289; b=WsunOO574hbwv1P6vpVjoVAd+xBrtH7DppnyZ24iVvKSY5E
        V0/eRRfxzjgCVS0o51aaIo8LdYpXw8bqYbSW4cushtJ4y3f3ccXr/JUJDNxJNUB1rGj+MYJo+hU9B
        V+nF56Bl4UE1qsiBC323nAgMzmH1tDix2bQEDRXPX2RUNsQiIULQe81l74S2WQ+YvIjEwp1Exh92F
        RSVPXFme+gPBp4GDNhiAVrHpBgqjqLIpAKdzU0PVV2X9s8/YUW/1MN+h4Lthvh+//b+iCuV5Nc7II
        sFrkR9wmdw6tbHHYL2yaLzAfGQecv45lTniRQc8GOgNdft9dCoFxlJQ5CtflL3BA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJOJ-009S8n-GD;
        Mon, 20 Sep 2021 15:31:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/6] mac80211: mlme: find auth challenge directly
Date:   Mon, 20 Sep 2021 15:31:22 +0200
Message-Id: <20210920153122.b1de9f9ca1a5.Ice3159ffad03a007d6154cbf1fb3a8c48489e86f@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
References: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to parse all elements etc. just to find the
authentication challenge - use cfg80211_find_elem() instead.
This also allows us to remove WLAN_EID_CHALLENGE handling
from the element parsing entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/mlme.c        | 11 ++++++-----
 net/mac80211/util.c        |  4 ----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6a129a08bc9b..7a9e529f8366 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1517,7 +1517,6 @@ struct ieee802_11_elems {
 	const u8 *supp_rates;
 	const u8 *ds_params;
 	const struct ieee80211_tim_ie *tim;
-	const u8 *challenge;
 	const u8 *rsn;
 	const u8 *rsnx;
 	const u8 *erp_info;
@@ -1571,7 +1570,6 @@ struct ieee802_11_elems {
 	u8 ssid_len;
 	u8 supp_rates_len;
 	u8 tim_len;
-	u8 challenge_len;
 	u8 rsn_len;
 	u8 rsnx_len;
 	u8 ext_supp_rates_len;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 39b3ed89e0da..e18bd07f6822 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2870,17 +2870,17 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgd_auth_data *auth_data = sdata->u.mgd.auth_data;
+	const struct element *challenge;
 	u8 *pos;
-	struct ieee802_11_elems elems;
 	u32 tx_flags = 0;
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
 
 	pos = mgmt->u.auth.variable;
-	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, &elems,
-			       mgmt->bssid, auth_data->bss->bssid);
-	if (!elems.challenge)
+	challenge = cfg80211_find_elem(WLAN_EID_CHALLENGE, pos,
+				       len - (pos - (u8 *)mgmt));
+	if (!challenge)
 		return;
 	auth_data->expected_transaction = 4;
 	drv_mgd_prepare_tx(sdata->local, sdata, &info);
@@ -2888,7 +2888,8 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 		tx_flags = IEEE80211_TX_CTL_REQ_TX_STATUS |
 			   IEEE80211_TX_INTFL_MLME_CONN_TX;
 	ieee80211_send_auth(sdata, 3, auth_data->algorithm, 0,
-			    elems.challenge - 2, elems.challenge_len + 2,
+			    (void *)challenge,
+			    challenge->datalen + sizeof(*challenge),
 			    auth_data->bss->bssid, auth_data->bss->bssid,
 			    auth_data->key, auth_data->key_len,
 			    auth_data->key_idx, tx_flags);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 43ccad8b24c7..dce841228297 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1112,10 +1112,6 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			} else
 				elem_parse_failed = true;
 			break;
-		case WLAN_EID_CHALLENGE:
-			elems->challenge = pos;
-			elems->challenge_len = elen;
-			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
-- 
2.31.1

