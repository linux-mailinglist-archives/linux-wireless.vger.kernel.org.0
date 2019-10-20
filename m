Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB7DDDE1
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJTKFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:05:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfJTKFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:05:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CBE8F61650; Sun, 20 Oct 2019 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565953;
        bh=rpA34j+kT2pTKIPYfqOextdjLtmqLX/isbLDQiYh9Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krrrU6ENCJDBQm1ctweurCSi3ftHcUwXS2Sp09V1rJo+cK5/Tm9qCmDSqTfldGHLC
         mPi0BST0buEq8JyQJd2wu45A/IC0ltS9Ji6uelK2tXU0kj7lGoNG4UNfhu1tqEC0pJ
         KVvmypj8GDnSOb3ZXVTirXpkLAUZsxCwTbjq8QnA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EF0B61630;
        Sun, 20 Oct 2019 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565945;
        bh=rpA34j+kT2pTKIPYfqOextdjLtmqLX/isbLDQiYh9Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNOtI68ycsxgAYX8aYOuI5vbRX8BxKfUG/S+JrECeqDbkaCQFmcX8fTk2LY+yaNgk
         +l5TSW7k+ioNSB+CjefTcNDg4ZLUfxU2DmZOEHI4pOen5CYJ/Bb5TW6mNw4UiJkTrE
         p2b6UCFIfP5q9HlYhBrZvQy5zGKi1mv0JaaUspw4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EF0B61630
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 40/49] ath11k: add testmode.c
Date:   Sun, 20 Oct 2019 13:03:58 +0300
Message-Id: <1571565847-10338-41-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/testmode.c | 199 +++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
new file mode 100644
index 000000000000..932bee6d1740
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include "testmode.h"
+#include <net/netlink.h>
+#include "debug.h"
+#include "wmi.h"
+#include "hw.h"
+#include "core.h"
+#include "testmode_i.h"
+
+static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
+	[ATH11K_TM_ATTR_CMD]		= { .type = NLA_U32 },
+	[ATH11K_TM_ATTR_DATA]		= { .type = NLA_BINARY,
+					    .len = ATH11K_TM_DATA_MAX_LEN },
+	[ATH11K_TM_ATTR_WMI_CMDID]	= { .type = NLA_U32 },
+	[ATH11K_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
+	[ATH11K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
+};
+
+/* Returns true if callee consumes the skb and the skb should be discarded.
+ * Returns false if skb is not used. Does not sleep.
+ */
+bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)
+{
+	struct sk_buff *nl_skb;
+	bool consumed;
+	int ret;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d skb %pK skb->len %d\n",
+		   cmd_id, skb, skb->len);
+
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
+
+	spin_lock_bh(&ar->data_lock);
+
+	consumed = true;
+
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
+						   2 * sizeof(u32) + skb->len,
+						   GFP_ATOMIC);
+	if (!nl_skb) {
+		ath11k_warn(ar->ab,
+			    "failed to allocate skb for testmode wmi event\n");
+		goto out;
+	}
+
+	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD, ATH11K_TM_CMD_WMI);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to to put testmode wmi event cmd attribute: %d\n",
+			    ret);
+		kfree_skb(nl_skb);
+		goto out;
+	}
+
+	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to to put testmode wmi even cmd_id: %d\n",
+			    ret);
+		kfree_skb(nl_skb);
+		goto out;
+	}
+
+	ret = nla_put(nl_skb, ATH11K_TM_ATTR_DATA, skb->len, skb->data);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to copy skb to testmode wmi event: %d\n",
+			    ret);
+		kfree_skb(nl_skb);
+		goto out;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+
+out:
+	spin_unlock_bh(&ar->data_lock);
+
+	return consumed;
+}
+
+static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
+{
+	struct sk_buff *skb;
+	int ret;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
+		   "testmode cmd get version_major %d version_minor %d\n",
+		   ATH11K_TESTMODE_VERSION_MAJOR,
+		   ATH11K_TESTMODE_VERSION_MINOR);
+
+	skb = cfg80211_testmode_alloc_reply_skb(ar->hw->wiphy,
+						nla_total_size(sizeof(u32)));
+	if (!skb)
+		return -ENOMEM;
+
+	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
+			  ATH11K_TESTMODE_VERSION_MAJOR);
+	if (ret) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
+			  ATH11K_TESTMODE_VERSION_MINOR);
+	if (ret) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	return cfg80211_testmode_reply(skb);
+}
+
+static int ath11k_tm_cmd_wmi(struct ath11k *ar, struct nlattr *tb[])
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct sk_buff *skb;
+	u32 cmd_id, buf_len;
+	int ret;
+	void *buf;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	if (!tb[ATH11K_TM_ATTR_DATA]) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!tb[ATH11K_TM_ATTR_WMI_CMDID]) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf = nla_data(tb[ATH11K_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH11K_TM_ATTR_DATA]);
+	cmd_id = nla_get_u32(tb[ATH11K_TM_ATTR_WMI_CMDID]);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
+		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
+		   cmd_id, buf, buf_len);
+
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", buf, buf_len);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, buf_len);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(skb->data, buf, buf_len);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, cmd_id);
+	if (ret) {
+		dev_kfree_skb(skb);
+		ath11k_warn(ar->ab, "failed to transmit wmi command (testmode): %d\n",
+			    ret);
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  void *data, int len)
+{
+	struct ath11k *ar = hw->priv;
+	struct nlattr *tb[ATH11K_TM_ATTR_MAX + 1];
+	int ret;
+
+	ret = nla_parse(tb, ATH11K_TM_ATTR_MAX, data, len, ath11k_tm_policy,
+			NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[ATH11K_TM_ATTR_CMD])
+		return -EINVAL;
+
+	switch (nla_get_u32(tb[ATH11K_TM_ATTR_CMD])) {
+	case ATH11K_TM_CMD_GET_VERSION:
+		return ath11k_tm_cmd_get_version(ar, tb);
+	case ATH11K_TM_CMD_WMI:
+		return ath11k_tm_cmd_wmi(ar, tb);
+	default:
+		return -EOPNOTSUPP;
+	}
+}

