Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5A5F54EE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJENBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJENBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:01:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BD78592
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uppWoO0h4MdQEjM22vXzX8mYeeKMXuQ4/Jb1fhgoQtE=;
        t=1664974859; x=1666184459; b=MQSW42vkhRhApYltSkmJTVFnLpPS/AsdExM5tizzFX6g5vx
        Wxt7E0dmsqXlB+fRRNmHlw+DbxDU8vz0qLr/D1H24yF+oGuymrd967UqNhDx6T2Qg3GZ3/TkeyTp4
        nwgeDWiFFxUnCGGKWfaOclSmN3ujHyjt3o5lN6D9zzPx/cB7Aw3JHWQ289TtkqV+stjqPw2IfJQ5A
        08x+Eo/F+IzGMvgLTkqckW+63GjeU5U0Edaf7LKjCrrbKgZ+Km8sUk1q5Hj4BKUrECjYuWP+7z4E0
        TaJEIk6pqy3ludEVG7kZ0TwwfVvLq3UWtAZb/QEYbzw+pZ8pAixPzvYLnsEJn9AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41B-00G2RL-19;
        Wed, 05 Oct 2022 15:00:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/28] wifi: mac80211: remove support for AddBA with fragmentation
Date:   Wed,  5 Oct 2022 15:00:47 +0200
Message-Id: <20221005145226.633fb92be811.I00470eddf867445ccdcf919dadd6378ae7a0356d@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

HE added support for dynamic fragmentation inside aggregation
sessions, but no existing driver ever advertises it. Thus,
remove the code for now, it cannot work as-is in MLO. For it
to properly work in MLO, we'd need to validate that the frag
level is identical across all the link bands/iftypes, which
is a good amount of complex code that's just not worth it as
long as no driver has support for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index bd41022f4894..c6fa53230450 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -183,34 +183,15 @@ static void ieee80211_add_addbaext(struct ieee80211_sub_if_data *sdata,
 				   const struct ieee80211_addba_ext_ie *req,
 				   u16 buf_size)
 {
-	struct ieee80211_supported_band *sband;
 	struct ieee80211_addba_ext_ie *resp;
-	const struct ieee80211_sta_he_cap *he_cap;
-	u8 frag_level, cap_frag_level;
 	u8 *pos;
 
-	sband = ieee80211_get_sband(sdata);
-	if (!sband)
-		return;
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
-	if (!he_cap)
-		return;
-
 	pos = skb_put_zero(skb, 2 + sizeof(struct ieee80211_addba_ext_ie));
 	*pos++ = WLAN_EID_ADDBA_EXT;
 	*pos++ = sizeof(struct ieee80211_addba_ext_ie);
 	resp = (struct ieee80211_addba_ext_ie *)pos;
 	resp->data = req->data & IEEE80211_ADDBA_EXT_NO_FRAG;
 
-	frag_level = u32_get_bits(req->data,
-				  IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK);
-	cap_frag_level = u32_get_bits(he_cap->he_cap_elem.mac_cap_info[0],
-				      IEEE80211_HE_MAC_CAP0_DYNAMIC_FRAG_MASK);
-	if (frag_level > cap_frag_level)
-		frag_level = cap_frag_level;
-	resp->data |= u8_encode_bits(frag_level,
-				     IEEE80211_ADDBA_EXT_FRAG_LEVEL_MASK);
 	resp->data |= u8_encode_bits(buf_size >> IEEE80211_ADDBA_EXT_BUF_SIZE_SHIFT,
 				     IEEE80211_ADDBA_EXT_BUF_SIZE_MASK);
 }
-- 
2.37.3

