Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFA172B1DC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjFKMhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjFKMhh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 08:37:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30C10CF;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso4745188a12.0;
        Sun, 11 Jun 2023 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV5kS4uFTylsIKBTpLATpLjmqF+bm2uJbZFR1pKIFFU=;
        b=cF6z1xdITZwBuJSfEmjH/z+MYgQa6wthMLGjBetd3+r+x+rszQ+Rm9mZozEEA9cHR7
         2chTWTmNsABqQmt99SjzmNhB5X4R0F/0QIj0/7D558ncNVgwKZwzDuFgzA5U4AdxJsTL
         4S8JPhYcuGHxn1NNbL7+t/QHJTKg0gYiAyDhM7tZ1/Tb9nRsv1RM87ySMLs5kbpulmEH
         Utga4iCqqyo263e32Up7YU2oMkVFX+I1T9KimFgLCDXkJLWm8xYDIAJOFEREkO5/08UO
         n5/9qrB7yxoeu8COJ29bHPXmKtxM+chHgyjz7KlO2IZgkvrkQfa8cj4TG7E3ZynmZQl8
         bfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686487055; x=1689079055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV5kS4uFTylsIKBTpLATpLjmqF+bm2uJbZFR1pKIFFU=;
        b=cSeVaNQQPB4qFSA0JBI2UVQ5QjQASgm30F2kaFstm+k3zddlqvP21vHVtkCALtxggU
         B9Zt30KbdcZW3Khj3fsB6/m5+MUbLtuLsiSYoy3HtRDjo6ir+UpmE2cVsQsuq0PdO2Pz
         6xB69sazoUofvrBKln1eJeAu5O/tusGTylTZ9dggggeCmfcepXt5ZT5MPimNaAoBRFEh
         M5ULxJyxWFtGnL8uCpPo3oXJUxFrlH5CtTC4IZJalO/OYLmfLxTS4yordVq12qIKROG4
         ufvpScxhcwo4OXQ0kdr/K/UmuPsNWmtiI2XopVpL52KpeROwSLTSZFVkddaGWtU5xo3l
         iLqQ==
X-Gm-Message-State: AC+VfDwBCBC1Unw3tVy+yG+BWTqgDd0jYQHUq+bUDDuutYjUq9YQsVnM
        BGmIoFOgV49Cl//7BCCprxeckhPDyCc=
X-Google-Smtp-Source: ACHHUZ5VWP0NHERLXgSX8/htApGTFSp4xIZ43YimlNMEmqPkZyr/BbV5qoFPogbWxjoMRvXLVK0GgA==
X-Received: by 2002:a17:907:a0d:b0:978:6fbf:869c with SMTP id bb13-20020a1709070a0d00b009786fbf869cmr7003552ejc.16.1686487054755;
        Sun, 11 Jun 2023 05:37:34 -0700 (PDT)
Received: from shift.daheim (p4fd09ff6.dip0.t-ipconnect.de. [79.208.159.246])
        by smtp.gmail.com with ESMTPSA id dx15-20020a170906a84f00b0097bb01516c2sm2738842ejb.0.2023.06.11.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:37:33 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q8KK4-000LN5-2Z;
        Sun, 11 Jun 2023 14:37:32 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: [PATCH v2 2/2] wifi: ath11k: add support DT ieee80211-freq-limit
Date:   Sun, 11 Jun 2023 14:37:32 +0200
Message-Id: <ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com>
References: <fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com>
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

The common DT property can be used to limit the available
channels/frequencies. But ath11k has to manually call
wiphy_read_of_freq_limits().

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
compile-tested only.
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c947d1c8d8c1..7e43f2770f27 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9414,6 +9414,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (ret)
 		goto err;
 
+	wiphy_read_of_freq_limits(ar->hw->wiphy);
 	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
 	ath11k_mac_setup_he_cap(ar, cap);
 
-- 
2.40.1

