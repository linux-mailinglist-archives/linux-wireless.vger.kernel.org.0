Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773253AAD14
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFQHLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47926 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230118AbhFQHLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm98-001XeC-FZ; Thu, 17 Jun 2021 10:09:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:50 +0300
Message-Id: <iwlwifi.20210617100544.2d4b46c656bb.Iff9ee6a7e65d439169202911dad2cbea626fb887@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: pcie: fix some kernel-doc comments
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

"ubd" is really called "used_bd", fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 907781714680..1c740c382b9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -109,8 +109,8 @@ struct iwl_rx_completion_desc {
  *	Address size is 32 bit in pre-9000 devices and 64 bit in 9000 devices.
  *	In AX210 devices it is a pointer to a list of iwl_rx_transfer_desc's
  * @bd_dma: bus address of buffer of receive buffer descriptors (rbd)
- * @ubd: driver's pointer to buffer of used receive buffer descriptors (rbd)
- * @ubd_dma: physical address of buffer of used receive buffer descriptors (rbd)
+ * @used_bd: driver's pointer to buffer of used receive buffer descriptors (rbd)
+ * @used_bd_dma: physical address of buffer of used receive buffer descriptors (rbd)
  * @tr_tail: driver's pointer to the transmission ring tail buffer
  * @tr_tail_dma: physical address of the buffer for the transmission ring tail
  * @cr_tail: driver's pointer to the completion ring tail buffer
-- 
2.32.0

