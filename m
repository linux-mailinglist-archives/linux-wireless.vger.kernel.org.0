Return-Path: <linux-wireless+bounces-5215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D606C88AB6E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F343285946
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC6129E8D;
	Mon, 25 Mar 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNQUPOgo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6912A163
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382847; cv=none; b=KXuNy1Vijf77OGzKMdwE4A2HcvjRWC4O8rTntKrKI9rO0uVdoHxy8CO4mRS5MQFhWI1huHLYauw852wg3s7HKCmi7QSkwz7cWU1CUHIRdM+UNosBDrJ9+eu8jRSK3OnFOUZTbyDtd9lCvfAl4Enjp+qtOENFT8V9/3MATBDN1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382847; c=relaxed/simple;
	bh=lhtgjswdAt3dPhPOjQVossLy0Om7Cz4LSE9rk1bfwwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KThtHn7ucfgdnda659Yu+p28RKas7k9UHmt3oyLHr2k0atMYwgYiTL+i9dqIRNEV0d1/pklSdudU2IKwcR9h85frfKKbSczjaH3u4frD0fBoOR+tWt+8Re3WPws6MQVUOQ00XlDxq/mM8nU7TEk414aA+FSGdXUeNmj6kBRMcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNQUPOgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E178CC433F1;
	Mon, 25 Mar 2024 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382847;
	bh=lhtgjswdAt3dPhPOjQVossLy0Om7Cz4LSE9rk1bfwwo=;
	h=From:To:Cc:Subject:Date:From;
	b=vNQUPOgoQvaB8Y2fEAKKpGkcTORMP39jmR/TTIDrpLY/3Hyez4QEVopW53zoacobL
	 2WVx54LH3Zl95WsOav7lQyR8gtSW2P+9k/p8AryOlhbqp98M14R09YQQ8UVX37Mx86
	 OphXVsFz0Q/vdCUBv/Quaic1dlY89+Q5NPuC2+G4+YwEdIxxis74IMsi1jr2fY4YqP
	 Zl5NgxYbgjwnYD15ZfPi9NuEKgJLg7bi729pLXisKtOoYbfqwHog5gC+J94VwRG852
	 jfHF5Ch82oIQ/TazqJzSLd+YRw7qZ3XCLWaSOwuJjG2Xy7GOvnI7LPEaNv/j6CiMRo
	 RAMQP46nti0Vw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com
Subject: [PATCH] mt76: sdio: move mcu queue size check inside critical section
Date: Mon, 25 Mar 2024 17:07:16 +0100
Message-ID: <e7b8e26b999918f3b74f951ea87adc5b14bc925b.1711382721.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it is not a real issue at the moment since concurrent access to
mcu message queue is protected by mcu mutex, make the code more robust
and move mcu queue free space check inside queue spinlock critical section.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 3e88798df017..6198906946f5 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -548,10 +548,7 @@ static int
 mt76s_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 		       struct sk_buff *skb, u32 tx_info)
 {
-	int ret = -ENOSPC, len = skb->len, pad;
-
-	if (q->queued == q->ndesc)
-		goto error;
+	int ret, len = skb->len, pad;
 
 	pad = round_up(skb->len, 4) - skb->len;
 	ret = mt76_skb_adjust_pad(skb, pad);
@@ -560,6 +557,12 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 
 	spin_lock_bh(&q->lock);
 
+	if (q->queued == q->ndesc) {
+		ret = -ENOSPC;
+		spin_unlock_bh(&q->lock);
+		goto error;
+	}
+
 	q->entry[q->head].buf_sz = len;
 	q->entry[q->head].skb = skb;
 
-- 
2.44.0


