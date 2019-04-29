Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900EDE89E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfD2RRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 13:17:15 -0400
Received: from nbd.name ([46.4.11.11]:37838 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfD2RRP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0X4uyWwzNc04tcMgVTVgcXTRC/MGRYogdl72B1UBRGw=; b=sx8vcuMOfmSTfIhp1txyQFCkra
        DAfIGA7exfrH4MpFmAyqkwcOChWEUA0EBuffbFf0SawrvTJFPvceVo/odvKz/LBHAL7Sox4ng4y9e
        ZS2HTNnv1OmcwfP/ucNYazFZIDXvVUqQmLH8203g2UNvW6zJzUHe7VZ3mlfI+eY31jlU=;
Received: from p4ff135f1.dip0.t-ipconnect.de ([79.241.53.241] helo=maeck-2.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hL9ty-0001Dy-6t
        for linux-wireless@vger.kernel.org; Mon, 29 Apr 2019 19:17:14 +0200
Received: by maeck-2.local (Postfix, from userid 501)
        id 3998D5A48250; Mon, 29 Apr 2019 19:17:13 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7615: use sizeof instead of sizeof_field
Date:   Mon, 29 Apr 2019 19:17:12 +0200
Message-Id: <20190429171712.52983-4-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190429171712.52983-1-nbd@nbd.name>
References: <20190429171712.52983-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is simpler in this case

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b09540654b09..ea67c6022fe6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -88,8 +88,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	      FIELD_PREP(MT_TXD1_PKT_FMT, pkt_fmt);
 	txd[1] = cpu_to_le32(val);
 
-	mcu_txd->len = cpu_to_le16(skb->len -
-				   sizeof_field(struct mt7615_mcu_txd, txd));
+	mcu_txd->len = cpu_to_le16(skb->len - sizeof(mcu_txd->txd));
 	mcu_txd->pq_id = cpu_to_le16(MCU_PQ_ID(MT_TX_PORT_IDX_MCU, q_idx));
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
-- 
2.17.0

