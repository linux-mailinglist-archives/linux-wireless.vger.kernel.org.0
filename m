Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0D5287A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfFYJqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:46:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54670 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727729AbfFYJqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:46:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0d-0007Nv-5C; Tue, 25 Jun 2019 12:45:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 11/12] iwlwifi: mvm: remove multiple debugfs entries
Date:   Tue, 25 Jun 2019 12:44:51 +0300
Message-Id: <20190625094452.19034-12-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Now that we have per station control over amsdu size no need for
multiple entries, especially that the old one is misleading due to not
setting it for all protocols as a limit.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 20 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  9 +--------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index fb2fd89270ed..8260da314721 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1396,24 +1396,6 @@ static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_mvm *mvm,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_max_amsdu_len_write(struct iwl_mvm *mvm,
-					     char *buf, size_t count,
-					     loff_t *ppos)
-{
-	unsigned int max_amsdu_len;
-	int ret;
-
-	ret = kstrtouint(buf, 0, &max_amsdu_len);
-	if (ret)
-		return ret;
-
-	if (max_amsdu_len > IEEE80211_MAX_MPDU_LEN_VHT_11454)
-		return -EINVAL;
-	mvm->max_amsdu_len = max_amsdu_len;
-
-	return count;
-}
-
 #define ADD_TEXT(...) pos += scnprintf(buf + pos, bufsz - pos, __VA_ARGS__)
 #ifdef CONFIG_IWLWIFI_BCAST_FILTERING
 static ssize_t iwl_dbgfs_bcast_filters_read(struct file *file,
@@ -1966,7 +1948,6 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(d0i3_refs, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
-MVM_DEBUGFS_WRITE_FILE_OPS(max_amsdu_len, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(indirection_tbl,
 			   (IWL_RSS_INDIRECTION_TABLE_SIZE * 2));
 MVM_DEBUGFS_WRITE_FILE_OPS(inject_packet, 512);
@@ -2169,7 +2150,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	MVM_DEBUGFS_ADD_FILE(d0i3_refs, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_conf, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_collect, mvm->debugfs_dir, 0200);
-	MVM_DEBUGFS_ADD_FILE(max_amsdu_len, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(send_echo_cmd, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(indirection_tbl, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(inject_packet, mvm->debugfs_dir, 0200);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8dc2a9850bc5..0c938fe4cbe7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1109,7 +1109,6 @@ struct iwl_mvm {
 	u8 ps_disabled; /* u8 instead of bool to ease debugfs_create_* usage */
 	/* Indicate if 32Khz external clock is valid */
 	u32 ext_clock_valid;
-	unsigned int max_amsdu_len; /* used for debugfs only */
 
 	struct ieee80211_vif __rcu *csa_vif;
 	struct ieee80211_vif __rcu *csa_tx_blocked_vif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ad4760307726..16f7458e2e81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -893,18 +893,15 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	unsigned int mss = skb_shinfo(skb)->gso_size;
 	unsigned int num_subframes, tcp_payload_len, subf_len, max_amsdu_len;
 	u16 snap_ip_tcp, pad;
-	unsigned int dbg_max_amsdu_len;
 	netdev_features_t netdev_flags = NETIF_F_CSUM_MASK | NETIF_F_SG;
 	u8 tid;
 
 	snap_ip_tcp = 8 + skb_transport_header(skb) - skb_network_header(skb) +
 		tcp_hdrlen(skb);
 
-	dbg_max_amsdu_len = READ_ONCE(mvm->max_amsdu_len);
-
 	if (!mvmsta->max_amsdu_len ||
 	    !ieee80211_is_data_qos(hdr->frame_control) ||
-	    (!mvmsta->amsdu_enabled && !dbg_max_amsdu_len))
+	    !mvmsta->amsdu_enabled)
 		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
 	/*
@@ -936,10 +933,6 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 	max_amsdu_len = iwl_mvm_max_amsdu_size(mvm, sta, tid);
 
-	if (unlikely(dbg_max_amsdu_len))
-		max_amsdu_len = min_t(unsigned int, max_amsdu_len,
-				      dbg_max_amsdu_len);
-
 	/*
 	 * Limit A-MSDU in A-MPDU to 4095 bytes when VHT is not
 	 * supported. This is a spec requirement (IEEE 802.11-2015
-- 
2.20.1

