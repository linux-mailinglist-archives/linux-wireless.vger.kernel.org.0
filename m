Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FEB701C7E
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjENJQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbjENJQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02527272A
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055794; x=1715591794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W4RGxG0Vy1qXxIFpSA+MOMm17el+kCNIPm3YHMbDyWk=;
  b=PV/EQnPnMvy0DZmgSuZ82WAm1C+n7JLrm7MryVeN80SzFUPkdZzJtmMh
   FovkkJ6jqnECR3pw+eDjFpCPlbnodlw7cZcj/rV3/8ogfv1L8xIjOXVjz
   d6x+elGLQgV+EEz/+VnTQn+YLqjb1NMw4ZDfliAkiEwA/cKOI97gkwdcs
   vXYIx6Se2eMkOahK6WXtThhq1p9DLwPuu7oVpjCmXfuM6KT82XXZ820Mu
   SlREHIiq5R5h9M9AmS7NGcwkunqsdsusxF6lvAeasFnBcFLzSfclYLeBz
   v2iC5/Y9spD2k0GUV2ax1Qx3H1PX5jNRN6ojZf68rn1TkdgL/kMFMAAjr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366859"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366859"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300440"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300440"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 09/12] wifi: iwlwifi: mvm: fix OEM's name in the tas approved list
Date:   Sun, 14 May 2023 12:15:52 +0300
Message-Id: <20230514120631.4090de6d1878.If9391ef6da78f1b2cc5eb6cb8f6965816bb7a7f5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index b35c96cf7ad2..ef7e8205b31c 100644
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

