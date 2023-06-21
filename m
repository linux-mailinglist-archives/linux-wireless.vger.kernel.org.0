Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826D7380CB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFUKOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjFUKOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639C10FE
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342433; x=1718878433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wkduqHwzUIKPPTlBQEBpz8kP6Qfs1iJUKhHWijQkx2o=;
  b=D9aAT7ruZ3r2kOatSgX8XVA9n0QvFBxfLnWSo8BV19XaKloNyW7VkvOh
   n+u+67yIg5EJiD42fizbfrqG1n3GVYwLOGFUxH0QTY1ahgfv5zvXtF32T
   hun8OuJTI5lsXMCGn1xmUHUt12cnnytYxOTQiOQ+JXYObKnTlPT3/0SJI
   Fk3sMINB7ijZs/FlAjEAt57oVomDPT0wkAob81DoyL+YbieTK23+5aT2a
   OMwxcC2zzdCOvHRNhtV8zc0XB/qTo4LMyaeuxJehvIBnFD9EAW+r3YphN
   QBrf5eXltC7MUvmjMHRVyqY5uVzXwJNmT3m/Q0fb7zGsihLt81oFsIx9q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506495"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599297"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599297"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/18] wifi: iwlwifi: bump FW API to 83 for AX/BZ/SC devices
Date:   Wed, 21 Jun 2023 13:12:19 +0300
Message-Id: <20230621130444.267a136ea57f.Iaef9f04b9655c5c1b8bdee3b89cc3361ab621bcf@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Start supporting API version 83 for new devices.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 1821e569e9b3..73736f7372d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_AX210_UCODE_API_MAX	82
+#define IWL_AX210_UCODE_API_MAX	83
 
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	59
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 4f0bc6924111..2feb47af8dda 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	82
+#define IWL_BZ_UCODE_API_MAX	83
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 6e487a83ee24..ad283fd22e2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	82
+#define IWL_SC_UCODE_API_MAX	83
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.38.1

