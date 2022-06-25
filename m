Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094255ACBB
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiFYVYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672A13EB5
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q/jMzgf/jsjzqIhl2ruHN5aDUCE9o0c0u+/yCZPnc7M=; b=ivvHh4G3IrYaEWjqahgaA2VxRR
        ufenb3bev4WE1raB14oRmBmiL00vzF+fqClIocTscpm8wqoy5WcP9PA6/qripBOhnYUry3JPZdCKZ
        HFLPYJkNkRjMe2eoChRdNoJMwAPGGrf4bCtJCsr6i0XeWO0QKDdfd6n2a/BT3f3D038g=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGI-0003Vi-4J; Sat, 25 Jun 2022 23:24:14 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 6/7] mac80211: add debugfs file to display per-phy AQL pending airtime
Date:   Sat, 25 Jun 2022 23:24:10 +0200
Message-Id: <20220625212411.36675-6-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625212411.36675-1-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Now that the global pending airtime is more relevant for airtime fairness,
it makes sense to make it accessible via debugfs for debugging

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/debugfs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 0c748b1eb023..4d4341249759 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -201,6 +201,36 @@ static const struct file_operations airtime_flags_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t aql_pending_read(struct file *file,
+				char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[400];
+	int len = 0;
+
+	len = scnprintf(buf, sizeof(buf),
+			"AC     AQL pending\n"
+			"VO     %u us\n"
+			"VI     %u us\n"
+			"BE     %u us\n"
+			"BK     %u us\n"
+			"total  %u us\n",
+			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VO]),
+			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VI]),
+			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
+			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
+			atomic_read(&local->aql_total_pending_airtime));
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buf, len);
+}
+
+static const struct file_operations aql_pending_ops = {
+	.read = aql_pending_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static ssize_t aql_txq_limit_read(struct file *file,
 				  char __user *user_buf,
 				  size_t count,
@@ -631,6 +661,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD(hw_conf);
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 	DEBUGFS_ADD_MODE(aql_enable, 0600);
+	DEBUGFS_ADD(aql_pending);
 
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
-- 
2.36.1

