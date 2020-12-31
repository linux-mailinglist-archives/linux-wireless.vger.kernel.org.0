Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF64D2E7D4E
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Dec 2020 01:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgLaAGP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Dec 2020 19:06:15 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:47702 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgLaAGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Dec 2020 19:06:14 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0347813C2B3;
        Wed, 30 Dec 2020 16:05:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0347813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609373132;
        bh=s6MYRR66efeBM4Caw8/gweJuAhRqnIrureKUjgbz8Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/dWVl+NIuesaRaXRvh8bcYVcCwscY1VPIdk0u5lDKVp/WSL8XchMeYSYIFdNtyfi
         eue2yzCrEOdIKK+H194S+QzSO9+Wl0Krg3amo6JGFFrEsKOhq3sTsqcclFNrr9g7eH
         JKyqXNwUo8+UFuXSGyTGm+s7+KxsVPW/yDTUz9Wo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     luca@coelho.fi, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/6] iwlwifi:  Enable debug-overrides.
Date:   Wed, 30 Dec 2020 16:05:19 -0800
Message-Id: <20201231000523.14963-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201231000523.14963-1-greearb@candelatech.com>
References: <20201231000523.14963-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This is ported from the out-of-kernel backports iwlwifi driver.
It provides some options to change the radio's behaviour based
on a config file.  This is most useful for testing purposes.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    |   5 +
 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   7 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-cfg.c  | 381 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-cfg.h  | 277 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  87 ++++
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   7 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 203 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  10 +
 .../wireless/intel/iwlwifi/mvm/constants.h    | 106 +++++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  58 +++
 .../intel/iwlwifi/mvm/ftm-responder.c         |  11 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  79 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  26 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  53 +++
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   6 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  15 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |   6 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  37 ++
 21 files changed, 1379 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 1085afbefba8..167dfe611cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -143,6 +143,11 @@ config IWLWIFI_DEVICE_TRACING
 
 	  If unsure, say Y so we can help you better when problems
 	  occur.
+
+config IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	depends on IWLWIFI
+	bool "enable default value override (for debugging)"
+
 endmenu
 
 endif
diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 14b0db28143b..28c85d24cc98 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -20,6 +20,7 @@ iwlwifi-objs		+= fw/dbg.o fw/pnvm.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_IWLWIFI_DEBUGFS) += fw/debugfs.o
+iwlwifi-$(CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES) += iwl-dbg-cfg.o
 
 iwlwifi-objs += $(iwlwifi-m)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ab4a8b942c81..7fb04fc0c4b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2660,6 +2660,13 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (fwrt->trans->dbg_cfg.disable_wrt_dump) {
+		IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection disabled\n");
+		goto out;
+	}
+#endif
+	
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, true);
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection start\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 02c64b988a13..e5e57e2ad735 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -171,6 +171,7 @@ struct iwl_ucode_tlv {
 	u8 data[0];
 };
 
