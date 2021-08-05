Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEADA3E183E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbhHEPje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbhHEPjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 11:39:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2BC061798
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 08:39:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so9770392pjv.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MALEPaHHc/EsqmzETjoT0BXGuVrPDKvHZtKjVXpWqAs=;
        b=tncQI6Tv2gOgxIUz/J7Xvc5/29/QU2+LVrhjPZRllp86AhwFyhAHKHQZX79cglXRXH
         yuv5PfYKHmIu2OFeu6JDFT7mMVphyR8xaJt3c0omDzd+/rWfew01TvsEujVbMo26FYnR
         7XlpxVckSQ8nxX2tOK9b/ssWoSm0LoFsH0+rCGtAhWARZnKAbq7c9B3IOlsPlEweHAxu
         i81VgMxbiGLG4lTmC83mnTRJb2Y8gmuqhhEMrc7e9FdzqsL5E3elJesXA8SWX5J1e1a4
         G9jYIao/vHguK9N2ridpCbjOEiTY2NQd4hdJT52Hw5hruJtaA/TBbiv5jmO4oFUkL+70
         o4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MALEPaHHc/EsqmzETjoT0BXGuVrPDKvHZtKjVXpWqAs=;
        b=JNBlbcjNgqShOUnX0ttr/N8um05ksaa8UDtZS9ah0/eIduhOTomIOC8sM9SVeOse71
         dsHzN9dIBPbtmRt9t5x6jr9U3RglBovNgRm+4iGnnT5QLediM2yMdaTmdVFS6jL2xHv9
         zNwRI+80pvQ1VWr3VBrSQkEJe65AJw0vY1xKHbrnOaPBk+mtkx8PYK3M1xdnEKF1HKA5
         t0bL76rZS4BTljhuV23hqsqHnTw/Pvtc2VTU4xRGZSXbeEsO52AQigV51QBJ1zXnWEhA
         5p1TMxIQuhOn7QtLU/BPTsXV51WuGpfnAqm3TG9C0GstKvHofRm0uOq+Gq7T2kOUO6r9
         v3Pg==
X-Gm-Message-State: AOAM533i6bswKb6UaJJrKWUH9j+FyVOe0MvWB6lGfcFYiSKcI/9b6nye
        4TbbBtnTCOR8cGg+XX/2Xnc=
X-Google-Smtp-Source: ABdhPJyl/jYreKM8rT7ZF1N6xtbrpW6t3uRvQCYAys2qHvLar5pdP6mXohXMTkuCfQXLsgRx3jgIPQ==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr5381031pja.175.1628177957784;
        Thu, 05 Aug 2021 08:39:17 -0700 (PDT)
Received: from lattitude.lan ([49.206.116.229])
        by smtp.googlemail.com with ESMTPSA id m17sm7173437pfh.133.2021.08.05.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:39:17 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] iw: mesh: fix crash when attempting to print the conf param "mesh_nolearn"
Date:   Thu,  5 Aug 2021 21:08:06 +0530
Message-Id: <20210805153807.645106-1-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if iw did not receive some of the meshconf attributes in response to
NL80211_CMD_GET_MESH_PARAMS, it tries to print that param and gets crashed.
Fix this by adding a condition check before trying to access each of the
mesh conf params.

$ iw dev mesh0 get mesh_param mesh_nolearn
Segmentation fault (core dumped)

 (gdb) bt
 #0  0x00007f21f54660e9 in nla_get_u8 () from /lib/x86_64-linux-gnu/libnl-3.so.200
 #1  0x0000562ba2f5d70d in _print_u8 (a=<optimized out>) at mesh.c:131
 #2  0x0000562ba2f5d7ce in print_mesh_param_handler (msg=<optimized out>,
     arg=0x562ba2f85758 <_mesh_param_descrs+1080>) at mesh.c:412
 #3  0x00007f21f546db9c in nl_recvmsgs_report () from /lib/x86_64-linux-gnu/libnl-3.so.200
 #4  0x00007f21f546e059 in nl_recvmsgs () from /lib/x86_64-linux-gnu/libnl-3.so.200
 #5  0x0000562ba2f5bb3b in __handle_cmd (state=0x7ffe677bc510, idby=II_NETDEV, argc=<optimized out>,
     argv=<optimized out>, cmdout=0x7ffe677bc508) at iw.c:541
 #6  0x0000562ba2f4fe0c in __handle_cmd (cmdout=0x7ffe677bc508, argv=0x7ffe677bc658, argc=4, idby=II_NETDEV,
     state=0x7ffe677bc510) at iw.c:613
 #7  main (argc=4, argv=0x7ffe677bc658) at iw.c:613
 (gdb) up 2
 #2  0x0000562ba2f5d7ce in print_mesh_param_handler (msg=<optimized out>,
     arg=0x562ba2f85758 <_mesh_param_descrs+1080>) at mesh.c:412
 412             mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
 (gdb) i local
 mdescr = 0x562ba2f85758 <_mesh_param_descrs+1080>
 attrs = {0x0 <repeats 35 times>, 0x562ba4002a14, 0x0 <repeats 266 times>}
 parent_attr = <optimized out>
 mesh_params = {0x0, 0x562ba4002a20, 0x562ba4002a28, 0x562ba4002a30, 0x562ba4002a38, 0x562ba4002a40,
   0x562ba4002a48, 0x562ba4002a58, 0x562ba4002a68, 0x562ba4002a70, 0x562ba4002a78, 0x562ba4002a80,
   0x562ba4002a88, 0x562ba4002a98, 0x562ba4002aa0, 0x562ba4002a50, 0x562ba4002aa8, 0x562ba4002ab0,
   0x562ba4002a90, 0x562ba4002ab8, 0x562ba4002ac0, 0x562ba4002a60, 0x562ba4002ac8, 0x562ba4002ad0,
   0x562ba4002ad8, 0x562ba4002ae0, 0x562ba4002ae8, 0x562ba4002af0, 0x562ba4002af8, 0x562ba4002b00, 0x0, 0x0}
 gnlh = 0x562ba4002a10
 (gdb)
 (gdb) p mesh_params[30]
 $7 = (struct nlattr *) 0x0
 (gdb)

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 mesh.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mesh.c b/mesh.c
index 23b3471..3797335 100644
--- a/mesh.c
+++ b/mesh.c
@@ -401,16 +401,20 @@ static int print_mesh_param_handler(struct nl_msg *msg, void *arg)
 
 		for (i = 0; i < ARRAY_SIZE(_mesh_param_descrs); i++) {
 			mdescr = &_mesh_param_descrs[i];
-			printf("%s = ", mdescr->name);
-			mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
-			printf("\n");
+			if (mesh_params[mdescr->mesh_param_num]) {
+				printf("%s = ", mdescr->name);
+				mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
+				printf("\n");
+			}
 		}
 		return NL_SKIP;
 	}
 
 	/* print out the mesh parameter */
-	mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
-	printf("\n");
+	if (mesh_params[mdescr->mesh_param_num]) {
+		mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
+		printf("\n");
+	}
 	return NL_SKIP;
 }
 
-- 
2.25.1

