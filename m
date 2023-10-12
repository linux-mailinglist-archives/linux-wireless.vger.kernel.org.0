Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58E7C6FEC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjJLOC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjJLOC4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 10:02:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09FC4
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 07:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C4C433C7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697119374;
        bh=c6Oxp4lb2zkqfrJQLR6JW+PwlrYWb3MMT6NSedmS1ns=;
        h=From:To:Subject:Date:From;
        b=EJ/JFIApS+FTTSVBdcuAQ0unDX+jO4x/AAYghNHXc3AWBPGA9uW9eQI58m3Czx9Ln
         OgIE/HzSw6ENhhxmfKE8H8QjfsAmmeedm1Wm1iVM9Hp8Smfch9a0JZqdmLuSGz1cOi
         i5gQzUaHqtlrcwsNTnRCpmGr3ckVDtAgGftxnRt8b30uIl7O4N3EgjaTOTXLPn8LzB
         nLwxHe8X4Ml6lyWKA8VIgRTtliOKIJbsl6FLpayAv2bw2q/0UqdTpTSTGJK5CBO8nx
         MguX7rq+YRPfb4OwnucseypFsgw1ytfsDuKmAWZJLvWSvQvJhFgqzGsKd/ae+ue22x
         6MlR2ArHClhpA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH RFC] wifi: iwlwifi: fix format-truncation warnings
Date:   Thu, 12 Oct 2023 17:02:51 +0300
Message-Id: <20231012140251.3473708-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On v6.6-rc4 with GCC 13.2 I see:

drivers/net/wireless/intel/iwlwifi/dvm/main.c:1467:19: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/dvm/main.c:1465:9: note: 'snprintf' output between 1 and 64 bytes into a destination of size 32
drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1307:19: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1305:9: note: 'snprintf' output between 1 and 64 bytes into a destination of size 32
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:549:33: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 48 and 56 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:547:9: note: 'snprintf' output 9 or more bytes (assuming 80) into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:729:33: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 48 and 56 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:727:9: note: 'snprintf' output 9 or more bytes (assuming 80) into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:989:51: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 46 and 58 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:987:33: note: 'snprintf' output between 7 and 82 bytes into a destination of size 64
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:984:53: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 40 and 50 [-Wformat-truncation=]
drivers/net/wireless/intel/iwlwifi/iwl-drv.c:982:33: note: 'snprintf' output between 15 and 88 bytes into a destination of size 64

Two of the warnings were easy to fix by using strscpy(). But the rest were more
challening. For now I was only able to come up with artificial testing of
snprintf() return value but that doesn't make really sense. I marked the ugly
once "FIXME" in the code.

Any ideas how to fix the warnings properly?

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 64 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +-
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index a873be109f43..6b252f19b641 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1462,9 +1462,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	iwl_power_initialize(priv);
 	iwl_tt_initialize(priv);
 
-	snprintf(priv->hw->wiphy->fw_version,
-		 sizeof(priv->hw->wiphy->fw_version),
-		 "%s", fw->fw_version);
+	strscpy(priv->hw->wiphy->fw_version, fw->fw_version,
+		sizeof(priv->hw->wiphy->fw_version));
 
 	priv->new_scan_threshold_behaviour =
 		!!(ucode_flags & IWL_UCODE_TLV_FLAGS_NEWSCAN);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index fb5e254757e7..85cb7ad604d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -496,6 +496,7 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 	u32 api_ver, hdr_size, build;
 	char buildstr[25];
 	const u8 *src;
+	int len;
 
 	drv->fw.ucode_ver = le32_to_cpu(ucode->ver);
 	api_ver = IWL_UCODE_API(drv->fw.ucode_ver);
@@ -544,14 +545,16 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 	else
 		buildstr[0] = '\0';
 
