Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02406A6A8C
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCAKK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCAKKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B7C2A6E2
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665413; x=1709201413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvBC3/Rm8mNRk9jWC2gAp/TMN8i7LBgRRjk3X2Tpf0E=;
  b=P7jf0m5G+JPRZ1DbjGNq8URV89sl6tP+8PjJlK5sb6cEIwrc6fVecU4R
   fhhyeoSjioiximbE8BGEWeoBujUIG8PV8TPcX731PckKt/nwyPDgw+Bx/
   8WQhJ0gzTnTlq+/80yIdhmQs8JoTPmUFZjLqPUZqv3ccCari7UdYJIX6m
   44TXStrtRnuhKS2T4qs2Soa9wIshq1V1U6KFr0/89Fgg55MddXPeyNPIF
   HzJMhZb1CFPDpgn5S9ryM4KVV7z+wsRGD4RbpOlyiA+P7bZ++Bw7l1pKD
   ZbwlJY5hyWq8GNLLnHv1HaOj3zzARWXWOH1zB4H6F066JL9k2uJ/L8n2J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662795"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662795"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589027"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589027"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:03 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 04/23] wifi: mac80211: check key taint for beacon protection
Date:   Wed,  1 Mar 2023 12:09:16 +0200
Message-Id: <20230301115906.cf2c3fee6f1f.I2f19b3e04e31c99bed3c9dc71935bf513b2cd177@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

