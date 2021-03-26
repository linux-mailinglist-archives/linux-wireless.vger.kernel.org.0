Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DEC34AE40
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 19:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZSIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 14:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhCZSIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 14:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616782129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dQILoV3kUu2cnjCNXVKuUHFOhse1lh3BYTGitnUmP28=;
        b=bk1uXyrDMyomIhjmiioLJFBGT1bRQHnD4JEABYDXSnuzUDFX7vQKSf9HHChYaztEFFHrBK
        DLgic0hqr18AYmjyCbM5eQhzM9YwYHrkIa2NrPZwbgXMXriQjZ18Ww2rfjsleHTJRyEp6N
        aGzA7fXI2pIMDxzUk7FtMYXlhk/cm60=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-Wd3VcE3oOECx6-Uw4MyeWg-1; Fri, 26 Mar 2021 14:08:47 -0400
X-MC-Unique: Wd3VcE3oOECx6-Uw4MyeWg-1
Received: by mail-ej1-f71.google.com with SMTP id mj6so4441329ejb.11
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 11:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQILoV3kUu2cnjCNXVKuUHFOhse1lh3BYTGitnUmP28=;
        b=FETkjFXioboxgK6kOPqCuv4FxgMW82yI999OIZl9odauxMm+dEeZ/J+ithMO9ggBQE
         pZF8vMQ/j5CC/hVoOge1slpALXvQ5zrfMd7epEy0l5RLqSrZ+KmFPbfVXojPmkKwkE+w
         GzYGGD6ulDTYkNcsmLotts5Sg0w4UGv8aIMy76Kz3lwcrEKVUsp/b01l9ZK6MFBburbU
         DaXrLVVADL6yJ0eeDCfAQH62eAJRygChw+m2VDgNA1UBh8wDNblcvJ0v3HswrU0EVu1n
         +tZ6ZgCJh+mz87FbhcEilD+IYZdXSq6pvSgyUGsoS9IqJ5GhnjWk0TCFlAF2mE2/92Kv
         StJw==
X-Gm-Message-State: AOAM531M3EQ8oX0ba0GbqYr4wWWj4tK6olzEH3FcW4o8fBkhU5xJy59K
        8HnC2r5IeiahvgdN53b44nWXn6Mat/UM0PlLlu3H4fuBE7WAcVzygK1yN9ie0cm85wSIlVa4vaZ
        jXqWGtmm26yTZkY4gOY1PNfYjyiY=
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr16356726ejb.282.1616782126500;
        Fri, 26 Mar 2021 11:08:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu6rViMnjRlOHbegtbtEcgLdUVlGnCu9O818y584E3dt7SvOhA82GKyVOA+XcbrpX6qwD5VA==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr16356712ejb.282.1616782126354;
        Fri, 26 Mar 2021 11:08:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ho11sm3977841ejc.112.2021.03.26.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:08:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0AFDE1801A3; Fri, 26 Mar 2021 19:08:45 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] ath9k: Fix error check in ath9k_hw_read_revisions() for PCI devices
Date:   Fri, 26 Mar 2021 19:08:19 +0100
Message-Id: <20210326180819.142480-1-toke@redhat.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the error check in ath9k_hw_read_revisions() was added, it checked for
-EIO which is what ath9k_regread() in the ath9k_htc driver uses. However,
for plain ath9k, the register read function uses ioread32(), which just
returns -1 on error. So if such a read fails, it still gets passed through
and ends up as a weird mac revision in the log output.

Fix this by changing ath9k_regread() to return -1 on error like ioread32()
does, and fix the error check to look for that instead of -EIO.

Fixes: 2f90c7e5d094 ("ath9k: Check for errors when reading SREV register")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 2 +-
 drivers/net/wireless/ath/ath9k/hw.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index db0c6fa9c9dc..ff61ae34ecdf 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -246,7 +246,7 @@ static unsigned int ath9k_regread(void *hw_priv, u32 reg_offset)
 	if (unlikely(r)) {
 		ath_dbg(common, WMI, "REGISTER READ FAILED: (0x%04x, %d)\n",
 			reg_offset, r);
-		return -EIO;
+		return -1;
 	}
 
 	return be32_to_cpu(val);
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index b66eeb577272..504e316d3394 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -287,7 +287,7 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 
 	srev = REG_READ(ah, AR_SREV);
 
-	if (srev == -EIO) {
+	if (srev == -1) {
 		ath_err(ath9k_hw_common(ah),
 			"Failed to read SREV register");
 		return false;
-- 
2.31.0

