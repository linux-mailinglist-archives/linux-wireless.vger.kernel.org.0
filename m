Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAB553EBA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354838AbiFUWvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 18:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFUWvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 18:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BD31374
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 15:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157B46160E
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 22:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B0DC3411C;
        Tue, 21 Jun 2022 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655851902;
        bh=4W9ii2RKDpZIoHbjqx+xSSzcOKdm2U1i15grOer6jp8=;
        h=From:To:Cc:Subject:Date:From;
        b=VXa9Racxx7jz/uEKwYOkISzfote06Z7x8t+Mk9DJuPx3Vud/567zPImzFkXyMbYFd
         w1WW1x7xxaU7Q0prY/uyoXNCflnsTL8bncZO6FK4UVDEJXJltDr4TmkpuquEz0UcWp
         3aWgHu0iionmoedmiUc/k88N75SAcjU1g6B+UiAx4NiXtDk/UG9Jb570hAPmlYmKTd
         s4qV1XsSRhORFXl5vYPrhm/2JT9mSuYAscMoWOuWjKM/RkXjr9OSo5svRaPFBFhoa9
         4GrxmqJviWYnstiVlgDh11Sggn021BzwKuOVKhA7RfREbXdSMCc3ACeMZt3ghjbexA
         hxjxlFAn4xCBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: do not copy ieee80211_ops pointer in mt7915_mmio_probe
Date:   Wed, 22 Jun 2022 00:51:24 +0200
Message-Id: <1801887f3b435958c2b09d5c5d18c9bede94f333.1655851816.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We do not modify ieee80211_ops pointers so we do not need to copy them.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index c2646d24b574..930fae7a0bd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -661,16 +661,11 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 		.sta_remove = mt7915_mac_sta_remove,
 		.update_survey = mt7915_update_channel,
 	};
-	struct ieee80211_ops *ops;
 	struct mt7915_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
 
-	ops = devm_kmemdup(pdev, &mt7915_ops, sizeof(mt7915_ops), GFP_KERNEL);
-	if (!ops)
-		return ERR_PTR(-ENOMEM);
-
-	mdev = mt76_alloc_device(pdev, sizeof(*dev), ops, &drv_ops);
+	mdev = mt76_alloc_device(pdev, sizeof(*dev), &mt7915_ops, &drv_ops);
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.36.1

