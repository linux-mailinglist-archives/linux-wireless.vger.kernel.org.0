Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB57B7C53
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbjJDJh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbjJDJh1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B85FB
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412240; x=1727948240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJjgrAkCVxY2XcSPYWBamCdKmy+0uAq0cNIQxacbYrU=;
  b=cDZEVaDrcChHQ1Uqi8UiQe8jUREplLgngjnjusx+rTzcDq3Jfja5Fewi
   RmjKm4b5rtCwOgvSLCZafwXYGSqIsdZwElz6hjd6d4UnrzuXTsWRdZuZ6
   fJhwauZRss7vNy+FCR+yp8NFyDxmtkdnh42tc8UQMSPN+gWC/QdRiPpUq
   lbqjjuFvd1DM01DynjKJE96DUcqhx0jhzhoSkYWaKBEQ81cEaz4AHR9Kl
   tg/THoQ6yqendN94YxmX2RwfnA2EqS4qwKGnaOmTOyNV2HNZ6nq1Abhu/
   ymzIBR+VeV4+VnIHXmnUsy8SR/vqG3fH1nr9DkmxO9zyUrV118sprJotE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611893"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611893"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415204"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415204"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: fix the rf step and flavor bits range
Date:   Wed,  4 Oct 2023 12:36:33 +0300
Message-Id: <20231004123422.cfd0aaaa5eb3.Ie2dd6c3a3062647f19cb5e888c46f0fdca103484@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The macros used to get the RF step and flavour are using
wrong bit range. Update the bit range for both macros.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index c1a94b01ce14..da035dbfbdb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -423,14 +423,14 @@ enum {
  * reserved: bits 12-18
  * slave_exist: bit 19
  * dash: bits 20-23
- * step: bits 24-26
- * flavor: bits 27-31
+ * step: bits 24-27
+ * flavor: bits 28-31
  */
 #define REG_CRF_ID_TYPE(val)		(((val) & 0x00000FFF) >> 0)
 #define REG_CRF_ID_SLAVE(val)		(((val) & 0x00080000) >> 19)
 #define REG_CRF_ID_DASH(val)		(((val) & 0x00F00000) >> 20)
-#define REG_CRF_ID_STEP(val)		(((val) & 0x07000000) >> 24)
-#define REG_CRF_ID_FLAVOR(val)		(((val) & 0xF8000000) >> 27)
+#define REG_CRF_ID_STEP(val)		(((val) & 0x0F000000) >> 24)
+#define REG_CRF_ID_FLAVOR(val)		(((val) & 0xF0000000) >> 28)
 
 #define UREG_CHICK		(0xA05C00)
 #define UREG_CHICK_MSI_ENABLE	BIT(24)
-- 
2.38.1

