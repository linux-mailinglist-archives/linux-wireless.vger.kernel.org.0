Return-Path: <linux-wireless+bounces-26686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0CB37EC4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CDD1BA161A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D43451A3;
	Wed, 27 Aug 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Vz+D83Wp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5741276028
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286754; cv=none; b=ST+IROqSpnFtaiR/c0rOqy2W+xYmEMDk1RNQ3y12DdRUtYNIH4q7Q7he+ENDK11nWmxxhZExk9CZYv+G2so5cYg6XVJiLcquh2/aozGMEH+K+yN2ONnr4nwCkaeUUwFxKGoCouvN3Uqfb1JNAv7XWfwH1+G0D5jWsFI7OEic/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286754; c=relaxed/simple;
	bh=j+LVRtOys1mJB5ptUqAdG32lJvLopUhd+x0y+CFj7Vw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3pZ17N/0jVZ6yfXbUHYsWS2Z8nMVaL0VmOVksyPjhht8ypKCJ1udPTV3g5kYdgmqh2Qa8hgFhfYo2JvfkgOkGEOi/QeM5QwTK1N72nKt/9hGpN5auc93ZzJiWEBqv9jHsLO6DnW/CSxUtr/A0Xosz6n/kNeqtJezl0U5vgXMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Vz+D83Wp; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fvDY0kjDUbCFNlZ0SBI94+ocXPj1yPZZXx2XLjCKFM0=; b=Vz+D83WpxPovXsRenMnM3TcBMf
	XxhNO1m+vJ51JBkSwPcDFCGkibConHjRl4hmpg7Dnp7Hv2PQjOS2FGzPSCiHtHLKU0Q+YJ8o6RUUZ
	45aKB9XMJ8dlamnge8AHm/Fq+F9T7We6hH1va4JtLs/12yWqTIcZ6rAHadKO0knQxcBc=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBul-00Fn6z-17
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] wifi: mt76: do not add non-sta wcid entries to the poll list
Date: Wed, 27 Aug 2025 10:53:48 +0200
Message-ID: <20250827085352.51636-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827085352.51636-1-nbd@nbd.name>
References: <20250827085352.51636-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Polling and airtime reporting is valid for station entries only

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3afe4c4cd7bb..6b2641a9ae9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1690,7 +1690,7 @@ EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
 
 void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state) || !wcid->sta)
 		return;
 
 	spin_lock_bh(&dev->sta_poll_lock);
-- 
2.51.0


