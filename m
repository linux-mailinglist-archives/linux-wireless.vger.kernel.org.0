Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0847A8BAA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjITS0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjITS0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A4E4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234383; x=1726770383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Niz5N6MtjyXH0uHwcBazXnt/tgjtNQgxDsdXcy3MsTg=;
  b=dbz6oSkwLDKRuS/VbnlJZsQ5nn+efCtC7zNKNCdkXpswXMLDSO0cFZlo
   +m1dhS06hu2mod+zbK+/fqmqSECug5UtlsR55Yd9RtEVWBg4ZKUx1mX3l
   jth3SP2pElLXoJhYvEfgsdDGLr+QW2F7ZAfiN1AxvYmup7BbRUd446VbB
   DcDf0H8ZDX8iGA8cwoUP7c3ON4fEwfmsWzW7UkQsLsqiGri/KtVcdQfBK
   5dTpeFrxspLkjznQgJxU4MkZuEa7g7/5Uvu0U/VHls0S/N5e3fg6bhkoY
   2+lWrApBVwlHVcWjoSC0UIgjXGOIgxF9l6EvzbO1NlEj8/U+l06d9/FR9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556318"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556318"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424217"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424217"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 04/18] wifi: mac80211: relax RCU check in for_each_vif_active_link()
Date:   Wed, 20 Sep 2023 21:25:15 +0300
Message-Id: <20230920211508.858921bd2860.I01f456be8ce2a4fbd15e0d44302e2f7d72e91987@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

