Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3194DCBB61
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfJDNOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 09:14:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46576 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388186AbfJDNOY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 09:14:24 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGNPb-0000l2-1W; Fri, 04 Oct 2019 16:14:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 16:14:11 +0300
Message-Id: <20191004131414.27372-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004131414.27372-1-luca@coelho.fi>
References: <20191004131414.27372-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 5/8] iwlwifi: pcie: fix indexing in command dump for new HW
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We got a crash in iwl_trans_pcie_get_cmdlen(), while the TFD was
being accessed to sum up the lengths.

We want to access the TFD here, which is the information for the
hardware. We always only allocate 32 buffers for the cmd queue,
but on newer hardware (using TFH) we can also allocate only a
shorter hardware array, also only 32 TFDs. Prior to the TFH, we
had to allocate a bigger TFD array but would make those point to
a smaller set of buffers.

Additionally, now max_tfd_queue_size is up to 65536, so we can
access *way* out of bounds of a really only 32-entry array, so
it crashes.

Fix this by making the TFD index depend on which hardware we are
using right now.

While changing the calculation, also fix it to not use void ptr
arithmetic, but cast to u8 * before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f8a1f985a1d8..ab7480a85015 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3272,11 +3272,17 @@ static struct iwl_trans_dump_data
 		ptr = cmdq->write_ptr;
 		for (i = 0; i < cmdq->n_window; i++) {
 			u8 idx = iwl_pcie_get_cmd_index(cmdq, ptr);
+			u8 tfdidx;
 			u32 caplen, cmdlen;
 
+			if (trans->trans_cfg->use_tfh)
+				tfdidx = idx;
+			else
+				tfdidx = ptr;
+
 			cmdlen = iwl_trans_pcie_get_cmdlen(trans,
-							   cmdq->tfds +
-							   tfd_size * ptr);
+							   (u8 *)cmdq->tfds +
+							   tfd_size * tfdidx);
 			caplen = min_t(u32, TFD_MAX_PAYLOAD_SIZE, cmdlen);
 
 			if (cmdlen) {
-- 
2.23.0

