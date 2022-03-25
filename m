Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A64E7C83
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiCYVMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiCYVMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 17:12:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982A3892
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uXBAt9XsRmUuSPIcQ9NHpAxUz3a5Chm+TIyzTY05THE=; b=NYB2AuT2Df9z/B+HwA1VRQDFEI
        PSfsmMZfHntEvZA8KQYNelMb5YihM3IhsNJgf2BSDhduynvvTrzBSo2iUw8BcBh2NTtd3UwOOsDKN
        Y5Z6wQQWC0p3YQb1LtgXkLabFiXOE5GN30vISXfL71nX8U31K6uxd867laB51hged9Mc=;
Received: from p200300daa70ef200dc11dea3d730df97.dip0.t-ipconnect.de ([2003:da:a70e:f200:dc11:dea3:d730:df97] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nXrCi-0001fW-Dp
        for linux-wireless@vger.kernel.org; Fri, 25 Mar 2022 22:10:40 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] mt76: mt7915: accept rx frames with non-standard VHT MCS10-11
Date:   Fri, 25 Mar 2022 22:10:29 +0100
Message-Id: <20220325211031.24171-6-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325211031.24171-1-nbd@nbd.name>
References: <20220325211031.24171-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware receives them properly, they should not be dropped

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e9e7efbf350d..a8df65cc115f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -521,7 +521,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 		status->encoding = RX_ENC_VHT;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-		if (i > 9)
+		if (i > 11)
 			return -EINVAL;
 		break;
 	case MT_PHY_TYPE_HE_MU:
-- 
2.35.1

