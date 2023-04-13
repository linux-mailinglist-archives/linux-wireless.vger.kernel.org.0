Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B96E144D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjDMSlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDMSlp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:41:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685049CE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411302; x=1712947302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBcyASEKRmSlAFwNcYnc6XKMHP7W85GZpBDY6YAMAvg=;
  b=Yrk0FKLjyYdkWl7l1qa0+O/Z/i8molu3oUg1uY1zp7m1l1SCK4RTscl4
   3r4gdj3tMHyJrt4bWckiC3ZxvFkaPUdLLVL2dFGFatK0nbantE9upsbyY
   pQ44uo1oo64iT2LscrRuWgswcdeG4ERRnh9l+3nQ06vMzpswRM6RAMsv2
   /8iQnQJ0YFPZwWJCEaLDecVyQ0GuMh99omH+8W8Vlgsiz2Y4LPZcQyziu
   zm3PvHc3+vy6a3VXkxQI6MEZpP6btAluRNhbbThkLeyI7g3jZGT+oVHtq
   6kJTl7rbfjYDiv2AN6oTrx1fGFDAd3m5BY4SppfjNJkB2vAvTBLp5z7D4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127081"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984396"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984396"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: Fix the duplicate dump name
Date:   Thu, 13 Apr 2023 21:40:31 +0300
Message-Id: <20230413213309.6c987f820557.I924f2eae1eef2fe82c7a23be566551653d46f729@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Driver is using the dump name generated first time in all
generated dump in case of NMI.
The validity of dump name should be with each dump created
and need to reset after each use.

Fixes: 834f920ef34b ("wifi: iwlwifi: yoyo: Add driver defined dump file name")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ca97f2fcb693..51cdbc13fbcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2345,6 +2345,8 @@ static u32 iwl_dump_ini_file_name_info(struct iwl_fw_runtime *fwrt,
 	/* add the dump file name extension tlv to the list */
 	list_add_tail(&entry->list, list);
 
+	fwrt->trans->dbg.dump_file_name_ext_valid = false;
+
 	return entry->size;
 }
 
-- 
2.38.1

