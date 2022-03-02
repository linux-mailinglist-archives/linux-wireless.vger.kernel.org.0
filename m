Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39F4CAF11
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiCBTw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbiCBTw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD133D95DF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 11:51:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x5so3743650edd.11
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yrb/BN+S9473Kdgr+x3ZnvUqcQCkSxkwALLKGoVRVpA=;
        b=bco7aZCvlsclt+bXgiGW0Lmyr342mKTH5p4LwAFnfSIesPFEJCgRbx4xB9RydhNRlC
         GR/3jvHFV5rgz3un5714um/qrP2rrJXAs31zCSCxfqoOKKAYYr0EXpuufMJIKHSnFocy
         dNNjniJ5DQh52lPQ6iT6cb4RgBE85dlHnmB+dmCexVJNePMUEzH1Q8/3mfcdXFNFfwfD
         bmok/i3W6ArB6nHprVnBFrn6fLdVQVhmaqkeAndDTxsvXK91Q15PpI+2/FBptiemN4+T
         wcNDN2qdhKfdF79ja4yEmHlDBjSSdtfteAl62JBQvAr9gPLDXCB7Chw5K7JmuQfcDxmK
         C+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yrb/BN+S9473Kdgr+x3ZnvUqcQCkSxkwALLKGoVRVpA=;
        b=n3WeCvFRcJ9Hl6R0diR3OKjokZeLpDiPPvQRLtr3DrxvevpWLAls227mz57baxrHlo
         Yzje0YqtUzaDhRRGuVr8y7HiWpO/9vjO2jP9J7YVAwvqGsCTI0IChMHMjmw3tYPlU5Te
         90G8oCCCS/rg3sP30qIsBBUw8KVvwfP9mRMWbgo9CUR9cS+Ar4YDTzgwPCSGUYErysqL
         DQiiA+EFulRktMZyHXS6x+/y69dcDPb8dBIHhaexfLbq3pHu4kQWMfw/D8X0PHyvg9kF
         0dq6iJ63GIsMiYbd0UNw3r60pmG6/uHXemyCgkAb2HII2ByjUDxwXdb2hH9phG52tTQl
         HOxg==
X-Gm-Message-State: AOAM531inSmi4/ia5L8HpHFeBaDLuyP4VzAS8nTdBdPNmarJ6PeSWAGt
        5Gk63HaxsPVvlf5jERuNI6WTRE1Ddck=
X-Google-Smtp-Source: ABdhPJxsHXlSWJgwFlKrsmPYnlmLlgT2bjI60HYjKGacAY8Rmvg7E5OdYMiJRhiPKOe2Md+g++kkpQ==
X-Received: by 2002:a05:6402:2549:b0:415:c31c:f9c2 with SMTP id l9-20020a056402254900b00415c31cf9c2mr3446902edb.335.1646250701410;
        Wed, 02 Mar 2022 11:51:41 -0800 (PST)
Received: from debian64.daheim (p5b0d776b.dip0.t-ipconnect.de. [91.13.119.107])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00413a99bf3a3sm5620449edq.56.2022.03.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:38 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nPV0c-000IOz-G3;
        Wed, 02 Mar 2022 20:51:38 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v1 1/5] carl9170: replace GFP_ATOMIC in ampdu_action, it can sleep
Date:   Wed,  2 Mar 2022 20:51:34 +0100
Message-Id: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Since ~2010, the driver is allowed to sleep in the ampdu_action
callback thanks to:
commit 85ad181ea788 ("mac80211: allow drivers to sleep in ampdu_action")

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 2208ec800482..f6974aff0c59 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1412,7 +1412,7 @@ static int carl9170_op_ampdu_action(struct ieee80211_hw *hw,
 			return -EOPNOTSUPP;
 
 		tid_info = kzalloc(sizeof(struct carl9170_sta_tid),
-				   GFP_ATOMIC);
+				   GFP_KERNEL);
 		if (!tid_info)
 			return -ENOMEM;
 
-- 
2.35.1

