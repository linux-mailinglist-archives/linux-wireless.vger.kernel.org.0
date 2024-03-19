Return-Path: <linux-wireless+bounces-4923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD988039F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E211F25A67
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8EA23772;
	Tue, 19 Mar 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCeX921G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B42375B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869975; cv=none; b=XEsyJW22eOVgToVJNcjgXecSJhKReYULuoWKEja0z3JD+0hSfmknrXBoV/h6QNGQGXussr9VWK2lPwIlDdmdoiTUV0PLZbonjWxpYkwBv+WgVRSnhjMjPeOCTjNHXWFi3q5gfIK48OhTeUktk7VDt2PQvu3LtpCoaRhhIIHev7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869975; c=relaxed/simple;
	bh=HTsBylmQ/Fyja+f2LE6kyL3EX6N34Mpa+nEkmWGsRig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK40RGDS4UiDd1JCX2zhm+xp8l90Cg7GJiw2y23Ia+adIOKMUdAEIbAFXv8Z9NoNnWyZAh/iSKJe9Km/RzwVJIsUUp20GKi9tuul+5L6UHfij7pp3iGUAu1jqGkXJ3ZdkIzn00kkAvifgFCunVfvHdAt0DssarlfWVu54iYjelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCeX921G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF198C433C7;
	Tue, 19 Mar 2024 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710869975;
	bh=HTsBylmQ/Fyja+f2LE6kyL3EX6N34Mpa+nEkmWGsRig=;
	h=From:To:Cc:Subject:Date:From;
	b=eCeX921G0+cdAhV1txEd3bsBRNSv2/5MZST2/Hqs1ydhW6QT9wqFjJ0uJIVTZplwT
	 RtcXdTpVvppdMG7lscLdNczmwJSaSthKWAgah+UGqv4dhMFAXYEKp3R7uDx+E6RntG
	 te7EEIjxSWk6SsUu125D+1pKYfMVz4n1yIPkOrDeag6fxFENeeaAulKMDIyKGAgZsv
	 NB9N+i4XM6zWzTI6khIEVaOVSlNPGE4IE7NNX4LIKC8opMgibToMjEcmGxcszo25wD
	 ZSt/9uygZi/r6kVJ2fmyZ6TAoW1KsmRC8SZfCu2EqCZsSog6LdhFOBtI72vdIlGXCW
	 2Ypjyg5Y/s0Nw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com
Subject: [RFT] mt76: sdio: move mcu queue size check inside critical section
Date: Tue, 19 Mar 2024 18:39:24 +0100
Message-ID: <e7b8e26b999918f3b74f951ea87adc5b14bc925b.1710869778.git.lorenzo@kernel.org>
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
compile tested only.
@Deren: can you please run some tests?
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


