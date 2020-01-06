Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9D130EF8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFIzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51392 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbgAFIzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:16 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAL-0007qa-S3; Mon, 06 Jan 2020 10:55:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:57 +0200
Message-Id: <20200106085502.363205-8-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 07/12] iwlwifi: incorporate firmware filename into version
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have many different firmware images with the same version,
and it's sometimes cumbersome to figure out which image was
really used, especially as the marketing strings that we do
print out can be the same for (slightly) different hardware
using different firmware images.

Incorporate the firmware filename into the fw_version so it's
printed out all the time. Unfortunately, this will make the
string be longer than the 32 characters for ethtool, but we
almost never really use ethtool, so strip the "iwlwifi-"
prefix (if not overridden), and the remaining data that may
then be stripped at the end is not usually useful anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 24 +++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 994880a83652..90ca5f929cf9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -251,7 +251,7 @@ struct iwl_fw_dbg {
 struct iwl_fw {
 	u32 ucode_ver;
 
-	char fw_version[ETHTOOL_FWVERS_LEN];
+	char fw_version[64];
 
 	/* ucode images */
 	struct fw_img img[IWL_UCODE_TYPE_MAX];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c6cb5e1a1bd9..773de0b724be 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -493,6 +493,16 @@ static void iwl_set_ucode_capabilities(struct iwl_drv *drv, const u8 *data,
 	}
 }
 
+static const char *iwl_reduced_fw_name(struct iwl_drv *drv)
+{
+	const char *name = drv->firmware_name;
+
+	if (strncmp(name, "iwlwifi-", 8) == 0)
+		name += 8;
+
+	return name;
+}
+
 static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 				    const struct firmware *ucode_raw,
 				    struct iwl_firmware_pieces *pieces)
@@ -551,12 +561,12 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 
 	snprintf(drv->fw.fw_version,
 		 sizeof(drv->fw.fw_version),
-		 "%u.%u.%u.%u%s",
+		 "%u.%u.%u.%u%s %s",
 		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
 		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
 		 IWL_UCODE_API(drv->fw.ucode_ver),
 		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
-		 buildstr);
+		 buildstr, iwl_reduced_fw_name(drv));
 
 	/* Verify size of file vs. image size info in file's header */
 
@@ -636,12 +646,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 	snprintf(drv->fw.fw_version,
 		 sizeof(drv->fw.fw_version),
-		 "%u.%u.%u.%u%s",
+		 "%u.%u.%u.%u%s %s",
 		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
 		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
 		 IWL_UCODE_API(drv->fw.ucode_ver),
 		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
-		 buildstr);
+		 buildstr, iwl_reduced_fw_name(drv));
 
 	data = ucode->data;
 
@@ -895,11 +905,13 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (major >= 35)
 				snprintf(drv->fw.fw_version,
 					 sizeof(drv->fw.fw_version),
-					"%u.%08x.%u", major, minor, local_comp);
+					"%u.%08x.%u %s", major, minor,
+					local_comp, iwl_reduced_fw_name(drv));
 			else
 				snprintf(drv->fw.fw_version,
 					 sizeof(drv->fw.fw_version),
-					"%u.%u.%u", major, minor, local_comp);
+					"%u.%u.%u %s", major, minor,
+					local_comp, iwl_reduced_fw_name(drv));
 			break;
 			}
 		case IWL_UCODE_TLV_FW_DBG_DEST: {
-- 
2.24.1

