Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6455A490301
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 08:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbiAQHir (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 02:38:47 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39955 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiAQHiq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 02:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642405126; x=1673941126;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tBEX9l+nFIr0BQPfW+Fqa6GfToON3WyjV/2sEwUAxhU=;
  b=ozZpkn0xHEJwyqlPhpvCBYFmx49Tlvxq1Rj4+sb1daX7YGtbR7MuhHQw
   o3L4hFUPFtBntyjZS32y8tQrhPQe2P0S7TAH5Sq24mOl/pl4pNK8BGJQl
   yxfqgQ2Fzs92pfZ6rt2i6j/dQC/dj9xZZFqrbt6cIIIdk6TMbOnYe9amM
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 23:38:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 23:38:45 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 23:38:44 -0800
Received: from seevalam-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 23:38:42 -0800
From:   Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
Subject: [PATCHv2] ath11k: Add debugfs interface to configure firmware debug log level
Date:   Mon, 17 Jan 2022 13:08:23 +0530
Message-ID: <1642405103-32302-1-git-send-email-quic_seevalam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add debugfs interface "fw_dbglog_config" to configure firmware log level.
Configuration is done via WMI command WMI_DBGLOG_CFG_CMDID.

Command to configure,
echo "<dbglog_param> <values>" >
/sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config

where dbglog_param can be,
  1) WMI_DEBUG_LOG_PARAM_LOG_LEVEL - configure log level for a given module
     here, <values> = <0xaaaa00bb>, 'aaaa' - module id and 'bb' - loglevel
  2) WMI_DEBUG_LOG_PARAM_VDEV_ENABLE - enable debug log for a given vdev
     here, <values> = vdev_id
  3) WMI_DEBUG_LOG_PARAM_VDEV_DISABLE - disable debug log for a given vdev
     except ERROR logs
     here, <values> = vdev_id
  4) WMI_DEBUG_LOG_PARAM_VDEV_ENABLE_BITMAP - set vdev enable bitmap
       here, <values> = vdev_enable_bitmap
  5) WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP - set a given log level to all the
     modules specified in the module bitmap. Command to configure for this log param,

     $ echo "5 <values> <module_id_index> <is_end>" >
         /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
     here,
                <values> = <0xaaaaaaaa000000bb>, 'aaaaaaaa' - module bitmap and
                          'bb' - loglevel
                <module_id_index> = index of module bitmap. Max module id is 512.
                                    So, module_id_index is 0-15.
                <is_end> = to indicate if more configuration to follow.

  6) WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP - Wow mode specific logging enable.
     Command to configure for this log param,

      $ echo "6 <values> <module_id_index> <is_end>" >
          /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config
      here,
                 <values> = <0xaaaaaaaa000000bb>, 'aaaaaaaa' - module bitmap and
                              'bb' - loglevel
                 <module_id_index> = index of module bitmap. Max module id is 512.
                                     So, module_id_index is 0-15.
                 <is_end> = to indicate if more configuration to follow.

Sample command usage,

To enable module WLAN_MODULE_WMI and log level ATH11K_FW_DBGLOG_VERBOSE,
echo "1 0x10001" > /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config

To enable module bit map from 32 to 63 and log level ATH11K_FW_DBGLOG_VERBOSE,
echo "5 0xffffffff00000001 1 1" > /sys/kernel/debug/ath11k/<hw>/macX/fw_dbglog_config

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
---
v2: 
  - Fixed below compilation error "Reported-by: kernel test robot <lkp@intel.com>"
    drivers/net/wireless/ath/ath11k/wmi.c:7833:39: error: 'struct ath11k' has no member named 'debug'

 drivers/net/wireless/ath/ath11k/core.h    |   3 +
 drivers/net/wireless/ath/ath11k/debugfs.c |  66 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h | 124 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     |  53 +++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h     |  18 +++++
 5 files changed, 264 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9e88ccc..22c1f47 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -441,6 +441,8 @@ struct ath11k_dbg_htt_stats {
 	spinlock_t lock;
 };
 
