Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8390664519
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbjAJPmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjAJPmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 10:42:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974E3FC91
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 07:42:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id u9so29802933ejo.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvskllAMxjpoYxy8x91Ay3wHk+edHsNAvSmQ+G4D/28=;
        b=M2e2m0o/SO/SkR3TdYczdGi2OcFE75a0cGVpRPpAa2m46IVI7Qm+RJMd40tKr9NkOv
         aDgbggUcO6WLqPeAzzFJyxJOj0rH6TShM3P6kuX7JDoJdvhJS+ArBylpnTcKQxZDU4Ew
         nyJ2oB3P2G696Q+OSNAu1iJ3/uPgZnKBejr6LOnzf3FE8xlolX5Z9EsA9vcXRDU6JZpd
         Yd52sjZ7FQ+a4RcGuJu3+Va5w4ryQav7io9PU+z+oskKPlO9uwO7kCTTmAd4FwfGnQxV
         oeTHSVVPOXvHO4P7Zi5T1DUsnPp2KYb7e0iiLqL8AnudNV81dvocETbhECDRFu+fCegz
         bWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvskllAMxjpoYxy8x91Ay3wHk+edHsNAvSmQ+G4D/28=;
        b=JCNMfUqAfbzU/nhpfMrW9j9bEzRATuGLWdqycDNFPqWa4Kgqr+dn//71wyyIN5kkdY
         Pb7uj+I1x56QmKqQ4XDbPxZHpEf5UygNaUsA8S5/zeWnbLKmOpGGAD2KEktUBcFe4soM
         TuxLW7RCCsvTt5415NTS1pzfiqP+TZqPrutky9Qz9XIGV0nlx4x1UakEjsr2UjDa84zv
         aO94DSu+DPNyF7Kp5JiIrGQD69InaUca1GvNa0B/UbcpYQj3InXU44XxrK9fCct0evqC
         wAw7VA53GOoDqF17mH4S0wpRvZTJo6VqeNlgkrKxLG5fm4FmXZk9/ee/cHDpRImxYcfa
         D7nQ==
X-Gm-Message-State: AFqh2krA4WKakqXEQCvZj0j9Cei5HQwViqahYYMMcIFffBjkt7SUi7RT
        UK4E1mbSVa8X/dZwKaJ/n+HUxZjhBfU=
X-Google-Smtp-Source: AMrXdXt+aaSr6VwSZxQEJnkNjMobBX+aSAP9U/9qLFQ/g0DsUuI8SYYf5/qh5ZaABEQlfAGpD0d/Sw==
X-Received: by 2002:a17:906:d205:b0:7c1:51ee:a2ec with SMTP id w5-20020a170906d20500b007c151eea2ecmr58517152ejz.46.1673365361039;
        Tue, 10 Jan 2023 07:42:41 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906292a00b00782fbb7f5f7sm5114950ejd.113.2023.01.10.07.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:42:40 -0800 (PST)
Message-ID: <d53fcf97-d6d2-3c75-14d5-97b58a5f3a6c@gmail.com>
Date:   Tue, 10 Jan 2023 17:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/2] wifi: rtl8xxxu: Dump the efuse only for untested devices
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
In-Reply-To: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
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

It appears this was the intention all along, but commit 3307d84024d2
("rtl8xxxu: Add initial code to parse rtl8192eu efuse") initialised
rtl8xxxu_debug with RTL8XXXU_DEBUG_EFUSE for no apparent reason, which
made it dump the efuse for all devices, even the tested ones.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d521435e1c07..07c3af5d0374 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -34,7 +34,7 @@
 
 #define DRIVER_NAME "rtl8xxxu"
 
-int rtl8xxxu_debug = RTL8XXXU_DEBUG_EFUSE;
+int rtl8xxxu_debug;
 static bool rtl8xxxu_ht40_2g;
 static bool rtl8xxxu_dma_aggregation;
 static int rtl8xxxu_dma_agg_timeout = -1;
-- 
2.38.0
