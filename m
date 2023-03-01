Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531026A6A87
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCAKKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCAKKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E13647D
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665414; x=1709201414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOzXP8LomyHd700l2Fo775pz3JgmHbSNQy1oTDWNjUM=;
  b=QYIX03tvSJ4HrWZygos6Hbd5BRC2zPd/gHGOdON1m5DuCprIeHri7jc2
   F9k7dPmaqVJms/ueGpSKxbXON26zr5wa1+vEMujrMTKEkFiIOjyQsM8ZG
   YNa/sQ67gU29JmctDY1TojAmCiJBm+pyK4QYuFIBLAk0OuReA4MR+fmzG
   o1kH4QRNclquZFwUg6n4XJnXCntvAzUs4ZvtOj7PV1husvvur+22aca6q
   ju+zx+ztihqNs+TkCtf4nd6p/mY6OwuUnRkXlhgMuQC9Lm7C3CXjtSzhz
   eRXAKk35MSIVlozbMzSenbBiyS2pLxw154mrVyD4BCN2n7u6GajMQXWRs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662805"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662805"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589032"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589032"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:05 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 05/23] wifi: mac80211: allow beacon protection HW offload
Date:   Wed,  1 Mar 2023 12:09:17 +0200
Message-Id: <20230301115906.b2becd9a22fb.I6c0b9c50c6a481128ba912a11cb7afc92c4b6da7@changeid>
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

In case of beacon protection, check if the key was offloaded
to the hardware and in that case set control.hw_key so that
the encryption function will see it and only do the needed
steps that aren't done in hardware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1f9294f5baa4..628d60f3db2a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5121,6 +5121,10 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
+	if (!(tx.key->conf.flags & IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
+	    tx.key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+		IEEE80211_SKB_CB(skb)->control.hw_key = &tx.key->conf;
+
 	tx.local = local;
 	tx.sdata = sdata;
 	__skb_queue_head_init(&tx.skbs);
-- 
2.38.1

