Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110872D4CE0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgLIVbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:31:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35838 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726877AbgLIVbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:31:53 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pi-003Drx-59; Wed, 09 Dec 2020 23:17:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:25 +0200
Message-Id: <iwlwifi.20201209231352.6378fb435cc0.Ib07485f3dc5999c74b03f21e7a808c50a05e353c@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 21/47] iwlwifi: pcie: validate RX descriptor length
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Validate the maximum RX descriptor length against the size
of the buffers we gave the device - if it doesn't fit then
the hardware messed up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 94299f259518..ed200f541bfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1335,6 +1335,13 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 
 		len = iwl_rx_packet_len(pkt);
 		len += sizeof(u32); /* account for status word */
+
+		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
+
+		/* check that what the device tells us made sense */
+		if (offset > max_len)
+			break;
+
 		trace_iwlwifi_dev_rx(trans->dev, trans, pkt, len);
 		trace_iwlwifi_dev_rx_data(trans->dev, trans, pkt, len);
 
@@ -1392,7 +1399,6 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		page_stolen |= rxcb._page_stolen;
 		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 			break;
-		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
 	}
 
 	/* page was stolen from us -- free our reference */
-- 
2.29.2

