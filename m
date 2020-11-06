Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22052A9F9C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 22:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgKFVx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 16:53:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59331 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgKFVx2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 16:53:28 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kb9fi-0001wj-GN
        for linux-wireless@vger.kernel.org; Fri, 06 Nov 2020 21:53:26 +0000
Received: by mail-io1-f69.google.com with SMTP id c2so2104939ioq.7
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 13:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYkKRFNH0Li3fZ5I86MqhtBKEPq0eFBCRC97cNAkMHQ=;
        b=Au0Y8YvFq4BY6lTXNSqwM+exjBMjcH8ymMBAwiA9N7BsXZCDlZHbsBA+5S2t75ERBK
         8ysKc1bXJN3aJCd14IoYHBLkrPWCpxPXWTVXcFqad4E9k64NCk+/MJG7oFlvJl2J4MnO
         9Ke7LTDGBnTPT80A1Px5u+kTtJ77Y7E/iu6JrJ6st+JQjKCI1Hi/6epz5Ju1rKLFJplJ
         zy1ZV/sueWp4bDIE6s8LYW9mud3fx0SrUsOPiGnyxF4/MepwEE9qXkc8e/ZZBuic1LC4
         k+v5viMbKvEsbuu/xqdLgyV3lZt9jkK/6D2l50DWBl1TPOBJ+N/S8AK4RXe2wHeTYPKj
         ukfw==
X-Gm-Message-State: AOAM530w6364wMHtMZsof5vMuFWoXeF26KxCiu8PQsgmf3PtGepKdizX
        rG8P82aylWGo6AK2McFuD5bnyZnRKKg4hPJ7jtsDV9bTJ9CtknGhhj52a2EI5JZHpvDpJTh8S3v
        u8yVd65G/5qhAOMCHpWMEN+Xd+nyEuQlKn8OW9jm6r6a4
X-Received: by 2002:a6b:8bcf:: with SMTP id n198mr3028498iod.122.1604699605519;
        Fri, 06 Nov 2020 13:53:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSAOxUarMLL4BEmJ12nIraGCuhMcgS0MiaV08Fy7EOXCinP3RM/D+A0uSgsXM2GbT6IISeCA==
X-Received: by 2002:a6b:8bcf:: with SMTP id n198mr3028492iod.122.1604699605332;
        Fri, 06 Nov 2020 13:53:25 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:e814:e33:9bb4:dad3])
        by smtp.gmail.com with ESMTPSA id l18sm1440854ioc.31.2020.11.06.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:53:24 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: update 5.8 GHz regulatory rule for GB
Date:   Fri,  6 Nov 2020 15:53:24 -0600
Message-Id: <20201106215324.91265-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on [1], the 5.8 GHz limit for GB is 200 mW and requires DFS
and TPC. Update the rule accordingly.

While at it, expand the 5470 - 5725 rule to 5730 as specified in
the same document to allow channel 144 to be used.

[1] https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 db.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 699bce9fb9d8..39e1928fe384 100644
--- a/db.txt
+++ b/db.txt
@@ -593,9 +593,9 @@ country GB: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
-	(5725 - 5875 @ 80), (25 mW)
+	(5725 - 5875 @ 80), (100 mW), DFS
 	# 60 GHz band channels 1-6
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.27.0

