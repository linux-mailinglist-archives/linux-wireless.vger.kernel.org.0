Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8340287E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbhIGMUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33696
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344087AbhIGMTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:51 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4D404019C
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017115;
        bh=Puh8mRYPY/DpKQ/I9uyYNXcSBWp/u+3lkb87itcd3n8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uUM0PGv4Rfv1eIcr/jyhIigDDP8aHrh/h5BVxfaJ8Y/CnfjE8YPeL7liuR927Teqq
         STekRzWqNFsFiHoLo5t/iynyWYXVdQ0HGA5UBL6syWw1UeEWS+ORr/8D7DEu4OLJmW
         ZDegXvvAx1ePauQZeHS74aULclKv5J+6S8N3GUkIGtCMEAPt8hydng134zw5kYMc2S
         8H912pfWb6qtYXviPK2WAMfiWwzJCQfuzaAGYfjPqE6xf3FqovXyzbd/lzwFplv1Es
         2L/oX5igL3KDFVgiCFEUnR5ClL8RhnvuKBRKkZ9TcB8yHNTBCTVCY1s7+y2G6Jhg45
         TkVBqvd3XDtRA==
Received: by mail-wm1-f70.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so3326296wml.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Puh8mRYPY/DpKQ/I9uyYNXcSBWp/u+3lkb87itcd3n8=;
        b=garm8dBNiPezafHBesqUYF4OB2QfkF1lwORU1uZp1NZbMsPjNCnAQtbNrfmesRTTZw
         CkDdn91rTS43VbWl4jk9U1AORgeWdQ69k57kn0A9gKO8M3MH0jhp4YTHo2LRgK6oZf6d
         KzjUJEs0oMBWQB4R7aPfpwvbgqDhPsU8jcwhH816E8R5U7vC7mU0pjZPmzBvoyTJKIFr
         b1EYOy541pkuX68jdTJTqiiM85tGue9nlctwtEnUHahhJBso8fiWpg63APAybToInAmw
         spcGLhpdh8zZTKF+RJxBzZAYbQB0tne0VVggdzU6/9fQG7MLE+FnLMiHoGeK9ialbazt
         VGRg==
X-Gm-Message-State: AOAM530faY9li+5ct4tX/Q5A2giVfhYhddZxJfOdyTJKnqHivroIaQA9
        tfRIrjsu3ad0Fce0P4XNpKZ9pF9Iw0C4Y/IcVZkfF1zDPctnooodNhubPLdfp1JHnStCxcxCOt7
        eU491kcKePyRq8GIZcduRGUsBTagVPvNh5q3JEkokYCGg
X-Received: by 2002:adf:f490:: with SMTP id l16mr18418669wro.136.1631017115522;
        Tue, 07 Sep 2021 05:18:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLMJx55+Q/WM79I6j8ltV38paMRUj8UUI3CoLPAg5wP7ajpWFYZY+esfWvjPdv6zq3PNmHWg==
X-Received: by 2002:adf:f490:: with SMTP id l16mr18418651wro.136.1631017115342;
        Tue, 07 Sep 2021 05:18:35 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 11/15] nfc: st21nfca: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:12 +0200
Message-Id: <20210907121816.37750-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/i2c.c | 4 ----
 drivers/nfc/st21nfca/se.c  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 279d88128b2e..f126ce96a7df 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -421,7 +421,6 @@ static int st21nfca_hci_i2c_read(struct st21nfca_i2c_phy *phy,
 static irqreturn_t st21nfca_hci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st21nfca_i2c_phy *phy = phy_id;
-	struct i2c_client *client;
 
 	int r;
 
@@ -430,9 +429,6 @@ static irqreturn_t st21nfca_hci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
-
 	if (phy->hard_fault != 0)
 		return IRQ_HANDLED;
 
diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index c8bdf078d111..a43fc4117fa5 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -257,8 +257,6 @@ static void st21nfca_se_wt_timeout(struct timer_list *t)
 	struct st21nfca_hci_info *info = from_timer(info, t,
 						    se_info.bwi_timer);
 
-	pr_debug("\n");
-
 	info->se_info.bwi_active = false;
 
 	if (!info->se_info.xch_error) {
@@ -278,8 +276,6 @@ static void st21nfca_se_activation_timeout(struct timer_list *t)
 	struct st21nfca_hci_info *info = from_timer(info, t,
 						    se_info.se_active_timer);
 
-	pr_debug("\n");
-
 	info->se_info.se_active = false;
 
 	complete(&info->se_info.req_completion);
-- 
2.30.2

