Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4CD47A028
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhLSKS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51340 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235569AbhLSKS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:28 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGr-001O3b-Rg; Sun, 19 Dec 2021 12:18:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:11 +0200
Message-Id: <iwlwifi.20211219121514.539aecb91247.I6e555a5185bad30d7d1a4659f9c0b99325425f18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/12] iwlwifi: mvm: don't trust hardware queue number
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't really have much reason to mistrust the hardware
queue number, but if it gets mixed up we still don't want
to access some data out of bounds, so drop such frames.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f12e571d3581..2b42b1b1fe60 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1918,6 +1918,9 @@ static void iwl_mvm_rx_mq_rss(struct iwl_op_mode *op_mode,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	u16 cmd = WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd);
 
+	if (unlikely(queue >= mvm->trans->num_rx_queues))
+		return;
+
 	if (unlikely(cmd == WIDE_ID(LEGACY_GROUP, FRAME_RELEASE)))
 		iwl_mvm_rx_frame_release(mvm, napi, rxb, queue);
 	else if (unlikely(cmd == WIDE_ID(DATA_PATH_GROUP,
-- 
2.34.1

