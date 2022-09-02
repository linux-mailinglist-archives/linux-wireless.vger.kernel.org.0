Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF35AB422
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiIBOvY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E56D575
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BLgJlpT2m8WOjBT3GmDzobre3LBXo995uWDdryiR5DQ=;
        t=1662127986; x=1663337586; b=UhL+tpsmQijj7PXhQjRQZEnZnjJOlW4rknfX5XSAxov9Dy/
        ZHt1+xyEGI2j2lGrgPQbuAEMPv5TaWlqAjq4RbN+GbzO8UXPb/tbnFcPp+tpO38foUCEwvaSqpE7t
        Gwwnwo+5PVw04NicqEvhms2wRoulSvQICAuLq5sYaL0loZSCgJeeEQcUe/CIFUX0+UOizMYtsQwp3
        0iZhte4D2putYx76u7oGuS3YjwrWqovmTDrh70qHStC9g3ZzSrTNHxKtMmfqkmkvhuVA1ubcda//6
        rCccLUVorKInJnMaJA9EGgnaK+gZkinXVPXGXmcWmNDGO1TqedPewB1lfgIOQNtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pr-006Ch3-0f;
        Fri, 02 Sep 2022 16:13:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/27] wifi: mac80211: remove unused arg to ieee80211_chandef_eht_oper
Date:   Fri,  2 Sep 2022 16:12:34 +0200
Message-Id: <20220902161143.fa3aaf0f22db.I696d3190ec9f55028f9728c5589f76608860a0cf@changeid>
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

We don't need the sdata argument, and it doesn't make any
sense for a direct conversion from one value to another,
so just remove the argument

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 3 +--
 net/mac80211/mlme.c        | 2 +-
 net/mac80211/util.c        | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f358977a6b9..e902feecfad4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2412,8 +2412,7 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
-void ieee80211_chandef_eht_oper(struct ieee80211_sub_if_data *sdata,
-				const struct ieee80211_eht_operation *eht_oper,
+void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation *eht_oper,
 				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 13d075e6a318..ef192974949c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -314,7 +314,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	if (eht_oper && (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
 		struct cfg80211_chan_def eht_chandef = *chandef;
 
-		ieee80211_chandef_eht_oper(sdata, eht_oper,
+		ieee80211_chandef_eht_oper(eht_oper,
 					   eht_chandef.width ==
 					   NL80211_CHAN_WIDTH_160,
 					   false, &eht_chandef);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a292e63377c3..8b4c6b7abafa 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3512,8 +3512,7 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 	return true;
 }
 
-void ieee80211_chandef_eht_oper(struct ieee80211_sub_if_data *sdata,
-				const struct ieee80211_eht_operation *eht_oper,
+void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation *eht_oper,
 				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef)
 {
@@ -3689,7 +3688,7 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		support_320 =
 			eht_phy_cap & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
-		ieee80211_chandef_eht_oper(sdata, eht_oper, support_160,
+		ieee80211_chandef_eht_oper(eht_oper, support_160,
 					   support_320, &he_chandef);
 	}
 
-- 
2.37.2

