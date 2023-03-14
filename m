Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E656B9D94
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCNRyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCNRyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B726619A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816433; x=1710352433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVoIuRZGhTmLawHoe5mIKhilHr45bRXD7PfZnEe2+jA=;
  b=PKygbFftKNfdaoQ08doyvjatj+69tOC8iV/vMopjs7GoLkuSoqkb/zMx
   9jxTta60owDmlyA7zMUgmvz99Wuc5D0sGjk7Mq/XPHntHoHtBMZexOQvJ
   yV4LBtw2jOO7HhTFaP3OU77ugZ63gLSBi14iZ2rkfJ5xnn25lmr/1iGQn
   NqS+hqpCzj4rwvb/KTJweb3dIRh7GsAERaebYMJS/0CNfQiTP9q3Q+V7R
   lePk1Tb0riVaQ3Smc5IjLk+Cthl+bxr4mWx3WwVxv2utv6FdQfJkWPwAr
   2iAjsX2I+XlZqlPQXdrAq8eM90z1K3ljAbcjx9JDF8zayOiyWDEXVtjPC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149729"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149729"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200592"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200592"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/22] wifi: iwlwifi: mvm: rs: print BAD_RATE for invalid HT/VHT index
Date:   Tue, 14 Mar 2023 19:49:32 +0200
Message-Id: <20230314194113.06b38d160fc5.I45a9254d3658b1ce796aa4c427193d3cbf638d7e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If there's a rate->index that maps inside the range but
to an uninitialized value, then that's also a bad rate,
avoid printing "(nil)" in that case and rather print the
"BAD_RATE" string instead as in the else branch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 7c976b7f1cd7..bd135b7168cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -512,10 +512,10 @@ static char *rs_pretty_rate(const struct rs_rate *rate)
 		 (rate->index <= IWL_RATE_MCS_9_INDEX))
 		rate_str = ht_vht_rates[rate->index];
 	else
-		rate_str = "BAD_RATE";
+		rate_str = NULL;
 
 	sprintf(buf, "(%s|%s|%s)", rs_pretty_lq_type(rate->type),
-		iwl_rs_pretty_ant(rate->ant), rate_str);
+		iwl_rs_pretty_ant(rate->ant), rate_str ?: "BAD_RATE");
 	return buf;
 }
 
-- 
2.38.1

