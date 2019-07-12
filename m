Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F2666E5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGLGUr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 02:20:47 -0400
Received: from nbd.name ([46.4.11.11]:33146 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfGLGUr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 02:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Sbz8z6SEObGtGR3GqBk5quoR9BE3oDwNEqamX6j0zMs=; b=uhfEkCB3fVC6CouR2tVLqh//pt
        NLGKlv2JAdOxRiatxFSxf5XRC8psbqjQqIkB0AdANb1nupy6ZWuNzH52ORIOY7vTYw9bVn9JzAlz8
        7sxjGPovCozwtGQsoUXgEDUDrinN5MJUT5Q+FDS5GIY4lcWy07jXAQOJVcqsXgtTcoe4=;
Received: from p54ae9abd.dip0.t-ipconnect.de ([84.174.154.189] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hlovG-0003rc-BC
        for linux-wireless@vger.kernel.org; Fri, 12 Jul 2019 08:20:46 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id A1AEF61C52AC; Fri, 12 Jul 2019 08:20:45 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt76: mt7615: fix PS buffering of action frames
Date:   Fri, 12 Jul 2019 08:20:43 +0200
Message-Id: <20190712062045.85109-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190712062045.85109-1-nbd@nbd.name>
References: <20190712062045.85109-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bufferable management frames need to be put in the data queue, otherwise
they will not be buffered when the receiver is asleep.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6c21b2df69c4..fc98dabed594 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -334,7 +334,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
-	if (ieee80211_is_data(fc)) {
+	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
 		q_idx = skb_get_queue_mapping(skb);
 		p_fmt = MT_TX_TYPE_CT;
 	} else if (ieee80211_is_beacon(fc)) {
-- 
2.17.0

