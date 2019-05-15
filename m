Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB71F1F58D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEON0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:26:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEON0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:26:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQtvI-0007x3-0P
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 13:26:20 +0000
Received: by mail-io1-f72.google.com with SMTP id d22so1815858ioh.14
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 06:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lyyPK/ttNK3yVa2nl40/3kjtonXN5aqatNlD6xkp1J4=;
        b=Wbw+5bKDywpXBMgexxHGY9uPg7GhG9geUYbKNPfle5/d/uUtAH7howHmfY+cvNUQ53
         RAcNQx1/gLWe2ee5glbeYgOlkImp7mQ+E/+ZcXTh1/u292ZpEa2oZrqB1xo50ldfzzjP
         IJ0ETtmZ1c485BdRyzIR1Nyia9ChM4ikRwlCaLyAuyBFyJRuMl8uxfRpvjMWQaIZoTTm
         Wdw6yYlj1Q8mc/8ScoZplr47Fv67Vqm7s/z4FEFKn5Y2GEmqEx6Ci1Up9LgcCQFYrXX5
         F80MYjNR7teED6s1vesejtH7csaKGQ6ov5WDJ6M/yMvfSGp4PgWqgm6qH2BenJVdWyMx
         xA/Q==
X-Gm-Message-State: APjAAAXyB87zCrbcrmzWLM01h0pZBc80m2JxTkb+7CvG2U9idVW+qr7g
        wTBN2OZO3Gd7JKShMIHdgVIxywwngzbn1pe2+R+0r51qjtD4BnGL82PkoTsn5bjAe1anTKQ4ZUj
        UHDbJ+8hIa23xLuM3sj37HvWYBFvw04flnIVoPt09EMfh
X-Received: by 2002:a05:6602:21d7:: with SMTP id c23mr26101201ioc.66.1557926778670;
        Wed, 15 May 2019 06:26:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO0n6Jcd5OaVwtRdVjBHXpu4I2gf5hesNIT8015nW6YBWuZ2NJqGaHyDgy7P82Boyj8952Uw==
X-Received: by 2002:a05:6602:21d7:: with SMTP id c23mr26101185ioc.66.1557926778407;
        Wed, 15 May 2019 06:26:18 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id x4sm123733ita.0.2019.05.15.06.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:26:17 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Expand 60 GHz band for Japan to 57-66 GHz
Date:   Wed, 15 May 2019 08:26:17 -0500
Message-Id: <20190515132617.12852-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The official documents are not feely available, but based on
summaries such as [1] and numerous third-party resources the 60
GHz band in Japan has been 57-66 GHz for some time now. Update
our rules accordingly.

[1] https://webstore.arib.or.jp/en/products/detail.php?product_id=288

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 4fb194835116..e11e0f747386 100644
--- a/db.txt
+++ b/db.txt
@@ -664,7 +664,7 @@ country JP: DFS-JP
 	(5490 - 5710 @ 160), (23), DFS
 	# 60 GHz band channels 2-4 at 10mW,
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
-	(59000 - 66000 @ 2160), (10 mW)
+	(57000 - 66000 @ 2160), (10 mW)
 
 country KE: DFS-JP
 	(2402 - 2482 @ 40), (20)
-- 
2.20.1

