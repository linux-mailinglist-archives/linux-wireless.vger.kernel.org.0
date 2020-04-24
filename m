Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A431B7A7C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgDXPsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57876 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727885AbgDXPs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:29 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z1-000OY2-Jg; Fri, 24 Apr 2020 18:48:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:07 +0300
Message-Id: <iwlwifi.20200424182643.06de959301f5.I544c353a8a811f107bd66d168e37920237ecf071@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: fw api: fix PHY data 2/3 position
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In AX210 devices, the PHY data wasn't actually reported, but now
that it's going to be reported it turns out that the position is
supposed to be the other way around, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 88bc7733065f..b8b36a4f9eb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,10 +27,9 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -535,9 +533,9 @@ struct iwl_rx_mpdu_desc_v3 {
 		__le32 filter_match;
 
 		/**
-		 * @phy_data2: depends on info type (see @phy_data1)
+		 * @phy_data3: depends on info type (see @phy_data1)
 		 */
-		__le32 phy_data2;
+		__le32 phy_data3;
 	};
 
 	/* DW8 - carries rss_hash only when rpa_en == 1 */
@@ -548,9 +546,9 @@ struct iwl_rx_mpdu_desc_v3 {
 		__le32 rss_hash;
 
 		/**
-		 * @phy_data3: depends on info type (see @phy_data1)
+		 * @phy_data2: depends on info type (see @phy_data1)
 		 */
-		__le32 phy_data3;
+		__le32 phy_data2;
 	};
 	/* DW9 */
 	/**
-- 
2.26.2

