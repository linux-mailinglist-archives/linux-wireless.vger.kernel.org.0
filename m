Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACDD24283A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHLK2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLK2d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FEC061787
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=C/LH2x6Ykbd4uh82Tnz/oEyVZHZM/RLYVWUjwLX5aeQ=; b=f4FOwn1gBZbKqkf5YnFAENWz8C
        Kt9xYOfXEWFU9eAdsUc2RqLHvNWUzZ7P6dBbz6osB0bMViG5XgFiwDaj342AtWsH0xcH49LCSLpM/
        bK39FGs11XrWbyYhLjBsV/rTWB8/c9L9Ez8DXV3j0gnmsLIUHOcClnkEDx+jHnP+zgh8=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzk-0002U3-09
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] mt76: mt7915: increase tx retry count
Date:   Wed, 12 Aug 2020 12:28:25 +0200
Message-Id: <20200812102831.11991-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812102831.11991-1-nbd@nbd.name>
References: <20200812102831.11991-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set it to 15 to match reference driver

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 64089a8a01c9..06371d694618 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -571,7 +571,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
-	u16 tx_count = 4, seqno = 0;
+	u16 tx_count = 15, seqno = 0;
 	u32 val;
 
 	if (vif) {
-- 
2.28.0