+#define MAX_MODULE_ID_BITMAP_WORDS	16
+
 struct ath11k_debug {
 	struct dentry *debugfs_pdev;
 	struct ath11k_dbg_htt_stats htt_stats;
@@ -454,6 +456,7 @@ struct ath11k_debug {
 	u32 pktlog_peer_valid;
 	u8 pktlog_peer_addr[ETH_ALEN];
 	u32 rx_filter;
+	u32 module_id_bitmap[MAX_MODULE_ID_BITMAP_WORDS];
 };
 
 struct ath11k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 198ade9..aa65ce6 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -870,6 +870,69 @@ static const struct file_operations fops_soc_dp_stats = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_write_fw_dbglog(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[128] = {0};
+	struct ath11k_fw_dbglog dbglog;
+	unsigned int param, mod_id_index, is_end;
+	u64 value;
+	int ret, num;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
+				     user_buf, count);
+	if (ret <= 0)
+		return ret;
+
+	num = sscanf(buf, "%u %llx %u %u", &param, &value, &mod_id_index, &is_end);
+
+	if (num < 2)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	if (param == WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP ||
+	    param == WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP) {
+		if (num != 4 || mod_id_index > (MAX_MODULE_ID_BITMAP_WORDS - 1)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ar->debug.module_id_bitmap[mod_id_index] = upper_32_bits(value);
+		if (!is_end) {
+			ret = count;
+			goto out;
+		}
+	} else {
+		if (num != 2) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	dbglog.param = param;
+	dbglog.value = lower_32_bits(value);
+	ret = ath11k_wmi_fw_dbglog_cfg(ar, ar->debug.module_id_bitmap, &dbglog);
+	if (ret) {
+		ath11k_warn(ar->ab, "fw dbglog config failed from debugfs: %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = count;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_fw_dbglog = {
+	.write = ath11k_write_fw_dbglog,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 {
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
@@ -1136,6 +1199,9 @@ int ath11k_debugfs_register(struct ath11k *ar)
 	debugfs_create_file("pktlog_filter", 0644,
 			    ar->debug.debugfs_pdev, ar,
 			    &fops_pktlog_filter);
+	debugfs_create_file("fw_dbglog_config", 0600,
+			    ar->debug.debugfs_pdev, ar,
+			    &fops_fw_dbglog);
 
 	if (ar->hw->wiphy->bands[NL80211_BAND_5GHZ]) {
 		debugfs_create_file("dfs_simulate_radar", 0200,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 4c07403..a369792 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -107,6 +107,130 @@ enum ath11k_dbg_aggr_mode {
 	ATH11K_DBG_AGGR_MODE_MAX,
 };
 
+enum fw_dbglog_wlan_module_id {
+	WLAN_MODULE_ID_MIN = 0,
+	WLAN_MODULE_INF = WLAN_MODULE_ID_MIN,
+	WLAN_MODULE_WMI,
+	WLAN_MODULE_STA_PWRSAVE,
+	WLAN_MODULE_WHAL,
+	WLAN_MODULE_COEX,
+	WLAN_MODULE_ROAM,
+	WLAN_MODULE_RESMGR_CHAN_MANAGER,
+	WLAN_MODULE_RESMGR,
+	WLAN_MODULE_VDEV_MGR,
+	WLAN_MODULE_SCAN,
+	WLAN_MODULE_RATECTRL,
+	WLAN_MODULE_AP_PWRSAVE,
+	WLAN_MODULE_BLOCKACK,
+	WLAN_MODULE_MGMT_TXRX,
+	WLAN_MODULE_DATA_TXRX,
+	WLAN_MODULE_HTT,
+	WLAN_MODULE_HOST,
+	WLAN_MODULE_BEACON,
+	WLAN_MODULE_OFFLOAD,
+	WLAN_MODULE_WAL,
+	WLAN_WAL_MODULE_DE,
+	WLAN_MODULE_PCIELP,
+	WLAN_MODULE_RTT,
+	WLAN_MODULE_RESOURCE,
+	WLAN_MODULE_DCS,
+	WLAN_MODULE_CACHEMGR,
+	WLAN_MODULE_ANI,
+	WLAN_MODULE_P2P,
+	WLAN_MODULE_CSA,
+	WLAN_MODULE_NLO,
+	WLAN_MODULE_CHATTER,
+	WLAN_MODULE_WOW,
+	WLAN_MODULE_WAL_VDEV,
+	WLAN_MODULE_WAL_PDEV,
+	WLAN_MODULE_TEST,
+	WLAN_MODULE_STA_SMPS,
+	WLAN_MODULE_SWBMISS,
+	WLAN_MODULE_WMMAC,
+	WLAN_MODULE_TDLS,
+	WLAN_MODULE_HB,
+	WLAN_MODULE_TXBF,
+	WLAN_MODULE_BATCH_SCAN,
+	WLAN_MODULE_THERMAL_MGR,
+	WLAN_MODULE_PHYERR_DFS,
+	WLAN_MODULE_RMC,
+	WLAN_MODULE_STATS,
+	WLAN_MODULE_NAN,
+	WLAN_MODULE_IBSS_PWRSAVE,
+	WLAN_MODULE_HIF_UART,
+	WLAN_MODULE_LPI,
+	WLAN_MODULE_EXTSCAN,
+	WLAN_MODULE_UNIT_TEST,
+	WLAN_MODULE_MLME,
+	WLAN_MODULE_SUPPL,
+	WLAN_MODULE_ERE,
+	WLAN_MODULE_OCB,
+	WLAN_MODULE_RSSI_MONITOR,
+	WLAN_MODULE_WPM,
+	WLAN_MODULE_CSS,
+	WLAN_MODULE_PPS,
+	WLAN_MODULE_SCAN_CH_PREDICT,
+	WLAN_MODULE_MAWC,
+	WLAN_MODULE_CMC_QMIC,
+	WLAN_MODULE_EGAP,
+	WLAN_MODULE_NAN20,
+	WLAN_MODULE_QBOOST,
+	WLAN_MODULE_P2P_LISTEN_OFFLOAD,
+	WLAN_MODULE_HALPHY,
+	WLAN_WAL_MODULE_ENQ,
+	WLAN_MODULE_GNSS,
+	WLAN_MODULE_WAL_MEM,
+	WLAN_MODULE_SCHED_ALGO,
+	WLAN_MODULE_TX,
+	WLAN_MODULE_RX,
+	WLAN_MODULE_WLM,
+	WLAN_MODULE_RU_ALLOCATOR,
+	WLAN_MODULE_11K_OFFLOAD,
+	WLAN_MODULE_STA_TWT,
+	WLAN_MODULE_AP_TWT,
+	WLAN_MODULE_UL_OFDMA,
+	WLAN_MODULE_HPCS_PULSE,
+	WLAN_MODULE_DTF,
+	WLAN_MODULE_QUIET_IE,
+	WLAN_MODULE_SHMEM_MGR,
+	WLAN_MODULE_CFIR,
+	WLAN_MODULE_CODE_COVER,
+	WLAN_MODULE_SHO,
+	WLAN_MODULE_MLO_MGR,
+	WLAN_MODULE_PEER_INIT,
+	WLAN_MODULE_STA_MLO_PS,
+
+	WLAN_MODULE_ID_MAX,
+	WLAN_MODULE_ID_INVALID = WLAN_MODULE_ID_MAX,
+};
+
+enum fw_dbglog_log_level {
+	ATH11K_FW_DBGLOG_ML = 0,
+	ATH11K_FW_DBGLOG_VERBOSE = 0,
+	ATH11K_FW_DBGLOG_INFO,
+	ATH11K_FW_DBGLOG_INFO_LVL_1,
+	ATH11K_FW_DBGLOG_INFO_LVL_2,
+	ATH11K_FW_DBGLOG_WARN,
+	ATH11K_FW_DBGLOG_ERR,
+	ATH11K_FW_DBGLOG_LVL_MAX
+};
+
+struct ath11k_fw_dbglog {
+	enum wmi_debug_log_param param;
+	union {
+		struct {
+			/* log_level values are given in enum fw_dbglog_log_level */
+			u16 log_level;
+			/* module_id values are given in  enum fw_dbglog_wlan_module_id */
+			u16 module_id;
+		};
+		/* value is either log_level&module_id/vdev_id/vdev_id_bitmap/log_level
+		 * according to param
+		 */
+		u32 value;
+	};
+};
+
 #ifdef CONFIG_ATH11K_DEBUGFS
 int ath11k_debugfs_soc_create(struct ath11k_base *ab);
 void ath11k_debugfs_soc_destroy(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6b68ccf6..5b2d8a0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7798,6 +7798,59 @@ int ath11k_wmi_simulate_radar(struct ath11k *ar)
 	return ath11k_wmi_send_unit_test_cmd(ar, wmi_ut, dfs_args);
 }
 
+int ath11k_wmi_fw_dbglog_cfg(struct ath11k *ar, u32 *module_id_bitmap,
+			     struct ath11k_fw_dbglog *dbglog)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_debug_log_config_cmd_fixed_param *cmd;
+	struct sk_buff *skb;
+	struct wmi_tlv *tlv;
+	int ret, len;
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE + (MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_debug_log_config_cmd_fixed_param *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_DEBUG_LOG_CONFIG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->dbg_log_param = dbglog->param;
+
+	tlv = (struct wmi_tlv *)((u8 *)cmd + sizeof(*cmd));
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
+		      FIELD_PREP(WMI_TLV_LEN, MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
+
+	switch (dbglog->param) {
+	case WMI_DEBUG_LOG_PARAM_LOG_LEVEL:
+	case WMI_DEBUG_LOG_PARAM_VDEV_ENABLE:
+	case WMI_DEBUG_LOG_PARAM_VDEV_DISABLE:
+	case WMI_DEBUG_LOG_PARAM_VDEV_ENABLE_BITMAP:
+		cmd->value = dbglog->value;
+		break;
+	case WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP:
+	case WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP:
+		cmd->value = dbglog->value;
+		memcpy(tlv->value, module_id_bitmap,
+		       MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
+		/* clear current config to be used for next user config */
+		memset(module_id_bitmap, 0,
+		       MAX_MODULE_ID_BITMAP_WORDS * sizeof(u32));
+		break;
+	default:
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_DBGLOG_CFG_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_DBGLOG_CFG_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 int ath11k_wmi_connect(struct ath11k_base *ab)
 {
 	u32 i;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 2f26ec1a..1d5bd1e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -12,6 +12,7 @@
 struct ath11k_base;
 struct ath11k;
 struct ath11k_fw_stats;
+struct ath11k_fw_dbglog;
 
 #define PSOC_HOST_MAX_NUM_SS (8)
 
@@ -5240,6 +5241,21 @@ struct wmi_rfkill_state_change_ev {
 	u32 radio_state;
 } __packed;
 
+enum wmi_debug_log_param {
+	WMI_DEBUG_LOG_PARAM_LOG_LEVEL = 0x1,
+	WMI_DEBUG_LOG_PARAM_VDEV_ENABLE,
+	WMI_DEBUG_LOG_PARAM_VDEV_DISABLE,
+	WMI_DEBUG_LOG_PARAM_VDEV_ENABLE_BITMAP,
+	WMI_DEBUG_LOG_PARAM_MOD_ENABLE_BITMAP,
+	WMI_DEBUG_LOG_PARAM_WOW_MOD_ENABLE_BITMAP,
+};
+
+struct wmi_debug_log_config_cmd_fixed_param {
+	u32 tlv_header;
+	u32 dbg_log_param;
+	u32 value;
+} __packed;
+
 #define WMI_MAX_MEM_REQS 32
 
 #define MAX_RADIOS 3
@@ -5582,4 +5598,6 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar);
 int ath11k_wmi_wow_enable(struct ath11k *ar);
 int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 				 const u8 mac_addr[ETH_ALEN]);
+int ath11k_wmi_fw_dbglog_cfg(struct ath11k *ar, u32 *module_id_bitmap,
+			     struct ath11k_fw_dbglog *dbglog);
 #endif
-- 
2.7.4

