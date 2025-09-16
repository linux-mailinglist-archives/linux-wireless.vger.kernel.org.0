Return-Path: <linux-wireless+bounces-27400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B5B7DCEE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB11C06952
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B732951C;
	Tue, 16 Sep 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="DvAFJl64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31F32951E
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061738; cv=none; b=Trfv34eM8/cORXfNfbzKCLpKOu2O3bf6B4eXQtj9ULyLtDo1ZHGonLZjSBuKqq32B9orcOn0L1g1yr5nwMRoVWpy1XI7xnBKORnMqOaUGyn/VyKNleUjBYARe4gUTNJf5ayZODA6zMb5tgFV2ssMC48QKfXED3zg/9xFTc2zHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061738; c=relaxed/simple;
	bh=uv7ANsCM0xpQzti6V1oU1lPXf8QhgQ7EMBhbUhq4RJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osjwTPFZCUXAMk3hjL8lgBASfeGLXaRiv8U2pv8lSS6e8OZHwFi6uZa+myqgiZAPbK9CAO/JhwSESre1ZlyAnvzfFiF4IA2aWtDBVtFudZbBRl/+Re5Lp3qPkjVp0bA4SAshddujAS+uV/UHZ1FfD3s81FQFyP2GsO2V7nKOMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=DvAFJl64; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061736; x=1789597736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uv7ANsCM0xpQzti6V1oU1lPXf8QhgQ7EMBhbUhq4RJw=;
  b=DvAFJl64bPwRiEKfbKKIChL9gOQvMpf6/ZDmxdOPbZG20WJkE1qNwz1c
   YXn+W4X5Or27fjIKC1XVFjQypykhbSj2bJlv2HV8OQrqeARkXzQ0rlXKK
   is57tucy9V8Yj8MfK1MVqSndONm9d+fWJc0TaZH5vqXNk2/9Lvmy0HzpX
   Y=;
X-CSE-ConnectionGUID: LuWbyrUZRauXcLj3san3AA==
X-CSE-MsgGUID: 85534x8bS+eFKHsEn0uwcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918772"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918772"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:28:54 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:28:53 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:28:50 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 45/57] wifi: inffmac: add btcoex.c/h
Date: Wed, 17 Sep 2025 03:48:05 +0530
Message-ID: <20250916221821.4387-51-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of Coexistence mechanism to mitigate interface
between Wi-Fi and Bluetooth.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/btcoex.c    | 482 ++++++++++++++++++
 .../net/wireless/infineon/inffmac/btcoex.h    |  22 +
 2 files changed, 504 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/btcoex.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/btcoex.h

