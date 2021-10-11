Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DC428ADA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 12:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhJKKk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 06:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235907AbhJKKku (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 06:40:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E721460E54;
        Mon, 11 Oct 2021 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633948730;
        bh=F5bTJ6exGEP1GwkWedtllJFB4jrvWH3L3GZweXBY9eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knYfrv+jhntNaRMjzQkgKPJMu/hwfpGmHa2HI6xdedo3FLjAPmsNqQOoCA5X90bQL
         abNgJqNtr4/DB5onmb5eB63oh4s/Czl9Z/jT2CD6oPpRenDZXe10VMwzKnjG8BRRB1
         PIiyCF4+Q4zhkoL/wzisYWoW7xLtj6Dj/BIBepKtXEQGMr+EzbgPMv9hX1ctqN3Ne6
         DkhcQnIu01GunC+cRe7RpIzfa58YGQcp7jAmBAwwiu275t9TJ9iwlphTcNp2FYXyNK
         T/jD22Tg8uJjJcdLxEEAlomiMaX2Nb20mqgz1MLoepLuoAMvrCYGPM5CcCKJhKY1U7
         SZ9tluaIivIRg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v3 3/3] mt76: mt7915: improve code readability for xmit-queue handler
Date:   Mon, 11 Oct 2021 12:38:29 +0200
Message-Id: <0055619eb663d424a4ef9acfbe0232c8ee5713af.1633948549.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633948549.git.lorenzo@kernel.org>
References: <cover.1633948549.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve xmit-queue debugfs node readability for mt7915

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index ec39a3b81c89..86c681dd7a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -378,14 +378,14 @@ mt7915_xmit_queues_show(struct seq_file *file, void *data)
 	};
 	int i;
 
+	seq_puts(file, "     queue | hw-queued |      head |      tail |\n");
 	for (i = 0; i < ARRAY_SIZE(queue_map); i++) {
 		struct mt76_queue *q = queue_map[i].q;
 
 		if (!q)
 			continue;
 
-		seq_printf(file,
-			   "%s:	queued=%d head=%d tail=%d\n",
+		seq_printf(file, "   %s | %9d | %9d | %9d |\n",
 			   queue_map[i].queue, q->queued, q->head,
 			   q->tail);
 	}
-- 
2.31.1

