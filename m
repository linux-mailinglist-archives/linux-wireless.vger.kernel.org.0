Return-Path: <linux-wireless+bounces-16413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189F9F2F5F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C67A2797
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B842066D8;
	Mon, 16 Dec 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XLON3cxu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E720458D;
	Mon, 16 Dec 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348614; cv=none; b=eLCHdBQK50itYHkAM2Q15JXeLBbENdpYtQfedSZO8XYZTpyHgcuct3HeoJwK9+1UytdZrTh8X79FV3XyuxFFwYoFioKwaj/aaUoWZ81VF7Q8TbYs0vuQSSXlRHCfse1WYDC/wF3cwXccjLzER/p0ZPr2oQmPWnjw+b9zuP1+FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348614; c=relaxed/simple;
	bh=4lfzZN5KkAJ2v/7q6O8dM4kEUYnGJIO7Kjt5/WsPqHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfJP+bqD9UlkerIZXuC+4sqBbIDi/eyCCgw0c+bn2Ba0hjUy44NGNTI+uBrBmEx81ANsn1fsI9mrk+U0Us7j4z+2jch8cCBgzjxlXVeSaFbeNxUDTqEpivwA2hqLTOB7wp+jwPLkI9G3hxNsR3/m37g5MUYakCgevp7inbLPHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XLON3cxu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348610;
	bh=4lfzZN5KkAJ2v/7q6O8dM4kEUYnGJIO7Kjt5/WsPqHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XLON3cxu3FaY+o31XZ0xn7TlD7hbB3VnMtQ1PRgW37NHMhRs8CaNa+HXFqERuhNmc
	 2v8FMnog2OQ8T5x5W2tWkwDcbkQXpNe4AEeQh6Al13pQOznKZwTOil/kcf3pHkT9v/
	 e0eogBk4S3H7sZE93vLLnYi+HThfiW+nNX4CtIrk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:30:12 +0100
Subject: [PATCH net-next 5/5] qlcnic: constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-5-ec460b91f274@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=9387;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4lfzZN5KkAJ2v/7q6O8dM4kEUYnGJIO7Kjt5/WsPqHE=;
 b=T8yR+XsxXRIz+8QU8/PV0YFo+3DvCYwiwBv7Kig360NLswQicPGNHnpkOUgBVFm7NBdkcnVEl
 YlpbwyaLUAEC/KGwj5SiS6LakzzAKo94Bc8sSuYsJU+AIYQ7ft6tfRj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c | 70 +++++++++++------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
