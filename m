Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529414D6281
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 14:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiCKNjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 08:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiCKNjG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 08:39:06 -0500
X-Greylist: delayed 246 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 05:38:01 PST
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB74131977
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647005879;
        bh=bTn0Ulrz1PQ04aZp3KYT1ZbdN3Em8ZHmDvX4IptqKIA=;
        h=From:To:Cc:Subject:Date;
        b=V+Lh1adWvuTCwLAymZ0iCaDIkSf7jPIn7FxNqZ1ZOYg6ZJHnuVOldqBclzB+GUo1I
         xoSBgZeCP/ni/aGiME2gULghw4kvLovcpPLmB82zEExLrhvfuMrkIfBIwRQ69UQYFb
         tW/0PYht/tK46HK3m0aAxonRocGPQ8JE1jXuMRlo=
Received: from localhost.localdomain ([111.193.130.237])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 7A23AC16; Fri, 11 Mar 2022 21:30:34 +0800
X-QQ-mid: xmsmtpt1647005434trceabbcx
Message-ID: <tencent_1874B4BE714648459A63EC78424E87226609@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3eY2YdsC3TvfVGl3GnM3yMcgSDH/07jHGutvo3g8ZCALMEU/XMO
         ZjF7nrDW8jheSQjJ2w/TSCNYAmSZXCgjY963EzA/+1NRrb9oETIsW5j1++jCvJTqgCc8juDEwsXn
         rM76NBMNY6LTZ5v+KtEGvvMZoqS7eohHdncX9N9tekepovDmR8U3Me3aRfFs9hyJ2KQBf9LblsKL
         vxf7XbvCYkJ5+BqCervf8d8tLvbUg75R6N5QKqL+8tELAGT76gax7Q6xClfYC0ZxUQ2Jx8XLHRAr
         RUzpvSe63XELxz2IxraPIEF7Zp2djgLNWlDLMTg84K11LNcHPbkbRrafiQT9GoijATH2cCYq0mWr
         cqv97kxun/u5DabOM2yAG+YyVnSXt2wcxXuWxmfYBcjpUHHE6glf+k1C23sbhdlETIKW4T6yZIWJ
         N6wpPZDRZd3GdEMWjsXrmgJHcgbjcoTbcx2G77Nrhw2bNadF+P8ckfD34C2aPpuHDRUtVpYnttlF
         9VIKR7QWjSoValqKhCuv1vZRdF4G6QZJa/R/P1HsJUGaAStmEEWl7BJTGxd4UV4QMfi+xIvcCleZ
         ZfrQ6HHy8e79bemxgClvnsFYlnheBBBPulP3AhILyEL4HzK/TNI1gsUZzCKhH284EJuQUbVSKokL
         WkLM0k2Gswjx6XO1TyMY+641RFyHNEbgAyTS5HFXtTdGyHFXAac5LPbbqtcFYpWvLnOPcgnmHRu2
         cPxG/FZzRwVqg93+elPoi7aZKvp9FrOWD7l6Oer4LsZiNJrOikq1qc4jsKZE6u7C6QA6b7vec+fQ
         McGwJh3g6q9MgVBIFgrIJJiZ7zHQ7aoHxR2/uQrqJ5Oxq5Je/UQWbFNM2uCO1j3juw1W1FQGqlmO
         C1LyzjaROuAov8uu90PdZHqc328OXEWg==
From:   Weiguo Li <liwg06@foxmail.com>
To:     igor.mitsyanko.os@quantenna.com
Cc:     kvalo@codeaurora.org, geomatsi@gmail.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] qtnfmac: fix null check
Date:   Fri, 11 Mar 2022 21:30:33 +0800
X-OQ-MSGID: <20220311133033.258241-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We did a null check after "mac_info->if_comb = kcalloc(...)", but we checked
"mac->macinfo.if_comb" instead of "mac_info->if_comb".

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index c68563c83098..e4271405b997 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1256,7 +1256,7 @@ qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 				    sizeof(*mac->macinfo.if_comb),
 				    GFP_KERNEL);
 
-	if (!mac->macinfo.if_comb)
+	if (!mac_info->if_comb)
 		return -ENOMEM;
 
 	return 0;
-- 
2.25.1

