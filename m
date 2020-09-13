Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F13268085
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Sep 2020 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMRVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Sep 2020 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMRVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Sep 2020 13:21:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EF9C06174A
        for <linux-wireless@vger.kernel.org>; Sun, 13 Sep 2020 10:21:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gr14so20008069ejb.1
        for <linux-wireless@vger.kernel.org>; Sun, 13 Sep 2020 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTI9rYYZOz9x7GGfK504gbdxl6ZS8e9EmqJVB1GyVzM=;
        b=ZLmsqdLZ8/vwSVlDu7ApqDOZQdruO932aMzys003ysncsdQ5KHAHXBBW/PF/t9I5rg
         3cBEuuv2RcbQE7bRIvI6P3r3AMhAKBF8nkOQRySrZyyAusGf0/jk6wEoVl7zya9YlL5+
         cUNj3Ge2+0TWDqkv9YQnDTghqEugnl7cPvZrGqRXcv3H9xyeXOYLr8bzE7yP0DmFKkVm
         NwuRPU57GaS9YUs5uSwi0trB55KfhD7TpgHKLwK0xWJqdwfdPimp46VoJUw/5dLbyRJq
         k/0Z8ONs5G8pciI4sB5WHngrEu62JfMN53Lj+/RULpRECoWPSXqGomk2gYIJwR638VRI
         OtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTI9rYYZOz9x7GGfK504gbdxl6ZS8e9EmqJVB1GyVzM=;
        b=cdt0U+CqQYmBcgbdtGMnXMcJ+r7sOwXtxZezJ/2uk/t2J3YawHmX+dNKVtl6IHpfX+
         WI4nOvrkqYfmQJHpMZ6Z9mUZbUR5B9aFZuZGU/E0tl9cJJGccNGsDYjCl+ldfpU8BYya
         y/vOzhxi5endqM9YShQ/OneCMcAiRQ44UkLGLznBfZSrRQov/VVI6JHUbwJFMOHc7oTL
         IMsgnJiNMCvONdJell+mMPrxABRu0wkyzOQOGzIOPWukjJB8Uw+0J8fViKC5UGSC1VUz
         7LodtkNESr3f/1UYD3h3awhl08gQvJ3yL8buy/RkuNAL9BpY3LJ4zbPNh8PsnDM/8eTV
         wsuQ==
X-Gm-Message-State: AOAM533ppPOUxMSXGtoHlZmdSIBYHsJyXTk3/N255R705J9Zb3KUAO4h
        Yit7/GNmnizuIJYYB1A3oiCXzGZWUBTQwA==
X-Google-Smtp-Source: ABdhPJw5aIH+rNLEb4u6ggAk9xNoe5Z3yVSu1dJuoCd5mFjec9zknX+vaVNgK5oS+Nm+iUd/HdLQEg==
X-Received: by 2002:a17:906:c1c6:: with SMTP id bw6mr11425807ejb.374.1600017707102;
        Sun, 13 Sep 2020 10:21:47 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-22.xnet.hr. [88.207.97.22])
        by smtp.googlemail.com with ESMTPSA id o6sm7464260edh.40.2020.09.13.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 10:21:46 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     seth.forshee@canonical.com, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Croatia (HR)
Date:   Sun, 13 Sep 2020 19:21:40 +0200
Message-Id: <20200913172140.66439-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Croatian Regulatory Authority for Network Industries (HAKOM) has
updated the general licenses OD-85 and OD-86 with the new OD-85a
and OD-86a versions.

These introuduce the following changes:
* Outdoor usage for 5150-5250 and 5250-5350 MHz ranges is permitted
* 5150-5250 MHz range TPC requirment was dropped and power output raised to 200mW

OD-85a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_85a.pdf
OD-86a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_86a.pdf

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 db.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index ac32483..52d0fab 100644
--- a/db.txt
+++ b/db.txt
@@ -693,8 +693,8 @@ country HR: DFS-ETSI
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # HR: http://tablice.hakom.hr:8080/vis?lang=en
 	(2400 - 2483.5 @ 40), (100 mW)
-	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-- 
2.26.2

