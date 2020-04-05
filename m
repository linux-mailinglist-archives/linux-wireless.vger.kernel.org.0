Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E804219EDCF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 22:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDEUJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Apr 2020 16:09:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44276 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEUJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Apr 2020 16:09:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so14904296wrw.11
        for <linux-wireless@vger.kernel.org>; Sun, 05 Apr 2020 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59ygflbpAkIRwMVUaF51S+Y9tq+5sCewZts0noUXoCQ=;
        b=prWMqfC3A16KW7vDTmnaYvVZzBfEMyOqMs+deQ/wY0ivpjHLsL7TUzeqOixdhlGMzO
         ep2WstqpJtRa9c/MR8tQWr/13uhdEJ4+q9hfDj8C+80i6mITBn6VddiyJV7F4NPXAuuD
         ZwgOsykkhFdxpimocXqw45GtCWCy73WRuHwYC30RxGbcuCYqIMVF6XPPe7lHy24Ho3Oj
         mUEko2pFMqK6oQ/USLEBCJMVGR0yqG9cePRAH4RReNG8cWN/tA0bZm3i91I0xzlLDTtI
         1hGghJDVrgqTb9jmZqis4KkYFYcHtJ7dYh9XwTiec3JmEQcO7mA7QjH/We/wC3hLrJRT
         Eiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=59ygflbpAkIRwMVUaF51S+Y9tq+5sCewZts0noUXoCQ=;
        b=RztMf/fdTmvICOnjfrFs7tEtf7OzAf3PLiDjzD1wh1/p6oyRmRh3nJOj0rRNkqLR9F
         njjicfmsb0iH57e2aPLuEvnloj5YW4DXUntDUargiQjAURyxHQFx7aZOD1f1aAI5Hl6o
         jduHjVt6lU1k7mU7uvqWyDnhp+BkH4EXvuCDj0QZhkOI2+CHVOsTrCS+LwNZ+oCyZ/kw
         hmFJwxuLMoF1/uq+db/H9jlwdcV9kURmTG0ZUhW2gqw0JaHXZGZktOX1e7AX/9gSWDd4
         W4Ncze/i7DzH0t03pTPP5fGeMCfKsZCVvW3we1tfiq3D6KSSlPtlzzzNahxqavHQlFXS
         rWIw==
X-Gm-Message-State: AGi0PuYH06vhpB1W/2k5Cq4Lt7twrELEJa1UyXGqmWv5RTHxGhqMoxbA
        TL9mwcTX99ZSEgj8blPYENE=
X-Google-Smtp-Source: APiQypIMyzaDRV5z1tsM4wU6bSV/e9vJp0+miBxi4ZwHlM8hR7zVO1QOnF+AQz/W4FVys/IDclnpZA==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr21725731wrt.103.1586117396216;
        Sun, 05 Apr 2020 13:09:56 -0700 (PDT)
Received: from localhost (catv-86-101-16-129.catv.broadband.hu. [86.101.16.129])
        by smtp.gmail.com with ESMTPSA id w81sm22001206wmg.19.2020.04.05.13.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2020 13:09:55 -0700 (PDT)
From:   bkil <b.K.il.h.u+tigbuh@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: update rules for US on 2.4/5G
Date:   Sun,  5 Apr 2020 22:09:42 +0200
Message-Id: <bd3095568bfcb9ee543cc1b2b68d22f5cd6e1c3c.1586117381.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bands are wider and more continuous:
5.15-5.35 GHz, 5.47-5.725 GHz and 5.725-5.85 GHz.
Based on the April 2, 2020 version of e-CFR Title 47 Part 15,
Radio Frequency Devices.

This also includes a small tweak for channel 144 similar to TW.

Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
---
 db.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 9c4b447..6096121 100644
--- a/db.txt
+++ b/db.txt
@@ -1556,13 +1556,19 @@ country UG: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
=20
+# https://www.ecfr.gov/cgi-bin/text-idx?SID=3Deed706a2c49fd9271106c3228b06=
15f3&mc=3Dtrue&node=3Dpt47.1.15&rgn=3Ddiv5
+# Title 47 Part 15 - Radio Frequency Devices, April 2, 2020
 country US: DFS-FCC
-	(2402 - 2472 @ 40), (30)
+	(2400 - 2483.5 @ 40), (30)
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
-	(5170 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (23), DFS
-	(5735 - 5835 @ 80), (30)
+	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
+	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
+	# requirements, we can extend the range by 5 MHz to make the kernel
+	# happy and be able to use channel 144.
+	(5470 - 5730 @ 160), (23), DFS
+	(5730 - 5850 @ 80), (30)
 	# 60g band
 	# reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-=
89A1.pdf
 	# channels 1-6 EIRP=3D40dBm(43dBm peak)
