Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259053C7A7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiFCJhW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiFCJhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 05:37:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80D91115A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 02:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D5F619B5
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3349CC385A9;
        Fri,  3 Jun 2022 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654249028;
        bh=3mJdSExtj2HVPSGN5VmTJ62q01/n+owBiA6wt40zW/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhbOLkPQqXqRTch02axBEBjUQVwDTfn/aXXFZip1aZYDFbqyZYMGV0FuiznsPHoca
         DMkzDvbXZokigesO4rYxx6xh1GEX2Ef3ks+E+n9ztwv3XRDBsq80MdOULPVHjkUqKN
         pKtTC3e6FcKT/gNw2va+WoW1VSVYABTnddrkfNA8cZZYhg4B2kckaMZoCkuruInOBB
         HAM5AtU1ahInBqeqUu/Hz8wj1onnfA2PexJOj0rGfwi/+Q+bN+kD+8kSDKJh4B0SNo
         dOWCu4LjPvIVHgCE6QbSkAQMrp/DaNjJiC9C1kMs4SYH8ulg4cfIeC0RnhlHJt1+5B
         OPfzFUrIIGpHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 2/5] mt76: mt7921: move fw toggle in mt7921_load_firmware
Date:   Fri,  3 Jun 2022 11:36:43 +0200
Message-Id: <8d3f5d937138d5bb1694235cf71aeef7a28f7cd1.1654248715.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654248715.git.lorenzo@kernel.org>
References: <cover.1654248715.git.lorenzo@kernel.org>
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

Move drv_own/fw_own toggle in mt7921_load_firmware. This change allow to
reuse connac code to load patch for mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1f1c270a4d81..bf1648b02ab5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -537,13 +537,6 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		break;
 	}
 
-	if (!ret && mt76_is_sdio(&dev->mt76)) {
-		/* activate again */
-		ret = __mt7921_mcu_fw_pmctrl(dev);
-		if (!ret)
-			ret = __mt7921_mcu_drv_pmctrl(dev);
-	}
-
 	release_firmware(fw);
 
 	return ret;
@@ -662,6 +655,13 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
+	if (mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt7921_mcu_fw_pmctrl(dev);
+		if (!ret)
+			ret = __mt7921_mcu_drv_pmctrl(dev);
+	}
+
 	ret = mt7921_load_ram(dev);
 	if (ret)
 		return ret;
-- 
2.35.3