+#define IWL_TLV_FW_DBG_MAGIC            0xb5221389
 #define IWL_TLV_UCODE_MAGIC		0x0a4c5749
 #define FW_VER_HUMAN_READABLE_SZ	64
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
new file mode 100644
index 000000000000..223c716d9fce
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
+ * Copyright (C) 2013-2015, 2019-2020 Intel Corporation
+ * Copyright (C) 2016 Intel Deutschland GmbH
+ */
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/firmware.h>
+#include "iwl-dbg-cfg.h"
+#include "iwl-modparams.h"
+
+/* grab default values */
+#undef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+#include "fw/runtime.h"
+#if IS_ENABLED(CONFIG_IWLXVT)
+#include "xvt/constants.h"
+#endif
+#if IS_ENABLED(CONFIG_IWLMVM)
+#include "mvm/constants.h"
+#endif
+
+struct iwl_dbg_cfg current_dbg_config = {
+#define DBG_CFG_REINCLUDE
+#define IWL_DBG_CFG(type, name) \
+	.name = IWL_ ## name,
+#define IWL_DBG_CFG_STR(name) /* no default */
+#define IWL_DBG_CFG_NODEF(type, name) /* no default */
+#define IWL_DBG_CFG_BIN(name) /* nothing, default empty */
+#define IWL_DBG_CFG_BINA(name, max) /* nothing, default empty */
+#define IWL_MOD_PARAM(type, name) /* nothing, default empty */
+#define IWL_MVM_MOD_PARAM(type, name) /* nothing, default empty */
+#define IWL_DBG_CFG_RANGE(type, name, min, max)	\
+	.name = IWL_ ## name,
+#define IWL_DBG_CFG_FN(name, fn) /* no default */
+#include "iwl-dbg-cfg.h"
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+};
+
+static const char dbg_cfg_magic[] = "[IWL DEBUG CONFIG DATA]";
+
+#define DBG_CFG_LOADER(_type)							\
+static void __maybe_unused							\
+dbg_cfg_load_ ## _type(const char *name, const char *val,			\
+		       void *out, s64 min, s64 max)				\
+{										\
+	_type r;								\
+										\
+	if (kstrto ## _type(val, 0, &r)) {					\
+		printk(KERN_INFO "iwlwifi debug config: Invalid data for %s: %s\n",\
+		       name, val);						\
+		return;								\
+	}									\
+										\
+	if (min && max && (r < min || r > max)) {				\
+		printk(KERN_INFO "iwlwifi debug config: value %u for %s out of range [%lld,%lld]\n",\
+		       r, name, min, max);					\
+		return;								\
+	}									\
+										\
+	*(_type *)out = r;							\
+	printk(KERN_INFO "iwlwifi debug config: %s=%d\n", name, *(_type *)out);	\
+}
+
+DBG_CFG_LOADER(u8)
+DBG_CFG_LOADER(u16)
+DBG_CFG_LOADER(u32)
+DBG_CFG_LOADER(int)
+DBG_CFG_LOADER(uint)
+
+static void __maybe_unused
+dbg_cfg_load_bool(const char *name, const char *val,
+		  void *out, s64 min, s64 max)
+{
+	u8 v;
+
+	if (kstrtou8(val, 0, &v)) {
+		printk(KERN_INFO "iwlwifi debug config: Invalid data for %s: %s\n",
+		       name, val);
+	} else {
+		*(bool *)out = v;
+		printk(KERN_INFO "iwlwifi debug config: %s=%d\n",
+		       name, *(bool *)out);
+	}
+}
+
+static int __maybe_unused
+dbg_cfg_load_bin(const char *name, const char *val, struct iwl_dbg_cfg_bin *out)
+{
+	int len = strlen(val);
+	u8 *data;
+
+	if (len % 2)
+		goto error;
+	len /= 2;
+
+	data = kzalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (hex2bin(data, val, len)) {
+		kfree(data);
+		goto error;
+	}
+	out->data = data;
+	out->len = len;
+	printk(KERN_INFO "iwlwifi debug config: %d bytes for %s\n", len, name);
+	return 0;
+error:
+	printk(KERN_INFO "iwlwifi debug config: Invalid data for %s\n", name);
+	return -EINVAL;
+}
+
+static __maybe_unused void
+dbg_cfg_load_str(const char *name, const char *val, void *out, s64 min, s64 max)
+{
+	if (strlen(val) == 0) {
+		printk(KERN_INFO "iwlwifi debug config: Invalid data for %s\n",
+		       name);
+	} else {
+		*(char **)out = kstrdup(val, GFP_KERNEL);
+		printk(KERN_INFO "iwlwifi debug config: %s=%s\n",
+		       name, *(char **)out);
+	}
+}
+
+void iwl_dbg_cfg_free(struct iwl_dbg_cfg *dbgcfg)
+{
+#define IWL_DBG_CFG(t, n) /* nothing */
+#define IWL_DBG_CFG_STR(n)				\
+	kfree(dbgcfg->n);
+#define IWL_DBG_CFG_NODEF(t, n) /* nothing */
+#define IWL_DBG_CFG_BIN(n)				\
+	do {						\
+		kfree(dbgcfg->n.data);			\
+		dbgcfg->n.data = NULL;			\
+		dbgcfg->n.len = 0;			\
+	} while (0);
+#define IWL_DBG_CFG_BINA(n, max)			\
+	do {						\
+		int i;					\
+							\
+		for (i = 0; i < max; i++) {		\
+			kfree(dbgcfg->n[i].data);	\
+			dbgcfg->n[i].data = NULL;	\
+			dbgcfg->n[i].len = 0;		\
+		}					\
+		dbgcfg->n_ ## n = 0;			\
+	} while (0);
+#define IWL_DBG_CFG_RANGE(t, n, min, max) /* nothing */
+#define IWL_MOD_PARAM(t, n) /* nothing */
+#define IWL_MVM_MOD_PARAM(t, n) /* nothing */
+#define IWL_DBG_CFG_FN(name, fn) /* nothing */
+#include "iwl-dbg-cfg.h"
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+}
+
+struct iwl_dbg_cfg_loader {
+	const char *name;
+	s64 min, max;
+	void (*loader)(const char *name, const char *val,
+		       void *out, s64 min, s64 max);
+	u32 offset;
+};
+
+static const struct iwl_dbg_cfg_loader iwl_dbg_cfg_loaders[] = {
+#define IWL_DBG_CFG(t, n)					\
+	{							\
+		.name = #n,					\
+		.offset = offsetof(struct iwl_dbg_cfg, n),	\
+		.loader = dbg_cfg_load_##t,			\
+	},
+#define IWL_DBG_CFG_STR(n)					\
+	{							\
+		.name = #n,					\
+		.offset = offsetof(struct iwl_dbg_cfg, n),	\
+		.loader = dbg_cfg_load_str,			\
+	},
+#define IWL_DBG_CFG_NODEF(t, n) IWL_DBG_CFG(t, n)
+#define IWL_DBG_CFG_BIN(n) /* not using this */
+#define IWL_DBG_CFG_BINA(n, max) /* not using this */
+#define IWL_DBG_CFG_RANGE(t, n, _min, _max)			\
+	{							\
+		.name = #n,					\
+		.offset = offsetof(struct iwl_dbg_cfg, n),	\
+		.min = _min,					\
+		.max = _max,					\
+		.loader = dbg_cfg_load_##t,			\
+	},
+#define IWL_MOD_PARAM(t, n) /* no using this */
+#define IWL_MVM_MOD_PARAM(t, n) /* no using this */
+#define IWL_DBG_CFG_FN(name, fn) /* not using this */
+#include "iwl-dbg-cfg.h"
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+};
+
+static void iwl_dbg_cfg_parse_fw_dbg_preset(struct iwl_dbg_cfg *dbgcfg,
+					    const char *val)
+{
+	u8 preset;
+
+	if (kstrtou8(val, 0, &preset)) {
+		printk(KERN_INFO "iwlwifi debug config: Invalid data for FW_DBG_PRESET: %s\n",
+		       val);
+		return;
+	}
+
+	if (preset > 15) {
+		printk(KERN_INFO "iwlwifi debug config: Invalid value for FW_DBG_PRESET: %d\n",
+		       preset);
+		return;
+	}
+
+	dbgcfg->FW_DBG_DOMAIN &= 0xffff;
+	dbgcfg->FW_DBG_DOMAIN |= BIT(16 + preset);
+	printk(KERN_INFO "iwlwifi debug config: FW_DBG_PRESET=%d => FW_DBG_DOMAIN=0x%x\n",
+	       preset, dbgcfg->FW_DBG_DOMAIN);
+}
+
+void iwl_dbg_cfg_load_ini(struct device *dev, struct iwl_dbg_cfg *dbgcfg)
+{
+	const struct firmware *fw;
+	char *data, *end, *pos;
+	int err;
+
+	if (dbgcfg->loaded)
+		return;
+
+	/* TODO: maybe add a per-device file? */
+	err = firmware_request_nowarn(&fw, "iwl-dbg-cfg.ini", dev);
+	if (err)
+		return;
+
+	/* must be ini file style with magic section header */
+	if (fw->size < strlen(dbg_cfg_magic))
+		goto release;
+	if (memcmp(fw->data, dbg_cfg_magic, strlen(dbg_cfg_magic))) {
+		printk(KERN_INFO "iwlwifi debug config: file is malformed\n");
+		goto release;
+	}
+
+	/* +1 guarantees the last line gets NUL-terminated even without \n */
+	data = kzalloc(fw->size - strlen(dbg_cfg_magic) + 1, GFP_KERNEL);
+	if (!data)
+		goto release;
+	memcpy(data, fw->data + strlen(dbg_cfg_magic),
+	       fw->size - strlen(dbg_cfg_magic));
+	end = data + fw->size - strlen(dbg_cfg_magic);
+	/* replace CR/LF with NULs to make parsing easier */
+	for (pos = data; pos < end; pos++) {
+		if (*pos == '\n' || *pos == '\r')
+			*pos = '\0';
+	}
+
+	pos = data;
+	while (pos < end) {
+		const char *line = pos;
+		bool loaded = false;
+		int idx;
+
+		/* skip to next line */
+		while (pos < end && *pos)
+			pos++;
+		/* skip to start of next line, over empty ones if any */
+		while (pos < end && !*pos)
+			pos++;
+
+		/* skip empty lines and comments */
+		if (!*line || *line == '#')
+			continue;
+
+		for (idx = 0; idx < ARRAY_SIZE(iwl_dbg_cfg_loaders); idx++) {
+			const struct iwl_dbg_cfg_loader *l;
+
+			l = &iwl_dbg_cfg_loaders[idx];
+
+			if (strncmp(l->name, line, strlen(l->name)) == 0 &&
+			    line[strlen(l->name)] == '=') {
+				l->loader(l->name, line + strlen(l->name) + 1,
+					  (void *)((u8 *)dbgcfg + l->offset),
+					  l->min, l->max);
+				loaded = true;
+			}
+		}
+
+		/*
+		 * if it was loaded by the loaders, don't bother checking
+		 * more or printing an error message below
+		 */
+		if (loaded)
+			continue;
+
+#define IWL_DBG_CFG(t, n) /* handled above */
+#define IWL_DBG_CFG_NODEF(t, n) /* handled above */
+#define IWL_DBG_CFG_BIN(n)						\
+		if (strncmp(#n, line, strlen(#n)) == 0 &&		\
+		    line[strlen(#n)] == '=') {				\
+			dbg_cfg_load_bin(#n, line + strlen(#n) + 1,	\
+					 &dbgcfg->n);			\
+			continue;					\
+		}
+#define IWL_DBG_CFG_BINA(n, max)					\
+		if (strncmp(#n, line, strlen(#n)) == 0 &&		\
+		    line[strlen(#n)] == '=') {				\
+			if (dbgcfg->n_##n >= max) {			\
+				printk(KERN_INFO			\
+				       "iwlwifi debug config: " #n " given too many times\n");\
+				continue;				\
+			}						\
+			if (!dbg_cfg_load_bin(#n, line + strlen(#n) + 1,\
+					      &dbgcfg->n[dbgcfg->n_##n]))\
+				dbgcfg->n_##n++;			\
+			continue;					\
+		}
+#define IWL_DBG_CFG_RANGE(t, n, min, max) /* handled above */
+#define IWL_DBG_CFG_STR(n) /* handled above */
+#define IWL_MOD_PARAM(t, n)						\
+		if (strncmp(#n, line, strlen(#n)) == 0 &&		\
+		    line[strlen(#n)] == '=') {				\
+			dbg_cfg_load_##t(#n, line + strlen(#n) + 1,	\
+					 &iwlwifi_mod_params.n, 0, 0);	\
+			continue;					\
+		}
+#define IWL_MVM_MOD_PARAM(t, n)	{					\
+		if (strncmp("mvm." #n, line, strlen("mvm." #n)) == 0 &&	\
+		    line[strlen("mvm." #n)] == '=') {			\
+			dbg_cfg_load_##t("mvm." #n,			\
+					 line + strlen("mvm." #n) + 1,	\
+					 &dbgcfg->mvm_##n, 0, 0);	\
+			dbgcfg->__mvm_mod_param_##n = true;		\
+			continue;					\
+		}							\
+	}
+#define IWL_DBG_CFG_FN(n, fn)					\
+		if (strncmp(#n "=", line, strlen(#n) + 1) == 0) {	\
+			fn(dbgcfg, line + strlen(#n) + 1);		\
+			continue;					\
+		}
+#include "iwl-dbg-cfg.h"
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+		printk(KERN_INFO "iwlwifi debug config: failed to load line \"%s\"\n",
+		       line);
+	}
+
+	kfree(data);
+ release:
+	release_firmware(fw);
+	dbgcfg->loaded = true;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.h
new file mode 100644
index 000000000000..cfc6231b4bca
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-cfg.h
@@ -0,0 +1,277 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2013-2015, 2018-2020 Intel Corporation
+ * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
+ */
+#if !defined(__IWL_DBG_CFG_H__) || defined(DBG_CFG_REINCLUDE)
+#undef __IWL_DBG_CFG_H__ /* avoid warning */
+#define __IWL_DBG_CFG_H__
+/*
+ * with DBG_CFG_REINCLUDE set this file should contain nothing
+ * but IWL_DBG_CFG() macro invocations so it can be used in
+ * the C file to generate more code (e.g. for debugfs and the
+ * struct initialization with default values)
+ */
+#ifndef DBG_CFG_REINCLUDE
+#include <linux/types.h>
+
+struct iwl_dbg_cfg_bin {
+	const void *data;
+	unsigned int len;
+};
+
+struct iwl_dbg_cfg {
+	bool loaded;
+
+#define IWL_DBG_CFG(type, name)		type name;
+#define IWL_DBG_CFG_NODEF(type, name)	type name;
+#define IWL_DBG_CFG_BIN(name)		struct iwl_dbg_cfg_bin name;
+#define IWL_DBG_CFG_STR(name)	const char *name;
+#define IWL_DBG_CFG_BINA(name, max)	struct iwl_dbg_cfg_bin name[max]; \
+					int n_ ## name;
+#define IWL_DBG_CFG_RANGE(type, name, min, max)	IWL_DBG_CFG(type, name)
+#define IWL_MOD_PARAM(type, name)	/* do nothing */
+#define IWL_MVM_MOD_PARAM(type, name)	type mvm_##name; \
+					bool __mvm_mod_param_##name;
+#define IWL_DBG_CFG_FN(name, fn)	/* nothing */
+
+#endif /* DBG_CFG_REINCLUDE */
+#if IS_ENABLED(CONFIG_IWLXVT)
+	IWL_DBG_CFG(u32, XVT_DEFAULT_DBGM_MEM_POWER)
+	IWL_DBG_CFG(u32, XVT_DEFAULT_DBGM_LMAC_MASK)
+	IWL_DBG_CFG(u32, XVT_DEFAULT_DBGM_PRPH_MASK)
+	IWL_MOD_PARAM(bool, xvt_default_mode)
+#endif
+	IWL_DBG_CFG_NODEF(bool, disable_wrt_dump)
+	IWL_DBG_CFG_NODEF(bool, disable_52GHz)
+	IWL_DBG_CFG_NODEF(bool, disable_24GHz)
+#if IS_ENABLED(CONFIG_IWLMVM) || IS_ENABLED(CONFIG_IWLFMAC)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_OVERRIDE_CONTROL)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_INIT_FLOW)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_INIT_EVENT)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_D0_FLOW)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_D0_EVENT)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_D3_FLOW)
+	IWL_DBG_CFG_NODEF(u32, MVM_CALIB_D3_EVENT)
+	IWL_DBG_CFG_NODEF(bool, enable_timestamp_marker_cmd)
+#endif
+	IWL_DBG_CFG_NODEF(bool, STARTUP_RFKILL)
+#if IS_ENABLED(CONFIG_IWLMVM)
+	IWL_DBG_CFG(u32, MVM_DEFAULT_PS_TX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_DEFAULT_PS_RX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_WOWLAN_PS_TX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_WOWLAN_PS_RX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_SHORT_PS_TX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_SHORT_PS_RX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_UAPSD_TX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_UAPSD_RX_DATA_TIMEOUT)
+	IWL_DBG_CFG(u32, MVM_UAPSD_QUEUES)
+	IWL_DBG_CFG_NODEF(bool, MVM_USE_PS_POLL)
+	IWL_DBG_CFG(u8, MVM_PS_HEAVY_TX_THLD_PACKETS)
+	IWL_DBG_CFG(u8, MVM_PS_HEAVY_RX_THLD_PACKETS)
+	IWL_DBG_CFG(u8, MVM_PS_SNOOZE_HEAVY_TX_THLD_PACKETS)
+	IWL_DBG_CFG(u8, MVM_PS_SNOOZE_HEAVY_RX_THLD_PACKETS)
+	IWL_DBG_CFG(u8, MVM_PS_HEAVY_TX_THLD_PERCENT)
+	IWL_DBG_CFG(u8, MVM_PS_HEAVY_RX_THLD_PERCENT)
+	IWL_DBG_CFG(u16, MVM_PS_SNOOZE_INTERVAL)
+	IWL_DBG_CFG(u16, MVM_PS_SNOOZE_WINDOW)
+	IWL_DBG_CFG(u16, MVM_WOWLAN_PS_SNOOZE_WINDOW)
+	IWL_DBG_CFG(u8, MVM_LOWLAT_QUOTA_MIN_PERCENT)
+	IWL_DBG_CFG(u16, MVM_BT_COEX_EN_RED_TXP_THRESH)
+	IWL_DBG_CFG(u16, MVM_BT_COEX_DIS_RED_TXP_THRESH)
+	IWL_DBG_CFG(u32, MVM_BT_COEX_ANTENNA_COUPLING_THRS)
+	IWL_DBG_CFG(u32, MVM_BT_COEX_MPLUT_REG0)
+	IWL_DBG_CFG(u32, MVM_BT_COEX_MPLUT_REG1)
+	IWL_DBG_CFG(bool, MVM_BT_COEX_SYNC2SCO)
+	IWL_DBG_CFG(bool, MVM_BT_COEX_MPLUT)
+	IWL_DBG_CFG(bool, MVM_BT_COEX_TTC)
+	IWL_DBG_CFG(bool, MVM_BT_COEX_RRC)
+	IWL_DBG_CFG(bool, MVM_FW_MCAST_FILTER_PASS_ALL)
+	IWL_DBG_CFG(bool, MVM_FW_BCAST_FILTER_PASS_ALL)
+	IWL_DBG_CFG(bool, MVM_TOF_IS_RESPONDER)
+	IWL_DBG_CFG(bool, MVM_P2P_LOWLATENCY_PS_ENABLE)
+	IWL_DBG_CFG(bool, MVM_SW_TX_CSUM_OFFLOAD)
+	IWL_DBG_CFG(bool, MVM_HW_CSUM_DISABLE)
+	IWL_DBG_CFG(bool, MVM_PARSE_NVM)
+	IWL_DBG_CFG(bool, MVM_ADWELL_ENABLE)
+	IWL_DBG_CFG(bool, MVM_USE_NSSN_SYNC)
+	IWL_DBG_CFG(u16, MVM_ADWELL_MAX_BUDGET)
+	IWL_DBG_CFG(u32, MVM_TCM_LOAD_MEDIUM_THRESH)
+	IWL_DBG_CFG(u32, MVM_TCM_LOAD_HIGH_THRESH)
+	IWL_DBG_CFG(u32, MVM_TCM_LOWLAT_ENABLE_THRESH)
+	IWL_DBG_CFG(u32, MVM_UAPSD_NONAGG_PERIOD)
+	IWL_DBG_CFG_RANGE(u8, MVM_UAPSD_NOAGG_LIST_LEN,
+			  1, IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM)
+	IWL_DBG_CFG(bool, MVM_NON_TRANSMITTING_AP)
+	IWL_DBG_CFG(u32, MVM_PHY_FILTER_CHAIN_A)
+	IWL_DBG_CFG(u32, MVM_PHY_FILTER_CHAIN_B)
+	IWL_DBG_CFG(u32, MVM_PHY_FILTER_CHAIN_C)
+	IWL_DBG_CFG(u32, MVM_PHY_FILTER_CHAIN_D)
+	IWL_DBG_CFG(u8, MVM_QUOTA_THRESHOLD)
+	IWL_DBG_CFG(u8, MVM_RS_RSSI_BASED_INIT_RATE)
+	IWL_DBG_CFG(u8, MVM_RS_80_20_FAR_RANGE_TWEAK)
+	IWL_DBG_CFG(u8, MVM_RS_NUM_TRY_BEFORE_ANT_TOGGLE)
+	IWL_DBG_CFG(u8, MVM_RS_HT_VHT_RETRIES_PER_RATE)
+	IWL_DBG_CFG(u8, MVM_RS_HT_VHT_RETRIES_PER_RATE_TW)
+	IWL_DBG_CFG(u8, MVM_RS_INITIAL_MIMO_NUM_RATES)
+	IWL_DBG_CFG(u8, MVM_RS_INITIAL_SISO_NUM_RATES)
+	IWL_DBG_CFG(u8, MVM_RS_INITIAL_LEGACY_NUM_RATES)
+	IWL_DBG_CFG(u8, MVM_RS_INITIAL_LEGACY_RETRIES)
+	IWL_DBG_CFG(u8, MVM_RS_SECONDARY_LEGACY_RETRIES)
+	IWL_DBG_CFG(u8, MVM_RS_SECONDARY_LEGACY_NUM_RATES)
+	IWL_DBG_CFG(u8, MVM_RS_SECONDARY_SISO_NUM_RATES)
+	IWL_DBG_CFG(u8, MVM_RS_SECONDARY_SISO_RETRIES)
+	IWL_DBG_CFG(u8, MVM_RS_RATE_MIN_FAILURE_TH)
+	IWL_DBG_CFG(u8, MVM_RS_RATE_MIN_SUCCESS_TH)
+	IWL_DBG_CFG(u8, MVM_RS_STAY_IN_COLUMN_TIMEOUT)
+	IWL_DBG_CFG(u8, MVM_RS_IDLE_TIMEOUT)
+	IWL_DBG_CFG(u8, MVM_RS_MISSED_RATE_MAX)
+	IWL_DBG_CFG(u16, MVM_RS_LEGACY_FAILURE_LIMIT)
+	IWL_DBG_CFG(u16, MVM_RS_LEGACY_SUCCESS_LIMIT)
+	IWL_DBG_CFG(u16, MVM_RS_LEGACY_TABLE_COUNT)
+	IWL_DBG_CFG(u16, MVM_RS_NON_LEGACY_FAILURE_LIMIT)
+	IWL_DBG_CFG(u16, MVM_RS_NON_LEGACY_SUCCESS_LIMIT)
+	IWL_DBG_CFG(u16, MVM_RS_NON_LEGACY_TABLE_COUNT)
+	IWL_DBG_CFG(u16, MVM_RS_SR_FORCE_DECREASE)
+	IWL_DBG_CFG(u16, MVM_RS_SR_NO_DECREASE)
+	IWL_DBG_CFG(u16, MVM_RS_AGG_TIME_LIMIT)
+	IWL_DBG_CFG(u8, MVM_RS_AGG_DISABLE_START)
+	IWL_DBG_CFG(u8, MVM_RS_AGG_START_THRESHOLD)
+	IWL_DBG_CFG(u16, MVM_RS_TPC_SR_FORCE_INCREASE)
+	IWL_DBG_CFG(u16, MVM_RS_TPC_SR_NO_INCREASE)
+	IWL_DBG_CFG(u8, MVM_RS_TPC_TX_POWER_STEP)
+	IWL_DBG_CFG(bool, MVM_ENABLE_EBS)
+	IWL_DBG_CFG_NODEF(u16, MVM_FTM_RESP_TOA_OFFSET)
+	IWL_DBG_CFG_NODEF(u32, MVM_FTM_RESP_VALID)
+	IWL_DBG_CFG_NODEF(u32, MVM_FTM_RESP_FLAGS)
+	IWL_DBG_CFG(u8, MVM_FTM_INITIATOR_ALGO)
+	IWL_DBG_CFG(bool, MVM_FTM_INITIATOR_DYNACK)
+	IWL_DBG_CFG_NODEF(bool, MVM_FTM_INITIATOR_MCSI_ENABLED)
+	IWL_DBG_CFG_NODEF(int, MVM_FTM_INITIATOR_COMMON_CALIB)
+	IWL_DBG_CFG_NODEF(bool, MVM_FTM_INITIATOR_FAST_ALGO_DISABLE)
+	IWL_DBG_CFG(bool, MVM_D3_DEBUG)
+	IWL_DBG_CFG(bool, MVM_USE_TWT)
+	IWL_DBG_CFG(bool, MVM_TWT_TESTMODE)
+	IWL_DBG_CFG(u32, MVM_AMPDU_CONSEC_DROPS_DELBA)
+	IWL_MVM_MOD_PARAM(int, power_scheme)
+	IWL_MVM_MOD_PARAM(bool, init_dbg)
+	IWL_DBG_CFG(bool, MVM_FTM_INITIATOR_ENABLE_SMOOTH)
+	IWL_DBG_CFG_RANGE(u8, MVM_FTM_INITIATOR_SMOOTH_ALPHA, 0, 100)
+	/* 667200 is 200m RTT */
+	IWL_DBG_CFG_RANGE(u32, MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT, 0, 667200)
+	IWL_DBG_CFG_RANGE(u32, MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT, 0, 667200)
+	IWL_DBG_CFG(u32, MVM_FTM_INITIATOR_SMOOTH_AGE_SEC)
+	IWL_DBG_CFG(bool, MVM_DISABLE_AP_FILS)
+#endif /* CONFIG_IWLMVM */
+#ifdef CONFIG_IWLWIFI_DEVICE_TESTMODE
+	IWL_DBG_CFG_NODEF(u32, dnt_out_mode)
+	/* XXX: should be dbgm_ or dbg_mon_ for consistency? */
+	IWL_DBG_CFG_NODEF(u32, dbm_destination_path)
+	/* XXX: should be dbg_mon_ for consistency? */
+	IWL_DBG_CFG_NODEF(u32, dbgm_enable_mode)
+	IWL_DBG_CFG_NODEF(u32, dbgm_mem_power)
+	IWL_DBG_CFG_NODEF(u32, dbg_flags)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_ctl_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_ctl_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_buff_base_addr_reg_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_buff_end_addr_reg_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_data_sel_ctl_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_data_sel_ctl_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_mc_msk_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_mc_msk_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_mask_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_mask_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_start_mask_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_start_mask_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_end_mask_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_end_mask_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_end_threshold_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_end_threshold_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_period_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_sample_period_val)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_wr_ptr_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_cyc_cnt_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_dmarb_rd_ctl_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_dmarb_rd_data_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_marbh_conf_reg)
+	IWL_DBG_CFG_NODEF(u32, dbg_marbh_conf_mask)
+	IWL_DBG_CFG_NODEF(u32, dbg_marbh_access_type)
+	IWL_DBG_CFG_NODEF(u32, dbgc_hb_base_addr)
+	IWL_DBG_CFG_NODEF(u32, dbgc_hb_end_addr)
+	IWL_DBG_CFG_NODEF(u32, dbgc_dram_wrptr_addr)
+	IWL_DBG_CFG_NODEF(u32, dbgc_wrap_count_addr)
+	IWL_DBG_CFG_NODEF(u32, dbg_mipi_conf_reg)
+	IWL_DBG_CFG_NODEF(u32, dbg_mipi_conf_mask)
+	IWL_DBG_CFG_NODEF(u32, dbgc_hb_base_val_smem)
+	IWL_DBG_CFG_NODEF(u32, dbgc_hb_end_val_smem)
+	IWL_DBG_CFG_BIN(dbg_conf_monitor_host_command)
+	IWL_DBG_CFG_BIN(log_level_cmd)
+	IWL_DBG_CFG_BINA(ldbg_cmd, 32)
+	IWL_DBG_CFG_NODEF(u8, log_level_cmd_id)
+	IWL_DBG_CFG_NODEF(u8, dbg_conf_monitor_cmd_id)
+	IWL_DBG_CFG_NODEF(u8, ldbg_cmd_nums)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_buff_base_addr_reg_addr_b_step)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_buff_end_addr_reg_addr_b_step)
+	IWL_DBG_CFG_NODEF(u32, dbg_mon_wr_ptr_addr_b_step)
+#endif /* CONFIG_IWLWIFI_DEVICE_TESTMODE */
+	IWL_DBG_CFG_BIN(hw_address)
+	IWL_DBG_CFG_STR(fw_dbg_conf)
+	IWL_DBG_CFG_STR(nvm_file)
+	IWL_DBG_CFG_STR(fw_file_pre)
+	IWL_DBG_CFG_NODEF(u32, valid_ants)
+	IWL_DBG_CFG_NODEF(u32, no_ack_en)
+	IWL_DBG_CFG_NODEF(u32, ack_en)
+	IWL_DBG_CFG_NODEF(bool, no_ldpc)
+	IWL_DBG_CFG_NODEF(bool, smps_disabled)
+	IWL_DBG_CFG_NODEF(u16, rx_agg_subframes)
+	IWL_DBG_CFG_NODEF(u16, tx_agg_subframes)
+	IWL_DBG_CFG_NODEF(u16, ampdu_exponent_p1)
+	IWL_DBG_CFG_NODEF(bool, tx_siso_80bw_like_160bw)
+	IWL_DBG_CFG_NODEF(u16, ampdu_limit)
+	IWL_DBG_CFG_NODEF(u16, rx_mcs_80)
+	IWL_DBG_CFG_NODEF(u16, tx_mcs_80)
+	IWL_DBG_CFG_NODEF(u16, rx_mcs_160)
+	IWL_DBG_CFG_NODEF(u16, tx_mcs_160)
+	IWL_DBG_CFG_NODEF(u32, secure_boot_cfg)
+	IWL_MOD_PARAM(u32, uapsd_disable)
+	IWL_MOD_PARAM(bool, fw_restart)
+	IWL_MOD_PARAM(bool, power_save)
+	IWL_MOD_PARAM(bool, bt_coex_active)
+	IWL_MOD_PARAM(int, power_level)
+	IWL_MOD_PARAM(int, led_mode)
+	IWL_MOD_PARAM(int, amsdu_size)
+	IWL_MOD_PARAM(int, swcrypto)
+	IWL_MOD_PARAM(uint, disable_11n)
+	IWL_MOD_PARAM(bool, enable_ini)
+	IWL_DBG_CFG_BIN(he_ppe_thres)
+	IWL_DBG_CFG_NODEF(u8, he_chan_width_dis)
+	IWL_DBG_CFG_NODEF(u32, vht_cap_flip)
+	IWL_DBG_CFG_NODEF(u32, mu_edca)
+	IWL_DBG_CFG_BIN(he_mac_cap)
+	IWL_DBG_CFG_BIN(he_phy_cap)
+	IWL_DBG_CFG_NODEF(u32, FW_DBG_DOMAIN)
+	IWL_DBG_CFG_FN(FW_DBG_PRESET, iwl_dbg_cfg_parse_fw_dbg_preset)
+#ifdef CONFIG_IWLWIFI_DEBUG
+	IWL_MOD_PARAM(u32, debug_level)
+#endif /* CONFIG_IWLWIFI_DEBUG */
+#ifdef CONFIG_IWLWIFI_DISALLOW_OLDER_FW
+	IWL_DBG_CFG_NODEF(bool, load_old_fw)
+#endif /* CONFIG_IWLWIFI_DISALLOW_OLDER_FW */
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+#ifndef DBG_CFG_REINCLUDE
+};
+
+extern struct iwl_dbg_cfg current_dbg_config;
+void iwl_dbg_cfg_free(struct iwl_dbg_cfg *dbgcfg);
+void iwl_dbg_cfg_load_ini(struct device *dev, struct iwl_dbg_cfg *dbgcfg);
+#endif /* DBG_CFG_REINCLUDE */
+
+#endif /* __IWL_DBG_CFG_H__ || DBG_CFG_REINCLUDE */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 9dcd2e990c9c..206e8b9be469 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -76,6 +76,9 @@
 #include "iwl-config.h"
 #include "iwl-modparams.h"
 #include "fw/api/alive.h"
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+#include "iwl-dbg-cfg.h"
+#endif
 #include "fw/api/mac.h"
 
 /******************************************************************************
@@ -216,6 +219,9 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 {
 	const struct iwl_cfg *cfg = drv->trans->cfg;
 	char tag[8];
+#if defined(CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES)
+	char fw_name_temp[64];
+#endif
 
 	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_B_STEP &&
@@ -255,6 +261,15 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s%s.ucode",
 		 cfg->fw_name_pre, tag);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (drv->trans->dbg_cfg.fw_file_pre) {
+		snprintf(fw_name_temp, sizeof(fw_name_temp), "%s%s",
+			 drv->trans->dbg_cfg.fw_file_pre, drv->firmware_name);
+		strncpy(drv->firmware_name, fw_name_temp,
+			sizeof(drv->firmware_name));
+	}
+#endif /* CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES */
+
 	IWL_DEBUG_FW_INFO(drv, "attempting to load firmware '%s'\n",
 			  drv->firmware_name);
 
@@ -625,6 +640,17 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	int num_of_cpus;
 	bool usniffer_req = false;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (ucode->magic == cpu_to_le32(IWL_TLV_FW_DBG_MAGIC)) {
+		size_t dbg_data_ofs = offsetof(struct iwl_tlv_ucode_header,
+					       human_readable);
+		data = (void *)ucode_raw->data + dbg_data_ofs;
+		len -= dbg_data_ofs;
+
+		goto fw_dbg_conf;
+	}
+#endif
+
 	if (len < sizeof(*ucode)) {
 		IWL_ERR(drv, "uCode has invalid length: %zd\n", len);
 		return -EINVAL;
@@ -659,6 +685,10 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 	len -= sizeof(*ucode);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+fw_dbg_conf:
+#endif
+
 	while (len >= sizeof(*tlv)) {
 		len -= sizeof(*tlv);
 		tlv = (void *)data;
@@ -842,6 +872,27 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			if (tlv_len != sizeof(u32))
 				goto invalid_tlv_len;
 			drv->fw.phy_config = le32_to_cpup((__le32 *)tlv_data);
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+			if (drv->trans->dbg_cfg.valid_ants & ~ANT_ABC)
+				IWL_ERR(drv,
+					"Invalid value for antennas: 0x%x\n",
+					drv->trans->dbg_cfg.valid_ants);
+			/* Make sure value stays in range */
+			drv->trans->dbg_cfg.valid_ants &= ANT_ABC;
+			if (drv->trans->dbg_cfg.valid_ants) {
+				u32 phy_config = ~(FW_PHY_CFG_TX_CHAIN |
+						   FW_PHY_CFG_RX_CHAIN);
+
+				phy_config |=
+					(drv->trans->dbg_cfg.valid_ants <<
+					 FW_PHY_CFG_TX_CHAIN_POS);
+				phy_config |=
+					(drv->trans->dbg_cfg.valid_ants <<
+					 FW_PHY_CFG_RX_CHAIN_POS);
+
+				drv->fw.phy_config &= phy_config;
+			}
+#endif
 			drv->fw.valid_tx_ant = (drv->fw.phy_config &
 						FW_PHY_CFG_TX_CHAIN) >>
 						FW_PHY_CFG_TX_CHAIN_POS;
@@ -1358,6 +1409,11 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	bool load_module = false;
 	bool usniffer_images = false;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	const struct firmware *fw_dbg_config;
+	int load_fw_dbg_err = -ENOENT;
+#endif
+	
 	fw->ucode_capa.max_probe_length = IWL_DEFAULT_MAX_PROBE_LENGTH;
 	fw->ucode_capa.standard_phy_calibration_size =
 			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
@@ -1394,6 +1450,23 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	if (err)
 		goto try_again;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (!ucode->ver && drv->trans->dbg_cfg.fw_dbg_conf) {
+		load_fw_dbg_err =
+			request_firmware(&fw_dbg_config,
+					 drv->trans->dbg_cfg.fw_dbg_conf,
+					 drv->trans->dev);
+		if (!load_fw_dbg_err) {
+			err = iwl_parse_tlv_firmware(drv, fw_dbg_config, pieces,
+						     &fw->ucode_capa,
+						     &usniffer_images);
+			if (err)
+				IWL_ERR(drv,
+					"Failed to configure FW DBG data!\n");
+		}
+	}
+#endif
+	
 	if (fw_has_api(&drv->fw.ucode_capa, IWL_UCODE_TLV_API_NEW_VERSION))
 		api_ver = drv->fw.ucode_ver;
 	else
@@ -1572,6 +1645,11 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	/* We have our copies now, allow OS release its copies */
 	release_firmware(ucode_raw);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (!load_fw_dbg_err)
+		release_firmware(fw_dbg_config);
+#endif
+	
 	mutex_lock(&iwlwifi_opmode_table_mtx);
 	switch (fw->type) {
 	case IWL_FW_DVM:
@@ -1666,6 +1744,12 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 	init_completion(&drv->request_firmware_complete);
 	INIT_LIST_HEAD(&drv->list);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+        trans->dbg_cfg = current_dbg_config;
+        iwl_dbg_cfg_load_ini(drv->trans->dev, &drv->trans->dbg_cfg);
+#endif
+
+
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the device debugfs entries. */
 	drv->dbgfs_drv = debugfs_create_dir(dev_name(trans->dev),
@@ -1719,6 +1803,9 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	debugfs_remove_recursive(drv->dbgfs_drv);
 #endif
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	iwl_dbg_cfg_free(&drv->trans->dbg_cfg);
+#endif
 	iwl_dbg_tlv_free(drv->trans);
 
 	kfree(drv);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index cf7e2a9232e5..f3d1da746a1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -774,6 +774,13 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	ht_info->ampdu_factor = cfg->max_ht_ampdu_exponent;
 	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.ampdu_exponent_p1) {
+		ht_info->ampdu_factor = min((u16)(trans->dbg_cfg.ampdu_exponent_p1 - 1),
+					    (u16)(ht_info->ampdu_factor));
+	}
+#endif
+
 	ht_info->mcs.rx_mask[0] = 0xFF;
 	if (rx_chains >= 2)
 		ht_info->mcs.rx_mask[1] = 0xFF;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 6d19de3058d2..c85209ea7005 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -500,6 +500,13 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 	unsigned int max_ampdu_exponent = (cfg->max_vht_ampdu_exponent ?:
 					   IEEE80211_VHT_MAX_AMPDU_1024K);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.ampdu_exponent_p1) {
+		max_ampdu_exponent = min((unsigned int)(trans->dbg_cfg.ampdu_exponent_p1 - 1),
+					 max_ampdu_exponent);
+	}
+#endif
+
 	vht_cap->vht_supported = true;
 
 	vht_cap->cap = IEEE80211_VHT_CAP_SHORT_GI_80 |
@@ -574,6 +581,10 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 			cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2);
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	vht_cap->cap ^= trans->dbg_cfg.vht_cap_flip;
+#endif
+
 	vht_cap->vht_mcs.tx_mcs_map = vht_cap->vht_mcs.rx_mcs_map;
 
 	vht_cap->vht_mcs.tx_highest |=
@@ -763,8 +774,157 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 			iwl_he_capa[i].he_cap.he_cap_elem.phy_cap_info[7] &=
 				~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
 		}
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+		if (trans->dbg_cfg.ampdu_exponent_p1) {
+			/* Use whatever is set in the VHT element. */
+			iwl_he_capa[i].he_cap.he_cap_elem.mac_cap_info[3] &= ~IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK;
+			iwl_he_capa[i].he_cap.he_cap_elem.mac_cap_info[3] |= IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_USE_VHT;
+		}
+#endif
+	}
+}
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+/* returns true iff there exists one spatial stream where MCS of a > b */
+static bool iwl_he_mcs_greater(u16 a, u16 b)
+{
+	int i;
+
+	for (i = 0; i < 16; i += 2) {
+		if ((((a >> i) + 1) & 3) > (((b >> i) + 1) & 3))
+			return true;
+	}
+	return false;
+}
+
+static void iwl_init_he_override(struct iwl_trans *trans,
+				 struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_sband_iftype_data *iftype_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iwl_he_capa); i++) {
+		iftype_data = &iwl_he_capa[i];
+
+		if (trans->dbg_cfg.rx_mcs_80) {
+			if (iwl_he_mcs_greater(trans->dbg_cfg.rx_mcs_80,
+					       le16_to_cpu(iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80)))
+				IWL_ERR(trans,
+					"Cannot set dbg rx_mcs_80 = 0x%x (too big)\n",
+					trans->dbg_cfg.rx_mcs_80);
+			else
+				iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80 =
+					cpu_to_le16(trans->dbg_cfg.rx_mcs_80);
+		}
+		if (trans->dbg_cfg.tx_mcs_80) {
+			if (iwl_he_mcs_greater(trans->dbg_cfg.tx_mcs_80,
+					       le16_to_cpu(iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80)))
+				IWL_ERR(trans,
+					"Cannot set dbg tx_mcs_80 = 0x%x (too big)\n",
+					trans->dbg_cfg.tx_mcs_80);
+			else
+				iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80 =
+					cpu_to_le16(trans->dbg_cfg.tx_mcs_80);
+		}
+		if (trans->dbg_cfg.rx_mcs_160) {
+			if (iwl_he_mcs_greater(trans->dbg_cfg.rx_mcs_160,
+					       le16_to_cpu(iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160)))
+				IWL_ERR(trans,
+					"Cannot set dbg rx_mcs_160 = 0x%x (too big)\n",
+					trans->dbg_cfg.rx_mcs_160);
+			else
+				iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160 =
+					cpu_to_le16(trans->dbg_cfg.rx_mcs_160);
+		}
+		if (trans->dbg_cfg.tx_mcs_160) {
+			if (iwl_he_mcs_greater(trans->dbg_cfg.tx_mcs_160,
+					       le16_to_cpu(iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160)))
+				IWL_ERR(trans,
+					"Cannot set dbg tx_mcs_160 = 0x%x (too big)\n",
+					trans->dbg_cfg.tx_mcs_160);
+			else
+				iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160 =
+					cpu_to_le16(trans->dbg_cfg.tx_mcs_160);
+		}
+
+		/*
+		 * If antennas were forced - make sure not declaring MIMO when
+		 * we actually are SISO
+		 * Recall that there are 2 bits per stream in the "HE Tx/Rx HE
+		 * MCS NSS Support Field", so if some antenna is forced on but
+		 * not both A and B - we should work in SISO mode, so mark the
+		 * 2nd SS as not supported
+		 */
+		if (trans->dbg_cfg.valid_ants &&
+		    (trans->dbg_cfg.valid_ants & ANT_AB) != ANT_AB) {
+			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_160 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_160 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+			iftype_data->he_cap.he_mcs_nss_supp.rx_mcs_80p80 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+			iftype_data->he_cap.he_mcs_nss_supp.tx_mcs_80p80 |=
+				cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		}
+
+		if (trans->dbg_cfg.no_ldpc)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[1] &=
+				~IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+
+		/* Check if any HE capabilities need to be set for debug */
+		if (trans->dbg_cfg.he_ppe_thres.len) {
+			u8 len = trans->dbg_cfg.he_ppe_thres.len;
+
+			if (len > sizeof(iftype_data->he_cap.ppe_thres))
+				len = sizeof(iftype_data->he_cap.ppe_thres);
+			memcpy(iftype_data->he_cap.ppe_thres,
+			       trans->dbg_cfg.he_ppe_thres.data, len);
+		}
+
+		if (trans->dbg_cfg.he_chan_width_dis)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[0] &=
+					~(trans->dbg_cfg.he_chan_width_dis << 1);
+
+		if (trans->dbg_cfg.he_mac_cap.len) {
+			if (trans->dbg_cfg.he_mac_cap.len !=
+			    sizeof(iftype_data->he_cap.he_cap_elem.mac_cap_info)) {
+				IWL_ERR(trans,
+					"Wrong he_mac_cap len %u, should be %zu\n",
+					trans->dbg_cfg.he_mac_cap.len,
+					sizeof(iftype_data->he_cap.he_cap_elem.mac_cap_info));
+			} else {
+				memcpy(iftype_data->he_cap.he_cap_elem.mac_cap_info,
+				       trans->dbg_cfg.he_mac_cap.data,
+				       trans->dbg_cfg.he_mac_cap.len);
+			}
+		}
+		if (trans->dbg_cfg.he_phy_cap.len) {
+			if (trans->dbg_cfg.he_phy_cap.len !=
+			    sizeof(iftype_data->he_cap.he_cap_elem.phy_cap_info)) {
+				IWL_ERR(trans,
+					"Wrong he_phy_cap len %u, should be %zu\n",
+					trans->dbg_cfg.he_phy_cap.len,
+					sizeof(iftype_data->he_cap.he_cap_elem.phy_cap_info));
+			} else {
+				memcpy(iftype_data->he_cap.he_cap_elem.phy_cap_info,
+				       trans->dbg_cfg.he_phy_cap.data,
+				       trans->dbg_cfg.he_phy_cap.len);
+			}
+		}
+
+		if (iftype_data->types_mask == BIT(NL80211_IFTYPE_STATION) &&
+		    trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+			iftype_data->he_cap.he_cap_elem.phy_cap_info[2] |=
+				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+				IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+
 	}
 }
+#endif
 
 static void iwl_init_sbands(struct iwl_trans *trans,
 			    struct iwl_nvm_data *data,
@@ -961,6 +1121,19 @@ static int iwl_set_hw_address(struct iwl_trans *trans,
 			      struct iwl_nvm_data *data, const __be16 *nvm_hw,
 			      const __le16 *mac_override)
 {
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	struct iwl_dbg_cfg *dbg_cfg = &trans->dbg_cfg;
+
+	if (dbg_cfg->hw_address.len) {
+		if (dbg_cfg->hw_address.len == ETH_ALEN &&
+		    is_valid_ether_addr(dbg_cfg->hw_address.data)) {
+			memcpy(data->hw_addr, dbg_cfg->hw_address.data,
+			       ETH_ALEN);
+			return 0;
+		}
+		IWL_ERR(trans, "mac address from config file is invalid\n");
+	}
+#endif
 	if (cfg->mac_addr_from_csr) {
 		iwl_set_hw_address_from_csr(trans, data);
 	} else if (cfg->nvm_type != IWL_NVM_EXT) {
@@ -1060,6 +1233,16 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		rx_chains &= data->valid_rx_ant;
 
 	sku = iwl_get_sku(cfg, nvm_sw, phy_sku);
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.disable_52GHz)
+		/* remove support for 5.2 */
+		sku &= ~NVM_SKU_CAP_BAND_52GHZ;
+	if (trans->dbg_cfg.disable_24GHz)
+		/* remove support for 2.4 */
+		sku &= ~NVM_SKU_CAP_BAND_24GHZ;
+#endif
+
 	data->sku_cap_band_24ghz_enable = sku & NVM_SKU_CAP_BAND_24GHZ;
 	data->sku_cap_band_52ghz_enable = sku & NVM_SKU_CAP_BAND_52GHZ;
 	data->sku_cap_11n_enable = sku & NVM_SKU_CAP_11N_ENABLE;
@@ -1106,6 +1289,10 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		return NULL;
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	iwl_init_he_override(trans, &data->bands[NL80211_BAND_2GHZ]);
+	iwl_init_he_override(trans, &data->bands[NL80211_BAND_5GHZ]);
+#endif
 	if (lar_enabled &&
 	    fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_LAR_SUPPORT))
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
@@ -1571,6 +1758,18 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	iwl_set_hw_address_from_csr(trans, nvm);
 	/* TODO: if platform NVM has MAC address - override it here */
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.hw_address.len) {
+		if (trans->dbg_cfg.hw_address.len == ETH_ALEN &&
+		    is_valid_ether_addr(trans->dbg_cfg.hw_address.data))
+			memcpy(nvm->hw_addr,
+			       trans->dbg_cfg.hw_address.data, ETH_ALEN);
+		else
+			IWL_ERR(trans,
+				"mac address from config file is invalid\n");
+	}
+#endif
+
 	if (!is_valid_ether_addr(nvm->hw_addr)) {
 		IWL_ERR(trans, "no valid mac address was found\n");
 		ret = -EINVAL;
@@ -1613,6 +1812,10 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	iwl_init_he_override(trans, &nvm->bands[NL80211_BAND_2GHZ]);
+	iwl_init_he_override(trans, &nvm->bands[NL80211_BAND_5GHZ]);
+#endif
 	rsp_v3 = (void *)rsp;
 	channel_profile = v4 ? (void *)rsp->regulatory.channel_profile :
 			  (void *)rsp_v3->regulatory.channel_profile;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index fa3f15778fc7..8fbf00648c5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -417,6 +417,10 @@ enum {
 /* device family 22000 WPROT register */
 #define PREG_PRPH_WPROT_22000		0xA04D00
 
+#define SB_CFG_OVERRIDE_ADDR		0xA26C78
+#define SB_CFG_OVERRIDE_ENABLE		0x8000
+#define SB_CFG_BASE_OVERRIDE		0xA20000
+#define SB_MODIFY_CFG_FLAG		0xA03088
 #define SB_CPU_1_STATUS			0xA01E30
 #define SB_CPU_2_STATUS			0xA01E34
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 11a040e75bf3..d3a1333e6334 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -74,6 +74,9 @@
 #include "fw/img.h"
 #include "iwl-op-mode.h"
 #include <linux/firmware.h>
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+#include "iwl-dbg-cfg.h"
+#endif
 #include "fw/api/cmdhdr.h"
 #include "fw/api/txq.h"
 #include "fw/api/dbg-tlv.h"
@@ -113,7 +116,11 @@
  *	6) Eventually, the free function will be called.
  */
 
+#ifndef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
 #define IWL_TRANS_FW_DBG_DOMAIN(trans)	IWL_FW_INI_DOMAIN_ALWAYS_ON
+#else
+#define IWL_TRANS_FW_DBG_DOMAIN(trans)	((trans)->dbg_cfg.FW_DBG_DOMAIN)
+#endif
 
 #define FH_RSCSR_FRAME_SIZE_MSK		0x00003FFF	/* bits 0-13 */
 #define FH_RSCSR_FRAME_INVALID		0x55550000
@@ -1027,6 +1034,9 @@ struct iwl_trans {
 	struct lockdep_map sync_cmd_lockdep_map;
 #endif
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	struct iwl_dbg_cfg dbg_cfg;
+#endif
 	struct iwl_trans_debug dbg;
 	struct iwl_self_init_dram init_dram;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 2487871eac73..a2b816eaf04d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -69,6 +69,7 @@
 
 #define IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM		20
 
+#ifndef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_WOWLAN_PS_TX_DATA_TIMEOUT	(10 * USEC_PER_MSEC)
@@ -153,17 +154,122 @@
 #define IWL_MVM_FTM_INITIATOR_DYNACK		true
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
+#define IWL_MVM_TWT_TESTMODE                    false
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
 #define IWL_MVM_USE_NSSN_SYNC			0
 #define IWL_MVM_PHY_FILTER_CHAIN_A		0
 #define IWL_MVM_PHY_FILTER_CHAIN_B		0
 #define IWL_MVM_PHY_FILTER_CHAIN_C		0
 #define IWL_MVM_PHY_FILTER_CHAIN_D		0
+#define IWL_MVM_DISABLE_AP_FILS                 false
 #define IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH     false
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA      40
 /*  20016 pSec is 6 meter RTT, meaning 3 meter range */
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT 20016
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT  20016
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC    2
+#else /* CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES */
+#define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_DEFAULT_PS_TX_DATA_TIMEOUT)
+#define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_DEFAULT_PS_RX_DATA_TIMEOUT)
+#define IWL_MVM_WOWLAN_PS_TX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_WOWLAN_PS_TX_DATA_TIMEOUT)
+#define IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_WOWLAN_PS_RX_DATA_TIMEOUT)
+#define IWL_MVM_SHORT_PS_TX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_SHORT_PS_TX_DATA_TIMEOUT)
+#define IWL_MVM_SHORT_PS_RX_DATA_TIMEOUT	(mvm->trans->dbg_cfg.MVM_SHORT_PS_RX_DATA_TIMEOUT)
+#define IWL_MVM_P2P_LOWLATENCY_PS_ENABLE	(mvm->trans->dbg_cfg.MVM_P2P_LOWLATENCY_PS_ENABLE)
+#define IWL_MVM_UAPSD_TX_DATA_TIMEOUT		(mvm->trans->dbg_cfg.MVM_UAPSD_TX_DATA_TIMEOUT)
+#define IWL_MVM_UAPSD_RX_DATA_TIMEOUT		(mvm->trans->dbg_cfg.MVM_UAPSD_RX_DATA_TIMEOUT)
+#define IWL_MVM_UAPSD_QUEUES			(mvm->trans->dbg_cfg.MVM_UAPSD_QUEUES)
+#define IWL_MVM_PS_HEAVY_TX_THLD_PACKETS	(mvm->trans->dbg_cfg.MVM_PS_HEAVY_TX_THLD_PACKETS)
+#define IWL_MVM_PS_HEAVY_RX_THLD_PACKETS	(mvm->trans->dbg_cfg.MVM_PS_HEAVY_RX_THLD_PACKETS)
+#define IWL_MVM_PS_SNOOZE_HEAVY_TX_THLD_PACKETS	(mvm->trans->dbg_cfg.MVM_PS_SNOOZE_HEAVY_TX_THLD_PACKETS)
+#define IWL_MVM_PS_SNOOZE_HEAVY_RX_THLD_PACKETS	(mvm->trans->dbg_cfg.MVM_PS_SNOOZE_HEAVY_RX_THLD_PACKETS)
+#define IWL_MVM_PS_HEAVY_TX_THLD_PERCENT	(mvm->trans->dbg_cfg.MVM_PS_HEAVY_TX_THLD_PERCENT)
+#define IWL_MVM_PS_HEAVY_RX_THLD_PERCENT	(mvm->trans->dbg_cfg.MVM_PS_HEAVY_RX_THLD_PERCENT)
+#define IWL_MVM_PS_SNOOZE_INTERVAL		(mvm->trans->dbg_cfg.MVM_PS_SNOOZE_INTERVAL)
+#define IWL_MVM_PS_SNOOZE_WINDOW		(mvm->trans->dbg_cfg.MVM_PS_SNOOZE_WINDOW)
+#define IWL_MVM_WOWLAN_PS_SNOOZE_WINDOW		(mvm->trans->dbg_cfg.MVM_WOWLAN_PS_SNOOZE_WINDOW)
+#define IWL_MVM_LOWLAT_QUOTA_MIN_PERCENT	(mvm->trans->dbg_cfg.MVM_LOWLAT_QUOTA_MIN_PERCENT)
+#define IWL_MVM_BT_COEX_EN_RED_TXP_THRESH	(mvm->trans->dbg_cfg.MVM_BT_COEX_EN_RED_TXP_THRESH)
+#define IWL_MVM_BT_COEX_DIS_RED_TXP_THRESH	(mvm->trans->dbg_cfg.MVM_BT_COEX_DIS_RED_TXP_THRESH)
+#define IWL_MVM_BT_COEX_SYNC2SCO		(mvm->trans->dbg_cfg.MVM_BT_COEX_SYNC2SCO)
+#define IWL_MVM_BT_COEX_MPLUT			(mvm->trans->dbg_cfg.MVM_BT_COEX_MPLUT)
+#define IWL_MVM_BT_COEX_RRC			(mvm->trans->dbg_cfg.MVM_BT_COEX_RRC)
+#define IWL_MVM_BT_COEX_TTC			(mvm->trans->dbg_cfg.MVM_BT_COEX_TTC)
+#define IWL_MVM_BT_COEX_MPLUT_REG0		(mvm->trans->dbg_cfg.MVM_BT_COEX_MPLUT_REG0)
+#define IWL_MVM_BT_COEX_MPLUT_REG1		(mvm->trans->dbg_cfg.MVM_BT_COEX_MPLUT_REG1)
+#define IWL_MVM_BT_COEX_ANTENNA_COUPLING_THRS	(mvm->trans->dbg_cfg.MVM_BT_COEX_ANTENNA_COUPLING_THRS)
+#define IWL_MVM_FW_MCAST_FILTER_PASS_ALL	(mvm->trans->dbg_cfg.MVM_FW_MCAST_FILTER_PASS_ALL)
+#define IWL_MVM_FW_BCAST_FILTER_PASS_ALL	(mvm->trans->dbg_cfg.MVM_FW_BCAST_FILTER_PASS_ALL)
+#define IWL_MVM_TOF_IS_RESPONDER		(mvm->trans->dbg_cfg.MVM_TOF_IS_RESPONDER)
+#define IWL_MVM_SW_TX_CSUM_OFFLOAD		(mvm->trans->dbg_cfg.MVM_SW_TX_CSUM_OFFLOAD)
+#define IWL_MVM_HW_CSUM_DISABLE			(mvm->trans->dbg_cfg.MVM_HW_CSUM_DISABLE)
+#define IWL_MVM_PARSE_NVM			(mvm->trans->dbg_cfg.MVM_PARSE_NVM)
+#define IWL_MVM_ADWELL_ENABLE			(mvm->trans->dbg_cfg.MVM_ADWELL_ENABLE)
+#define IWL_MVM_ADWELL_MAX_BUDGET		(mvm->trans->dbg_cfg.MVM_ADWELL_MAX_BUDGET)
+#define IWL_MVM_TCM_LOAD_MEDIUM_THRESH		(mvm->trans->dbg_cfg.MVM_TCM_LOAD_MEDIUM_THRESH)
+#define IWL_MVM_TCM_LOAD_HIGH_THRESH		(mvm->trans->dbg_cfg.MVM_TCM_LOAD_HIGH_THRESH)
+#define IWL_MVM_TCM_LOWLAT_ENABLE_THRESH	(mvm->trans->dbg_cfg.MVM_TCM_LOWLAT_ENABLE_THRESH)
+#define IWL_MVM_UAPSD_NONAGG_PERIOD		(mvm->trans->dbg_cfg.MVM_UAPSD_NONAGG_PERIOD)
+#define IWL_MVM_UAPSD_NOAGG_LIST_LEN		(mvm->trans->dbg_cfg.MVM_UAPSD_NOAGG_LIST_LEN)
+#define IWL_MVM_NON_TRANSMITTING_AP		(mvm->trans->dbg_cfg.MVM_NON_TRANSMITTING_AP)
+#define IWL_MVM_QUOTA_THRESHOLD			(mvm->trans->dbg_cfg.MVM_QUOTA_THRESHOLD)
+#define IWL_MVM_RS_RSSI_BASED_INIT_RATE         (mvm->trans->dbg_cfg.MVM_RS_RSSI_BASED_INIT_RATE)
+#define IWL_MVM_RS_80_20_FAR_RANGE_TWEAK	(mvm->trans->dbg_cfg.MVM_RS_80_20_FAR_RANGE_TWEAK)
+#define IWL_MVM_RS_NUM_TRY_BEFORE_ANT_TOGGLE    (mvm->trans->dbg_cfg.MVM_RS_NUM_TRY_BEFORE_ANT_TOGGLE)
+#define IWL_MVM_RS_HT_VHT_RETRIES_PER_RATE      (mvm->trans->dbg_cfg.MVM_RS_HT_VHT_RETRIES_PER_RATE)
+#define IWL_MVM_RS_HT_VHT_RETRIES_PER_RATE_TW   (mvm->trans->dbg_cfg.MVM_RS_HT_VHT_RETRIES_PER_RATE_TW)
+#define IWL_MVM_RS_INITIAL_MIMO_NUM_RATES       (mvm->trans->dbg_cfg.MVM_RS_INITIAL_MIMO_NUM_RATES)
+#define IWL_MVM_RS_INITIAL_SISO_NUM_RATES       (mvm->trans->dbg_cfg.MVM_RS_INITIAL_SISO_NUM_RATES)
+#define IWL_MVM_RS_INITIAL_LEGACY_NUM_RATES     (mvm->trans->dbg_cfg.MVM_RS_INITIAL_LEGACY_NUM_RATES)
+#define IWL_MVM_RS_INITIAL_LEGACY_RETRIES       (mvm->trans->dbg_cfg.MVM_RS_INITIAL_LEGACY_RETRIES)
+#define IWL_MVM_RS_SECONDARY_LEGACY_RETRIES     (mvm->trans->dbg_cfg.MVM_RS_SECONDARY_LEGACY_RETRIES)
+#define IWL_MVM_RS_SECONDARY_LEGACY_NUM_RATES   (mvm->trans->dbg_cfg.MVM_RS_SECONDARY_LEGACY_NUM_RATES)
+#define IWL_MVM_RS_SECONDARY_SISO_NUM_RATES     (mvm->trans->dbg_cfg.MVM_RS_SECONDARY_SISO_NUM_RATES)
+#define IWL_MVM_RS_SECONDARY_SISO_RETRIES       (mvm->trans->dbg_cfg.MVM_RS_SECONDARY_SISO_RETRIES)
+#define IWL_MVM_RS_RATE_MIN_FAILURE_TH		(mvm->trans->dbg_cfg.MVM_RS_RATE_MIN_FAILURE_TH)
+#define IWL_MVM_RS_RATE_MIN_SUCCESS_TH		(mvm->trans->dbg_cfg.MVM_RS_RATE_MIN_SUCCESS_TH)
+#define IWL_MVM_RS_STAY_IN_COLUMN_TIMEOUT       (mvm->trans->dbg_cfg.MVM_RS_STAY_IN_COLUMN_TIMEOUT)
+#define IWL_MVM_RS_IDLE_TIMEOUT                 (mvm->trans->dbg_cfg.MVM_RS_IDLE_TIMEOUT)
+#define IWL_MVM_RS_MISSED_RATE_MAX		(mvm->trans->dbg_cfg.MVM_RS_MISSED_RATE_MAX)
+#define IWL_MVM_RS_LEGACY_FAILURE_LIMIT		(mvm->trans->dbg_cfg.MVM_RS_LEGACY_FAILURE_LIMIT)
+#define IWL_MVM_RS_LEGACY_SUCCESS_LIMIT		(mvm->trans->dbg_cfg.MVM_RS_LEGACY_SUCCESS_LIMIT)
+#define IWL_MVM_RS_LEGACY_TABLE_COUNT		(mvm->trans->dbg_cfg.MVM_RS_LEGACY_TABLE_COUNT)
+#define IWL_MVM_RS_NON_LEGACY_FAILURE_LIMIT	(mvm->trans->dbg_cfg.MVM_RS_NON_LEGACY_FAILURE_LIMIT)
+#define IWL_MVM_RS_NON_LEGACY_SUCCESS_LIMIT	(mvm->trans->dbg_cfg.MVM_RS_NON_LEGACY_SUCCESS_LIMIT)
+#define IWL_MVM_RS_NON_LEGACY_TABLE_COUNT	(mvm->trans->dbg_cfg.MVM_RS_NON_LEGACY_TABLE_COUNT)
+#define IWL_MVM_RS_SR_FORCE_DECREASE		(mvm->trans->dbg_cfg.MVM_RS_SR_FORCE_DECREASE)
+#define IWL_MVM_RS_SR_NO_DECREASE		(mvm->trans->dbg_cfg.MVM_RS_SR_NO_DECREASE)
+#define IWL_MVM_RS_AGG_TIME_LIMIT	        (mvm->trans->dbg_cfg.MVM_RS_AGG_TIME_LIMIT)
+#define IWL_MVM_RS_AGG_DISABLE_START	        (mvm->trans->dbg_cfg.MVM_RS_AGG_DISABLE_START)
+#define IWL_MVM_RS_AGG_START_THRESHOLD	        (mvm->trans->dbg_cfg.MVM_RS_AGG_START_THRESHOLD)
+#define IWL_MVM_RS_TPC_SR_FORCE_INCREASE	(mvm->trans->dbg_cfg.MVM_RS_TPC_SR_FORCE_INCREASE)
+#define IWL_MVM_RS_TPC_SR_NO_INCREASE		(mvm->trans->dbg_cfg.MVM_RS_TPC_SR_NO_INCREASE)
+#define IWL_MVM_RS_TPC_TX_POWER_STEP		(mvm->trans->dbg_cfg.MVM_RS_TPC_TX_POWER_STEP)
+#define IWL_MVM_ENABLE_EBS			(mvm->trans->dbg_cfg.MVM_ENABLE_EBS)
+#define IWL_MVM_FTM_RESP_TOA_OFFSET		(mvm->trans->dbg_cfg.MVM_FTM_RESP_TOA_OFFSET)
+#define IWL_MVM_FTM_RESP_VALID			(mvm->trans->dbg_cfg.MVM_FTM_RESP_VALID)
+#define IWL_MVM_FTM_RESP_FLAGS			(mvm->trans->dbg_cfg.MVM_FTM_RESP_FLAGS)
+#define IWL_MVM_FTM_INITIATOR_ALGO		(mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_ALGO)
+#define IWL_MVM_FTM_INITIATOR_DYNACK		(mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_DYNACK)
+#define IWL_MVM_FTM_INITIATOR_MCSI_ENABLED	(mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_MCSI_ENABLED)
+#define IWL_MVM_FTM_INITIATOR_COMMON_CALIB	(mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_COMMON_CALIB)
+#define IWL_MVM_FTM_INITIATOR_FAST_ALGO_DISABLE (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_FAST_ALGO_DISABLE)
+#define IWL_MVM_D3_DEBUG			(((struct iwl_mvm *)ctx)->trans->dbg_cfg.MVM_D3_DEBUG)
+#define IWL_MVM_USE_TWT				(mvm->trans->dbg_cfg.MVM_USE_TWT)
+#define IWL_MVM_TWT_TESTMODE                    (mvm->trans->dbg_cfg.MVM_TWT_TESTMODE)
+#define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	(mvm->trans->dbg_cfg.MVM_AMPDU_CONSEC_DROPS_DELBA)
+#define IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH     (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_ENABLE_SMOOTH)
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA      (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_SMOOTH_ALPHA)
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT)
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT  (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT)
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC    (mvm->trans->dbg_cfg.MVM_FTM_INITIATOR_SMOOTH_AGE_SEC)
+#define IWL_MVM_USE_NSSN_SYNC			(mvm->trans->dbg_cfg.MVM_USE_NSSN_SYNC)
+#define IWL_MVM_PHY_FILTER_CHAIN_A		(mvm->trans->dbg_cfg.MVM_PHY_FILTER_CHAIN_A)
+#define IWL_MVM_PHY_FILTER_CHAIN_B		(mvm->trans->dbg_cfg.MVM_PHY_FILTER_CHAIN_B)
+#define IWL_MVM_PHY_FILTER_CHAIN_C		(mvm->trans->dbg_cfg.MVM_PHY_FILTER_CHAIN_C)
+#define IWL_MVM_PHY_FILTER_CHAIN_D		(mvm->trans->dbg_cfg.MVM_PHY_FILTER_CHAIN_D)
+#define IWL_MVM_DISABLE_AP_FILS			(mvm->trans->dbg_cfg.MVM_DISABLE_AP_FILS)
+
+#endif /* CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES */
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index a0ce761d0c59..93a1c871c3a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -265,6 +265,15 @@ static void iwl_mvm_ftm_cmd_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->request_id = req->cookie;
 	cmd->num_of_ap = req->n_peers;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (IWL_MVM_FTM_INITIATOR_COMMON_CALIB) {
+		cmd->common_calib =
+			cpu_to_le16(IWL_MVM_FTM_INITIATOR_COMMON_CALIB);
+		cmd->initiator_flags =
+			cpu_to_le32(IWL_TOF_INITIATOR_FLAGS_COMMON_CALIB);
+	}
+#endif
+
 	/* use maximum for "no timeout" or bigger than what we can do */
 	if (!req->timeout || req->timeout > 255 * 100)
 		cmd->req_timeout = 255;
@@ -312,6 +321,12 @@ static void iwl_mvm_ftm_cmd_common(struct iwl_mvm *mvm,
 	for (i = 0; i < ETH_ALEN; i++)
 		cmd->macaddr_mask[i] = ~req->mac_addr_mask[i];
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (IWL_MVM_FTM_INITIATOR_FAST_ALGO_DISABLE)
+		cmd->initiator_flags |=
+			cpu_to_le32(IWL_TOF_INITIATOR_FLAGS_FAST_ALGO_DISABLED);
+#endif
+
 	if (vif->bss_conf.assoc) {
 		memcpy(cmd->range_req_bssid, vif->bss_conf.bssid, ETH_ALEN);
 
@@ -338,6 +353,15 @@ static void iwl_mvm_ftm_cmd_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			       struct cfg80211_pmsr_request *req)
 {
 	iwl_mvm_ftm_cmd_common(mvm, vif, (void *)cmd, req);
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (IWL_MVM_FTM_INITIATOR_COMMON_CALIB) {
+		cmd->common_calib =
+			cpu_to_le16(IWL_MVM_FTM_INITIATOR_COMMON_CALIB);
+		cmd->initiator_flags |=
+			cpu_to_le32(IWL_TOF_INITIATOR_FLAGS_COMMON_CALIB);
+	}
+#endif
 }
 
 static int
@@ -447,6 +471,9 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 		target->location_req |= IWL_TOF_LOC_CIVIC;
 
 	target->algo_type = IWL_MVM_FTM_INITIATOR_ALGO;
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	target->notify_mcsi = IWL_MVM_FTM_INITIATOR_MCSI_ENABLED;
+#endif
 
 	return 0;
 }
@@ -488,6 +515,11 @@ iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
 		FTM_PUT_FLAG(TB);
 	else if (peer->ftm.non_trigger_based)
 		FTM_PUT_FLAG(NON_TB);
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (IWL_MVM_FTM_INITIATOR_MCSI_ENABLED)
+		FTM_PUT_FLAG(MCSI_REPORT);
+#endif
 }
 
 static int
@@ -658,6 +690,28 @@ static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
 }
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+static void iwl_mvm_ftm_set_calib(struct iwl_mvm *mvm,
+                                  struct iwl_tof_range_req_ap_entry_v6 *target)
+{
+        if (IWL_MVM_FTM_INITIATOR_COMMON_CALIB) {
+                int j;
+
+                /*
+                 * The driver API only supports one calibration value.
+                 * For now, use it for all bandwidths.
+                 * TODO: Add support for per bandwidth calibration
+                 * values.
+                 */
+                for (j = 0; j < IWL_TOF_BW_NUM; j++)
+                        target->calib[j] =
+                                cpu_to_le16(IWL_MVM_FTM_INITIATOR_COMMON_CALIB);
+
+                FTM_PUT_FLAG(USE_CALIB);
+        }
+}
+#endif
+
 static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				struct cfg80211_pmsr_request *req)
 {
@@ -680,6 +734,10 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		err = iwl_mvm_ftm_put_target(mvm, vif, peer, target);
 		if (err)
 			return err;
+
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+		iwl_mvm_ftm_set_calib(mvm, target);
+#endif
 	}
 
 	return iwl_mvm_ftm_send_cmd(mvm, &hcmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index dd3662b9a5bc..3593774cef81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -154,6 +154,17 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	cmd.cmd_valid_fields |= cpu_to_le32(IWL_MVM_FTM_RESP_VALID);
+	cmd.responder_cfg_flags |= cpu_to_le32(IWL_MVM_FTM_RESP_FLAGS);
+
+	if (IWL_MVM_FTM_RESP_TOA_OFFSET) {
+		cmd.cmd_valid_fields |=
+			cpu_to_le32(IWL_TOF_RESPONDER_FLAGS_TOA_OFFSET_MODE);
+		cmd.toa_offset = cpu_to_le16(IWL_MVM_FTM_RESP_TOA_OFFSET);
+	}
+#endif
+	
 	if (cmd_ver == 7)
 		err = iwl_mvm_ftm_responder_set_bw_v2(chandef, &cmd.format_bw,
 						      &cmd.ctrl_ch_position);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6385b9641126..1386d8397204 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -604,9 +604,19 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	struct iwl_phy_specific_cfg phy_filters = {};
 	u8 cmd_ver;
 	size_t cmd_size;
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	u32 override_mask, flow_override, flow_src;
+	u32 event_override, event_src;
+	const struct iwl_tlv_calib_ctrl *default_calib =
+		&mvm->fw->default_calib[ucode_type];
+#endif
 
 	if (iwl_mvm_has_unified_ucode(mvm) &&
-	    !mvm->trans->cfg->tx_with_siso_diversity)
+	    !mvm->trans->cfg->tx_with_siso_diversity
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	    && !mvm->trans->dbg_cfg.MVM_CALIB_OVERRIDE_CONTROL
+#endif
+	   )
 		return 0;
 
 	if (mvm->trans->cfg->tx_with_siso_diversity) {
@@ -639,6 +649,73 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 		       sizeof(struct iwl_phy_specific_cfg));
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	override_mask = mvm->trans->dbg_cfg.MVM_CALIB_OVERRIDE_CONTROL;
+	if (override_mask) {
+		IWL_DEBUG_INFO(mvm,
+			       "calib settings overriden by user, control=0x%x\n",
+			       override_mask);
+
+		switch (ucode_type) {
+		case IWL_UCODE_INIT:
+			flow_override = mvm->trans->dbg_cfg.MVM_CALIB_INIT_FLOW;
+			event_override =
+				mvm->trans->dbg_cfg.MVM_CALIB_INIT_EVENT;
+			IWL_DEBUG_CALIB(mvm,
+					"INIT: flow_override %x, event_override %x\n",
+					flow_override, event_override);
+			break;
+		case IWL_UCODE_REGULAR:
+			flow_override = mvm->trans->dbg_cfg.MVM_CALIB_D0_FLOW;
+			event_override = mvm->trans->dbg_cfg.MVM_CALIB_D0_EVENT;
+			IWL_DEBUG_CALIB(mvm,
+					"REGULAR: flow_override %x, event_override %x\n",
+					flow_override, event_override);
+			break;
+		case IWL_UCODE_WOWLAN:
+			flow_override = mvm->trans->dbg_cfg.MVM_CALIB_D3_FLOW;
+			event_override = mvm->trans->dbg_cfg.MVM_CALIB_D3_EVENT;
+			IWL_DEBUG_CALIB(mvm,
+					"WOWLAN: flow_override %x, event_override %x\n",
+					flow_override, event_override);
+			break;
+		default:
+			IWL_ERR(mvm, "ERROR: calib case isn't valid\n");
+			flow_override = 0;
+			event_override = 0;
+			break;
+		}
+
+		IWL_DEBUG_CALIB(mvm, "override_mask %x\n", override_mask);
+
+		/* find the new calib setting for the flow calibrations */
+		flow_src = le32_to_cpu(default_calib->flow_trigger);
+		IWL_DEBUG_CALIB(mvm, "flow_src %x\n", flow_src);
+
+		flow_override &= override_mask;
+		flow_src &= ~override_mask;
+		flow_override |= flow_src;
+
+		phy_cfg_cmd.calib_control.flow_trigger =
+			cpu_to_le32(flow_override);
+		IWL_DEBUG_CALIB(mvm, "new flow calib setting = %x\n",
+				flow_override);
+
+		/* find the new calib setting for the event calibrations */
+		event_src = le32_to_cpu(default_calib->event_trigger);
+		IWL_DEBUG_CALIB(mvm, "event_src %x\n", event_src);
+
+		event_override &= override_mask;
+		event_src &= ~override_mask;
+		event_override |= event_src;
+
+		phy_cfg_cmd.calib_control.event_trigger =
+			cpu_to_le32(event_override);
+		IWL_DEBUG_CALIB(mvm, "new event calib setting = %x\n",
+				event_override);
+	}
+#endif
+	
 	IWL_DEBUG_INFO(mvm, "Sending Phy CFG command: 0x%x\n",
 		       phy_cfg_cmd.phy_cfg);
 	cmd_size = (cmd_ver == 3) ? sizeof(struct iwl_phy_cfg_cmd_v3) :
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b627e7da7ac9..3e65f41cd6a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -583,6 +583,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	num_mac = (mvm->nvm_data->n_hw_addrs > 1) ?
 		min(IWL_MVM_MAX_ADDRESSES, mvm->nvm_data->n_hw_addrs) : 1;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (mvm->trans->dbg_cfg.hw_address.len)
+		num_mac = IWL_MVM_MAX_ADDRESSES;
+#endif
+	
 	for (i = 1; i < num_mac; i++) {
 		memcpy(mvm->addresses[i].addr, mvm->addresses[i-1].addr,
 		       ETH_ALEN);
@@ -2250,6 +2255,27 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			(vif->bss_conf.uora_ocw_range >> 3) & 0x7;
 	}
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (mvm->trans->dbg_cfg.no_ack_en & 0x2)
+		flags &= ~STA_CTXT_HE_ACK_ENABLED;
+
+	/* MU EDCA override */
+	if (mvm->trans->dbg_cfg.mu_edca) {
+		u32 mu_edca = mvm->trans->dbg_cfg.mu_edca;
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			sta_ctxt_cmd.trig_based_txf[i].aifsn =
+				cpu_to_le16(mu_edca & 0xf);
+			sta_ctxt_cmd.trig_based_txf[i].cwmin =
+				cpu_to_le16((mu_edca >> 4) & 0xf);
+			sta_ctxt_cmd.trig_based_txf[i].cwmax =
+				cpu_to_le16((mu_edca >> 8) & 0xf);
+			sta_ctxt_cmd.trig_based_txf[i].mu_time =
+				cpu_to_le16((mu_edca >> 12) & 0xff);
+		}
+	}
+#endif
+
 	if (vif->bss_conf.nontransmitted) {
 		flags |= STA_CTXT_HE_REF_BSSID_VALID;
 		ether_addr_copy(sta_ctxt_cmd.ref_bssid_addr,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f1c5b3a9c26f..8e7a3be7621a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -555,6 +555,34 @@ static void iwl_mvm_tx_unblock_dwork(struct work_struct *work)
 	mutex_unlock(&mvm->mutex);
 }
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+static void iwl_mvm_init_modparams(struct iwl_mvm *mvm)
+{
+#define IWL_DBG_CFG(t, n)			/* nothing */
+#define IWL_DBG_CFG_STR(n)			/* nothing */
+#define IWL_DBG_CFG_NODEF(t, n)			/* nothing */
+#define IWL_DBG_CFG_BIN(n)			/* nothing */
+#define IWL_DBG_CFG_BINA(n, max)		/* nothing */
+#define IWL_DBG_CFG_RANGE(t, n, min, max)	/* nothing */
+#define IWL_MOD_PARAM(t, n)			/* nothing */
+#define IWL_MVM_MOD_PARAM(t, n)				\
+	if (mvm->trans->dbg_cfg.__mvm_mod_param_##n)	\
+		iwlmvm_mod_params.n = mvm->trans->dbg_cfg.mvm_##n;
+#define IWL_DBG_CFG_FN(n, fn)			/* nothing */
+#define DBG_CFG_REINCLUDE
+#include "../iwl-dbg-cfg.h"
+#undef IWL_DBG_CFG
+#undef IWL_DBG_CFG_STR
+#undef IWL_DBG_CFG_NODEF
+#undef IWL_DBG_CFG_BIN
+#undef IWL_DBG_CFG_BINA
+#undef IWL_DBG_CFG_RANGE
+#undef IWL_MOD_PARAM
+#undef IWL_MVM_MOD_PARAM
+#undef IWL_DBG_CFG_FN
+}
+#endif
+
 static int iwl_mvm_fwrt_dump_start(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
@@ -635,11 +663,28 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.rx_agg_subframes)
+		hw->max_rx_aggregation_subframes =
+			trans->dbg_cfg.rx_agg_subframes;
+#endif
+
 	if (cfg->max_tx_agg_size)
 		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
 	else
 		hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans->dbg_cfg.tx_agg_subframes)
+		hw->max_tx_aggregation_subframes =
+			trans->dbg_cfg.tx_agg_subframes;
+
+	pr_err("hw->max_tx_aggregation_subframes: %d  cfg->max-tx-agg-size: %d  ampdu-exponent-p1: %d\n",
+	       hw->max_tx_aggregation_subframes, cfg->max_tx_agg_size,
+	       trans->dbg_cfg.ampdu_exponent_p1);
+
+#endif
+
 	op_mode = hw->priv;
 
 	mvm = IWL_OP_MODE_GET_MVM(op_mode);
@@ -813,6 +858,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	if (iwlwifi_mod_params.nvm_file)
 		mvm->nvm_file_name = iwlwifi_mod_params.nvm_file;
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	else if (trans->dbg_cfg.nvm_file)
+		mvm->nvm_file_name = trans->dbg_cfg.nvm_file;
+#endif
 	else
 		IWL_DEBUG_EEPROM(mvm->trans->dev,
 				 "working without external nvm file\n");
@@ -858,6 +907,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	else
 		memset(&mvm->rx_stats, 0, sizeof(struct mvm_statistics_rx));
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	iwl_mvm_init_modparams(mvm);
+#endif
+
 	iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
 
 	return op_mode;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index c146303ec73b..c59787a4cb90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -193,6 +193,12 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 		return;
 	}
 #endif
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (mvm->trans->dbg_cfg.MVM_USE_PS_POLL) {
+		cmd->flags |= cpu_to_le16(POWER_FLAGS_ADVANCE_PM_ENA_MSK);
+		return;
+	}
+#endif
 
 	for (ac = IEEE80211_AC_VO; ac <= IEEE80211_AC_BK; ac++) {
 		if (!mvmvif->queue_params[ac].uapsd)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index e0e80906fdc6..4a57921d4bfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -482,6 +482,21 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 #endif
 	rs_fw_set_supp_rates(sta, sband, &cfg_cmd);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	/*
+	 * if AP disables mimo on 160bw
+	 * (!cfg_cmd.ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_160])
+	 * and AP enables siso on 160
+	 * cfg_cmd.ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_160]
+	 * we disable mimo on 80bw cmd->ht_rates[1][0]
+	 */
+	if (mvm->trans->dbg_cfg.tx_siso_80bw_like_160bw &&
+	    cfg_cmd.ht_rates[IWL_TLC_NSS_1][IWL_TLC_HT_BW_160] &&
+	    !cfg_cmd.ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_160])
+		cfg_cmd.ht_rates[IWL_TLC_NSS_2][IWL_TLC_HT_BW_NONE_160] = 0;
+
+#endif
+
 	/*
 	 * since TLC offload works with one mode we can assume
 	 * that only vht/ht is used and also set it as station max amsdu
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index ff542d2f0054..9c27031c3e24 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -783,6 +783,12 @@ static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 	if (trans_pcie->debug_rfkill == 1)
 		return true;
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	if (trans_pcie->debug_rfkill == -1 &&
+	    trans->dbg_cfg.STARTUP_RFKILL)
+		return true;
+#endif
+	
 	return !(iwl_read32(trans, CSR_GP_CNTRL) &
 		CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 18ddaa2c73fc..1c2a4b555a42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -780,6 +780,39 @@ static int iwl_pcie_load_section(struct iwl_trans *trans, u8 section_num,
 	return ret;
 }
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+static void iwl_pcie_override_secure_boot_cfg(struct iwl_trans *trans)
+{
+	u32 val;
+
+	if (!trans->dbg_cfg.secure_boot_cfg)
+		return;
+
+	/* Verify AUX address space is not locked */
+	val = iwl_read_prph(trans, PREG_AUX_BUS_WPROT_0);
+	if (val & BIT((SB_CFG_OVERRIDE_ADDR - SB_CFG_BASE_OVERRIDE) >> 10)) {
+		IWL_ERR(trans,
+			"AUX address space is locked for override, (AUX val=0x%x)\n",
+			val);
+		return;
+	}
+
+	/* Modify secure boot cfg flags */
+	iwl_write_prph(trans, SB_MODIFY_CFG_FLAG,
+		       trans->dbg_cfg.secure_boot_cfg);
+
+	/* take ownership on the AUX IF */
+	iwl_set_bits_prph(trans, WFPM_CTRL_REG,
+			  WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK);
+
+	/* indicate secure boot cfg override */
+	iwl_set_bits_prph(trans, SB_CFG_OVERRIDE_ADDR,
+			  SB_CFG_OVERRIDE_ENABLE);
+
+	return;
+}
+#endif
+
 static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
 					   const struct fw_img *image,
 					   int cpu,
@@ -1050,6 +1083,10 @@ static int iwl_pcie_load_given_ucode_8000(struct iwl_trans *trans,
 	if (iwl_pcie_dbg_on(trans))
 		iwl_pcie_apply_destination(trans);
 
+#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
+	iwl_pcie_override_secure_boot_cfg(trans);
+#endif
+
 	IWL_DEBUG_POWER(trans, "Original WFPM value = 0x%08X\n",
 			iwl_read_prph(trans, WFPM_GP2));
 
-- 
2.20.1

