Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D531FDE0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBSR3z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:29:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSR3x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:29:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FB7C64E92;
        Fri, 19 Feb 2021 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755752;
        bh=kdPuPJVVjL5SudYMyG5MAw+/bnFudTIECAVlKbbrWf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMmHQSYltIq6hC21XcT+53w3EQ/OkBrLG2b2pDD/EtYJaADg2s6qBGjECUXXbzIeG
         8B1c4zIAUxWI9SVQygDsUJ987cw0/I0+sbGF2BvD5I1KTxc3yVKX5hj7E/NCuFk2xK
         nnas8Y9JjhbqxB40RtTDEJxTXNpRlWX71e3j9uQpjT3UsOpjtS+s5rac7FUNdlYeYs
         2s3bNcGvevd+F5mmJ/+OseYymI0RC/Znf8fQjlJhmDs36F5Rj9f3OmLulbvlSSjOAE
         j4DXTLQCbvMh10Q8CsmFdDrOo+pPVz20V7kxH6LywOITzDorlL98ZtcFAuNvkxyskL
         pmAuVNYbsI4yg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 2/8] mt76: mt7921: fix memory leak in mt7921_coredump_work
Date:   Fri, 19 Feb 2021 18:28:45 +0100
Message-Id: <611f3f56d715a11a12e8144175d3fb8b652588a6.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613755428.git.lorenzo@kernel.org>
References: <cover.1613755428.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix possible memory leak in mt7921_coredump_work.

Fixes: 1c099ab44727c ("mt76: mt7921: add MCU support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 9468c9c3b9cf..8befa8167cde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1503,8 +1503,10 @@ void mt7921_coredump_work(struct work_struct *work)
 			break;
 
 		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
-		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ)
-			break;
+		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+			dev_kfree_skb(skb);
+			continue;
+		}
 
 		memcpy(data, skb->data, skb->len);
 		data += skb->len;
-- 
2.29.2

