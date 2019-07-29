Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3607934A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfG2SmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 14:42:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36669 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2SmQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 14:42:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so42818945lfc.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7vDMG/9SCpPW3zmkoq8GdvzJ3cq2Be8bwboqnhnU9g=;
        b=L2KTJIdu5SiSbqtA+LZydg+GbdXI6nZzL5fw2BriYpWQB+jv1KhlEeAp5yd++nyCmr
         1s+f4UOqCpHcVXO5Grj9EA1yTN1g6Jh5uVksbdUZ5Bb6Hzn4oy43/0k9oYGtNMRkZFNa
         d5RulY+9W1QrS6o5irg0fI1ByxqWt6HETk0k9Hw1Goi8DDmMFrhGY1aEbCsLwHqY46oZ
         FItHqhgKUpV6wQ7VLY6uVXguNqaRd+4vHsVvHQYY4ZWdbQPxlhzrVSKuHcIOLiSiSPCp
         L9G3cvVGdzSUrtY04OwxGP4s0TLEBnL9n7UafTs/Ig97y4kaXJhjI/zkMPdztduzgzgl
         mXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7vDMG/9SCpPW3zmkoq8GdvzJ3cq2Be8bwboqnhnU9g=;
        b=PtOuTXScqzaXzEKgYNyfcGBhBbGWm4XxeScKUQgyTMFSulikzQm52EiAbibRL27ZJ+
         1d/eMalJlJHWeRzRPTgofL00UjH3dH4Slv6HwDhVcRAGbTLlyvU5ozejeE6Ll5BNJhi9
         JenDOCZh4Ek4gq8wSuyvTIZlzFmCp0LHZ8Rb8x4jb64KVILocHjlVhFR25A+a478Vm9A
         HKgxoy4+a6bWpEeBtNir9aSvVN2QUgTdbgsgM3Ya9oDnkLcE75fJ+/FohQlRxPSUhkV5
         tC6uZhW8A4QoUYNSdU2tr2P3nPlI1UJJXkCgM09s55vhYGCMBSwepeFsLFESPwXvcxB3
         vIMA==
X-Gm-Message-State: APjAAAWUAdAug9loWlp+xrbHAKB2DQBXapK3cOFrBNK4d0Exh9xVnqh+
        lEKhfJm3syE+Pn9bIqn4CcA=
X-Google-Smtp-Source: APXvYqzLBz7WhjXzhopopbrVmVKOm9YF7O1ilm1tuUTzj5olqIOpSbyM3oXefjchCnbcIP30Uy5IPA==
X-Received: by 2002:a05:6512:484:: with SMTP id v4mr33865937lfq.66.1564425733934;
        Mon, 29 Jul 2019 11:42:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:dc6e:0:c4ca:724:d773:277d])
        by smtp.gmail.com with ESMTPSA id n24sm13059100ljc.25.2019.07.29.11.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 11:42:13 -0700 (PDT)
From:   Dmitry Tunin <hanipouspilot@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH] wireless-regdb: update regulatory rules for Russia (RU) on 5GHz
Date:   Mon, 29 Jul 2019 21:42:05 +0300
Message-Id: <1564425725-24733-1-git-send-email-hanipouspilot@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Russian entry is incorrect. According to the last regulations document of Feb 29, 2016,
160 MHz channels and 802.11ad are allowed.

http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf

Note that there was never a DFS requirement in Russia, but always was
NO-OUTDOOR on 5GHz.
Maximum power is 200mW that is ~23dBm on all 5GHz channels.
Also Russia has never been regulated by ETSI.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 db.txt | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/db.txt b/db.txt
index 37393e6..068fb5a 100644
--- a/db.txt
+++ b/db.txt
@@ -1097,14 +1097,12 @@ country RS: DFS-ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-country RU: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5650 - 5730 @ 80), (30), DFS
-	(5735 - 5835 @ 80), (30)
-	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
-	(57000 - 66000 @ 2160), (40)
+country RU:
+(2402 - 2482 @ 40), (20)
+(5170 - 5350 @ 160), (23), NO-OUTDOOR
+(5650 - 5850 @ 160), (23), NO-OUTDOOR
+# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
+(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country RW: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.7.4

