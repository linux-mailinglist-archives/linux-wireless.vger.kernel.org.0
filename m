Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15520BEF7
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2020 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgF0GXU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Jun 2020 02:23:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32093 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgF0GXT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Jun 2020 02:23:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593238997; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3B8DtFpbDD8QiQPmG4elCiyFJXgpzM3e2d8vy0b5vTs=; b=Wx2upR0mLt9rKdTU8x5IcNbgZybLT/FUpEygIQo93gY0CkXoYBTUqPVM2xdBuDUZU1tfiVGc
 xFljzqUL1zb/VX2sQoJ9rKahVQfJje1AUdKtCRvW1oiNiHDe+q8Mhz/L2lz4QMUfs3lWRQ2b
 /p0EIA1rGKVuE82ltaK8ZOdF1/E=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ef6e5c8117610c7ff1009e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 27 Jun 2020 06:23:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E884BC433CA; Sat, 27 Jun 2020 06:23:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0D07C433C6;
        Sat, 27 Jun 2020 06:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0D07C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Add history for tracking certain events
Date:   Sat, 27 Jun 2020 11:52:53 +0530
Message-Id: <1593238973-23237-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For debugging many issues, a history of the
below mentioned events can help get an idea
of what exactly was going on just before any
issue occurred in the system. These event
history will be collected only when the host
driver is run in debug mode (i.e. with the
config ATH10K_DEBUG enabled).

Add history for tracking the below events
- register read
- register write
- IRQ trigger
- IRQ Enable
- IRQ Disable
- NAPI poll
- CE service
- WMI cmd
- WMI event
- WMI tx completion

This will help in debugging any crash or any
improper behaviour.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/ce.c      |   2 +
 drivers/net/wireless/ath/ath10k/core.h    |  77 +++++++++++++++++
 drivers/net/wireless/ath/ath10k/debug.c   | 134 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/debug.h   |  74 +++++++++++++++++
 drivers/net/wireless/ath/ath10k/snoc.c    |  17 ++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |   1 +
 drivers/net/wireless/ath/ath10k/wmi.c     |  10 +++
 7 files changed, 315 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 1e16f26..ddf2765 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -509,6 +509,7 @@ u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar)
 		}
 	}
 
+	ath10k_record_ce_event(ar, ATH10K_IRQ_SUMMARY, irq_summary);
 	return irq_summary;
 }
 EXPORT_SYMBOL(ath10k_ce_gen_interrupt_summary);
@@ -1331,6 +1332,7 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 	u32 ctrl_addr = ce_state->ctrl_addr;
 
