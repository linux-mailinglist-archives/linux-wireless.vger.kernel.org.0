Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC3721E8E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFEGvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFEGvv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 02:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F139F
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 23:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D3AE61F45
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 06:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A50C433D2;
        Mon,  5 Jun 2023 06:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685947909;
        bh=Xggw3mgI4FsUX4Nvfu/nfssYrOWa3pNSMv5R4MEAvr4=;
        h=From:To:Cc:Subject:Date:From;
        b=BTmCOsMXxQ2AUsRAOwidnh2WaWSKieB1umaP/0kH9vHt4sJDbWme+vnEblEGI2IOD
         CfGmszt5OSlM6zk8+a5MI/p3Vmd5hJghkCgzClPCJlfI85WBlCkxXB/7UbQ4VMC8wT
         3s50no0/tp0Iwvtdo308SHP3rT2KbfsAQ1rAm0Rd196DN/JhLwIZZBjOhMJjAKxutx
         fwm6IZq9i2+ZDsOoSG5Ktg/r/qKTIZgP0WoQrhltHQlsD090NWmZqBELLCgOLbFzfF
         Aw0sVmKgKp7kbmdchGMhO17meLhgeqCrtntzIfgWdElF69QH48E2BbyitFFpVnQnqw
         tdaqCT2guvEjQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: get rid of MT7921_RESET_TIMEOUT marco
Date:   Mon,  5 Jun 2023 08:51:43 +0200
Message-Id: <f58cf85964c1444e9038ad2e299d583448199889.1685947518.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
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

MT7921_RESET_TIMEOUT is never used, so get rid of it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 39d7ebba0457..9640cc033300 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -19,7 +19,6 @@
 #define MT7921_PM_TIMEOUT		(HZ / 12)
 #define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
 #define MT7921_WATCHDOG_TIME		(HZ / 4)
-#define MT7921_RESET_TIMEOUT		(30 * HZ)
 
 #define MT7921_TX_RING_SIZE		2048
 #define MT7921_TX_MCU_RING_SIZE		256
-- 
2.40.1

