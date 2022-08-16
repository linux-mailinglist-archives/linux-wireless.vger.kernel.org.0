Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877D59590C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiHPK4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 06:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiHPKzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 06:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13118F2C9E
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 03:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1F5612F0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 10:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2744AC433C1;
        Tue, 16 Aug 2022 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660644590;
        bh=papoG9pIkm60eff7CO4HmAEVFaVlnwUd0ZxEl94h/QM=;
        h=From:To:Cc:Subject:Date:From;
        b=cdMHX7MGRqkIAW3y5ZKwWrL4oifDJZY6ow0gpyqKs1/EcZyEW7aBb1luXHvu2sRbf
         S1CppV4Q6DR7JnbETCmouh03EaUweZX7Ue7EdpI88K9PeyculVQSbn+lAxadYRuueV
         HMgPSSRPCN9B/rL6W7EeFsfZU44q99dpp8Wl4NB+z/K4e/pqxo+J9qISm7oTBwuTIt
         i/n+0Nu4+1DX+RV1lReo8YkHWYkoPZim0kF4Js49Bk0sgiFAz0cnhNHWvyWTXVGvCz
         9RHxONozqaxIzxVsD5gDt5VwD7DWge9iBn4qROYBAUUFHfoxcyqAu9Y9+IZzNULXFY
         4RL6AF+jqg0dw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921: remove dead code
Date:   Tue, 16 Aug 2022 12:09:41 +0200
Message-Id: <2354824dc68444c83a71f7121582f482ee0adab1.1660644457.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.2
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

remove duplicated code in mt7921_pci_suspend routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9b75756c2837..2eaff6b6aa13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -405,9 +405,6 @@ static int mt7921_pci_suspend(struct device *device)
 	if (err)
 		goto restore_napi;
 
-	if (err)
-		goto restore_napi;
-
 	return 0;
 
 restore_napi:
-- 
2.37.2

