Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7469B293
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBQSty (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 13:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBQSty (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 13:49:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D83C2C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:49:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g29so2898023eda.5
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8aIeiSeDJ4k7x2pbHMiXdPe7liNypG67WygfOUBF0g=;
        b=qOMI5Gs2IS89vhyJRWcrz+v6wMnpNJ3frrSniNM1kWpVAeS/3zTrC4nyWVzIp41C4V
         dc2gYqsnE9RIB9NuqwUs6InHPtztaOkRtjvTkVwAuuvVuTAaIXnFnKyAFseu2/rutY2+
         ps+91ymqRDnoxqEOBKQjqjYkxZGzLKqL2caRioxnOK720KeDqHKMZhLvxDJmRlXstpIs
         Whq62Z6dWKNKQvE5T6lqXt1+oNgZuA2aH2P1Ptx0/W0C22iX6Jlf1shxfAKn0lNyUmn3
         hKmEZAnZgIqNQFwgfO15WACItauLmq3HPsd3WTNUCxshPLABOuhuWbck7Dhp2BDMz1xu
         hT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8aIeiSeDJ4k7x2pbHMiXdPe7liNypG67WygfOUBF0g=;
        b=qN4XoGOnldGgemX/fvvSvNjJihMZ962ifZnuxtJjOQDPYqBvbW6K3ydP9yQIDFM6sQ
         nw3F7i6im+3rZRLi76MgK8paF0VwZwZR3FoJUbpMwNP3NORp6Er+8G/KlTw0p6FWc3zD
         5uvAd3ekLL0cKZ0YBoQozwPUK86Q3VFGY33RY4fnT1SWLbjhOLZ27nmY/el9kU0ygFez
         2GB5wniSEd+bHQqoVeGj7zhhEHEZZxuEWwbJ3BNer8hjrsUFHShB+uXPgFYUlula5JPu
         jkml4CcMroEstL8fXLT5XR8/fD3ABwvttbriWJVczRJWRLDqe3MorGHYEZY53K1sNlEI
         gtYQ==
X-Gm-Message-State: AO0yUKV71O+vM22f+U/KfF4vQWw2v/uPubaTm+w7b7ioEUSDWTWv3m5C
        UC7vtJ7votRVzEmC1OrnCBvbxtzu4bc=
X-Google-Smtp-Source: AK7set95Qes3EcHHYFzHVd/CGPf8NYkoX+Uz+RYBMUPdNLaxigL+svnu+ja8wBbqOM2P8gC6S3XqUQ==
X-Received: by 2002:a17:906:5651:b0:884:fd73:8053 with SMTP id v17-20020a170906565100b00884fd738053mr8840ejr.9.1676659791037;
        Fri, 17 Feb 2023 10:49:51 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id n9-20020a1709067b4900b008b12d3403adsm2483969ejo.19.2023.02.17.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 10:49:50 -0800 (PST)
Message-ID: <68eff98b-a022-5a00-f330-adf623a35772@gmail.com>
Date:   Fri, 17 Feb 2023 20:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Remove always true condition in
 rtl8xxxu_print_chipinfo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a new smatch warning:
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1580 rtl8xxxu_print_chipinfo() warn: always true condition '(priv->chip_cut <= 15) => (0-15 <= 15)'

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302140753.71IgU77A-lkp@intel.com/
Fixes: 7b0ac469e331 ("wifi: rtl8xxxu: Recognise all possible chip cuts")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 620a5cc2bfdd..54ca6f2ced3f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1575,11 +1575,7 @@ rtl8xxxu_set_spec_sifs(struct rtl8xxxu_priv *priv, u16 cck, u16 ofdm)
 static void rtl8xxxu_print_chipinfo(struct rtl8xxxu_priv *priv)
 {
 	struct device *dev = &priv->udev->dev;
-	char cut = '?';
-
-	/* Currently always true: chip_cut is 4 bits. */
-	if (priv->chip_cut <= 15)
-		cut = 'A' + priv->chip_cut;
+	char cut = 'A' + priv->chip_cut;
 
 	dev_info(dev,
 		 "RTL%s rev %c (%s) romver %d, %iT%iR, TX queues %i, WiFi=%i, BT=%i, GPS=%i, HI PA=%i\n",
-- 
2.39.1
