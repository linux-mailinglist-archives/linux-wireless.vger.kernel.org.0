Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD93CD444
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhGSLVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhGSLVW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 07:21:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9917C061574
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=7+LS3y5wbzz6LyqpW5/kCC11RLc/TklJi8Xzn16wtwY=; t=1626696122; x=1627905722; 
        b=K9URTtWGL35vqzKDrZFddCMUECQFoY6rRPcALBrjoBb6gp1rIuwYQYRRI5hNswl2hjO30sBOFbk
        s7KRsqe3/cmGa4Fp8lq1w2Rt9QEqLA6SUXRLREnKnOoHZ6dbbXQQzBMNxapspLiEWyBzSi6nsP93i
        2CRfYNtynKSuz/CmfWbCDI1MlGzWJ7uAxn9tWdevWtGVi1wBP6N31QMciBAthq6hvyF4pJQGaLpLK
        ajpCjNqLUMlwQ+3UP7ljoF55RpuhcjClQCenSt8nhzJ3Q2hzKgg5y9r+Kpak85lmN6Nr/HQ1zeB5k
        0OwCRHOTyvJVnd8cgogFM0wx+fbrUb23qqZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m5RyC-004Lkt-1X; Mon, 19 Jul 2021 14:02:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.14] iwlwifi: pnvm: accept multiple HW-type TLVs
Date:   Mon, 19 Jul 2021 14:01:56 +0200
Message-Id: <20210719140154.a6a86e903035.Ic0b1b75c45d386698859f251518e8a5144431938@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some products (So) may have two different types of products
with different mac-type that are otherwise equivalent, and
have the same PNVM data, so the PNVM file will contain two
(or perhaps later more) HW-type TLVs. Accept the file and
use the data section that contains any matching entry.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 25 +++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 2403490cbc26..b4b1f75b9c2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -37,6 +37,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 	u32 sha1 = 0;
 	u16 mac_type = 0, rf_id = 0;
 	u8 *pnvm_data = NULL, *tmp;
+	bool hw_match = false;
 	u32 size = 0;
 	int ret;
 
@@ -83,6 +84,9 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 				break;
 			}
 
+			if (hw_match)
+				break;
+
 			mac_type = le16_to_cpup((__le16 *)data);
 			rf_id = le16_to_cpup((__le16 *)(data + sizeof(__le16)));
 
@@ -90,15 +94,9 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 				     "Got IWL_UCODE_TLV_HW_TYPE mac_type 0x%0x rf_id 0x%0x\n",
 				     mac_type, rf_id);
 
-			if (mac_type != CSR_HW_REV_TYPE(trans->hw_rev) ||
-			    rf_id != CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
-				IWL_DEBUG_FW(trans,
-					     "HW mismatch, skipping PNVM section, mac_type 0x%0x, rf_id 0x%0x.\n",
-					     CSR_HW_REV_TYPE(trans->hw_rev), trans->hw_rf_id);
-				ret = -ENOENT;
-				goto out;
-			}
-
+			if (mac_type == CSR_HW_REV_TYPE(trans->hw_rev) &&
+			    rf_id == CSR_HW_RFID_TYPE(trans->hw_rf_id))
+				hw_match = true;
 			break;
 		case IWL_UCODE_TLV_SEC_RT: {
 			struct iwl_pnvm_section *section = (void *)data;
@@ -149,6 +147,15 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 	}
 
 done:
+	if (!hw_match) {
+		IWL_DEBUG_FW(trans,
+			     "HW mismatch, skipping PNVM section (need mac_type 0x%x rf_id 0x%x)\n",
+			     CSR_HW_REV_TYPE(trans->hw_rev),
+			     CSR_HW_RFID_TYPE(trans->hw_rf_id));
+		ret = -ENOENT;
+		goto out;
+	}
+
 	if (!size) {
 		IWL_DEBUG_FW(trans, "Empty PNVM, skipping.\n");
 		ret = -ENOENT;
-- 
2.31.1

