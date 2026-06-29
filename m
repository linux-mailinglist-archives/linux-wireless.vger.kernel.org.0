Return-Path: <linux-wireless+bounces-38240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id awwVMhPkQWo1vgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:18:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D04CE6D5A24
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 05:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NXSwzhYQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38240-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38240-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D17413001CF2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 03:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75C37AA65;
	Mon, 29 Jun 2026 03:18:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8C1A9F85
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 03:18:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703111; cv=none; b=tfov+OS7J4XVoE3WgRj6RS2IAC5S4JrCLDVm/tw63FNCV3+lYhK+70JNINuBZ7VmQxx4Jx0dcM0BD2Mx4bs9rMxM+PrrXj474+EJxSsSpnPVyNw+a6kmXq3EZKcabNG9e3WDH20/woHUB8cPkyUmjEN/RuF0IdQOd6T83kUnrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703111; c=relaxed/simple;
	bh=1AgY4jVLFdm/H04VMtZhA95dLlGc9UFYnSNmMibSfZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJkRsQTzrwpTFvGCoV1mByaqNHJzJv3j4zjO/Ck69Fg3RSkOyEx3YLZN+CsANeVWqi2hdqTa8YKholoe/a9jqv7EZCmhul0le8ehkXQ8eQvCDHAl9H8vyN+7E2YJdMxxVIx59yTgqTpsF78z1KjWdFK5TiVq2dkgf4MMIt7aWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXSwzhYQ; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1144242b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782703110; x=1783307910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyo3EmhxxwSCqUeCqzPNA+iusIA5H6mT15Ae1YaEZQM=;
        b=NXSwzhYQ1yPyn6tw4Dcp5yPN4A5zg6SxYerPlhPFDnh/PmWdwI/TnHUb2j5bRwnTMV
         On+7OUZ1Qv4gkC6mhjWDxYPtMkmHtlReuc0EONY1ljnwn9Rm/6vr+HPXgLGKv1USpxx1
         qLFHl/xo1qucz7o5cR5TaL3kovL7X19lajpBKFLClC0Q7NeTmCbOHFfTZbu9nbNFothC
         kPNa7FCLOVH/op7P2esCUop2JoVvgJgIS8kGFwii7mmARQSQ36cR6EXQunpb5uwyw76V
         Qix3GjsJcf1ZS2ji7N/wcqy2a+/DLuPj3Og3J8CTH6wBqXJiJc7aqpW7i4cw1l12Btqr
         ow1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782703110; x=1783307910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyo3EmhxxwSCqUeCqzPNA+iusIA5H6mT15Ae1YaEZQM=;
        b=REUqREmL5I2+zwc7XHTSIJLk6Q4MJFVz6Vg8p13322g8Co0Lb2jAXO+pB4U+BzIMcM
         ehVG+NNoEqmTs+ANKJ06Df21B2ZGM6El5dN9+0RuYQEzo6qhH3FipDugETmPoWaZYIwB
         zt80ePfiyiR5sBk+bA479p1ajb3BayVfKYfN+5zMAOjBOL3vqLhciGwAKe7u1pA2hKQL
         2bE0wjBZmx48yGq3dyDN2Q4cGoVEfCamNDATwF+iJ6vUMznIJwrbS9+o1QxROKj69yjD
         NPowzTwJPj0C1oPh9ioYFUzYYZlcD4ccpdIZRfD1GdN+01zD/Zu1lcaNKZj8yEfVjEkg
         ybjg==
X-Gm-Message-State: AOJu0YyF418Ej1AOXMAc3ThJG2LWgsClKyKw6hMDYdA42g9GYVpaDQNd
	gaZUcm/n6g675iuyPqa6tus+jLie55FIH6bdNBcSae7JeLxZvymmi39SesDDuQ==
