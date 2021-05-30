Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E23950A7
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE3L1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3L1g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 07:27:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8FC061574
        for <linux-wireless@vger.kernel.org>; Sun, 30 May 2021 04:25:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso5087852pji.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 May 2021 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNa82AGxltrUgWZP3TuoWDeM9PCyLQw1GWApGDdlR0Y=;
        b=SvqwsGy8E0Fe/rYwjJIp8TCapDPyNHFJ4AuosCUP36nbSX7kjpCQT0rx6F29FkqJPh
         0zoxO62BR630Imr3D/ziH9LJNS6NrkKiiiSKXK7hjFoaxh6X0HUkBfM3BrIm3eDNbD+W
         khiD5z2aLiK9vy8NOdgFY0m6874o7EtYGIgpcOYq7dQu1rTKOWZe3v6PhdFN+CH5orq2
         y+AZ39L1rd7+aac/g09Qhm9z946R03zZjoLUWbx4cAG5Pn0ZYCAwErf2TvyJA0tNy0AD
         JSi/FS8f3Gy5GtvWqSkEmtJCyHQUNFJAqFbn9mDM+cKehhufdd+CnLK4JkkZeAvH0kw3
         wS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNa82AGxltrUgWZP3TuoWDeM9PCyLQw1GWApGDdlR0Y=;
        b=fICbYiVWO2Q3kVGDG9Es+4g/OodAmh38L9WhaOa2yLYR/lfDLlObw7x/gD9Dgi6JgR
         9PUvECcov6RWo5IDHd8NGAxHyAVvZSi9iyK0ooHvJSXaGUJvj7F1YaoaT4sZx6OLHwol
         F/b25xRv5z7PTLsLfI8teT0k+fMR1zLJO5XA3A7D8gRHP8zWI3xLgq0/KXzHN3/Sw2dV
         k555mQP2zX5TlHQYAi54jexS6INAg/dcM3XN1h8Njmq1CQt3kpWHyxSg0NZzbORQmGax
         cMaiH7bEIOKv+4JpjqwwGG2wSZzGRr75WjxL3E65KhE4N9I2Sq3spDE/CkKYDR40b+dw
         cNnA==
X-Gm-Message-State: AOAM5301ALmahldLgeiNnQB/UKe1upGgipY62WXgP06GucBEQDjB9mM7
        i4qnkdeMIMxFYrtRuyk/Ke7+EIuwbqzeCg==
X-Google-Smtp-Source: ABdhPJzcsaYG0xsfkn0blH8YcTovp7+vdCpRcTWhYdpe8ScEhQ4NYKSs/MwljkUZmyKjBqYg3e5yhg==
X-Received: by 2002:a17:90a:8005:: with SMTP id b5mr13795932pjn.203.1622373956871;
        Sun, 30 May 2021 04:25:56 -0700 (PDT)
Received: from localhost ([193.110.201.122])
        by smtp.gmail.com with ESMTPSA id k9sm9003083pgq.27.2021.05.30.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 04:25:56 -0700 (PDT)
From:   Jianhui Zhao <zhaojh329@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, zhaojh329@gmail.com
Subject: [PATCH] iw: add option to set auth type for connect
Date:   Sun, 30 May 2021 19:25:52 +0800
Message-Id: <20210530112552.577329-1-zhaojh329@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
---
 connect.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 3237a27..e5b177f 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@ static int iw_conn(struct nl80211_state *state,
 {
 	char *end;
 	unsigned char bssid[6];
+	bool need_key = false;
 	int freq;
 	int ret;
 
@@ -48,7 +49,32 @@ static int iw_conn(struct nl80211_state *state,
 	if (!argc)
 		return 0;
 
-	if (strcmp(*argv, "key") != 0 && strcmp(*argv, "keys") != 0)
+	if (strcmp(*argv, "auth") == 0) {
+		argv++;
+		argc--;
+
+		if (!argc)
+			return 1;
+
+		if (strcmp(argv[0], "open") == 0) {
+			NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
+			    NL80211_AUTHTYPE_OPEN_SYSTEM);
+		} else if (strcmp(argv[0], "shared") == 0) {
+			NLA_PUT_U32(msg, NL80211_ATTR_AUTH_TYPE,
+			    NL80211_AUTHTYPE_SHARED_KEY);
+			need_key = true;
+		} else {
+			return 1;
+		}
+
+		argv++;
+		argc--;
+	}
+
+	if (need_key && !argc)
+		return 1;
+
+	if (argc && strcmp(*argv, "key") != 0 && strcmp(*argv, "keys") != 0)
 		return 1;
 
 	argv++;
@@ -160,7 +186,7 @@ static int iw_connect(struct nl80211_state *state,
 			   &printargs);
 	return 0;
 }
-TOPLEVEL(connect, "[-w] <SSID> [<freq in MHz>] [<bssid>] [key 0:abcde d:1:6162636465] [mfp:req/opt/no]",
+TOPLEVEL(connect, "[-w] <SSID> [<freq in MHz>] [<bssid>] [auth open|shared] [key 0:abcde d:1:6162636465] [mfp:req/opt/no]",
 	0, 0, CIB_NETDEV, iw_connect,
 	"Join the network with the given SSID (and frequency, BSSID).\n"
 	"With -w, wait for the connect to finish or fail.");
-- 
2.25.1

