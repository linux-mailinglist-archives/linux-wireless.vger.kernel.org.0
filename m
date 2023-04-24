Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC46EC732
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 09:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDXHdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjDXHdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 03:33:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D29E6C
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682321604; x=1713857604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eUSQAa9Njfa1cb+oZo0gO6rc+BBWy9j3tC9W/CNRj+I=;
  b=SRn/h/m4cjBrU+yFx/1O+5Uw8OFHrg91k9DG1eT+N7rpEB3fuYnJ8rfW
   fVfFvLyy7DD35r4Cb93sMv6M8/8RTPfpghaYJim72t7jFe9Sb6qUdJ8Bc
   VlhtVH6ODpNCypivO7wB9+G0o88BB7QZx1LekIWUByfP2DHsB63+I9pdk
   TaqvPnfyDa6UEv8/IlY5kwtlkv8kKUDF5T05oI5osaqRb3d6itbm2Qhms
   TmczodAperaJtMimos5zm1OvKV/QoeoUv28BYNNvEpz78wj6BsN7+joUk
   cJzHf/jRyWY+6IGMRVIghZ19yObffojFt/hoUMNwl8UAxGvhWbiLqTJVe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="326703988"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="326703988"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 00:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="643263145"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="643263145"
Received: from ynever-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 00:33:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] wifi: cfg80211: Drop entries with invalid BSSIDs in RNR
Date:   Mon, 24 Apr 2023 10:32:24 +0300
Message-Id: <20230424103224.5e65d04d1448.Ic10c8577ae4a85272c407106c9d0a2ecb5372743@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Ignore AP information for entries that include an invalid
BSSID in the TBTT information field, e.g., all zeros BSSIDs.

Fixes: c8cb5b854b40 ("nl80211/cfg80211: support 6 GHz scanning")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a1382255fab3..c501db7bbdb3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -540,6 +540,10 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 	/* skip the TBTT offset */
 	pos++;
 
+	/* ignore entries with invalid BSSID */
+	if (!is_valid_ether_addr(pos))
+		return -EINVAL;
+
 	memcpy(entry->bssid, pos, ETH_ALEN);
 	pos += ETH_ALEN;
 
-- 
2.38.1

