Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C8763F73
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGZTXE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGZTWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 15:22:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF61271C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:22:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e0213c0bso171913b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690399370; x=1691004170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CBmR4yWSUiguiE7O6QA/p1IdBkA3XhGpXHwJgerUEQ=;
        b=l0s2bdogF/ulmv67NAoA2CMWMyKmdrObXgRhPfalZU2+gK6FHVIYSKsyPnZCsktliW
         iKi4kt37tj2wV9eZC6I7wqXODLvKacOpZJLViqIKPZk8RLiGcQJJJf2uVV+uOPZVPa0Q
         SiiWfY47HkBt3en9a8qXt5xhkiBilulrYan25xgowSQinCaRuh3xxZzj942U2/XRKCL9
         O6An4Q/bePxCuvkkHMs3ETLWbV0da3LU5EunV3GHwllxIrWDH73iWsQQ9Xzg1mzw8szR
         2Wwecqm0PlgQIaTLrin4ggEfCHAhUNCzYHbJ4TewiGMk5iKsZ6Hq2y6PtTskmq24lygL
         s9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399370; x=1691004170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CBmR4yWSUiguiE7O6QA/p1IdBkA3XhGpXHwJgerUEQ=;
        b=JlZUR2DZpkzS8ErfzjOIEiA9SjyCnF92ilpMUj+xi8SAaZkGcHMymNcempTnGmTZRJ
         f+BdkKfwHnbPqFwAQoSJ1PO3S7K1Nl13mUBK48qajAjtqn7jzi3+C8qfB+6T70Mm7Kdv
         huTV4kQlOizlfz5HeSnHG/MXA0Uu2wX1Perlujvg+Tz1lwr4KOJQTsAjdEFSvVq9WWBx
         zEb14AywTpWi3XXUgO2tmAnWr6VBZiK5P4hyIJ19Et6NWGW37x8KHcEdhvYk50U54gcc
         E9V4eut75SCgIxB7F2lpM2xiAHtf0SIRCL+mvIY/6Iv0DsNsE/shGS1hKaF+0KlXoBLE
         JS+w==
X-Gm-Message-State: ABy/qLY3gPRDHAyZTH4vLBJqT+blTcYBE2V97scNP4PNz+hixujotidy
        /sWKEzSWDm33/AxBuHVlU0R8MkWZkrQ=
X-Google-Smtp-Source: APBJJlFkxyvb4wouwruXVT5552N9CzHb3E3/7j82WKrtbOlaDjrH1hRRz2ecQoszH+BCOPcK647/hA==
X-Received: by 2002:a05:6a20:3950:b0:137:3224:16c1 with SMTP id r16-20020a056a20395000b00137322416c1mr2934132pzg.45.1690399369691;
        Wed, 26 Jul 2023 12:22:49 -0700 (PDT)
Received: from smtp.gmail.com ([49.205.252.170])
        by smtp.gmail.com with ESMTPSA id i73-20020a636d4c000000b00553d42a7cb5sm667741pgc.68.2023.07.26.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:22:49 -0700 (PDT)
From:   Chaitanya Tata <chaitanya.mgit@gmail.com>
X-Google-Original-From: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH] iw: connect: Fix segfault during open authentication
Date:   Thu, 27 Jul 2023 00:52:45 +0530
Message-Id: <20230726192245.100897-1-Chaitanya.Tata@nordicsemi.no>
X-Mailer: git-send-email 2.34.1
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

The check for remaining arguments is done after decrement effectively
bypassing the non-zero check and causes a segfault with below command:

  "connect <SSID> auth open/shared".

Signed-off-by: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index e5b177f..33e1a5f 100644
--- a/connect.c
+++ b/connect.c
@@ -77,6 +77,9 @@ static int iw_conn(struct nl80211_state *state,
 	if (argc && strcmp(*argv, "key") != 0 && strcmp(*argv, "keys") != 0)
 		return 1;
 
+	if (!argc)
+		return 0;
+
 	argv++;
 	argc--;
 
-- 
2.34.1

