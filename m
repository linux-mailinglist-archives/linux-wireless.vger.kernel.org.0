Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23D2A93AC
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKFKHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:07:24 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39903 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKFKHX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:07:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604657241; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AWU6PhE47sDy3XmMKU1D96UdKUc2jx3axIWbUz2bTtY=; b=pO8bDMzx2keHjI2P8Ci6c1lDehbau2WUXNSKVs8joxAQzPomzrCWMQCQw4Nuq3DUUSHlv5vx
 QP+Mpw+JNJvwd0K2FVR2+OZ9RpkVW53HD9O4iSh7gxZbd6843oh8GsHA+aBHKVAuBV2OZLxR
 n36oU/xNArciC2GG12uQldq/cJk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa52059e58103ecbcae1d12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 10:07:21
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9A9EC433C6; Fri,  6 Nov 2020 10:07:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A97D3C433CB;
        Fri,  6 Nov 2020 10:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A97D3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        dianders@chromium.org, kuabhs@google.com
Subject: [PATCH 2/3] mac80211: add ieee80211_set_sar_specs
Date:   Fri,  6 Nov 2020 05:07:07 -0500
Message-Id: <20201106100708.4609-3-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106100708.4609-1-cjhuang@codeaurora.org>
References: <20201106100708.4609-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This change registers ieee80211_set_sar_specs to
mac80211_config_ops, so cfg80211 can call it.

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/cfg.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ec148b3..df758ee 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4125,6 +4125,8 @@ struct ieee80211_ops {
 	int (*reset_tid_config)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta, u8 tids);
+	int (*set_sar_specs)(struct ieee80211_hw *hw,
+			     const struct cfg80211_sar_specs *sar);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4e39e3..cc74322 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3993,6 +3993,17 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
 	return ret;
 }
 
+static int ieee80211_set_sar_specs(struct wiphy *wiphy,
+				   struct cfg80211_sar_specs *sar)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (!local->ops->set_sar_specs)
+		return -EOPNOTSUPP;
+
+	return local->ops->set_sar_specs(&local->hw, sar);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4096,4 +4107,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.probe_mesh_link = ieee80211_probe_mesh_link,
 	.set_tid_config = ieee80211_set_tid_config,
 	.reset_tid_config = ieee80211_reset_tid_config,
+	.set_sar_specs = ieee80211_set_sar_specs,
 };
-- 
2.7.4

