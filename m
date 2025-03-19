Return-Path: <linux-wireless+bounces-20542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62AA6884D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7BB18928B0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF525CC7C;
	Wed, 19 Mar 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGPr3Qrz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA425CC79;
	Wed, 19 Mar 2025 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376763; cv=none; b=Qhog3H4Y46bM109sRIjBP9Srf3DdwyQpW6EOaXL/AD1z8isc8nTazZvJ9xrcUDWcKVcX5Zt+nZLKWfaHMotnW/cYNmfwSW9LRDNuJXg82RCVqSef5Wt/bQkoJ29baK41YN6kcX2Y/gHEik9/PZXkyLrKv2AgQruSMp56Ks1nIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376763; c=relaxed/simple;
	bh=3+LjMAEuzeNpxJR5cfAVgsh9YroO0Rsedf62LqvRaUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONNO6BMoe792LduNy0MUQ1ey9j5F2iAlYE1scJsWLwm1OQ8UV0qHW57higuAO+8uuxshlR5VOq8kMGMnrpgjPxYDmWODGe0fKFHJb6YMT4qtWjD+buXAFAGmr8poE/LFmL9tQjZ7J4jwzFgo45dKjdmPi/Hj5dJamJ54Z5rhJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGPr3Qrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EE7C4CEE9;
	Wed, 19 Mar 2025 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376762;
	bh=3+LjMAEuzeNpxJR5cfAVgsh9YroO0Rsedf62LqvRaUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGPr3QrzDCb9Fe5F15fDm5RZeShUvuU4ui4BHnHwAojHYMsGhwD2nPaX/Y71s489V
	 BWoTsr17j7JlbeEduoU5BNyVFL48Crqyx+FRQM2hqNVEIZN8aXmareKjZut5DtpzEn
	 pypCM37GsXrYJPNjMmhL5PVKIMEue+9yY3keQc9OVVT09XsdPPDG1oeYXLEJ/cMZIP
	 Z4hIEG+CMMWIRKpPeruIcpyTOjsUiuJZZ33+mLhB8s0+XM2TzWH4d643e+wTtS6VOc
	 boMtlRXsX9tgOiiPF9w+BXvGvgVOp2iOzIcli0HRlntz8lAMjEgJO74XV/WuOgnhDC
	 BkI/YzFEQCYXA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Michael Buesch <m@bues.ch>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 37/57] irqdomain: ssb: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:30 +0100
Message-ID: <20250319092951.37667-38-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org
---
 drivers/ssb/driver_gpio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 897cb8db5084..f9426a586653 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -148,8 +148,8 @@ static int ssb_gpio_irq_chipco_domain_init(struct ssb_bus *bus)
 	if (bus->bustype != SSB_BUSTYPE_SSB)
 		return 0;
 
-	bus->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
-						&irq_domain_simple_ops, chipco);
+	bus->irq_domain = irq_domain_create_linear(NULL, chip->ngpio, &irq_domain_simple_ops,
+						   chipco);
 	if (!bus->irq_domain) {
 		err = -ENODEV;
 		goto err_irq_domain;
@@ -347,8 +347,8 @@ static int ssb_gpio_irq_extif_domain_init(struct ssb_bus *bus)
 	if (bus->bustype != SSB_BUSTYPE_SSB)
 		return 0;
 
-	bus->irq_domain = irq_domain_add_linear(NULL, chip->ngpio,
-						&irq_domain_simple_ops, extif);
+	bus->irq_domain = irq_domain_create_linear(NULL, chip->ngpio, &irq_domain_simple_ops,
+						   extif);
 	if (!bus->irq_domain) {
 		err = -ENODEV;
 		goto err_irq_domain;
-- 
2.49.0