-	snprintf(drv->fw.fw_version,
-		 sizeof(drv->fw.fw_version),
-		 "%u.%u.%u.%u%s %s",
-		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
-		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
-		 IWL_UCODE_API(drv->fw.ucode_ver),
-		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
-		 buildstr, iwl_reduced_fw_name(drv));
+	len = snprintf(drv->fw.fw_version,
+		       sizeof(drv->fw.fw_version),
+		       "%u.%u.%u.%u%s %s",
+		       IWL_UCODE_MAJOR(drv->fw.ucode_ver),
+		       IWL_UCODE_MINOR(drv->fw.ucode_ver),
+		       IWL_UCODE_API(drv->fw.ucode_ver),
+		       IWL_UCODE_SERIAL(drv->fw.ucode_ver),
+		       buildstr, iwl_reduced_fw_name(drv));
+	if (len)
+		printk("FIXME");
 
 	/* Verify size of file vs. image size info in file's header */
 
@@ -700,7 +703,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	const u8 *tlv_data;
 	char buildstr[25];
 	u32 build, paging_mem_size;
-	int num_of_cpus;
+	int num_of_cpus, l;
 	bool usniffer_req = false;
 
 	if (len < sizeof(*ucode)) {
@@ -724,14 +727,16 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	else
 		buildstr[0] = '\0';
 
-	snprintf(drv->fw.fw_version,
-		 sizeof(drv->fw.fw_version),
-		 "%u.%u.%u.%u%s %s",
-		 IWL_UCODE_MAJOR(drv->fw.ucode_ver),
-		 IWL_UCODE_MINOR(drv->fw.ucode_ver),
-		 IWL_UCODE_API(drv->fw.ucode_ver),
-		 IWL_UCODE_SERIAL(drv->fw.ucode_ver),
-		 buildstr, iwl_reduced_fw_name(drv));
+	l = snprintf(drv->fw.fw_version,
+		       sizeof(drv->fw.fw_version),
+		       "%u.%u.%u.%u%s %s",
+		       IWL_UCODE_MAJOR(drv->fw.ucode_ver),
+		       IWL_UCODE_MINOR(drv->fw.ucode_ver),
+		       IWL_UCODE_API(drv->fw.ucode_ver),
+		       IWL_UCODE_SERIAL(drv->fw.ucode_ver),
+		       buildstr, iwl_reduced_fw_name(drv));
+	if (l)
+		printk("FIXME");
 
 	data = ucode->data;
 
@@ -978,16 +983,21 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			minor = le32_to_cpup(ptr++);
 			local_comp = le32_to_cpup(ptr);
 
-			if (major >= 35)
-				snprintf(drv->fw.fw_version,
-					 sizeof(drv->fw.fw_version),
-					"%u.%08x.%u %s", major, minor,
-					local_comp, iwl_reduced_fw_name(drv));
-			else
-				snprintf(drv->fw.fw_version,
-					 sizeof(drv->fw.fw_version),
-					"%u.%u.%u %s", major, minor,
-					local_comp, iwl_reduced_fw_name(drv));
+			if (major >= 35) {
+				l = snprintf(drv->fw.fw_version,
+					     sizeof(drv->fw.fw_version),
+					     "%u.%08x.%u %s", major, minor,
+					     local_comp, iwl_reduced_fw_name(drv));
+				if (l)
+					printk("FIXME");
+			} else {
+				l = snprintf(drv->fw.fw_version,
+					     sizeof(drv->fw.fw_version),
+					     "%u.%u.%u %s", major, minor,
+					     local_comp, iwl_reduced_fw_name(drv));
+				if (l)
+					printk("FIXME");
+			}
 			break;
 			}
 		case IWL_UCODE_TLV_FW_DBG_DEST: {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 465090f67aaf..3864aaf7c1ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1302,9 +1302,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.cmd_q_wdg_timeout =
 		iwl_mvm_get_wd_timeout(mvm, NULL, false, true);
 
-	snprintf(mvm->hw->wiphy->fw_version,
-		 sizeof(mvm->hw->wiphy->fw_version),
-		 "%s", fw->fw_version);
+	strscpy(mvm->hw->wiphy->fw_version, fw->fw_version,
+		sizeof(mvm->hw->wiphy->fw_version));
 
 	trans_cfg.fw_reset_handshake = fw_has_capa(&mvm->fw->ucode_capa,
 						   IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);

base-commit: 618071ae0f7e8c1aeb9b1b1e9ee876bcc3f045fc
-- 
2.39.2