diff --git a/drivers/net/wireless/infineon/inffmac/btcoex.c b/drivers/net/wireless/infineon/inffmac/btcoex.c
new file mode 100644
index 000000000000..a1620501e947
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/btcoex.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <net/cfg80211.h>
+
+#include "core.h"
+#include "debug.h"
+#include "fwil.h"
+#include "fwil_types.h"
+#include "btcoex.h"
+#include "cfg80211.h"
+
+/* T1 start SCO/eSCO priority suppression */
+#define INFF_BTCOEX_OPPR_WIN_TIME   msecs_to_jiffies(2000)
+
+/* BT registers values during DHCP */
+#define INFF_BT_DHCP_REG50 0x8022
+#define INFF_BT_DHCP_REG51 0
+#define INFF_BT_DHCP_REG64 0
+#define INFF_BT_DHCP_REG65 0
+#define INFF_BT_DHCP_REG71 0
+#define INFF_BT_DHCP_REG66 0x2710
+#define INFF_BT_DHCP_REG41 0x33
+#define INFF_BT_DHCP_REG68 0x190
+
+/* number of samples for SCO detection */
+#define INFF_BT_SCO_SAMPLES 12
+
+/**
+ * enum inff_btcoex_state - BT coex DHCP state machine states
+ * @INFF_BT_DHCP_IDLE: DCHP is idle
+ * @INFF_BT_DHCP_START: DHCP started, wait before
+ *	boosting wifi priority
+ * @INFF_BT_DHCP_OPPR_WIN: graceful DHCP opportunity ended,
+ *	boost wifi priority
+ * @INFF_BT_DHCP_FLAG_FORCE_TIMEOUT: wifi priority boost end,
+ *	restore defaults
+ */
+enum inff_btcoex_state {
+	INFF_BT_DHCP_IDLE,
+	INFF_BT_DHCP_START,
+	INFF_BT_DHCP_OPPR_WIN,
+	INFF_BT_DHCP_FLAG_FORCE_TIMEOUT
+};
+
+/**
+ * struct inff_btcoex_info - BT coex related information
+ * @vif: interface for which request was done.
+ * @timer: timer for DHCP state machine
+ * @timeout: configured timeout.
+ * @timer_on:  DHCP timer active
+ * @dhcp_done: DHCP finished before T1/T2 timer expiration
+ * @bt_state: DHCP state machine state
+ * @work: DHCP state machine work
+ * @cfg: driver private data for cfg80211 interface
+ * @reg66: saved value of btc_params 66
+ * @reg41: saved value of btc_params 41
+ * @reg68: saved value of btc_params 68
+ * @saved_regs_part1: flag indicating regs 66,41,68
+ *	have been saved
+ * @reg50: saved value of btc_params 50
+ * @reg51: saved value of btc_params 51
+ * @reg64: saved value of btc_params 64
+ * @reg65: saved value of btc_params 65
+ * @reg71: saved value of btc_params 71
+ * @saved_regs_part2: flag indicating regs 50,51,64,65,71
+ *	have been saved
+ */
+struct inff_btcoex_info {
+	struct inff_cfg80211_vif *vif;
+	struct timer_list timer;
+	u16 timeout;
+	bool timer_on;
+	bool dhcp_done;
+	enum inff_btcoex_state bt_state;
+	struct work_struct work;
+	struct inff_cfg80211_info *cfg;
+	u32 reg66;
+	u32 reg41;
+	u32 reg68;
+	bool saved_regs_part1;
+	u32 reg50;
+	u32 reg51;
+	u32 reg64;
+	u32 reg65;
+	u32 reg71;
+	bool saved_regs_part2;
+};
+
+/**
+ * inff_btcoex_params_write() - write btc_params firmware variable
+ * @ifp: interface
+ * @addr: btc_params register number
+ * @data: data to write
+ */
+static s32 inff_btcoex_params_write(struct inff_if *ifp, u32 addr, u32 data)
+{
+	struct {
+		__le32 addr;
+		__le32 data;
+	} reg_write;
+
+	reg_write.addr = cpu_to_le32(addr);
+	reg_write.data = cpu_to_le32(data);
+	return inff_fil_iovar_data_set(ifp, "btc_params",
+					&reg_write, sizeof(reg_write));
+}
+
+/**
+ * inff_btcoex_params_read() - read btc_params firmware variable
+ * @ifp: interface
+ * @addr: btc_params register number
+ * @data: read data
+ */
+static s32 inff_btcoex_params_read(struct inff_if *ifp, u32 addr, u32 *data)
+{
+	*data = addr;
+
+	return inff_fil_iovar_int_get(ifp, "btc_params", data);
+}
+
+/**
+ * inff_btcoex_boost_wifi() - control BT SCO/eSCO parameters
+ * @btci: BT coex info
+ * @trump_sco:
+ *	true - set SCO/eSCO parameters for compatibility
+ *		during DHCP window
+ *	false - restore saved parameter values
+ *
+ * Enhanced BT COEX settings for eSCO compatibility during DHCP window
+ */
+static void inff_btcoex_boost_wifi(struct inff_btcoex_info *btci,
+				   bool trump_sco)
+{
+	struct inff_if *ifp = inff_get_ifp(btci->cfg->pub, 0);
+
+	if (trump_sco && !btci->saved_regs_part2) {
+		/* this should reduce eSCO agressive
+		 * retransmit w/o breaking it
+		 */
+
+		/* save current */
+		inff_dbg(INFO, "new SCO/eSCO coex algo {save & override}\n");
+		inff_btcoex_params_read(ifp, 50, &btci->reg50);
+		inff_btcoex_params_read(ifp, 51, &btci->reg51);
+		inff_btcoex_params_read(ifp, 64, &btci->reg64);
+		inff_btcoex_params_read(ifp, 65, &btci->reg65);
+		inff_btcoex_params_read(ifp, 71, &btci->reg71);
+
+		btci->saved_regs_part2 = true;
+		inff_dbg(INFO,
+			 "saved bt_params[50,51,64,65,71]: 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+			 btci->reg50, btci->reg51, btci->reg64,
+			 btci->reg65, btci->reg71);
+
+		/* pacify the eSco   */
+		inff_btcoex_params_write(ifp, 50, INFF_BT_DHCP_REG50);
+		inff_btcoex_params_write(ifp, 51, INFF_BT_DHCP_REG51);
+		inff_btcoex_params_write(ifp, 64, INFF_BT_DHCP_REG64);
+		inff_btcoex_params_write(ifp, 65, INFF_BT_DHCP_REG65);
+		inff_btcoex_params_write(ifp, 71, INFF_BT_DHCP_REG71);
+
+	} else if (btci->saved_regs_part2) {
+		/* restore previously saved bt params */
+		inff_dbg(INFO, "Do new SCO/eSCO coex algo {restore}\n");
+		inff_btcoex_params_write(ifp, 50, btci->reg50);
+		inff_btcoex_params_write(ifp, 51, btci->reg51);
+		inff_btcoex_params_write(ifp, 64, btci->reg64);
+		inff_btcoex_params_write(ifp, 65, btci->reg65);
+		inff_btcoex_params_write(ifp, 71, btci->reg71);
+
+		inff_dbg(INFO,
+			 "restored bt_params[50,51,64,65,71]: 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+			 btci->reg50, btci->reg51, btci->reg64,
+			 btci->reg65, btci->reg71);
+
+		btci->saved_regs_part2 = false;
+	} else {
+		inff_dbg(INFO, "attempted to restore not saved BTCOEX params\n");
+	}
+}
+
+/**
+ * inff_btcoex_is_sco_active() - check if SCO/eSCO is active
+ * @ifp: interface
+ *
+ * return: true if SCO/eSCO session is active
+ */
+static bool inff_btcoex_is_sco_active(struct inff_if *ifp)
+{
+	int ioc_res = 0;
+	bool res = false;
+	int sco_id_cnt = 0;
+	u32 param27;
+	int i;
+
+	for (i = 0; i < INFF_BT_SCO_SAMPLES; i++) {
+		ioc_res = inff_btcoex_params_read(ifp, 27, &param27);
+
+		if (ioc_res < 0) {
+			inff_err("ioc read btc params error\n");
+			break;
+		}
+
+		inff_dbg(INFO, "sample[%d], btc_params 27:%x\n", i, param27);
+
+		if ((param27 & 0x6) == 2) { /* count both sco & esco  */
+			sco_id_cnt++;
+		}
+
+		if (sco_id_cnt > 2) {
+			inff_dbg(INFO,
+				 "sco/esco detected, pkt id_cnt:%d samples:%d\n",
+				 sco_id_cnt, i);
+			res = true;
+			break;
+		}
+	}
+	inff_dbg(TRACE, "exit: result=%d\n", res);
+	return res;
+}
+
+/*
+ * btcmf_btcoex_save_part1() - save first step parameters.
+ */
+static void btcmf_btcoex_save_part1(struct inff_btcoex_info *btci)
+{
+	struct inff_if *ifp = btci->vif->ifp;
+
+	if (!btci->saved_regs_part1) {
+		/* Retrieve and save original reg value */
+		inff_btcoex_params_read(ifp, 66, &btci->reg66);
+		inff_btcoex_params_read(ifp, 41, &btci->reg41);
+		inff_btcoex_params_read(ifp, 68, &btci->reg68);
+		btci->saved_regs_part1 = true;
+		inff_dbg(INFO,
+			 "saved btc_params regs (66,41,68) 0x%x 0x%x 0x%x\n",
+			 btci->reg66, btci->reg41,
+			 btci->reg68);
+	}
+}
+
+/*
+ * inff_btcoex_restore_part1() - restore first step parameters.
+ */
+static void inff_btcoex_restore_part1(struct inff_btcoex_info *btci)
+{
+	struct inff_if *ifp;
+
+	if (btci->saved_regs_part1) {
+		btci->saved_regs_part1 = false;
+		ifp = btci->vif->ifp;
+		inff_btcoex_params_write(ifp, 66, btci->reg66);
+		inff_btcoex_params_write(ifp, 41, btci->reg41);
+		inff_btcoex_params_write(ifp, 68, btci->reg68);
+		inff_dbg(INFO,
+			 "restored btc_params regs {66,41,68} 0x%x 0x%x 0x%x\n",
+			 btci->reg66, btci->reg41,
+			 btci->reg68);
+	}
+}
+
+/*
+ * inff_btcoex_timerfunc() - BT coex timer callback
+ */
+static void inff_btcoex_timerfunc(struct timer_list *t)
+{
+	struct inff_btcoex_info *bt_local = timer_container_of(bt_local, t,
+							       timer);
+	inff_dbg(TRACE, "enter\n");
+
+	bt_local->timer_on = false;
+	schedule_work(&bt_local->work);
+}
+
+/**
+ * inff_btcoex_handler() - BT coex state machine work handler
+ * @work: work
+ */
+static void inff_btcoex_handler(struct work_struct *work)
+{
+	struct inff_btcoex_info *btci;
+
+	btci = container_of(work, struct inff_btcoex_info, work);
+	if (btci->timer_on) {
+		btci->timer_on = false;
+		timer_delete_sync(&btci->timer);
+	}
+
+	switch (btci->bt_state) {
+	case INFF_BT_DHCP_START:
+		/* DHCP started provide OPPORTUNITY window
+		 * to get DHCP address
+		 */
+		inff_dbg(INFO, "DHCP started\n");
+		btci->bt_state = INFF_BT_DHCP_OPPR_WIN;
+		if (btci->timeout < INFF_BTCOEX_OPPR_WIN_TIME) {
+			mod_timer(&btci->timer, btci->timer.expires);
+		} else {
+			btci->timeout -= INFF_BTCOEX_OPPR_WIN_TIME;
+			mod_timer(&btci->timer,
+				  jiffies + INFF_BTCOEX_OPPR_WIN_TIME);
+		}
+		btci->timer_on = true;
+		break;
+
+	case INFF_BT_DHCP_OPPR_WIN:
+		if (btci->dhcp_done) {
+			inff_dbg(INFO, "DHCP done before T1 expiration\n");
+			goto idle;
+		}
+
+		/* DHCP is not over yet, start lowering BT priority */
+		inff_dbg(INFO, "DHCP T1:%d expired\n",
+			 jiffies_to_msecs(INFF_BTCOEX_OPPR_WIN_TIME));
+		inff_btcoex_boost_wifi(btci, true);
+
+		btci->bt_state = INFF_BT_DHCP_FLAG_FORCE_TIMEOUT;
+		mod_timer(&btci->timer, jiffies + btci->timeout);
+		btci->timer_on = true;
+		break;
+
+	case INFF_BT_DHCP_FLAG_FORCE_TIMEOUT:
+		if (btci->dhcp_done)
+			inff_dbg(INFO, "DHCP done before T2 expiration\n");
+		else
+			inff_dbg(INFO, "DHCP T2:%d expired\n",
+				 INFF_BT_DHCP_FLAG_FORCE_TIMEOUT);
+
+		goto idle;
+
+	default:
+		inff_err("invalid state=%d !!!\n", btci->bt_state);
+		goto idle;
+	}
+
+	return;
+
+idle:
+	btci->bt_state = INFF_BT_DHCP_IDLE;
+	btci->timer_on = false;
+	inff_btcoex_boost_wifi(btci, false);
+	cfg80211_crit_proto_stopped(&btci->vif->wdev, GFP_KERNEL);
+	inff_btcoex_restore_part1(btci);
+	btci->vif = NULL;
+}
+
+/**
+ * inff_btcoex_attach() - initialize BT coex data
+ * @cfg: driver private cfg80211 data
+ *
+ * return: 0 on success
+ */
+int inff_btcoex_attach(struct inff_cfg80211_info *cfg)
+{
+	struct inff_btcoex_info *btci;
+
+	inff_dbg(TRACE, "enter\n");
+
+	btci = kmalloc(sizeof(*btci), GFP_KERNEL);
+	if (!btci)
+		return -ENOMEM;
+
+	btci->bt_state = INFF_BT_DHCP_IDLE;
+
+	/* Set up timer for BT  */
+	btci->timer_on = false;
+	btci->timeout = INFF_BTCOEX_OPPR_WIN_TIME;
+	timer_setup(&btci->timer, inff_btcoex_timerfunc, 0);
+	btci->cfg = cfg;
+	btci->saved_regs_part1 = false;
+	btci->saved_regs_part2 = false;
+
+	INIT_WORK(&btci->work, inff_btcoex_handler);
+
+	cfg->btcoex = btci;
+	return 0;
+}
+
+/**
+ * inff_btcoex_detach - clean BT coex data
+ * @cfg: driver private cfg80211 data
+ */
+void inff_btcoex_detach(struct inff_cfg80211_info *cfg)
+{
+	inff_dbg(TRACE, "enter\n");
+
+	if (!cfg->btcoex)
+		return;
+
+	timer_shutdown_sync(&cfg->btcoex->timer);
+	cfg->btcoex->timer_on = false;
+
+	cancel_work_sync(&cfg->btcoex->work);
+
+	inff_btcoex_boost_wifi(cfg->btcoex, false);
+	inff_btcoex_restore_part1(cfg->btcoex);
+
+	kfree(cfg->btcoex);
+	cfg->btcoex = NULL;
+}
+
+static void inff_btcoex_dhcp_start(struct inff_btcoex_info *btci)
+{
+	struct inff_if *ifp = btci->vif->ifp;
+
+	btcmf_btcoex_save_part1(btci);
+	/* set new regs values */
+	inff_btcoex_params_write(ifp, 66, INFF_BT_DHCP_REG66);
+	inff_btcoex_params_write(ifp, 41, INFF_BT_DHCP_REG41);
+	inff_btcoex_params_write(ifp, 68, INFF_BT_DHCP_REG68);
+	btci->dhcp_done = false;
+	btci->bt_state = INFF_BT_DHCP_START;
+	schedule_work(&btci->work);
+	inff_dbg(TRACE, "enable BT DHCP Timer\n");
+}
+
+static void inff_btcoex_dhcp_end(struct inff_btcoex_info *btci)
+{
+	/* Stop any bt timer because DHCP session is done */
+	btci->dhcp_done = true;
+	if (btci->timer_on) {
+		inff_dbg(INFO, "disable BT DHCP Timer\n");
+		btci->timer_on = false;
+		timer_delete_sync(&btci->timer);
+
+		/* schedule worker if transition to IDLE is needed */
+		if (btci->bt_state != INFF_BT_DHCP_IDLE) {
+			inff_dbg(INFO, "bt_state:%d\n",
+				 btci->bt_state);
+			schedule_work(&btci->work);
+		}
+	} else {
+		/* Restore original values */
+		inff_btcoex_restore_part1(btci);
+	}
+}
+
+/*
+ * inff_btcoex_set_mode - set BT coex mode
+ * @mode: Wifi-Bluetooth coexistence mode
+ *
+ * return: 0 on success
+ */
+int inff_btcoex_set_mode(struct inff_cfg80211_vif *vif,
+			 enum inff_btcoex_mode mode, u16 duration)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(vif->wdev.wiphy);
+	struct inff_btcoex_info *btci = cfg->btcoex;
+	struct inff_if *ifp = inff_get_ifp(cfg->pub, 0);
+
+	switch (mode) {
+	case INFF_BTCOEX_DISABLED:
+		inff_dbg(INFO, "DHCP session starts\n");
+		if (btci->bt_state != INFF_BT_DHCP_IDLE)
+			return -EBUSY;
+		/* Start BT timer only for SCO connection */
+		if (inff_btcoex_is_sco_active(ifp)) {
+			btci->timeout = msecs_to_jiffies(duration);
+			btci->vif = vif;
+			inff_btcoex_dhcp_start(btci);
+		}
+		break;
+
+	case INFF_BTCOEX_ENABLED:
+		inff_dbg(INFO, "DHCP session ends\n");
+		if (btci->bt_state != INFF_BT_DHCP_IDLE &&
+		    vif == btci->vif) {
+			inff_btcoex_dhcp_end(btci);
+		}
+		break;
+	default:
+		inff_dbg(INFO, "Unknown mode, ignored\n");
+	}
+	return 0;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/btcoex.h b/drivers/net/wireless/infineon/inffmac/btcoex.h
new file mode 100644
index 000000000000..fc597d3a7575
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/btcoex.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_BTCOEX_H
+#define INFF_BTCOEX_H
+
+enum inff_btcoex_mode {
+	INFF_BTCOEX_DISABLED,
+	INFF_BTCOEX_ENABLED
+};
+
+int inff_btcoex_attach(struct inff_cfg80211_info *cfg);
+void inff_btcoex_detach(struct inff_cfg80211_info *cfg);
+int inff_btcoex_set_mode(struct inff_cfg80211_vif *vif,
+			 enum inff_btcoex_mode mode, u16 duration);
+
+#endif /* INFF_BTCOEX_H */
-- 
2.25.1


