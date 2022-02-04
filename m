Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5E4A97B3
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358311AbiBDKZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:26 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37968 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1357055AbiBDKZY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:24 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmM-0005zM-6z;
        Fri, 04 Feb 2022 12:25:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:07 +0200
Message-Id: <iwlwifi.20220204122220.2150362427bd.I47a47d0f795dc08361958833b8235ab5de75d154@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/12] iwlwifi: eeprom: clean up macros
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are two versions of the same definitions, with and without
IWL_ prefix. Use the ones with IWL_ prefix, keeping the correct
comment (microseconds).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index b9e86bf972e5..5f386bb1a353 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -23,26 +23,22 @@
  */
 #define IWL_EEPROM_ACCESS_TIMEOUT	5000 /* uSec */
 
-#define IWL_EEPROM_SEM_TIMEOUT		10   /* microseconds */
-#define IWL_EEPROM_SEM_RETRY_LIMIT	1000 /* number of attempts (not time) */
-
-
 /*
  * The device's EEPROM semaphore prevents conflicts between driver and uCode
  * when accessing the EEPROM; each access is a series of pulses to/from the
  * EEPROM chip, not a single event, so even reads could conflict if they
  * weren't arbitrated by the semaphore.
  */
+#define IWL_EEPROM_SEM_TIMEOUT		10   /* microseconds */
+#define IWL_EEPROM_SEM_RETRY_LIMIT	1000 /* number of attempts (not time) */
 
-#define	EEPROM_SEM_TIMEOUT 10		/* milliseconds */
-#define EEPROM_SEM_RETRY_LIMIT 1000	/* number of attempts (not time) */
 
 static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 {
 	u16 count;
 	int ret;
 
-	for (count = 0; count < EEPROM_SEM_RETRY_LIMIT; count++) {
+	for (count = 0; count < IWL_EEPROM_SEM_RETRY_LIMIT; count++) {
 		/* Request semaphore */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM);
@@ -51,7 +47,7 @@ static int iwl_eeprom_acquire_semaphore(struct iwl_trans *trans)
 		ret = iwl_poll_bit(trans, CSR_HW_IF_CONFIG_REG,
 				CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM,
 				CSR_HW_IF_CONFIG_REG_BIT_EEPROM_OWN_SEM,
-				EEPROM_SEM_TIMEOUT);
+				IWL_EEPROM_SEM_TIMEOUT);
 		if (ret >= 0) {
 			IWL_DEBUG_EEPROM(trans->dev,
 					 "Acquired semaphore after %d tries.\n",
-- 
2.34.1

