Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2E74DFF5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGJVCw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGJVCu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 17:02:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED3A8
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:02:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31441dfbf97so5712531f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022968; x=1691614968;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+D+4zoQ0B9tHUKwZdibD1400scNbLYMmekMtFdpiw4=;
        b=ovtOxPqKXZ70vzrl7GNcKTGHOx0rDToaxsbsatYiRsX6T9PCdr4CKkUVBFDH010eHp
         kmzr/Qr/4Ku2KlsSZao5ybUzaYjHIENYq2fe6ZVeOHqbkwQGJBTtlMGG893aMePThSOj
         HZUx+vxyaUJ1UQBcIvjszYmFFrLUbviUwZX0qbnpK0ELlz5LPI3F/J48lXibg2HZzvbn
         yhw6bJ9VSLm8HmS98M5mtQs9mPS1x2I8qx4DBPbeptvlw86g5VYrtooNJUlNqXGN/uTs
         OspQ/nJ32imRdLdXtrlPZ/Qm6Gi8M5QpCZSp+rzKBpOtlt/6obFiYSXFRVF85HhnugGP
         MqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022968; x=1691614968;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+D+4zoQ0B9tHUKwZdibD1400scNbLYMmekMtFdpiw4=;
        b=h8AdM/a5A18/hqYb6nOMOg/yDWukFxNhKvOGOyI/P9nV8wQlq+WHkkH/LgktHZBZjo
         OaRO1VcvuEkpvsItPx9fr7PuKYzi/+z3Z4k/0UpsaAda7l16yOlQTrSdgNP1IJFz9zkZ
         blYbbTXYyJqxbm5bm/lUbFEqb6Bd5P038Ht8W8ELYqsuFTKOpGWHPXjL/wwwKItIG8kn
         EeYK2LJ8hyxdQv84Z3csifdKczoPvf8ddf0TBpBH5FloO0e4JTGDAi4bAHJoBUGvpG4b
         NRQI69VAqDfWkrJ1+0UZ+vF7HklKTfcAG+aPAa2dQAp+fHN79ZgbEaTBPpYx5Wx9jtls
         U/Qg==
X-Gm-Message-State: ABy/qLbhfe1/Qt7pZJm7x4vKoM7rfr/kQuOlz4Ng5peC5m2b7TjMGXeP
        H2hsJRxK5XIp7EWTi0Y8f07YYwumrzQ=
X-Google-Smtp-Source: APBJJlG7F1bY9+HSbhdw0X6yfwFOHYrqsZKviVztWsfJxz/JRnp5N7lah2FcTIlpWBybxTOVH324xQ==
X-Received: by 2002:a05:6000:1081:b0:315:96e2:d73b with SMTP id y1-20020a056000108100b0031596e2d73bmr5220529wrw.37.1689022967844;
        Mon, 10 Jul 2023 14:02:47 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id i17-20020adff311000000b003143853590csm357501wro.104.2023.07.10.14.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 14:02:47 -0700 (PDT)
Message-ID: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
Date:   Tue, 11 Jul 2023 00:02:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/4] wifi: rtl8xxxu: Enable AP mode for RTL8192FU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Theoretically this chip can handle 127 clients.

Tested only very briefly but it should work as well as the RTL8188FU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 18dc5221a9c0..28e93835e05a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -2079,6 +2079,8 @@ struct rtl8xxxu_fileops rtl8192fu_fops = {
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x1f1f,
+	.supports_ap = 1,
+	.max_macid_num = 128,
 	.trxff_boundary = 0x3f3f,
 	.pbp_rx = PBP_PAGE_SIZE_256,
 	.pbp_tx = PBP_PAGE_SIZE_256,
-- 
2.41.0
