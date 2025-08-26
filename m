Return-Path: <linux-wireless+bounces-26626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207FB357C3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CD1B6572B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC622FCC12;
	Tue, 26 Aug 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8JJDlw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8oyBmfJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375129ACDB
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198824; cv=none; b=O/d/yGfEIF1rTdxZe2iPqdQ40xCvSxAecYawFzQSZt2TrxVM26Xd63Jx0UETdwmzdEuJUU1QnJZgG/e4c9c9/JVoepO3TeGGk1IWTUxfZStCw9m3itQ2YFCwmchV62rAQLwTti+3yKA0Jiggn8AgQe7dtDpBgQRTWtClIlhRrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198824; c=relaxed/simple;
	bh=lUDVpX47GJ5krunG6B7HPBqcnHmlaFky/nVoT70LOA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNcDtQbyCAN0SosEtmZ0pQ8qhYD8Q0zgHLXOAN92ySHzDWYzyfRTo4Jdumglqzm6XOccxEBYIFf5o6D53WS9zeGl58XFYyeClJ/q+t4UnadI226fwcHyo+xWpRTdmdJeg8lJ5C4ofyfQ/u531AW9TFhgtuxwaXYQRnIHNHPeM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8JJDlw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8oyBmfJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756198821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gq7eF/8AMTqmWrEqZ4QOBhXBx+dUaUlrxR8GPHeaZDw=;
	b=m8JJDlw2cBZv57VzVp8Rhe34o2QwprLD9Moa0RE/wTzrBEoYYMaD2FjLOb+paTCle23ag/
	Mpmx/4zTo7O4GazqkHWNOrlo0My+IH9oSeK3huaVnulldKFaMi/HxlnY+5/a8mZyDdDbwM
	Svp2lg4wPRdeOGjsCf4+XskQe6CcPhgX6wcPQhdD3fgEk+AFhEqgUGENTJjwj7ruJtWELG
	jd3RAaq7lRcCIj92fSujWRY9RQ4Jt6DThaFPyyoSWRONmcou9rBrMjeYDTBFtHZs1cj1mW
	gnOBpFXKthD27YVyrG5y0kxcNJNJJRyfA+AGMmy13CHiWZ/LFZxxNsRc5UdmNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756198821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gq7eF/8AMTqmWrEqZ4QOBhXBx+dUaUlrxR8GPHeaZDw=;
	b=n8oyBmfJ/rhmnpEyihZ9p9M6myKkTods7znJhO9xZVm43hrUuK9SNWmBW2JlYpdSt0agHv
	I5fFYtncDTxoObBg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtl8xxxu: expose efuse via debugfs
Date: Tue, 26 Aug 2025 11:00:15 +0200
Message-Id: <20250826090015.1552939-1-martin.kaistra@linutronix.de>
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
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 831b5025c6349..b45010c93ad72 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1901,6 +1901,29 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
 		       priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
 }
 
+/* debugfs: efuse */
+static ssize_t read_file_efuse(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct rtl8xxxu_priv *priv = file_inode(file)->i_private;
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       priv->efuse_wifi.raw, EFUSE_MAP_LEN);
+}
+
+static const struct file_operations fops_efuse = {
+	.read = read_file_efuse,
+	.owner = THIS_MODULE,
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
@@ -7974,6 +7997,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	}
 
 	rtl8xxxu_init_led(priv);
+	rtl8xxxu_debugfs_init(priv);
 
 	return 0;
 
-- 
2.39.5


