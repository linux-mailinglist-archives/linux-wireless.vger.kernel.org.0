Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D56E357F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 08:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDPGq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 02:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 02:46:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21C4FB
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 23:46:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec817060cdso759516e87.3
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681627614; x=1684219614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kzjc0m3n/HBNEngFJPQreLN49X01EVyeWOqOYCCxE4=;
        b=akE6ALMsMvivugWKCDqVA3mT0Fbr25siLHjG3Ys0CIyRLsa5Jdf+7t3JelaN73XxL5
         029vkQP+wIpDLx3LqOz0GjHhgIvhLqWiBXePz/ifhbdarJWsoTHSN7166mE1yNzFIHHb
         Qry7zPVOF8ATmD1shRYm/wJZsEtQvRr4l18WFFvkEt6/yDbWjo35TNPLZEstypKVMOdA
         r+1w4GDpQ/jLXTlXoa6PihBXXKjjS+uZMi3cvgio3vSqOUZknDr/2PHq3zyPfhfEy0XW
         PZ7e4xs60XWxDa0toIV8G/+hkiBlcF4WY6x8E1ZwRkT9LYgMws4hfgL+0efZx37Q1FeE
         fiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681627614; x=1684219614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kzjc0m3n/HBNEngFJPQreLN49X01EVyeWOqOYCCxE4=;
        b=aRxoTJeGxreFYvXSd/3yw64wFVbSuRwfA+5b32SvoELOdChVYH7OLrxkcmDG9QOuEi
         LXdc2kVETP5hmKHmSG2e+v+n0uo7xlXGw9ozCG7KGE+raphXYvFtndDvdfd01LiywLpI
         lxpEp5OYiAkuMGIiEHnWyqeuLNFkB33ogCLI6AiVFmx3COD+V8tpMUnSSfWFwRxgC2MH
         fxWimAU0dTmkR6nvEXKOaUi1D3kVY/38T3vGgiKJIlEt1lSAVtx9msRwDDVfDf+ucRUV
         +8TtgvH7uYiegWiUlGkTCOpdRiJuJSw8sVASsqAAA0yPlnPUVuFIvrmFX1gyv1bHuoC5
         30Yw==
X-Gm-Message-State: AAQBX9edgFPd7BRPzkAcQkKdctA6oHSxwtvP9M+RCPuVG7lSnQ9x05TJ
        cbsnG72fW75zwL93Z0zKo/Q=
X-Google-Smtp-Source: AKy350Zk2uMHGl0271ahQzLNGjgue3/h+Bja2OuPO3J5C/W51ionoX1AkdoYZGWR/S06DWgqZGnQEQ==
X-Received: by 2002:ac2:5598:0:b0:4ea:e799:59f9 with SMTP id v24-20020ac25598000000b004eae79959f9mr1014303lfg.66.1681627613830;
        Sat, 15 Apr 2023 23:46:53 -0700 (PDT)
Received: from Pilot6.. (93-80-87-124.broadband.corbina.ru. [93.80.87.124])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512006c00b004db0a7ce483sm1583450lfo.162.2023.04.15.23.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 23:46:53 -0700 (PDT)
From:   Dmitry Tunin <hanipouspilot@gmail.com>
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Russia (RU). Remove DFS requirement.
Date:   Sun, 16 Apr 2023 09:46:48 +0300
Message-Id: <20230416064648.3227-1-hanipouspilot@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use of Wi-Fi devices are regulated by the Decision of the State Commission for Radio Frequencies
 under the Ministry of Communications of Russia of February 29, 2016 No. 16-36-03
 “On Amendments to the Decision of the State Committee for Radio Frequencies of May 7, 2007 No. 07-20-03-001
 “On the allocation of radio frequency bands to short-range devices »

https://www.garant.ru/products/ipo/prime/doc/71249926/

The document sets 100mW for 2.4 GHz and 200 mW for 5 GHz. The is also TPC requirement (see the footnote).
There is a special limitation 100mW for 5 GHz onboard aircraft.

DFS was never required in Russia.
Instead the authority chose to prohibit outdoor use for 5 GHz totally.

So we reduce power to 100 mW because of TPC on 5 GHz.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 db.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 915a3b9..6a05141 100644
--- a/db.txt
+++ b/db.txt
@@ -1501,11 +1501,10 @@ country RS: DFS-ETSI
 	(57000 - 66000 @ 2160), (40)
 
 # Source: https://docs.cntd.ru/document/902048009?section=text
-country RU: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
-	(5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
-	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
+country RU:
+	(2400 - 2483.5 @ 40), (100mW)
+	(5150 - 5350 @ 160), (200 mW), NO-OUTDOOR
+	(5650 - 5850 @ 160), (200 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country RW: DFS-FCC
-- 
2.34.1

