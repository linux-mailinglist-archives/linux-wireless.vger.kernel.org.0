Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66826612A48
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 12:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJ3LGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3LGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 07:06:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D61031
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 04:06:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so13619951pjk.2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/J6k02TVORFNXB/Iha8H3DzOddnGAfqUw1Md3lKKnLo=;
        b=qtMGzOnm/UKmznDAjA7+mmgiwpPUtRT2LB/OU6bHDXdrulr/2Aei0oVOEmScqCb6Dp
         rlHQ2VyjzLQkR8cJL0zuCt/Vh6qIgYxoQv8zyTpq6ThMdjNAYGoJU+tSosdVPXM0AXO6
         8ms0uspPWxhzZCKr8+Q7O+sSi+bEv9eaWtBEzD08TziGbhGN2wU72krBKcNtbqKSuPBT
         EGnYCs6uTL+D8a2Ypnu6xNUQBC6hjWDlkO9Yc5L8yVVD+YrNA2+G7yoeooqxOArftV6S
         vQDZ0yl0Ilbnp1wnzucYXDFPQh6cbZrUnBxuVBw9Rne2Z8sXEJaaZBE53NXdXXZApCof
         sC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/J6k02TVORFNXB/Iha8H3DzOddnGAfqUw1Md3lKKnLo=;
        b=J5ifCA1r++EdYPKvz346ag3KvHA2lx3xKlaV1AhLvTex5OHvTNdutoqEjbO92cn8So
         WAR7m5QmpkW9LYFRpTqT+p8VeyfDSpdA+zzX8g8ZAYUudOGfmiD9GoIgDrvBF2wLnhIR
         w2ubNN1ec7JrmSpHoVyIi/OAQpryEUdf5tYk2sRomw/Gvm/3e1Vh2OL7sF/kfwApWFfR
         eaSE0StxboUziZG7Ao4f2CKNCO8vkMcxy6W/sZgfbENgFWOhXP3gVPsF7KlBIUF8Z7O7
         lRMdeG0uikZMIl+QkmUdoFB4F9DCJI+PqIGZuIY7GRbyYTT1FOGkKm1Toyyl1hn1p+tZ
         98tw==
X-Gm-Message-State: ACrzQf3Ep9mfG0jgEv9NLM4jK80xlP3AOGeckHpiqXwOeVnbXbYfyiK5
        bgb7M4ncFrXno8tBonPUbSo=
X-Google-Smtp-Source: AMsMyM6NhuElBfqS68HCPZuzFC92G/2tnu9F2J5xR5pP1YVCiOCRDTBFkIiVuVfY6vIuSny4b3bXJg==
X-Received: by 2002:a17:90a:1a43:b0:20a:ea98:b962 with SMTP id 3-20020a17090a1a4300b0020aea98b962mr26528826pjl.118.1667127981990;
        Sun, 30 Oct 2022 04:06:21 -0700 (PDT)
Received: from nuc11atkpe.. (113x34x39x75.ap113.ftth.ucom.ne.jp. [113.34.39.75])
        by smtp.gmail.com with ESMTPSA id a19-20020aa79713000000b0056bc1a41209sm2461980pfg.33.2022.10.30.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 04:06:21 -0700 (PDT)
From:   CaffeeLake <pascalcoffeelake@gmail.com>
X-Google-Original-From: CaffeeLake <PascalCoffeeLake@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        CaffeeLake <PascalCoffeeLake@gmail.com>
Subject: wireless-regdb: Update regulatory rules for Japan (JP) on 6GHz
Date:   Sun, 30 Oct 2022 20:05:10 +0900
Message-Id: <20221030110510.752996-1-PascalCoffeeLake@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support 6GHz for JP Region.

The Ministry of Internal Affairs and Communications has approved 6GHz (5925 - 6425 MHz) in Japan.

Source: https://www.soumu.go.jp/main_content/000833682.pdf

Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 012824f..96527c9 100644
--- a/db.txt
+++ b/db.txt
@@ -907,6 +907,8 @@ country JO: DFS-JP
 	(5170 - 5250 @ 80), (23)
 	(5735 - 5835 @ 80), (23)

+# Source:
+# https://www.soumu.go.jp/main_content/000833682.pdf
 country JP: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(2474 - 2494 @ 20), (20), NO-OFDM
@@ -914,6 +916,7 @@ country JP: DFS-JP
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (23), DFS
+	(5925 - 6425 @ 160), (200 mW), NO-OUTDOOR
 	# 60 GHz band channels 2-4 at 10mW,
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
--
2.37.3

