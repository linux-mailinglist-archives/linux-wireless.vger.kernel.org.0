Return-Path: <linux-wireless+bounces-3080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E466848699
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56B61F23044
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24351AAD7;
	Sat,  3 Feb 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fKchBD6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AF5D72F
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706968496; cv=none; b=jspGQSHDRp/bvXcRWwRqMpc2L5NRygmuNvkLyiDfJO4tVgUAtAvUzd1ao2Zqh93CPYdWIBWra0HYmDVnRLjD42zE9SOi72sfx1rA6M3/Pyduc2v8iBcNT867LHnfV1+mh1bwFwslZ5llZVflYxw4e/J2NRF6W4akJA9z8jLWV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706968496; c=relaxed/simple;
	bh=GT2GmlXPYN+2WDYv0iRc7uBL7iWlgUjLwnYle/xpkC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nG+NF4In+lVowqVyytt37yZlnr+80SBQEXoA6SDyLvkSahwzVb7Nv/lNVg50bfVUzrXOY3GdrJNVgUhrAkNTszpY2pNmxwQGlt8WaE05TfVthuzrKEws9CE7yvS8VrzjYIiQGFEFSjjsaxZ4xZSlKj5tekhTRYyITo8ztsn/5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fKchBD6E; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aEPwejJF8n9dT0rNMNmVEFMU356gZk6jqJKgL18WPW4=; b=fKchBD6EmAVZ+En6Lh+y2D4Y4+
	rjb8VOAcbCqxYUa4MsiZjQRv3ebvK6eAyDvT/6KMow9SXXuaXJlbmr8RdPqMvBBPHqI3KPhzygSn4
	kl1c0w9gFNlczWEDx1LOAGCmFPmu0qMYQR7sT4iEw+nFUkHMozEOLmJOEDE/LSg9Fjzo=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rWG0m-00AXsM-Ja; Sat, 03 Feb 2024 14:24:48 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org
Subject: [PATCH wireless] wifi: mt76: mt7996: fix fortify warning
Date: Sat,  3 Feb 2024 14:24:46 +0100
Message-ID: <20240203132446.54790-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy cck and ofdm separately in order to avoid __read_overflow2_field
warning.

Fixes: f75e4779d215 ("wifi: mt76: mt7996: add txpower setting support")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 3c729b563edc..699be57309c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4477,7 +4477,8 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
 
 	skb_put_data(skb, &req, sizeof(req));
 	/* cck and ofdm */
-	skb_put_data(skb, &la.cck, sizeof(la.cck) + sizeof(la.ofdm));
+	skb_put_data(skb, &la.cck, sizeof(la.cck));
+	skb_put_data(skb, &la.ofdm, sizeof(la.ofdm));
 	/* ht20 */
 	skb_put_data(skb, &la.mcs[0], 8);
 	/* ht40 */
-- 
2.43.0


