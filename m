Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8747938E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfG2THh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 15:07:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43418 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfG2THh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 15:07:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so42836521lfm.10
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuQ1o03JrINX5QLqf5QHyyKPqrVTcHMbuNL5DOO9uX0=;
        b=cMgP5IO3NZbsaizYpn442MvKLS4pLwIKAJTm1EKa15ytCPkCJ3PC93SWWgna28H/jm
         P+1sM2749Miw4FwRwkNz7WqbnhOFRZou2fWq8tm/AOUv4ZMOriA0TDmM8MONf3BvhgC0
         mNLKBz8tswwWydBmPmD6JW060SmyRV2/8oepKVAUol9NMAA1MfWiqiiKjfZv7ftgr4uM
         pyz/wEsSUw723UJ+vowDDm1JDQceuM+aRC6iH7HQW069Vkaw7WY46bEb6hB0revwyTTS
         fpT6359wNzygp9fF4Uyp1uWPuDzSKLslLJDUg4K72tjm89dMvJOMqUJZwXr95j7RB7e7
         ImBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuQ1o03JrINX5QLqf5QHyyKPqrVTcHMbuNL5DOO9uX0=;
        b=lyhoJ+FU7N4h6iFmrS1pyWzp2AJMYr2PLtvv6mDFtQ2HC0h3ZIAZOcDf09kTZsRQhP
         lpa0gqpfQhukL3akMhD0JsNgsb6saPfWRyiXPuAzPmnq3hx+866FZJxIcCCtNPV+CpsY
         ZUqacOPORqaxtj+YmGKK3jOoFBqt/OUoJ3hRCYMiW6t1L/LX/YJZsejabt2S1gcpz4iN
         9s0y381AdkrEDa9DAIw6oMsjtNbDiGxkuyOHdGrbiX4ASTraOze8BxAt8tfp+rB5rier
         4gEw8wsIRLx00CDiBQcDK3/qrjwKGZCodu9aaqsj7BvcWZ37PjNNLvFIbi5xHYkC6eCr
         ljZw==
X-Gm-Message-State: APjAAAVZDqFXl9HSzSzMwBt/+4xrhr0E0niQ5fcmeEP1o16zpnoEwX8Q
        lxYW/tLCbYdTyqtPw4fACSo=
X-Google-Smtp-Source: APXvYqydXOnfyRoM9gITUKpF6esyPYLqkfxAdjQXZUflu1r3r3Dae4DnZ4pWn5AeO93w7wuiqvSsBg==
X-Received: by 2002:a19:f703:: with SMTP id z3mr52359464lfe.171.1564427255537;
        Mon, 29 Jul 2019 12:07:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:dc6e:0:c4ca:724:d773:277d])
        by smtp.gmail.com with ESMTPSA id j90sm12995429ljb.29.2019.07.29.12.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 12:07:35 -0700 (PDT)
From:   Dmitry Tunin <hanipouspilot@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH v2] wireless-regdb: update regulatory rules for Russia (RU) on 5GHz
Date:   Mon, 29 Jul 2019 22:07:26 +0300
Message-Id: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com>
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
 db.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index 37393e6..d95ed5e 100644
--- a/db.txt
+++ b/db.txt
@@ -1097,14 +1097,12 @@ country RS: DFS-ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-country RU: DFS-ETSI
+country RU:
 	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5650 - 5730 @ 80), (30), DFS
-	(5735 - 5835 @ 80), (30)
+	(5170 - 5350 @ 160), (23), NO-OUTDOOR
+	(5650 - 5850 @ 160), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
-	(57000 - 66000 @ 2160), (40)
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country RW: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.7.4

