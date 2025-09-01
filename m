Return-Path: <linux-wireless+bounces-26891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB141B3E270
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF3716AD02
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE961FC7C5;
	Mon,  1 Sep 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TMwGQZJ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ohFF2k+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E351DFFD
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728981; cv=none; b=KxZfZ03YrCUNOjTNGYyGBGlsa5c51yuZ6tzy/QCCOZza9HsPoF3HrJ0O07IArzWoAfRqDZ40XGmmtfSNLLeQeTqsr8aI9Gd1yKmQwTfZ51rhi5f5cBBFWr0u6Rr6nJmx7aiSEZhKWISyeqPq/33XKp9+T3AK120MI9y9jPRCIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728981; c=relaxed/simple;
	bh=ezKC8iAm8ub8aUe602MSQ8DsLBVevPPeoi30sDunXp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9g1MzBAkk8WKgFgstfL4mLg08uM8+pTk08mJE1K5x9lXAaII3IWmiOcr9pMfk+24JO4yn9JnUMOqna9yDSGkAKUdgpMGUO13FXBk4jgdB5xhojb+TUeFnoPm1kFQuWHVugfkNzTZaBgWwFGHigf7wgBN8LUDystNBtd9Rijc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TMwGQZJ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ohFF2k+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756728977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9WWWriQ+2vCd3zLxE/oYlURlW1JmZpDlXQIVevTBfmc=;
	b=TMwGQZJ/ir9EjAmmcp1yn+cXN/oVQentY9mXh4ezIuMkb4SdI12qS9qLQ1PjpAKQDfllJj
	h7xU562lTaqn0yTwDkXKsToKPLmxIkdOxSrDp4DcFkdxtdcxK81QINm24M5BhMrxhMohSw
	22YWxvCV9jmXx6OyKjmiPjKMsZYQSbXtJfawcU+9zKmmawn2A/blJ4mMt55lLaqVbRkmjt
	48l8Bybz+hPTLvNinZlUPPma2IYGigJzpvycNdqh6sggpSbSOLGLVd1SzNu1T20/W9VufH
	28brTuBxz0tL7nvoMTWBDEp23EztZQ8ltWovqXqTUg/VB7lPcKGiR8MqbfndDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756728977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9WWWriQ+2vCd3zLxE/oYlURlW1JmZpDlXQIVevTBfmc=;
	b=8ohFF2k+k4pbGjt5pDs3PIJAorriiesfwzzJSeyYbmAIwI7o1vEos4sVSWZwV/lrR9Pq5x
	o5tak/+sOJOUp0CA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
Date: Mon,  1 Sep 2025 14:16:13 +0200
Message-Id: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efuse contains the mac address and calibration data. During
manufacturing and testing it can be necessary to read and check this
data.

Add a debugfs interface to make it available to userspace.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
Changes in v2:
- remove unnecessary comment
- use debugfs_short_fops

 drivers/net/wireless/realtek/rtl8xxxu/core.c | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 831b5025c6349..aea706f0251d8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1901,6 +1901,27 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
 		       priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
 }
 
+static ssize_t read_file_efuse(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct rtl8xxxu_priv *priv = file_inode(file)->i_private;
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       priv->efuse_wifi.raw, EFUSE_MAP_LEN);
+}
+
+static const struct debugfs_short_fops fops_efuse = {
+	.read = read_file_efuse,
+};
+
+static void rtl8xxxu_debugfs_init(struct rtl8xxxu_priv *priv)
+{
+	struct dentry *phydir;
+
+	phydir = debugfs_create_dir("rtl8xxxu", priv->hw->wiphy->debugfsdir);
+	debugfs_create_file("efuse", 0400, phydir, priv, &fops_efuse);
+}
+
 void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
 {
 	u8 val8;
@@ -7974,6 +7995,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	}
 
 	rtl8xxxu_init_led(priv);
+	rtl8xxxu_debugfs_init(priv);
 
 	return 0;
 
-- 
2.39.5


