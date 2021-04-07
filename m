Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E152F3565D8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhDGH4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDGHz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 03:55:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59953C06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 00:55:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lU32M-008Tw9-8V; Wed, 07 Apr 2021 09:55:42 +0200
Message-ID: <95b6c4b34da1173faf226246ea25b47a8fd395b7.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 07 Apr 2021 09:55:41 +0200
In-Reply-To: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm> (sfid-20210407_095129_306913_82B5BB2F)
References: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
         <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
         (sfid-20210407_095129_306913_82B5BB2F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-04-07 at 09:51 +0200, Jiri Kosina wrote:
> On Wed, 7 Apr 2021, Heiner Kallweit wrote:
> 
> > Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
> > iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
> > I get the same lockdep warning on AX210.
> 
> Makes sense, it's being called from exactly the same contexts.

I'm guessing nobody saw this before because the LEDs stuff is not
supported/used on newer devices :)

Still makes sense though.

Btw, I had a fix for your patch for some devices, see below. Already in
our tree, so Luca will send it on the way, just FYI/review here.

Thanks,
johannes


From: Johannes Berg <johannes.berg@intel.com>
Date: Tue, 6 Apr 2021 16:50:23 +0200
Subject: [PATCH] [BUGFIX] iwlwifi: pcie: don't enable BHs with IRQs disabled

After the fix from Jiri that disabled local IRQs instead of
just BHs (necessary to fix an issue with submitting a command
with IRQs already disabled), there was still a situation in
which we could deep in there enable BHs, if the device config
sets the apmg_wake_up_wa configuration, which is true on all
7000 series devices.

To fix that, but not require reverting commit 1ed08f6fb5ae
("iwlwifi: remove flags argument for nic_access"), split up
nic access into a version with BH manipulation to use most
of the time, and without it for this specific case where the
local IRQs are already disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 ++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 24 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  4 ++--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 2c2389feb5e1..0b99f0c34111 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -453,6 +453,11 @@ struct iwl_trans
 		      const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_pcie_free(struct iwl_trans *trans);
 
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
+#define _iwl_trans_pcie_grab_nic_access(trans)			\
+	__cond_lock(nic_access_nobh,				\
+		    likely(__iwl_trans_pcie_grab_nic_access(trans)))
+
 /*****************************************************
 * RX
 ******************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f2869fc343e3..bf36fa72f22e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2047,12 +2047,16 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	module_put(THIS_MODULE);
 }
 
-static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+/*
+ * This version doesn't disable BHs but rather assumes they're
+ * already disabled.
+ */
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-	spin_lock_bh(&trans_pcie->reg_lock);
+	spin_lock(&trans_pcie->reg_lock);
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
@@ -2137,7 +2141,7 @@ static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 		}
 
 err:
-		spin_unlock_bh(&trans_pcie->reg_lock);
+		spin_unlock(&trans_pcie->reg_lock);
 		return false;
 	}
 
@@ -2150,6 +2154,20 @@ out:
 	return true;
 }
 
+static bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+{
+	bool ret;
+
+	local_bh_disable();
+	ret = __iwl_trans_pcie_grab_nic_access(trans);
+	if (ret) {
+		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
+		return ret;
+	}
+	local_bh_enable();
+	return false;
+}
+
 static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 0346505351f5..4f6c187eed69 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -643,7 +643,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (!iwl_trans_grab_nic_access(trans))
+	if (!_iwl_trans_pcie_grab_nic_access(trans))
 		return -EIO;
 
 	/*
@@ -652,7 +652,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * already true, so it's OK to unconditionally set it to true.
 	 */
 	trans_pcie->cmd_hold_nic_awake = true;
-	spin_unlock_bh(&trans_pcie->reg_lock);
+	spin_unlock(&trans_pcie->reg_lock);
 
 	return 0;
 }
-- 
2.30.2



