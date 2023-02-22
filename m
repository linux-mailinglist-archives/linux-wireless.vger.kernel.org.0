Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4969FD33
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjBVUuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 15:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBVUuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 15:50:16 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AB526CEC
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:50:15 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1723ab0375eso7259456fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bbkki67Asub00CoMWXZQkStJ/TI4GpjlH8uEJFsaihI=;
        b=QqbWYbmEHUVORP5xLFx85xhTiMbxaMmFAmgyJQX1eLqrawunSGMHZlMJrOmIm85k3B
         iLe3zN+M+5t/q8s7347lP1pqwGMXhI31bXnNU3NrpZa83GhPqwfUu6P2MUXK1TuwkEQh
         o1E/lbdd1PgE6HaMs1JlxadYGdj+esoYuwlc77mPiA5NjiMmh9hHZrPueZHBV7KaEuhN
         xaYQT8MAQLw/g1bCQPsDWewc8uqVwOud2m37IsLq3dmqRJ27PO+VxsO132tCIVeJ6HfP
         DE2H2gI7LpymT94An3dsS83882236TOjut/r2K/11KfAK4ZcHup6ysnxniEZ/+5YqHnM
         8Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbkki67Asub00CoMWXZQkStJ/TI4GpjlH8uEJFsaihI=;
        b=lCuBdnvmTD62VhkUkTeXmAuIS1iIPDv7tM6VdZOoFCXLDq/q/oldpHyGwEUeE2wEMd
         DyPHMUkYZMZntkc4EqlX0JN2XsIJDw9oLt+ilVWtEkZFVuW+rw2OSckxD2CANm8MHHck
         qUzBwU5T66hR/TF6leDkgpfUdnafJpFBcvr95aKrsoi8ySm+6sIYm/YFR4W+GJPrRtA/
         oz82cSQ7TCGY5OF6V5L4SSO3e/WHVue2htKXvGzW8RXxdMnDsfpDnjop0bIrPKLxwyii
         A4h47pipBjth2MVvbqTyYD5AmqWaONszCDq+IZvogqPqexQFTN6mwYj7DuBtzqiZKnUA
         Hcqg==
X-Gm-Message-State: AO0yUKWMp28AvK4/r+vcVaHNKqC4yXXYD4FKeiEoF9qb0nXbwbnMm0pd
        NTZBI4eiQWZCHaDoH9OdRIvjGwCdC+4=
X-Google-Smtp-Source: AK7set++Xwd4IBFMlUyMgL29NaU26tnbOV/USXTlX39nL9hLojwh3+7TJNCN6NkhBOpATaMLVYgLtQ==
X-Received: by 2002:a05:6870:2389:b0:16d:c23a:a11b with SMTP id e9-20020a056870238900b0016dc23aa11bmr8922160oap.3.1677099014386;
        Wed, 22 Feb 2023 12:50:14 -0800 (PST)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ae583000000b00524faf3d2d7sm1872801oov.41.2023.02.22.12.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:50:14 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] wifi: wext: Eliminate log spamming in wireless_warn_cfg80211_wext()
Date:   Wed, 22 Feb 2023 14:49:45 -0600
Message-Id: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
usage") introduces a warning when wireless extensions are used with
cfg80211 drivers. Although such a warning is desirable, the current
implementation overflows the dmesg buffer with thousands of warnings,
all of which are the same. A WARN_ONCE() call is sufficient.

Fixes: dc09766c755c {"wifi: wireless: warn on most wireless extension usage")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

Kalle,

If accepted, this patch should be send to kernel 6.3.

Larry
---
 net/wireless/wext-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 13a72b17248e..9589ba5dafc2 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -641,8 +641,8 @@ static void wireless_warn_cfg80211_wext(void)
 {
 	char name[sizeof(current->comm)];
 
-	pr_warn_ratelimited("warning: `%s' uses wireless extensions that are deprecated for modern drivers; use nl80211\n",
-			    get_task_comm(name, current));
+	WARN_ONCE(1, "warning: `%s' uses wireless extensions that are deprecated for modern drivers; use nl80211\n",
+		  get_task_comm(name, current));
 }
 #endif
 
-- 
2.39.2

