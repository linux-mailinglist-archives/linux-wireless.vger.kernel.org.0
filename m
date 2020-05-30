Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F31E9410
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2020 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgE3Vvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 May 2020 17:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbgE3Vvy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 May 2020 17:51:54 -0400
Received: from lore-desk.lan (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243D92076B;
        Sat, 30 May 2020 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590875513;
        bh=wDgSOAC+4TcxDfda+SJLYawjVVJtQhuWAadqxEi/cLA=;
        h=From:To:Cc:Subject:Date:From;
        b=CiWWgNWN+8yu95rD+0mxMCppz5ZE69VyfsCpDcWIzFU2rrumE7pAY0/vLcz+d8aj+
         +8d+2sOBMPjXI7IACdD6rQg+rGTe5vzBHZ5eWEZQZVMFf2+W4eyJ44KU292Xp0h523
         JRkfODCMjyGVKH1WL5bbJmVTu2vmADzawQqLDCYg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: fix lmac queue debugsfs entry
Date:   Sat, 30 May 2020 23:51:27 +0200
Message-Id: <89323ce0d5a7df04371bc598b089ba6b123932dc.1590875387.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

acs and wmm index are swapped in mt7615_queues_acq respect to the hw
design

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index fd3ef483a87c..d06afcf46d67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -234,10 +234,11 @@ mt7615_queues_acq(struct seq_file *s, void *data)
 	int i;
 
 	for (i = 0; i < 16; i++) {
-		int j, acs = i / 4, index = i % 4;
+		int j, wmm_idx = i % MT7615_MAX_WMM_SETS;
+		int acs = i / MT7615_MAX_WMM_SETS;
 		u32 ctrl, val, qlen = 0;
 
-		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, index));
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, wmm_idx));
 		ctrl = BIT(31) | BIT(15) | (acs << 8);
 
 		for (j = 0; j < 32; j++) {
@@ -245,11 +246,11 @@ mt7615_queues_acq(struct seq_file *s, void *data)
 				continue;
 
 			mt76_wr(dev, MT_PLE_FL_Q0_CTRL,
-				ctrl | (j + (index << 5)));
+				ctrl | (j + (wmm_idx << 5)));
 			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
 					       GENMASK(11, 0));
 		}
-		seq_printf(s, "AC%d%d: queued=%d\n", acs, index, qlen);
+		seq_printf(s, "AC%d%d: queued=%d\n", wmm_idx, acs, qlen);
 	}
 
 	return 0;
-- 
2.26.2

