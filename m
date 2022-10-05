Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD55F54E5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJENBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJENA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E609E2CDDE
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9VSh7S6ZvvOM6di/mKAqKw0yp+jDdDCZUlSwTNXpD30=;
        t=1664974857; x=1666184457; b=NdltjU8zOYRXcAHcdiIYqEOeqf3/OtyzZwPVlrVflItOvXS
        NVvGJMAlyPf0K4IrwPNDpYOtzArFbULy1e8jKJoODBIpabBU6ymkocw00aWwNQHi+AkgPQ7jEWAY6
        9feWCLFUcNmf9rHSdBLqqn+4QY1pffz0xSbFmtYqH/euZ2jP/mOK8ZZ0xbu7bRnbDBflbDQGSVJQz
        7vvlVGHQHXJdEnoTEkHWLhLtmzFTfZeQDxL+70sa8G4w+DQjFYJipP4E7zZXXSmCjb4gTnl68CAtM
        Sd6kdcmVJgwdXkVFbqk0/2+S61MgngiSiWqLXz05fs9Q3bZU/k9PRHHjl4kdUEgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og419-00G2RL-0H;
        Wed, 05 Oct 2022 15:00:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 18/28] wifi: mac80211: add RCU _check() link access variants
Date:   Wed,  5 Oct 2022 15:00:38 +0200
Message-Id: <20221005145226.be2d0a5f0c99.I6d4abf13505122fca79578bb9da9473214602f13@changeid>
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

We might sometimes need to use RCU and locking in the same code
path, so add the two variants link_conf_dereference_check() and
link_sta_dereference_check().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c413050ec8dd..cda4584dfd51 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1915,6 +1915,10 @@ static inline bool lockdep_vif_mutex_held(struct ieee80211_vif *vif)
 	rcu_dereference_protected((vif)->link_conf[link_id],	\
 				  lockdep_vif_mutex_held(vif))
 
+#define link_conf_dereference_check(vif, link_id)		\
+	rcu_dereference_check((vif)->link_conf[link_id],	\
+			      lockdep_vif_mutex_held(vif))
+
 /**
  * enum ieee80211_key_flags - key flags
  *
@@ -2311,6 +2315,10 @@ static inline bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
 	rcu_dereference_protected((sta)->link[link_id],		\
 				  lockdep_sta_mutex_held(sta))
 
+#define link_sta_dereference_check(sta, link_id)		\
+	rcu_dereference_check((sta)->link[link_id],		\
+			      lockdep_sta_mutex_held(sta))
+
 #define for_each_sta_active_link(vif, sta, link_sta, link_id)			\
 	for (link_id = 0; link_id < ARRAY_SIZE((sta)->link); link_id++)		\
 		if ((!(vif)->active_links ||					\
-- 
2.37.3

