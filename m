Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39488745E55
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGCORN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCORM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 10:17:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C72E52
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 07:17:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so3413976f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jul 2023 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688393829; x=1690985829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NS8aCa+Lk9ooIVJLC50sm9OfUoCHiG9VauOiFjSke5I=;
        b=Dz7mnBydwopgtG5BvWhnn6YG9PDY/D9J7KxzrFPVZJ4igHsL8gj+e8B+0RKgzdiuy5
         3gk3lnDKzewXPImLL74MoeBaTauKZUZKo96oLK/RSU7qPMiDdIe51lApoYZ4/TkTNAza
         TeOBAMwIu9T9ACoDZQGmKgIqchNfCQ0bFDBNTcwepwyOfRnIIZCgS3wNsFDafeFE7HKx
         rTLQ5eNEV+3WwsdjUtdbtumC1Qv7XiaX4Hoa1tzSNCyJtGuu12MFkk47fgYfZB2oDLBI
         ld5RlWMBII6YN8QmgGVa/XPVldJaehURhv3c84W2zvM/H2R9n5hk2RqEmb8kUe8UgbUh
         Lc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393829; x=1690985829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS8aCa+Lk9ooIVJLC50sm9OfUoCHiG9VauOiFjSke5I=;
        b=AFdbg4toj3Sm8JpiB4KL7wUus+Z1ZZtWgZlb5CZA6ezajvHuNQ4ehpZJhh2Z8OctQV
         Au3jojdMD9WSXCw7D2e2dUSB5d73KAL6kDnM8AjCNgi8qV22FYMSilEVmQlznPfCCpFB
         i7piGunZ591YmtV8YSmiHE6EJNfy5mPDljtQF6pr+dyuEkz7bFvdaiOc1Opx6VvDempO
         9Nl4xA43xhXSE3jk0GkRYAOV4KA5Ih1NUNPuR+zqXpFVrO9kT/tLag1e0EpanrNPpTMd
         uT8F0Hr1MjAawWQhvY2v8c5TP1c2/bazkLc7xN/2ah8pw7+SJAix94GjUksOiO08sA+E
         3rCw==
X-Gm-Message-State: ABy/qLapgtFa64gMSAzwOC8A4CUj2FETP+Gr5dhiRD10lN0tBZQ6h9tE
        Xfe6da6jRe+stVNBaxLKsqD82g==
X-Google-Smtp-Source: APBJJlEHMDhiRmKyjSnGkgATubU4gmdibSh3K5idL3pcNGvtZkcd2PD4WINUw9CHRRCGA5SEfYkQPw==
X-Received: by 2002:adf:fcc5:0:b0:314:1b9b:6e1a with SMTP id f5-20020adffcc5000000b003141b9b6e1amr9941313wrs.62.1688393829298;
        Mon, 03 Jul 2023 07:17:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u2-20020adfdd42000000b00314326c91e2sm4463454wrm.28.2023.07.03.07.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:17:07 -0700 (PDT)
Date:   Mon, 3 Jul 2023 17:17:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ath9k: use struct_group() to silence static checker warning
Message-ID: <6de44cd9-a9a0-4b76-a9b5-a3c37b97f9aa@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are deliberately copying both ba_high and ba_low so use a struct
group to make that clear.  Otherwise static checkers like Smatch and
Clang complain that we are copying beyond the end of the ba_low struct
member.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath9k/mac.h  | 6 ++++--
 drivers/net/wireless/ath/ath9k/xmit.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index af44b33814dd..f03d792732da 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -115,8 +115,10 @@ struct ath_tx_status {
 	u8 qid;
 	u16 desc_id;
 	u8 tid;
-	u32 ba_low;
-	u32 ba_high;
+	struct_group(ba,
+		u32 ba_low;
+		u32 ba_high;
+	);
 	u32 evm0;
 	u32 evm1;
 	u32 evm2;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index f6f2ab7a63ff..42058368e637 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -468,7 +468,7 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	isaggr = bf_isaggr(bf);
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
-		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+		memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 	}
 
 	while (bf) {
@@ -551,7 +551,7 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
 	if (isaggr && txok) {
 		if (ts->ts_flags & ATH9K_TX_BA) {
 			seq_st = ts->ts_seqnum;
-			memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
+			memcpy(ba, &ts->ba, WME_BA_BMP_SIZE >> 3);
 		} else {
 			/*
 			 * AR5416 can become deaf/mute when BA
-- 
2.39.2

