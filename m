Return-Path: <linux-wireless+bounces-31075-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAQ9JpUDcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31075-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:01:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F19AD65A5C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 12:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E56ABAAA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6E3F075B;
	Thu, 22 Jan 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZiVaVuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27103EDAC9
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078441; cv=none; b=gYvs/SQeWAufiXWWogg3uN+TgyuwbTGeW7nk5eNo2USkLBdFuKZlai4TOg4ezFzDTG+vije365EqL9p1bALWqHUDq5jRjXo6FWX4GvgC7WsBdibKBcZJvthtqxnT38qruK7ZuUlB57SJXwf8ctgz/8MNoslEVdN58ezLsHzjwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078441; c=relaxed/simple;
	bh=Q09V5A7X3pM/0XY3mGlRPsebpRgqHCxs0F4mulk67UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2UUDgoXhV/7k2MHSowOIQMoX6jqaxo/S8R9PzLDTEXOaiZs96WVK9pNmPCHeaIQXUrsiv7aFUdi5lHfgjcpC207k/1UHDFFgWdLdJzUX5KGfWtJBRIPTJwsRQjNQU+GOQvpzArknxNkE0jrc8YSxnDn+jZrvnzqExD7/pizeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZiVaVuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56E5C116C6;
	Thu, 22 Jan 2026 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078441;
	bh=Q09V5A7X3pM/0XY3mGlRPsebpRgqHCxs0F4mulk67UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EZiVaVuIMTO/2UAW8yzMgdAEjoh6u3221P/AUaWQeW+KSU3jvxOOnXilWpTERER52
	 xdzUp845i0e75PLSiq4h5jDX7J5xyQPAASSG261fmtp/fqeRwvM5rQL0bWRdJknK3J
	 TdtNEdyskBh0eeZczWa6iER3Ibe2Abn387XrRFF+N3+50W0IULXR+EbraC8ElYPgsd
	 26OGDYVn2UJeFJkh7g2kxptN0BeCom85ZFOouD6qYMJ8+cww2wxEMceQgDRjtGrN+D
	 XBCOmD0TP2S5B1hyhgXGu1uDTHHYRI0Di0hZLmK//K862n0TkZloY9FYDHW9L0kzSD
	 /lJ1+C5IepBnw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:58 +0100
Subject: [PATCH mt76 v2 14/17] wifi: mt76: Do not reset idx for NPU tx
 queues during reset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-14-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31075-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email]
X-Rspamd-Queue-Id: F19AD65A5C
X-Rspamd-Action: no action

Do not run reset_q callaback with reset_idx set to true for NPU Tx
queues. This is a preliminary patch to properly manage reset procedure
when NPU offloading is enabled.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 4a63de6c5bf5a34cb76f10a427649bc04ebe78b2..2a0226c83f3c92a615d34846b8fcb5fafb42d07c 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -174,7 +174,9 @@ void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 static inline void
 mt76_dma_reset_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	dev->queue_ops->reset_q(dev, q, true);
+	bool reset_idx = q && !mt76_queue_is_npu_tx(q);
+
+	dev->queue_ops->reset_q(dev, q, reset_idx);
 	if (mtk_wed_device_active(&dev->mmio.wed))
 		mt76_wed_dma_setup(dev, q, true);
 }

-- 
2.52.0


