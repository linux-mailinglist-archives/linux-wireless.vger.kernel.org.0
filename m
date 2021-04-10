Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BF35ACE7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhDJLUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Apr 2021 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhDJLUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Apr 2021 07:20:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D0C061763
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:20:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x7so8049366wrw.10
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYEahb625v2DCYdik74nB2Ub24ROmO5mmaG2bC7Pguw=;
        b=RpY1ITiz7aMOv9E2uunW9JWYLB438oUBtyFi3vn/qnKrdu1aMKTHAS89waKrwpuc0d
         mv2ipGWDKMZ38r4O5/+XOd2YKTjO5hoLBq59bSrcu2BDPUcfVGDeTe/zjFHpsPpT8IZG
         UaVBhEQ7TdAtJRZHfF4Xm8nY29qQgYARut/ryoxSS0o7wDiLdjtxBRBKamVlXVq+MrGR
         DQuj+66zCzrwn5iwxL2u+00CIi7QnGCPdEVWlQy9OBjqLkjTLRXw6TPsm9JgTUe0jfid
         fK6vom9dNfOoURIANR8H4XkbdW9Os7Riuu/rrnbfq8k5oT1MJEFIyoJVdX59YEZzZ2QQ
         dj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYEahb625v2DCYdik74nB2Ub24ROmO5mmaG2bC7Pguw=;
        b=kQbCgqw04NytSXYYYT/tpJTKXUKhXD8GP0/GOqUK5k8+fbJFcM8UZ6nxuqIkkQaSca
         kMxrNY8hAksKEfeeVx0h+Rggb73xEyhYyfj/JP+kvjWL6x2xWVxYO3d/M3XdUsTSBMdY
         mrp9cP8f9yHD26SecrmV6SkRPPir4g2W5FDasM6rmZZ6OPkga13qmYDXlxyfEMVhaY4m
         jKH/8DtM0J1Ry68zAqXjYQNIy73aLoB/OHAYJ13CJqB7rDfygC0Ujeea0AUYY3DpN+8r
         m3XZc2wvaOyJZwxdK2xKHFE0L770sq0mAt1A2i+jsCDwWtQwKcIXSmG7dZObQphSpfIN
         kPcg==
X-Gm-Message-State: AOAM533xHh+Mb4sO93JwvEu8cQax7f2DLnEhGZsvIoxYQZVuQdkx7qI+
        +k+VCh9tGaTiv2EJNbZnfEQsa3dXWaI=
X-Google-Smtp-Source: ABdhPJwZaKRfAjI+5CoHPUFj+GyNqO/wiXJyAdxXPbeE+eOjx14eHs4RvyC6tCwvQNjELSzNDN0ljg==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr21922261wri.90.1618053603534;
        Sat, 10 Apr 2021 04:20:03 -0700 (PDT)
Received: from paula-ultrabook.fritz.box (dynamic-2a01-0c22-a41a-e200-35a1-ce2e-1cf4-ff60.c22.pool.telefonica.de. [2a01:c22:a41a:e200:35a1:ce2e:1cf4:ff60])
        by smtp.gmail.com with ESMTPSA id j123sm7545118wmb.1.2021.04.10.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:20:03 -0700 (PDT)
From:   Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
To:     johannes@sipsolutions.net
Cc:     benjamin.aschenbrenner@gmail.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] iw: fix mgmt dump missing arguments segfault
Date:   Sat, 10 Apr 2021 13:19:36 +0200
Message-Id: <20210410111937.32813-1-benjamin.aschenbrenner@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
 
+	if (argc < 2)
+		return HANDLER_RET_USAGE;
+
 	ret = sscanf(argv[0], "%x", &type);
 	if (ret != 1) {
 		printf("invalid frame type: %s\n", argv[0]);
@@ -96,7 +99,6 @@ static int handle_mgmt_dump(struct nl80211_state *state,
 	char **mgmt_argv;
 	unsigned int count = 0;
 	int err = 0;
-	int i;
 
 	mgmt_argv = calloc(mgmt_argc, sizeof(char*));
 	if (!mgmt_argv)
@@ -106,27 +108,42 @@ static int handle_mgmt_dump(struct nl80211_state *state,
 	mgmt_argv[1] = "mgmt";
 	mgmt_argv[2] = "reg";
 
-	for (i = 3; i < argc; i += 3) {
-		if (strcmp(argv[i], "count") == 0) {
-			count = 1 + atoi(argv[i + 1]);
-			if (count < 1)
-				count = 1;
-			break;
-		}
+	if (argc < 6) {
+		err = HANDLER_RET_USAGE;
+		goto out;
+	}
 
-		if (strcmp(argv[i], "frame") != 0) {
-			err = 1;
+	argc -= 3;
+	argv += 3;
+	while (argc >= 3) {
+		if (strcmp(argv[0], "frame") != 0) {
+			err = HANDLER_RET_USAGE;
 			goto out;
 		}
 
-		mgmt_argv[3] = argv[i + 1];
-		mgmt_argv[4] = argv[i + 2];
+		mgmt_argv[3] = argv[1];
+		mgmt_argv[4] = argv[2];
+
+		argc -= 3;
+		argv += 3;
 
 		err = handle_cmd(state, II_NETDEV, mgmt_argc, mgmt_argv);
 		if (err)
 			goto out;
 	}
 
+	if (argc == 2 && strcmp(argv[0], "count") == 0) {
+		count = 1 + atoi(argv[1]);
+		if (count < 1)
+			count = 1;
+
+		argc -= 2;
+		argv += 2;
+	} else if (argc) {
+		err = HANDLER_RET_USAGE;
+		goto out;
+	}
+
 	mgmt_cb = nl_cb_alloc(iw_debug ? NL_CB_DEBUG : NL_CB_DEFAULT);
 	if (!mgmt_cb) {
 		err = 1;
-- 
2.30.2

