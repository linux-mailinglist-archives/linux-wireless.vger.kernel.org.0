Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB79972F9A7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbjFNJpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbjFNJoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653D2962
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735787; x=1718271787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/OFzp6H6DaurPne6LXrcFZrgYlAF+loDzSXiCigTew=;
  b=TNpiiekvj0M7rO4EnU6km7+zdIbVDzh+jcNSux7uX0KIDTDDj+RvvKZ2
   sQ8KRzy/kanY6o/AAXmNsDuxjvYv8GmQV1m68gHV0G8YhP0unHkQ9t1M9
   l8aeWKbur4MOOiZrBOSG6R+akbd3Hi8lb9ZcIpaEZ0z9lMvxWJzEuLuYJ
   xCYul/Ik2AD2+d0TYjrfNE34qN2wbaOPYO3vOwuI6G1PlbPuyKDsDhYG3
   p/e9SRgGQtSaSm/2xOajSmdKkuPITx/ZqrtRfJxrgguZdPFbht7vxnGDj
   t+JhjXUinKrAnyYs4Yoojt+9IZPq86GKFDzUGGrXwd8pZFeU5QSaIfqVd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049805"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989779"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989779"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:41:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/20] wifi: iwlwifi: Correctly indicate support for VHT TX STBC
Date:   Wed, 14 Jun 2023 12:41:19 +0300
Message-Id: <20230614123446.b24b5fba6fab.I116617875eb4a9d520df23a8c49a6594f9d8b2c6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

If HT STBC is not supported, do not indicate support for VHT TX
STBC.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index fad71f490313..d79d5453c2dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -516,7 +516,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		num_tx_ants = 1;
 	}
 
-	if (num_tx_ants > 1)
+	if (trans->cfg->ht_params->stbc && num_tx_ants > 1)
 		vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
 	else
 		vht_cap->cap |= IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
-- 
2.38.1

