Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B151C2EA9EE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbhAELbw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 06:31:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44425 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbhAELbw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 06:31:52 -0500
X-UUID: 7e705380f50740189101f6ae80db1669-20210105
X-UUID: 7e705380f50740189101f6ae80db1669-20210105
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1914351871; Tue, 05 Jan 2021 19:31:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 1/4] mt76: testmode: add a new state for continuous tx
Date:   Tue, 5 Jan 2021 19:30:42 +0800
Message-ID: <20210105113045.17815-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7E5E07FCAB5EEA3F854DA865564EF26F7A0991E141CB9B2D9F73D132B9646A5F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support to set a special tx state in testmode: continuous tx,
which is used for sending tx without time gap.
Note that continuous tx mode doesn't send real packets, instead, it's
pure phy signal, and the waveform can be observed by instrument.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/testmode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index e4849946f180..6db8109a0945 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -140,12 +140,14 @@ enum mt76_testmode_rx_attr {
  * @MT76_TM_STATE_IDLE: test mode enabled, but idle
  * @MT76_TM_STATE_TX_FRAMES: send a fixed number of test frames
  * @MT76_TM_STATE_RX_FRAMES: receive packets and keep statistics
+ * @MT76_TM_STATE_TX_CONT: waveform tx without time gap
  */
 enum mt76_testmode_state {
 	MT76_TM_STATE_OFF,
 	MT76_TM_STATE_IDLE,
 	MT76_TM_STATE_TX_FRAMES,
 	MT76_TM_STATE_RX_FRAMES,
+	MT76_TM_STATE_TX_CONT,
 
 	/* keep last */
 	NUM_MT76_TM_STATES,
-- 
2.29.2

