Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C21362DF0
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhDQGCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 02:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhDQGCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 02:02:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A1C061574;
        Fri, 16 Apr 2021 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cl7FQ6LumdWXdQOKz8VonjG+pk/Z99sirkEm+WrnRWI=; b=NPdh72gJZRSzBCyzyM1j2tptQ1
        3e8uFx6mSGUXf7fWh6ptsDvdK3lrtm2DTViZIS0CmHN1JQnjee1iPBFkAHUqKCVJ1njBw9Hi+NaKS
        HdG+bJQtGZ9FQ6Q5kOFrMS6tBDCbjoJa3zrLDFNTqDTT4jNH1J5MafjTiihUeMhh1qt6sMQDTbeQF
        D9YCy9dZU05eW55Lut/+TrFkV6ihMW4BkHPC8A7hHQwuDzfmbv2NpfnR4h6LpcUHoTAFcQHpKUGGV
        +42PaAZyVXxIqqhxch//QYEwZajGGiTyPwDa8Ar5+o8h8Zm19JGEM/EM5ahgIkxwHXd6UeBvvOwsq
        YWZVZYsw==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXe1b-004UFg-2a; Sat, 17 Apr 2021 06:01:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH -next] cfg80211: fix a few kernel-doc warnings
Date:   Fri, 16 Apr 2021 23:01:42 -0700
Message-Id: <20210417060142.1648-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix multiple kernel-doc warnings in cfg80211.h.

cfg80211.h:363: warning: missing initial short description on line:
 * struct ieee80211_sband_iftype_data
cfg80211.h:6643: warning: expecting prototype for wiphy_rfkill_set_hw_state(). P
rototype was for wiphy_rfkill_set_hw_state_reason() instead
cfg80211.h:6743: warning: missing initial short description on line:
 * cfg80211_vendor_cmd_get_sender

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org
---
 include/net/cfg80211.h |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- linux-next-20210416.orig/include/net/cfg80211.h
+++ linux-next-20210416/include/net/cfg80211.h
@@ -360,7 +360,7 @@ struct ieee80211_sta_he_cap {
 };
 
 /**
- * struct ieee80211_sband_iftype_data
+ * struct ieee80211_sband_iftype_data - sband data per interface type
  *
  * This structure encapsulates sband data that is relevant for the
  * interface types defined in @types_mask.  Each type in the
@@ -6633,15 +6633,14 @@ void cfg80211_notify_new_peer_candidate(
  * They can do this with a few helper functions documented here.
  */
 
+void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
+				      enum rfkill_hard_block_reasons reason);
+
 /**
  * wiphy_rfkill_set_hw_state - notify cfg80211 about hw block state
  * @wiphy: the wiphy
  * @blocked: block status
- * @reason: one of reasons in &enum rfkill_hard_block_reasons
  */
-void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
-				      enum rfkill_hard_block_reasons reason);
-
 static inline void wiphy_rfkill_set_hw_state(struct wiphy *wiphy, bool blocked)
 {
 	wiphy_rfkill_set_hw_state_reason(wiphy, blocked,
@@ -6740,7 +6739,7 @@ cfg80211_vendor_cmd_alloc_reply_skb(stru
 int cfg80211_vendor_cmd_reply(struct sk_buff *skb);
 
 /**
- * cfg80211_vendor_cmd_get_sender
+ * cfg80211_vendor_cmd_get_sender - get the current netlink port ID of a wiphy
  * @wiphy: the wiphy
  *
  * Return the current netlink port ID in a vendor command handler.
