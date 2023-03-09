Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E36B211D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 11:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCIKR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 05:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCIKRh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 05:17:37 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC422E8AA4;
        Thu,  9 Mar 2023 02:16:44 -0800 (PST)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 3DFD72003D0;
        Thu,  9 Mar 2023 11:16:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678357001;
        bh=KsY0ROkL+cUe7OoIP278GJcGrIgfnvguP7NW7TiJfnY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=faXhcrfJzqMhRwEuDizNUVJi8EeUdU3GMRzmg+yYvq2RjxMWl6XYwcDMjARU25yBF
         LvPL/LH368oeEV6NO25PdC0w47cd1GVxf8pjWgseCWJM1yIs43nhQ/Sn+kPM6vAXyw
         921VJHuDlQCSfLYkC/IzHz65t8BhNUcEDmOtFOkBhHjzG1q29/buIDF/3vlGdTY22K
         RDgYaYf0WKD1zGlQSobHywgxUtZPKLxmsLkjVQbIq1+5rWvMuySbRYxYXvQ8uHX4Kq
         ed0auBox94ef9PKjD3VSgALFZUqttVpkzYDFUeoYQ/CCWcA7JI42f9UwFFwlwniWnY
         hkSJKQSycFH7A==
Message-ID: <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
Date:   Thu, 9 Mar 2023 11:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
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
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
 <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
In-Reply-To: <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/03/2023 11:24, Marc Gonzalez wrote:

> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
> OF_NAME=wifi
> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
> OF_COMPATIBLE_0=brcm,bcm4329-fmac
> OF_COMPATIBLE_N=1
> SDIO_CLASS=00
> SDIO_ID=02D0:AAE7
> SDIO_REVISION=0.0
> MODALIAS=sdio:c00v02D0dAAE7
> 
> NB: 0xaae7 = 43751

I have run into another issue.

The WiFi device (and the mmc2 bus it sits on) don't show up at all
in the kernel log *unless* I add lots of debug output, such as with
#define DEBUG in drivers/base/dd.c

I think this points to some kind of race condition?

Neil suggested that maybe the host probes the mmc2 bus "too soon",
when the WiFi device is still powering up, which makes the entire
probe fail.

This patch appears to solve the symptom:

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b477..999b3843c0d0b 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1400,7 +1400,7 @@ static struct platform_driver meson_mmc_driver = {
 	.remove		= meson_mmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.of_match_table = meson_mmc_of_match,
 	},
 };

But this might just be delaying the probe enough for the device
to become ready?

Ideas/Suggestions?

Regards

