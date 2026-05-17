Return-Path: <linux-wireless+bounces-36558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zIN5Ab9MCmptzQQAu9opvQ
	(envelope-from <linux-wireless+bounces-36558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:18:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336C564569
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA8B300695E
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DFA341050;
	Sun, 17 May 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmQoRqCC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1C32E6B4
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059899; cv=none; b=GU3Nrf+GzlIgjQGgNBb1i/XkF1K4rDMCbQt6DLdGkV/H795Qg4qR6Dt3BgEhtSyjsELbHTbX0mBqSIk7PPxc6RRVaZQQkqocMJxIw5q8/snKw0OG/qEeQMg80jf+EyQfTVYOWWz/F8KEf63BN0Dgy0/5g99dO/0YvOHFH5atN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059899; c=relaxed/simple;
	bh=UZn3pITGvP4LW9/RFaemW1OJ484MjcH6NtAK4eMbf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4Iwfy8LzYQ+fgdFPA2ijztVxNdyxY367kEgC8lTW3ZSS5ZneSb1fkhdGzGnjbis2Q3RbfL2rW6UH8otppuiipw0OVnANfNTC9Ir52+z2ofEhfzM8FzUE3SxQofZApbJdP+fQoMoHlaFExOZeO1SyXOBwmjLiY6I7FTrFoRR1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmQoRqCC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80291e6237so1218746a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779059897; x=1779664697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2quCpGONsw646jIOKe/5cEbb5ynd3RgkQTixQnoB8es=;
        b=QmQoRqCCvKLWyDmPfEKoMUMM/ED8naaEh0mnzyy0VkLSwVTaS8OxtHiBHPLk8R8cWB
         Z8cwkGKm6vEkFxScPRfTEL2c6qqUOzdqNSVjVOxf/emIJeLvxB2Vq/PgM6Fl10tSUdHK
         N+LSB2FFAjVkmt9g4rLkS5Al56yJXjpCprsRjhWoRKiT319HgKpRV3cdnMv4AyfOoAMS
         6V8WE9DLeKO1PeryendddWQUwMAzfz/EhWiO0mXsVSBPmyjxtic6h45og91goJGNQP56
         9IFrES2fZHyXZyURPHOqTWw7PzsI9ik49cNfruMANrjeFauu8oyPDHWuaxKpHNJ996pR
         XmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779059897; x=1779664697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2quCpGONsw646jIOKe/5cEbb5ynd3RgkQTixQnoB8es=;
        b=j+3/kxbkpKZcRKd/0/mQR1ZMOhstNNhnWfoaVV4WI/8rDzus835KyFYmRLtwgsAhBt
         F5SsSdjvLcvCFJevxUKWY0rBufcH81s+XhcT99PekMdE14WPE9Z8jiKbWsM+MxRI6Wsi
         pfspUNsPgbD1s0PjNE0RtUDuxI/oZ478+y3ASMXRU8SuaX2RUQyV7TRf/RQYV13ZnPBe
         sMwUxmhS1R/54Gh+q2zbeMFi4feQu/Zk4c3vK+aBnXkvMtph6Ufdm/PtR1dtbFhFVa58
         GKuG92JUQz5GCmgBby2XzbuyrrWu7+pzrYjzpDK40eETHcAmsR3lGjgsCKeCJDB+1A3E
         kZgw==
X-Gm-Message-State: AOJu0YwWNtPpSiRntJmt/wmk4iNm9H+DevISMtNS7koPXFFaOGySmimq
	G4AWpRrQnfZ6o78LSop3tR/P7O0W1qGp+I8WJKiO1I1ZfCmtw5wjz6qJXWE5LA==
X-Gm-Gg: Acq92OEejjaAlrgu5Hkm2sIYv/5LTSeeHuLVn5I3jGASIUno07LmCbri+FTO55jMXXb
	MMULg76WUR6iQHFV7HEnPs8lW3sZgmEKNacNPPz11mbT79gymkp5KKCopHwBfa1CJPQ322Q2u3G
	5kdFeJjGAyIGOk02acKAY+hSBuJ7RXKXWXXYpATITuvsBzm3lqWiMdpz39J9rnGsfyLikMhZACc
	9WUqtzS8fC+7TFONQdGv6ir+DpX3bQ/mkhhU6pY0Gfp4FQ7x+svjDDVbwsg9Lh6j/HUat50BTsb
	jrzL+3Ba5/fiiyjbUmS1PW2QzHx35xIVMPN/jyAh91+M8kXjd7Lnir0WBdtq4FhlKMe8vskL6z2
	r4b8UbSURfbsgscqS3Wd62G48V0EI9kzH9DgL8QGfaMPhXBmQ1y9ZTDVRJRStdI3G5A8iYraKyC
	SPfbe5vLXFxNLflTi7nr9XOZL3Rl2bCBjsfSkH3WKtIQbHeFQ3Vc5G2p5DRIV2y3Mw6h7ynlQCj
	0SROyJ7dIkjTipu1C4y7dkOpVzpZdYmIFY=
X-Received: by 2002:a05:6a20:7486:b0:3a2:d79c:416d with SMTP id adf61e73a8af0-3b22ed6295emr14697035637.43.1779059897281;
        Sun, 17 May 2026 16:18:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm14509038b3a.58.2026.05.17.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 16:18:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: rt2x00: Allocate LED names dynamically
Date: Sun, 17 May 2026 16:17:59 -0700
Message-ID: <20260517231759.56638-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5336C564569
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36558-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The rt2x00 LED registration path builds LED class names from the
driver and wiphy names. A fixed stack buffer can truncate those names
before they are passed to the LED core.

Allocate each LED name with kasprintf(), check allocation failures, and
release the stored name when the LED is unregistered.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2x00leds.c   | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c b/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
index f5361d582d4e..8818e0b2447b 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
@@ -100,6 +100,8 @@ static int rt2x00leds_register_led(struct rt2x00_dev *rt2x00dev,
 
 	retval = led_classdev_register(device, &led->led_dev);
 	if (retval) {
+		kfree(name);
+		led->led_dev.name = NULL;
 		rt2x00_err(rt2x00dev, "Failed to register led handler\n");
 		return retval;
 	}
@@ -111,15 +113,19 @@ static int rt2x00leds_register_led(struct rt2x00_dev *rt2x00dev,
 
 void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
 {
-	char name[36];
+	char *name;
 	int retval;
 	unsigned long on_period;
 	unsigned long off_period;
 	const char *phy_name = wiphy_name(rt2x00dev->hw->wiphy);
 
 	if (rt2x00dev->led_radio.flags & LED_INITIALIZED) {
-		snprintf(name, sizeof(name), "%s-%s::radio",
-			 rt2x00dev->ops->name, phy_name);
+		name = kasprintf(GFP_KERNEL, "%s-%s::radio",
+				 rt2x00dev->ops->name, phy_name);
+		if (!name) {
+			retval = -ENOMEM;
+			goto exit_fail;
+		}
 
 		retval = rt2x00leds_register_led(rt2x00dev,
 						 &rt2x00dev->led_radio,
@@ -129,8 +135,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
 	}
 
 	if (rt2x00dev->led_assoc.flags & LED_INITIALIZED) {
-		snprintf(name, sizeof(name), "%s-%s::assoc",
-			 rt2x00dev->ops->name, phy_name);
+		name = kasprintf(GFP_KERNEL, "%s-%s::assoc",
+				 rt2x00dev->ops->name, phy_name);
+		if (!name) {
+			retval = -ENOMEM;
+			goto exit_fail;
+		}
 
 		retval = rt2x00leds_register_led(rt2x00dev,
 						 &rt2x00dev->led_assoc,
@@ -140,8 +150,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
 	}
 
 	if (rt2x00dev->led_qual.flags & LED_INITIALIZED) {
-		snprintf(name, sizeof(name), "%s-%s::quality",
-			 rt2x00dev->ops->name, phy_name);
+		name = kasprintf(GFP_KERNEL, "%s-%s::quality",
+				 rt2x00dev->ops->name, phy_name);
+		if (!name) {
+			retval = -ENOMEM;
+			goto exit_fail;
+		}
 
 		retval = rt2x00leds_register_led(rt2x00dev,
 						 &rt2x00dev->led_qual,
@@ -182,6 +196,8 @@ static void rt2x00leds_unregister_led(struct rt2x00_led *led)
 		led->led_dev.brightness_set(&led->led_dev, LED_OFF);
 
 	led->flags &= ~LED_REGISTERED;
+	kfree(led->led_dev.name);
+	led->led_dev.name = NULL;
 }
 
 void rt2x00leds_unregister(struct rt2x00_dev *rt2x00dev)
-- 
2.54.0


