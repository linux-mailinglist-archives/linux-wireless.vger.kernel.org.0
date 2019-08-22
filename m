Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6B98C75
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfHVHdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 03:33:07 -0400
Received: from nbd.name ([46.4.11.11]:48310 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfHVHdH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 03:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4UbZBAtKMdW9eRXallmw+x2PGiUizCpLIyoNyqs2rEA=; b=MweCc1qK3ifgmIPM0kON22XDS9
        hLnx2ExvgUtO1Ci7ANCuaYmriAY598HZb5ziH+FjeyTckDRjyP2bkyfq5AGSfmzV2RERzODpMrrkF
        2RqZMXVeulUNf0KRDJk//BZ8A9CRyTqXNoltjG6tabKV4SGe7WsbVeoHFlLfjmvzfldc=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0hak-0002gv-0U
        for linux-wireless@vger.kernel.org; Thu, 22 Aug 2019 09:33:06 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 7967A63FD13D; Thu, 22 Aug 2019 09:33:05 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: dma: reset q->rx_head on rx reset
Date:   Thu, 22 Aug 2019 09:33:04 +0200
Message-Id: <20190822073305.37840-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes rx of the first frame if a fragmented rx was interrupted by the reset

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 46f5223b4d89..c747eb24581c 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -431,6 +431,12 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	mt76_dma_rx_cleanup(dev, q);
 	mt76_dma_sync_idx(dev, q);
 	mt76_dma_rx_fill(dev, q);
+
+	if (!q->rx_head)
+		return;
+
+	dev_kfree_skb(q->rx_head);
+	q->rx_head = NULL;
 }
 
 static void
-- 
2.17.0

