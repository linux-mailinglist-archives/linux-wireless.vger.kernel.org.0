Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1B31CB6E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Feb 2021 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBPNwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Feb 2021 08:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPNwW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Feb 2021 08:52:22 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84341C06174A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Feb 2021 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RSI6oKrtNkOYmjgNvOUbqLJBGmnOq4IwXSdNDvURzeg=; b=cy85HkeVbYWaKc/uRMjNuRRI3M
        WY/axb/1xIxYMN4YcjWBi80y297DOHPh4lVK1NWjE76kBdnK+x5lrGqfGq86vtaZNM2strM3yeuVN
        xBDvo5bVDwK9BVFnSvzx78S/nuhV3beTT2jkh+TzTTNtwjOCI6yudHSZeDb1o6XvXZ78=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lC0l9-0004IS-Kn; Tue, 16 Feb 2021 14:51:23 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.12 2/2] mt76: mt7915: only modify tx buffer list after allocating tx token id
Date:   Tue, 16 Feb 2021 14:51:19 +0100
Message-Id: <20210216135119.23809-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216135119.23809-1-nbd@nbd.name>
References: <20210216135119.23809-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modifying the tx buffer list too early can leak DMA mappings

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index eb889f8d6fea..e5a258958ac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -967,11 +967,6 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 	txp->nbuf = nbuf;
 
-	/* pass partial skb header to fw */
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
-	tx_info->buf[1].skip_unmap = true;
-	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
-
 	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD | MT_CT_INFO_FROM_HOST);
 
 	if (!key)
@@ -1009,6 +1004,11 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		txp->rept_wds_wcid = cpu_to_le16(0x3ff);
 	tx_info->skb = DMA_DUMMY_DATA;
 
+	/* pass partial skb header to fw */
+	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].skip_unmap = true;
+	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
+
 	return 0;
 }
 
-- 
2.28.0

