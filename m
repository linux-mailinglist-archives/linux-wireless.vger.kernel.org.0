Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34491379254
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbhEJPRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:17:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58505 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238956AbhEJPQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:10 -0400
X-UUID: 006f526ac05e428982fbd65242d0c1a4-20210510
X-UUID: 006f526ac05e428982fbd65242d0c1a4-20210510
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1293285783; Mon, 10 May 2021 23:15:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:58 +0800
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
Subject: [PATCH 3/9] mt76: connac: fw_own rely on all packet memory all being free
Date:   Mon, 10 May 2021 23:14:51 +0800
Message-ID: <1620659697-12048-3-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

If the device is MMIO-based, we must ensure all TxD/TxP on the host
memory all being consumed by the device prior to safely switching to
fw_own state.

Fixes: ec7bd7b4a9c0 ("mt76: connac: check wake refcount in mcu_fw_pmctrl")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 2b1150bf8d3d..a588d2c39870 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -133,8 +133,12 @@ mt76_connac_pm_unref(struct mt76_connac_pm *pm)
 static inline bool
 mt76_connac_skip_fw_pmctrl(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
+	struct mt76_dev *dev = phy->dev;
 	bool ret;
 
+	if (dev->token_count)
+		return true;
+
 	spin_lock_bh(&pm->wake.lock);
 	ret = pm->wake.count || test_and_set_bit(MT76_STATE_PM, &phy->state);
 	spin_unlock_bh(&pm->wake.lock);
-- 
2.25.1

