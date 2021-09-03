Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753AF3FFF65
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhICLuC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45250 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349000AbhICLtz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669736; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Y+9ApvPbOLaFubh5UEepLh95vf9Gj/yPu0Pm5Sgp12Q=; b=notSZQP76xE02C91u8Kt/6z4q2XS/VEC+0XFi+yXUjywYQaqJhtIOMdkhP4eTH3ncWz92GxZ
 CnM89aTugV7e4mSuF+hdKoNieWFgyWb31UkfpRatQdyKlj6Jr1eEudC3Vpgq62fNVgZ05VD4
 whSzNQ7Zh6KZJQNh/9xRq95H32s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61320b98d15f4d68a276c3a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:40
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF455C4338F; Fri,  3 Sep 2021 11:48:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C289C43617;
        Fri,  3 Sep 2021 11:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3C289C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 8/9] mac80211: use ieee802_11_parse_elems() to find ies instead of ieee80211_bss_get_ie()
Date:   Fri,  3 Sep 2021 07:48:20 -0400
Message-Id: <20210903114821.23346-9-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In function ieee80211_prep_channel(), it has some ieee80211_bss_get_ie()
and cfg80211_find_ext_ie() to get the IE, this is to use another
function ieee802_11_parse_elems() to get all the IEs in one time.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/mlme.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2480bd0577bb..6b32cdd590cd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5001,10 +5001,22 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
+	struct ieee802_11_elems *elems;
+	const struct cfg80211_bss_ies *ies;
 	int ret;
 	u32 i;
 	bool have_80mhz;
 
+	elems = kzalloc(sizeof(*elems), GFP_KERNEL);
+	if (!elems)
+		return -ENOMEM;
+
+	rcu_read_lock();
+
+	ies = rcu_dereference(cbss->ies);
+	ieee802_11_parse_elems(ies->data, ies->len, false, elems,
+			       NULL, NULL);
+
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 
 	ifmgd->flags &= ~(IEEE80211_STA_DISABLE_40MHZ |
@@ -5026,16 +5038,14 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!ieee80211_get_he_sta_cap(sband))
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 
-	rcu_read_lock();
-
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
 		const u8 *ht_oper_ie, *ht_cap_ie;
 
-		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
+		ht_oper_ie = ((const u8 *)elems->ht_operation) - 2;
 		if (ht_oper_ie && ht_oper_ie[1] >= sizeof(*ht_oper))
 			ht_oper = (void *)(ht_oper_ie + 2);
 
-		ht_cap_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_CAPABILITY);
+		ht_cap_ie = ((const u8 *)elems->ht_cap_elem) - 2;
 		if (ht_cap_ie && ht_cap_ie[1] >= sizeof(*ht_cap))
 			ht_cap = (void *)(ht_cap_ie + 2);
 
@@ -5048,8 +5058,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) && !is_6ghz) {
 		const u8 *vht_oper_ie, *vht_cap;
 
-		vht_oper_ie = ieee80211_bss_get_ie(cbss,
-						   WLAN_EID_VHT_OPERATION);
+		vht_oper_ie = ((const u8 *)elems->vht_operation) - 2;
 		if (vht_oper_ie && vht_oper_ie[1] >= sizeof(*vht_oper))
 			vht_oper = (void *)(vht_oper_ie + 2);
 		if (vht_oper && !ht_oper) {
@@ -5061,7 +5070,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 		}
 
-		vht_cap = ieee80211_bss_get_ie(cbss, WLAN_EID_VHT_CAPABILITY);
+		vht_cap = ((const u8 *)elems->vht_cap_elem) - 2;
 		if (!vht_cap || vht_cap[1] < sizeof(struct ieee80211_vht_cap)) {
 			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 			vht_oper = NULL;
@@ -5069,12 +5078,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
-		const struct cfg80211_bss_ies *ies;
 		const u8 *he_oper_ie;
 
-		ies = rcu_dereference(cbss->ies);
-		he_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION,
-						  ies->data, ies->len);
+		he_oper_ie = ((const u8 *)elems->he_operation) - 3;
 		if (he_oper_ie &&
 		    he_oper_ie[1] >= ieee80211_he_oper_size(&he_oper_ie[3]))
 			he_oper = (void *)(he_oper_ie + 3);
@@ -5102,8 +5108,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		const u8 *s1g_oper_ie;
 
-		s1g_oper_ie = ieee80211_bss_get_ie(cbss,
-						   WLAN_EID_S1G_OPERATION);
+		s1g_oper_ie = ((const u8 *)elems->s1g_oper) - 2;
 		if (s1g_oper_ie && s1g_oper_ie[1] >= sizeof(*s1g_oper))
 			s1g_oper = (void *)(s1g_oper_ie + 2);
 		else
@@ -5125,7 +5130,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE && is_6ghz) {
 		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_no_lock;
 	}
 
 	/* will change later if needed */
@@ -5143,15 +5149,17 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	/* don't downgrade for 5 and 10 MHz channels, though. */
 	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
 	    chandef.width == NL80211_CHAN_WIDTH_10)
-		goto out;
+		goto out_lock;
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
 		ifmgd->flags |= ieee80211_chandef_downgrade(&chandef);
 		ret = ieee80211_vif_use_channel(sdata, &chandef,
 						IEEE80211_CHANCTX_SHARED);
 	}
- out:
+ out_lock:
 	mutex_unlock(&local->mtx);
+ out_no_lock:
+	kfree(elems);
 	return ret;
 }
 
-- 
2.31.1

