Return-Path: <linux-wireless+bounces-7915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A18CB2C1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBC1C218C8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D9149E0A;
	Tue, 21 May 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pVhCSsW3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38391494CD;
	Tue, 21 May 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311973; cv=none; b=kM+2c/XlglVbPjvf8SKAycIzwoJ/L4sHAoBb7FJmOy9/9HjOdc6duU5FS7d1spDi4q7IEF4CUYFOrykaIWnq+lpESr+f9x8BUmJxdA7SOu3ueMA0QoeKedBguBm8H4CttwPp+zW2Q0Nz10+N8QVSxReXlDl+F7LJbQTNNFpXuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311973; c=relaxed/simple;
	bh=VkAv+9RQal1an9tN8YAIdQx6dIthw4Ls6SaEMdJs2Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeR6zEKMPYlTVRxhIqGSPVswVWcd107+puCyFXOL9qd3fnMJEUHieYbaymhOtZ0pSyWfL+SW0SIbi9vcRaqIzrKcHr9VVGGVgvJ7pdcTKhhntE0kBXca0tVAnEAvYVe+R+WlXVjU51EdKUnj22Pqo8uERCikVziWfMQGQ2Jrf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pVhCSsW3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJIPU090447;
	Tue, 21 May 2024 12:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311958;
	bh=PDWgra4GhyaLxhcebmPBYxE5bgzO0zs9zMXxHl+F/SU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pVhCSsW3krcYv2+tjDg5jIDUNB+75J9OC8J14PAUlmi2axOnZn3LAw4s07s+djRnh
	 dsatfO30g8utqUNQIEQ/0aHvIStHIx0G0X7Hhk9nd8/EM2OrpdmTYGmhbh9Z6WRzQE
	 bFlV8gyj8nEn7tZOgBLMhgT1CVtgSAQ5BFdz8J5E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHJHK8026959
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:19:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:19:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:19:17 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJGtx023578;
	Tue, 21 May 2024 12:19:17 -0500
From: <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees
 Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>,
        Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH 15/17] Add testmode.c, testmode.h
Date: Tue, 21 May 2024 20:18:39 +0300
Message-ID: <20240521171841.884576-16-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521171841.884576-1-michael.nemanov@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

Allows a user-space tools to access FW APIs via CFG80211_TESTMODE
infrastructure.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/testmode.c | 357 ++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/testmode.h |  12 +
 2 files changed, 369 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.h

