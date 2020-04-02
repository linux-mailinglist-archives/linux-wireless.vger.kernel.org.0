Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B389319C8AA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbgDBSTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:23 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1277208E0;
        Thu,  2 Apr 2020 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851563;
        bh=vzaViAtUmAV7N15ae5o71qDlMqQiH1rYvo2bCHDWI1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1rdQz4ugvkntZPua7+2sY6iIpQzVnueV5NOdnRLxICUkj5Ng2+eIpZAQ80LBWant
         aI2D7u0UkoHskaph0yFADzSj3ZgxJJCV8vUOwehrTjfN4ZeeaMCIQ6iuj4OtZJrFzJ
         QW/tKrdGGPMQbamAIj5O7klheEsOhVgTeIoY0eyw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 6/9] mt76: mt76u: rely on mt7622 queue scheme for mt7663u
Date:   Thu,  2 Apr 2020 20:18:53 +0200
Message-Id: <ea99d9b8bc10f202614c249038a707a8d7b45212.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on the mt7622 endpoint definitions for mt7663u

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a981da6c35a5..fb97ea25b4d4 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1009,8 +1009,19 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 
 static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
 {
-	if (mt76_chip(dev) == 0x7663)
-		return ac ^ 0x3;
+	if (mt76_chip(dev) == 0x7663) {
+		static const u8 wmm_queue_map[] = {
+			[IEEE80211_AC_VO] = 0,
+			[IEEE80211_AC_VI] = 1,
+			[IEEE80211_AC_BE] = 2,
+			[IEEE80211_AC_BK] = 4,
+		};
+
+		if (WARN_ON(ac >= ARRAY_SIZE(wmm_queue_map)))
+			return 2; /* BE */
+
+		return wmm_queue_map[ac];
+	}
 
 	return mt76_ac_to_hwq(ac);
 }
-- 
2.25.1

