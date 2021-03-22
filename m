Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903E1344837
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 15:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhCVOyJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 10:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCVOyA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 10:54:00 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581DC061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 07:54:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z3so14230123ioc.8
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rOr4TucPxgholRfGxWTtHiitPJG47B61Q/J9WpwQsBs=;
        b=Axb7gjTCy0BSJmpzC5EZKARnmZ+CfR1vEkBTgKzFgZVGixJR7kiDLx7K8w3VW79hHX
         XDJ7O6Yl1O9p8x3A4xPf7YdnXBKE/G2fqmBIPr9zzI06YnbAk9bZd3lQmoCXAQPCOhvV
         j9lXtIzfazW+OLBN4MzlERENqVNM+guaZtO3svVmtuB7jk3SRzwD+ueN0ECfRKYPoie+
         rdvlHJoB1aXxdCusfBmqH0cARFYemKVuf8H4cO0jCETttYI1fjof8fHJHE2Cxp5m34zg
         x3Dr5JFCQJI7dLZ/mcxK7DZKPyxnGRL5afANWzjMeJeBftxs1lJf9NRh1mOVP6IUeo4c
         sN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rOr4TucPxgholRfGxWTtHiitPJG47B61Q/J9WpwQsBs=;
        b=L+QWVq0pFbmigxuRYV8NvC0ip8sQww5XZ9os0mA6/2VTOwJZznuyV9aNGYDgvZI2aD
         2J/QdIA4nXYPACRSdB5X+JXplXsOXiSgI6l2Xm084Y6oV+BpTlCrE2bNM+5/AM4RGs55
         mxQb06xwOmx+PXZeQRhfB7nMCbYcw1R03BYOZK0Z11DQzGOCHH1xhqEi2p9tBgDl+sJw
         TnQrDlLQpfXlEh/siWZTzHCwGLAgq0p+4aTkHiH7JJiNONw5xEvr0xu9eYfhnGThcWQD
         9r0NF/DDhwLi2outagbzlOdjk5lk1lTfo1dLQ5H8zYi8NeXv8hA64FV+xKwm2iYiQPzn
         xjew==
X-Gm-Message-State: AOAM5319S6H+mO5+T5JDOCDVRswD0qPoIT2gZ6Hbafa5mcVupcMZKIuq
        fD+qKA1EvCatSZMzORxhz7P+QlLKcIYCu665xEdanj+DEmY=
X-Google-Smtp-Source: ABdhPJyXNBonYAP9bvbCnukGVvR5JdSPmWRqiJTwnamDKG3j9YbO4L33oFJ5ZjhCh3ZtZoCYPiR0nLLt82duxMpCieg=
X-Received: by 2002:a02:272d:: with SMTP id g45mr11764560jaa.117.1616424839690;
 Mon, 22 Mar 2021 07:53:59 -0700 (PDT)
MIME-Version: 1.0
From:   Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
Date:   Mon, 22 Mar 2021 15:53:48 +0100
Message-ID: <CAASiZWZGk=FWdy=MbM7MZnSx5GeS2X6-3xCmogsvGO5CgWKWBQ@mail.gmail.com>
Subject: [PATCH 1/2] iw: fix mgmt dump missing arguments segfault
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
Date: Mon, 22 Mar 2021 15:03:51 +0100
Subject: [PATCH 1/2] iw: fix mgmt dump missing arguments segfault

When expected arguments for mgmt command dump are left out iw segfaults.

Example: iw dev wlp2s0 mgmt dump frame e0

This fixes it.

Signed-off-by: Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
---
 mgmt.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/mgmt.c b/mgmt.c
index 338435d..677afb8 100644
--- a/mgmt.c
+++ b/mgmt.c
@@ -54,6 +54,9 @@ static int register_mgmt_frame(struct nl80211_state *state,
     size_t match_len;
     int ret;

+    if (argc < 2)
+        return HANDLER_RET_USAGE;
+
     ret = sscanf(argv[0], "%x", &type);
     if (ret != 1) {
         printf("invalid frame type: %s\n", argv[0]);
@@ -96,7 +99,6 @@ static int handle_mgmt_dump(struct nl80211_state *state,
     char **mgmt_argv;
     unsigned int count = 0;
     int err = 0;
-    int i;

     mgmt_argv = calloc(mgmt_argc, sizeof(char*));
     if (!mgmt_argv)
@@ -106,27 +108,42 @@ static int handle_mgmt_dump(struct nl80211_state *state,
     mgmt_argv[1] = "mgmt";
     mgmt_argv[2] = "reg";

-    for (i = 3; i < argc; i += 3) {
-        if (strcmp(argv[i], "count") == 0) {
-            count = 1 + atoi(argv[i + 1]);
-            if (count < 1)
-                count = 1;
-            break;
-        }
+    if (argc < 6) {
+        err = HANDLER_RET_USAGE;
+        goto out;
+    }

-        if (strcmp(argv[i], "frame") != 0) {
-            err = 1;
+    argc -= 3;
+    argv += 3;
+    while (argc >= 3) {
+        if (strcmp(argv[0], "frame") != 0) {
+            err = HANDLER_RET_USAGE;
             goto out;
         }

-        mgmt_argv[3] = argv[i + 1];
-        mgmt_argv[4] = argv[i + 2];
+        mgmt_argv[3] = argv[1];
+        mgmt_argv[4] = argv[2];
+
+        argc -= 3;
+        argv += 3;

         err = handle_cmd(state, II_NETDEV, mgmt_argc, mgmt_argv);
         if (err)
             goto out;
     }

+    if (argc == 2 && strcmp(argv[0], "count") == 0) {
+        count = 1 + atoi(argv[1]);
+        if (count < 1)
+            count = 1;
+
+        argc -= 2;
+        argv += 2;
+    } else if (argc) {
+        err = HANDLER_RET_USAGE;
+        goto out;
+    }
+
     mgmt_cb = nl_cb_alloc(iw_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
     if (!mgmt_cb) {
         err = 1;
-- 
2.30.2
