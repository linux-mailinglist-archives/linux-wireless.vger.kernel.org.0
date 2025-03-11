Return-Path: <linux-wireless+bounces-20156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A17A5BDFF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DBC7A7A7A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C39231A30;
	Tue, 11 Mar 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KE+8paTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD01EFFBB
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689410; cv=none; b=HDXPF6Nc6n3FMwIZEJ94hdlzNjdOdFI6wa3DI8wK9Np315EepA7b21s4J9nCTfBxMFfmAtRLjT8qNpDaRQvNNX8gmk+eCZJGI814abfn30IZ2OOZ0BcLG3Dr1tZBx63nuM7PRVNDUoSgLbVHP+Q8ykyV+XSlgOIU40FDIU2X9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689410; c=relaxed/simple;
	bh=0osvVldS7YF+QBFuO3OBVSw1Mj78xlJl916NcFP6dcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgpCFkuYWsyqkyMj3f6Sc+rIXiu1pLLoNO/4b2Xa3mVUt845lnxZLnrFi4Kykv7ia9X+Fd6DIVFnjktZcko7LoyVRq8L+aFKt2YcWOcCiupS5CLvnTDKHlZhUSD3ArsWqVC7z7Mj+/IA97/fhNm3pX98eFEtEGGIt8cFi40OsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KE+8paTx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oX7fNBkbdS/vI0jXkyauqy9l/D3sLjdSFPu7ePBaaK8=; b=KE+8paTxyvjL7jTZ6yLQXPcWC0
	UJ33KCr7lG95beYojyaPmhIjT6oKovhiFrwIqzLMsJTG2UFnwgmm7wMDTeWDkHE/jDekHItY5iEW4
	qqSBlPQqcBvTLBz2F31HZJSFLsiCXU/ATgZ32mDomLFHLCZO5B3ptxbSWVfCZ1rNgKPQ=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1trwyc-00Ftvh-2v
	for linux-wireless@vger.kernel.org;
	Tue, 11 Mar 2025 11:36:46 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] wifi: mt76: mt7996: remove unnecessary key->cipher check for BIP frames
Date: Tue, 11 Mar 2025 11:36:40 +0100
Message-ID: <20250311103646.43346-3-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311103646.43346-1-nbd@nbd.name>
References: <20250311103646.43346-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

The cipher type check is redundant, and there is no need to dereference the
key struct here.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 33a8049d3356..162d1552602e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -773,8 +773,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD1_FIXED_RATE;
 
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
-	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb)) {
 		val |= MT_TXD1_BIP;
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
 	}
-- 
2.47.1


