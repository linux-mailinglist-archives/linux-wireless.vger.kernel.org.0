Return-Path: <linux-wireless+bounces-11900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED895E393
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C93E2819A7
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA71015443F;
	Sun, 25 Aug 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qjubs+18"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF95464E
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591972; cv=none; b=B6GNqLvxuVZqqVI5O3eQ+7TSgLqoPzENtnGdga7zcPaXubeR4IR18IMH85hsTy2NmkBDtOMFgZ1hthLrWcsd5nD+XxOCN9mYWyyF9KgcAnDKcCq+X96DvA/eV6vFF5vAMciF6paQFdZuda7WX3WndSP++AuVLDk5CyCxFHIgXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591972; c=relaxed/simple;
	bh=8p+g2F4j/irnUuWLk9wAFcIimCjZHaUVQUI4HAdIsJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvmeVrSxOP8LStWCcIc0k2XQTETPDp0N+eooHr8TK7yfcxI06oG0OZZ041qr0BS83NrLsGXd4vzCCCCdqBbxiy3NyJjxk5+3w2u4HJeM5HJhkdn6tTsZA2PPMmRvnv63r+OGG8QSZj11Y5RySsEgP6iF5thXf/ewtbRRtwafi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qjubs+18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724591969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rp8G6qDMo1ZV9tsh/r13/jvaPvi4RD1NsdRYxXubRE4=;
	b=Qjubs+18fsivN9q1U8McMOBZBBvP6BHmWDgP/4gI3bnWuerEaJ04Xu4CpcvpGg2OfWCRx7
	/B98CInFgR7yaRdPu9TQyaliB0p2s0hqJ9NuiUfYqtBwQFrn7ysGLzG66ML7quGDT8Uefp
	mxGTriId7U35m96oBjjiXI+fzSCFmZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-qKiT2DDrM7WXsrx48XD1Zg-1; Sun,
 25 Aug 2024 09:19:26 -0400
X-MC-Unique: qKiT2DDrM7WXsrx48XD1Zg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A941955BF2;
	Sun, 25 Aug 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FA7719560A3;
	Sun, 25 Aug 2024 13:19:21 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: rfkill: gpio: Do not load on Lenovo Yoga Tab 3 Pro YT3-X90
Date: Sun, 25 Aug 2024 15:19:16 +0200
Message-ID: <20240825131916.6388-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The Lenovo Yoga Tab 3 Pro YT3-X90 has a non functional "BCM4752" ACPI
device, which uses GPIO resources which are actually necessary / used
for the sound (codec, speaker amplifier) on the Lenovo Yoga Tab 3 Pro.

If the rfkill-gpio driver loads before the sound drivers do the sound
drivers fail to load because the GPIOs are already claimed.

Add a DMI based deny list with the Lenovo Yoga Tab 3 Pro on there and
make rfkill_gpio_probe() exit with -ENODEV for devices on the DMI based
deny list.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 net/rfkill/rfkill-gpio.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 84529886c2e6..c268c2b011f4 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2011, NVIDIA Corporation.
  */
 
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -72,6 +73,20 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
 	return devm_acpi_dev_add_driver_gpios(dev, acpi_rfkill_default_gpios);
 }
 
+/* List of DMI matches for devices on which rfkill-gpio should not load,
+ * to avoid firmware bugs.
+ */
+static const struct dmi_system_id rfkill_gpio_deny_table[] = {
+	{
+		/* Lenovo Yoga Tab 3 Pro YT3-X90, bogus "BCM4752" device in DSDT */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
+		},
+	},
+	{ }
+};
+
 static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
@@ -81,6 +96,9 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	const char *type_name;
 	int ret;
 
+	if (dmi_check_system(rfkill_gpio_deny_table))
+		return -ENODEV;
+
 	rfkill = devm_kzalloc(&pdev->dev, sizeof(*rfkill), GFP_KERNEL);
 	if (!rfkill)
 		return -ENOMEM;
-- 
2.46.0


