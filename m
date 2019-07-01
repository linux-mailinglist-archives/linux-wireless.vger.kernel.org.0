Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D705C11A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGAQ2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 12:28:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAQ2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 12:28:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hhz9r-00038a-9G; Mon, 01 Jul 2019 16:27:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Haim Dreyfuss <haim.dreyfuss@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] iwlwifi: mvm: fix comparison of u32 variable with less than zero
Date:   Mon,  1 Jul 2019 17:27:59 +0100
Message-Id: <20190701162759.15418-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of the u32 variable wgds_tbl_idx with less than zero is
always going to be false because it is unsigned.  Fix this by making
wgds_tbl_idx a plain signed int.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 4fd445a2c855 ("iwlwifi: mvm: Add log information about SAR status")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 719f793b3487..a9bb43a2f27b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -620,7 +620,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 	enum iwl_mcc_source src;
 	char mcc[3];
 	struct ieee80211_regdomain *regd;
-	u32 wgds_tbl_idx;
+	int wgds_tbl_idx;
 
 	lockdep_assert_held(&mvm->mutex);
 
-- 
2.20.1

