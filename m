Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A84EE692
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 05:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiDADN2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 23:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiDADNY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 23:13:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE81B30A3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 20:11:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t2so1376137pfj.10
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 20:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeDQ4zgJLHyjCHgAOp4dtUhvH7HBlcHTmr4EQRu/8po=;
        b=EpVaeFRWYYMqYfUaRd2yiEFkqfxs5Fglx1vyi8nYaNbgmjDrONPElFZfrLu5Ln7G+0
         wjO4aSXSEcp+ka0cxzqRt1hNcFXXpHoNNcBHpHlqcdIln4Xl6kDK7zwTzL43dK8C/sxI
         z7i5tZOcDlkofPK+yfaGCpZZvSwD/HIzeXda3sLZOEGejtWc3101eXsqnxy4LSauGvM2
         jd8nKHkZU59I57dVW0IqNoKG9G6YkddUYNVARS/eRJKHxQokKyZO7+kLOLXd+YcuSmLX
         8qbm1+fWeAenYpWsCsMrL5PUDlvP9FOrBuFc2EnH55HSviowu0/jNkTYtUuCARfa58gU
         x2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeDQ4zgJLHyjCHgAOp4dtUhvH7HBlcHTmr4EQRu/8po=;
        b=Dug5zmkZvSGkwb0qZMG1EhLuXb0G5aOgWIB9v6R+qA1/U1kZ5J3dAjoqxQ801v2P4n
         cDxz6s7qs8h1VjmBGrxH3wddq71SW7JGHlz918P92szoOcUUQdXoyiHjpeBVNz1dfwLC
         dCYlUzE7yyUKCeJn5xpx8AQf1FFFn8rgnqvy/ViHWvoumuXN5xt8Jjde8O6JGNVFb10S
         MrmYtVJa6EDNZfVtBSVjO9/GljzcbyrsV9P3G7r6/uGU4A8GqWMd93RwxuOGWLh+aRbx
         M49QF1ssVUnsQJm9t32RWEmsf4YAsoSCwHJfH5gPN3LvGp1C7iYdBL0wJKGstgT9lClN
         lPBw==
X-Gm-Message-State: AOAM532+gjHnQsCZSTKFXINicX/UD/P2o445brC5x/IaP+kvVBtmM769
        cS0zMsX+tvtdU/syrDhg7Ik3MKTcxmSDXg==
X-Google-Smtp-Source: ABdhPJyynXOZOkC5KSNv5nHXth4+2sXY/l5Y5M5Bqc3b4dt9o8EbssLufJ0UvSj+Wzq2oQLo9C5f/w==
X-Received: by 2002:a65:41c3:0:b0:363:5711:e234 with SMTP id b3-20020a6541c3000000b003635711e234mr13320045pgq.386.1648782695587;
        Thu, 31 Mar 2022 20:11:35 -0700 (PDT)
Received: from localhost.localdomain (2403-5806-8049--9c5.ip6.aussiebb.net. [2403:5806:8049::9c5])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm903406pfu.56.2022.03.31.20.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 20:11:34 -0700 (PDT)
From:   Richard Huynh <voxlympha@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Richard Huynh <voxlympha@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Australia (AU)
Date:   Fri,  1 Apr 2022 14:11:16 +1100
Message-Id: <20220401031116.2195-1-voxlympha@gmail.com>
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
index e887c73..a820ec8 100644
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
+	(5925 - 6425 @ 160), (24), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (43), NO-OUTDOOR
 
 country AW: DFS-ETSI
-- 
2.35.1

