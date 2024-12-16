Return-Path: <linux-wireless+bounces-16412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3B9F2F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF821697DF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBCA204C0B;
	Mon, 16 Dec 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Zl78iIUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E220459A;
	Mon, 16 Dec 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348613; cv=none; b=qjFQWJDvQBdh73QqDlmqOan2INrAOruI6BEmPD5HwkwfQ5GIGDovMy2UqmlGxpcJkzw8NNn65SCKfCPnqMHYYccf31HcUWlocATo8HIp9Hi73oORiQLPg5CTtav07gWP7+NDKtBXOxRxHVELWSpnlw25Nwtj/3HpJ39e0mM46O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348613; c=relaxed/simple;
	bh=Vlj4Bzk6QHgRqF8zYsvEUfDWI8hKCPW8mB6sHzcz4fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG5RMa8LzalXJRZEdogFsAfZSYeZ5L2shZGJ1qujFhH9Kh/SeOgXsxpPt5+QB4TsRzeSWIMCCWL4hrDC9fn4h/4I95bh2Cl4tPZK/8i2RY/N9EEF3WaUbqA5sqUAT6c/xhJMSWU3lTy4PnBnXrqj5SBXM92xyuq+Lecbiaz20vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Zl78iIUy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348609;
	bh=Vlj4Bzk6QHgRqF8zYsvEUfDWI8hKCPW8mB6sHzcz4fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zl78iIUy2kM4i/AZURTEexE+j65gyMzsUe7LqSVXoQeXojVMFUOPFy7xxnjJhzoqE
	 avBOSIFRdUuo/JXKkbJkNuoYCFYhfeUWNJve9fMpz1RkPdX+zQ4tcvmAlb9zbDCZA8
	 +HBAPRA9ADxy3/QmWsXM3BlCFpp+F/e8hDibnyV0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:30:09 +0100
Subject: [PATCH net-next 2/5] net: phy: ks8995: constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-2-ec460b91f274@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
To: Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=1744;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Vlj4Bzk6QHgRqF8zYsvEUfDWI8hKCPW8mB6sHzcz4fE=;
 b=Dmpso/XTYKpV8ZglwkBLBxSLfKQ/6cMDmBLx+OYY1D4CliYs3tn86ImJEi+9LWSRaky0CZZiU
 EyPXtCIzFyIDuwiN+tdsJLDVYbbkCqc+E+66tuVrJbzsEKuZJPa+Bfq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/net/phy/spi_ks8995.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index 7196e927c2cd8bd73ef2492260182d48daac19ef..076a370be849e00c57a3be0bbce83c4665c49593 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -289,7 +289,7 @@ static int ks8995_reset(struct ks8995_switch *ks)
 }
 
 static ssize_t ks8995_registers_read(struct file *filp, struct kobject *kobj,
-	struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
+	const struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
 {
 	struct device *dev;
 	struct ks8995_switch *ks8995;
@@ -301,7 +301,7 @@ static ssize_t ks8995_registers_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t ks8995_registers_write(struct file *filp, struct kobject *kobj,
-	struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
+	const struct bin_attribute *bin_attr, char *buf, loff_t off, size_t count)
 {
 	struct device *dev;
 	struct ks8995_switch *ks8995;
@@ -401,8 +401,8 @@ static const struct bin_attribute ks8995_registers_attr = {
 		.mode   = 0600,
 	},
 	.size   = KS8995_REGS_SIZE,
-	.read   = ks8995_registers_read,
-	.write  = ks8995_registers_write,
+	.read_new   = ks8995_registers_read,
+	.write_new  = ks8995_registers_write,
 };
 
 /* ------------------------------------------------------------------------ */

-- 
2.47.1


