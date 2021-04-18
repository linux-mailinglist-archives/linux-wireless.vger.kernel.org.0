Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5433636CB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhDRQqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhDRQqq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85F5561359;
        Sun, 18 Apr 2021 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764378;
        bh=+Oxye/bjHWl5xZjfh8qt5MykV/JZ1/vGrp8SWJrbj0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+nVoBSPr9/fy69NTBV0x5QTByBJZz86Oz+GAKpd9H9hIrcMoLzTw//cskH22GpQ3
         U6b+SzM5/Y/gKAzvhasNuYdVGmCRXc8QNqfpJMHpH/g6OuVMHQNfVJpamYFkAznGfv
         QvtnEs12uXOA8bDsomWRamezosMht5SzN4jDrw+1N1QjHnJgl7htHvRLCyXLeozA+i
         t36DDB3cq/ekYkEeyAtUXVzYdR6pRFHXpHzwJtGF4u984V5JFTE9FVZnGfw83ruFM4
         o5/syD3hCsTN6n2sKZK6adW6dTeC2qd284c4AH56jd7zjq2sEZRyzjqN76L9tKxLNa
         /x6XZlQJNjmyA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 17/19] mt76: remove MT76_STATE_PM in tx path
Date:   Sun, 18 Apr 2021 18:45:43 +0200
Message-Id: <cb14c7b8efca07a97d276834aa52f48e235bd8fc.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

since tx/rx path is now relying pm ref counting, get rid of MT76_STATE_PM
check in the tx path

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index cfc7229aa7b0..236eaa351f53 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -422,8 +422,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_queue *q,
 		return idx;
 
 	do {
-		if (test_bit(MT76_STATE_PM, &phy->state) ||
-		    test_bit(MT76_RESET, &phy->state))
+		if (test_bit(MT76_RESET, &phy->state))
 			return -EBUSY;
 
 		if (stop || mt76_txq_stopped(q))
@@ -463,8 +462,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 	while (1) {
 		int n_frames = 0;
 
-		if (test_bit(MT76_STATE_PM, &phy->state) ||
-		    test_bit(MT76_RESET, &phy->state))
+		if (test_bit(MT76_RESET, &phy->state))
 			return -EBUSY;
 
 		if (dev->queue_ops->tx_cleanup &&
-- 
2.30.2

