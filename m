Return-Path: <linux-wireless+bounces-25834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08AB0D4D5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3200A16A750
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847232D46A3;
	Tue, 22 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js01oqJO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604342D8767
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753173795; cv=none; b=I+dtohNT0s1bQSowMWr5+artsm6U4ARC4QQlfINSJmC7tHD1d7KEneHCDAuST28QQugWDLp1M6erTPFIhTwUBxl//lZhUwQ5CLZG5WUtfaUyD00tLZrBMJHN2lp/drWUPw6o4D7/F5075ss7DXMzYfpX5/TMhpuJ4orwdb7Nsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753173795; c=relaxed/simple;
	bh=ehhPScnBu/pFnDquLo0e3popXPH+ZYkTYjeUsGCcKDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2/fDLxeSkwZO76gIOuKzrx3NCARQGbiIbIFhc4WvBjve85yeBBVmCJiBhBhp0YOUJsWoUu8ddy2cvaX/QIJ6jpkQFNmA8DY/GxqowlKVYOSus217NdlR2hI6ZWJTHXj83xjY0iuSeHTvaBUfqHvrUwzRFJjtLnq6Cp7iEuTLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js01oqJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93666C4CEEB;
	Tue, 22 Jul 2025 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753173795;
	bh=ehhPScnBu/pFnDquLo0e3popXPH+ZYkTYjeUsGCcKDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Js01oqJOuEkrc8K2Jsp0hBZg9omlkwwLDwnacIoVicH9bvqwSTytE721yOYxEMGCx
	 GHWQri5nPsTXIsZVHrccpmlvba3rwKSoagZ4SepfzY5JCV5Qa///+HvKP8lcIRo7Ef
	 P7h/LHKOYuvEfH9cOvkOFdzM5a2Ju0ewSxlAz/jXzMa2bK3LnHYZ1LjKtCf3Nafry1
	 iPy3wfQ1iSjFfQM63P95dGSwWCpmJZwc22HzdtTc2alCKytq/VwjBApaYjzNFIunyM
	 Pjm1f0duSbJCr44w0EYyWcnaPDufZBTE6dZMUqu7qkvhYf//LrxKBP3A+wIKYVc2gN
	 kfDMSLHWRGNhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	krzk@kernel.org,
	lorenzo@kernel.org,
	horms@kernel.org
Subject: [RFC mt76 v2 2/4] wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
Date: Tue, 22 Jul 2025 10:42:25 +0200
Message-ID: <db97d4466f03f8feb932c5113b5d7c257350956b.1753173330.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753173330.git.lorenzo@kernel.org>
References: <cover.1753173330.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preliminary patch to enable traffic forward offloading via the
Airoha NPU module available on the Airoha EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index a66cda167374..48e5c4e98937 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -669,6 +669,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->ndesc = n_desc;
 	q->buf_size = bufsize;
 	q->hw_idx = idx;
+	q->dev = dev;
 
 	size = mt76_queue_is_wed_rro_ind(q) ? sizeof(struct mt76_wed_rro_desc)
 					    : sizeof(struct mt76_desc);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2912568612bc..db37de583709 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -234,6 +234,7 @@ struct mt76_queue {
 	u16 flags;
 
 	struct mtk_wed_device *wed;
+	struct mt76_dev *dev;
 	u32 wed_regs;
 
 	dma_addr_t desc_dma;
-- 
2.50.1


