Return-Path: <linux-wireless+bounces-37191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDytMg38G2rFIAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 11:14:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142761549F
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C5C300FEF0
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D63345729;
	Sun, 31 May 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGV/adLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBE243951
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218676; cv=none; b=t6fF+ksyO90trCyQ5non+VT1ZPdnLdoHLpaWeJ1x6xREFUBYShdlm0nb67CjjzUvPRm2W1cRE6OXyFML9/L5HIav9W8x5yLwB0nBwko0s3qAasteMaaetkGoqk2q3nifhscUYpO6IyC8JRnvSJQDznPzlGNF8JjPPKMGY/NqJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218676; c=relaxed/simple;
	bh=PbXxun0ih/3Ga6AnfHYh668oib+8oiaI7DMgPKjhkPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VDQXpWOW9dn6uNfbbLyw/OTa/McjQQS940u7n7jm61W/2+v7cAi2eK0llNiBSJlwVDDEoNFjUzJUOHiPeTzYEB99rqBg0lXY9csUXrPbB1KWQivDLdrX0P4eiCzLjMAjdzg21jIfbER5iN9gpE9QszMmHdPJa7NjXQZigU7PYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGV/adLu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9011F00893;
	Sun, 31 May 2026 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780218675;
	bh=6TGpPgHfFm56JUjwdlaeKJfpJw7m6x4u70bcMACQbLI=;
	h=From:Date:Subject:To:Cc;
	b=RGV/adLubwTrr/AqpfjX+pOOAKqhivsYI7PU3+V/5v3JUCJI1TksqC8F4B6byVAFT
	 W5nEQqF7nebdpMI5nMGTeHVwG29wkJUFnK7yqOcZ/4fhGEbC5x49OpsY7RkV1wblHl
	 y7ETvm4+RRW4X3f7/8GP9ndTX+J5uwXQVDV9aLhd/jMndfqwG4Vcar1KAweCPmnJ0d
	 KpHS+1FjVVpgH/gpCAbaXPlRD+IBYhHiZlIpXesBuJDZvShDagnPuvayo3jmvVkZum
	 87ZOQ7MoroWrml2H+gPVP8TgZ+Ae6vIBtHvThSybFCXLGqAJxqQZAJ7muiQ8h4HLJZ
	 ib4e1Z798ieMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 31 May 2026 11:10:59 +0200
Subject: [PATCH] wifi: mt76: mt7996: Fix possible token leak in
 mt7996_tx_prepare_skb()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-mt7996_tx_prepare_skb-token-leack-v1-1-2b9c9f59ceb1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NUQrCMBAFr1L224U0amy9ikhI01ddomlJghRK7
 27o58Aws1FGEmS6Nxsl/CTLHCu0p4b828UXWMbKpJU26npu+VtufW9sWe2SsLgEm8PAZQ6I/IH
 zgTsNfVFj542ZqHaqN8l6PB7Pff8DNkwQJnMAAAA=
X-Change-ID: 20260531-mt7996_tx_prepare_skb-token-leack-82e240d8c66f
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37191-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3142761549F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If link_conf or link_sta lookup fails in mt7996_tx_prepare_skb routine,
mt7996 driver leaks an already allocated tx token. Fix the issue
releasing the token in case of error.

Fixes: 7ef0c7ad735b0 ("wifi: mt76: mt7996: Implement MLD address translation for EAPOL")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/tx.c         | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c98446057282..8c56344d211b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1067,11 +1067,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 		link_conf = rcu_dereference(vif->link_conf[wcid->link_id]);
 		if (!link_conf)
-			return -EINVAL;
+			goto error_relase_token;
 
 		link_sta = rcu_dereference(sta->link[wcid->link_id]);
 		if (!link_sta)
-			return -EINVAL;
+			goto error_relase_token;
 
 		dma_sync_single_for_cpu(mdev->dma_dev, tx_info->buf[1].addr,
 					tx_info->buf[1].len, DMA_TO_DEVICE);
@@ -1176,6 +1176,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
 	return 0;
+
+error_relase_token:
+	mt76_token_release(mdev, id, NULL);
+	return -EINVAL;
 }
 
 u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 22f9690634c9..f96d9c471853 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -933,7 +933,7 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
 #endif
 	}
 
-	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
+	if (wake && dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
 	    dev->phy.q_tx[0]->blocked)
 		*wake = true;
 

---
base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
change-id: 20260531-mt7996_tx_prepare_skb-token-leack-82e240d8c66f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


