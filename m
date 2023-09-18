Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B007A481C
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjIRLMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbjIRLLp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:11:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B488F
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035500; x=1726571500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Niz5N6MtjyXH0uHwcBazXnt/tgjtNQgxDsdXcy3MsTg=;
  b=TvO1CD2j3tjOJoV3ID4PD69Ei8nDhukeiGyRLiyvM6rf72IMDhBBBAl9
   ZZ9OSkO/kFUXHNYu38QbrSl1LPLJIu0cF7gzJ7A24WlsdYodpyc77m5t4
   WKEYZV/+lX9K+hKtQlPcbrOKHy+McydHT2Dshw8LvRNviQ9GI1Pzvqr8R
   tQQ3UL9w9M14WED6qg/OVvj41T6SgQvuxbQn9PwcS9WIKG176yo9h219O
   uzD7cKabneCL93Z3QvZkljlqVOgW5FemBjTWAwvHkrCGCdhiJHPMAr/dZ
   enAEfCC2wd9CJl6tC8ettoZUd9mNu4roXyiCPNWy1D/I2kfI2Do10mOdv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535745"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025269"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025269"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:11:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/18] wifi: mac80211: relax RCU check in for_each_vif_active_link()
Date:   Mon, 18 Sep 2023 14:10:49 +0300
Message-Id: <20230918140607.a70cf3802904.I01f456be8ce2a4fbd15e0d44302e2f7d72e91987@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

To iterate the vif links we don't necessarily need to be in an
RCU critical section, it's also possible to hold the sdata/wdev
mutex. Annotate for_each_vif_active_link() accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8d993f6ab919..7aea4787e62b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1942,7 +1942,7 @@ static inline bool ieee80211_vif_is_mld(const struct ieee80211_vif *vif)
 	for (link_id = 0; link_id < ARRAY_SIZE((vif)->link_conf); link_id++)	\
 		if ((!(vif)->active_links ||					\
 		     (vif)->active_links & BIT(link_id)) &&			\
-		    (link = rcu_dereference((vif)->link_conf[link_id])))
+		    (link = link_conf_dereference_check(vif, link_id)))
 
 static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
 {
-- 
2.38.1

