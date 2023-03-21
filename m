Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAB6C2F41
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 11:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCUKl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCUKlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 06:41:24 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D12706;
        Tue, 21 Mar 2023 03:41:08 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id D099020041A;
        Tue, 21 Mar 2023 11:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1679395264;
        bh=KCCATZkTr+7Q3TiUEqunw+3zj4NwVvKmBZameTcJZZ0=;
        h=Date:To:Cc:From:Subject:From;
        b=uToAtzfIpIaP4K567OQRcAp3j5BLtqLpONLanYT+KGrwDJHQHB/ounDJorAs627uw
         YalRsK6VxilPt7sYfuiwQXedPkl7qk+qRfnyxArlUViS10V/Ang1GBAVITq8FIdikC
         z3f1v3DtmKKESeRNv3MIG+kUf1pNHLUrQ+jG3MwsDpxQZ+Lem03Rm9ur9eCwSey4hu
         pQXH134cmjPTL/Ptm+pXqlFc3OKt19N82KriW1RmzpH4IceKu3LIMRes0Pm8EyEwjG
         bR9/DgLsGUnUym+pHRHuffznAkullCl5ic1A2VosUA9pqjy1HLVWMuIr4TBiKXfFkN
         S9CZlRY2+PSRQ==
Message-ID: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
Date:   Tue, 21 Mar 2023 11:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [Performance regression] BCM4359/9 on S905X2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello everyone,

I've been benchmarking an Amlogic S905X2 board.
It provides a BCM4359/9 WiFi chip connected through SDIO.

There's a large performance gap between vendor kernel and mainline.
(Downloading a 1GB file to /dev/null from a device inches away)

# curl -o /dev/null http://192.168.1.254:8095/fixed/1G
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1024M  100 1024M    0     0  27.5M      0  0:00:37  0:00:37 --:--:-- 28.6M
vs
100 1024M  100 1024M    0     0  11.0M      0  0:01:32  0:01:32 --:--:-- 11.0M

Line 1 = vendor kernel (4.9.180 amlogic android)
Line 2 = mainline kernel (6.2.0-rc8)

Why is the vendor kernel 2.5 times faster?

(I'm using the same firmware files, but it seems the vendor kernel reads
an additional configuration file that the mainline vendor seems to ignore.)

Regards
