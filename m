Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE09245E0E9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhKYTVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbhKYTTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:19:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7498C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PDW6wcSIpdwIlpsPgBT0PAdywXf8Gwn66V4UAdEGbmM=; b=LarVPDdTMXEhNSm/JUrMJ5oqsq
        I3uDVD57zXjy2INGpAo4fK9tiCdlsZRjctbDyNhaoxQTsFUaPSQqKJybPGYaoUOgIjkuySGUsIO3E
        Q0T0l19jTRLla74WRn4x4Y7iSwtErGmQSB1ABrY6dzQPf+u8N1xaMF+fpbocOh3w2Z3Q=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqKEY-00022n-9d
        for linux-wireless@vger.kernel.org; Thu, 25 Nov 2021 20:16:38 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7603: improve reliability of tx powersave filtering
Date:   Thu, 25 Nov 2021 20:14:36 +0100
Message-Id: <20211125191436.76952-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211125191436.76952-1-nbd@nbd.name>
References: <20211125191436.76952-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Leave more time to abort transmissions (which could happen at low CCK rates)
Only warn if the last filter command is stuck

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index a9ac61b9f854..a272d64808c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -202,10 +202,11 @@ void mt7603_filter_tx(struct mt7603_dev *dev, int idx, bool abort)
 			FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, port) |
 			FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, queue));
 
-		WARN_ON_ONCE(!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY,
-					0, 5000));
+		mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 15000);
 	}
 
+	WARN_ON_ONCE(mt76_rr(dev, MT_DMA_FQCR0) & MT_DMA_FQCR0_BUSY);
+
 	mt76_wr(dev, MT_TX_ABORT, 0);
 
 	mt7603_wtbl_set_skip_tx(dev, idx, false);
-- 
2.30.1

