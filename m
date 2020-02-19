Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4281A163BF9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 05:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgBSEQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 23:16:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45654 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 23:16:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so8987821pls.12
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2020 20:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H5s84nZe09LEygazx+9zYHkBioooKXZ48/ls3AZTwNo=;
        b=sXaNni8hNvrlu2JabbxBr+U2UvIQCh/uJTUDTlriUSPs5hnN1ZiU3F+gNTn8rh8anX
         U7MKjCjKjLxdYUUeivIa7H5T8OsyjinlUCKaCqo4eUSh3vOpO4iRsfwa0H9tzahAL5+R
         pYIdtfahHGVvUm+g53tiLTgjAYY8Ws94wjGhRBMAOv5vLedb9Dgl8Fu8XjaOp/XM45b4
         yVdLXEqexgtLIsejKJQy0ShG8n8Mfmsurh3eCEb7NcJj/w74ug31e0dbUHOP401Gwq9q
         rcIocFOzMHzfF+K6GUOBJkb80YFfbcJ1dKYVHZx3CGYyq3jpuP6wGHyU8R92ye83WIvU
         dlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H5s84nZe09LEygazx+9zYHkBioooKXZ48/ls3AZTwNo=;
        b=VDerCLvcBFfboUf/Pfr8AdgtwIW01jAIT+E3t5CnIZ/gwoTaJug6wB1F6uYmCvlYld
         Q9HlgMT5AnXtY47xiNBkjXkbzXg1i4q39r3ECvoSQXAUZAOGXyGdS5CcZQeUeKBxl7le
         FAWfbEWDZ+hvYB14RFOG8BdrHZQEde2FswT7NoPVJzl3QHEtgWhFJjuDFaPhqtgJ7XyQ
         QPs/suZo8TiHtIAgFUAUTXW82nc4pylSylc6QqlM1M5gOQvL5mVAWWiwbg6nhwMt8qg4
         vky0/dESM/hzfytTJ457ogWg4SBgVjcv6MIv5eOaLeIm8Pvdqpn0YsCUUa+FvsOPC3XM
         meRA==
X-Gm-Message-State: APjAAAXftH5AAyWNEc1DM3Q4fykAFdW+qz1QX+xsRmPWp2ZnZouF4Lv4
        OrPYYD7W2JoYVC5YvQXB0z0=
X-Google-Smtp-Source: APXvYqyky4/vFL+WsbTkF+tGUtZqVgC52PrW/+DgGiIICaiq8pZbX5zw1WTPwenoUorf5FE9Kj8Qlg==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr6853463pjw.41.1582085764323;
        Tue, 18 Feb 2020 20:16:04 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id m12sm465947pjf.25.2020.02.18.20.16.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 20:16:03 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     Larry.Finger@lwfinger.net, kvalo@codeaurora.org,
        davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] b43legacy/sysfs.c: replace simple_strtol() with kstrtoint()
Date:   Wed, 19 Feb 2020 12:15:59 +0800
Message-Id: <1582085759-17998-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

The simple_strtol() function is deprecated since it does not
check for the range overflow. Use kstrtoint() instead.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/net/wireless/broadcom/b43legacy/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/sysfs.c b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
index 9312c1d..eec087c 100644
--- a/drivers/net/wireless/broadcom/b43legacy/sysfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/sysfs.c
@@ -25,13 +25,15 @@
 static int get_integer(const char *buf, size_t count)
 {
 	char tmp[10 + 1] = { 0 };
-	int ret = -EINVAL;
+	int ret = -EINVAL, res;
 
 	if (count == 0)
 		goto out;
 	count = min_t(size_t, count, 10);
 	memcpy(tmp, buf, count);
-	ret = simple_strtol(tmp, NULL, 10);
+	ret = kstrtoint(tmp, 10, &res);
+	if (!ret)
+		return res;
 out:
 	return ret;
 }
-- 
1.9.1

