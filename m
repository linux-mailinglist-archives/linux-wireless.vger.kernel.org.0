Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A88296064
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507141AbgJVNvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 09:51:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56902 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2507018AbgJVNvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 09:51:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kVazh-002eBi-IG; Thu, 22 Oct 2020 16:51:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 22 Oct 2020 16:51:03 +0300
Message-Id: <iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] iwlwifi: pcie: limit memory read spin time
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we read device memory, we lock a spinlock, write the address we
want to read from the device and then spin in a loop reading the data
in 32-bit quantities from another register.

As the description makes clear, this is rather inefficient, incurring
a PCIe bus transaction for every read. In a typical device today, we
want to read 786k SMEM if it crashes, leading to 192k register reads.
Occasionally, we've seen the whole loop take over 20 seconds and then
triggering the soft lockup detector.

Clearly, it is unreasonable to spin here for such extended periods of
time.

To fix this, break the loop down into an outer and an inner loop, and
break out of the inner loop if more than half a second elapsed. To
avoid too much overhead, check for that only every 128 reads, though
there's no particular reason for that number. Then, unlock and relock
to obtain NIC access again, reprogram the start address and continue.

This will keep (interrupt) latencies on the CPU down to a reasonable
time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 36 ++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d2e69ad53b27..2fffbbc8462f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2156,18 +2156,36 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 				   void *buf, int dwords)
 {
 	unsigned long flags;
-	int offs, ret = 0;
+	int offs = 0;
 	u32 *vals = buf;
 
-	if (iwl_trans_grab_nic_access(trans, &flags)) {
-		iwl_write32(trans, HBUS_TARG_MEM_RADDR, addr);
-		for (offs = 0; offs < dwords; offs++)
-			vals[offs] = iwl_read32(trans, HBUS_TARG_MEM_RDAT);
-		iwl_trans_release_nic_access(trans, &flags);
-	} else {
-		ret = -EBUSY;
+	while (offs < dwords) {
+		/* limit the time we spin here under lock to 1/2s */
+		ktime_t timeout = ktime_add_us(ktime_get(), 500 * USEC_PER_MSEC);
+
+		if (iwl_trans_grab_nic_access(trans, &flags)) {
+			iwl_write32(trans, HBUS_TARG_MEM_RADDR,
+				    addr + 4 * offs);
+
+			while (offs < dwords) {
+				vals[offs] = iwl_read32(trans,
+							HBUS_TARG_MEM_RDAT);
+				offs++;
+
+				/* calling ktime_get is expensive so
+				 * do it once in 128 reads
+				 */
+				if (offs % 128 == 0 && ktime_after(ktime_get(),
+								   timeout))
+					break;
+			}
+			iwl_trans_release_nic_access(trans, &flags);
+		} else {
+			return -EBUSY;
+		}
 	}
-	return ret;
+
+	return 0;
 }
 
 static int iwl_trans_pcie_write_mem(struct iwl_trans *trans, u32 addr,
-- 
2.28.0

