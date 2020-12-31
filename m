Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88A2E7D4A
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLaAGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:12 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47700 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgLaAGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:12 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C28F413C2B0;
        Wed, 30 Dec 2020 16:05:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C28F413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373131;
        bh=hFkyYEWhA30TPBMGchH4iI/kOk+PGLWX5Kt4pCTCvhA=;
        h=From:To:Cc:Subject:Date:From;
        b=InfqUoQByIIFcqHjtXQ/5glhhNnUXgRAQzaX+SToRVdcYBAbb7zPfRbrWCYXX9oCn
         TnVJefXL1PcklllzIcI550xTsHEqnflPM9QMNbO/2zdB2rlz8oXqgDsqCucCP8yYd9
         PxqncQVIlvqumdGBr28wZYag65UjynOhB4tfoh4o=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/6] iwlwifi: Decrease firmware monitor debug area from 4MB to 512k.
Date:   Wed, 30 Dec 2020 16:05:18 -0800
Message-Id: <20201231000523.14963-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

It appears the code can handle down to 2^11, so set max in
this case to 2^19 to save mem.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2fffbbc8462f..18ddaa2c73fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -223,8 +223,8 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 			continue;
 
 		IWL_INFO(trans,
-			 "Allocated 0x%08x bytes for firmware monitor.\n",
-			 size);
+			 "Allocated 0x%08x bytes for firmware monitor, max_power: %d  min_power: %d  power: %d.\n",
+			 size, max_power, min_power, power);
 		break;
 	}
 
@@ -244,6 +244,8 @@ static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
 
 void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 {
+	pr_err("iwl_pcie_alloc_fw_monitor, monitor size max_power requested: %d\n",
+	       max_power);
 	if (!max_power) {
 		/* default max_power is maximum */
 		max_power = 26;
@@ -256,6 +258,13 @@ void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
 		 max_power))
 		return;
 
+	/* Try to use less memory, there are other things in the system as well! */
+	if (max_power > 19) {
+		pr_err("iwl_pcie_alloc_fw_monitor, decreasing max-power from %d to 19 to save memory.\n",
+		       max_power);
+		max_power = 19;
+	}
+
 	if (trans->dbg.fw_mon.size)
 		return;
 
-- 
2.20.1

