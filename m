Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38E46FB14
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhLJHKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:07 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50840 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233193AbhLJHKH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:07 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzD-001F9v-1t; Fri, 10 Dec 2021 09:06:31 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:18 +0200
Message-Id: <iwlwifi.20211210090244.6f2fca102739.I8b5e37a00c50b7b51f7d377216dde91e71faffba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/11] iwlwifi: mvm: rfi: update rfi table
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

After some lab experimentation with different DDRs, need
to update the table. Also, arrange it by frequency and not
by DDR type since now the table contains a super-set of all
possible conflicts.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 46 ++++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index f1ed73c9f3dd..f054ce76bed5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -12,34 +12,52 @@
  * frequency values in the adjusted format.
  */
 static const struct iwl_rfi_lut_entry iwl_rfi_table[IWL_RFI_LUT_SIZE] = {
-	/* LPDDR4 */
+	/* frequency 2667MHz */
+	{cpu_to_le16(160), {50, 58, 60, 62, 64, 52, 54, 56},
+	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+	       PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 2933MHz */
+	{cpu_to_le16(176), {149, 151, 153, 157, 159, 161, 165, 163, 167, 169,
+			    171, 173, 175},
+	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+	       PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+	       PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 3200MHz */
+	{cpu_to_le16(192), {79, 81, 83, 85, 87, 89, 91, 93},
+	      {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
+	       PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,}},
 
 	/* frequency 3733MHz */
-	{cpu_to_le16(223), {114, 116, 118, 120, 122,},
-	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+	{cpu_to_le16(223), {114, 116, 118, 120, 122, 106, 110, 124, 126},
+	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+	       PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 4000MHz */
+	{cpu_to_le16(240), {114, 151, 155, 157, 159, 161, 165},
+	      {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+	       PHY_BAND_5, PHY_BAND_5,}},
 
 	/* frequency 4267MHz */
 	{cpu_to_le16(256), {79, 83, 85, 87, 89, 91, 93,},
 	       {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
 		PHY_BAND_6, PHY_BAND_6,}},
 
-	/* DDR5ePOR */
-
-	/* frequency 4000MHz */
-	{cpu_to_le16(240), {3, 5, 7, 9, 11, 13, 15,},
-	      {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
-	       PHY_BAND_6, PHY_BAND_6,}},
-
 	/* frequency 4400MHz */
 	{cpu_to_le16(264), {111, 119, 123, 125, 129, 131, 133, 135, 143,},
 	      {PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,
 	       PHY_BAND_6, PHY_BAND_6, PHY_BAND_6, PHY_BAND_6,}},
 
-	/* LPDDR5iPOR */
-
 	/* frequency 5200MHz */
-	{cpu_to_le16(312), {36, 38, 40, 42, 50,},
-	       {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
+	{cpu_to_le16(312), {36, 38, 40, 42, 44, 46, 50,},
+	       {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+		PHY_BAND_5, PHY_BAND_5,}},
+
+	/* frequency 5600MHz */
+	{cpu_to_le16(336), {106, 110, 112, 114, 116, 118, 120, 122},
+	       {PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,
+		PHY_BAND_5, PHY_BAND_5, PHY_BAND_5,}},
 
 	/* frequency 6000MHz */
 	{cpu_to_le16(360), {3, 5, 7, 9, 11, 13, 15,},
-- 
2.34.1

