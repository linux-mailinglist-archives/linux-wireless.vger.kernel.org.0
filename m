Return-Path: <linux-wireless+bounces-27297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09441B57215
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86073B286C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA32EA154;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="O6Xex+nT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE612E9EA8
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=K0QNofvThAdds2WJwhCJCP6aPOL+U4+nQrCKc0vuxOFS4gHQMFut+k5Lo0VVdsPH/y7lEXCw6/j3zMIbd2rS9JF1MfezmFc6uy986K/GbiNCOyPuRil8ZYa5pSY4rrYXRD3JgJHf1CLBamZNgo46MKJgw2kmqotmn816zVCLmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=1aZXyJxh2XEV+umnKpFEwtVVIvzM69JtaiCHHubEJ/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaxk8LRPREhE2bnFYnogkE9qjSzkvXW8Bn01Lqm/CP6xYwFFx9zGKEVjMCNIVPbQ2XPykfYKw56vwHuVRvPOc394QnFKVsDRSWUUccVj1x9QMyiUAyM6X2qVcDl6lv/2VEOf8TrlnxunegolLcdX8+7IBKw/CmwjbsyXyNdf8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=O6Xex+nT; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OY9RfwO5IQsxkzPyiDuHkB2UYa1VUtoXpBFleZuGKKI=; b=O6Xex+nTkK0f7yvZtjJdCFVkiW
	wBv8OjByAPpPGNX9mPSPMcf96dWrSR+38xWpMQ3/x0HVtoMRyEW2xgevYpXk7DFChYm7SzCbn6jpS
	uqPNsKtADcpt3UsdzIY2b0CC99HHTBZn/Wnhlps70ChBouDvSK1pfuGtcs0XNBa5VXaE=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-2b
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:11 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 05/15] wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error
Date: Mon, 15 Sep 2025 09:59:00 +0200
Message-ID: <20250915075910.47558-5-nbd@nbd.name>
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

Free the allocated skb on error

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 5c16e4b780ad..5707e6b59aea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2614,8 +2614,10 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	ret = mt7996_mcu_sta_key_tlv(wcid, skb, key, cmd);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
-- 
2.51.0


