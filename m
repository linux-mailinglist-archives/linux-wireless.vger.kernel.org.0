Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51266600572
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 04:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiJQCwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Oct 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiJQCwS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Oct 2022 22:52:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F5474EF
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 19:52:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 3so9870932pfw.4
        for <linux-wireless@vger.kernel.org>; Sun, 16 Oct 2022 19:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGZZN/AFG+E18FjNDFSOY1MKkkaUhFr7pWLXHYisKfo=;
        b=P6aCAof3fj2iynKF+R9vQd+vgVwQQmVQrx7UF42pcPIft0qYAZbNw8nD2jODEnDei5
         5mxgmIVJxvdVFDHSFmL3gDgXu0lfAxTMovhSznDUdf9nk7WF8NnrCwweLfTcYfQUPfvQ
         CmD2vcylbznoxhZHznIh+VoLbe62rYdl0Zl7UesaZ4Er8cDCPmL8eKt5HhV7hd5CWNoA
         EwrxDXF62I6lF+j8SVuZ7HVYHZEppO2BLiUJ3iAgfOKK8hMdro5RzMfk+yrFOqMzzLc0
         JaHp4ROqsa91kL6KfwNYZA4Ttzyzz8u5plQFIjV1d/ySKcy9uPiIO5H60ONldGojNfSG
         S2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGZZN/AFG+E18FjNDFSOY1MKkkaUhFr7pWLXHYisKfo=;
        b=VJTpafXi4bD0qBzg1BVmYzV0nlF57ZxflsQpQ3AZHlHTeoM+RXiakUDKA/hgSid73U
         hvYPqwglqa3Sj8Q8RSzQME4UbNcLcyYR4HDJV5we7r0QtphHe8IboXl6MiNLeKaFgJDi
         k4C33C096/8HOuzWoV43UFL4K/ULC/JFgXTOC2VGa/htLxal60W+GR0aQCo9rO8Q65lS
         lV8PQ4r9KG1Lwd6eQAUBJuJJIHtvVBP+j8PKY+/FaGmWBJtwn9P7aXks7UkVv0FJoKsm
         byScEjp8xfLK4Euzbu4KmBYxdV6dXgGPVKJCHiyFV+nH0uTs7tgPSWrPzz73UzlID001
         M+0A==
X-Gm-Message-State: ACrzQf2O18r8KG1/RlKpddIX3L/GJ9ygYY/MODmnG02Q1ON/uPRC94YN
        S3VUeywCHKVMrJe51rR8B6PMKkHnG8iakQ==
X-Google-Smtp-Source: AMsMyM5opIAgAZPSlWoemFjeMKCkiT+pDRl6sktzppu9RXOGuk998XlOmfnoWiVX2V2wtV6BM25Vpw==
X-Received: by 2002:a63:5b58:0:b0:452:2ba4:f86b with SMTP id l24-20020a635b58000000b004522ba4f86bmr8580293pgm.223.1665975136135;
        Sun, 16 Oct 2022 19:52:16 -0700 (PDT)
Received: from nuc11atkpe.usen.ad.jp (113x34x39x75.ap113.ftth.ucom.ne.jp. [113.34.39.75])
        by smtp.gmail.com with ESMTPSA id i31-20020a17090a3da200b0020ad7678ba0sm5131887pjc.3.2022.10.16.19.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:52:15 -0700 (PDT)
From:   CaffeeLake <pascalcoffeelake@gmail.com>
X-Google-Original-From: CaffeeLake <PascalCoffeeLake@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        CaffeeLake <PascalCoffeeLake@gmail.com>
Subject: wireless-regdb: Update regulatory rules for Japan (JP) on 5GHz
Date:   Mon, 17 Oct 2022 11:52:04 +0900
Message-Id: <20221017025204.1370004-1-PascalCoffeeLake@gmail.com>
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

Support 144ch for JP Region.

The Ministry of Internal Affairs and Communications has approved 144ch in Japan.

Source: https://www.soumu.go.jp/main_content/000635492.pdf

Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>
---
 db.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 012824f..8b3827a 100644
--- a/db.txt
+++ b/db.txt
@@ -907,13 +907,15 @@ country JO: DFS-JP
 	(5170 - 5250 @ 80), (23)
 	(5735 - 5835 @ 80), (23)

+# Source:
+# https://www.soumu.go.jp/main_content/000635492.pdf
 country JP: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(2474 - 2494 @ 20), (20), NO-OFDM
 	(4910 - 4990 @ 40), (23)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5490 - 5710 @ 160), (23), DFS
+	(5490 - 5730 @ 160), (23), DFS
 	# 60 GHz band channels 2-4 at 10mW,
 	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
 	(57000 - 66000 @ 2160), (10 mW)
--
2.37.3

