Return-Path: <linux-wireless+bounces-11035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE805949650
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF11C23878
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515DA176AD0;
	Tue,  6 Aug 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TgpMSWhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E78173331;
	Tue,  6 Aug 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963721; cv=none; b=Z8PJFJdPjcM/h/dz6zFs4Ez3f9hc1297Yxb3/CHvyHm1dZA3c2+IwK80wH7TnRYTbVAYFqhB0WewyL0sFh2fNSccUNiLz940JkuTrPjJc505ehxptG8N7+IcU6uyEioT2We8xQ7tY7lqzcV6FvSeofBTAvXEJaInMuq7PUzhjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963721; c=relaxed/simple;
	bh=UCO5+KhbgsK1kQSN/woFq+iZsxldEHT3xSvjVd+w0Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO8KubpFI48qOLWcnK7FMVtiWyWjBJg1/jqFEU392j9RkcHPURmsL1koD/cgiKxDtPVYtFECtbyqoDG65u0/E4eolU0EIkRUuuJQ+limECUq72SM9mqnQEy1IPFnQiZb1r1LRNy9IYsIZhOwRlsO8TjTTbWHhsNnZAlsaInjOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TgpMSWhh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1nob055337;
	Tue, 6 Aug 2024 12:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963709;
	bh=hJ7RYsPLtASkS0lhgQY19gST6H0vK537u8leRJPiIqY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TgpMSWhhkP/2UF/Xd4ire3kEdogEYKSbp7JwtEonb/WtjJPe4KfwwQuvXvl2tYWMi
	 /ww1XsHRfO16AAb9zQPCMFb7Ay/ms9uICx2DCECAw09S7eDrd0a+gvojGNxCbjhyUk
	 Q1XEJXUlzyG8w3+W+SKCkPKHr0ZQzpN1QjRciKd0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1npK090716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:48 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1lra039189;
	Tue, 6 Aug 2024 12:01:48 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v3 15/17] wifi: cc33xx: Add testmode.c, testmode.h
Date: Tue, 6 Aug 2024 20:00:16 +0300
Message-ID: <20240806170018.638585-16-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806170018.638585-1-michael.nemanov@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Allows a user-space tools to access FW APIs via CFG80211_TESTMODE
infrastructure.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/testmode.c | 359 ++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/testmode.h |  12 +
 2 files changed, 371 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.h

diff --git a/drivers/net/wireless/ti/cc33xx/testmode.c b/drivers/net/wireless/ti/cc33xx/testmode.c
new file mode 100644
index 000000000000..e1a372ec97d1
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/testmode.c
@@ -0,0 +1,359 @@
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
+	int ret, len;
+	u16 buf_len;
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
+	int ret;
+	u16 buf_len;
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
2.34.1


