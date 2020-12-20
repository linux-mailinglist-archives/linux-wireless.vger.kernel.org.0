Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D42DF936
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgLUGWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 01:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgLUGWq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 01:22:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2465BC0613D3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Dec 2020 22:22:06 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m12so20971639lfo.7
        for <linux-wireless@vger.kernel.org>; Sun, 20 Dec 2020 22:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e3jNsq3iy3v40rws4mJ4ddje4NCepqN/jkGkUQj+WE=;
        b=IGyJLrwNPs7nGGEVHTQab82fiJjb6Idsp5s6IB1R4RaWfyeKeQXU9t3UEqBpVGkMZD
         qgXp8QFGBZ3P4HidQCrMOA6IrDOZQiKoA8xy8w43f/dCVFRQoNda8JDbNKiT4OS1zUso
         dfpbm6nrZJoavjjOduhKN7Cj1BFsZwkoYO53ksa94098xyxknJiiZSaXoskClm0PI5MJ
         dVlGOVXrB7FYjTROt6AVHUX5JzymRBThW1vAsfMgCeNZiraktIlK55yVSg49HUwOaKzR
         7SFMGDvetsBuUQS15b0Wn7HnkOsrIGe7fappaBw6Lgpf+mRr0yO43orO0ebtKm5OzlYt
         hSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e3jNsq3iy3v40rws4mJ4ddje4NCepqN/jkGkUQj+WE=;
        b=gdDBw41bkgTyYZtgZtUJpQiggM4UX0RHqmWjIbHc6WYJjkTo8wnE5Pcma89XizU+w1
         TmVlIG8rmF+Jkiy4MmUAcK4NhtzKRoZPbH31vNkwLHWTPbO3HwRnMNGM71SGbFV1/JSA
         CiSFRg6MgtyX50SdFXuAPwhlWDYeQ7NNKbirQOoVYjUjX5iNkTOA12LafvgLmM4OIePs
         ydVvsXqnwgvU/dUMhyMwgLCK11AmTT8n4L7zeXB9v22WwfChBML1HsJFPY0gNnTT5PbX
         F0Jv6LxjVHoT7KuzAUnIgyXmkWCeYu2Txtgg8V4wHcgRd02x6F2DDYP4paayGUDh+ytQ
         7WVA==
X-Gm-Message-State: AOAM532cDj/JBpmV46Anc0s38lvm1gqHeVInmUK4ScdWkuKMvy6qbwYm
        GBPlXn3Ui8coDuvqHhqx6mrgU42dbnCI8Opc
X-Google-Smtp-Source: ABdhPJzUdmxt16lAcpr3XIJgaS3ZNd1qmGeb8QjncFPHRIJmPJNAdv0Y5Q2WBJiq/hVrXME+Ecnimg==
X-Received: by 2002:a2e:b6d0:: with SMTP id m16mr5896530ljo.133.1608499681510;
        Sun, 20 Dec 2020 13:28:01 -0800 (PST)
Received: from 5550.lan (host-91-243-31-214.la.net.ua. [91.243.31.214])
        by smtp.googlemail.com with ESMTPSA id u6sm1777338lfl.64.2020.12.20.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 13:28:00 -0800 (PST)
From:   Illia Volochii <illia.volochii@gmail.com>
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Illia Volochii <illia.volochii@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Ukraine (UA)
Date:   Sun, 20 Dec 2020 23:27:21 +0200
Message-Id: <20201220212721.22450-1-illia.volochii@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is based on the latest Ukrainian norms https://zakon.rada.gov.ua/laws/show/z0201-15#n48.

* Extend some frequency ranges.
* Increase EIRP of frequency ranges.
* Set wmmrule=ETSI to frequency ranges that are related to EN 301 893.
* Permit outdoor usage of 2.4 GHz band channels.
* Prohibit outdoor usage of some 5 GHz band channels.

Signed-off-by: Illia Volochii <illia.volochii@gmail.com>
---
 db.txt | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/db.txt b/db.txt
index c71a03a..86073d2 100644
--- a/db.txt
+++ b/db.txt
@@ -1548,21 +1548,20 @@ country TZ:
 	(2402 - 2482 @ 40), (20)
 	(5735 - 5835 @ 80), (30)
 
-# Source:
-# #914 / 06 Sep 2007: http://www.ucrf.gov.ua/uk/doc/nkrz/1196068874
-# #1174 / 23 Oct 2008: http://www.nkrz.gov.ua/uk/activities/ruling/1225269361
-# (appendix 8)
-# Listed 5GHz range is a lowest common denominator for all related
-# rules in the referenced laws. Such a range is used because of
-# disputable definitions there.
+# Source: https://zakon.rada.gov.ua/laws/show/z0201-15#n48
+# Although it is allowed to use up to 250 mW for some 5 GHz frequency ranges,
+# all of them are limited to 100 mW for IEEE 802.11n and IEEE 802.11ac.
+# 2.4 GHz band channels can be used outdoors when some requirements are met.
+# 5 GHz band channels must be used only indoors in some cases. They are neither
+# permitted nor denied outdoors in others.
 country UA: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20), NO-OUTDOOR
-	(5150 - 5250 @ 80), (20), NO-OUTDOOR, AUTO-BW
-	(5250 - 5350 @ 80), (20), DFS, NO-OUTDOOR, AUTO-BW
-	(5490 - 5670 @ 160), (20), DFS
-	(5735 - 5835 @ 80), (20)
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (100 mW), DFS, NO-OUTDOOR, wmmrule=ETSI
+	(5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
-	(57000 - 66000 @ 2160), (40)
+	(57000 - 66000 @ 2160), (40 mW), NO-OUTDOOR
 
 country UG: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1

