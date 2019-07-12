Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB60667AC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfGLHUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 03:20:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45115 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGLHUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 03:20:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so4115716pgp.12
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2019 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sTdxNwMo1ynQqFHL7wEFPYUKPKgtLYWrVI61dL0gV4=;
        b=iqYKjPLs/9W2hx4DzNbiDRl3HNC4JgIj7/lGzull/9QSYKRO1fDNNBTUZn15j95Mr7
         jgyKIYNLgEWo/LaoXQeq+BVFsMdOwNhv9KuHNO4TcVVVrt62bWZj6T/zKHo9GkpY9di0
         R/joh0jKv2U0yh/3+cWD8XP/CbLQPjQOTctNK345Prbi/U8wt26XF9e3WrCy0jlZudNg
         HCvrt/g8sZ/a4PIg16afRzW3VaiEUX0NmdPELpefGTWIkNXiXmhqIV70Qb7iukCExjt+
         IAS45JJYofdJCg7O9x4L1R+BPmvxuABilhNFLiTlW1FY+p/WRzKteXYOV5K9utNPqHYg
         HqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sTdxNwMo1ynQqFHL7wEFPYUKPKgtLYWrVI61dL0gV4=;
        b=uK1uytUf7BuZuszCSgNcQVbhCyI6meCyQZuYKctkCdYbr5pkjr9RrV735JImo0YtnZ
         rLUS58MRixWWxbIIDunyRVyrnxnpdtnoHOSJoteR70Xntn6fZ4NNucWSOAovvqaDEGJi
         z3oycekt8RySb8EL7gAX0/5/yOTaN0/ZyCcGvpWO0H5+BKsVe3vUCjzJyv8QiWL5wmmW
         DW798jP4eNeZ19qJNqIDp1XCmzJKBsqFMvkAteBGO4tzQP/nVdm9YYJuN853sRIryuqg
         wZSQ4webhsH+f9IkhCB0WZJnXBRgsiwHmypIV7rUHjvTx/lDDHFaQM0MgC86Rzuijf+q
         S8IA==
X-Gm-Message-State: APjAAAWRoKqMv+gmlCZngHDworw5ss6KGOIdeD6kzoMumOSDoVkycpmB
        BSomEYXUgc6ZS1gfFY+VlYI=
X-Google-Smtp-Source: APXvYqw8sYfogWIfoE1hiFrb1sXh4OzZVSLlzqPs1Ld2jHFzhZRZLmj03XOK4wcCvbFJxP+kU/idAg==
X-Received: by 2002:a63:360d:: with SMTP id d13mr9121876pga.80.1562916020802;
        Fri, 12 Jul 2019 00:20:20 -0700 (PDT)
Received: from localhost.localdomain ([110.227.64.207])
        by smtp.gmail.com with ESMTPSA id q69sm11202721pjb.0.2019.07.12.00.20.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 00:20:20 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     adham.abozaeid@microchip.com, ajay.kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: wilc1000: Replace function wilc_wlan_cfg_get_val()
Date:   Fri, 12 Jul 2019 12:50:09 +0530
Message-Id: <20190712072009.2550-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include wilc_wlan_cfg.h in wilc_netdev.c to enable it to call functions
in wilc_wlan_cfg.c.
Remove function wilc_wlan_cfg_get_val as all it does is call
wilc_wlan_cfg_get_wid_value in file wilc_wlan_cfg.c.
Rename function wilc_wlan_cfg_get_wid_value to wilc_wlan_cfg_get_val to
maintain compatibility with call sites (including in wilc_netdev.c).
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/wilc1000/wilc_netdev.c   | 1 +
 drivers/staging/wilc1000/wilc_wlan.c     | 5 -----
 drivers/staging/wilc1000/wilc_wlan.h     | 2 --
 drivers/staging/wilc1000/wilc_wlan_cfg.c | 4 ++--
 drivers/staging/wilc1000/wilc_wlan_cfg.h | 4 ++--
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1000/wilc_netdev.c
index 565e2b5d0616..8d8b7e4399f7 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -11,6 +11,7 @@
 #include <linux/inetdevice.h>
 
 #include "wilc_wfi_cfgoperations.h"
+#include "wilc_wlan_cfg.h"
 
 #define WILC_MULTICAST_TABLE_SIZE	8
 
diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index d46876edcfeb..2cbdbf0090e4 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -1196,11 +1196,6 @@ int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit,
 	return ret_size;
 }
 
-int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer, u32 buffer_size)
-{
-	return wilc_wlan_cfg_get_wid_value(wl, wid, buffer, buffer_size);
-}
-
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count)
 {
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc1000/wilc_wlan.h
index d2eef7b4c3b7..b70014142686 100644
--- a/drivers/staging/wilc1000/wilc_wlan.h
+++ b/drivers/staging/wilc1000/wilc_wlan.h
@@ -291,8 +291,6 @@ int wilc_wlan_cfg_set(struct wilc_vif *vif, int start, u16 wid, u8 *buffer,
 		      u32 buffer_size, int commit, u32 drv_handler);
 int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit,
 		      u32 drv_handler);
-int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
-			  u32 buffer_size);
 int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buffer,
 			       u32 buffer_size, void (*func)(void *, int));
 void wilc_chip_sleep_manually(struct wilc *wilc);
diff --git a/drivers/staging/wilc1000/wilc_wlan_cfg.c b/drivers/staging/wilc1000/wilc_wlan_cfg.c
index 9dc5de4eb08d..f4144f93e4a9 100644
--- a/drivers/staging/wilc1000/wilc_wlan_cfg.c
+++ b/drivers/staging/wilc1000/wilc_wlan_cfg.c
@@ -320,8 +320,8 @@ int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id)
 	return 2;
 }
 
-int wilc_wlan_cfg_get_wid_value(struct wilc *wl, u16 wid, u8 *buffer,
-				u32 buffer_size)
+int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
+			  u32 buffer_size)
 {
 	u32 type = (wid >> 12) & 0xf;
 	int i, ret = 0;
diff --git a/drivers/staging/wilc1000/wilc_wlan_cfg.h b/drivers/staging/wilc1000/wilc_wlan_cfg.h
index e5ca6cea0682..614c5673f232 100644
--- a/drivers/staging/wilc1000/wilc_wlan_cfg.h
+++ b/drivers/staging/wilc1000/wilc_wlan_cfg.h
@@ -44,8 +44,8 @@ struct wilc_cfg {
 struct wilc;
 int wilc_wlan_cfg_set_wid(u8 *frame, u32 offset, u16 id, u8 *buf, int size);
 int wilc_wlan_cfg_get_wid(u8 *frame, u32 offset, u16 id);
-int wilc_wlan_cfg_get_wid_value(struct wilc *wl, u16 wid, u8 *buffer,
-				u32 buffer_size);
+int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer,
+			  u32 buffer_size);
 void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 *frame, int size,
 			       struct wilc_cfg_rsp *rsp);
 int wilc_wlan_cfg_init(struct wilc *wl);
-- 
2.19.1

