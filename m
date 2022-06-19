Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A763550ABF
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jun 2022 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiFSNF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jun 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFSNF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jun 2022 09:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED6BE0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 06:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822EB6114E
        for <linux-wireless@vger.kernel.org>; Sun, 19 Jun 2022 13:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A59C341C6;
        Sun, 19 Jun 2022 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655643956;
        bh=yJqyxnOysUkN8QnONTZ41WdPOwf4U7nx1dFeoeADaCU=;
        h=From:To:Cc:Subject:Date:From;
        b=enX5VHEbaKXxps/P17H1o40fevdRD+AYYp5GheTD7STS/fWrmzXWfqdwSMtCk+96+
         MjG9fcWFV1dIFaLSMw+G8/C55tu0TinEek1X56T6l0uh4KAC+EHAEDZoQVryzHyD2T
         4u0IlbfWBENosbpUHiQ/jT5cnSsjzx/40L8zzH2feVfFAabrEW7ijbXYVAt0ajnd+9
         0KUG1khon+xAtTSWV1mB1EyH6yvWhHZg3K+YqLhmRWQU+tMYiS/5tAM6PxiaxyJr64
         Zr3m6LeHglXFI7g7Dl7s55euNjm3gxHakiPQaUgmZblwNCsxOG0/r9aEGJgeq7hiNO
         2NVwsfV/u8HYA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7915: get rid of unnecessary new line in mt7915_mac_write_txwi
Date:   Sun, 19 Jun 2022 15:05:51 +0200
Message-Id: <15be919e5184692c254f5d625dc546c94a4c16da.1655643835.git.lorenzo@kernel.org>
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

Remove unnecessary new line in mt7915_mac_write_txwi routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a575a44685b2..3af4a6afb55b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -672,7 +672,6 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, changed);
 
-
 	if (mt76_testmode_enabled(mphy))
 		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
 }
-- 
2.36.1

