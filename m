Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7E8469076
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 07:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhLFGtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 01:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhLFGtR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 01:49:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A5C0613F8
        for <linux-wireless@vger.kernel.org>; Sun,  5 Dec 2021 22:45:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np3so6945482pjb.4
        for <linux-wireless@vger.kernel.org>; Sun, 05 Dec 2021 22:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qzr+yh6ErGdeeC+7drzbTh2dtLMqeA3K9t8w3uHQOA=;
        b=P2PzKE2B/H1TpN+SacdNF6ALKvUiAzIa3Mi4o5f4F60k/pwqKUO2rqfQWWoBZsLx/p
         q/6Y/sSvnY8QftavUKA6/WsLR/LyjU6pW9tk/yILidiiwx/UvF2VR6aOhaCS43Hh3yIn
         LX64enc2leAR88QeFp5tmCfO+q2GNOVn3PoREKbSqO/GlTHp1wqDFvJTVhjBpZDbeURF
         /pdpXCR3SPBa+zZIirimOqve63se1AQ0GC3CsOEeJsePmjtRZFfN4ULz/RC35rQRc4sX
         0bo1DYRYXuwZy9yWNnwfWsM87PnQFKiDlkDssAeOkl/+L/YHj8zfKb6/qeuYLtelS0mc
         fazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2qzr+yh6ErGdeeC+7drzbTh2dtLMqeA3K9t8w3uHQOA=;
        b=E+wVQ2aNq3d3R+uiObJ/ZsbJ7Xq1rSPmd8LmJOVbmiCgnbhOrchdcnySRZRZ6WBSbT
         Nwuou4EagSOy1Tkkrhauv2KGXMctAEucylb/y+82MJ1Bm0abBmMrxhqza6+9ovNghqai
         /x95gEGjlCn+clFhXGTfFy4vsPRmC/MWEZYQ9jTiVnaVZlVrnyiG9G/DUKgeek9t9sM0
         Hva+zYYJKU9le1g6owL8dd+6wUHXkmkvwzwuuHykiOiJEPjviZzS4Q/9Xfmcx+Kjjor7
         ClY90gpvH+zXTx3ao8Fkng4ISHebAViOnS3qm7085UBxcFGJNG5tHN6OuFs3ELgpSDET
         RnuA==
X-Gm-Message-State: AOAM532H+JqtUkau7/8ZRyI0k1w4O5mvVt+f7Da5b9m0HZJTRzu8tyQq
        ZBpRIa3y8wz2YLdHXMZ+sY470Rr7aZw=
X-Google-Smtp-Source: ABdhPJxCNJsehXcVcXsg/yIrjmhhr3hM+KfAjGmqQ7mnmqWsX23VfJI8U9WyVIyX50VmqpT/xySh3A==
X-Received: by 2002:a17:902:e88f:b0:141:f982:777 with SMTP id w15-20020a170902e88f00b00141f9820777mr42774132plg.68.1638773148802;
        Sun, 05 Dec 2021 22:45:48 -0800 (PST)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id f185sm10810091pfg.39.2021.12.05.22.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 22:45:48 -0800 (PST)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] wireless-regdb: Raise DFS TX power limit to 250 mW (24 dBm) for the US
Date:   Sun,  5 Dec 2021 22:45:20 -0800
Message-Id: <20211206064520.11305-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

According to 47 CFR § 15.407(a)(2), the U-NII-2A (5.25-5.35 GHz) and
U-NII-2C (5.47-5.725 GHz) DFS bands are subject to the following [1]:
"For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conducted
 output power over the frequency bands of operation shall not exceed
 the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
 emission bandwidth in megahertz."

As such, increase the TX power limit for the U-NII-2A and U-NII-2C DFS
bands to 250 mW (24 dBm) to match the FCC's current rules. These power
limits have remained unchanged since the § 15.407 amendment by the FCC
in 2014 [2].

[1] https://www.ecfr.gov/current/title-47/chapter-I/subchapter-A/part-15/subpart-E/section-15.407#p-15.407(a)(2)
[2] https://www.federalregister.gov/d/2014-09279/p-131

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 db.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 6e8dbef..b898799 100644
--- a/db.txt
+++ b/db.txt
@@ -1596,12 +1596,12 @@ country US: DFS-FCC
 	(2400 - 2472 @ 40), (30)
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
+	(5250 - 5350 @ 80), (24), DFS, AUTO-BW
 	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
 	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
 	# requirements, we can extend the range by 5 MHz to make the kernel
 	# happy and be able to use channel 144.
-	(5470 - 5730 @ 160), (23), DFS
+	(5470 - 5730 @ 160), (24), DFS
 	(5730 - 5850 @ 80), (30), AUTO-BW
 	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
 	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
-- 
2.34.1

