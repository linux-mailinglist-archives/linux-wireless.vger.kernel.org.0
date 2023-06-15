Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525D730FAE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjFOGt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbjFOGtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBF297F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811664; x=1718347664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrvD9GwwfkXKhsSDMoLCr4OR3Kjcuh9IApIdDhSRBxs=;
  b=nfAlKLzvVvWpmJRbHpC4uvA7qRHeGfucTyhnKgDbWnLWatRcOEXohaQd
   ww5oxfmpz6LX5PN+52D25Jdg4NrqABT0nXi2hF2DzJAkKOvhIe5IYa3+6
   /tMIkz9NsFaxhwijzBtepkOe5vmZp+TT5aqKqOpDz7EBhy9sfjUT1aHHY
   fF4VWmMssmuTb/TpF1euBXFHKStq77DF+6zOn6JulFJcWS6eQxmoWSdEm
   zqSNAbLrTLYR5og5Ghq89pvAbf0v3t8sgLE0tTIleBz73/zywPXqQTxWf
   qVMrouV5TV7PSg1kqKWSgIBb8/olH0V6HXpnR1J5ALXxYvXpyI4rB1MkA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212263"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395975"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395975"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5/5] wifi: iwlwifi: bump FW API to 81 for AX devices
Date:   Thu, 15 Jun 2023 09:47:20 +0300
Message-Id: <20230615094410.e61fdc474d89.I3d9823231fa7fc47158b8aa3561b43822c8c86cd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230615064720.459645-1-gregory.greenman@intel.com>
References: <20230615064720.459645-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Start supporting API version 81 for AX devices.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 29dded1531a0..5ac9416331de 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX	79
+#define IWL_22000_UCODE_API_MAX	81
 #define IWL_22500_UCODE_API_MAX	77
 
 /* Lowest firmware API version supported */
-- 
2.38.1

