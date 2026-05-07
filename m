Return-Path: <linux-wireless+bounces-36051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG8iDwvx+2lfJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 03:55:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035A4E21F8
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 03:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5736301C14A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 01:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61461276050;
	Thu,  7 May 2026 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9wXY5Wt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334021A3172
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118917; cv=none; b=qazySnXOlmZmrK0PdQPcPYETibqi73TDxhQvFRi2B+X5qYW58vuGCk0MrTW7CaSLGSj1HAr0Q38oeh78O3ejRlmgATjy9YKBsURZKoLtdowVytZax7Hsr9KG3eFitNIkYX4CKJ8v9xdP5JqqEU93QU44MQKwagtV0fvl4cGHOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118917; c=relaxed/simple;
	bh=KM2IBGXPrY2u9cIPWgp7r/8W2uugSyA57Hpjz3HkFtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URSvWBh+BTypP8Hj5WydgkfNP3XN3fdXwGe/F+crI5hY/B0GMiGWz73L3j/s98zDHnVYEr/W99/JaJeqCdB2ujGzwNTLLRqU15e3ARYuaL+jPE+Su2ewbGfBHPBHyWbiSjXP1eEm1OIhhPKxuVsw0h4Mu5Is8pY8DJBYIjE+B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9wXY5Wt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-837b39eb078so156361b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778118915; x=1778723715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrwU1+WYoQ6dc3r1upj6/QwYywpyWVdYuoQct9GKosg=;
        b=E9wXY5WtWKu99slwlJ6AqG1VD3CPseJEymcAT5sP0LTBaFiD63L+IJyb0xbCRzWqo/
         UitKNumaHxyKX6tH/Q52nkDjAl4aPm4CW8sBtAjH0wE5zqqvcdGep8ZUaktf2vihK7/j
         F0cA6hFpBU/s4tGoHcxr/3pLZGnJer6pHviLi/TLzOZ1dfNtq05/661vdc0gB2yHl+0V
         UX6BXti+rllz2Kqg3j43xO2QyjbA4ArUofvoU4hHRDKRzUrXxmVwKORqxoXcF5aEPFMC
         czddDjIv8zZwVSrQC59JS35RzeOzkNYlp0GyVHh7pgiVyfhdyXGPdqa5vQTv2ls6dl59
         D1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778118915; x=1778723715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrwU1+WYoQ6dc3r1upj6/QwYywpyWVdYuoQct9GKosg=;
        b=PsNbzG4/rqiY3mPLSQd5xOo10f9eooSnwbgltcqeD5GbqrE7zDxgW77rq59Wl7He3I
         sPL0Dr6tqo3GmWy7c5530x3apAO0zgh7hNRnMF3IJGB6/vbfUFYt/fr+RXhfDEZY2Tqa
         1mLi8JkwrR0QkcG1xfgWCuOlPCLci5PO3q+DPBlelBYPFS7crec8nYT6rNz/LYTmykRh
         4uDqtktMc5p5AvsoCK+jU+2ggqN16rYOcVSJ8+Q3YFQ0LX06/LwvbK3zA4AFXwbmtzJa
         Une5qjeLrqeJPZH7zq2SUq/Lc4wK6f1qDhl6HE6Dr1BdKE3L9N5X97XxneUmGfSmiNOR
         xSAg==
X-Gm-Message-State: AOJu0YxwFrIGIKWvmHhOPc4AKvmi3l5/Upmjj+0Ln1LSCmM2Of6Sr7cu
	RrY7/VJ6Qqavqh141RluHHYak3SnhJELw2Fj2iIqg4XTqNJKRfyi7qkGTs2dzCnE
X-Gm-Gg: AeBDieuhEdDdEnqp/7EEwmWwUI4DNBlrcDcwCaVwQONLKsah9odlSmVVCmP9nEcWqV/
	EBgSso9aojiHka0Wq/Ofy4ULW5+T88Rl2odlc+IwRxfMWNWCfTGnY4AYtxnz+YY/u7kgRsPwQec
	ljnOIdPi+YrrACE40QshCmtYeuWduVcWz5Q+NGQ11xMXQZZvBxAGLRkH+HZmDC5aU6hlXCd6cd8
	YJqVBZF2W+Dnj/+Pydzs9Gw/5Y2ltl2YwlaajYiajc1UMnhvMOBkMpv1f4Y4M0tXYjeo5hbkNcl
	4gMQpbMa0VI3Kf726P/VhAu43OTwUH7szLMhjt9piTtHJO6XGcCMN7yUHIpA4gQCPzEWbNWU9CZ
	EHUhGjZhP/vREHbU5su0GNPevvxZ5DsSNQsMsB+4tLJ76/2E6xTsPUy4Wf36Fnmm3flVqoHwZav
	4AOzut3id1OnWS2qUxOF/Rj3PI8ns3z+khT0ZvkSsgcsfKUBJrOSOzpKh8ypGj4HN0q8ods/veP
	b1RU1MDg/paxnzTaoiISVU+T1M26MhIjjyz17C6qH4uRqldR9Zw+SEbjhGKZmM8O0Y=
X-Received: by 2002:a05:6a00:114d:b0:82f:3ecc:c42f with SMTP id d2e1a72fcca58-83a5e550e9fmr5307214b3a.40.1778118914968;
        Wed, 06 May 2026 18:55:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c7b92sm6776102b3a.29.2026.05.06.18.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 18:55:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Srinivasan Raju <srini.raju@purelifi.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: plfxlc: use module_usb_driver() macro
Date: Wed,  6 May 2026 18:54:57 -0700
Message-ID: <20260507015457.239807-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9035A4E21F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36051-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

init and exit do nothing interesting that module_usb_driver doesn't
already handle. Just use module_usb_driver to simplify the code.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/purelifi/plfxlc/usb.c | 25 ++--------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 5724ec173e64..6d24086eb8b7 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -851,7 +851,7 @@ static int resume(struct usb_interface *interface)
 
 #endif
 
-static struct usb_driver driver = {
+static struct usb_driver usbdriver = {
 	.name = KBUILD_MODNAME,
 	.id_table = usb_ids,
 	.probe = probe,
@@ -865,25 +865,7 @@ static struct usb_driver driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-static int __init usb_init(void)
-{
-	int r;
-
-	r = usb_register(&driver);
-	if (r) {
-		pr_err("%s usb_register() failed %d\n", driver.name, r);
-		return r;
-	}
-
-	pr_debug("Driver initialized :%s\n", driver.name);
-	return 0;
-}
-
-static void __exit usb_exit(void)
-{
-	usb_deregister(&driver);
-	pr_debug("%s %s\n", driver.name, __func__);
-}
+module_usb_driver(usbdriver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("USB driver for pureLiFi devices");
@@ -891,6 +873,3 @@ MODULE_AUTHOR("pureLiFi");
 MODULE_VERSION("1.0");
 MODULE_FIRMWARE("plfxlc/lifi-x.bin");
 MODULE_DEVICE_TABLE(usb, usb_ids);
-
-module_init(usb_init);
-module_exit(usb_exit);
-- 
2.54.0


