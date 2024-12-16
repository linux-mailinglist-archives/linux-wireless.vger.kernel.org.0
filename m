Return-Path: <linux-wireless+bounces-16414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603C29F2F69
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610AE18823EA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56C2066F1;
	Mon, 16 Dec 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I/JxaftG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1B204592;
	Mon, 16 Dec 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348614; cv=none; b=fwBjfJDQ4JdgNajvOmrZpL+Rr5To66emJ7hYt+fs42pGzRWTNxSbEr6ClIENBN5eZwKmaupznqYXvgH0fo3fOvOLuCnIcr0yxBtUVs1YG53UWy6jeQqE8dluqcBoIUXPHPFpgBtxNI/8soCwfReUgYvSd+XC84PBVkjX+kC9w8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348614; c=relaxed/simple;
	bh=afmiFWmGtDwSvWCLz/Awnrz8rUrbWbV1R/aSyG8z9fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOdRgCVVPCLwbLi3h68hKkRqayytgtILVdSEpQYO5HJJi+5PO3etQVFoB83ugMLuQ4OZunK2KBePZ0Tcnbg/Z1jLU4bpUhez8PYnCNEYcvW9U6CWffto9msp9UcOtc5Dz8WTe+dK1zRZq1cwjgRrc5g1Sg2Sw1tkNBFaQcYWHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I/JxaftG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348609;
	bh=afmiFWmGtDwSvWCLz/Awnrz8rUrbWbV1R/aSyG8z9fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I/JxaftGswFaQLoUCFKkScDmP2dU8N5jdG1tM+4wpCxbSF4pAashONomOrki33B5G
	 z81jo73OWmnLozhgGg/FgVfHOOfh2xmcN4OEqTW7uYcZvRIdIVep2ua8ovk+d87J/W
	 YTLddRNqVNH4JJpACDSRNltZYESXmYL6p6jNL3ww=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:30:08 +0100
Subject: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=1310;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=afmiFWmGtDwSvWCLz/Awnrz8rUrbWbV1R/aSyG8z9fk=;
 b=ZPFLEa3BA+fgVFucJJfAvGs4rNA9IdX6Lu/1cW1OkDiGlB5Fcz9l6EXJSQZQgAyYSkvzP1IcI
 ag0++1bPcO6Cbl8qEcUuCGP/18U/tR/xtp6zInMwvzfx6N0yIiUI2eU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/bridge/br_sysfs_br.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c7e7feeffef3c993404529ba88559..c1176a5e02c43ce32cb3dc152e9aa08eb535a419 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -1002,7 +1002,7 @@ static const struct attribute_group bridge_group = {
  * Returns the number of bytes read.
  */
 static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr,
+			      const struct bin_attribute *bin_attr,
 			      char *buf, loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -1023,10 +1023,10 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
 	return n;
 }
 
-static struct bin_attribute bridge_forward = {
+static const struct bin_attribute bridge_forward = {
 	.attr = { .name = SYSFS_BRIDGE_FDB,
 		  .mode = 0444, },
-	.read = brforward_read,
+	.read_new = brforward_read,
 };
 
 /*

-- 
2.47.1


