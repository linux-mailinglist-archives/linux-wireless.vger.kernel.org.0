Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0EFD93C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfKOJbV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:31:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKOJbU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:31:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 848A661669; Fri, 15 Nov 2019 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810279;
        bh=rpA34j+kT2pTKIPYfqOextdjLtmqLX/isbLDQiYh9Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4WojHpzmG+LdQyZ08gz9fy6VZQu+KHFz6wi/dqlQ1TUasaW9hadoxfLo6WFzZdVe
         Jo2JPt+dGeWpp1W0uHn9cr0F5/LBOMqzBzP6K7WHXpnLtALT2jBr7MkuqSX8W5Yt67
         d5+9F+rLEoWH1yUmD+SwpT+0R09PTjAZoQMyB/Cg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BADA61670;
        Fri, 15 Nov 2019 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810259;
        bh=rpA34j+kT2pTKIPYfqOextdjLtmqLX/isbLDQiYh9Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQBB1a+stdn4M3VgVW7qV5CXS3fPqsqmJ6xCrrjsu8Vcn3O38bQi7kYOY9UP5/I6g
         FI1MCxS3jCswm61E7cBqZOrYnRC+bbtQ7DEQsi0Qm0wDuMYKT3pUmQMdFIllaYOqOY
         QzvJGtX45U4owZbExZtq7l1fG1E4FkqXoOGsSC60=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BADA61670
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 40/49] ath11k: add testmode.c
Date:   Fri, 15 Nov 2019 11:29:04 +0200
Message-Id: <1573810153-29623-41-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
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

