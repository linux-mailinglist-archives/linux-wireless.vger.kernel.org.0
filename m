Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D890720ADC
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjFBVKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBVKj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 17:10:39 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399919B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 14:10:36 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AAF79B0007B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 21:10:34 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id DF39213C2B0;
        Fri,  2 Jun 2023 14:10:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DF39213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1685740234;
        bh=Or6uVmWw0aUXzaGAySiY4FyXq0oTCwAUtq4c1lzr5cA=;
        h=From:To:Cc:Subject:Date:From;
        b=kL+4fwkTmofWCrtvaTyh9NamxTGecT4jdYcqaY1W+lbtxcbF9+p3BzDQ6dlmJtivA
         MtT9zSxC3itPFT6V7xay7GDD7wXFcpgmJZATb52In90bhdQkClHfQ71uiqatabx4T8
         iJL6Snq2YzKPlTY4zULNdPIXLU8j04pkr0F5ws5A=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] wifi: iwlwifi: Add support for tx-override feature
Date:   Fri,  2 Jun 2023 14:10:32 -0700
Message-Id: <20230602211032.3914969-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1685740235-zI8cznt_ic_F
X-MDID-O: us5;at1;1685740235;zI8cznt_ic_F;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets user-space request specific rates for 400+ byte dataframes,
used for testing tx and rx sensitivity and correctness.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Fix problems with tx-antenna configuration.
  Use RCU to hold the txo object.  I have not much used RCU before, this
  part could use some careful review.

 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 157 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  19 +++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 137 +++++++++++++--
 3 files changed, 303 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 26ff8e234ff2..9d25cf93477f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2546,6 +2546,160 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 MVM_DEBUGFS_WRITE_FILE_OPS(ltr_config, 512);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rfi_freq_table, 16);
 
