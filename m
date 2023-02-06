Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD5768C05A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Feb 2023 15:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBFOlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Feb 2023 09:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjBFOll (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Feb 2023 09:41:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278CA24C8B;
        Mon,  6 Feb 2023 06:41:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so8862405wmb.0;
        Mon, 06 Feb 2023 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HzCHZgMAtU1lwfgKiXjvWaTvm2+bd5CX7c+kVIRQKEU=;
        b=osF8wkrcpsfpc0hCXE0D6Y4dHrmKgnG1p9gfaKmL7nIieN2qWJfdNWCMNO0J5ySI/c
         CYIlQQ+JeJuDy441wecpzU0UMInpr/v4gwF994dSfBSgoGOLlJ6fiVm1vvQ4UgVSKHa6
         NGGVtuF+UJFERcKDB0roHYSHJTk733Cpf3pDcemOdgn2+Dp6UuFXs9eldL5cXFnbW1E2
         hgNRSr/brgF9hSv4OCXg1rt/UA7cU+mFS4/783zG4IDYpkCQAWHfVixQSU+Tz34I+ixX
         Zi7ZQBdZYSdsC5xRqH4vYOsJAvr0qquV9h8v8/j12b4w26GBOC/TEdSpdweflgh5O/dx
         IjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzCHZgMAtU1lwfgKiXjvWaTvm2+bd5CX7c+kVIRQKEU=;
        b=QZBmZwmlYrFscN2KP2s7pu49Ra/giS0WnYaeLl6IspeREvOjBwiAGtc52qoofEDRJQ
         a8rwXIWZtIvG4M+Z1vjqMMBYKfj8hrxoMlGj74xVjbMGXAOy17MQu0AFsoEYhNED3LqL
         2UJDG9dhdFFPCH4/aRQaxk5SLt0vt6WQzMzJIh2WCfVRT00wnn0e3BIUPsyqA0+Wv0M+
         JNoPG3wcmaDdduM7P5fze0dVFDhoH+85rclXiizc1zx5vtsQuAbyBlaYGlZ4r/QaxMOB
         7Q43TXCJHzAS/1kIf1ITRBH0LxA2cYBeiAbB+ve+Ja9kW9liD13zmSvKKLotSwqiOE0Q
         ADag==
X-Gm-Message-State: AO0yUKXL7KzkRAKtXOnaX2fUSFwt5eq2e2Zrie8LTt7q7sOMDB8pyJox
        3RhsWQnr15yP5EFxWCLSePynry2Vms94oA==
X-Google-Smtp-Source: AK7set8QhziBZLhtKt4r7cWYVvybJNPAOODK+58BXXg6Sc45bWnKO1fuhX5ul84DGGzVbwWv2iDGSQ==
X-Received: by 2002:a05:600c:54c5:b0:3dc:9ecc:22a with SMTP id iw5-20020a05600c54c500b003dc9ecc022amr19345409wmb.8.1675694497607;
        Mon, 06 Feb 2023 06:41:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b003dd1bd66e0dsm12407562wmo.3.2023.02.06.06.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:41:37 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:41:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>
Cc:     Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chunfan Chen <jeffc@marvell.com>, Cathy Luo <cluo@marvell.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: fix loop iterator in
 mwifiex_update_ampdu_txwinsize()
Message-ID: <Y+ERnaDaZD7RtLvX@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code re-uses "i" to be the iterator for both the inside and outside
loops.  It means the outside loop will exit earlier than intended.

Fixes: d219b7eb3792 ("mwifiex: handle BT coex event to adjust Rx BA window size")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 4af57e6d4393..90e401100898 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -878,7 +878,7 @@ mwifiex_send_delba_txbastream_tbl(struct mwifiex_private *priv, u8 tid)
  */
 void mwifiex_update_ampdu_txwinsize(struct mwifiex_adapter *adapter)
 {
-	u8 i;
+	u8 i, j;
 	u32 tx_win_size;
 	struct mwifiex_private *priv;
 
@@ -909,8 +909,8 @@ void mwifiex_update_ampdu_txwinsize(struct mwifiex_adapter *adapter)
 		if (tx_win_size != priv->add_ba_param.tx_win_size) {
 			if (!priv->media_connected)
 				continue;
-			for (i = 0; i < MAX_NUM_TID; i++)
-				mwifiex_send_delba_txbastream_tbl(priv, i);
+			for (j = 0; j < MAX_NUM_TID; j++)
+				mwifiex_send_delba_txbastream_tbl(priv, j);
 		}
 	}
 }
-- 
2.35.1

