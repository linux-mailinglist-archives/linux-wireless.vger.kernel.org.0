Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E733CF9FC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhGTMUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 08:20:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53678 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229956AbhGTMUq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 08:20:46 -0400
X-UUID: 82a65126d30c49f59fbb647433bd812e-20210720
X-UUID: 82a65126d30c49f59fbb647433bd812e-20210720
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1269396128; Tue, 20 Jul 2021 21:01:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 21:01:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 21:01:20 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix bit fields for HT rate idx
Date:   Tue, 20 Jul 2021 21:00:14 +0800
Message-ID: <20210720130014.23572-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210720130014.23572-1-shayne.chen@mediatek.com>
References: <20210720130014.23572-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bit fields of tx rate idx should be 6 bits, otherwise it might be
incorrect in HT mode.
For VHT/HE rates, only 4 bits are actually used by rate idx, the other
2 bits are used for other functions.

Fixes: c31d94af1843 ("mt76: mt7915: fix tx rate related fields in tx descriptor")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 5e6f3ef..15f4341 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -283,7 +283,8 @@ enum tx_mcu_port_q_idx {
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
 #define MT_TX_RATE_SU_EXT_TONE		BIT(5)
 #define MT_TX_RATE_DCM			BIT(4)
-#define MT_TX_RATE_IDX			GENMASK(3, 0)
+/* VHT/HE only use bits 0-3 */
+#define MT_TX_RATE_IDX			GENMASK(5, 0)
 
 #define MT_TXP_MAX_BUF_NUM		6
 
-- 
2.25.1

