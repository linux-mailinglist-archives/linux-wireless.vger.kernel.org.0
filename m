Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F513ADD78
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFTHu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 03:50:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39947 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229489AbhFTHuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 03:50:25 -0400
X-UUID: 7bb713169bff4190a977994d229f672f-20210620
X-UUID: 7bb713169bff4190a977994d229f672f-20210620
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 788337663; Sun, 20 Jun 2021 15:48:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 20 Jun 2021 15:48:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 20 Jun 2021 15:48:09 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] mt76: mt7921: enable aspm by default
Date:   Sun, 20 Jun 2021 15:48:06 +0800
Message-ID: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

mt7921 is mainly used in NB, CE and IoT application where battery life is
much concerned so the patch enabled PCIe ASPM by default to shut off the
clocks related PCIe as much as possible when MT7921 is either in suspend
state or in runtime pm to lower power consumption.

We still leave disable aspm as an option with module_param for users to
disable ASPM if necessary.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index c3905bcab360..33782e1ee312 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -17,6 +17,10 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
 	{ },
 };
 
+static bool mt7921_disable_aspm;
+module_param_named(disable_aspm, mt7921_disable_aspm, bool, 0644);
+MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
+
 static void
 mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
@@ -132,7 +136,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	mt76_pci_disable_aspm(pdev);
+	if (mt7921_disable_aspm)
+		mt76_pci_disable_aspm(pdev);
 
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
 				 &drv_ops);
-- 
2.25.1