+static ssize_t iwl_dbgfs_read_set_rate_override(struct file *file,
+						char __user *user_buf,
+						size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_txo_data *td;
+	char *buf2;
+	int size = 8000;
+	int rv, sofar;
+	const char buf[] =
+		"This allows specifying tx rate parameters for larger DATA\n"
+		"frames.  TPC is ignored for now.  Dev-name is ignored, settings\n"
+		"apply radio wide for now.\n"
+		"To set a value, you specify the dev-name and key-value pairs:\n"
+		"tpc=10 sgi=1 mcs=x nss=x pream=x retries=x bw=x enable=0|1\n"
+		"pream: 0=cck, 1=ofdm, 2=HT, 3=VHT, 4=HE_SU, 5=EHT\n"
+		"cck-mcs: 0=1Mbps, 1=2Mbps, 3=5.5Mbps, 3=11Mbps\n"
+		"ofdm-mcs: 0=6Mbps, 1=9Mbps, 2=12Mbps, 3=18Mbps, 4=24Mbps, 5=36Mbps, 6=48Mbps, 7=54Mbps\n"
+		"tpc: adjust power from defaults, in 1/2 db units 0 - 31, 16 is default\n"
+		"sgi: VHT and lower: 0 off, 1 on\n"
+		"sgi: HE-SU: 0 1xLTF+0.8us, 1 2xLTF+0.8us, 2 2xLTF+1.6us, 3 4xLTF+3.2us, 4 4xLTF+0.8us\n"
+		"bw is 0-4 for 20-320\n"
+		"nss is zero based (0 means nss-1, 1 means nss-2)\n"
+		" For example, wlan0:\n"
+		"echo \"wlan0 tpc=255 sgi=1 mcs=0 nss=1 pream=3 retries=1 bw=0"
+		" active=1\" > ...iwlwifi/set_rate_override\n";
+
+	buf2 = kzalloc(size, GFP_KERNEL);
+	if (!buf2)
+		return -ENOMEM;
+	strcpy(buf2, buf);
+	sofar = strlen(buf2);
+
+	rcu_read_lock();
+	td = rcu_dereference(mvm->txo_data);
+	if (td)
+		sofar += scnprintf(buf2 + sofar, size - sofar,
+				   "vdev (all) active=%d tpc=%d sgi=%d mcs=%d nss=%d pream=%d retries=%d bw=%d\n",
+				   td->txo_active, td->tx_power,
+				   td->tx_rate_sgi, td->tx_rate_idx,
+				   td->tx_rate_nss, td->tx_rate_mode,
+				   td->tx_xmit_count, td->txbw);
+	else
+		sofar += scnprintf(buf2 + sofar, size - sofar,
+				   "No TXO values set.\n");
+	rcu_read_unlock();
+
+	rv = simple_read_from_buffer(user_buf, count, ppos, buf2, sofar);
+	kfree(buf2);
+	return rv;
+}
+
+/* Set the rate overrides for data frames.
+ */
+static ssize_t iwl_dbgfs_write_set_rate_override(struct file *file,
+						 const char __user *user_buf,
+						 size_t count, loff_t *ppos)
+{
+	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_txo_data *td = kzalloc(sizeof(*td), GFP_KERNEL);
+	struct iwl_txo_data *prev_td;
+	char buf[180];
+	char tmp[20];
+	char *tok;
+	int ret;
+	char *bufptr = buf;
+	long rc;
+
+	if (!td) {
+		ret = 0;
+		goto exit;
+	}
+
+	memset(buf, 0, sizeof(buf));
+
+	simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+
+	/* make sure that buf is null terminated */
+	buf[sizeof(buf) - 1] = 0;
+
+	/* drop the possible '\n' from the end */
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = 0;
+
+	/* Ignore empty lines, 'echo' appends them sometimes at least. */
+	if (buf[0] == 0) {
+		ret = count;
+		kfree(td);
+		goto exit;
+	}
+
+	/* String starts with vdev name, ie 'wlan0'  Find the proper vif that
+	 * matches the name. (Well, ignore that for now actually.)
+	 */
+	bufptr = strstr(buf, " ");
+	if (bufptr)
+		bufptr++; /* move past space */
+
+#define IWLWIFI_PARSE_LTOK(a, b)						\
+	do {								\
+		tok = strstr(bufptr, " " #a "=");			\
+		if (tok) {						\
+			char *tspace;					\
+			tok += 1; /* move past initial space */		\
+			strncpy(tmp, tok + strlen(#a "="), sizeof(tmp) - 1); \
+			tmp[sizeof(tmp) - 1] = 0;			\
+			tspace = strstr(tmp, " ");			\
+			if (tspace)					\
+				*tspace = 0;				\
+			if (kstrtol(tmp, 0, &rc) != 0)			\
+				pr_info(				\
+					"mt7915: set-rate-override: " #a \
+					"= could not be parsed, tmp: %s\n", \
+					tmp);				\
+			else						\
+				td->b = rc;				\
+		}							\
+	} while (0)
+
+	IWLWIFI_PARSE_LTOK(tpc, tx_power);
+	IWLWIFI_PARSE_LTOK(sgi, tx_rate_sgi);
+	IWLWIFI_PARSE_LTOK(mcs, tx_rate_idx);
+	IWLWIFI_PARSE_LTOK(nss, tx_rate_nss);
+	IWLWIFI_PARSE_LTOK(pream, tx_rate_mode);
+	IWLWIFI_PARSE_LTOK(retries, tx_xmit_count);
+	IWLWIFI_PARSE_LTOK(bw, txbw);
+	IWLWIFI_PARSE_LTOK(active, txo_active);
+
+	pr_info("iwlwifi: set-rate-overrides, active=%d tpc=%d sgi=%d mcs=%d nss=%d pream=%d retries=%d bw=%d\n",
+		td->txo_active, td->tx_power, td->tx_rate_sgi, td->tx_rate_idx,
+		td->tx_rate_nss, td->tx_rate_mode, td->tx_xmit_count,
+		td->txbw);
+
+	mutex_lock(&mvm->mutex);
+	prev_td = rcu_dereference_protected(mvm->txo_data, lockdep_is_held(&mvm->mutex));
+	rcu_assign_pointer(mvm->txo_data, td);
+	mutex_unlock(&mvm->mutex);
+	synchronize_rcu();
+	kfree(prev_td);
+
+	ret = count;
+
+exit:
+	return ret;
+}
+
+static const struct file_operations fops_set_rate_override = {
+	.read = iwl_dbgfs_read_set_rate_override,
+	.write = iwl_dbgfs_write_set_rate_override,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 				  size_t count, loff_t *ppos)
 {
@@ -2842,6 +2996,9 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	debugfs_create_file("mem", 0600, mvm->debugfs_dir, mvm,
 			    &iwl_dbgfs_mem_ops);
 
+	debugfs_create_file("set_rate_override", 0600, mvm->debugfs_dir,
+			    mvm, &fops_set_rate_override);
+
 	/*
 	 * Create a symlink with mac80211. It will be removed when mac80211
 	 * exists (before the opmode exists which removes the target.)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 463bcb852b58..66f8296f9485 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -902,6 +902,22 @@ struct iwl_time_sync_data {
 	bool active;
 };
 
+struct iwl_txo_data {
+	struct rcu_head rcu_head;
+	u8 txo_active; /* tx overrides are active */
+	u8 txbw; /* specify TX bandwidth: 0 20Mhz, 1 40Mhz, 2 80Mhz, 3 160Mhz, 4 320Mhz */
+	/* SGI:  VHT and lower: 0 off, 1 on
+	 * HE-SU: 0 1xLTF+0.8us, 1 2xLTF+0.8us, 2 2xLTF+1.6us, 3 4xLTF+3.2us, 4 4xLTF+0.8us
+	 */
+	u8 tx_rate_sgi;
+	u8 tx_rate_mode; /* 0=cck, 1=ofdm, 2=HT, 3=VHT, 4=HE_SU, 5=EHT */
+	u8 tx_rate_idx;
+	u8 tx_rate_nss;
+
+	u8 tx_power;
+	u8 tx_xmit_count; /* 0 means no-ack, 1 means one transmit, etc */
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -947,6 +963,7 @@ struct iwl_mvm {
 		struct mvm_statistics_rx rx_stats;
 	};
 	struct iwl_mvm_ethtool_stats ethtool_stats;
+	struct iwl_txo_data __rcu *txo_data;
 
 	struct {
 		u64 rx_time;
@@ -2687,6 +2704,8 @@ enum iwl_location_cipher iwl_mvm_cipher_to_location_cipher(u32 cipher)
 	}
 }
 
+struct iwl_txo_data *iwl_mvm_get_txo_data(struct iwl_mvm *mvm);
+
 struct iwl_mvm_csme_conn_info *iwl_mvm_get_csme_conn_info(struct iwl_mvm *mvm);
 static inline int iwl_mvm_mei_get_ownership(struct iwl_mvm *mvm)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index aee8501e5ace..f14aea39b70e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -308,6 +308,113 @@ static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
 	return BIT(mvm->mgmt_last_antenna_idx) << RATE_MCS_ANT_POS;
 }
 
+static u32 iwl_mvm_get_txo_rate_n_flags(struct iwl_mvm *mvm, struct iwl_txo_data *td)
+{
+	u32 result;
+
+	if (td->tx_rate_mode == 0) { /* cck */
+		result = RATE_MCS_CCK_MSK_V1;
+		switch (td->tx_rate_idx) {
+		case 0: result |= IWL_RATE_1M_PLCP; break;
+		case 1: result |= IWL_RATE_2M_PLCP; break;
+		case 2: result |= IWL_RATE_5M_PLCP; break;
+		default: result |= IWL_RATE_11M_PLCP; break;
+		}
+		goto check_v1;
+	} else if (td->tx_rate_mode == 1) { /* ofdm */
+		result = 0;
+		switch (td->tx_rate_idx) {
+		case 0: result |= IWL_RATE_6M_PLCP; break;
+		case 1: result |= IWL_RATE_9M_PLCP; break;
+		case 2: result |= IWL_RATE_12M_PLCP; break;
+		case 3: result |= IWL_RATE_18M_PLCP; break;
+		case 4: result |= IWL_RATE_24M_PLCP; break;
+		case 5: result |= IWL_RATE_36M_PLCP; break;
+		case 6: result |= IWL_RATE_48M_PLCP; break;
+		default: result |= IWL_RATE_54M_PLCP; break;
+		}
+		goto check_v1;
+	} else if (td->tx_rate_mode == 2) { /* ht */
+		result = RATE_MCS_HT_MSK_V1;
+		result |= u32_encode_bits(td->tx_rate_nss * 8 + td->tx_rate_idx,
+					  RATE_HT_MCS_RATE_CODE_MSK_V1 |
+					  RATE_HT_MCS_NSS_MSK_V1);
+		if (td->tx_rate_sgi)
+			result |= RATE_MCS_SGI_MSK_V1;
+		if (td->txbw == 1)
+			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		/* TODO:  Support forcing ldpc and stbc?
+		   if (info->flags & IEEE80211_TX_CTL_LDPC)
+		   result |= RATE_MCS_LDPC_MSK_V1;
+		   if (u32_get_bits(info->flags, IEEE80211_TX_CTL_STBC))
+		   result |= RATE_MCS_STBC_MSK;
+		*/
+		goto check_v1;
+	} else if (td->tx_rate_mode == 3) { /* vht */
+		u8 mcs = td->tx_rate_idx;
+		u8 nss = td->tx_rate_nss;
+
+		result = RATE_MCS_VHT_MSK_V1;
+		result |= u32_encode_bits(mcs, RATE_VHT_MCS_RATE_CODE_MSK);
+		result |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
+		if (td->tx_rate_sgi)
+			result |= RATE_MCS_SGI_MSK_V1;
+		if (td->txbw == 1)
+			result |= u32_encode_bits(1, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		else if (td->txbw == 2)
+			result |= u32_encode_bits(2, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		else if (td->txbw == 3)
+			result |= u32_encode_bits(3, RATE_MCS_CHAN_WIDTH_MSK_V1);
+		goto check_v1;
+	} else if (td->tx_rate_mode == 4) { /* HE-SU */
+		/* V2 format */
+		u8 mcs = td->tx_rate_idx;
+		u8 nss = td->tx_rate_nss;
+
+		result = RATE_MCS_HE_MSK; /* HE-SU by default, others possible */
+		result |= RATE_HT_MCS_INDEX(mcs);
+		result |= nss << RATE_MCS_NSS_POS;
+
+		if (td->txbw == 1)
+			result |= RATE_MCS_CHAN_WIDTH_40;
+		else if (td->txbw == 2)
+			result |= RATE_MCS_CHAN_WIDTH_80;
+		else if (td->txbw == 3)
+			result |= RATE_MCS_CHAN_WIDTH_160;
+
+		result |= ((u32)(td->tx_rate_sgi)) << RATE_MCS_HE_GI_LTF_POS;
+	} else if (td->tx_rate_mode == 5) { /* EHT */
+		/* V2 format */
+		u8 mcs = td->tx_rate_idx;
+		u8 nss = td->tx_rate_nss;
+
+		result = RATE_MCS_EHT_MSK; /* HE-SU by default, others possible */
+		result |= RATE_HT_MCS_INDEX(mcs);
+		result |= nss << RATE_MCS_NSS_POS;
+
+		if (td->txbw == 1)
+			result |= RATE_MCS_CHAN_WIDTH_40;
+		else if (td->txbw == 2)
+			result |= RATE_MCS_CHAN_WIDTH_80;
+		else if (td->txbw == 3)
+			result |= RATE_MCS_CHAN_WIDTH_160;
+		else if (td->txbw == 4)
+			result |= RATE_MCS_CHAN_WIDTH_320;
+
+		result |= ((u32)(td->tx_rate_sgi)) << RATE_MCS_HE_GI_LTF_POS;
+	}
+
+	result |= RATE_MCS_ANT_AB_MSK; /* enable both antennas */
+	return result;
+
+check_v1:
+	result |= RATE_MCS_ANT_AB_MSK; /* enable both antennas */
+
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 6)
+		return iwl_new_rate_from_v1(result);
+	return result;
+}
+
 static u32 iwl_mvm_get_inject_tx_rate(struct iwl_mvm *mvm,
 				      struct ieee80211_tx_info *info)
 {
@@ -437,8 +544,8 @@ static u32 iwl_mvm_get_tx_rate_n_flags(struct iwl_mvm *mvm,
  * Sets the fields in the Tx cmd that are rate related
  */
 void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
-			    struct ieee80211_tx_info *info,
-			    struct ieee80211_sta *sta, __le16 fc)
+			     struct ieee80211_tx_info *info,
+			     struct ieee80211_sta *sta, __le16 fc)
 {
 	/* Set retry limit on RTS packets */
 	tx_cmd->rts_retry_limit = IWL_RTS_DFAULT_RETRY_LIMIT;
@@ -475,8 +582,8 @@ void iwl_mvm_set_tx_cmd_rate(struct iwl_mvm *mvm, struct iwl_tx_cmd *tx_cmd,
 	}
 #else
 	if (ieee80211_is_back_req(fc))
-			tx_cmd->tx_flags |=
-				cpu_to_le32(TX_CMD_FLG_ACK | TX_CMD_FLG_BAR);
+		tx_cmd->tx_flags |=
+			cpu_to_le32(TX_CMD_FLG_ACK | TX_CMD_FLG_BAR);
 #endif
 
 	/* Set the rate in the TX cmd */
@@ -534,7 +641,7 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 	case WLAN_CIPHER_SUITE_WEP40:
 		tx_cmd->sec_ctl |= TX_CMD_SEC_WEP |
 			((keyconf->keyidx << TX_CMD_SEC_WEP_KEY_IDX_POS) &
-			  TX_CMD_SEC_WEP_KEY_IDX_MSK);
+			 TX_CMD_SEC_WEP_KEY_IDX_MSK);
 
 		memcpy(&tx_cmd->key[3], keyconf->key, keyconf->keylen);
 		break;
@@ -569,6 +676,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct iwl_device_tx_cmd *dev_cmd;
 	struct iwl_tx_cmd *tx_cmd;
+	__le16 fc = hdr->frame_control;
 
 	dev_cmd = iwl_trans_alloc_tx_cmd(mvm->trans);
 
@@ -584,7 +692,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			iwl_mvm_sta_from_mac80211(sta) : NULL;
 		bool amsdu = false;
 
-		if (ieee80211_is_data_qos(hdr->frame_control)) {
+		if (ieee80211_is_data_qos(fc)) {
 			u8 *qc = ieee80211_get_qos_ctl(hdr);
 
 			amsdu = *qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT;
@@ -598,12 +706,21 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		 * set rate/antenna during connection establishment or in case
 		 * no station is given.
 		 */
-		if (!sta || !ieee80211_is_data(hdr->frame_control) ||
+		if (!sta || !ieee80211_is_data(fc) ||
 		    mvmsta->sta_state < IEEE80211_STA_AUTHORIZED) {
 			flags |= IWL_TX_FLAGS_CMD_RATE;
 			rate_n_flags =
-				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta,
-							    hdr->frame_control);
+				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc);
+		} else if (mvm->txo_data && skb->len >= 400 &&
+			   (ieee80211_is_data(fc) || ieee80211_is_data_qos(fc)) &&
+			   (!(ieee80211_is_qos_nullfunc(fc) || ieee80211_is_nullfunc(fc)))) {
+			struct iwl_txo_data *td = rcu_dereference(mvm->txo_data);
+
+			/* Check td again, un-protected access above was lazy check. */
+			if (td && td->txo_active) {
+				flags |= IWL_TX_FLAGS_CMD_RATE;
+				rate_n_flags = iwl_mvm_get_txo_rate_n_flags(mvm, td);
+			}
 		}
 
 		if (mvm->trans->trans_cfg->device_family >=
@@ -649,7 +766,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	iwl_mvm_set_tx_cmd(mvm, skb, tx_cmd, info, sta_id);
 
-	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
+	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, fc);
 
 	/* Copy MAC header from skb into command buffer */
 	memcpy(tx_cmd->hdr, hdr, hdrlen);
-- 
2.40.0

