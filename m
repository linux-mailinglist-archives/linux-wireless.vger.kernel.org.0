Return-Path: <linux-wireless+bounces-8414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262958D7E4D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5957280DBB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6BB83CA0;
	Mon,  3 Jun 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EvD5HKBD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B182860
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406155; cv=none; b=QXwqmrZMZjf1eAPIODJpYTh23M/hhL2k3LkFlS/ZbaUopkQ6c74DA7cRgkrAnUm1KvzVEojqpZ0NrlH1qk0K1VJ+Tf17oO+zqkS20g68KNORwXKxQbBWDS2s+MWMWFHWQPOkvLSETMrXt31EX5MX6tC+erAGyPX2UTWyqNi2hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406155; c=relaxed/simple;
	bh=HhBt6/7iPORMx5Kl1Z9ooKI2OQsHyjjVeOMZLg9WLBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK0UeXg67t3PgCEZwlCMNBWY6i5h3QWLBoFaDtx+G9rl+bjbiXcHyFPVJrbrA9R4t2NWrwW2Xeju33HhlhntWYqhY1pJiXzYPiFY3m59LN2wJpSgjL4SwGvrkk3uH0jxhzYLX7BHrwIEHxMR2oQEuejgGhK4jdP4xhMeSN23vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EvD5HKBD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=9OJSdBKqUt1d4Vs+wHfk7HzuxjMx44r5nI8Q9nIvLBM=; b=EvD5HK
	BDgvJx56of1aDyIKNpwjw6wHq9xxahazmkblmjiw/RXovc5RWigo85Cxs68OYQ63
	yK88U4RKeeMnliv5NAjtC3ljHYNh3Dnmk74bpipBrElhtnI3qxLhP+F7TTWG6HnV
	2mjbm1sjwCuHbcXg2lO+Krkb60giVZ4vIF8eh9jbuecAeLTq4rNxwoRvoJcLwkQp
	YT7JTjLugYjBumkonA/TdeVYD572H2cRmAzuczTJ6MpWLfz0WFCqrSbYbr200i4K
	2yzTvDSUD1pU/jhm84uewpv58Ghx4rzmsSsFafTfjwjziymdZ+GWkUwN8RjHHSu0
	uV/MhEpw2/qsB13g==
Received: (qmail 1899365 invoked from network); 3 Jun 2024 11:15:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:48 +0200
X-UD-Smtp-Session: l3s3148p1@A4Rmx/gZHIYgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] wifi: p54: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon,  3 Jun 2024 11:15:37 +0200
Message-ID: <20240603091541.8367-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_interruptible_timeout() causing patterns like:

	timeout = wait_for_completion_interruptible_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wireless/intersil/p54/fwio.c   |  6 +++---
 drivers/net/wireless/intersil/p54/p54pci.c |  8 ++++----
 drivers/net/wireless/intersil/p54/p54spi.c | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index c4fe70e05b9b..772084a9bd8d 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -216,7 +216,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 	struct sk_buff *skb;
 	size_t eeprom_hdr_size;
 	int ret = 0;
-	long timeout;
+	long time_left;
 
 	if (priv->fw_var >= 0x509)
 		eeprom_hdr_size = sizeof(*eeprom_hdr);
@@ -245,9 +245,9 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 
 	p54_tx(priv, skb);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 			&priv->eeprom_comp, HZ);
-	if (timeout <= 0) {
+	if (time_left <= 0) {
 		wiphy_err(priv->hw->wiphy,
 			"device does not respond or signal received!\n");
 		ret = -EBUSY;
diff --git a/drivers/net/wireless/intersil/p54/p54pci.c b/drivers/net/wireless/intersil/p54/p54pci.c
index e97ee547b9f3..6588f5477762 100644
--- a/drivers/net/wireless/intersil/p54/p54pci.c
+++ b/drivers/net/wireless/intersil/p54/p54pci.c
@@ -434,7 +434,7 @@ static int p54p_open(struct ieee80211_hw *dev)
 {
 	struct p54p_priv *priv = dev->priv;
 	int err;
-	long timeout;
+	long time_left;
 
 	init_completion(&priv->boot_comp);
 	err = request_irq(priv->pdev->irq, p54p_interrupt,
@@ -472,12 +472,12 @@ static int p54p_open(struct ieee80211_hw *dev)
 	P54P_WRITE(dev_int, cpu_to_le32(ISL38XX_DEV_INT_RESET));
 	P54P_READ(dev_int);
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 			&priv->boot_comp, HZ);
-	if (timeout <= 0) {
+	if (time_left <= 0) {
 		wiphy_err(dev->wiphy, "Cannot boot firmware!\n");
 		p54p_stop(dev);
-		return timeout ? -ERESTARTSYS : -ETIMEDOUT;
+		return time_left ? -ERESTARTSYS : -ETIMEDOUT;
 	}
 
 	P54P_WRITE(int_enable, cpu_to_le32(ISL38XX_INT_IDENT_UPDATE));
diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index 0073b5e0f9c9..d33a994906a7 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -518,7 +518,7 @@ static void p54spi_work(struct work_struct *work)
 static int p54spi_op_start(struct ieee80211_hw *dev)
 {
 	struct p54s_priv *priv = dev->priv;
-	unsigned long timeout;
+	long time_left;
 	int ret = 0;
 
 	if (mutex_lock_interruptible(&priv->mutex)) {
@@ -538,10 +538,10 @@ static int p54spi_op_start(struct ieee80211_hw *dev)
 
 	mutex_unlock(&priv->mutex);
 
-	timeout = msecs_to_jiffies(2000);
-	timeout = wait_for_completion_interruptible_timeout(&priv->fw_comp,
-							    timeout);
-	if (!timeout) {
+	time_left = msecs_to_jiffies(2000);
+	time_left = wait_for_completion_interruptible_timeout(&priv->fw_comp,
+							      time_left);
+	if (!time_left) {
 		dev_err(&priv->spi->dev, "firmware boot failed");
 		p54spi_power_off(priv);
 		ret = -1;
-- 
2.43.0


