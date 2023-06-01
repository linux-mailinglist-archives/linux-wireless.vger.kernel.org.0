Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE719FAB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjFAOU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjFAOUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A21AB
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629244; x=1717165244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+uouVNSOyIbc5hYxsYtBdjEJPEDlJs7UryqFW+st7E=;
  b=kXO0xzcwCxYdBQJ1z8Mn9IP+6QOim84VEeX7At2CZP+WE8nq4kY0llL5
   i1mIpM/P6SS23p2vMNfWI2R7E3ivAyFsvfYfDw2IFQeLMsGntZ+qYfBsv
   QYhlg/lWWuG3GdFQySZFhLkXB+Kt8EFRn7oyAOdT2M4bB+4R9XriAqd5P
   D7yNyph0J3tyqYVdg33Jj5Wb3OyKko4SP+5FXSN50cuihYD050h/3qUg5
   tsyiN6XrC+gPMLqMAPVz4rybQgh+FSW6tNi51bn5qlzCFWnLdYPjQtAw1
   vIdRdLiWX3LbzyMMwOylts/nbrhQARQT7uc8/DRW00Xz5+TYS6tQ3a5RV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931875"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819812862"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819812862"
Received: from dvinnyc-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.93.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:20:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/6] wifi: iwlwifi: mvm: fix OEM's name in the tas approved list
Date:   Thu,  1 Jun 2023 17:20:07 +0300
Message-Id: <20230601171633.06828bbb50d8.If9391ef6da78f1b2cc5eb6cb8f6965816bb7a7f5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601142008.375040-1-gregory.greenman@intel.com>
References: <20230601142008.375040-1-gregory.greenman@intel.com>
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

From: Alon Giladi <alon.giladi@intel.com>

Fix a spelling mistake.

Fixes: 2856f623ce48 ("iwlwifi: mvm: Add list of OEMs allowed to use TAS")
Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index a97969075b7b..274ad34ae073 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1091,7 +1091,7 @@ static const struct dmi_system_id dmi_tas_approved_list[] = {
 	},
 		{ .ident = "LENOVO",
 	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Lenovo"),
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		},
 	},
 	{ .ident = "DELL",
-- 
2.38.1

