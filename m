Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14EB300389
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhAVMyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 07:54:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:41660 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727472AbhAVMyE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 07:54:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l2vvk-003vnH-F2; Fri, 22 Jan 2021 14:52:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Jan 2021 14:52:41 +0200
Message-Id: <iwlwifi.20210122144849.871f0892e4b2.I94819e11afd68d875f3e242b98bef724b8236f1e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122125242.107146-1-luca@coelho.fi>
References: <20210122125242.107146-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 6/7] iwlwifi: mvm: guard against device removal in reprobe
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we get into a problem severe enough to attempt a reprobe,
we schedule a worker to do that. However, if the problem gets
more severe and the device is actually destroyed before this
worker has a chance to run, we use a free device. Bump up the
reference count of the device until the worker runs to avoid
this situation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 03b41d911338..61618f607927 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1209,6 +1209,7 @@ static void iwl_mvm_reprobe_wk(struct work_struct *wk)
 	reprobe = container_of(wk, struct iwl_mvm_reprobe, work);
 	if (device_reprobe(reprobe->dev))
 		dev_err(reprobe->dev, "reprobe failed!\n");
+	put_device(reprobe->dev);
 	kfree(reprobe);
 	module_put(THIS_MODULE);
 }
@@ -1259,7 +1260,7 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 			module_put(THIS_MODULE);
 			return;
 		}
-		reprobe->dev = mvm->trans->dev;
+		reprobe->dev = get_device(mvm->trans->dev);
 		INIT_WORK(&reprobe->work, iwl_mvm_reprobe_wk);
 		schedule_work(&reprobe->work);
 	} else if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-- 
2.29.2

