Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A156E1459
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDMSmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDMSmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:42:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB096E86
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411343; x=1712947343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S6kuJZBzTChw4SZ7hh3qCTvVQL4SCAnv44wphRY+n/E=;
  b=BcGYjHvCnCWNJm2kjySMe98eHoY52hxSSGo9ePdmZ9nm7+hupNrGnbGV
   +f4qslfSB4nDsB/6pMhRbMrgNd4RmPaie/FW4Unp2rnbbNq2gK//qfv4r
   QrpMqUv0HfWtY7xVuN47oCpXHxQ/BIQLRsHC1NYJMBaxKa1p2tSpIzIvk
   ijoGi5J39gC7PhDVUmbInGn0ylXvoU2iTfGI+gG5/16mtL4phPyz1QwOJ
   xkn+anBb0ljrm8r3bkbL6iRYdueVDWySpB6tW/S004I0I/dR/oPQlk7nE
   LCHHkQ700vtuKnrx/ZawCRlYmXQ1vQ0lTHST0HpRrikmMM72ztYzMXhRb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127111"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984483"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984483"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: yoyo: Fix possible division by zero
Date:   Thu, 13 Apr 2023 21:40:34 +0300
Message-Id: <20230413213309.5d6688ed74d8.I5c2f3a882b50698b708d54f4524dc5bdf11e3d32@changeid>
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

From: Daniel Gabay <daniel.gabay@intel.com>

Don't allow buffer allocation TLV with zero req_size since it
leads later to division by zero in iwl_dbg_tlv_alloc_fragments().
Also, NPK/SRAM locations are allowed to have zero buffer req_size,
don't discard them.

Fixes: a9248de42464 ("iwlwifi: dbg_ini: add TLV allocation new API support")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 87366b70b17f..546737320a57 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -138,6 +138,12 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 		goto err;
 
+	if (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
+	    alloc->req_size == 0) {
+		IWL_ERR(trans, "WRT: Invalid DRAM buffer allocation requested size (0)\n");
+		return -EINVAL;
+	}
+
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
 
 	return 0;
-- 
2.38.1

