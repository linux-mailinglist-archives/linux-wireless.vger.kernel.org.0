Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEB53677F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 21:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbiE0Tby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiE0Tbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 15:31:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA2013C094
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 12:31:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so3593071otr.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taIZOP88c/8jIq0PRDOgEnC3ZWTsJa0UDOqT7eeY5Yg=;
        b=YRFCXRG49jC29R03e9OBlcn6gW/4DEM7tk/1almo1rWuH60lgOOPuKoiLSEU9qRVFS
         bAlfeT8KUkJ35UdpSzOZFqKkH+xFsGa5y6ww5Ag7gOibl8Q2wSPerwAhTJuUe7H1Xf64
         QYow/d+oLQpMjZB2cSsDI0kkEjPJrFe5q80tfiMNq+C4+eMpPCKD901mpxCgj6o77oES
         hHieDhiRZXL1lma7NETiygbwyz89TtJozS7p3pMOeu0CQLNy0WBZ8By3kLrW91wqy+re
         GeyUcSfQugPavwWd1z3jwTWYICxI5kZvjngookkRjpB7R1CYTQP71FzXk6lRFjnSxsk4
         lvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=taIZOP88c/8jIq0PRDOgEnC3ZWTsJa0UDOqT7eeY5Yg=;
        b=QmjPGCvvNMq8LG2g0/B2X+0HQFJDDy8kgHAWvYkJqptNfMEJOB4T+/8IYr08xBSQMG
         dKtp+WkNTqmoW9RjOtV2DPZh3cqPyoL86sqtxlcEjWKf8fMhjXdUMVMnz3Nj5I3wRCkb
         1AOu7cIUsFXGASb/39Lt64GFqRy2Bvq6NAMvKMVQ1xkk9ZATuaOn3F5Mw+C47oOFNL2p
         Kz8Tim7Qa8jdyaoGzpIRfi+90KyNSnYlfrIL/mCvFr26h98VVZJ11J/1mRJPTVO/Dppi
         Js1vU8ftqutU21kuBq9g0qo/PEz1BsNUYYWCzSv8taHe2AG3BxFxIibOr/SrQv9ay0ib
         w4+Q==
X-Gm-Message-State: AOAM533RwbI66X5CPA0jyKYdFDm6i+rbADkFjYgvZiVPRDbXhRW+mWVV
        g4qn/0u4iUPdzkZK2zYk5e0=
X-Google-Smtp-Source: ABdhPJyHCwsNWdRgZpvcDy0fPKsf67vLTbTAct19ftyLGc35aYQ6sQPPO+zjMgWhkz68y0jUdjFFtg==
X-Received: by 2002:a05:6830:1485:b0:60b:51d:436e with SMTP id s5-20020a056830148500b0060b051d436emr11852383otq.59.1653679910580;
        Fri, 27 May 2022 12:31:50 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:c968:d547:ede0:d371])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d590f000000b0060603221280sm2089462oth.80.2022.05.27.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:31:50 -0700 (PDT)
Sender: Seth Forshee <seth.forshee@gmail.com>
From:   Seth Forshee <seth@forshee.me>
X-Google-Original-From: Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Dennis Bland <dennis@dbperformance.com>
Subject: [PATCH] wireless-regdb: Remove AUTO-BW from 6 GHz rules
Date:   Fri, 27 May 2022 14:31:49 -0500
Message-Id: <20220527193149.127735-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No other bands are directly adjacent to this one, so AUTO-BW doesn't
make sense. Remove it, and also fix a nearby whitespace mistake found
while doing this update.

Cc: Dennis Bland <dennis@dbperformance.com>
Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/db.txt b/db.txt
index cf35883d1867..47850c051c9a 100644
--- a/db.txt
+++ b/db.txt
@@ -470,7 +470,7 @@ country DE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -558,7 +558,7 @@ country ES: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -582,8 +582,8 @@ country FI: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-        # 60 GHz band channels 1-4 (ETSI EN 302 567)
+	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country FM: DFS-FCC
@@ -607,7 +607,7 @@ country FR: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E low power indoor
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-6 (ETSI EN 302 567 v2.2.1)
 	(57000 - 71000 @ 2160), (40)
 
@@ -732,7 +732,7 @@ country HR: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1222,7 +1222,7 @@ country NL: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1242,7 +1242,7 @@ country NO: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.34.1

