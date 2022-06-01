Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C288539E84
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350272AbiFAHkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbiFAHkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D7980B0
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xhdesWb3xU1jVHvzhdmWuWQI2b5u4IA6OwxzPdrqLcA=;
        t=1654069205; x=1655278805; b=uzSUKePthxz7s5DYkrBZ+B/CyiMfmz8z2PgYhMjSyTpa38L
        04jsKXndWMFnx+CVgrmTUDChlq2K9OG7GqnPq2sDRHOK8QWP94UJi9VwQcreI5R5gecVPIw0XMulq
        A4+C2DyROzl1fbUlTsylA20ESDxG+20H0JRye+CsWK+lU/+eVH6Ixq2M6SQDoCoD0xtaZQSNQmnM1
        Eq3SCfheOAqWu1Gn9HuU/Onvs9cH88K7XWCvXFYxOpOUNkBLOkTMEq1i2naoyjLOww76/Fsi7PMUw
        TQ5CEaqH/0dtHKzXGeOVAD8BddSGY0wE8UAC5qqehhi2CnEWm34zQEnvrHucnUDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxX-00AJPK-6r;
        Wed, 01 Jun 2022 09:40:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/15] mac80211: use IEEE80211_MLD_MAX_NUM_LINKS
Date:   Wed,  1 Jun 2022 09:39:50 +0200
Message-Id: <20220601093922.583c5774aaae.I8ee15fc715cd84eb4dd0d11f9d86949adb09ec5f@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

Remove MAX_STA_LINKS and use IEEE80211_MLD_MAX_NUM_LINKS
instead to unify between the station and other data structures.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h  | 4 +---
 net/mac80211/sta_info.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4b3d19d88954..66a18dc4462f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2061,8 +2061,6 @@ struct ieee80211_sta_txpwr {
 	enum nl80211_tx_power_setting type;
 };
 
-#define MAX_STA_LINKS			15
-
 /**
  * struct ieee80211_link_sta - station Link specific info
  * All link specific info for a STA link for a non MLD STA(single)
@@ -2190,7 +2188,7 @@ struct ieee80211_sta {
 
 	bool multi_link_sta;
 	struct ieee80211_link_sta deflink;
-	struct ieee80211_link_sta *link[MAX_STA_LINKS];
+	struct ieee80211_link_sta *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 134a7dad0ac4..2ff3d5fd0cbf 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -710,7 +710,7 @@ struct sta_info {
 
 	bool multi_link_sta;
 	struct link_sta_info deflink;
-	struct link_sta_info *link[MAX_STA_LINKS];
+	struct link_sta_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	/* keep last! */
 	struct ieee80211_sta sta;
-- 
2.36.1

