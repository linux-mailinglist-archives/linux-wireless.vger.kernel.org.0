Return-Path: <linux-wireless+bounces-16918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38B9FEA68
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6763188311F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C519CD17;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PkCv4kYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04556199E94
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=kyzy/MkU70Q+FS99QW48xYxg1Nx1Kx9K0WydN+p1UUUwVddsPOWcMjKbQxLtkXKA5raO/wGEbXtENMzro7MY91364wPNFX4vJo+dQu2v59/RJ2DGwGYVltHlRj/WjPT8URCr+8lbf4rw3KIMcI/cUuJKyJithcpi7r20X7t1HfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=jQ1iBkKkN16aclRCyCeHhUWRrvCHfV6rCRG++OY+Wr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTtWFKHurtDEgxrj2TzeNrlmMhrQPslzQw2oA2qAnpFl+fnQn8/gGPF8SXZ6W98gcrXaD0MhNIuXOkQBFNORf7Pczn+QXjfP/finxyucl3O/9r+4fu7Oe0PQbnyDtD681dTZe5sBtS6lzJD9a0aMnPeNiGkU3bTAcgDCKbIdUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PkCv4kYL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=F29E93r78MUmG8XEyzaG65tuz9UUco8gUsGXqCDqQAA=; b=PkCv4kYLOAMHxVpJAaWkEDIRAN
	KjxvYt8LR5GNSMgTPcdAeVAJWOy5aCag1ZMwq8lHIAr+5OiirKBqHZpIpx6NKVH/iBQ0oo130go+p
	sAQnRG+FHmexndNsTQswMPc8WauPl/SdcrjfWgK0iOVCj3XI+ThHVWW8X2maQQ74ku/g=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeV-00GKzc-1K
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 12/14] wifi: mt76: mt7915: fix omac index assignment after hardware reset
Date: Mon, 30 Dec 2024 20:42:00 +0100
Message-ID: <20241230194202.95065-12-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset per-phy mac address slot mask in order to avoid leaking entries.

Fixes: 8a55712d124f ("wifi: mt76: mt7915: enable full system reset support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9b9158fdd4d9..e2693aea2e8e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1444,9 +1444,11 @@ static void
 mt7915_mac_full_reset(struct mt7915_dev *dev)
 {
 	struct mt76_phy *ext_phy;
+	struct mt7915_phy *phy2;
 	int i;
 
 	ext_phy = dev->mt76.phys[MT_BAND1];
+	phy2 = ext_phy ? ext_phy->priv : NULL;
 
 	dev->recovery.hw_full_reset = true;
 
@@ -1476,6 +1478,9 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 
 	memset(dev->mt76.wcid_mask, 0, sizeof(dev->mt76.wcid_mask));
 	dev->mt76.vif_mask = 0;
+	dev->phy.omac_mask = 0;
+	if (phy2)
+		phy2->omac_mask = 0;
 
 	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	dev->mt76.global_wcid.idx = i;
-- 
2.47.1


