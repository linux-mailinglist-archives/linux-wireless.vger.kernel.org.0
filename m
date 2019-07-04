Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20B5FB3C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfGDPx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 11:53:26 -0400
Received: from nbd.name ([46.4.11.11]:38244 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfGDPx0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rjOF04iQtrtjBhHMy+qUMjQnUpCvJqiej7WWXrul57k=; b=P5KkJTNlzXJIGxiq5a88LzMj5b
        CMfHf3FmscXllC6rkLdA6RFJPyNsnGBQ7Afr0cIybTTm3oFKX15cT9n/NuGroWzIZ5V0u61YAc9IW
        dvEGu+iVhMsyw/0J6BO5zFFkOqi2oTp0E+ouqfX+QTsorjFO+6nFenNhEM8OFieCHdTc=;
Received: from p54ae9425.dip0.t-ipconnect.de ([84.174.148.37] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hj432-0004qW-Uk
        for linux-wireless@vger.kernel.org; Thu, 04 Jul 2019 17:53:25 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 6165F6165C13; Thu,  4 Jul 2019 17:53:24 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt7603: enable hardware rate up/down selection
Date:   Thu,  4 Jul 2019 17:53:21 +0200
Message-Id: <20190704155324.56693-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improves performance by switching away from bad rates faster

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 38834c7d0891..568e57e1d69c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -248,8 +248,7 @@ mt7603_mac_init(struct mt7603_dev *dev)
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), MT7603_RATE_RETRY - 1));
 
 	mt76_wr(dev, MT_AGG_ARCR,
-		(MT_AGG_ARCR_INIT_RATE1 |
-		 FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
+		(FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
 		 MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4)));
-- 
2.17.0

