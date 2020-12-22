Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B932E0EE4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgLVTY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 14:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgLVTY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 14:24:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2BC0613D3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 11:23:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so34575885lfr.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Dec 2020 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdK3bqAaXhjxbjLLRwmPmQtBbS0rf7DANa/y/ZggeCk=;
        b=kdOd5IiB1Z2MgmQWRcjh2+8TvWAzJDo7Anxi9haqDGpZIULAt/d5LclHWrENhmgBAS
         3Jerv2vzWsK647Ud2p7Fx/MsSQIGkkSxutblvgEpF8IQcV6xNY2qXmbceg074m+lieap
         WxLZ5DxfX8slhcyWcW1XQujyiHB6hq5zIYkagmL67z49b72i2T/07LWyNDazcMvIcGOX
         t31bxfdG2VQ3+4FSbMHRTDpHUAZA7Ez+sPkf+CCc2SGWUxcpxQ24nifwZSuqYHIPUZj7
         XiPoqbf/v1PBWRzQXhyN0YcWF0LrEeS4wghK5TVhscWtZO2+GG5nInlLzhGHRdkVxORF
         w3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdK3bqAaXhjxbjLLRwmPmQtBbS0rf7DANa/y/ZggeCk=;
        b=VNIJ1v4jdxQ5HkLiKy75GUZLS43AlPtRbOGmXZKDxE4E/2sF+sHCJKxz1qVG5zhvBS
         xonKv4zy5DZKSFigmS7ahyrPmxuNTLwc6+9u9IDli5QSbOW06+jkt3kmO9+jUuHBEXr6
         MpYnHKzz7iEF6u7ZD8YNXzE84x+HY7mFumv/sRBdDl6SoBOjlbdch3B4Zfy7eVwN7vJQ
         2zSLn3CE+/6XGCq8D+ZEuw2oo0dCwec6xkEjIVC09TXNUT+YncVtNteSX8iHBQCRTrn9
         kDRMTUZouv1PTHR4c8SF80SnzFXSGcJqAx77571u//7E1QpJf0PWgO435bFjzsPZU1tn
         tcSg==
X-Gm-Message-State: AOAM532HGA1zAyC0uk0F+VC35PRdUOyAp+R8EewSXbPixukHevCEFtTg
        894WqLC1zIM64HpjE46B3hozkninZfoumg==
X-Google-Smtp-Source: ABdhPJzipiaEGWhOO4q3O1iWDXBbTSrA2ub7S+UiBBX62pQfgvJpLcICskUZ+/PqXzlbwnpjl2YwqQ==
X-Received: by 2002:ac2:5e87:: with SMTP id b7mr8991703lfq.190.1608665027028;
        Tue, 22 Dec 2020 11:23:47 -0800 (PST)
Received: from 5550.lan (host-91-243-31-214.la.net.ua. [91.243.31.214])
        by smtp.googlemail.com with ESMTPSA id k8sm2772582lfk.187.2020.12.22.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 11:23:46 -0800 (PST)
From:   Illia Volochii <illia.volochii@gmail.com>
To:     illia.volochii@gmail.com
Cc:     linux-wireless@vger.kernel.org, seth.forshee@canonical.com,
        wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory rules for Ukraine (UA)
Date:   Tue, 22 Dec 2020 21:23:28 +0200
Message-Id: <20201222192329.56983-1-illia.volochii@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222191738.56240-1-illia.volochii@gmail.com>
References: <20201222191738.56240-1-illia.volochii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is based on the latest Ukrainian norms https://zakon.rada.gov.ua/laws/show/z0201-15#n48 and is an updated version of the one sent previously.

* Extend some frequency ranges.
* Provide some power limits in mW to be consistent with local norms.
* Decrease EIRP on 60 GHz band channels to 20 dbm.
* Set wmmrule=ETSI to frequency ranges that are related to EN 301 893.
* Permit outdoor usage of 2.4 GHz band channels.
* Prohibit outdoor usage of some 5 GHz and 60 GHz band channels.

Signed-off-by: Illia Volochii <illia.volochii@gmail.com>
---
 db.txt | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/db.txt b/db.txt
index c71a03a..be6edf0 100644
--- a/db.txt
+++ b/db.txt
@@ -1548,21 +1548,22 @@ country TZ:
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
+# Power limit units are the same as provided in the source (i.e., mW for
+# 2.4 and 5 GHz, dbm for 60 GHz).
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
+	(57000 - 66000 @ 2160), (20), NO-OUTDOOR
 
 country UG: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1

