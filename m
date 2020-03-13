Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908DA1845E1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 12:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCMLZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 07:25:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37226 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMLZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 07:25:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so3968185pga.4;
        Fri, 13 Mar 2020 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YSkGa2UvwX+1eAP/7tt1QNSs+cG/P3JEIi8YH4DrwtI=;
        b=ds12Pbz56P3HtbbsNiP4zu8oLtv3DjT0vb9zDsJp975Z7iWT+UKql7Bn1CkRWx/e+Z
         lhHdDYzzewJ0hOIL29hwJcGLYEwZXnsQQ7j/8DWWJiZ0fq3dt7T5IFczsndvW2IAKj56
         6wVOm9bWVjGqxkNIZGRpKm4PXbyb9TyJxux37s3ASVI2BmtOMyvWRtqFSgnRbJZK4xW5
         lpGgT5PBTw0HyO559MN+VBkV+5rIvXlP91pA4yLTkQESr8+XQ0zIVB6nhjvlzO9UQ3Wh
         7Gjt4KQnntaCUkE/cQ/e0nDuF3SPxxKH0T9EZ5QQhrzMXqJs1JFaJJpz0uJoN+P4YEWM
         fxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YSkGa2UvwX+1eAP/7tt1QNSs+cG/P3JEIi8YH4DrwtI=;
        b=IhqYapwg6JelL28qmSDpA0pI9LzaMXLk/bSgZlwofNyWYnsmWis942iGbX+OR8J9i+
         zOxSf3oMU5zW0ppBe0s7I+IEZYsv7pdL81aIf4FrWYcV/niaZLENwRK7NVFsbWBGB2y0
         8lmXgOcTi+Vi5GCX+lUdzJ0q8QyWRHGsPFt6espW39h/nY6eYmx/9erQN2roEAxIx9uN
         jP20x0ECWxovmd79+H0DXurPjwQ14bjRAjgON0NMUneQITCZfEGvZLL6zhCz0yZ5FDP2
         LPs0/bTp/WTqcyMjVxezKfcKxrZ6weABBXYSdxNdzD3ddcUPlKTgXfwYNmxaqBLXEc9O
         73bg==
X-Gm-Message-State: ANhLgQ0KS/kgwad1CxCWwwkG0Oyn5op6ayuiivU+eigYkiNFnumrfskM
        HZcJ1M7aRzBfeIn5poorYog=
X-Google-Smtp-Source: ADFU+vuDSMMAXyFa/6NoReYrOXDHvyFMKXE0MIjwd9O6n1fxC41XyWu8IW+yEakpYStTxRY16K73tQ==
X-Received: by 2002:a63:6944:: with SMTP id e65mr13251443pgc.406.1584098704226;
        Fri, 13 Mar 2020 04:25:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:d418:f8a5:7ca8:f99b:fa30])
        by smtp.gmail.com with ESMTPSA id q26sm2094820pff.63.2020.03.13.04.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 04:25:03 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     adham.abozaeid@microchip.com, ajay.kathat@microchip.com,
        linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, shreeya.patel23498@gmail.com
Subject: [Outreachy kernel] [PATCH] Staging: wilc1000: cfg80211: Use kmemdup instead of kmalloc and memcpy
Date:   Fri, 13 Mar 2020 16:54:51 +0530
Message-Id: <20200313112451.25610-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace calls to kmalloc followed by a memcpy with a direct call to
kmemdup.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression from,to,size,flag;
statement S;
@@

-  to = \(kmalloc\|kzalloc\)(size,flag);
+  to = kmemdup(from,size,flag);
   if (to==NULL || ...) S
-  memcpy(to, from, size);

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/wilc1000/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000/cfg80211.c
index 54e02807cebf..4bdcbc5fd2fd 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -1142,14 +1142,13 @@ static int mgmt_tx(struct wiphy *wiphy,
 		goto out;
 	}
 
-	mgmt_tx->buff = kmalloc(len, GFP_KERNEL);
+	mgmt_tx->buff = kmemdup(buf, len, GFP_KERNEL);
 	if (!mgmt_tx->buff) {
 		ret = -ENOMEM;
 		kfree(mgmt_tx);
 		goto out;
 	}
 
-	memcpy(mgmt_tx->buff, buf, len);
 	mgmt_tx->size = len;
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
-- 
2.17.1

