Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687D4E8E28
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 08:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiC1G1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiC1G1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 02:27:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDA527C2
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 23:25:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f3so10442454pfe.2
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HCUS1XD9Y9CKN2kQWAX+DXJBDXsDCawO6AGnd0cclU=;
        b=Hqytv7IFwuXR+z/zuUbNN+kAIRbGZDbh0V9jHtaIQcTHDYw3FO+Nkde4JNUepwyAP/
         IzmzaWAZSS9ftQB6FmKWSEUw/DTBRwRkmLMdvt3J3v0VrUEag9CCevDPJCZCT2szkjy9
         MqhC19YjuIPAzQJRE71xwXyB9ScCDB1TjGumgy7+RDN9SveyN6EVnDv7OujxizhfklSc
         c28lpDyUJ7e11gchDYr7ffJ3LOyvk8+2l+U2WaAmknRrYgqLln7tQ8d+tBVGnEXmrsXP
         1NDglVUbVQ3JofnnlxHutYHwpwNv2EN7VXW3yIDvRmTSjLQyjjQfGmGYPoeEv1i3ROZp
         Sglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HCUS1XD9Y9CKN2kQWAX+DXJBDXsDCawO6AGnd0cclU=;
        b=CciHv9Y8wwtW/0ugZ5YGuL2EphslNilX9CUA2YuztBCyb37O9kvkay6hGviUNHJvmx
         9Av7M008C4u7iHiWSggaZtcoEZhCPjSRuSnX+Rq3EWOu0SiCKflXMGGnP24L0ApZHrP9
         RJbC1TUcT18Y6ZxdO4E7bgoa1NgUBo74Nqmb8r/KPzjHOLa41KTGg41DJ+6vc0X2IJ2M
         zBGTTQr6WE/6So6BL9KO9s7oiFv4VhoN/zwuV+uTL98OxbqC5e3S75qTY/FEzDxgbcyQ
         met28XsKLEy1PuuLyepOlBqYovqDUjL40Xj8Xe8uOl/yh9qutxxNiD1MTcjhjpL3B53Z
         Hdng==
X-Gm-Message-State: AOAM532WAkwnBcwMbRmYNbobS7+xLXm6s4J7vsnYk7m21nrioIX8ktLw
        Qyl8kXJptfK2J4yqqxxJ5TM=
X-Google-Smtp-Source: ABdhPJw71bqFIOQ2NPYdZRkzX/UDeuxPuBir5InwH2Ba6O0arOZWp4C5VVuzhCQrJI/Fi8uW60oW7w==
X-Received: by 2002:aa7:82d9:0:b0:4fa:2c7f:41e with SMTP id f25-20020aa782d9000000b004fa2c7f041emr22175770pfn.1.1648448703868;
        Sun, 27 Mar 2022 23:25:03 -0700 (PDT)
Received: from localhost.localdomain (2403-5806-8049--9c5.ip6.aussiebb.net. [2403:5806:8049::9c5])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00170d00b004fb1450229bsm10806396pfc.16.2022.03.27.23.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 23:25:03 -0700 (PDT)
From:   Richard Huynh <voxlympha@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Richard Huynh <voxlympha@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Australia (AU)
Date:   Mon, 28 Mar 2022 17:22:51 +1100
Message-Id: <20220328062250.15903-1-voxlympha@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changes allowing lower portion of WiFi 6E spectrum. (5925-6425)

Amendment: https://www.legislation.gov.au/Details/F2022L00249
Full text: https://www.legislation.gov.au/Details/F2022C00281

Allows for both 250mW EIRP indoors or 25mW outdoors.
However, only the former limit is defined in this commit.

Signed-off-by: Richard Huynh <voxlympha@gmail.com>
---
 db.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index e887c73..15de29f 100644
--- a/db.txt
+++ b/db.txt
@@ -121,7 +121,7 @@ country AT: DFS-ETSI
 	(57000 - 66000 @ 2160), (40)
 
 # Source:
-# https://www.legislation.gov.au/Details/F2016C00432
+# https://www.legislation.gov.au/Details/F2022C00281
 # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
 # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
 # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
@@ -133,6 +133,7 @@ country AU: DFS-ETSI
 	(5470 - 5600 @ 80), (27), DFS
 	(5650 - 5730 @ 80), (27), DFS
 	(5730 - 5850 @ 80), (36)
+	(5925 - 6425 @ 160), (24), NO-OUTDOOR, AUTO-BW
 	(57000 - 66000 @ 2160), (43), NO-OUTDOOR
 
 country AW: DFS-ETSI
-- 
2.35.1

