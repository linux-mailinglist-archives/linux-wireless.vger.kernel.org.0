Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0649238D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiARKMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 05:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiARKMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 05:12:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475BC061574
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 02:12:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D81F861284
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AF7C00446;
        Tue, 18 Jan 2022 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642500737;
        bh=FmVt/GQlolW0T5Y/rB8sX9IrFb3BuAz2mAietu34Ioc=;
        h=From:To:Cc:Subject:Date:From;
        b=F26L6txj+aKu1gEPRewjj3wnZYz1u7Vt7zdOiIE6iBYfHD+CyYJtghfiureFtn7t7
         yXNYhfLrhbkSRb+apiOWuK/7T22Y/YHJZIpODX6WxsagOKdt5S/pZvDo8PUJDTTKs1
         F3H3Hs7GD4uD/3Hf7qoFtPJVczd+R1wwkR3KwIU+x0QtZ0KSati9HokTiAbm8ARpvM
         QjuZEPQRZTGYc5zkv463s+f6qD9YCuYmAgnoNKOLZiZRTdEZNtPnEnB6CVsR/caXSp
         1GyiiJjP5IocG1uE/MB3XP5glBWlfMpzPc3MYq35UMgiLbYJkSS0G5Uzq3Euh9iPAC
         dPNnePBtIuLwA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: add missing DATA4_TB_SPTL_REUSE1 to mt7915_mac_decode_he_radiotap
Date:   Tue, 18 Jan 2022 11:12:07 +0100
Message-Id: <0484678a0d579a43d65842469dfa54d05f89467c.1642500686.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing DATA4_TB_SPTL_REUSE1 he radiotap flag to
mt7915_mac_decode_he_radiotap routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cf06fe14d387..c784d2d84275 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -376,7 +376,8 @@ mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
 			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
 			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
 
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
 			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
 			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
 
-- 
2.34.1

