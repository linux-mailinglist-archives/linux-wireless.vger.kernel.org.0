Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAE319D9A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 12:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBLLvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 06:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBLLvx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 06:51:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0020764E85;
        Fri, 12 Feb 2021 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613130672;
        bh=uvpfCLHunoPm0eUM2Xv0PxdIzJSLvY49OggW2BdxaPs=;
        h=From:To:Cc:Subject:Date:From;
        b=Uo8BC7w4LYDnn9VvL964WZBLHu8NTIW1Ec8jf2uCjEu03f0bZ/9XUY/e0zmYFYT6R
         TQj1iDDPCpthFRq34q9ci/QbR1RTeBBrwr2BmLyvMIt29wzzuBe3Bylw3TPuXONFFU
         yW6qThkpEy1XsACSD7c+uO91cmtr8qCReo+LL+hXoE5ymEqo8n05jooUX+3svjGWGv
         LDnvggZy2EKlPnI0qBvFvswZc1wNOsL7Lfn7Dw6NIHf6XKx9k8GxL+SyIjLjcU/7oT
         Ml/QLY+atHvlDMz/bEpmr7qpUU+cuXvldUiUU8zrffQlSS/3L+0NyXM30Zpscv6Opg
         Lbi09eBEWLeWA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, dan.carpenter@oracle.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: connac: always check return value from mt76_connac_mcu_alloc_wtbl_req
Date:   Fri, 12 Feb 2021 12:51:05 +0100
Message-Id: <d6a2d4791153949ec5ba01f182a5a973bf67a8dd.1613130548.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if this is not a real bug since mt76_connac_mcu_alloc_wtbl_req routine
can fails just if nskb is NULL , always check return value from
mt76_connac_mcu_alloc_wtbl_req in order to avoid possible future
mistake.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7e0046a20143..4e826acd7843 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1032,6 +1032,9 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_SET, sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, tx,
 				    sta_wtbl, wtbl_hdr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 3d139ecff84e..06111ef6f398 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -833,6 +833,9 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid,
 						  WTBL_RESET_AND_SET,
 						  sta_wtbl, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
 	if (enable) {
 		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, vif, sta, sta_wtbl,
 						 wtbl_hdr);
-- 
2.29.2