+	ath10k_record_ce_event(ar, ATH10K_CE_SERVICE, ce_id);
 	/*
 	 * Clear before handling
 	 *
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 040053a..eecb5cc 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -971,6 +971,78 @@ struct ath10k_bus_params {
 	bool hl_msdu_ids;
 };
 
+#define ATH10K_REG_ACCESS_HISTORY_MAX	512
+#define ATH10K_CE_EVENT_HISTORY_MAX	1024
+#define ATH10K_WMI_EVENT_HISTORY_MAX	512
+#define ATH10K_WMI_CMD_HISTORY_MAX	256
+
+#define ATH10K_WMI_DATA_LEN	16
+
+enum ath10k_ce_event {
+	ATH10K_IRQ_ENTRY,
+	ATH10K_IRQ_EXIT,
+	ATH10K_IRQ_ENABLE,
+	ATH10K_IRQ_DISABLE,
+	ATH10K_NAPI_POLL,
+	ATH10K_CE_SERVICE,
+	ATH10K_NAPI_COMPLETE,
+	ATH10K_NAPI_RESCHED,
+	ATH10K_IRQ_SUMMARY,
+};
+
+enum ath10k_wmi_type {
+	ATH10K_WMI_EVENT,
+	ATH10K_WMI_CMD,
+	ATH10K_WMI_TX_COMPL,
+};
+
+struct ath10k_reg_access_entry {
+	bool write;
+	u32 cpu_id;
+	u32 offset;
+	u32 val;
+	u64 timestamp;
+};
+
+struct ath10k_wmi_event_entry {
+	enum ath10k_wmi_type type;
+	u32 cpu_id;
+	u32 id;
+	u64 timestamp;
+	unsigned char data[ATH10K_WMI_DATA_LEN];
+};
+
+struct ath10k_ce_event_entry {
+	enum ath10k_ce_event event_type;
+	u32 cpu_id;
+	u32 ce_id;
+	u64 timestamp;
+};
+
+struct ath10k_wmi_event_history {
+	struct ath10k_wmi_event_entry *record;
+	u32 max_entries;
+	atomic_t index;
+	/* lock for accessing wmi event history */
+	spinlock_t hist_lock;
+};
+
+struct ath10k_ce_event_history {
+	struct ath10k_ce_event_entry *record;
+	u32 max_entries;
+	atomic_t index;
+	/* lock for accessing ce event history */
+	spinlock_t hist_lock;
+};
+
+struct ath10k_reg_access_history {
+	struct ath10k_reg_access_entry *record;
+	u32 max_entries;
+	atomic_t index;
+	/* lock for accessing register access history */
+	spinlock_t hist_lock;
+};
+
 struct ath10k {
 	struct ath_common ath_common;
 	struct ieee80211_hw *hw;
@@ -1263,6 +1335,11 @@ struct ath10k {
 	bool coex_support;
 	int coex_gpio_pin;
 
+	struct ath10k_reg_access_history reg_access_history;
+	struct ath10k_ce_event_history ce_event_history;
+	struct ath10k_wmi_event_history wmi_event_history;
+	struct ath10k_wmi_event_history wmi_cmd_history;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index e8250a6..1be4883 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -2722,4 +2722,138 @@ void ath10k_dbg_dump(struct ath10k *ar,
 }
 EXPORT_SYMBOL(ath10k_dbg_dump);
 
+int ath10k_core_reg_access_history_init(struct ath10k *ar, u32 max_entries)
+{
+	ar->reg_access_history.record = vzalloc(max_entries *
+						sizeof(struct ath10k_reg_access_entry));
+	if (!ar->reg_access_history.record)
+		return -ENOMEM;
+
+	ar->reg_access_history.max_entries = max_entries;
+	atomic_set(&ar->reg_access_history.index, 0);
+	spin_lock_init(&ar->reg_access_history.hist_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath10k_core_reg_access_history_init);
+
+int ath10k_core_wmi_cmd_history_init(struct ath10k *ar, u32 max_entries)
+{
+	ar->wmi_cmd_history.record = vzalloc(max_entries *
+					     sizeof(struct ath10k_wmi_event_entry));
+	if (!ar->wmi_cmd_history.record)
+		return -ENOMEM;
+
+	ar->wmi_cmd_history.max_entries = max_entries;
+	atomic_set(&ar->wmi_cmd_history.index, 0);
+	spin_lock_init(&ar->wmi_cmd_history.hist_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath10k_core_wmi_cmd_history_init);
+
+int ath10k_core_wmi_event_history_init(struct ath10k *ar, u32 max_entries)
+{
+	ar->wmi_event_history.record = vzalloc(max_entries *
+					       sizeof(struct ath10k_wmi_event_entry));
+	if (!ar->wmi_event_history.record)
+		return -ENOMEM;
+
+	ar->wmi_event_history.max_entries = max_entries;
+	atomic_set(&ar->wmi_event_history.index, 0);
+	spin_lock_init(&ar->wmi_event_history.hist_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath10k_core_wmi_event_history_init);
+
+int ath10k_core_ce_event_history_init(struct ath10k *ar, u32 max_entries)
+{
+	ar->ce_event_history.record = vzalloc(max_entries *
+					      sizeof(struct ath10k_ce_event_entry));
+	if (!ar->ce_event_history.record)
+		return -ENOMEM;
+
+	ar->ce_event_history.max_entries = max_entries;
+	atomic_set(&ar->ce_event_history.index, 0);
+	spin_lock_init(&ar->ce_event_history.hist_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath10k_core_ce_event_history_init);
+
+void ath10k_record_reg_access(struct ath10k *ar, u32 offset, u32 val, bool write)
+{
+	struct ath10k_reg_access_entry *entry;
+	u32 idx;
+
+	if (!ar->reg_access_history.record)
+		return;
+
+	idx = ath10k_core_get_next_idx(&ar->reg_access_history.index,
+				       ar->reg_access_history.max_entries);
+	entry = &ar->reg_access_history.record[idx];
+
+	entry->timestamp = ath10k_core_get_timestamp();
+	entry->cpu_id = smp_processor_id();
+	entry->write = write;
+	entry->offset = offset;
+	entry->val = val;
+}
+EXPORT_SYMBOL(ath10k_record_reg_access);
+
+void ath10k_record_wmi_event(struct ath10k *ar, enum ath10k_wmi_type type,
+			     u32 id, unsigned char *data)
+{
+	struct ath10k_wmi_event_entry *entry;
+	u32 idx;
+
+	if (type == ATH10K_WMI_EVENT) {
+		if (!ar->wmi_event_history.record)
+			return;
+
+		spin_lock_bh(&ar->wmi_event_history.hist_lock);
+		idx = ath10k_core_get_next_idx(&ar->reg_access_history.index,
+					       ar->wmi_event_history.max_entries);
+		entry = &ar->wmi_event_history.record[idx];
+		spin_unlock_bh(&ar->wmi_event_history.hist_lock);
+	} else {
+		if (!ar->wmi_cmd_history.record)
+			return;
+
+		spin_lock_bh(&ar->wmi_cmd_history.hist_lock);
+		idx = ath10k_core_get_next_idx(&ar->reg_access_history.index,
+					       ar->wmi_cmd_history.max_entries);
+		entry = &ar->wmi_cmd_history.record[idx];
+		spin_unlock_bh(&ar->wmi_cmd_history.hist_lock);
+	}
+
+	entry->timestamp = ath10k_core_get_timestamp();
+	entry->cpu_id = smp_processor_id();
+	entry->type = type;
+	entry->id = id;
+	memcpy(&entry->data, data + 4, ATH10K_WMI_DATA_LEN);
+}
+EXPORT_SYMBOL(ath10k_record_wmi_event);
+
+void ath10k_record_ce_event(struct ath10k *ar, enum ath10k_ce_event event_type,
+			    int ce_id)
+{
+	struct ath10k_ce_event_entry *entry;
+	u32 idx;
+
+	if (!ar->ce_event_history.record)
+		return;
+
+	idx = ath10k_core_get_next_idx(&ar->ce_event_history.index,
+				       ar->ce_event_history.max_entries);
+	entry = &ar->ce_event_history.record[idx];
+
+	entry->timestamp = ath10k_core_get_timestamp();
+	entry->cpu_id = smp_processor_id();
+	entry->event_type = event_type;
+	entry->ce_id = ce_id;
+}
+EXPORT_SYMBOL(ath10k_record_ce_event);
+
 #endif /* CONFIG_ATH10K_DEBUG */
diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
index 997c1c8..c28aeb1 100644
--- a/drivers/net/wireless/ath/ath10k/debug.h
+++ b/drivers/net/wireless/ath/ath10k/debug.h
@@ -258,6 +258,38 @@ void ath10k_dbg_dump(struct ath10k *ar,
 		     enum ath10k_debug_mask mask,
 		     const char *msg, const char *prefix,
 		     const void *buf, size_t len);
+
+/* ========== History init APIs =========== */
+int ath10k_core_reg_access_history_init(struct ath10k *ar, u32 max_entries);
+int ath10k_core_wmi_cmd_history_init(struct ath10k *ar, u32 max_entries);
+int ath10k_core_wmi_event_history_init(struct ath10k *ar, u32 max_entries);
+int ath10k_core_ce_event_history_init(struct ath10k *ar, u32 max_entries);
+
+/* ========== History record APIs =========== */
+void ath10k_record_reg_access(struct ath10k *ar, u32 offset, u32 val,
+			      bool write);
+void ath10k_record_wmi_event(struct ath10k *ar, enum ath10k_wmi_type type,
+			     u32 id, unsigned char *data);
+void ath10k_record_ce_event(struct ath10k *ar,
+			    enum ath10k_ce_event event_type,
+			    int ce_id);
+
+static inline u64 ath10k_core_get_timestamp(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+	return ((u64)ts.tv_sec * 1000000) + (ts.tv_nsec / 1000);
+}
+
+static inline int ath10k_core_get_next_idx(atomic_t *index, u32 max_entries)
+{
+	u32 curr_idx;
+
+	curr_idx = atomic_fetch_inc(index);
+	return (curr_idx & (max_entries - 1));
+}
+
 #else /* CONFIG_ATH10K_DEBUG */
 
 static inline int __ath10k_dbg(struct ath10k *ar,
@@ -273,6 +305,48 @@ static inline void ath10k_dbg_dump(struct ath10k *ar,
 				   const void *buf, size_t len)
 {
 }
+
+static inline int ath10k_core_reg_access_history_init(struct ath10k *ar,
+						      u32 max_entries)
+{
+	return 0;
+}
+
+static inline int ath10k_core_wmi_cmd_history_init(struct ath10k *ar,
+						   u32 max_entries)
+{
+	return 0;
+}
+
+static inline int ath10k_core_wmi_event_history_init(struct ath10k *ar,
+						     u32 max_entries)
+{
+	return 0;
+}
+
+static inline int ath10k_core_ce_event_history_init(struct ath10k *ar,
+						    u32 max_entries)
+{
+	return 0;
+}
+
+static inline void ath10k_record_reg_access(struct ath10k *ar, u32 offset,
+					    u32 val, bool write)
+{
+}
+
+static inline void ath10k_record_wmi_event(struct ath10k *ar,
+					   enum ath10k_wmi_type type,
+					   u32 id, unsigned char *data)
+{
+}
+
+static inline void ath10k_record_ce_event(struct ath10k *ar,
+					  enum ath10k_ce_event event_type,
+					  int ce_id)
+{
+}
+
 #endif /* CONFIG_ATH10K_DEBUG */
 
 /* Avoid calling __ath10k_dbg() if debug_mask is not set and tracing
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 8440e64..cfc0ae2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -474,6 +474,7 @@ static void ath10k_snoc_write32(struct ath10k *ar, u32 offset, u32 value)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
+	ath10k_record_reg_access(ar, offset, value, true);
 	iowrite32(value, ar_snoc->mem + offset);
 }
 
@@ -482,7 +483,9 @@ static u32 ath10k_snoc_read32(struct ath10k *ar, u32 offset)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	u32 val;
 
+	ath10k_record_reg_access(ar, offset, 0, false);
 	val = ioread32(ar_snoc->mem + offset);
+	ath10k_record_reg_access(ar, offset, val, false);
 
 	return val;
 }
@@ -828,11 +831,13 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
 {
 	ath10k_ce_disable_interrupts(ar);
+	ath10k_record_ce_event(ar, ATH10K_IRQ_DISABLE, 0);
 }
 
 static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
 {
 	ath10k_ce_enable_interrupts(ar);
+	ath10k_record_ce_event(ar, ATH10K_IRQ_ENABLE, 0);
 }
 
 static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
@@ -1154,7 +1159,9 @@ static irqreturn_t ath10k_snoc_per_engine_handler(int irq, void *arg)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	int ce_id = ath10k_snoc_get_ce_id_from_irq(ar, irq);
 
+	ath10k_record_ce_event(ar, ATH10K_IRQ_ENTRY, ce_id);
 	if (ce_id < 0 || ce_id >= ARRAY_SIZE(ar_snoc->pipe_info)) {
+		ath10k_record_ce_event(ar, ATH10K_IRQ_EXIT, ce_id);
 		ath10k_warn(ar, "unexpected/invalid irq %d ce_id %d\n", irq,
 			    ce_id);
 		return IRQ_HANDLED;
@@ -1163,6 +1170,7 @@ static irqreturn_t ath10k_snoc_per_engine_handler(int irq, void *arg)
 	ath10k_snoc_irq_disable(ar);
 	napi_schedule(&ar->napi);
 
+	ath10k_record_ce_event(ar, ATH10K_IRQ_EXIT, ce_id);
 	return IRQ_HANDLED;
 }
 
@@ -1171,6 +1179,7 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
 	int done = 0;
 
+	ath10k_record_ce_event(ar, ATH10K_NAPI_POLL, 0);
 	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		napi_complete(ctx);
 		return done;
@@ -1182,6 +1191,9 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 	if (done < budget) {
 		napi_complete(ctx);
 		ath10k_snoc_irq_enable(ar);
+		ath10k_record_ce_event(ar, ATH10K_NAPI_COMPLETE, 0);
+	} else {
+		ath10k_record_ce_event(ar, ATH10K_NAPI_RESCHED, 0);
 	}
 
 	return done;
@@ -1655,6 +1667,11 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 	ar->ce_priv = &ar_snoc->ce;
 	msa_size = drv_data->msa_size;
 
+	ath10k_core_reg_access_history_init(ar, ATH10K_REG_ACCESS_HISTORY_MAX);
+	ath10k_core_wmi_event_history_init(ar, ATH10K_WMI_EVENT_HISTORY_MAX);
+	ath10k_core_wmi_cmd_history_init(ar, ATH10K_WMI_CMD_HISTORY_MAX);
+	ath10k_core_ce_event_history_init(ar, ATH10K_CE_EVENT_HISTORY_MAX);
+
 	ath10k_snoc_quirks_init(ar);
 
 	ret = ath10k_snoc_resource_init(ar);
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 932266d..9df5748 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -627,6 +627,7 @@ static void ath10k_wmi_tlv_op_rx(struct ath10k *ar, struct sk_buff *skb)
 	if (skb_pull(skb, sizeof(struct wmi_cmd_hdr)) == NULL)
 		goto out;
 
+	ath10k_record_wmi_event(ar, ATH10K_WMI_EVENT, id, skb->data);
 	trace_ath10k_wmi_event(ar, id, skb->data, skb->len);
 
 	consumed = ath10k_tm_event_wmi(ar, id, skb);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index a81a1ab..8ebd05c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1802,6 +1802,15 @@ struct sk_buff *ath10k_wmi_alloc_skb(struct ath10k *ar, u32 len)
 
 static void ath10k_wmi_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 {
+	struct wmi_cmd_hdr *cmd_hdr;
+	enum wmi_tlv_event_id id;
+
+	cmd_hdr = (struct wmi_cmd_hdr *)skb->data;
+	id = MS(__le32_to_cpu(cmd_hdr->cmd_id), WMI_CMD_HDR_CMD_ID);
+
+	ath10k_record_wmi_event(ar, ATH10K_WMI_TX_COMPL, id,
+				skb->data + sizeof(struct wmi_cmd_hdr));
+
 	dev_kfree_skb(skb);
 }
 
@@ -1912,6 +1921,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 
 	might_sleep();
 
+	ath10k_record_wmi_event(ar, ATH10K_WMI_CMD, cmd_id, skb->data);
 	if (cmd_id == WMI_CMD_UNSUPPORTED) {
 		ath10k_warn(ar, "wmi command %d is not supported by firmware\n",
 			    cmd_id);
-- 
2.7.4

