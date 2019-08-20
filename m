Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA196577
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfHTPur (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbfHTPur (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A307861C52; Tue, 20 Aug 2019 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316245;
        bh=OYIxDz/6FqVLAYw3ppZvUqE7P0HvAcW1eJTB2m2sM4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS64AGrJt6ezPip23VCrbs3szwIGaSNmjguhs/3kH0AgolNSq1URc9WBoRHeMfyvW
         6fPrPY8Ajf3XLMz4dt+Qf8SgavM0DQubkulLbWNbWSVgbQjsiLAYzVuvPkIZfMraeW
         AKrFH2XWRqNyf9bSOYIBWXdfhEyh1IgMg7M3VHag=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6ACAA61B97;
        Tue, 20 Aug 2019 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316208;
        bh=OYIxDz/6FqVLAYw3ppZvUqE7P0HvAcW1eJTB2m2sM4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1/aHag9b7qzv4RsGIYBZk6lIx0y8P0XfLOEgRuoWHvWosI8SrMz2EiOMlXEfWSml
         U0+9Xew1m/+A0lqtOnCv6DaY2hkMvHUvOzfbRn4BvqKgeeq/hr5uGmWSzdPOvr6ojK
         eUKpgrwfTYbJaezoxnrFFbDX76U0yLWif0VMe2lo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ACAA61B97
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 40/49] ath11k: add testmode.c
Date:   Tue, 20 Aug 2019 18:48:06 +0300
Message-Id: <1566316095-27507-41-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/testmode.c | 199 +++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
new file mode 100644
index 000000000000..9274b6cc3921
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: ISC
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

