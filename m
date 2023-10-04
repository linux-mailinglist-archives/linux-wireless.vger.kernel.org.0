Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852E7B7C49
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbjJDJhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjJDJhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87707A7
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412221; x=1727948221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fR+YKwoHfLIRDI3H/5+RZ3cQPiNyeCWqZgd3W3V4VaM=;
  b=SNwdv25Fl3sWlJD/usu/RxaymF0aX4EhOcfm1bkQpvDlPu7Wa1BPMi1l
   UXTBn0qPaxnvF+70KzQY1Rj1l/jbbaWDEZW2G4gATavbVd4leFMUtvIz8
   R1ZWi9vVGZXjwQjKJhFAwU5LgmZZvJYpE+BpogrDyHUg0FtS4STB04QO8
   9RklyFlKXlN9ljMicVHJFLgnRuJrVI3s8TkHH2xQay3af4abtYi4IE0vH
   az6Sy0jG3ema7YuHL05OokfBydyV+nzZfOh9YQshenKylQG9c6S5qdkrN
   qITEcl6OElC5QttGBQpRL0CbfAjpFiZxqYH3RLvFhkB38klmvKMztIpNI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611727"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611727"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415155"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415155"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:51 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rotem Saado <rotem.saado@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: yoyo: swap cdb and jacket bits values
Date:   Wed,  4 Oct 2023 12:36:22 +0300
Message-Id: <20231004123422.356d8dacda2f.I349ab888b43a11baa2453a1d6978a6a703e422f0@changeid>
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

From: Rotem Saado <rotem.saado@intel.com>

The bits are wrong, the jacket bit should be 5 and cdb bit 4.
Fix it.

Fixes: 1f171f4f1437 ("iwlwifi: Add support for getting rf id with blank otp")
Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 06d467068ff4..7bd4ce149e04 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -348,8 +348,8 @@
 #define RFIC_REG_RD			0xAD0470
 #define WFPM_CTRL_REG			0xA03030
 #define WFPM_OTP_CFG1_ADDR		0x00a03098
-#define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(4)
-#define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(5)
+#define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(5)
+#define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(4)
 #define WFPM_OTP_BZ_BNJ_JACKET_BIT	5
 #define WFPM_OTP_BZ_BNJ_CDB_BIT		4
 #define WFPM_OTP_CFG1_IS_JACKET(_val)   (((_val) & 0x00000020) >> WFPM_OTP_BZ_BNJ_JACKET_BIT)
-- 
2.38.1

