Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8964F1081
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiDDIKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiDDIKT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 04:10:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA531DE5
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 01:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1614CB80DA9
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 08:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8276C2BBE4;
        Mon,  4 Apr 2022 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649059700;
        bh=mfm/K9GcpGGhuyxVMv7sVnzDkbxipQ7cp2gWfhFmEJk=;
        h=From:To:Cc:Subject:Date:From;
        b=hsZiz0Dm1mBj8EIPBbANPXcCAm7zsB1xp6N7zQ5XvfAlBcCUMzfNAe76JSNIrp2Kz
         kYpijkfnN9Te0bHOIwsUt6YbI4qdTHPIJLBkLJUkjcG4XfZGSKsdrkCOF/B0TjYlAV
         iUlZpsjqgIufZfPE4DrWdzL+1N3WJ+ufvsBdIXupM3HlddyfTy6Nf0RZek/c6Lt1Xe
         kOhYXEZmdNNP0j1RZhc0xE+rQPxj/iTGsuJCk2sAxkxHFaWjmjoU7nEI70OT0CS2Ax
         xBo5v5XvVNcNBeom25IsukO13JYWiTWbY4+cOTkxIfFAVAVldUgke01Tte/BhzrcQh
         RMF59PUI4ENMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: fix possible uninitialized pointer dereference in mt7986_wmac_gpio_setup
Date:   Mon,  4 Apr 2022 10:08:10 +0200
Message-Id: <89680812804b5167622050717dc3931c86fd7cef.1649059572.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add default case for type switch in mt7986_wmac_gpio_setup routine in
order to avoid a possible uninitialized pointer dereference.

Fixes: 99ad32a4ca3a2 ("mt76: mt7915: add support for MT7986")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 3028c02cb840..be448d471b03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -210,6 +210,8 @@ static int mt7986_wmac_gpio_setup(struct mt7915_dev *dev)
 		if (IS_ERR_OR_NULL(state))
 			return -EINVAL;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = pinctrl_select_state(pinctrl, state);
-- 
2.35.1

