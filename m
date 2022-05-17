Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4452A79B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbiEQQGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350676AbiEQQGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 12:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5B23BE6
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 09:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391CA6124B
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 16:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB5EC385B8;
        Tue, 17 May 2022 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803588;
        bh=oAcxzaKLovTaV2bvKwOoaeBwV1QZ6lS4t8ZStCKh+1s=;
        h=From:To:Cc:Subject:Date:From;
        b=gBALswFx2sB2GfcqvZ5wEkn9FXoQ5UCLx6L6o2DRvynuSOBgntAKiMKGOodPLKnrO
         /vbhDe1f6U489YKCFCHpd4eU513Jg+81Db+6VXeN/ZIxnCVjyfkgzW80/8hT20dV4c
         DnJNwgVQom2uiCZs1FI2zFyHAXE308uDWG9vRuRGci0XyDx+iXLt4Kvj6D3BxtgO3E
         XHUCxH92C3KJdTzYpIk/UAM7Z+ja3fEzGsva+1jZR+fXXxnO/1SlBmeWNb2g/uqzee
         +l4vgoHDeGgCvn1DWoqlqVXGKILk1zeB/XtGyXhvYuG8KJVGH/shJ9JewLb70eSAka
         pN7QsbVWfmeYg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix endianness in mt7915_rf_regval_get
Date:   Tue, 17 May 2022 18:05:59 +0200
Message-Id: <0ae7326558fdb36fb9e10ecb513f6397973bfc41.1652803390.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7915_rf_regval_get routine:
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:979:16: warning: cast to restricted __le32

Fixes: 0a17329ae9c1f ("mt76: mt7915: add debugfs knob for RF registers read/write")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index cab6e02e1f8c..d0c719ecacd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -976,7 +976,7 @@ mt7915_rf_regval_get(void *data, u64 *val)
 	if (ret)
 		return ret;
 
-	*val = le32_to_cpu(regval);
+	*val = regval;
 
 	return 0;
 }
-- 
2.35.3

