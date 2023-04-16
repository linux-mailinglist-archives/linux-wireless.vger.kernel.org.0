Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A56E385E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDPMsj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjDPMsi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2D4ED5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649307; x=1713185307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=94enEkycl3ZBJ7tegnUIsNZQ+SBc+RLWwB041LQ7404=;
  b=gZE/4MqPMsNNzb88bmQONWzkUGJPk6kIsGbmwnJlSWG84qE7jwlosEZd
   /oNWSVilhD81kauJlGAAgL+DiUsBLN4okXEVF8vYCUqLriksVwYhUYxwg
   93uY3FpgZmgrpYPp/H3vnGEZTavqlPIvzdND3MiZ4e6Sx97LkPZCP/jpz
   iBC7cPsBoXHVSg3Y00bP9o9kL/CHAVOv/RIx7dy6zbinnFoa2A4MaY/fC
   KMPxC587GEfLTMpigy0xRIadWzhfODS7gSKbbSOJEeeYvRsxaOtm/PEZp
   6DDbvUFQd2GGHnPQAUJ6ae7M+i54OoNYkIxziz+irVuPQMGn3nrUET+jh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520585"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520585"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670462"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670462"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Golan Ben Ami <golan.ben.ami@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: move debug buffer allocation failure to info verbosity
Date:   Sun, 16 Apr 2023 15:47:39 +0300
Message-Id: <20230416154301.0a7f557aa2a0.If9db474b63242b1bfaed659aa174b678ae8dc196@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
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

From: Golan Ben Ami <golan.ben.ami@intel.com>

This is noising the kernel log and customers asked to hush it down.
We can live with this message in "info" verbosity.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 546737320a57..898d5dcf1012 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -803,7 +803,7 @@ static void iwl_dbg_tlv_update_drams(struct iwl_fw_runtime *fwrt)
 		if (!ret)
 			dram_alloc = true;
 		else
-			IWL_WARN(fwrt,
+			IWL_INFO(fwrt,
 				 "WRT: Failed to set DRAM buffer for alloc id %d, ret=%d\n",
 				 i, ret);
 	}
-- 
2.38.1

