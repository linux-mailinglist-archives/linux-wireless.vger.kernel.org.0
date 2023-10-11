Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA637C4FBC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346248AbjJKKJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbjJKKJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89B22112
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018889; x=1728554889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xmj9yPuL+hdss5Lrj9ZdtAzsF9o8StU8XogQHAtKl3o=;
  b=hgWIN9aJiEGCG8MTpDI2YLoZW27AUR/EKhtLZ4jfgvAaMpvGKFt06npd
   3PsqZmoMqqk+LTg8XSM1a/G2lGsEuefRFT9+T1SFIDNJIjDH5Aq7+gBRe
   YzM0skuR9d/6vOgebpKb+VjvemcvzgJYy/78uwdgaBsOjtPNMta1Aob/z
   zzcqQi3RxxYc6DgFqHUMJQP9synK1X+Iam32l6cyiWXEVCOYBP1ReJ7BI
   1J8N1/t9prnc/ml/WTcx+K6rfvoUoYZkbIgkauA/ytFC+cAMJxmCMS0fF
   Iec/yKy6rJO9UdioIVF6iqCHfBgmx41/SBpWJ2x06JSXf80yu6/WUwhzY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670640"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670640"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050314"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050314"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:08 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/16] wifi: iwlwifi: mvm: extend alive timeout to 2 seconds
Date:   Wed, 11 Oct 2023 13:07:27 +0300
Message-Id: <20231011130030.f1f0aa1794e6.I34a06ef24b642a32af69c0bd109694de469d5177@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

There are devices that need longer time to get the alive notification.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d791132b3a33..f04f85320133 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -23,7 +23,7 @@
 #include "iwl-nvm-parse.h"
 #include "time-sync.h"
 
-#define MVM_UCODE_ALIVE_TIMEOUT	(HZ)
+#define MVM_UCODE_ALIVE_TIMEOUT	(2 * HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
 #define IWL_TAS_US_MCC 0x5553
-- 
2.38.1

