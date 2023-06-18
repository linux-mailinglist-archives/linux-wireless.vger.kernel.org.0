Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36B97347BD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjFRSu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFRSuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A39E49
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114220; x=1718650220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yeRHfD7QTKsnlqvpAmbv04xuz3H8LYHVHxmzj5GAKSc=;
  b=eIIA0Mg2kfB12HPt9gOtTaAYDbrsEE23cch/dUiyWM+yy+K9H0MvluxK
   05AV1XiyJ5Ctji8GIPEhnbhLyqEGdOU0Wp7PFxS+0mQhg4ftSuSBIaTGe
   x9sKaFJWktoUpoaIk8C3dyn/uCcKMMfRWycKaugzxyAPA1VJGx9cTc60i
   ZdluZ4xMYWU3BeCscobbUzp90yE5b3wW1hfwRdru0SfWd3tCML8EiMhvJ
   cq7EdXSr3O450JIWyYvCe+34+oP0LjbuSFfFfxO+j+OBBp2O/ObYulTpg
   +v9kdgFkB/BVR31afpuVAbG9ie4dHLQstiB3HPTio/uTroSZ9TT7gugjK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116628"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:20 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233848"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233848"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/20] wifi: mac80211: Include Multi-Link in CRC calculation
Date:   Sun, 18 Jun 2023 21:49:44 +0300
Message-Id: <20230618214435.ae8246b93d85.Ia64b45198de90ff7f70abcc997841157f148ea40@changeid>
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

Include the Multi-Link elements found in beacon frames
in the CRC calculation, as these elements are intended
to reflect changes in the AP MLD state.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2c53f6e17cfe..35701316dccf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -987,6 +987,10 @@ ieee80211_parse_extension_element(u32 *crc,
 			const struct ieee80211_multi_link_elem *mle =
 				(void *)data;
 
+			if (crc)
+				*crc = crc32_be(*crc, (void *)elem,
+						elem->datalen + 2);
+
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-- 
2.38.1

