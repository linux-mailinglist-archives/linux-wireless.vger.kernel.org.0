Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24404573352
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiGMJqM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiGMJp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53CF5D76
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cxMOwRLadusuyHu4WBOXyZ1r2bwq30eYm7gHkZYvEE4=;
        t=1657705522; x=1658915122; b=M1jwIFlPBiwOMjhbdcc3f8anMV96Xcfy/ZEWBgVN3OtWJ6b
        iBqtf7E/mvEYkojNgPKfkNZzpWMXAzuU4Lv7Dqm4yXudOVOdYxcBf2VYGj3a3FdRDvaaL6yloiEEp
        JXovteQxvUQgjBpI0dL3KiGRJTinIldoZy55Zm+BhVixop1/ClWNPj7V0DU5E+JtsYtZWWgtQzf82
        EhlBc4976t4s+7OEkQDAxgBUSx/tDHAcxVqBlid9v2V44iEz7L792oa1OIxQLGufUhzcMaGyqyMYI
        0AXjuKR8q6+95Sa+vCemDWj6SulHbW5CW8iv4Ss+2Bgqm4iDroCJZcV8vam9OBMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvo-00EgvB-To;
        Wed, 13 Jul 2022 11:45:21 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 47/76] wifi: mac80211: move tdls_chan_switch_prohibited to link data
Date:   Wed, 13 Jul 2022 11:44:33 +0200
Message-Id: <20220713114425.37d893a4f541.I01237781b0cd7bffe3d4090782290dcf5166e44f@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

This value should be per link, since a TDLS connection is
only established on a given link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 2 +-
 net/mac80211/ieee80211_i.h | 3 ++-
 net/mac80211/mlme.c        | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 873e1acc8c30..555c135e9fcd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1759,7 +1759,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 
 	/* mark TDLS channel switch support, if the AP allows it */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
-	    !sdata->u.mgd.tdls_chan_switch_prohibited &&
+	    !sdata->deflink.u.mgd.tdls_chan_switch_prohibited &&
 	    params->ext_capab_len >= 4 &&
 	    params->ext_capab[3] & WLAN_EXT_CAPA4_TDLS_CHAN_SWITCH)
 		set_sta_flag(sta, WLAN_STA_TDLS_CHAN_SWITCH);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2cf13ea4c9f7..a8211ced719e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -514,7 +514,6 @@ struct ieee80211_if_managed {
 	struct sk_buff *orig_teardown_skb; /* The original teardown skb */
 	struct sk_buff *teardown_skb; /* A copy to send through the AP */
 	spinlock_t teardown_lock; /* To lock changing teardown_skb */
-	bool tdls_chan_switch_prohibited;
 	bool tdls_wider_bw_prohibited;
 
 	/* WMM-AC TSPEC support */
@@ -880,6 +879,8 @@ struct ieee80211_link_data_managed {
 
 	s16 p2p_noa_index;
 
+	bool tdls_chan_switch_prohibited;
+
 	bool have_beacon;
 	bool tracking_signal_avg;
 	bool disable_wmm_tracking;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index aec77e81df99..404edb975a2f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3503,7 +3503,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->vif.cfg.aid = aid;
-	ifmgd->tdls_chan_switch_prohibited =
+	sdata->deflink.u.mgd.tdls_chan_switch_prohibited =
 		elems->ext_capab && elems->ext_capab_len >= 5 &&
 		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
 
-- 
2.36.1

