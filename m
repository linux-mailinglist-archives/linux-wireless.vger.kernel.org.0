Return-Path: <linux-wireless+bounces-24849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5CAFA3F8
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 11:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41CF17EE95
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08641E9B31;
	Sun,  6 Jul 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="EWyovHmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAB1991CD
	for <linux-wireless@vger.kernel.org>; Sun,  6 Jul 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793660; cv=none; b=BpIuDVrj4ALS3Pv7sgblv3uEo2tlwLF5CZSG++7HMhLNfcbkWSfrfDWMl8jf9bSvRZ7hHhhWNXt5YWFnn3F7LI1kTyBQ2AuNfTyI9Km0EkBigP4a+KzWbUnsuhjOjRLsRdL4hSF4cg4GJiiunjl5RUUpC6O0HWUV2CtgkmjOjxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793660; c=relaxed/simple;
	bh=fzZR3DEzO6bEF7Uk4im/5BBzN0TRLrvk22xTLemMVfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m7bxlrV70E2tE/p7WAplAjZ70YAYTUtCTJ2h0v5nl+yeV1Cckuw3Qy1iIMbWpOQeFzUUlnx+Ju0InUC0QLJK4L4TUyDkMOkiKuof2Yb3c9egMM5SXSqiIzCOtgetxPHK01+HmeSvJQPezJNpzWSGCVpYoDjhhz6a+GBHTFUcXq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=EWyovHmh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fZR49+16+I+xe1tQffYaC7YiJpOtTyAuMaePqTaRISw=; b=EWyovHmhzJKJ87lFEb3Tt5US7E
	UO6LtFZPSzt2W5gVoWxKPMyqzTfC38/8xIGJRsVY1vYei+KMZrPfbnCN5rLRPmD4ZyriUG7W76K+b
	okRYpXHNiz94jqdHlyTTiiyQnaA3k1r+6saLUe53ncDoVR+r+JqrOVFAcEC5oR0BOpRc=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=MacBookPro.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uYLYM-007jkI-1Y
	for linux-wireless@vger.kernel.org;
	Sun, 06 Jul 2025 11:20:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: rt2x00: fix remove callback type mismatch
Date: Sun,  6 Jul 2025 11:20:53 +0200
Message-ID: <20250706092053.97724-1-nbd@nbd.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is used as remove callback for a platform driver.
It was missed during the conversion from int to void

Fixes: 0edb555a65d1 ("platform: Make platform_driver::remove() return void")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c | 4 +---
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
index eface610178d..f7f3a2340c39 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
@@ -108,7 +108,7 @@ int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_probe);
 
-int rt2x00soc_remove(struct platform_device *pdev)
+void rt2x00soc_remove(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -119,8 +119,6 @@ int rt2x00soc_remove(struct platform_device *pdev)
 	rt2x00lib_remove_dev(rt2x00dev);
 	rt2x00soc_free_reg(rt2x00dev);
 	ieee80211_free_hw(hw);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_remove);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
index 021fd06b3627..d6226b8a10e0 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
@@ -17,7 +17,7 @@
  * SoC driver handlers.
  */
 int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops);
-int rt2x00soc_remove(struct platform_device *pdev);
+void rt2x00soc_remove(struct platform_device *pdev);
 #ifdef CONFIG_PM
 int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state);
 int rt2x00soc_resume(struct platform_device *pdev);
-- 
2.49.0


