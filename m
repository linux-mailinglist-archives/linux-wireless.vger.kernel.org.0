Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC665BDD5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjACKQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 05:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjACKP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 05:15:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9FF6C
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 02:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B492B80E64
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 10:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7673C433D2;
        Tue,  3 Jan 2023 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672740955;
        bh=0Y3LOkAwBPu0GXmutmpHI22q7o0KKKn2e6onxQBoxYA=;
        h=From:To:Cc:Subject:Date:From;
        b=VnNLO2ID5SpLEjXovsf+Jt2mlYct9kn791zsK6AxtD4Mwr1rqxoJcgAl/0Ro4sC93
         qNi4lEsQR+JtV2SROGJjdlFWMYJrAGZEQgYLLt3+qN2RTJcSawcW4T6MaYWEF1qKOa
         k9un8imu7R3ErAjo0pby6t5NgCFT7RRJWx00Nm3Dw6YzzZkq6W+YgEFnoGdboeA5Ad
         VgiT6LskHHrOiJoimpQMJpCXK5OcxK60uYsFOUF8pg449TZ5h2RbHrCJhxcilwl5Vi
         cxk83NAv4VdeEHHma+xlUCZXIjLU6HopBxpX54lMNZszppqYMFq1gJxUaYf6jK7ao6
         /VUE/IBFsQRTA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: fix memory leak in mt7915_rate_txpower_get
Date:   Tue,  3 Jan 2023 11:15:49 +0100
Message-Id: <2ea534ec17856f65237939f3d437aad37ddc7753.1672740921.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible memory leak in mt7915_rate_txpower_get routine if
mt7915_mcu_get_txpower_sku() fails.

Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fb46c2c1784f..4730508652af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -990,14 +990,14 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 	char *buf;
 	u32 reg;
 
-	buf = kzalloc(sz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
 	if (ret)
 		return ret;
 
+	buf = kzalloc(sz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	/* Txpower propagation path: TMAC -> TXV -> BBP */
 	len += scnprintf(buf + len, sz - len,
 			 "\nPhy%d Tx power table (channel %d)\n",
-- 
2.39.0

