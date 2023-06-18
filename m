Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F17347BE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjFRSu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFRSu0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8521AA
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114223; x=1718650223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ql71OeA89ZxajN4zCl2gjFygo4KKXIYWMcjSxGpKBR4=;
  b=AYm33XBMCJ5fhT8WxYmROLYJhYOhBquIrEiyfhSwB6XZ6m2uOL5b1tFp
   tDqbDffIWPfxr4FNUZH5ooZtVBe/hpnlODGKImR2DRg0Ulugm4vBQzEpR
   //ULu3PwVJh0KTevxQBeVqzKRk2dkYELl/zgHxVP+5XuUXCBTESX/Ooh0
   31Kris6GKIVPuRt1RMVhwSSsOLka7kY/SSsfXTsjw4RKjWYvi3yOD9N19
   nhSSIMd9UtgPCV8i1y1OtFyNMpjDZmbgVJm14+c5mXuJQZrF6HZYDNc7d
   bza+WngbTS/qQ04o5KS+Oh6OrtT8A/PaP+ak/u2WtamkQDxXAeTu0bwlO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116632"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:23 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233866"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233866"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/20] wifi: ieee80211: Fix the common size calculation for reconfiguration ML
Date:   Sun, 18 Jun 2023 21:49:45 +0300
Message-Id: <20230618214435.3c7ed4817338.I42ef706cb827b4dade6e4ffbb6e7f341eaccd398@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The common information length is found in the first octet of the common
information.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index aeedd49e5101..97edc3b404dd 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4617,15 +4617,12 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 	case IEEE80211_ML_CONTROL_TYPE_PREQ:
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
+	case IEEE80211_ML_CONTROL_TYPE_RECONF:
 		/*
 		 * The length is the first octet pointed by mle->variable so no
 		 * need to add anything
 		 */
 		break;
-	case IEEE80211_ML_CONTROL_TYPE_RECONF:
-		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
-			common += ETH_ALEN;
-		return common;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		if (control & IEEE80211_MLC_PRIO_ACCESS_PRES_AP_MLD_MAC_ADDR)
 			common += ETH_ALEN;
-- 
2.38.1

