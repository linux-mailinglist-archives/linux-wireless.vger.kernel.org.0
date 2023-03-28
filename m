Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73D6CBBAD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjC1KCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjC1KBp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 06:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17E61A9
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 03:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B26B61632
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 10:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE43C433D2;
        Tue, 28 Mar 2023 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679997697;
        bh=nlT8V0kYXcLVH5zDb1O6aDkcSFyReeczDxXJJQ5/5w8=;
        h=From:To:Cc:Subject:Date:From;
        b=nQg9jg5vIepkxVgsoKc/krC+soveIBf1Wp+odThUNZ1sb8fyXZw3RbS7xvkxso3KK
         VyLnDyog5XtTb2owbi+92V5MpiO9W/++0fY2JqE+d3AqAeeNwS29VzpDnyJDZgtCow
         Sd+cvwtY1KjmI6I3DXVUG0gtXPKWxms1q1ULJs8Kn1rDydMTF6463yWQIrvZzAT3/i
         GKjjVQYOdjSNe0MYArXcjmQC+cAav535qLO6IFE9fgcRVVSpKioBfBV1sCEql+8656
         czejWOKZHvld9kGZGo6f4mf4AsUUW+CVfHqrbTlBeDsks6isage6BAbdhzrtcUbL7M
         7AigcM2Km6VKA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH wireless] wifi: mt76: mt7921: fix fw used for offload check for mt7922
Date:   Tue, 28 Mar 2023 12:01:17 +0200
Message-Id: <632d8f0c9781c9902d7160e2c080aa7e9232d50d.1679997487.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the firmware version used for offload capability check used by 0x0616
devices. This path enables offload capabilities for 0x0616 devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217245
Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index cb72ded37256..5c23c827abe4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -20,7 +20,7 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
 		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
-		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
 	{ },
 };
 
-- 
2.39.2

