Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF687F20DD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKFVdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 16:33:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFVdQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 16:33:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id v19so29901pfm.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 13:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63TQi9wjRsP9B7olazjIeMk+BpYZQm1gAxXkqYIXD5g=;
        b=D6Bull3RYJaTOJbI8OL+yktXxz064s3kjiWnXaVqXiWMAa35qY+ce6w2nQf4G0NYeZ
         G/HzyrSZB9UkbI4lR8QedCA9CsA4GwfvyhYTTjQwGIMXN2LgpGHQV6LTfU90iaSp1Y6P
         3M+kB4VgdoLRLnW3bvmQIhjzHVodk3k3/uSrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63TQi9wjRsP9B7olazjIeMk+BpYZQm1gAxXkqYIXD5g=;
        b=tVJWyp5QDgKt55yS1mXC0/i1su+DCe1A+0VvJwHsa0rHtbNsiWZQPfs/cVW1lD4SNQ
         RUsCxagA3n8l082IIi+AY7P7axZ0l5jVrquojVLgBXyECcXeYINE4uzTYFJoLgkX5rC6
         1HrxYrNkF60ZbEf0KihV6Aug2ppi6STzKTPqBJRWtUAgSXUC8BcwDSqzxV7hvj35dtKF
         k7U5Bis7zAZXVYk7XJh/GzEeMwyBCInKJ2OVAWy8seeE+x4MvHfkoTT/09NkAcTI0YE9
         G9WWP5Ipvy92jjAK2tFbIErWPbkeBEHFZywKinposDGfRsVvjAHYRQsQ0BnBAMmx7a4+
         1rYg==
X-Gm-Message-State: APjAAAVZ4ARbN33E5Pe7ptbM4PfJfDgj7MvTLRGeSw8DWuUOzUGgl7oW
        FtOjoEjLBNTuv9ZF9S9uiaf4RXaSDyQ=
X-Google-Smtp-Source: APXvYqyFlUEM4jPnNevwfG+aT+9aGfM4U7Yb7YBooImBgaTarAywLYkNzmT6rmvCCOOKXx1TZ0+c4w==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr34785pjr.4.1573075995269;
        Wed, 06 Nov 2019 13:33:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id w11sm15710pgp.28.2019.11.06.13.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 13:33:14 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     <linux-wireless@vger.kernel.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] rtw88: signal completion even on firmware-request failure
Date:   Wed,  6 Nov 2019 13:30:55 -0800
Message-Id: <20191106213055.133424-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Otherwise, the waiters (e.g., "modprobe rtwpci") will block forever.

Fixes: f530c1961af2 ("rtw88: fix potential NULL pointer access for firmware")
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index de82d08ea29e..ae61415e1665 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1026,6 +1026,7 @@ static void rtw_load_firmware_cb(const struct firmware *firmware, void *context)
 
 	if (!firmware || !firmware->data) {
 		rtw_err(rtwdev, "failed to request firmware\n");
+		complete_all(&fw->completion);
 		return;
 	}
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

