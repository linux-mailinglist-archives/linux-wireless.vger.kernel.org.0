Return-Path: <linux-wireless+bounces-5808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92D6896D65
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A41C252C8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC4142E8A;
	Wed,  3 Apr 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mUQBDNJY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9A143869
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141746; cv=none; b=sUYIsjnoj3CjI9jDCCAQMCZ8mWe4ofATxcVxs4xkXn87+zeLqRpeMUAudrKly1LVM9TiE7hWDoK6xhOLAip90Ct+EV51x1251PFkhmS/YrMjDAvr1+r1Y3vLULHC7ECkGTR8qmk53BMsgnzj1L2bO/snnWy31CsGTXEe1SKu59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141746; c=relaxed/simple;
	bh=HK7rVuUrlUcc57fNZdssiaADI1DKUsyiKF3ySo5YN/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reDZRAHWg89nyl+uRoOBuZrTaQlM0sQYbQr6QmGijociXmg8oNxjKVLnGo3pp28OZcqYNbUkG7BOR8wTfIr8PN0w4D3HtuHJQIQDOOcg8OTxqzjPYpRFuiYZLIcyjbZQs86/I+HJX/gfSd8u1EWFhz5ton3KpZqDvairDTpKmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mUQBDNJY; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/HKPbsMA32Fa3R72OCQB/+EejK18TEGBbFipaaZLxGA=; b=mUQBDNJY27+vr02OaxsGW8nr/K
	OuNHjjNvywT2EDM19+yxEBrmGDPquVXpdVAxWy5QvSO+TflkNl0wc/umTlOY5Cl3DtF+JrAgWj7Ra
	bT6G8joeG4IW9AY/BWk+7cwINKuaiJqDhduOnpjeTn9OPK4kduPPG2aOwL/PBzC4TtvU=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt4-00CgfA-Sd
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:34 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 13/13] wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset
Date: Wed,  3 Apr 2024 12:30:32 +0200
Message-ID: <20240403103032.54823-13-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is needed for the PSE client reset. Fixes watchdog reset issues.

Fixes: c677dda16523 ("wifi: mt76: mt7603: improve watchdog reset reliablity")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index cf21d06257e5..dc8a77f0a1cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1393,6 +1393,7 @@ void mt7603_pse_client_reset(struct mt7603_dev *dev)
 		   MT_CLIENT_RESET_TX_R_E_2_S);
 
 	/* Start PSE client TX abort */
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
 	mt76_set(dev, addr, MT_CLIENT_RESET_TX_R_E_1);
 	mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_1_S,
 		       MT_CLIENT_RESET_TX_R_E_1_S, 500);
-- 
2.43.0


