Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4267D602
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfHAHEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 03:04:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53982 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfHAHEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 03:04:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ht58k-0007bG-LH; Thu, 01 Aug 2019 09:04:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mauro Rossi <issor.oruam@gmail.com>
Subject: [PATCH] iwlwifi: dbg_ini: fix compile time assert build errors
Date:   Thu,  1 Aug 2019 09:04:34 +0200
Message-Id: <20190801070436.6588-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mauro Rossi <issor.oruam@gmail.com>

This patch fixes and preserves existing code style, and readability,
for IWL_ERR() and IWL_WARN() macros invocations recently added in dbg.c

Fixes the following build errors with Android build system:

/home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c: In function '_iwl_fw_dbg_apply_point':
/home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2445:3:
error: call to '__compiletime_assert_2446' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
/home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2451:3:
error: call to '__compiletime_assert_2452' declared with attribute error: BUILD_BUG_ON failed: err_str[sizeof(err_str) - 2] != '\n'
...
/home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2789:5:
error: call to '__compiletime_assert_2790' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'
/home/utente/pie-x86_kernel/kernel/drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2800:5:
error: call to '__compiletime_assert_2801' declared with attribute error: BUILD_BUG_ON failed: invalid_ap_str[sizeof(invalid_ap_str) - 2] != '\n'

Fixes: 427ab6385cf3 ("iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv")
Fixes: 57d88b116175 ("iwlwifi: dbg_ini: support debug info TLV")
Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 22 +++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index e411ac98290d..4d81776f576d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2438,17 +2438,19 @@ static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
 {
 	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
 	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
-	const char err_str[] =
-		"WRT: ext=%d. Invalid %s name length %d, expected %d\n";
 
 	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
-		IWL_WARN(fwrt, err_str, ext, "image", img_name_len,
+		IWL_WARN(fwrt,
+			 "WRT: ext=%d. Invalid image name length %d, expected %d\n",
+			 ext, img_name_len,
 			 IWL_FW_INI_MAX_IMG_NAME_LEN);
 		return;
 	}
 
 	if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
-		IWL_WARN(fwrt, err_str, ext, "debug cfg", dbg_cfg_name_len,
+		IWL_WARN(fwrt,
+			 "WRT: ext=%d. Invalid debug cfg name length %d, expected %d\n",
+			 ext, dbg_cfg_name_len,
 			 IWL_FW_INI_MAX_DBG_CFG_NAME_LEN);
 		return;
 	}
@@ -2775,8 +2777,6 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		struct iwl_ucode_tlv *tlv = iter;
 		void *ini_tlv = (void *)tlv->data;
 		u32 type = le32_to_cpu(tlv->type);
-		const char invalid_ap_str[] =
-			"WRT: ext=%d. Invalid apply point %d for %s\n";
 
 		switch (type) {
 		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
@@ -2786,8 +2786,9 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			struct iwl_fw_ini_allocation_data *buf_alloc = ini_tlv;
 
 			if (pnt != IWL_FW_INI_APPLY_EARLY) {
-				IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
-					"buffer allocation");
+				IWL_ERR(fwrt,
+					"WRT: ext=%d. Invalid apply point %d for buffer allocation\n",
+					ext, pnt);
 				goto next;
 			}
 
@@ -2797,8 +2798,9 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		}
 		case IWL_UCODE_TLV_TYPE_HCMD:
 			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
-				IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
-					"host command");
+				IWL_ERR(fwrt,
+					"WRT: ext=%d. Invalid apply point %d for host command\n",
+					ext, pnt);
 				goto next;
 			}
 			iwl_fw_dbg_send_hcmd(fwrt, tlv, ext);
-- 
2.20.1

