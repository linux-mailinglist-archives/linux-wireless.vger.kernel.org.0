Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D817D236C
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjJVO4S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVO4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF888E1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986574; x=1729522574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjB7P0mzbxfiYz0qJ5s4lXPmMNieXNzNtkURpsosC7I=;
  b=IAsD6+IUKTcECFuA/JZQoNzwO060sjAdOVWXX3Q2OZ5s2S+Ko2kbynEp
   H1sHXXdFkGiOgNTekQNdnVvFchbb0Hu66L+cUliyU9NdRc52f2lpBn3Qv
   B1WHfwK3wc0C5qYVUB7RWtWscahW6stpnDkVI4xQHjlBhxh/puVJJ0UmK
   jn/fG6qr8KrRJ02WCD/9xH3eXkYT/1z198S8xMoEEnGDs0tXZdXeTEtnt
   I6MVsl0njP7c1dWb4gfNjHmTsn6Q10QqO3Vdwz6D02To9uU2ZbAhjmn51
   wIw4vlHDGfbFZ0W7aIzUcGxfilP8OGim6DJaKRuErSpnHGkVhNmGxf4Zr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925847"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556192"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:54:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/10] wifi: iwlwifi: mvm: debugfs for fw system stats
Date:   Sun, 22 Oct 2023 17:55:48 +0300
Message-Id: <20231022173519.e77efee7cd85.I99f370f26f94f73e06aec2a8eaf21ebcc82f60a9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add debgufs handler for fw system statistics command.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2c93b5a442c4..329c545f65fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1005,6 +1005,13 @@ static ssize_t iwl_dbgfs_fw_rx_stats_read(struct file *file,
 	char *buf;
 	int ret;
 	size_t bufsz;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(SYSTEM_GROUP,
+						   SYSTEM_STATISTICS_CMD),
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
+		return -EOPNOTSUPP;
 
 	if (iwl_mvm_has_new_rx_stats_api(mvm))
 		bufsz = ((sizeof(struct mvm_statistics_rx) /
@@ -1184,6 +1191,101 @@ static ssize_t iwl_dbgfs_fw_rx_stats_read(struct file *file,
 }
 #undef PRINT_STAT_LE32
 
+static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
+					      char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	char *buff, *pos, *endpos;
+	int ret;
+	size_t bufsz;
+	int i;
+	struct iwl_mvm_vif *mvmvif;
+	struct ieee80211_vif *vif;
+	struct iwl_mvm *mvm = file->private_data;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(SYSTEM_GROUP,
+						   SYSTEM_STATISTICS_CMD),
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	/* in case of a wrong cmd version, allocate buffer only for error msg */
+	bufsz = (cmd_ver == 1) ? 4096 : 64;
+
+	buff = kzalloc(bufsz, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	pos = buff;
+	endpos = pos + bufsz;
+
+	if (cmd_ver != 1) {
+		pos += scnprintf(pos, endpos - pos,
+				 "System stats not supported:%d\n", cmd_ver);
+		goto send_out;
+	}
+
+	mutex_lock(&mvm->mutex);
+	if (iwl_mvm_firmware_running(mvm))
+		iwl_mvm_request_statistics(mvm, false);
+
+	for (i = 0; i < NUM_MAC_INDEX_DRIVER; i++) {
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, i, false);
+		if (!vif)
+			continue;
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			break;
+	}
+
+	if (i == NUM_MAC_INDEX_DRIVER || !vif) {
+		pos += scnprintf(pos, endpos - pos, "vif is NULL\n");
+		goto release_send_out;
+	}
+
+	mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	if (!mvmvif) {
+		pos += scnprintf(pos, endpos - pos, "mvmvif is NULL\n");
+		goto release_send_out;
+	}
+
+	for_each_mvm_vif_valid_link(mvmvif, i) {
+		struct iwl_mvm_vif_link_info *link_info = mvmvif->link[i];
+
+		pos += scnprintf(pos, endpos - pos,
+				 "link_id %d", i);
+		pos += scnprintf(pos, endpos - pos,
+				 " num_beacons %d",
+				 link_info->beacon_stats.num_beacons);
+		pos += scnprintf(pos, endpos - pos,
+				 " accu_num_beacons %d",
+				 link_info->beacon_stats.accu_num_beacons);
+		pos += scnprintf(pos, endpos - pos,
+				 " avg_signal %d\n",
+				 link_info->beacon_stats.avg_signal);
+	}
+
+	pos += scnprintf(pos, endpos - pos,
+			 "radio_stats.rx_time %lld\n",
+			 mvm->radio_stats.rx_time);
+	pos += scnprintf(pos, endpos - pos,
+			 "radio_stats.tx_time %lld\n",
+			 mvm->radio_stats.tx_time);
+	pos += scnprintf(pos, endpos - pos,
+			 "accu_radio_stats.rx_time %lld\n",
+			 mvm->accu_radio_stats.rx_time);
+	pos += scnprintf(pos, endpos - pos,
+			 "accu_radio_stats.tx_time %lld\n",
+			 mvm->accu_radio_stats.tx_time);
+
+release_send_out:
+	mutex_unlock(&mvm->mutex);
+
+send_out:
+	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	kfree(buff);
+
+	return ret;
+}
+
 static ssize_t iwl_dbgfs_frame_stats_read(struct iwl_mvm *mvm,
 					  char __user *user_buf, size_t count,
 					  loff_t *ppos,
@@ -2053,6 +2155,7 @@ MVM_DEBUGFS_READ_FILE_OPS(bt_cmd);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(disable_power_off, 64);
 MVM_DEBUGFS_READ_FILE_OPS(fw_rx_stats);
 MVM_DEBUGFS_READ_FILE_OPS(drv_rx_stats);
+MVM_DEBUGFS_READ_FILE_OPS(fw_system_stats);
 MVM_DEBUGFS_READ_FILE_OPS(fw_ver);
 MVM_DEBUGFS_READ_FILE_OPS(phy_integration_ver);
 MVM_DEBUGFS_READ_FILE_OPS(tas_get_status);
@@ -2260,6 +2363,7 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(fw_ver, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_rx_stats, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(drv_rx_stats, mvm->debugfs_dir, 0400);
+	MVM_DEBUGFS_ADD_FILE(fw_system_stats, mvm->debugfs_dir, 0400);
 	MVM_DEBUGFS_ADD_FILE(fw_restart, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(fw_nmi, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(bt_tx_prio, mvm->debugfs_dir, 0200);
-- 
2.38.1

