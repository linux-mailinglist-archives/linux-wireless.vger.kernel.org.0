Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816870B897
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjEVJJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEVJJJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 05:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB14BB
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 02:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17F6F61735
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 09:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201C9C433D2;
        Mon, 22 May 2023 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684746547;
        bh=Z8uuQCKFkOKGtGX/On+BwiaICnJovYkCowCwzcELjW4=;
        h=From:To:Cc:Subject:Date:From;
        b=ljkp5Y1dP0iEtoMERKIKUimTi0NoOnvN/F+9waZc9MPnveWcBHonSVuI3DtvRT1nI
         4WL/BbxLyUHQjMtYbvSwrUZh4a9t5aB1uxytnj7jpyU5iy/HkFcf11U+JNjDAsa03R
         bra9NWq9IwjsTN38j1nF9j/FdcVEXr9tLgDJJN8ksi3CdBWyYobL6GYd7SvnjcHM2x
         iBuelkVL5t6E4dPfv29qnQ+mGFK08SfFpo4C2wHJz+8EcLAfcS2XfQZk4L3/9GRmMn
         abw2xligXMHBjy5YT9PK6HoX1Dc+A2dS2OX4+hQ5mfTMpBGOL4ajAx8lsmFsG96qs7
         ib72uDuHFXUkQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix endianness warning in mt7996_mac_write_txwi
Date:   Mon, 22 May 2023 11:09:01 +0200
Message-Id: <9509f4bc32d9321f3419a3c0029a01b426f13fd8.1684746447.git.lorenzo@kernel.org>
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

Fix the following endianness warning in mt7996_mac_write_txwi routine:

drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25: warning: invalid assignment: |=
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    left side has type restricted __le32
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1091:25:    right side has type unsigned long

Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 7905070afc2c..942152a70f6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1088,7 +1088,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		else if (beacon && mvif->beacon_rates_idx)
 			idx = mvif->beacon_rates_idx;
 
-		txwi[6] |= FIELD_PREP(MT_TXD6_TX_RATE, idx);
+		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 }
-- 
2.40.1

