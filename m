Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF612EA9EC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 12:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAELbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 06:31:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48053 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725769AbhAELbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 06:31:46 -0500
X-UUID: a5ed39f2b3f34cc783d892a047b1ad4f-20210105
X-UUID: a5ed39f2b3f34cc783d892a047b1ad4f-20210105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1135770502; Tue, 05 Jan 2021 19:31:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 19:30:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 19:30:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/4] mt76: mt7915: rework set state part in testmode
Date:   Tue, 5 Jan 2021 19:30:43 +0800
Message-ID: <20210105113045.17815-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105113045.17815-1-shayne.chen@mediatek.com>
References: <20210105113045.17815-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to simplify setting state in mt7915
testmode, for adding the new continuous tx state.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 6f6e02038c6d..e5af42c70e12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -395,9 +395,8 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 }
 
 static void
-mt7915_tm_init(struct mt7915_phy *phy)
+mt7915_tm_init(struct mt7915_phy *phy, bool en)
 {
-	bool en = !(phy->mt76->test.state == MT76_TM_STATE_OFF);
 	struct mt7915_dev *dev = phy->dev;
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
@@ -502,16 +501,15 @@ mt7915_tm_set_state(struct mt76_phy *mphy, enum mt76_testmode_state state)
 
 	mphy->test.state = state;
 
-	if (prev_state == MT76_TM_STATE_TX_FRAMES)
-		mt7915_tm_set_tx_frames(phy, false);
-	else if (state == MT76_TM_STATE_TX_FRAMES)
-		mt7915_tm_set_tx_frames(phy, true);
-	else if (prev_state == MT76_TM_STATE_RX_FRAMES)
-		mt7915_tm_set_rx_frames(phy, false);
-	else if (state == MT76_TM_STATE_RX_FRAMES)
-		mt7915_tm_set_rx_frames(phy, true);
-	else if (prev_state == MT76_TM_STATE_OFF || state == MT76_TM_STATE_OFF)
-		mt7915_tm_init(phy);
+	if (prev_state == MT76_TM_STATE_TX_FRAMES ||
+	    state == MT76_TM_STATE_TX_FRAMES)
+		mt7915_tm_set_tx_frames(phy, state == MT76_TM_STATE_TX_FRAMES);
+	else if (prev_state == MT76_TM_STATE_RX_FRAMES ||
+		 state == MT76_TM_STATE_RX_FRAMES)
+		mt7915_tm_set_rx_frames(phy, state == MT76_TM_STATE_RX_FRAMES);
+	else if (prev_state == MT76_TM_STATE_OFF ||
+		 state == MT76_TM_STATE_OFF)
+		mt7915_tm_init(phy, !(state == MT76_TM_STATE_OFF));
 
 	if ((state == MT76_TM_STATE_IDLE &&
 	     prev_state == MT76_TM_STATE_OFF) ||
-- 
2.29.2

