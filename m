Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBD3DDAAB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhHBOSa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:18:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238444AbhHBORe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:17:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdY-001xoA-Li; Mon, 02 Aug 2021 17:09:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:37 +0300
Message-Id: <iwlwifi.20210802170640.6a62255b3df0.I47bb36530a3c2cdbd73454c796ce608ee2a32a6c@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/12] iwlwifi: pcie: optimise struct iwl_rx_mem_buffer layout
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On 64-bit machines, struct iwl_rx_mem_buffer has a lot of
padding due to the use of pointers after the small items.
Move the list entry before them, and while at it also add
documentation for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index cc550f6ef957..10d763fc3d50 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -42,6 +42,7 @@ struct iwl_host_cmd;
  * struct iwl_rx_mem_buffer
  * @page_dma: bus address of rxb page
  * @page: driver's pointer to the rxb page
+ * @list: list entry for the membuffer
  * @invalid: rxb is in driver ownership - not owned by HW
  * @vid: index of this rxb in the global table
  * @offset: indicates which offset of the page (in bytes)
@@ -50,10 +51,10 @@ struct iwl_host_cmd;
 struct iwl_rx_mem_buffer {
 	dma_addr_t page_dma;
 	struct page *page;
-	u16 vid;
-	bool invalid;
 	struct list_head list;
 	u32 offset;
+	u16 vid;
+	bool invalid;
 };
 
 /**
-- 
2.32.0

