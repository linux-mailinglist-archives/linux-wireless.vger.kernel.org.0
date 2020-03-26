Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18966193F56
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgCZMzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44280 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728172AbgCZMzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2h-00040Z-9W; Thu, 26 Mar 2020 14:55:27 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:10 +0200
Message-Id: <iwlwifi.20200326145047.99596d53b40c.Ia59b0abbef16b6783fcabc095c5fde16bd047a26@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: remove newline from rs_pretty_print_rate()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some of the places using this want the newline, but not all,
so remove the newline from it and generate it in the debugfs
files where it's desired.

The effect of this is not printing double newlines in debug
log messages.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 4 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c      | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 190cf15b825c..3beef8d077b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -461,6 +461,8 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 
 	desc += rs_pretty_print_rate(buff + desc, bufsz - desc,
 				     lq_sta->last_rate_n_flags);
+	if (desc < bufsz - 1)
+		buff[desc++] = '\n';
 	mutex_unlock(&mvm->mutex);
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
@@ -1013,6 +1015,8 @@ static ssize_t iwl_dbgfs_frame_stats_read(struct iwl_mvm *mvm,
 				 (int)(ARRAY_SIZE(stats->last_rates) - i));
 		pos += rs_pretty_print_rate(pos, endpos - pos,
 					    stats->last_rates[idx]);
+		if (pos < endpos - 1)
+			*pos++ = '\n';
 	}
 	spin_unlock_bh(&mvm->drv_stats_lock);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 1a990ed9c3ca..c1aba2bf73cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3697,7 +3697,7 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	    !(rate & RATE_MCS_HE_MSK)) {
 		int index = iwl_hwrate_to_plcp_idx(rate);
 
-		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps\n",
+		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
 				 rs_pretty_ant(ant),
 				 index == IWL_RATE_INVALID ? "BAD" :
 				 iwl_rate_mcs[index].mbps);
@@ -3740,7 +3740,7 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	}
 
 	return scnprintf(buf, bufsz,
-			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s\n",
+			 "0x%x: %s | ANT: %s BW: %s MCS: %d NSS: %d %s%s%s%s",
 			 rate, type, rs_pretty_ant(ant), bw, mcs, nss,
 			 (rate & RATE_MCS_SGI_MSK) ? "SGI " : "NGI ",
 			 (rate & RATE_MCS_STBC_MSK) ? "STBC " : "",
@@ -3888,6 +3888,8 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 		desc += scnprintf(buff + desc, bufsz - desc,
 				  " rate[%d] 0x%X ", i, r);
 		desc += rs_pretty_print_rate(buff + desc, bufsz - desc, r);
+		if (desc < bufsz - 1)
+			buff[desc++] = '\n';
 	}
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
-- 
2.25.1

