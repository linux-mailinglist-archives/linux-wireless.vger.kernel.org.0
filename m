Return-Path: <linux-wireless+bounces-16915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0CA9FEA65
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F019188357A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1219CC1F;
	Mon, 30 Dec 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="FA4Gb1gE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0119885F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587734; cv=none; b=IddDv4hncmMad9RvFUEXnkGPUO39UnGvy1urZRjqTuPvcwR+onEsmTG1Jr666WC8uN/qfDNcpNUjrsZfYsFf3JkXv9kDJ4usdiUk71ASi4Kz9sjofv8z9i/vQmmlEMpyCIKucrq/xiGWfHZia7C5kqqroAL+QMFYUmESzr725tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587734; c=relaxed/simple;
	bh=2XAlaVtEeUaLrDqXmLzNOtBkNmuFWjfktGnaW2CNDBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9zSkGPomBf5GEGDgkWOSVLNzpmgg4v9xYxtlATeBUx+eIGthy35GMtksI/bhu6ZB/jmWkh4mSBkcrzapWalekD7cEu2MiEtXMCnu6Vw7cotdDVjn/dbM247Si+kp4OvDQZum8QtS3GqptTIMZLej3hknJGgmKn2cqCG4SY+0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=FA4Gb1gE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cG1gs3YcTGF5QunWsC3tOlr1NjTswGIrIrK+2iSDAhs=; b=FA4Gb1gExGtz/zCtSyjN9Vgofl
	y0SRNKjWz1NkRFw0L/n04W3YEiZGPEC7VstzDdicUOjeUA55yKHfTnDcawQwyxc6xI7yuN96AwNXo
	9NZPxrNX6a5MCZdmI/UZDpbqdruWctCJvP1PnIzYBjFT8qSdHPXK4zjKqi7huAuoJpmw=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeU-00GKzc-05
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 05/14] wifi: mt76: mt7996: fix rx filter setting for bfee functionality
Date: Mon, 30 Dec 2024 20:41:53 +0100
Message-ID: <20241230194202.95065-5-nbd@nbd.name>
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

Fix rx filter setting to prevent dropping NDPA frames. Without this
change, bfee functionality may behave abnormally.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index eb2388f079d9..d76a9dcfd148 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -488,8 +488,7 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 
 	MT76_FILTER(CONTROL, MT_WF_RFCR_DROP_CTS |
 			     MT_WF_RFCR_DROP_RTS |
-			     MT_WF_RFCR_DROP_CTL_RSV |
-			     MT_WF_RFCR_DROP_NDPA);
+			     MT_WF_RFCR_DROP_CTL_RSV);
 
 	*total_flags = flags;
 	mt76_wr(dev, MT_WF_RFCR(phy->mt76->band_idx), phy->rxfilter);
-- 
2.47.1


