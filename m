Return-Path: <linux-wireless+bounces-27308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D500FB57220
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC53B90C2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686FE2EB5DE;
	Mon, 15 Sep 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZEsfnf1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4F2E9ECD
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923163; cv=none; b=hgwTyLDlu6Ac1jxJC0m26RiE5DF3PadN2F42H+kVGoC46+mZoO7wQDv5eQJH3YC0PXkCE9ZjHXBUNMBYKWTiTVwT5Pzo8fKGNT5S5EegLs71cHJxB0Y13aaPCfbHoWUIQyfsRGA3zfF07N4qbmJ00z6eRwhgFbfweeJDlSKAgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923163; c=relaxed/simple;
	bh=xvwJi0p/h5sWvRtE9qmR4SnPAgucuqg3umiLU22Y2xg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGqXNcSWXj9BasxUfmMy9NOU2Jjvc0cqXqwzJ+WwHDl+ncy52p8n5a9ck9qqUgdLV6W0VgwBRQqsIogtyHSHqAqDGoigTllWpwLWSkwURUOStjgbz11G44ScyrHrrqT3aawdvhkLwR+ghLnYsca/gr0nA2snNeXgdQei4Z9AbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZEsfnf1w; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Iyl7WSJzE9ka8q/ZQ42qP8VNpm19JSobw9HsTGitX9s=; b=ZEsfnf1wD7viFaVGddkqvoasjW
	rb2cKuJ9VX6PzIcPQpILZ7IZMostzgUxNxN5xyhj5pkAhHMDvGgKqtD8iU3xDz/H/8gfD0c2a5cVQ
	2M+PkGrZG+Kw2BrWJZLfEZxgTpiR5orknOT3JYOIE/XFgZabRUBcc/sFzHGi2u8CcHg8=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47F-0078GN-0e
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 12/15] wifi: mt76: mt7996: set VTA in txwi
Date: Mon, 15 Sep 2025 09:59:07 +0200
Message-ID: <20250915075910.47558-12-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Enable VTA flag in txwi to enable HQD in SPL which is needed by
the PST. Without this patch, PST cannot get the correct delay of
TxD and lead to a large latency.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 289f69cc2bdf..2d5dab535357 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -968,7 +968,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
 
-	val = MT_TXD6_DAS;
+	val = MT_TXD6_DAS | MT_TXD6_VTA;
 	if ((q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0) ||
 	    skb->protocol == cpu_to_be16(ETH_P_PAE))
 		val |= MT_TXD6_DIS_MAT;
-- 
2.51.0


