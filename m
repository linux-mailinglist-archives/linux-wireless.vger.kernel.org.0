Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCE6A05BD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjBWKMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBWKMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1514FC84
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147126; x=1708683126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvBC3/Rm8mNRk9jWC2gAp/TMN8i7LBgRRjk3X2Tpf0E=;
  b=mGd3TeNI8Y6suNImS8dmzLtYbQ7KG0ra4AGFyE43sJsSXvlLeU16dZen
   jt4lRg0sE2wDpp7s5Zb+ialrLRFM/o8DbvNbOfXzOng7Z30GJom2MZVnQ
   +IK90FZxrL35TmMp3o1shAreqSG5mRmYM0lfGKxFE3djQUkZK+eZ6ihAz
   J0yT9Hdrjl7aDxOsBZAKmBwAFMHfnC3wESqDB4B3k+NxuYEQqEbNx8Ile
   9HzkXGQdr232ipRoYX2whhsYpelH0tLe2GipNLjnWY/kuwZvZlCzVjm+Q
   KvJqX3WH1xRZAsP+27VW60hyxTW5u+NllN2GyNZfMEDm7MEwl31hSVvrE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396278"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245169"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245169"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:29 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/21] wifi: mac80211: check key taint for beacon protection
Date:   Thu, 23 Feb 2023 12:09:25 +0200
Message-Id: <20230223114629.a08041eab67c.I2f19b3e04e31c99bed3c9dc71935bf513b2cd177@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
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

This will likely never happen, but for completeness check
the key taint flag before using a key for beacon protection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7699fb410670..1f9294f5baa4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5115,6 +5115,12 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	tx.key = rcu_dereference(link->default_beacon_key);
 	if (!tx.key)
 		return 0;
+
+	if (unlikely(tx.key->flags & KEY_FLAG_TAINTED)) {
+		tx.key = NULL;
+		return -EINVAL;
+	}
+
 	tx.local = local;
 	tx.sdata = sdata;
 	__skb_queue_head_init(&tx.skbs);
-- 
2.38.1

