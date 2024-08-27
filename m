Return-Path: <linux-wireless+bounces-12043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D19E96059C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC40284B09
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D019DF5E;
	Tue, 27 Aug 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dJdts+kQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3519CD0F
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751025; cv=none; b=CNwSpkjaWscoOHa9bu85RGBaA4IElcXEk5airzvX9DSYp/p4H+Tb0TooxtB8EKBDQo96kQXNkWGmZec10CTmtj3kNhG0wFxitqcOEKzkvbEhj2usPz2Nnj1gpKO2hDL7oWblfEJGAexWUwiWsQ5CKS1oIDF9Rqg5aKH7WtVG2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751025; c=relaxed/simple;
	bh=XrAhAl+imlePza1xyIiHa+zkYGmlrbcPJi5mkVAUXVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huHB8MUdxGb+LhtCqXoSH7KhWyShLcH0x2kh97xJKYv6G497SuD1SVNMKakRXKMpTekCJ5hbpbxFP4YYSJv1f3J0anBh5/YVE9CSK4I2y7CKWwgm4PQvgUUYKY43KczZMEUb0FkPp5s4ArCcoW5CvEMpbC55i2mkIuUtYc5WrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dJdts+kQ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EOO1Dc4NMRzYFyzzx8bpSBxGgBjYACItgslpXQmBH1w=; b=dJdts+kQPfigM3eo3aE22DrICT
	cC5pZ/7KYZ/vGzSXGAoZt5L4P9BY2j3rnaTykdg9qY3afghGTqbpbWccOXdj2RQAvwAGErO+hFwxz
	F43oMQSrT1/Ci7ShPvv0IjkPvurX2DVeq8Mu1nrUldb1nlwHuNU9wFL+PDfNysS47iRE=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWl-004Ww8-0H
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:15 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 08/24] wifi: mt76: mt7915: allocate vif wcid in the same range as stations
Date: Tue, 27 Aug 2024 11:29:55 +0200
Message-ID: <20240827093011.18621-8-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces the amount of unnecessary WTBL bank switching, while still reserving
WTBL entries for vifs.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 87a7b1589af2..a89674d6b602 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -245,7 +245,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
-	idx = MT7915_WTBL_RESERVED - mvif->mt76.idx;
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
+	if (idx < 0)
+		return -ENOSPC;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
@@ -292,6 +294,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 
 	mt7915_mcu_add_bss_info(phy, vif, false);
 	mt7915_mcu_add_sta(dev, vif, NULL, false);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 
 	mutex_lock(&dev->mt76.mutex);
 	mt76_testmode_reset(phy->mt76, true);
-- 
2.46.0


