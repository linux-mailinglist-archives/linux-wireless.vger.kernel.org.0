Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D429E53D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 08:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgJ2Hzk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgJ2Hys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E87EC0613D5;
        Thu, 29 Oct 2020 00:54:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so1684071pgm.2;
        Thu, 29 Oct 2020 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZ8pxAyd90P09EZS29AS79lvzRZSYo/HmyimwC4NW5g=;
        b=fGi63on4cCN2JxK9RUaseBVnxHbgJ9kKPbeT2JyeclStZsn/APT81aV4vJdxOfP9pk
         ZtOmoPKJKXM5koaIuWUqw1BVtDlRWii6xIxrZi/JU7Ok0NwLqf7G4KWzdJIHVIGckLks
         fhKwip2ZR2SkF5q6yiI2xxaomjyc6Ob4Yi/DsAzGUKGS8vedNllcYDgcpVlVX5GgqHVd
         +Ktwaea/qbseQMox+1rI3f1ML4AVRkjPbp0O/oSiqnDQjAVDVvSRFGYAhCuZf1BC5RbB
         ZT2WKeuJ+lsBgjKEHJtibhJkoR+FGA8K848eDYA3TpXMPoArB9Cunhv7xUfDgsw59X2Z
         YRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZ8pxAyd90P09EZS29AS79lvzRZSYo/HmyimwC4NW5g=;
        b=MJ3THs+yJdDGIgXC8V/tNl2ZB0TVsDqFlRpFbQiyW714Gw6LeShH7PZsAsW9DjOCj8
         ckURZ4TLyMEkzHjkrTVLbo8+idlHsLYyXHjPylMcrBYz1RI5bHyK7kprY9ZRAh6bro7X
         NzGauG7bXHfgvfSTA3CNnP+c50PcaCXhMrYvaPuU35HWZstrKMmh5LZdiTylAkIDmUAR
         chanaEV4QmwQKG2x1Zb1yVQzjo/37QCnVrjZOqREDEU4mGvo32MISgwxOA8L/r0WrPYa
         VX8k6mvNY96y9yOSq2XAddR7UhvkS6aWVfCaatyWovrXTEafgus2uxTpDvBFzv5n4bxs
         70CQ==
X-Gm-Message-State: AOAM533KizKwTYQKxhkkmavGllCRtpSyHqWNZyOOR+G3i4f/5IebxZkM
        NOf3Pbag+Q3KAZYNhB80ar8gfK2uUf3puScY
X-Google-Smtp-Source: ABdhPJw5apgMORY34jfuinEPIPVOjJqjZuXgh2R1cY6w1t9FqV7P54pJnCEvaeIiybYX5oTZEtAf8A==
X-Received: by 2002:a17:90a:da04:: with SMTP id e4mr1306779pjv.18.1603958088250;
        Thu, 29 Oct 2020 00:54:48 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id z10sm1880540pjz.49.2020.10.29.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:54:47 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Michael Buesch <m@bues.ch>
Cc:     linux-wireless@vger.kernel.org (open list:SONICS SILICON BACKPLANE
        DRIVER (SSB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Drivers: ssb: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:54:30 +0800
Message-Id: <20201029075430.228760-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/ssb/pcihost_wrapper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ssb/pcihost_wrapper.c b/drivers/ssb/pcihost_wrapper.c
index 410215c16920..6510f57469a0 100644
--- a/drivers/ssb/pcihost_wrapper.c
+++ b/drivers/ssb/pcihost_wrapper.c
@@ -18,7 +18,6 @@
 #include <linux/ssb/ssb.h>
 
 
-#ifdef CONFIG_PM_SLEEP
 static int ssb_pcihost_suspend(struct device *d)
 {
 	struct pci_dev *dev = to_pci_dev(d);
@@ -62,8 +61,6 @@ static const struct dev_pm_ops ssb_pcihost_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ssb_pcihost_suspend, ssb_pcihost_resume)
 };
 
-#endif /* CONFIG_PM_SLEEP */
-
 static int ssb_pcihost_probe(struct pci_dev *dev,
 			     const struct pci_device_id *id)
 {
@@ -125,9 +122,7 @@ int ssb_pcihost_register(struct pci_driver *driver)
 {
 	driver->probe = ssb_pcihost_probe;
 	driver->remove = ssb_pcihost_remove;
-#ifdef CONFIG_PM_SLEEP
 	driver->driver.pm = &ssb_pcihost_pm_ops;
-#endif
 
 	return pci_register_driver(driver);
 }
-- 
2.28.0

