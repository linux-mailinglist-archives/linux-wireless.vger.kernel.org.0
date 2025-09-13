Return-Path: <linux-wireless+bounces-27272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F6B56083
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D003AE875
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E425CC74;
	Sat, 13 Sep 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7/5jS8+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03860B67F;
	Sat, 13 Sep 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757763319; cv=none; b=rZtJ1xITWdjoHs3JTT1izKzhHl17kX6MKFEK32HZusN+iigObCNbQbKDs2MfN0yhCK/ExxP31ZirRewJ9y+lc903yZ92YbTbwcG7kmclM0OHrIciqXEAm0zBtizlwVyPeocq0Fz29R9Y+QaiY/KGYXcKzvEYFTAM4WUo/IuZxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757763319; c=relaxed/simple;
	bh=Q0cNPxSupnkVAkshxZGO8UHs+uFC+c4ZXhf+1svpx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLv3plTlx4wTmmU47Q4sct6jbuUJcTuMZPDhXMNGGlM9Nw4qN1iTIjSoKcA/fp3c1N/2JzDFsoUDWubCGavkpy7ysR/n9kFM3csfNHbANiiPne7Fih3dnuMra4SNU4gZeRQUxEtIR3S7SwzCo531JluzGFFD78HCqFZhKc7/5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7/5jS8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F35BC4CEEB;
	Sat, 13 Sep 2025 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757763318;
	bh=Q0cNPxSupnkVAkshxZGO8UHs+uFC+c4ZXhf+1svpx3A=;
	h=From:To:Cc:Subject:Date:From;
	b=B7/5jS8+4+BjhZq1jX8hg/Yl6ErTVzIllexc+qsqJT18t0VD8z+DSN012LF74XR2X
	 hkU25chC7/fKi2Qpk4TMZlnSL5bkNJJzMPkhI5ZEb/1AOQpQfs+2vZXz/FZjgerQ6s
	 32yKHwhyaQBhf0Hdvz3V+wZ8+OSos7G6/6flQO/qxtS+UF0wl495X2MtCJ718ov7k7
	 WJ0oPSaxZ41joaczaUWMsE2lGw7tEJ6MyW3WfCpVZN6b19u/+voBVXGbEzM2AsbsC2
	 +P2j7LL705Q10BC0PSgf6szqJwP3F+xlx5GoGqNIg1t+bNZQY0CVXh05AVoamVQZ9J
	 AM3iYTY+F53vg==
From: Hans de Goede <hansg@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
Date: Sat, 13 Sep 2025 13:35:15 +0200
Message-ID: <20250913113515.21698-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7d5e9737efda ("net: rfkill: gpio: get the name and type from
device property") rfkill_find_type() gets called with the possibly
uninitialized "const char *type_name;" local variable.

On x86 systems when rfkill-gpio binds to a "BCM4752" or "LNV4752"
acpi_device, the rfkill->type is set based on the ACPI acpi_device_id:

        rfkill->type = (unsigned)id->driver_data;

and there is no "type" property so device_property_read_string() will fail
and leave type_name uninitialized, leading to a potential crash.

rfkill_find_type() does accept a NULL pointer, fix the potential crash
by initializing type_name to NULL.

Note likely sofar this has not been caught because:

1. Not many x86 machines actually have a "BCM4752"/"LNV4752" acpi_device
2. The stack happened to contain NULL where type_name is stored

Fixes: 7d5e9737efda ("net: rfkill: gpio: get the name and type from device property")
Cc: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
Changes in v2:
- Fix typo in stable email address
---
 net/rfkill/rfkill-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 41e657e97761..cf2dcec6ce5a 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -94,10 +94,10 @@ static const struct dmi_system_id rfkill_gpio_deny_table[] = {
 static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
-	struct gpio_desc *gpio;
+	const char *type_name = NULL;
 	const char *name_property;
 	const char *type_property;
-	const char *type_name;
+	struct gpio_desc *gpio;
 	int ret;
 
 	if (dmi_check_system(rfkill_gpio_deny_table))
-- 
2.51.0