X-Gm-Gg: AfdE7clskFJH1I/+fHdoIT7NuMqd8ddRhq5R596WyXgzlTkFU5tjko2z/oYyq15ujdU
	8HEtYJra6iZDI0OURlCM46y6KxFO3dyUqmGxkNJNBi28Jn+eWxfOfyqL4lZcRnZAIZ6vCrP96Ml
	qaxwbbnDsmfsy6qU/r9qAqumz5txEyHIm6ZVoMkcd05RxPg8van8191wUUN197Va6JJunKJuSCv
	/F/INj0ZIRWMSLfffVmmdyXaxrk6jYHqcWkNuAxQvwFjFwpAG42f/g2gdeG1o2h6mmNuC3WSF5N
	qeeKnMzoVmYUDS4H2S7DO7xSeke/rxYKvEZO0mIM5KPBhox3rupRZQeh5qTfgBbwG/qF3TpfeRT
	EuFUX0+VbSSAZxXCQzDWrXJds/uQiGpr7qYji9vBDFZqO5WapAALCjUGu8QkID8TleENdbWN0k8
	B1G4ZjCwy5CSc7f8cj7ac5Zi+EWeBzZQHO3Ffnn7UDYq5HUhny/8sEas4xjpIR5WhBc3nsV4K7j
	zwYwWwg4sWLXnc8ij+U
X-Received: by 2002:a05:6a00:8010:b0:847:73a6:6175 with SMTP id d2e1a72fcca58-84773a66464mr2437064b3a.15.1782703109803;
        Sun, 28 Jun 2026 20:18:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fee103sm11009817b3a.16.2026.06.28.20.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 20:18:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] bcma: host_soc: convert to devres and drop remove callback
Date: Sun, 28 Jun 2026 20:18:27 -0700
Message-ID: <20260629031827.2293745-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38240-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:zajec5@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D04CE6D5A24

Replace of_iomap with devm_platform_ioremap_resource to let
the device resource framework handle unmapping. Use
devm_add_action_or_reset to schedule bcma_bus_unregister on
device removal, allowing the explicit remove callback to be
dropped entirely.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/bcma/host_soc.c | 42 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
index 20b1816c570b..411cfbf53f7b 100644
--- a/drivers/bcma/host_soc.c
+++ b/drivers/bcma/host_soc.c
@@ -188,22 +188,20 @@ int __init bcma_host_soc_register(struct bcma_soc *soc)
 
 int __init bcma_host_soc_init(struct bcma_soc *soc)
 {
-	struct bcma_bus *bus = &soc->bus;
-	int err;
+	return bcma_bus_early_register(&soc->bus);
+}
 
-	/* Scan bus and initialize it */
-	err = bcma_bus_early_register(bus);
-	if (err)
-		iounmap(bus->mmio);
+#ifdef CONFIG_OF
+static void bcma_host_soc_unregister(void *data)
+{
+	struct bcma_bus *bus = data;
 
-	return err;
+	bcma_bus_unregister(bus);
 }
 
-#ifdef CONFIG_OF
 static int bcma_host_soc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct bcma_bus *bus;
 	int err;
 
@@ -215,9 +213,9 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 	bus->dev = dev;
 
 	/* Map MMIO */
-	bus->mmio = of_iomap(np, 0);
-	if (!bus->mmio)
-		return -ENOMEM;
+	bus->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bus->mmio))
+		return PTR_ERR(bus->mmio);
 
 	/* Host specific */
 	bus->hosttype = BCMA_HOSTTYPE_SOC;
@@ -229,24 +227,9 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 	/* Register */
 	err = bcma_bus_register(bus);
 	if (err)
-		goto err_unmap_mmio;
-
-	platform_set_drvdata(pdev, bus);
-
-	return err;
-
-err_unmap_mmio:
-	iounmap(bus->mmio);
-	return err;
-}
-
-static void bcma_host_soc_remove(struct platform_device *pdev)
-{
-	struct bcma_bus *bus = platform_get_drvdata(pdev);
+		return err;
 
-	bcma_bus_unregister(bus);
-	iounmap(bus->mmio);
-	platform_set_drvdata(pdev, NULL);
+	return devm_add_action_or_reset(dev, bcma_host_soc_unregister, bus);
 }
 
 static const struct of_device_id bcma_host_soc_of_match[] = {
@@ -261,7 +244,6 @@ static struct platform_driver bcma_host_soc_driver = {
 		.of_match_table = bcma_host_soc_of_match,
 	},
 	.probe		= bcma_host_soc_probe,
-	.remove		= bcma_host_soc_remove,
 };
 
 int __init bcma_host_soc_register_driver(void)
-- 
2.54.0


