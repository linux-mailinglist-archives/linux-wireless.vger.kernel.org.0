Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786789BC9B
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2019 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfHXIsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Aug 2019 04:48:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXIsX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Aug 2019 04:48:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so8772162lfk.12;
        Sat, 24 Aug 2019 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAKYmNodOYsJUt+/MXg5I2xorFlQfQabnP3uXvypvqA=;
        b=aZFlho9Tmkpszrem/8A+w4JrJz68CTR2RUcH77gMLSO9wzg3tHKqmdiikXBaNf1PIz
         4srPV2br76qdV+xgwGTWY79CRKEvNS6q6sogZQZdoug9+KUWmdu5NRVbiceWOIUsRuO+
         fqiYCg+A9tYdZ66U136zJTVBGCZdvYBfc07+5nCvHiaIv5CavKIrqSBJl56Ti58IjY2P
         AgmUqwbJB/d/UR33zpHefZuXOaoHE8hNhiOiJE1YBQ+L1JR7SW4LDxRjyYlEN0N9AFZJ
         NBy5PBFCJX5NsHhcmQFAyDILvFwjB49VFmb82VfdcojkQM83XfDKSIXeAkaATPQd16Bv
         yNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAKYmNodOYsJUt+/MXg5I2xorFlQfQabnP3uXvypvqA=;
        b=KVkLhExjmaZwhkZbCV3Q997YO7wBopl1CimkRhzJ7eAlVO6cTvvQRuZMDdxeakjAeK
         bGlVd9Hr6+ezB/M4BsrM1Xhisb7tGiL3Zzv5UJqvKZgkikzCbCUmb5L7xAKKi1vGTLvH
         65M6C2nJBVNNCGdlHcyQY5znxzIqLIiLDAUUspGvjDBuuvXasoeznKTNBJEFbNNkf/tH
         rRZjVs1jv3NWAzzCgZGiFn1rDKT6iTB66AYAZV1U9CvQt82awiyRu5Sfl6AvFdvNEqOu
         Nrb/fvhMJk/0WVruzzNQsOeHLSWC6db7qm5Q+rpKqUn5XFa4lnOWUQSXs3hEWN0heOWR
         D5/w==
X-Gm-Message-State: APjAAAWdUOCA/2e/pVpAO9PDH40hF/11QfPLt1sYOmg8oz7DwdIIBxDR
        NqQjn6ogmmZ4dAReIXO37iI=
X-Google-Smtp-Source: APXvYqx79f5q4WxtprT/3spGqQLaUKwprKNhE9/G/BtOYL6UuJjzDwQtYX+b1Zh0JRtpRUSYk8ZN1g==
X-Received: by 2002:ac2:558a:: with SMTP id v10mr1327282lfg.162.1566636500662;
        Sat, 24 Aug 2019 01:48:20 -0700 (PDT)
Received: from natasha-samsung.lan ([31.173.82.37])
        by smtp.gmail.com with ESMTPSA id p5sm1007948lfk.95.2019.08.24.01.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 01:48:19 -0700 (PDT)
From:   Dmitry Tunin <hanipouspilot@gmail.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH v3] Russian entry is incorrect. According to the last regulations document of Feb 29, 2016, 160 MHz channels and 802.11ad are allowed.
Date:   Sat, 24 Aug 2019 11:48:10 +0300
Message-Id: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf

Note that there was never a DFS requirement in Russia, but always was
NO-OUTDOOR on 5GHz.
Maximum power is 200mW that is ~23dBm on all 5GHz channels.
Also Russia has never been regulated by ETSI.

EIRP has been reduced by 4dBm because of TPC requirement.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 db.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/db.txt b/db.txt
index 37393e6..9e4dc27 100644
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
+country RU:
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5350 @ 160), (20), NO-OUTDOOR
+	(5650 - 5850 @ 160), (20), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
-	(57000 - 66000 @ 2160), (40)
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country RW: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.7.4

