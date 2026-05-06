Return-Path: <linux-wireless+bounces-36046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G3GFrjT+2lxFAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 01:50:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD64E19C6
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105EB3025D1B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A613264E7;
	Wed,  6 May 2026 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnD4ZoM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6922F388
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111348; cv=none; b=U4VGbnvFS3HeLmrtIzxpnAKMq6pQaHPk8arVy95N94o5DDNu2fUynfZ2rK92S2RgroSz5J/6RVE56vgEa/TwaVz37EISp1oDu0ew+fU2aJbHG+bc6lGnWQbJuzB919iFFSaqQQesbqH4/vX7X18Q6155o2tFlOHdFntnkIMNaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111348; c=relaxed/simple;
	bh=Z4bytMVYePXqONZsifEH8qNJARoWqBYwmzfkG84+Yok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDyqHg4Ck26QOiXep/Kh7rz9nh2kbJke4asTXSh9nstFQpqriZBo7h7PPxE6VA2VPMFHOO6qHHIe6bs6Va/Rcz2W+Y2Kqs+6MLpvQ7mUUVPFUjcpVKkA5k+oOKQtByujumIjMWixAYT87+AiB3JvmG6Ibk34Wq6zLVvxaT+J73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnD4ZoM0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83659d38e38so59491b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778111347; x=1778716147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4c1t/cGflcyf51//1AN5dSxXV4n4B5RD0CTc3t+wbU8=;
        b=AnD4ZoM0UwoM0By+rhWcj9yxERVbw9OByKDos9S3lqjqvvfYw5bUanH/H2cm7J6H9A
         LEn4olhO1OX2NxYkker/T5HwFKvcH73f69Rm+VL9xcGeST0QiWv4PwdbX0TTkhTx5R3N
         d8n84NBqHvBLRdeTiwgS5Ya59k8MURgWPsALthg1DhYvxfxvWLG7QlXT8zpWm6l2v+zt
         /OBREQlqrQPy8ehoMdRpiBIFIFx43/hROpwecR4GMvgrfSKAvCnMHvus9Es45jcmtXVA
         w7O2KXJLiX2JCpeemvgCV0CJ6oUsDbUxFmwAGbcAQpaEKBPRJTktrJzD795b9e1w+ByY
         kimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778111347; x=1778716147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c1t/cGflcyf51//1AN5dSxXV4n4B5RD0CTc3t+wbU8=;
        b=hTMyri7usIVfpN/Ywu16RF4xQTYsD8moK18rY6bK2vNw7ng3k7FDr8nmZJ1dU/usuZ
         CMXjJHyKCKPzJQ8cJB9s/J1SRe9MTsRbURz4BNZU3NXZdYDURl2qtFzRANe9LlCOeBmi
         9GqMQBJnK0haq6Dm/D2whmxw1NrVry4hmzJ3v89FGyFeD2LGm6fIfwqxzMCypOjrman9
         NT4sQIp3AtFjOZjJraTW7munm+0iIYou7wgFEmYfG51BgCoHMFJv+GpXw/Sg6O9RZa0L
         PADi8twhowc6sXrA5blN5O1H7bYPQpU8tM5SN003CUOOWwF/IVNwps2EqFPuKobOPex9
         pzOw==
X-Gm-Message-State: AOJu0Yz3WBcwpLhifUK0d89PBG4B/eMyYqCJ2AS3rzppdnwk4YVBiF+G
	6OYESz3jHx1fFTaCuyuS2giwz5TTYWQjZXX/+AkX4/iQmG4ddmAWLnr/HtzQL/Kd
X-Gm-Gg: AeBDieuWKzJf4yetPGjAf8WI5fM4A1eguFYUFf1oeZNXogGurYpzTI0LPMy3PNVr6Hr
	c6zuxejmqur9rMAsy2yiZunXYbzr8AEimzuEgZjaWew2t+5RCr6juPJC8NseCTlZPyNk73v/0Cl
	el7tgRkNZODO/XsccevZLiAKPBObXjiBV+Od+h2M7FNzhR48nPsxiQvzbsaH+94cRmLje8INz7R
	C1se/5qfAnm2XJ9Zk7aKgKwzlTJWAnrsxBhIkBjhb8I3G346ku0tSikEHB+KauKgtC76QEJckOW
	MPwByximGnNrVZZViKdcfWAgjFYDjgjAag8nlPC2xReejHi5ukUuPWy0hkS0usJgqjaP9U7JZ0d
	MIruE9CXp1Zb8BfCNw0QIjshniw6uYFU5TSzlkAt076N1wixh+mOwEtLZNtRV0/EPf0GHFcD58v
	n9+8U4kYi+TG9H+XRkBC9u/SOGeh9crRb4UeA/yNv6ERuZeBzmWc3GMMR1N06/nGj1jwZ64wmcu
	2zYMEGNtFJGftueZ5m6JSJy/Fr6ZeDVAA/0k25jg2LgzQ==
X-Received: by 2002:a05:6a00:3d99:b0:83a:7def:e3af with SMTP id d2e1a72fcca58-83a7defe3e2mr3770078b3a.7.1778111345854;
        Wed, 06 May 2026 16:49:05 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm6928881b3a.15.2026.05.06.16.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:49:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 ath-next] wifi: ath9k_htc: use module_usb_driver
Date: Wed,  6 May 2026 16:48:48 -0700
Message-ID: <20260506234848.189840-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFAD64E19C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36046-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This follows the pattern with other USB Wifi drivers. There is nothing
special being done in the _init and _exit functions here. Simplifies and
saves some lines of code.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move module_usb_driver to its proper place.
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 10 +---------
 drivers/net/wireless/ath/ath9k/hif_usb.h      |  2 --
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 18 ------------------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 8ae4e5d4fa14..515267f48d80 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1520,12 +1520,4 @@ static struct usb_driver ath9k_hif_usb_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-int ath9k_hif_usb_init(void)
-{
-	return usb_register(&ath9k_hif_usb_driver);
-}
-
-void ath9k_hif_usb_exit(void)
-{
-	usb_deregister(&ath9k_hif_usb_driver);
-}
+module_usb_driver(ath9k_hif_usb_driver);
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index c28033ee61ce..dc0b0fa5c325 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -136,8 +136,6 @@ struct hif_device_usb {
 	u8 flags; /* HIF_USB_* */
 };
 
-int ath9k_hif_usb_init(void);
-void ath9k_hif_usb_exit(void);
 void ath9k_hif_usb_dealloc_urbs(struct hif_device_usb *hif_dev);
 
 #endif /* HTC_USB_H */
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 5270d0c0af17..6de78ae85726 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -1021,21 +1021,3 @@ int ath9k_htc_resume(struct htc_target *htc_handle)
 	return ret;
 }
 #endif
-
-static int __init ath9k_htc_init(void)
-{
-	if (ath9k_hif_usb_init() < 0) {
-		pr_err("No USB devices found, driver not installed\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-module_init(ath9k_htc_init);
-
-static void __exit ath9k_htc_exit(void)
-{
-	ath9k_hif_usb_exit();
-	pr_info("Driver unloaded\n");
-}
-module_exit(ath9k_htc_exit);
-- 
2.54.0


