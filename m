Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09D368BF13
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Feb 2023 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBFOAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Feb 2023 09:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBFN72 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:28 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4B28D32;
        Mon,  6 Feb 2023 05:58:46 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id h3so2607881wrp.10;
        Mon, 06 Feb 2023 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzPi/t0MR9S08ss12Dlv57UTudCb600vUEwyip7OnS0=;
        b=TC5PNFuJzf6Cg3YH99Kqmm8xtZ4ritJRKvCS46f+X7qwkOL2fPC20CRZ6y5nhmF/8i
         /C/h2V+j8wlukHdz+ZAsmJmMctevSecB0P91cc/z02u7QF8YiMwvR922WSMLN+lrD6ss
         xCiLHNlztoSvtZqLkr+iXKt0km4Cc5VXwaOtEIedEgwSO7r92grNJX+amPByKYGRUOQz
         jIautBhd6shdLjy2dsImqamz28q1wZ3fjRAGhytah4DJUAIMiiVQCPldozbv/4jArxKw
         QAzmKL1oP/GQUjCCM6IdZNhC8YVrU2pRHBIBGt5EgjJ8ZTgEa/mDMopXCoGOufsjJjx/
         9O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzPi/t0MR9S08ss12Dlv57UTudCb600vUEwyip7OnS0=;
        b=fcjzoCtIJv9xRRzpO0hTP4LsaOFGCmViot/CEZ+Se2FaR2p33qxw2lD8/krxOGNaNS
         aps8w4ia68IIKwGzoYYsVF7t/3rpqayIRU0OQqaHiB8hriBFQNY0TgjRbGI7u+sUwate
         pZNif6Xo2AhzfOB0xu/Jv1AG5gM60ElckIj8JBjM2w2cCyC77lNnQbWQleqA7bIEtCM0
         4+cQC3s3uPWqi/e+gE9U6xmQsPlKTQI5jYKdg8PUj1gUdnpdD2wUo279nrYt8TOF/+ue
         TVLVFuRP8g5JpueASqq7419d9Vg21xb2W+BwQv6JqDkhiXhHfVz4z85/MMjogxiTx6ne
         Ce8w==
X-Gm-Message-State: AO0yUKUzl1x3f/Q892gvuNf6EI5w++af8xbNB1gj0CHOOdjDObOCCM7a
        yJasQaTCU9nBj+uSz95pVsKtaGnMilM=
X-Google-Smtp-Source: AK7set9k8HwJpaxPB5d+chZ86tHz5LwoNdMs5kzx0i/ERbDFkRWeCWEK6BgR6gRDVE8EI1VL8VwAow==
X-Received: by 2002:a05:6000:1ce:b0:2bf:bf32:70c with SMTP id t14-20020a05600001ce00b002bfbf32070cmr15541835wrx.47.1675691925869;
        Mon, 06 Feb 2023 05:58:45 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b002c3e1e1dcd7sm5430684wrv.104.2023.02.06.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:58:45 -0800 (PST)
Date:   Mon, 6 Feb 2023 16:15:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>, Felix Fietkau <nbd@openwrt.org>
Cc:     Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath5k: fix an off by one check in
 ath5k_eeprom_read_freq_list()
Message-ID: <Y+D9hPQrHfWBJhXz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This loop checks that i < max at the start of loop but then it does
i++ which could put it past the end of the array.  It's harmless to
check again and prevent a potential out of bounds.

Fixes: 1048643ea94d ("ath5k: Clean up eeprom parsing and add missing calibration data")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---

 drivers/net/wireless/ath/ath5k/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index d444b3d70ba2..58d3e86f6256 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -529,7 +529,7 @@ ath5k_eeprom_read_freq_list(struct ath5k_hw *ah, int *offset, int max,
 		ee->ee_n_piers[mode]++;
 
 		freq2 = (val >> 8) & 0xff;
-		if (!freq2)
+		if (!freq2 || i >= max)
 			break;
 
 		pc[i++].freq = ath5k_eeprom_bin2freq(ee,
-- 
2.35.1

