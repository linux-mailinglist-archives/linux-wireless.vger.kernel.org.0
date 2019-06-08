Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6876E39C74
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFHKmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 06:42:20 -0400
Received: from nbd.name ([46.4.11.11]:34754 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfFHKmU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 06:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5Es2a+cVQu57ystmB9RI0W1hNPeijJ4X1kJCX8eRF0A=; b=aMPc9iAE2J+QoSZ26yCeXgkvs0
        HUjxP+iy56YpLbG5H/No9t6pVmETCF3Jzj+Jq1Ic55MTS50jpHer4KUlIxB0mZXIxmo6BGYhafdLC
        nIiWEtTWgMkezhXthGUch4REsVMC1eFwXF6M6FilLaCU4smiZMbf3FDhrg61C6PSoi4M=;
Received: from p4ff13bc7.dip0.t-ipconnect.de ([79.241.59.199] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hZYni-0003Il-PK
        for linux-wireless@vger.kernel.org; Sat, 08 Jun 2019 12:42:18 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id BD7975C70BE2; Sat,  8 Jun 2019 12:42:02 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/4] mt76: mt76x02: fix tx reordering on rate control probing without a-mpdu
Date:   Sat,  8 Jun 2019 12:42:02 +0200
Message-Id: <20190608104202.85213-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607164355.51876-4-nbd@nbd.name>
References: <20190607164355.51876-4-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid aggregating rate control probing packets with other traffic, and to
ensure that the probing rate gets used, probing packets get assigned a different
internal queueing priority.
This causes packets to be transmitted in a different order, which is compensated
by the receiver side reordering.
However, if A-MPDU is disabled, this reordering can become visible to upper
layers on the receiver side. Disable the priority change if A-MPDU is disabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix compile error
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index 95c73049a68b..82acebb7f1a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -154,6 +154,7 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
 	struct mt76x02_txwi *txwi = txwi_ptr;
+	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	int hdrlen, len, pid, qsel = MT_QSEL_EDCA;
 
 	if (qid == MT_TXQ_PSD && wcid && wcid->idx < 128)
@@ -171,7 +172,7 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	txwi->pktid = pid;
 
-	if (mt76_is_skb_pktid(pid))
+	if (mt76_is_skb_pktid(pid) && ampdu)
 		qsel = MT_QSEL_MGMT;
 
 	tx_info->info = FIELD_PREP(MT_TXD_INFO_QSEL, qsel) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 2436f14ca24a..f3696afc1dde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -79,6 +79,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	int pid, len = tx_info->skb->len, ep = q2ep(mdev->q_tx[qid].q->hw_idx);
 	struct mt76x02_txwi *txwi;
+	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	enum mt76_qsel qsel;
 	u32 flags;
 
@@ -96,7 +97,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 
 	txwi->pktid = pid;
 
-	if (mt76_is_skb_pktid(pid) || ep == MT_EP_OUT_HCCA)
+	if ((mt76_is_skb_pktid(pid) && ampdu) || ep == MT_EP_OUT_HCCA)
 		qsel = MT_QSEL_MGMT;
 	else
 		qsel = MT_QSEL_EDCA;
-- 
2.17.0

