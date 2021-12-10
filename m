Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62746FB17
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhLJHKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50858 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231790AbhLJHKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:09 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzF-001F9v-PC; Fri, 10 Dec 2021 09:06:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:21 +0200
Message-Id: <iwlwifi.20211210090244.3c851b93aef5.I346fa2e1d79220a6770496e773c6f87a2ad9e6c4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/11] iwlwifi: mvm: Increase the scan timeout guard to 30 seconds
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

With the introduction of 6GHz channels the scan guard timeout should
be adjusted to account for the following extreme case:

- All 6GHz channels are scanned passively: 58 channels.
- The scan is fragmented with the following parameters: 3 fragments,
  95 TUs suspend time, 44 TUs maximal out of channel time.

The above would result with scan time of more than 24 seconds. Thus,
set the timeout to 30 seconds.

Cc: stable@vger.kernel.org
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 54ec5eb6c763..693afd78bc66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2513,7 +2513,7 @@ static int iwl_mvm_check_running_scans(struct iwl_mvm *mvm, int type)
 	return -EIO;
 }
 
-#define SCAN_TIMEOUT 20000
+#define SCAN_TIMEOUT 30000
 
 void iwl_mvm_scan_timeout_wk(struct work_struct *work)
 {
-- 
2.34.1