index 74125188beb82515f57a20ae24dcd526943d05ee..82c357865f19ba8f272426abc09f47b40d6b53da 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
@@ -264,7 +264,7 @@ static int qlcnic_sysfs_validate_crb(struct qlcnic_adapter *adapter,
 }
 
 static ssize_t qlcnic_sysfs_read_crb(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -281,7 +281,7 @@ static ssize_t qlcnic_sysfs_read_crb(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t qlcnic_sysfs_write_crb(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -310,7 +310,7 @@ static int qlcnic_sysfs_validate_mem(struct qlcnic_adapter *adapter,
 }
 
 static ssize_t qlcnic_sysfs_read_mem(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -332,7 +332,7 @@ static ssize_t qlcnic_sysfs_read_mem(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t qlcnic_sysfs_write_mem(struct file *filp, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t offset, size_t size)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -396,7 +396,7 @@ static int validate_pm_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_pm_config(struct file *filp,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -446,7 +446,7 @@ static ssize_t qlcnic_sysfs_write_pm_config(struct file *filp,
 
 static ssize_t qlcnic_sysfs_read_pm_config(struct file *filp,
 					   struct kobject *kobj,
-					   struct bin_attribute *attr,
+					   const struct bin_attribute *attr,
 					   char *buf, loff_t offset,
 					   size_t size)
 {
@@ -539,7 +539,7 @@ static int validate_esw_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_esw_config(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -623,7 +623,7 @@ static ssize_t qlcnic_sysfs_write_esw_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_esw_config(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -675,7 +675,7 @@ static int validate_npar_config(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_sysfs_write_npar_config(struct file *file,
 					      struct kobject *kobj,
-					      struct bin_attribute *attr,
+					      const struct bin_attribute *attr,
 					      char *buf, loff_t offset,
 					      size_t size)
 {
@@ -722,7 +722,7 @@ static ssize_t qlcnic_sysfs_write_npar_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_npar_config(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -769,7 +769,7 @@ static ssize_t qlcnic_sysfs_read_npar_config(struct file *file,
 
 static ssize_t qlcnic_sysfs_get_port_stats(struct file *file,
 					   struct kobject *kobj,
-					   struct bin_attribute *attr,
+					   const struct bin_attribute *attr,
 					   char *buf, loff_t offset,
 					   size_t size)
 {
@@ -804,7 +804,7 @@ static ssize_t qlcnic_sysfs_get_port_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_get_esw_stats(struct file *file,
 					  struct kobject *kobj,
-					  struct bin_attribute *attr,
+					  const struct bin_attribute *attr,
 					  char *buf, loff_t offset,
 					  size_t size)
 {
@@ -839,7 +839,7 @@ static ssize_t qlcnic_sysfs_get_esw_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_clear_esw_stats(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -868,7 +868,7 @@ static ssize_t qlcnic_sysfs_clear_esw_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_clear_port_stats(struct file *file,
 					     struct kobject *kobj,
-					     struct bin_attribute *attr,
+					     const struct bin_attribute *attr,
 					     char *buf, loff_t offset,
 					     size_t size)
 {
@@ -898,7 +898,7 @@ static ssize_t qlcnic_sysfs_clear_port_stats(struct file *file,
 
 static ssize_t qlcnic_sysfs_read_pci_config(struct file *file,
 					    struct kobject *kobj,
-					    struct bin_attribute *attr,
+					    const struct bin_attribute *attr,
 					    char *buf, loff_t offset,
 					    size_t size)
 {
@@ -938,7 +938,7 @@ static ssize_t qlcnic_sysfs_read_pci_config(struct file *file,
 
 static ssize_t qlcnic_83xx_sysfs_flash_read_handler(struct file *filp,
 						    struct kobject *kobj,
-						    struct bin_attribute *attr,
+						    const struct bin_attribute *attr,
 						    char *buf, loff_t offset,
 						    size_t size)
 {
@@ -1115,7 +1115,7 @@ static int qlcnic_83xx_sysfs_flash_write(struct qlcnic_adapter *adapter,
 
 static ssize_t qlcnic_83xx_sysfs_flash_write_handler(struct file *filp,
 						     struct kobject *kobj,
-						     struct bin_attribute *attr,
+						     const struct bin_attribute *attr,
 						     char *buf, loff_t offset,
 						     size_t size)
 {
@@ -1195,64 +1195,64 @@ static const struct device_attribute dev_attr_beacon = {
 static const struct bin_attribute bin_attr_crb = {
 	.attr = { .name = "crb", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_crb,
-	.write = qlcnic_sysfs_write_crb,
+	.read_new = qlcnic_sysfs_read_crb,
+	.write_new = qlcnic_sysfs_write_crb,
 };
 
 static const struct bin_attribute bin_attr_mem = {
 	.attr = { .name = "mem", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_mem,
-	.write = qlcnic_sysfs_write_mem,
+	.read_new = qlcnic_sysfs_read_mem,
+	.write_new = qlcnic_sysfs_write_mem,
 };
 
 static const struct bin_attribute bin_attr_npar_config = {
 	.attr = { .name = "npar_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_npar_config,
-	.write = qlcnic_sysfs_write_npar_config,
+	.read_new = qlcnic_sysfs_read_npar_config,
+	.write_new = qlcnic_sysfs_write_npar_config,
 };
 
 static const struct bin_attribute bin_attr_pci_config = {
 	.attr = { .name = "pci_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_pci_config,
-	.write = NULL,
+	.read_new = qlcnic_sysfs_read_pci_config,
+	.write_new = NULL,
 };
 
 static const struct bin_attribute bin_attr_port_stats = {
 	.attr = { .name = "port_stats", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_get_port_stats,
-	.write = qlcnic_sysfs_clear_port_stats,
+	.read_new = qlcnic_sysfs_get_port_stats,
+	.write_new = qlcnic_sysfs_clear_port_stats,
 };
 
 static const struct bin_attribute bin_attr_esw_stats = {
 	.attr = { .name = "esw_stats", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_get_esw_stats,
-	.write = qlcnic_sysfs_clear_esw_stats,
+	.read_new = qlcnic_sysfs_get_esw_stats,
+	.write_new = qlcnic_sysfs_clear_esw_stats,
 };
 
 static const struct bin_attribute bin_attr_esw_config = {
 	.attr = { .name = "esw_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_esw_config,
-	.write = qlcnic_sysfs_write_esw_config,
+	.read_new = qlcnic_sysfs_read_esw_config,
+	.write_new = qlcnic_sysfs_write_esw_config,
 };
 
 static const struct bin_attribute bin_attr_pm_config = {
 	.attr = { .name = "pm_config", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_sysfs_read_pm_config,
-	.write = qlcnic_sysfs_write_pm_config,
+	.read_new = qlcnic_sysfs_read_pm_config,
+	.write_new = qlcnic_sysfs_write_pm_config,
 };
 
 static const struct bin_attribute bin_attr_flash = {
 	.attr = { .name = "flash", .mode = 0644 },
 	.size = 0,
-	.read = qlcnic_83xx_sysfs_flash_read_handler,
-	.write = qlcnic_83xx_sysfs_flash_write_handler,
+	.read_new = qlcnic_83xx_sysfs_flash_read_handler,
+	.write_new = qlcnic_83xx_sysfs_flash_write_handler,
 };
 
 #ifdef CONFIG_QLCNIC_HWMON

-- 
2.47.1


