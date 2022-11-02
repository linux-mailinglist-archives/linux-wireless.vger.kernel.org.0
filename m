Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0402A616300
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 13:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKBMsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiKBMr7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 08:47:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E182A424
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 05:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36076B82277
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 12:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEBC433C1;
        Wed,  2 Nov 2022 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667393274;
        bh=DjaYv1Iu/TnU9Zu0Qtxjp4xmU9j2hcik4DFQyWu6rxI=;
        h=From:To:Cc:Subject:Date:From;
        b=KJ1v++AUk7gpJJ/rHOtbGGTCP07GdoupqabFKxTKJlrrwbgz+9gWWTm0B+j4h5ht4
         rRK0AaMi19DKR2xzuxFwc4uEPq8m/fBfNFZdythdsmUP+MFSaPtCTqNOtnj+VwY/QJ
         B1oBLf92Dj0G2XnkHncYVpqyjG1bMRgjdUG8JDGrnUS06YcnsTkgGGBeCZ3Qm3MFEf
         exflGIyiKajCSSvDt2dIuuhLjn454Rql/s8m14PC0ZO914OKkOb26pEq2iTgjD9zI9
         tjlIx3ky13oAMtimiDxY06ULOISgOtXFY3LLWqQpAHRHkJfob3VsBHt85ulgGtz269
         Ft/E7wtL5HgKg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: mt7921: fix reporting of TX AGGR histogram
Date:   Wed,  2 Nov 2022 13:46:50 +0100
Message-Id: <74cf11c228e9174c5d7fd794af8967d5ce9e5de7.1667393153.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915, fix stats clash between bins [4-7] in 802.11 tx
aggregation histogram.

Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 6860468ed191..1c0d8cf19b8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -984,7 +984,7 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 		mib->tx_amsdu_cnt += val;
 	}
 
-	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+	for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
 		u32 val2;
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
-- 
2.38.1

