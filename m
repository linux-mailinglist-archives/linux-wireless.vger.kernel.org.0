Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCE72B112
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjFKJO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjFKJOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 05:14:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905F173B
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686474886; x=1718010886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCrltpD/DlpZPpsEoKm+r8MLURR8tz5E3GndKl1iBzU=;
  b=X0rLcsN33LmFkLzwy3L3y9faWj1c/jKh3HoJnK5QmyYhiEHskSjFhQQO
   qCSWYHU7f9ypnE2vLuZ3lOq0/ujzRWjb2UglCVIGvSCb7LbPe0ETdVWuW
   D45AZDLWfeioXxbtwUz19BqoCP8FDoidg3jXuOLuxmKYb/QT03pkGsStf
   jUm2i+A8B6yzIro3M9cINXtgRhMuLOmQkBJm7xzhF1ZoUnaZLED/HE0sU
   qfWnZa/cwYIMJ3oJgVL/6HFoDGZUlXP07ij2cvKSCXkk9jlUS0XBKH/+0
   nUDYvysMV2FGXPENt15NOFwZl32sxdNYGwkGGFg9A3uwEKtXSrx5Fbx4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347488938"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="347488938"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688249741"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="688249741"
Received: from rganonx-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.222.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/4] wifi: mac80211: Do not use "non-MLD AP" syntax
Date:   Sun, 11 Jun 2023 12:14:27 +0300
Message-Id: <20230611121219.77236a2e26ad.I8193ca8e236c9eb015870471f77a7d5134da3156@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611091429.24517-1-gregory.greenman@intel.com>
References: <20230611091429.24517-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Instead clarify the cases where link ID == 0 is intended
for an AP STA that is not part of an AP MLD.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b5704ef4308f..914448cb0ecf 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5282,7 +5282,8 @@ struct ieee80211_mutable_offsets {
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @offs: &struct ieee80211_mutable_offsets pointer to struct that will
  *	receive the offsets that may be updated by the driver.
- * @link_id: the link id to which the beacon belongs (or 0 for a non-MLD AP)
+ * @link_id: the link id to which the beacon belongs (or 0 for an AP STA
+ *	that is not associated with AP MLD).
  *
  * If the driver implements beaconing modes, it must use this function to
  * obtain the beacon template.
@@ -5379,7 +5380,8 @@ void ieee80211_beacon_free_ema_list(struct ieee80211_ema_beacons *ema_beacons);
  * @tim_length: pointer to variable that will receive the TIM IE length,
  *	(including the ID and length bytes!).
  *	Set to 0 if invalid (in non-AP modes).
- * @link_id: the link id to which the beacon belongs (or 0 for a non-MLD AP)
+ * @link_id: the link id to which the beacon belongs (or 0 for an AP STA
+ *	that is not associated with AP MLD).
  *
  * If the driver implements beaconing modes, it must use this function to
  * obtain the beacon frame.
@@ -5402,7 +5404,8 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
  * ieee80211_beacon_get - beacon generation function
  * @hw: pointer obtained from ieee80211_alloc_hw().
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @link_id: the link id to which the beacon belongs (or 0 for a non-MLD AP)
+ * @link_id: the link id to which the beacon belongs (or 0 for an AP STA
+ *	that is not associated with AP MLD).
  *
  * See ieee80211_beacon_get_tim().
  *
-- 
2.38.1

