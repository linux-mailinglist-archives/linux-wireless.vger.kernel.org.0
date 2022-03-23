Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435894E594A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344350AbiCWTnI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344334AbiCWTnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:43:08 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32108B6F5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:41:37 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-d4164acd34so2789742fac.4
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forshee.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CUKoQqqtzrjMgIuYVrIVsqW153Ub0tNPj/H249Q6ig=;
        b=FUK2t5UiH/LbhG0gnBokE7UeYtdE3PCNock02ICrHilTNWPQhDUE7rRKAu60Djit83
         1FGr84X/6FrdSrFaqBCMgx1AfTA6Ol96kw6Ul7R74QDh8rvoJ+UeMdEcSIf097Y2gUnp
         K0HKHystMRzFSWBt+HfEn+fkOZAIjjuzcoQZkYTRvT+OVYIkMSbvOu+piUARk9u+bS6K
         Bbx4eG/iUy+p6o7gwDeX0lUNk6WoUVRtvxe68hJid4X7nXAICFvLFef7hOzr9wzSrDEj
         co2BsPukhQ59j6e0WEmqpgLeBrekJeYHWKCV+PeLiOKXnIXZvbWrr0EyjObizFZmMoBO
         pNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CUKoQqqtzrjMgIuYVrIVsqW153Ub0tNPj/H249Q6ig=;
        b=fpNZgPTEQ4E8j+idI9X+UgjBbNr/vV4CxKx1cApZmTPruBo7Z1XSpZiaBJVQtCuNeh
         5/UpjJv/gZV4dllk/zxeHKYsGpWMCRpYF/jSZe9Bhzbd7GFLJrrPKJCQWe/5t7axDim7
         HKvmLSo13Ffq0AgfozE8LQyr8xEWm+iFHiQAoZepw72kcF56a+EcnH0Dp35UvzcQajbk
         GizGuK+d2S1A4YrXAwFrOaoJ9EOyrVtE0HCfDmnx6rXvDC+t08NR1Zta/emzR93SGKGL
         OTQJT456caMmSBSuR9OUaKar6mz4RVbd7G6L3Je3lxzZn2j3MaDfvomDhYtB6xUGKYwg
         n7Mg==
X-Gm-Message-State: AOAM5325eoZZhu/xbrfs/NXLdMrqmy9s07VDUaAUgRxrFpfR6zGMLdYp
        C83m7cLc9qukO4ZUk/q637wjy+d3jvEsZA==
X-Google-Smtp-Source: ABdhPJy/0eWpNEhcKMBMgvB26Tz1iKQhJ/yQ5omVMFFkbu9BuvpYBkQwFyiGuh+rIeQ2m070ghO7sw==
X-Received: by 2002:a05:6870:3509:b0:dd:b3d8:115d with SMTP id k9-20020a056870350900b000ddb3d8115dmr773824oah.151.1648064496921;
        Wed, 23 Mar 2022 12:41:36 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:1106:a97c:b0a4:146a])
        by smtp.gmail.com with ESMTPSA id k14-20020a056830168e00b005b22c20b195sm388565otr.45.2022.03.23.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:41:36 -0700 (PDT)
From:   Seth Forshee <seth@forshee.me>
X-Google-Original-From: Seth Forshee <sforshee@kernel.org>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: add missing spaces for US S1G rules
Date:   Wed, 23 Mar 2022 14:41:34 -0500
Message-Id: <20220323194134.169332-1-sforshee@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rules lack spaces in the frequency range definition, which works
find for building the database but causes problems for some external
parsers. Add the missing spaces.

Signed-off-by: Seth Forshee <sforshee@kernel.org>
---
 db.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index d45ec082e7c4..5f2168d21222 100644
--- a/db.txt
+++ b/db.txt
@@ -1619,11 +1619,11 @@ country UG: DFS-FCC
 # set out in 47 CFR § 15.205. TODO: reenable and specify a safe TX power here.
 country US: DFS-FCC
 	# S1G Channel 1-3
-	(902-904 @ 2), (30)
+	(902 - 904 @ 2), (30)
 	# S1G Channel 5-35
-	(904-920 @ 16), (30)
+	(904 - 920 @ 16), (30)
 	# S1G Channel 37-51
-	(920-928 @ 8), (30)
+	(920 - 928 @ 8), (30)
 	(2400 - 2472 @ 40), (30)
 	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
 	(5150 - 5250 @ 80), (23), AUTO-BW
-- 
2.32.0

