Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0550027EA01
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgI3Nbi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53346 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730480AbgI3Nbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCk-002MJ5-Fy; Wed, 30 Sep 2020 16:31:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:19 +0300
Message-Id: <iwlwifi.20200930161256.6a0aae2c0507.I7bd72968279d586af420472707d53106b35efc08@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: dbg: remove no filter condition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently if group-id and command-id values are zero we
trigger and collect every RX frame,
this is not the right behavior and zero value
should be handled like any other filter.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: 3ed34fbf9d3b ("iwlwifi: dbg_ini: support FW response/notification region type")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index c44e61aa2aca..9b64a12e489d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -954,9 +954,8 @@ static bool iwl_dbg_tlv_check_fw_pkt(struct iwl_fw_runtime *fwrt,
 	struct iwl_rx_packet *pkt = tp_data->fw_pkt;
 	struct iwl_cmd_header *wanted_hdr = (void *)&trig_data;
 
-	if (pkt && ((wanted_hdr->cmd == 0 && wanted_hdr->group_id == 0) ||
-		    (pkt->hdr.cmd == wanted_hdr->cmd &&
-		     pkt->hdr.group_id == wanted_hdr->group_id))) {
+	if (pkt && (pkt->hdr.cmd == wanted_hdr->cmd &&
+		    pkt->hdr.group_id == wanted_hdr->group_id)) {
 		struct iwl_rx_packet *fw_pkt =
 			kmemdup(pkt,
 				sizeof(*pkt) + iwl_rx_packet_payload_len(pkt),
-- 
2.28.0

