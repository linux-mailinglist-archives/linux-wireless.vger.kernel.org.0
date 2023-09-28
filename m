Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333347B1FC1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjI1OgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjI1OgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CF1B5
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911778; x=1727447778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/Wm2fcf7fkqOtMbcDefTZF7auoktizwsoIsZ1gy1fc=;
  b=NTB6B1Lm1iYnlFvql+xSSrxbThRY8YH5yKC//3LLtOy/eFv9ut+bIh/F
   5wHcZKbP6x9yMpvTqpXj35h/Iucyfjx/B3sk3nkU5uodJS0dBczHLApKn
   zFiHrzCSE98KSboEKY6Y9EHuG+2yHlER6h+qskgLSXNWwsfFmwiWUaYu1
   tSiBXfzcfIlsrvoujDdhz5wJ87niL7qREvFgyxgEk40ZOg45oZ4VMUI79
   LlymqgX50F4hegqjy0NWAQGN+v5R0Ewkky0wmCrlVRwyez7zgmdmyEfBG
   onXp7GgGuE9t1P0TlV7LzTLpaYN1n2fPOzoXHho7XF2sStpmpo6zemYco
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688461"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688461"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590458"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590458"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/18] wifi: mac80211: Fix setting vif links
Date:   Thu, 28 Sep 2023 17:35:31 +0300
Message-Id: <20230928172905.0357b6306587.I7dbfec347949b629fea680d246a650d6207ff217@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
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

From: Ilan Peer <ilan.peer@intel.com>

When setting the interface links, ignore the change iff both the
valid links and the dormant links did not change. This is needed
to support cases where the valid links didn't change but the dormant
links did.

Fixes: 6d543b34dbcf ("wifi: mac80211: Support disabled links during association")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 76c61a132569..bf7bd880d062 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -195,7 +195,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 
 	memset(to_free, 0, sizeof(links));
 
-	if (old_links == new_links)
+	if (old_links == new_links && dormant_links == sdata->vif.dormant_links)
 		return 0;
 
 	/* if there were no old links, need to clear the pointers to deflink */
-- 
2.38.1

