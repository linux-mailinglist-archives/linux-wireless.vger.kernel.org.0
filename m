Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26041D874
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbhI3LN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350363AbhI3LNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076BC06176A
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H0n6QHKdUTF0V4atc/hzEHKbZ/FgDfgWVCU6LPDHA8k=;
        t=1633000296; x=1634209896; b=xaX8OCm9zOYIeFZkQ3z85KL3oMK7B/1f0mdqBgsSoOXRX4U
        BIRyNeXbTX9Q3a71BEvBt5K+f9KRRqA3TZ6GTu8IgU/yMr91j5fVki4VFpRxh6zr7L6YMqvZ5Z3Ee
        o/VI7TG3ngA4N9HuvuM25TopG5GhCpbR5CyKnWBDmIXoHLrCmRsdCLd5pxYTaHtoBA3/j+VbflBdN
        u2nPZHlmTRNAAu64NohGXaQqHRTeSa0nTtbYvzrBxN/MISOS98LBsj0jN7HHLms1K+h3BxP7kcWn5
        XnHowimATWGy2fjUveR69D28oUAejJuFL5ctBE46lt+rpNQV7gL+CTCIGNylgViw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyQ-00Dlti-NM;
        Thu, 30 Sep 2021 13:11:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/5] mac80211: use ieee80211_bss_get_elem() in most places
Date:   Thu, 30 Sep 2021 13:11:31 +0200
Message-Id: <20210930131130.9a413f12a151.I0699ba7e48c9d88dbbfa3107cf4d34a8345d02a0@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
References: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are a number of uses of ieee80211_bss_get_ie(),
replace most of them with ieee80211_bss_get_elem().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0ec183a92a01..e96811776f7e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2514,7 +2514,7 @@ static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	const u8 *ssid;
+	const struct element *ssid;
 	u8 *dst = ifmgd->associated->bssid;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
@@ -2551,14 +2551,14 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		int ssid_len;
 
 		rcu_read_lock();
-		ssid = ieee80211_bss_get_ie(ifmgd->associated, WLAN_EID_SSID);
+		ssid = ieee80211_bss_get_elem(ifmgd->associated, WLAN_EID_SSID);
 		if (WARN_ON_ONCE(ssid == NULL))
 			ssid_len = 0;
 		else
-			ssid_len = ssid[1];
+			ssid_len = ssid->datalen;
 
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
-					      ssid + 2, ssid_len,
+					      ssid->data, ssid_len,
 					      ifmgd->associated->channel);
 		rcu_read_unlock();
 	}
@@ -2634,7 +2634,7 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct cfg80211_bss *cbss;
 	struct sk_buff *skb;
-	const u8 *ssid;
+	const struct element *ssid;
 	int ssid_len;
 
 	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
@@ -2652,16 +2652,17 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 		return NULL;
 
 	rcu_read_lock();
-	ssid = ieee80211_bss_get_ie(cbss, WLAN_EID_SSID);
-	if (WARN_ONCE(!ssid || ssid[1] > IEEE80211_MAX_SSID_LEN,
-		      "invalid SSID element (len=%d)", ssid ? ssid[1] : -1))
+	ssid = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
+	if (WARN_ONCE(!ssid || ssid->datalen > IEEE80211_MAX_SSID_LEN,
+		      "invalid SSID element (len=%d)",
+		      ssid ? ssid->datalen : -1))
 		ssid_len = 0;
 	else
-		ssid_len = ssid[1];
+		ssid_len = ssid->datalen;
 
 	skb = ieee80211_build_probe_req(sdata, sdata->vif.addr, cbss->bssid,
 					(u32) -1, cbss->channel,
-					ssid + 2, ssid_len,
+					ssid->data, ssid_len,
 					NULL, 0, IEEE80211_PROBE_FLAG_DIRECTED);
 	rcu_read_unlock();
 
@@ -5538,7 +5539,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	const struct cfg80211_bss_ies *beacon_ies;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
-	const u8 *ssidie, *ht_ie, *vht_ie;
+	const struct element *ssid_elem, *ht_elem, *vht_elem;
 	int i, err;
 	bool override = false;
 
@@ -5547,14 +5548,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	rcu_read_lock();
-	ssidie = ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
-	if (!ssidie || ssidie[1] > sizeof(assoc_data->ssid)) {
+	ssid_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_SSID);
+	if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
 		rcu_read_unlock();
 		kfree(assoc_data);
 		return -EINVAL;
 	}
-	memcpy(assoc_data->ssid, ssidie + 2, ssidie[1]);
-	assoc_data->ssid_len = ssidie[1];
+	memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
+	assoc_data->ssid_len = ssid_elem->datalen;
 	memcpy(bss_conf->ssid, assoc_data->ssid, assoc_data->ssid_len);
 	bss_conf->ssid_len = assoc_data->ssid_len;
 	rcu_read_unlock();
@@ -5668,15 +5669,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	assoc_data->supp_rates_len = bss->supp_rates_len;
 
 	rcu_read_lock();
-	ht_ie = ieee80211_bss_get_ie(req->bss, WLAN_EID_HT_OPERATION);
-	if (ht_ie && ht_ie[1] >= sizeof(struct ieee80211_ht_operation))
+	ht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_HT_OPERATION);
+	if (ht_elem && ht_elem->datalen >= sizeof(struct ieee80211_ht_operation))
 		assoc_data->ap_ht_param =
-			((struct ieee80211_ht_operation *)(ht_ie + 2))->ht_param;
+			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
 	else if (!is_6ghz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-	vht_ie = ieee80211_bss_get_ie(req->bss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_ie && vht_ie[1] >= sizeof(struct ieee80211_vht_cap))
-		memcpy(&assoc_data->ap_vht_cap, vht_ie + 2,
+	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
+	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap))
+		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
 		       sizeof(struct ieee80211_vht_cap));
 	else if (is_5ghz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
-- 
2.31.1

