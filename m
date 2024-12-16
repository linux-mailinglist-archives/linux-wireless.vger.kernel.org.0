Return-Path: <linux-wireless+bounces-16411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5E9F2F57
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE534188608B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE222204C05;
	Mon, 16 Dec 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s6aGcSZr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F12036FB;
	Mon, 16 Dec 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348613; cv=none; b=emAIEJWJ20t/1+8cXvkrqCIpCpBJkcc+Aosv887XJzcolzLxQmrL8Bhb642mftjhva6YDQA9AwxjYZk+ha782eolLX5M6UAAM3MKcr6zK/jBBMu8r/3TtzTPpVQ5aQT7u2X22ifJ0qpXkEjoD9AMpMCO32X3gcE/IQJfTFLNerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348613; c=relaxed/simple;
	bh=LP0tcqhCQKDxykPnUl4J7/vxYNglPUyx52VJJRyK4Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Irh9jsC7FF/cxpoapHBBBMMcgJmKraZwqjsBbHLmXLNE/NAGyjzSlqQynHDUXb9LJ2SrymMG7rEKF+5uuhE6pOFv3ZxS/e1OnEC6KODVRcoZWl5hgFqEvwwoncdqLs0WAHEKwcYxXeIhAbs8QhIrAGjUnUaSf2a877sqq16uA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s6aGcSZr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348609;
	bh=LP0tcqhCQKDxykPnUl4J7/vxYNglPUyx52VJJRyK4Uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6aGcSZrGVqvDrQbcbiGF1LTadRWUQooaVWEpT+ahwjGvuGFl08mWKnUFEJcV7iI8
	 H/HRPKrgf9wdNTO632BGPRVlKfH5MngclkaVyE91WHP5Oo4EPfSadSdthSc00/0fbV
	 6lZLtLDLbjVnEeQnEetHrKOt+jHAamJZpXcWWXRY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:30:11 +0100
Subject: [PATCH net-next 4/5] netxen_nic: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-4-ec460b91f274@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=3257;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LP0tcqhCQKDxykPnUl4J7/vxYNglPUyx52VJJRyK4Uw=;
 b=xrUP4dfP++DJeELPTbe/WudLHPR9ilyLrf3xKiItMg7i9sug99xl0qxBV6r7A6pa8evklD6BY
 zTxM6pprabHBolgCpV9RuWhhlN+Lv9RVEowSNER9XN3ojFBBeKUSjQY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 9cff0a8ffb2c55de195983051e4e7f8568528c0f..3383ee1dad14e2cb40062b27f32a7cffb6f3fac2 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -2832,7 +2832,7 @@ netxen_sysfs_validate_crb(struct netxen_adapter *adapter,
 
 static ssize_t
 netxen_sysfs_read_crb(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
+		const struct bin_attribute *attr,
 		char *buf, loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2860,7 +2860,7 @@ netxen_sysfs_read_crb(struct file *filp, struct kobject *kobj,
 
 static ssize_t
 netxen_sysfs_write_crb(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
+		const struct bin_attribute *attr,
 		char *buf, loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2901,7 +2901,7 @@ netxen_sysfs_validate_mem(struct netxen_adapter *adapter,
 
 static ssize_t
 netxen_sysfs_read_mem(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
+		const struct bin_attribute *attr,
 		char *buf, loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2922,7 +2922,7 @@ netxen_sysfs_read_mem(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t netxen_sysfs_write_mem(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr, char *buf,
+		const struct bin_attribute *attr, char *buf,
 		loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -2946,20 +2946,20 @@ static ssize_t netxen_sysfs_write_mem(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute bin_attr_crb = {
 	.attr = { .name = "crb", .mode = 0644 },
 	.size = 0,
-	.read = netxen_sysfs_read_crb,
-	.write = netxen_sysfs_write_crb,
+	.read_new = netxen_sysfs_read_crb,
+	.write_new = netxen_sysfs_write_crb,
 };
 
 static const struct bin_attribute bin_attr_mem = {
 	.attr = { .name = "mem", .mode = 0644 },
 	.size = 0,
-	.read = netxen_sysfs_read_mem,
-	.write = netxen_sysfs_write_mem,
+	.read_new = netxen_sysfs_read_mem,
+	.write_new = netxen_sysfs_write_mem,
 };
 
 static ssize_t
 netxen_sysfs_read_dimm(struct file *filp, struct kobject *kobj,
-		struct bin_attribute *attr,
+		const struct bin_attribute *attr,
 		char *buf, loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -3082,7 +3082,7 @@ netxen_sysfs_read_dimm(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute bin_attr_dimm = {
 	.attr = { .name = "dimm", .mode = 0644 },
 	.size = sizeof(struct netxen_dimm_cfg),
-	.read = netxen_sysfs_read_dimm,
+	.read_new = netxen_sysfs_read_dimm,
 };
 
 

-- 
2.47.1