diff --git a/drivers/net/wireless/ti/cc33xx/testmode.c b/drivers/net/wireless/ti/cc33xx/testmode.c
new file mode 100644
index 000000000000..032f50be5e7d
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/testmode.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <net/genetlink.h>
+
+#include "cc33xx.h"
+#include "acx.h"
+#include "io.h"
+#include "testmode.h"
+
+#define CC33XX_TM_MAX_DATA_LENGTH 1024
+
+enum cc33xx_tm_commands {
+	CC33XX_TM_CMD_UNSPEC,
+	CC33XX_TM_CMD_TEST,
+	CC33XX_TM_CMD_INTERROGATE,
+	CC33XX_TM_CMD_CONFIGURE,
+	CC33XX_TM_CMD_NVS_PUSH,		/* Not in use. Keep to not break ABI */
+	CC33XX_TM_CMD_SET_PLT_MODE,
+	CC33XX_TM_CMD_RECOVER,		/* Not in use. Keep to not break ABI */
+	CC33XX_TM_CMD_GET_MAC,
+
+	__CC33XX_TM_CMD_AFTER_LAST
+};
+
+enum cc33xx_tm_attrs {
+	CC33XX_TM_ATTR_UNSPEC,
+	CC33XX_TM_ATTR_CMD_ID,
+	CC33XX_TM_ATTR_ANSWER,
+	CC33XX_TM_ATTR_DATA,
+	CC33XX_TM_ATTR_IE_ID,
+	CC33XX_TM_ATTR_PLT_MODE,
+
+	__CC33XX_TM_ATTR_AFTER_LAST
+};
+
+#define CC33XX_TM_ATTR_MAX (__CC33XX_TM_ATTR_AFTER_LAST - 1)
+
+static struct nla_policy cc33xx_tm_policy[CC33XX_TM_ATTR_MAX + 1] = {
+	[CC33XX_TM_ATTR_CMD_ID] =	{ .type = NLA_U32 },
+	[CC33XX_TM_ATTR_ANSWER] =	{ .type = NLA_U8 },
+	[CC33XX_TM_ATTR_DATA] =		{ .type = NLA_BINARY,
+					  .len = CC33XX_TM_MAX_DATA_LENGTH },
+	[CC33XX_TM_ATTR_IE_ID] =	{ .type = NLA_U32 },
+	[CC33XX_TM_ATTR_PLT_MODE] =	{ .type = NLA_U32 },
+};
+
+static int cc33xx_tm_cmd_test(struct cc33xx *cc, struct nlattr *tb[])
+{
+	int buf_len, ret, len;
+	struct sk_buff *skb;
+	void *buf;
+	u8 answer = 0;
+
+	cc33xx_debug(DEBUG_TESTMODE, "testmode cmd test");
+
+	if (!tb[CC33XX_TM_ATTR_DATA])
+		return -EINVAL;
+
+	buf = nla_data(tb[CC33XX_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[CC33XX_TM_ATTR_DATA]);
+
+	if (tb[CC33XX_TM_ATTR_ANSWER])
+		answer = nla_get_u8(tb[CC33XX_TM_ATTR_ANSWER]);
+
+	if (buf_len > sizeof(struct cc33xx_command))
+		return -EMSGSIZE;
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_test(cc, buf, buf_len, answer);
+	if (ret < 0) {
+		cc33xx_warning("testmode cmd test failed: %d", ret);
+		goto out;
+	}
+
+	if (answer) {
+		/* If we got bip calibration answer print radio status */
+		struct cc33xx_cmd_cal_p2g *params =
+			(struct cc33xx_cmd_cal_p2g *)buf;
+		s16 radio_status = (s16)le16_to_cpu(params->radio_status);
+
+		if (params->test.id == TEST_CMD_P2G_CAL && radio_status < 0)
+			cc33xx_warning("testmode cmd: radio status=%d",
+				       radio_status);
+		else
+			cc33xx_info("testmode cmd: radio status=%d",
+				    radio_status);
+
+		len = nla_total_size(buf_len);
+		skb = cfg80211_testmode_alloc_reply_skb(cc->hw->wiphy, len);
+		if (!skb) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (nla_put(skb, CC33XX_TM_ATTR_DATA, buf_len, buf)) {
+			kfree_skb(skb);
+			ret = -EMSGSIZE;
+			goto out;
+		}
+
+		ret = cfg80211_testmode_reply(skb);
+	}
+
+out:
+	mutex_unlock(&cc->mutex);
+
+	return ret;
+}
+
+static int cc33xx_tm_cmd_interrogate(struct cc33xx *cc, struct nlattr *tb[])
+{
+	int ret;
+	struct cc33xx_command *cmd;
+	struct sk_buff *skb;
+	u8 ie_id;
+
+	cc33xx_debug(DEBUG_TESTMODE, "testmode cmd interrogate");
+
+	if (!tb[CC33XX_TM_ATTR_IE_ID])
+		return -EINVAL;
+
+	ie_id = nla_get_u8(tb[CC33XX_TM_ATTR_IE_ID]);
+
+	cc33xx_debug(DEBUG_TESTMODE, "testmode cmd interrogate id %d", ie_id);
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_debug_inter(cc, ie_id, cmd,
+				     sizeof(struct acx_header), sizeof(*cmd));
+	if (ret < 0) {
+		cc33xx_warning("testmode cmd interrogate failed: %d", ret);
+		goto out_free;
+	}
+
+	skb = cfg80211_testmode_alloc_reply_skb(cc->hw->wiphy, sizeof(*cmd));
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	if (nla_put(skb, CC33XX_TM_ATTR_DATA, sizeof(*cmd), cmd)) {
+		kfree_skb(skb);
+		ret = -EMSGSIZE;
+		goto out_free;
+	}
+
+	ret = cfg80211_testmode_reply(skb);
+	if (ret < 0)
+		goto out_free;
+
+out_free:
+	kfree(cmd);
+
+out:
+	mutex_unlock(&cc->mutex);
+
+	return ret;
+}
+
+static int cc33xx_tm_cmd_configure(struct cc33xx *cc, struct nlattr *tb[])
+{
+	int buf_len, ret;
+	void *buf;
+	u8 ie_id;
+
+	cc33xx_debug(DEBUG_TESTMODE, "testmode cmd configure");
+
+	if (!tb[CC33XX_TM_ATTR_DATA])
+		return -EINVAL;
+	if (!tb[CC33XX_TM_ATTR_IE_ID])
+		return -EINVAL;
+
+	ie_id = nla_get_u8(tb[CC33XX_TM_ATTR_IE_ID]);
+	buf = nla_data(tb[CC33XX_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[CC33XX_TM_ATTR_DATA]);
+
+	if (buf_len > sizeof(struct cc33xx_command))
+		return -EMSGSIZE;
+
+	mutex_lock(&cc->mutex);
+	ret = cc33xx_cmd_debug(cc, ie_id, buf, buf_len);
+	mutex_unlock(&cc->mutex);
+
+	if (ret < 0) {
+		cc33xx_warning("testmode cmd configure failed: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cc33xx_tm_detect_fem(struct cc33xx *cc, struct nlattr *tb[])
+{
+	/* return FEM type */
+	int ret, len;
+	struct sk_buff *skb;
+
+	ret = cc33xx_plt_start(cc, PLT_FEM_DETECT);
+	if (ret < 0)
+		goto out;
+
+	mutex_lock(&cc->mutex);
+
+	len = nla_total_size(sizeof(cc->fem_manuf));
+	skb = cfg80211_testmode_alloc_reply_skb(cc->hw->wiphy, len);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_mutex;
+	}
+
+	if (nla_put(skb, CC33XX_TM_ATTR_DATA, sizeof(cc->fem_manuf),
+		    &cc->fem_manuf)) {
+		kfree_skb(skb);
+		ret = -EMSGSIZE;
+		goto out_mutex;
+	}
+
+	ret = cfg80211_testmode_reply(skb);
+
+out_mutex:
+	mutex_unlock(&cc->mutex);
+
+	/* We always stop plt after DETECT mode */
+	cc33xx_plt_stop(cc);
+out:
+	return ret;
+}
+
+static int cc33xx_tm_cmd_set_plt_mode(struct cc33xx *cc, struct nlattr *tb[])
+{
+	u32 val;
+	int ret;
+
+	cc33xx_debug(DEBUG_TESTMODE, "testmode cmd set plt mode");
+
+	if (!tb[CC33XX_TM_ATTR_PLT_MODE])
+		return -EINVAL;
+
+	val = nla_get_u32(tb[CC33XX_TM_ATTR_PLT_MODE]);
+
+	switch (val) {
+	case PLT_OFF:
+		ret = cc33xx_plt_stop(cc);
+		break;
+	case PLT_ON:
+	case PLT_CHIP_AWAKE:
+		ret = cc33xx_plt_start(cc, val);
+		break;
+	case PLT_FEM_DETECT:
+		ret = cc33xx_tm_detect_fem(cc, tb);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int cc33xx_tm_cmd_get_mac(struct cc33xx *cc, struct nlattr *tb[])
+{
+	struct sk_buff *skb;
+	u8 zero_mac[ETH_ALEN] = {0};
+	int ret = 0;
+
+	mutex_lock(&cc->mutex);
+
+	if (!cc->plt) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (memcmp(zero_mac, cc->efuse_mac_address, ETH_ALEN) == 0) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	skb = cfg80211_testmode_alloc_reply_skb(cc->hw->wiphy, ETH_ALEN);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (nla_put(skb, CC33XX_TM_ATTR_DATA,
+		    ETH_ALEN, cc->efuse_mac_address)) {
+		kfree_skb(skb);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
+	ret = cfg80211_testmode_reply(skb);
+	if (ret < 0)
+		goto out;
+
+out:
+	mutex_unlock(&cc->mutex);
+	return ret;
+}
+
+int cc33xx_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len)
+{
+	struct cc33xx *cc = hw->priv;
+	struct nlattr *tb[CC33XX_TM_ATTR_MAX + 1];
+	u32 nla_cmd;
+	int err;
+
+	err = nla_parse_deprecated(tb, CC33XX_TM_ATTR_MAX, data, len,
+				   cc33xx_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (!tb[CC33XX_TM_ATTR_CMD_ID])
+		return -EINVAL;
+
+	nla_cmd = nla_get_u32(tb[CC33XX_TM_ATTR_CMD_ID]);
+
+	/* Only SET_PLT_MODE is allowed in case of mode PLT_CHIP_AWAKE */
+	if (cc->plt_mode == PLT_CHIP_AWAKE &&
+	    nla_cmd != CC33XX_TM_CMD_SET_PLT_MODE)
+		return -EOPNOTSUPP;
+
+	switch (nla_cmd) {
+	case CC33XX_TM_CMD_TEST:
+		return cc33xx_tm_cmd_test(cc, tb);
+	case CC33XX_TM_CMD_INTERROGATE:
+		return cc33xx_tm_cmd_interrogate(cc, tb);
+	case CC33XX_TM_CMD_CONFIGURE:
+		return cc33xx_tm_cmd_configure(cc, tb);
+	case CC33XX_TM_CMD_SET_PLT_MODE:
+		return cc33xx_tm_cmd_set_plt_mode(cc, tb);
+	case CC33XX_TM_CMD_GET_MAC:
+		return cc33xx_tm_cmd_get_mac(cc, tb);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/wireless/ti/cc33xx/testmode.h b/drivers/net/wireless/ti/cc33xx/testmode.h
new file mode 100644
index 000000000000..58f336202925
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/testmode.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __TESTMODE_H__
+#define __TESTMODE_H__
+
+int cc33xx_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len);
+
+#endif /* __TESTMODE_H__ */
-- 
2.25.1


