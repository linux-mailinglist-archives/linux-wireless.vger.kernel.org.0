Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876375AEBAC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiIFOCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiIFOAU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:00:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81C83F2E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471860; x=1694007860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qw4/LQBfMM8AzS7rwZHBIi2flgUOzLeoUR4QNprbkeo=;
  b=jdIm1OhJCQCw1Y/SIXctjqzHQeDKq5sM1GyHmP9WJhPqc9FxZkZrq881
   UKw7BYGH4dP379KDnYPjc9+BfCNxnlCChdjiwjogzMifVaWNWj4I5LJpj
   Rfl4CDE0kcDtmkgq09Yg3FckwRP6L45So9WUsvLaLAPqdgfcwwg9iRy1P
   AeZk5UTUGliXvsp1zUHbsh8M+zDPy1NuM3YyJRuroeR53LEOUz8ictUo8
   2jnw/f+F4u+04tpZ5j9X3JhxqNJ7Lb793vKBhVDFNpYL3SbH5IZhVYF7g
   QsAWmE3aUg85zxDx7LofV48vWAWThOg2yEkxjdtNl4Y+yBKGWXYGDT8ls
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276332678"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276332678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459600"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:16 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: mvm: fix typo in struct iwl_rx_no_data API
Date:   Tue,  6 Sep 2022 16:42:06 +0300
Message-Id: <20220906161827.80f7eda56163.Ib783512104f0c135695b4d59b637f3eef3e8f537@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The version 2 is also for RX, of course, that's just a typo.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 1989b270862b..74a01888715b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -668,7 +668,7 @@ struct iwl_rx_no_data {
 	__le32 phy_info[2];
 	__le32 rx_vec[2];
 } __packed; /* RX_NO_DATA_NTFY_API_S_VER_1,
-	       TX_NO_DATA_NTFY_API_S_VER_2 */
+	       RX_NO_DATA_NTFY_API_S_VER_2 */
 
 struct iwl_frame_release {
 	u8 baid;
-- 
2.35.3

