Return-Path: <linux-wireless+bounces-27271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2084B56079
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DE4E01B1
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Sep 2025 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B62D24BE;
	Sat, 13 Sep 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv60nWUU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2572EC0B8
	for <linux-wireless@vger.kernel.org>; Sat, 13 Sep 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757762499; cv=none; b=FLvz9atS6USlYho3A1o6UZYBXluhnAGsGurtob+5HU5LjmPlq2WFAZv3lF+2OVUCNDg99YjDWM/58/+qHNcuLhEoHd5vSvmAmOfBDtm3rFKq4zEuZEIdL6SJ+skWqmr0hYZj816BJ3MFsck2NAnieb6yQyCgGVSYWXJPwxD4q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757762499; c=relaxed/simple;
	bh=O2ELisK9viAsJ9wGVtOKRrUdxg4L7ePILlHAetvYZro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTV7XoYwvMp0QRB0L6vfmVpj1ogAbIUVbESClcxxTLOXUEjTrkBPL+u2NRdm88FOqH2u+wiViRlkWVUYIITEsWoO+h3qoXirnWE6j/c+S2Ol4fGnIgZ2TdbezThIFzVrP53lUwAjogrXuX8YXlWJWM4RdmuVKHlI0zKMUTN4JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv60nWUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A627C4CEEB;
	Sat, 13 Sep 2025 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757762498;
	bh=O2ELisK9viAsJ9wGVtOKRrUdxg4L7ePILlHAetvYZro=;
	h=From:To:Cc:Subject:Date:From;
	b=lv60nWUUZ4cFo0wSMaw5SCHMfDDzcoIQdxML/mTS+lFpGamnOhXCoJICHR1dNf6rx
	 ee4S3y937bjV1ELoF/kH8ZIHvniGa1D5YUpSzWbz557ZZy0E1A2gEBkbJuin9hAubR
	 DYiWfRCIRP5IL5B4boehy7ISATPAI1gLZ/Lx0vZG7nJ2/4THPs7HRodcNpLyVz3rZK
	 FOausri2VrU+iC2LpnEYbcVAdXdVQbKQ+Hoj/uxWhXvDH21tCMGwB46g8C0bA42juN
	 DvlFWQd8gd2RjQJiBxHm+JyWGbi2/qY6j0zQimRrUKxZVlmnaYqxb4ieyiwIEHLvy4
	 Ujw5DuT74qfaQ==
From: Hans de Goede <hansg@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-wireless@vger.kernel.org,
	stable@cger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
Date: Sat, 13 Sep 2025 13:21:35 +0200
Message-ID: <20250913112135.15658-1-hansg@kernel.org>
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
Cc: stable@cger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
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


