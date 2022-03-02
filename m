Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846F4CAF10
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiCBTw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiCBTwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE0D95CF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 11:51:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qt6so5985832ejb.11
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vyonuIYbQFfvGJr2SF2YCWFfmFUdkwV/iwFQ8ptY9o=;
        b=Lf6bvC7ZvEcvEo+aZnoz18dgO7rCFCPBJcdZxQPPCQ2pCO8+0DmA+lRPqiQiEhvE+o
         j8HkE16Bs1GqbEYmUKY+KTxkymjA3SEsqlwAQw1GLAYhkCGdLLXnU0gFWMSPB6YdCs3f
         ZSdLnjYjUEf5cQBqD2MjYi5LE6wV4o6FIir36MMp3iBDuqgUvQUC75UjpblVfBxNaF0i
         wEUSSbMEWbU1HTES7K90CBRAnAWhqWjmkOmVtKrxNYyKBkqxu+sLyKlLsgGKSuwnWQy5
         odFproFtFAX2d6fLVDR6gYjza4CmjHyDpQM14ZGtV7alc9N2TrFijbPaWCVcWIFl1vhT
         KmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vyonuIYbQFfvGJr2SF2YCWFfmFUdkwV/iwFQ8ptY9o=;
        b=sudMkC17nEa/bo36wo1GYim49PjeKQM0o6T55sTUkyeexHmE07BbkN+EvFgf3zzmQI
         0VXLKLfP0yD5M2HDbjo+5GY+f7Dfs7QkULWbQ/7XZfrBFzHQuQ2mXGyUn1va324vJ0yH
         21oD462sQ8MgdQDx3tB8l9d1sIoPYpc0tKO8ISPlvViuG0TJKt5xNQrSZPtp0u+NxEAU
         htuxjJTl3Fw3PxE84TDj7aDkyWYXnx4q9LH9yiah8M7VNEw3+sO3JuHxzF7ZPxLEfrKK
         oqZXfwQaazk+nBGSii7wC9o0APXGzdaOPOD9JnHR9H+D9GgtDfWBNMc8ldDPk4djC8qd
         ktlg==
X-Gm-Message-State: AOAM53143y79AMhJkM0XT+fwlW1n+8+hHpE7wLkKwOmIz1DFx5jStO6S
        YtJxcea5JRvhmyX4loSgzlLWjB31Bpk=
X-Google-Smtp-Source: ABdhPJyYmcJkTFq2Z8wdnnJBKp1DfTpVr/Rax8xUKTcaxzqa1Svedvv2otEDEJ6LZs7+j4vE67Jb+Q==
X-Received: by 2002:a17:906:360a:b0:6b9:1f8:9cdd with SMTP id q10-20020a170906360a00b006b901f89cddmr24652482ejb.461.1646250700463;
        Wed, 02 Mar 2022 11:51:40 -0800 (PST)
Received: from debian64.daheim (p5b0d776b.dip0.t-ipconnect.de. [91.13.119.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm1243535edd.57.2022.03.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:38 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nPV0c-000IP1-Gh;
        Wed, 02 Mar 2022 20:51:38 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v1 2/5] carl9170: devres-ing hwrng_register usage
Date:   Wed,  2 Mar 2022 20:51:35 +0100
Message-Id: <d1c16490462a9371ab3cc16a018ef5e08382a35e.1646250537.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com>
References: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com>
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

devres will take care of freeing the hwrng once it is no longer needed.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/carl9170.h |  1 -
 drivers/net/wireless/ath/carl9170/main.c     | 29 ++------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
index 84a8ce0784b1..ba29b4aebe9f 100644
--- a/drivers/net/wireless/ath/carl9170/carl9170.h
+++ b/drivers/net/wireless/ath/carl9170/carl9170.h
@@ -458,7 +458,6 @@ struct ar9170 {
 # define CARL9170_HWRNG_CACHE_SIZE	CARL9170_MAX_CMD_PAYLOAD_LEN
 	struct {
 		struct hwrng rng;
-		bool initialized;
 		char name[30 + 1];
 		u16 cache[CARL9170_HWRNG_CACHE_SIZE / sizeof(u16)];
 		unsigned int cache_idx;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index f6974aff0c59..9495b3da1978 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1539,7 +1539,7 @@ static int carl9170_rng_get(struct ar9170 *ar)
 
 	BUILD_BUG_ON(RB > CARL9170_MAX_CMD_PAYLOAD_LEN);
 
-	if (!IS_ACCEPTING_CMD(ar) || !ar->rng.initialized)
+	if (!IS_ACCEPTING_CMD(ar))
 		return -EAGAIN;
 
 	count = ARRAY_SIZE(ar->rng.cache);
@@ -1585,14 +1585,6 @@ static int carl9170_rng_read(struct hwrng *rng, u32 *data)
 	return sizeof(u16);
 }
 
-static void carl9170_unregister_hwrng(struct ar9170 *ar)
-{
-	if (ar->rng.initialized) {
-		hwrng_unregister(&ar->rng.rng);
-		ar->rng.initialized = false;
-	}
-}
-
 static int carl9170_register_hwrng(struct ar9170 *ar)
 {
 	int err;
@@ -1603,25 +1595,14 @@ static int carl9170_register_hwrng(struct ar9170 *ar)
 	ar->rng.rng.data_read = carl9170_rng_read;
 	ar->rng.rng.priv = (unsigned long)ar;
 
-	if (WARN_ON(ar->rng.initialized))
-		return -EALREADY;
-
-	err = hwrng_register(&ar->rng.rng);
+	err = devm_hwrng_register(&ar->udev->dev, &ar->rng.rng);
 	if (err) {
 		dev_err(&ar->udev->dev, "Failed to register the random "
 			"number generator (%d)\n", err);
 		return err;
 	}
 
-	ar->rng.initialized = true;
-
-	err = carl9170_rng_get(ar);
-	if (err) {
-		carl9170_unregister_hwrng(ar);
-		return err;
-	}
-
-	return 0;
+	return carl9170_rng_get(ar);
 }
 #endif /* CONFIG_CARL9170_HWRNG */
 
@@ -2064,10 +2045,6 @@ void carl9170_unregister(struct ar9170 *ar)
 	}
 #endif /* CONFIG_CARL9170_WPC */
 
-#ifdef CONFIG_CARL9170_HWRNG
-	carl9170_unregister_hwrng(ar);
-#endif /* CONFIG_CARL9170_HWRNG */
-
 	carl9170_cancel_worker(ar);
 	cancel_work_sync(&ar->restart_work);
 
-- 
2.35.1

