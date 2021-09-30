Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0379341E270
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347535AbhI3Tvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347577AbhI3Tvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 15:51:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D0C06176A;
        Thu, 30 Sep 2021 12:49:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q2so2035794wrc.4;
        Thu, 30 Sep 2021 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjxwTHZS4LImNPuiEDq8eN889k4cwPptRNYXuQDkBTY=;
        b=POFjq4PNVnMB+ghqugBSYt7WTv6oal3IwnJoiMg28UetK2WK9cy7KXe3PRMXHMgY4o
         peg7m8WFgBC4Oi9e0mhVaCcsJXYlczuDdST5OF/iztGGXm6LbTWWQ2jIx01NYPcEA7ZB
         IitFAQbYziDqlI7cHuEaRon0CvHtRoBsyPJqgkkqpmU6UfCXKOBwWJ1NPgknmIs/a3zE
         wJib0yfwL5hPoI4mRxVXePWNg5sL8J6GeTt2lrx9zqPEKIL5xr0RHhfxWVkdqb4dRnsH
         8VlYv7aL/nsGNXysonvuGIh0NqXnDwWde3NJutkyeeCgiHY1SenIuKW/DjAngvFUijH0
         F25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjxwTHZS4LImNPuiEDq8eN889k4cwPptRNYXuQDkBTY=;
        b=ir6sbW+eb8GZmJNAjVCYLuPXh/jAhKAeRPIWnUS6ypSrYZEViaIPvq5ffohQX06iBv
         2H2mxr/Ja9wuuqpIpLoORbICdzx0p/mWqeGG+VnTxp9iIE97N5B/3/uXczpAslNX67Yz
         35LcIPYXvHP9ZFikWu0CZPewtYr3g1gNeZrsXb264V2PfRAqvZZVWY7rwJMAl0/02aCq
         U9zW8ZegJbiKgMzDx4mXoZOptK8UAu52grV+hnDOawUlWiqqxa3j1umFOWzxkPke9t4z
         dSdUW9O/s1WFDlpi73ly72c63oxJMtk9oWCSEjWH6OsNL3oAFpXNS8cdOz6/5vn80ACX
         m5aQ==
X-Gm-Message-State: AOAM531L1td9yNdrSfbsyqyhpfHDL18OUH7yQcRg6hSMdUC7b22N8OzH
        mdkepysQcBw9XMnZiX8NVq0g7hBIREk=
X-Google-Smtp-Source: ABdhPJwOi77wbzT/7bmPyGfyV4/xyTaep1joFMvcIhWVX6PYTpFC71gRXLwn00cLdDLKDh9yyUBRWw==
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr8187959wru.280.1633031396526;
        Thu, 30 Sep 2021 12:49:56 -0700 (PDT)
Received: from localhost.localdomain ([197.49.49.194])
        by smtp.googlemail.com with ESMTPSA id j4sm3894816wrt.67.2021.09.30.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 12:49:55 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcma: drop unneeded initialization value
Date:   Thu, 30 Sep 2021 21:49:20 +0200
Message-Id: <20210930194920.15847-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not initialise statics to 0
ERROR found by checkpatch.pl

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/bcma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index c6d6ba0d00b1..8e7ca3e4c8c4 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -20,7 +20,7 @@ MODULE_DESCRIPTION("Broadcom's specific AMBA driver");
 MODULE_LICENSE("GPL");
 
 /* contains the number the next bus should get. */
-static unsigned int bcma_bus_next_num = 0;
+static unsigned int bcma_bus_next_num;
 
 /* bcma_buses_mutex locks the bcma_bus_next_num */
 static DEFINE_MUTEX(bcma_buses_mutex);
-- 
2.25.1

