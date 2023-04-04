Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545686D6818
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDDP77 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjDDP7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 11:59:49 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1B1A5;
        Tue,  4 Apr 2023 08:59:48 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8E078200483;
        Tue,  4 Apr 2023 17:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1680623987;
        bh=CzvvgTblGhaF/J7bVlIXcfhbbcQ7ryI5eYdk4LdJQkw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=VbGIfF4WDXmiHdI/d3y2APmUG8N17SSZEvysy8Jmpz+SQXB1wR0+k2jnkWTHNiIrx
         0enP5G+xmxoAMKV5yhhh2PpmL6Mx1kWJVLaekplNG5sceFEPSh9uFaccuRzldjYLD9
         ++r23Tjrz3L0vQmPgkXeO1frRUkNI6+VPo7wfMCPsDETRaGoIYYe/zSCmHDaRELNaS
         EqcIFTSeOEhxHtbrHlzkMpTF/e35S+h17yi/YL+V14kfXd29v/Q6N/9URcwWEYyznV
         rkgDSWkw46TFYPREv9ctjX/JQZZWGfYkeNRV91TdFvw/axbaZuJ5NrjRP5fTZPIB1v
         Dm5GAZSOvA4EQ==
Message-ID: <602e992f-514c-65e2-f45f-17c088af3a61@free.fr>
Date:   Tue, 4 Apr 2023 17:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     linux-amlogic@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
 <6be2c348-b343-876a-a77f-a8297676de6a@free.fr>
 <a215e398-2c49-19d2-0730-5e8c51df1ed9@free.fr>
 <CA+8PC_du5dMwkmAshG2mM9TdeJft5aeAbEdDp0_q3Rxdvpq4MQ@mail.gmail.com>
 <f14407f1-e16f-0074-6e29-c597754ae617@free.fr>
 <CA+8PC_dFTvv9VtY9jBWLLwSoQzGxQd57zWMsnN6amddop4Yw-g@mail.gmail.com>
 <31dea9bf-63ef-c6db-b206-8afac960fd10@free.fr>
In-Reply-To: <31dea9bf-63ef-c6db-b206-8afac960fd10@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/03/2023 18:40, Marc Gonzalez wrote:

> At my disposal, two S905X2 boards with SDIO-based brcm modules
> (according to the labels on the boards) :
> 
> Board A embeds "AP6398SR3"  which identifies as
> 	x vendor=2d0 dev=4359 over sdio_read_cis
> 	x brcmfmac: F1 signature read @0x18000000=0x17294359
> 	x brcmfmac: BCM4359/9: chip=4359 rev=9
> 
> Board B embeds "AP6398SR32" which identifies as
> 	x vendor=2d0 dev=aae7 over sdio_read_cis
> 	x F1 signature read @0x18000000=0x1042aae8
> 	x brcmfmac: BCM43752/2: chip=aae8 rev=2

Pali Rohár pointed out lssdio.
Here's the verbose output, for the record.


BOARD A
# lssdio -v
Host 2 Address 0001 Function 1: ID 02d0:4359 
    Common Address: 0x0001
    Common VDD voltage: 3.2-3.4V
    Common Type: SDIO
    Common Vendor ID: 0x02d0
    Common Device ID: 0x4359
    Common Revision: 0.0
    Function ID: 1
    Function Vendor ID: 0x02d0
    Function Device ID: 0x4359
    Function Class ID: 0x00
    Function Revision: 0.0
    Function Driver in use: brcmfmac
Host 2 Address 0001 Function 2: ID 02d0:4359 
    Common Address: 0x0001
    Common VDD voltage: 3.2-3.4V
    Common Type: SDIO
    Common Vendor ID: 0x02d0
    Common Device ID: 0x4359
    Common Revision: 0.0
    Function ID: 2
    Function Vendor ID: 0x02d0
    Function Device ID: 0x4359
    Function Class ID: 0x00
    Function Revision: 0.0
    Function Driver in use: brcmfmac
Host 2 Address 0001 Function 3: ID 02d0:4359 (Class 02)
    Common Address: 0x0001
    Common VDD voltage: 3.2-3.4V
    Common Type: SDIO
    Common Vendor ID: 0x02d0
    Common Device ID: 0x4359
    Common Revision: 0.0
    Function ID: 3
    Function Vendor ID: 0x02d0
    Function Device ID: 0x4359
    Function Class ID: 0x02
    Function Revision: 0.0
    Function Driver in use: (none)


BOARD B
# lssdio -v
Host 2 Address 0001 Function 1: ID 02d0:aae7 
    Common Address: 0x0001
    Common VDD voltage: 3.2-3.4V
    Common Type: SDIO
    Common Vendor ID: 0x02d0
    Common Device ID: 0xaae7
    Common Revision: 0.0
    Function ID: 1
    Function Vendor ID: 0x02d0
    Function Device ID: 0xaae7
    Function Class ID: 0x00
    Function Revision: 0.0
    Function Driver in use: (none)
Host 2 Address 0001 Function 2: ID 02d0:aae7 
    Common Address: 0x0001
    Common VDD voltage: 3.2-3.4V
    Common Type: SDIO
    Common Vendor ID: 0x02d0
    Common Device ID: 0xaae7
    Common Revision: 0.0
    Function ID: 2
    Function Vendor ID: 0x02d0
    Function Device ID: 0xaae7
    Function Class ID: 0x00
    Function Revision: 0.0
    Function Driver in use: (none)


