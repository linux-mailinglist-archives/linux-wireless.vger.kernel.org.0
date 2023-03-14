Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA96B9BC8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 17:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCNQil (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCNQig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 12:38:36 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B64A9DF7;
        Tue, 14 Mar 2023 09:38:13 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 83A0E2003FF;
        Tue, 14 Mar 2023 17:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678811880;
        bh=ooLFZIh4ulWCiJYZc6yvrTXCsSwnpVuJlixKNRQY1oE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B9487GuR3j6kDpBB3qOrBYwF6FKn4IOPzAaNUzUdpX3Jsr+JU2tFCsol57Ej3fBfy
         emDip74YRxyfzOIwWOcgqcZ2D13VkEkWhLyfTB3kR988vqTK2KIWmr3z2zgooYTP1j
         Qww2XjFe4zaP+9/7ddmqUBnG0Adf3MObL06tYNkerN0AlTALt+Ccvy1SOYRjP17r9Q
         FVVx52RR69x8RXY7yBkUNzBwCyKPI+s8kyET1WSN4zH80O9WaFNTBrkNbdEzYYCJcj
         RQLyjyR4kao5QOey0Eab2H5ijoe4/ay8EgG0JD1kdZZ27n3pNNvgR3RiCSUNJ25TC7
         mQRW0ZRkuJYhA==
Message-ID: <893311e7-6fce-118b-a683-6988de161698@free.fr>
Date:   Tue, 14 Mar 2023 17:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr>
 <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr>
 <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr>
 <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr>
 <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
 <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr>
 <CAPDyKFpJR9rgadXEBn+73FKgmLM8sZgzNbKV_x_udwOSRGH44Q@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAPDyKFpJR9rgadXEBn+73FKgmLM8sZgzNbKV_x_udwOSRGH44Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/03/2023 12:08, Ulf Hansson wrote:

> If the delay is to manage vmmc and vqmmc, which is somewhat part of
> the generic specifications (SD/MMC), then it should be described in
> the host's node.
> 
> A pwrseq is something special, which is also platform and device
> specific (the SDIO device). If the delays correspond to this, it
> should be part of the pwrseq node.

Uffe,

Wouldn't it make sense to warn, when probing for a non-removable card
returns nothing?

Something along these lines (which I can spin into a formal patch)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2257,6 +2257,9 @@ void mmc_rescan(struct work_struct *work)
                        break;
        }
 
+       if (!mmc_card_is_removable(host) && !host->card)
+               dev_warn(mmc_dev(host), "no device found");
+
        /*
         * Ignore the command timeout errors observed during
         * the card init as those are excepted.

Regards

