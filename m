Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A06424C0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiLEIgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiLEIgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12270167D7
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229403; x=1701765403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WBMPlvHy6e6psyZUuZS5/sTjRfclty2s753aRFhNhmA=;
  b=T3QHBLVE2G1nHsbAiB3DBc2h3AyNfMEziysr5PXHuE+U0XWKQQhehsS4
   KAVT+XfMvjTSelHPY7f32Sc/pdO2xnFW+ycGhZFhT+SsCv0SSVZYR47/g
   zouaseKnCvTjL0VsFqIgtpNgj9uGdx/my5uZrD+6S+VZkS6LuIS5K69tt
   VOhlKrOYR3VdgIHdZ3wiu/PcembqH0W2cL7hIT+ecUgnhoOXEP14FFB91
   nK2jR9WeCCEttqIA5v8pEan2KCENl8JeWf7bs0f9CKDP7KN3u+xFynqEP
   x3ndrQJjgTb84NdQCouBRdMXQu/fUHFjv32HIcGpKYxZ0TsYhTY8pbNdv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323210"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100465"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100465"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:39 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: fw: use correct IML/ROM status register
Date:   Mon,  5 Dec 2022 10:35:48 +0200
Message-Id: <20221205102808.28de1a5b2493.I356c9404623fd5ef793d47481fe37a95be355c6b@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Different registers should be used, but they code wasn't
adjusted for the 'error' register, only for the 'data1'.
Fix that.

Coverity CID: 1487176
Coverity CID: 1487230

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 03b1b2428b5e..792f7fee1840 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -377,7 +377,7 @@ static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
 		return;
 	}
 
-	error = iwl_read_umac_prph(trans, UMAG_SB_CPU_2_STATUS);
+	error = iwl_read_umac_prph(trans, error);
 
 	IWL_ERR(trans, "IML/ROM dump:\n");
 
-- 
2.35.3

