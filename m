Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15645430788
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbhJQJmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53670 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245109AbhJQJmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eY-000YUg-GK; Sun, 17 Oct 2021 12:40:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:13 +0300
Message-Id: <iwlwifi.20211017123741.d1514964e6a7.I18f8c2ce8082952af7cfe5f8fe75fe51851b8853@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: mvm: scrub key material in firmware dumps
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the previously added infrastructure to scrub key material
in firmware dumps:
 * in the TX FIFO data, just search for each key that we
   know about and override such data
 * scrub various commands that we sent to the firmware if
   they're present
 * in firmware memory, where advertised by firmware TLVs

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 179 ++++++++++++++++++-
 1 file changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b7f203fe7753..3b0d5a068541 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -725,6 +725,183 @@ static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
 	return 0;
 }
 
+struct iwl_mvm_frob_txf_data {
+	u8 *buf;
+	size_t buflen;
+};
+
+static void iwl_mvm_frob_txf_key_iter(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      struct ieee80211_key_conf *key,
+				      void *data)
+{
+	struct iwl_mvm_frob_txf_data *txf = data;
+	u8 keylen, match, matchend;
+	u8 *keydata;
+	size_t i;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+		keydata = key->key;
+		keylen = key->keylen;
+		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	case WLAN_CIPHER_SUITE_TKIP:
+		/*
+		 * WEP has short keys which might show up in the payload,
+		 * and then you can deduce the key, so in this case just
+		 * remove all FIFO data.
+		 * For TKIP, we don't know the phase 2 keys here, so same.
+		 */
+		memset(txf->buf, 0xBB, txf->buflen);
+		return;
+	default:
+		return;
+	}
+
+	/* scan for key material and clear it out */
+	match = 0;
+	for (i = 0; i < txf->buflen; i++) {
+		if (txf->buf[i] != keydata[match]) {
+			match = 0;
+			continue;
+		}
+		match++;
+		if (match == keylen) {
+			memset(txf->buf + i - keylen, 0xAA, keylen);
+			match = 0;
+		}
+	}
+
+	/* we're dealing with a FIFO, so check wrapped around data */
+	matchend = match;
+	for (i = 0; match && i < keylen - match; i++) {
+		if (txf->buf[i] != keydata[match])
+			break;
+		match++;
+		if (match == keylen) {
+			memset(txf->buf, 0xAA, i + 1);
+			memset(txf->buf + txf->buflen - matchend, 0xAA,
+			       matchend);
+			break;
+		}
+	}
+}
+
+static void iwl_mvm_frob_txf(void *ctx, void *buf, size_t buflen)
+{
+	struct iwl_mvm_frob_txf_data txf = {
+		.buf = buf,
+		.buflen = buflen,
+	};
+	struct iwl_mvm *mvm = ctx;
+
+	/* embedded key material exists only on old API */
+	if (iwl_mvm_has_new_tx_api(mvm))
+		return;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(mvm->hw, NULL, iwl_mvm_frob_txf_key_iter, &txf);
+	rcu_read_unlock();
+}
+
+static void iwl_mvm_frob_hcmd(void *ctx, void *hcmd, size_t len)
+{
+	/* we only use wide headers for commands */
+	struct iwl_cmd_header_wide *hdr = hcmd;
+	unsigned int frob_start = sizeof(*hdr), frob_end = 0;
+
+	if (len < sizeof(hdr))
+		return;
+
+	/* all the commands we care about are in LONG_GROUP */
+	if (hdr->group_id != LONG_GROUP)
+		return;
+
+	switch (hdr->cmd) {
+	case WEP_KEY:
+	case WOWLAN_TKIP_PARAM:
+	case WOWLAN_KEK_KCK_MATERIAL:
+	case ADD_STA_KEY:
+		/*
+		 * blank out everything here, easier than dealing
+		 * with the various versions of the command
+		 */
+		frob_end = INT_MAX;
+		break;
+	case MGMT_MCAST_KEY:
+		frob_start = offsetof(struct iwl_mvm_mgmt_mcast_key_cmd, igtk);
+		BUILD_BUG_ON(offsetof(struct iwl_mvm_mgmt_mcast_key_cmd, igtk) !=
+			     offsetof(struct iwl_mvm_mgmt_mcast_key_cmd_v1, igtk));
+
+		frob_end = offsetofend(struct iwl_mvm_mgmt_mcast_key_cmd, igtk);
+		BUILD_BUG_ON(offsetof(struct iwl_mvm_mgmt_mcast_key_cmd, igtk) <
+			     offsetof(struct iwl_mvm_mgmt_mcast_key_cmd_v1, igtk));
+		break;
+	}
+
+	if (frob_start >= frob_end)
+		return;
+
+	if (frob_end > len)
+		frob_end = len;
+
+	memset((u8 *)hcmd + frob_start, 0xAA, frob_end - frob_start);
+}
+
+static void iwl_mvm_frob_mem(void *ctx, u32 mem_addr, void *mem, size_t buflen)
+{
+	const struct iwl_dump_exclude *excl;
+	struct iwl_mvm *mvm = ctx;
+	int i;
+
+	switch (mvm->fwrt.cur_fw_img) {
+	case IWL_UCODE_INIT:
+	default:
+		/* not relevant */
+		return;
+	case IWL_UCODE_REGULAR:
+	case IWL_UCODE_REGULAR_USNIFFER:
+		excl = mvm->fw->dump_excl;
+		break;
+	case IWL_UCODE_WOWLAN:
+		excl = mvm->fw->dump_excl_wowlan;
+		break;
+	}
+
+	BUILD_BUG_ON(sizeof(mvm->fw->dump_excl) !=
+		     sizeof(mvm->fw->dump_excl_wowlan));
+
+	for (i = 0; i < ARRAY_SIZE(mvm->fw->dump_excl); i++) {
+		u32 start, end;
+
+		if (!excl[i].addr || !excl[i].size)
+			continue;
+
+		start = excl[i].addr;
+		end = start + excl[i].size;
+
+		if (end <= mem_addr || start >= mem_addr + buflen)
+			continue;
+
+		if (start < mem_addr)
+			start = mem_addr;
+
+		if (end > mem_addr + buflen)
+			end = mem_addr + buflen;
+
+		memset((u8 *)mem + start - mem_addr, 0xAA, end - start);
+	}
+}
+
+static const struct iwl_dump_sanitize_ops iwl_mvm_sanitize_ops = {
+	.frob_txf = iwl_mvm_frob_txf,
+	.frob_hcmd = iwl_mvm_frob_hcmd,
+	.frob_mem = iwl_mvm_frob_mem,
+};
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -774,7 +951,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->hw = hw;
 
 	iwl_fw_runtime_init(&mvm->fwrt, trans, fw, &iwl_mvm_fwrt_ops, mvm,
-			    NULL, NULL, dbgfs_dir);
+			    &iwl_mvm_sanitize_ops, mvm, dbgfs_dir);
 
 	iwl_mvm_get_acpi_tables(mvm);
 
-- 
2.33.0

