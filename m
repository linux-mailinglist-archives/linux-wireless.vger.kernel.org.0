Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C59D50B9
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfJLPsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48678 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729427AbfJLPsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:51 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdM-0005yf-3q; Sat, 12 Oct 2019 18:48:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:23 +0300
Message-Id: <20191012184707.f28b5805bf3c.I5882726ee399b1d313493eb12aec9ec3d055cf77@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/16] iwlwifi: dbg_ini: add periodic trigger new API support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Enable periodic trigger.
Allows the driver to trigger dump collection in constant intervals.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 105 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index c657acf61fe9..f813b2333565 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -95,6 +95,20 @@ struct iwl_dbg_tlv_ver_data {
 	int max_ver;
 };
 
+/**
+ * struct iwl_dbg_tlv_timer_node - timer node struct
+ * @list: list of &struct iwl_dbg_tlv_timer_node
+ * @timer: timer
+ * @fwrt: &struct iwl_fw_runtime
+ * @tlv: TLV attach to the timer node
+ */
+struct iwl_dbg_tlv_timer_node {
+	struct list_head list;
+	struct timer_list timer;
+	struct iwl_fw_runtime *fwrt;
+	struct iwl_ucode_tlv *tlv;
+};
+
 static const struct iwl_dbg_tlv_ver_data
 dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= {.min_ver = 1, .max_ver = 1,},
@@ -310,7 +324,14 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 
 void iwl_dbg_tlv_del_timers(struct iwl_trans *trans)
 {
-	/* will be used later */
+	struct list_head *timer_list = &trans->dbg.periodic_trig_list;
+	struct iwl_dbg_tlv_timer_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, timer_list, list) {
+		del_timer(&node->timer);
+		list_del(&node->list);
+		kfree(node);
+	}
 }
 IWL_EXPORT_SYMBOL(iwl_dbg_tlv_del_timers);
 
@@ -438,6 +459,7 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans)
 	int i;
 
 	INIT_LIST_HEAD(&trans->dbg.debug_info_tlv_list);
+	INIT_LIST_HEAD(&trans->dbg.periodic_trig_list);
 
 	for (i = 0; i < ARRAY_SIZE(trans->dbg.time_point); i++) {
 		struct iwl_dbg_tlv_time_point_data *tp =
@@ -654,6 +676,83 @@ static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 	}
 }
 
+static void iwl_dbg_tlv_periodic_trig_handler(struct timer_list *t)
+{
+	struct iwl_dbg_tlv_timer_node *timer_node =
+		from_timer(timer_node, t, timer);
+	struct iwl_fwrt_dump_data dump_data = {
+		.trig = (void *)timer_node->tlv->data,
+	};
+	int ret;
+
+	ret = iwl_fw_dbg_ini_collect(timer_node->fwrt, &dump_data);
+	if (!ret || ret == -EBUSY) {
+		u32 occur = le32_to_cpu(dump_data.trig->occurrences);
+		u32 collect_interval = le32_to_cpu(dump_data.trig->data[0]);
+
+		if (!occur)
+			return;
+
+		mod_timer(t, jiffies + msecs_to_jiffies(collect_interval));
+	}
+}
+
+static void iwl_dbg_tlv_set_periodic_trigs(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_dbg_tlv_node *node;
+	struct list_head *trig_list =
+		&fwrt->trans->dbg.time_point[IWL_FW_INI_TIME_POINT_PERIODIC].active_trig_list;
+
+	list_for_each_entry(node, trig_list, list) {
+		struct iwl_fw_ini_trigger_tlv *trig = (void *)node->tlv.data;
+		struct iwl_dbg_tlv_timer_node *timer_node;
+		u32 occur = le32_to_cpu(trig->occurrences), collect_interval;
+		u32 min_interval = 100;
+
+		if (!occur)
+			continue;
+
+		/* make sure there is at least one dword of data for the
+		 * interval value
+		 */
+		if (le32_to_cpu(node->tlv.length) <
+		    sizeof(*trig) + sizeof(__le32)) {
+			IWL_ERR(fwrt,
+				"WRT: Invalid periodic trigger data was not given\n");
+			continue;
+		}
+
+		if (le32_to_cpu(trig->data[0]) < min_interval) {
+			IWL_WARN(fwrt,
+				 "WRT: Override min interval from %u to %u msec\n",
+				 le32_to_cpu(trig->data[0]), min_interval);
+			trig->data[0] = cpu_to_le32(min_interval);
+		}
+
+		collect_interval = le32_to_cpu(trig->data[0]);
+
+		timer_node = kzalloc(sizeof(*timer_node), GFP_KERNEL);
+		if (!timer_node) {
+			IWL_ERR(fwrt,
+				"WRT: Failed to allocate periodic trigger\n");
+			continue;
+		}
+
+		timer_node->fwrt = fwrt;
+		timer_node->tlv = &node->tlv;
+		timer_setup(&timer_node->timer,
+			    iwl_dbg_tlv_periodic_trig_handler, 0);
+
+		list_add_tail(&timer_node->list,
+			      &fwrt->trans->dbg.periodic_trig_list);
+
+		IWL_DEBUG_FW(fwrt, "WRT: Enabling periodic trigger\n");
+
+		mod_timer(&timer_node->timer,
+			  jiffies + msecs_to_jiffies(collect_interval));
+	}
+}
+
 static bool is_trig_data_contained(struct iwl_ucode_tlv *new,
 				   struct iwl_ucode_tlv *old)
 {
@@ -936,6 +1035,10 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
 		break;
+	case IWL_FW_INI_TIME_POINT_PERIODIC:
+		iwl_dbg_tlv_set_periodic_trigs(fwrt);
+		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 59debf6e1b9d..32e522991068 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -724,6 +724,7 @@ struct iwl_self_init_dram {
  * @active_regions: active regions
  * @debug_info_tlv_list: list of debug info TLVs
  * @time_point: array of debug time points
+ * @periodic_trig_list: periodic triggers list
  * @domains_bitmap: bitmap of active domains other than
  *	&IWL_FW_INI_DOMAIN_ALWAYS_ON
  */
@@ -754,6 +755,7 @@ struct iwl_trans_debug {
 	struct list_head debug_info_tlv_list;
 	struct iwl_dbg_tlv_time_point_data
 		time_point[IWL_FW_INI_TIME_POINT_NUM];
+	struct list_head periodic_trig_list;
 
 	u32 domains_bitmap;
 };
-- 
2.23.0

