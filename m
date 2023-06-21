Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700E73831B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFULpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjFULpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:45:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8D10D5
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687347911; x=1718883911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=foOonq4Mj9Nx6Rl5TACRTaKBpxe1iLcuu2r1wpvcRzM=;
  b=E7hweK2HzH4QeJ9iQ+91t+HlDffLIJmiX1eSBuu9PIXBL9O74D24MRi7
   umkog/xOHuFH05LZWkKzROcySeqA9lX3wID6oHNE3DVV897b/kcKWCxH1
   DWB9rhJIpFUHGslwHKMHLQ8lJUKxqJD4yTnK3IGeJpYQD/izy7MW2Vz5w
   kmULgrAYClfLWMymVoU2DSW3eSLCP94XfUBH/nyvkdBrHYZ62FXIwo0LC
   /BgeY/vcz7AQrFS/0VLNugeGIZ84rOVtSERtqdhesU6S01xWvoMPM5V+j
   6er0U1lKDgBCcYMYQfwSn1PaSVPQ+qGBP69+5+/KVSjOW8pCeLZoQ60/r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363566088"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="363566088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691821144"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="691821144"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:44:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] wifi: mac80211: mark keys as uploaded when added by the driver
Date:   Wed, 21 Jun 2023 14:44:36 +0300
Message-Id: <20230621144414.bc78c7ff2a3d.I5e313d69e2b6a7a4766ef82d0faa122dd4c1c46d@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

When the driver has some form of GTK rekeying offload, e.g. during
WoWLAN, mac80211 can assume that keys that the driver adds for
that are already present in the hardware acceleration. Mark them
accordingly.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/key.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index e8f6c1e5eabf..0c2245eaa08e 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2020, 2022  Intel Corporation
+ * Copyright 2018-2020, 2022 -2023  Intel Corporation
  */
 
 #include <linux/if_ether.h>
@@ -510,8 +510,12 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				ret = ieee80211_key_enable_hw_accel(new);
 		}
 	} else {
-		if (!new->local->wowlan)
+		if (!new->local->wowlan) {
 			ret = ieee80211_key_enable_hw_accel(new);
+		} else {
+			assert_key_lock(new->local);
+			new->flags |= KEY_FLAG_UPLOADED_TO_HARDWARE;
+		}
 	}
 
 	if (ret)
-- 
2.38.1

