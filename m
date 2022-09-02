Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5855AB428
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiIBOvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E194EC4
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1XpeNIpO67G4HVOOsGN4VEe00Tjm+Hiet9gBy8s6ZJo=;
        t=1662127990; x=1663337590; b=rBf95t+V5raKIeSF9WPwlAL+0MOZlO8Kd2RwCGzlHQlMbZj
        +dIVVNOPinpjKDe3ScIjfOAwV23bhLgBonI84gjpXhXp2WDRU9AgS4JJvIQ/YdK87xIGTJ9E1jIHL
        GIzfD3z0k/z0jufIwbYXHWIqkZ0yr2ADIQFAwPShx4Q+OaxdFP8wbHpD3eWitTJnWYsgnMOwgIxuR
        +GhFNYWNlOV/wB+8IHTc9U/JXQtpULQGTvHRIy2FSkT2DxBsf8kMfcBeRc1FrHsaibu1lKe28lA5V
        PEDkGGOPrqtpPH2/Sl4A2tZp/wQYMS0XPzTiL9VjufgD7Qnr8G2EGEftceCgKPRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pw-006Ch3-0l;
        Fri, 02 Sep 2022 16:13:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/27] wifi: mac80211: add ieee80211_find_sta_by_link_addrs API
Date:   Fri,  2 Sep 2022 16:12:43 +0200
Message-Id: <20220902161143.c4defb74e10a.Id3b2c4f1ecad9e5b808c19b36658b7bdd46ced29@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a new API function ieee80211_find_sta_by_link_addrs()
that looks up the STA and link ID based on interface and
station link addresses.

We're going to use it for mac80211-hwsim to track on the
AP side which links are active.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h  | 16 ++++++++++++++++
 net/mac80211/sta_info.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 20a2f25a38fa..954cc029a9f9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5986,6 +5986,22 @@ struct ieee80211_sta *ieee80211_find_sta_by_ifaddr(struct ieee80211_hw *hw,
 					       const u8 *addr,
 					       const u8 *localaddr);
 
+/**
+ * ieee80211_find_sta_by_link_addrs - find STA by link addresses
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @addr: remote station's link address
+ * @localaddr: local link address, use %NULL for any (but avoid that)
+ * @link_id: pointer to obtain the link ID if the STA is found,
+ *	may be %NULL if the link ID is not needed
+ *
+ * Obtain the STA by link address, must use RCU protection.
+ */
+struct ieee80211_sta *
+ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
+				 const u8 *addr,
+				 const u8 *localaddr,
+				 unsigned int *link_id);
+
 /**
  * ieee80211_sta_block_awake - block station from waking up
  * @hw: the hardware
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 815ab0cee503..1749c21e735c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -274,6 +274,43 @@ link_sta_info_get_bss(struct ieee80211_sub_if_data *sdata, const u8 *addr)
 	return NULL;
 }
 
+struct ieee80211_sta *
+ieee80211_find_sta_by_link_addrs(struct ieee80211_hw *hw,
+				 const u8 *addr,
+				 const u8 *localaddr,
+				 unsigned int *link_id)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct link_sta_info *link_sta;
+	struct rhlist_head *tmp;
+
+	for_each_link_sta_info(local, addr, link_sta, tmp) {
+		struct sta_info *sta = link_sta->sta;
+		struct ieee80211_link_data *link;
+		u8 _link_id = link_sta->link_id;
+
+		if (!localaddr) {
+			if (link_id)
+				*link_id = _link_id;
+			return &sta->sta;
+		}
+
+		link = rcu_dereference(sta->sdata->link[_link_id]);
+		if (!link)
+			continue;
+
+		if (memcmp(link->conf->addr, localaddr, ETH_ALEN))
+			continue;
+
+		if (link_id)
+			*link_id = _link_id;
+		return &sta->sta;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ieee80211_find_sta_by_link_addrs);
+
 struct sta_info *sta_info_get_by_addrs(struct ieee80211_local *local,
 				       const u8 *sta_addr, const u8 *vif_addr)
 {
-- 
2.37.2

