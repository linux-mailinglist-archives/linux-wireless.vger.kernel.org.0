Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E231C99D6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgEGSvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 14:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgEGSvN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 14:51:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57D424959;
        Thu,  7 May 2020 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877472;
        bh=oH8LQB6ff7nQSBfFV1e2P1jvW2eA3yAZZHUuknmcRH0=;
        h=Date:From:To:Cc:Subject:From;
        b=SsK1tPP7W2kSwbjdHa5jS5rf4osDLaHwaGr+e7U7/JRoj8Y1lQYdMsWQXx5hNQeoN
         Obtx1eGFNxukn1wgIvpeSJB9grKzxdHthFm1lyJtvoJbyJeDlvZmc6zC2ZRqbeFRP6
         3mXY2tKZgX+qSBxSL1QZ+i23/HwC86kV1RJYZ/zA=
Date:   Thu, 7 May 2020 13:55:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: Replace zero-length array with flexible-array
Message-ID: <20200507185538.GA14674@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h   |   12 ++++++------
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h |    4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h    |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h      |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 0f4be4be181c..fdcc1292a92b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -1023,7 +1023,7 @@ struct iwl_wep_cmd {
 	u8 global_key_type;
 	u8 flags;
 	u8 reserved;
-	struct iwl_wep_key key[0];
+	struct iwl_wep_key key[];
 } __packed;
 
 #define WEP_KEY_WEP_TYPE 1
@@ -1305,7 +1305,7 @@ struct iwl_tx_cmd {
 	 * length is 26 or 30 bytes, followed by payload data
 	 */
 	u8 payload[0];
-	struct ieee80211_hdr hdr[0];
+	struct ieee80211_hdr hdr[];
 } __packed;
 
 /*
@@ -2380,7 +2380,7 @@ struct iwl_scan_cmd {
 	 * for one scan to complete (i.e. receive SCAN_COMPLETE_NOTIFICATION)
 	 * before requesting another scan.
 	 */
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /* Can abort will notify by complete notification with abort status. */
@@ -2475,7 +2475,7 @@ struct iwl_tx_beacon_cmd {
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
-	struct ieee80211_hdr frame[0];	/* beacon frame */
+	struct ieee80211_hdr frame[];	/* beacon frame */
 } __packed;
 
 /******************************************************************************
@@ -3188,7 +3188,7 @@ struct iwl_calib_hdr {
 
 struct iwl_calib_cmd {
 	struct iwl_calib_hdr hdr;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct iwl_calib_xtal_freq_cmd {
@@ -3216,7 +3216,7 @@ struct iwl_calib_temperature_offset_v2_cmd {
 /* IWL_PHY_CALIBRATE_CHAIN_NOISE_RESET_CMD */
 struct iwl_calib_chain_noise_reset_cmd {
 	struct iwl_calib_hdr hdr;
-	u8 data[0];
+	u8 data[];
 };
 
 /* IWL_PHY_CALIBRATE_CHAIN_NOISE_GAIN_CMD */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 97b49843e318..397ac89a04c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -351,7 +351,7 @@ struct iwl_mcc_update_resp_v3 {
 	__le16 time;
 	__le16 geo_info;
 	__le32 n_channels;
-	__le32 channels[0];
+	__le32 channels[];
 } __packed; /* LAR_UPDATE_MCC_CMD_RESP_S_VER_3 */
 
 /**
@@ -380,7 +380,7 @@ struct iwl_mcc_update_resp {
 	u8 source_id;
 	u8 reserved[3];
 	__le32 n_channels;
-	__le32 channels[0];
+	__le32 channels[];
 } __packed; /* LAR_UPDATE_MCC_CMD_RESP_S_VER_4 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 89f74116569d..cc1d93606d9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -261,7 +261,7 @@ struct hcmd_write_data {
 	__be32 cmd_id;
 	__be32 flags;
 	__be16 length;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 3008a5246be8..b35b8920941b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -175,7 +175,7 @@ void iwl_opmode_deregister(const char *name);
 struct iwl_op_mode {
 	const struct iwl_op_mode_ops *ops;
 
-	char op_mode_specific[0] __aligned(sizeof(void *));
+	char op_mode_specific[] __aligned(sizeof(void *));
 };
 
 static inline void iwl_op_mode_stop(struct iwl_op_mode *op_mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index bba527b339b5..3fbbbac0953d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -878,7 +878,7 @@ struct iwl_trans {
 
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
-	char trans_specific[0] __aligned(sizeof(void *));
+	char trans_specific[] __aligned(sizeof(void *));
 };
 
 const char *iwl_get_cmd_string(struct iwl_trans *trans, u32 id);

