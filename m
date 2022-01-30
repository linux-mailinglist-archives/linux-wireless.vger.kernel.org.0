Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAF4A357F
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354541AbiA3JxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37902 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354531AbiA3JxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:13 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tS-0003JO-LS;
        Sun, 30 Jan 2022 11:53:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:52:58 +0200
Message-Id: <iwlwifi.20220130115024.ea00b52c6f25.I8b79b14f1af8b6f2f579f97b397b9e005fe446b1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: pcie: make sure iwl_rx_packet_payload_len() will not underflow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

If the device is malfunctioning and reports too short rx descriptor
length, iwl_rx_packet_payload_len() will underflow, eventually resulting
in accessing memory out of bounds and other bad things. Prevent this.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index bda98c2eb0ad..e4016c97d5ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1317,7 +1317,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 		offset += ALIGN(len, FH_RSCSR_FRAME_ALIGN);
 
 		/* check that what the device tells us made sense */
-		if (offset > max_len)
+		if (len < sizeof(*pkt) || offset > max_len)
 			break;
 
 		trace_iwlwifi_dev_rx(trans->dev, trans, pkt, len);
-- 
2.34.1

