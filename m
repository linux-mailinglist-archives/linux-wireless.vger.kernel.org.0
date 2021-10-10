Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00114283A4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Oct 2021 22:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJJVBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Oct 2021 17:01:02 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49248
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhJJVBB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Oct 2021 17:01:01 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 937F840012
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633899541;
        bh=vbA6KQmT88TPosyqyyvRSbT6u/s6NWq+qTxHMzpWCdA=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=aafMjLiidKOfsoeaHM20W+8ZulnVY8h64S3f2lL0Tno1x5kCfuGvMWH3BUYRAM+t7
         NXmC7wXvSoh8XdQ33xM4nOD12sSM7Ej1sfMpQ4xNUmOTqVjn3LiFM3xljxa7G1PVle
         MLacPZYnipHWZY65L+IhVDSegidceVU1uQlBvT9/Xl1E4iS1vXJBlvfyMgAhRVIqi0
         IChraGyGK0wMiLfMZbzJOI2ioEDP6YqlV6TT+2WedGkk5VEZcuIl6LDU+ICtL4eu9w
         lafKR3Xto5h0HnWLl6gNrBf6mufPBAlwPraDSdK3NOA008yccTM3/7f+2LePYvh7O3
         I5rBP990MTXWw==
Received: by mail-ed1-f69.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so3028687edx.13
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 13:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbA6KQmT88TPosyqyyvRSbT6u/s6NWq+qTxHMzpWCdA=;
        b=JQ5ScuoN3TP37yeG2/4GZByAGIPnnGHKhqsLNgVvpmb9OKOI5SnnMmelMnngpu+g41
         KMAK3uy29jlPavGqHTyxwoTwJmC+0AUE5XjOmZRrHIwlu+YC2FiXPqQIDYRXw0hMBHRR
         NwrgAiQ3drNVCv+uQOsDzjDBKC3eH7OUvtgEVNgsaBCkk9E+DCaPF5ccqR8SBBlifGM+
         2Vb4DfETXuToyORZe5jE/AOrdBXFeTfLaghAcM/IoHU/D3t6t2A4IJsTIccIosbM3nlb
         Pf4Ta2taxBy/SdT/G14BdHW2KtYQ1tn8ABLS2C7wV5iHxX33awzkQK4wOFq/29t8iDNJ
         F0AQ==
X-Gm-Message-State: AOAM531BNleRms+oKy6sDqLUm4TcR2e+ek1NkNkwXzPs9wj9uE1B865K
        /9iHUnADgwt/NtpUfjd4qf09qtKO76og2XQCHJNYpAZUtiztb5cQ7c3ahlJRGL0Nx1qnyU1V6pL
        P0bQe0gc4eyhqVvm4xhhBFQ/AgbtHJfEIJWd/7Wxbz/yU
X-Received: by 2002:a05:6402:1941:: with SMTP id f1mr8554629edz.3.1633899541309;
        Sun, 10 Oct 2021 13:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFdhFoFHiozNsDRv0hkz318JVGkZTHVd/QS3nQ6sTbPFwP2FFLCChwQCYgJKHsOaeft+JO3g==
X-Received: by 2002:a05:6402:1941:: with SMTP id f1mr8554606edz.3.1633899541074;
        Sun, 10 Oct 2021 13:59:01 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id fx4sm2495638ejb.113.2021.10.10.13.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 13:59:00 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: nfc: nxp,nci: convert to dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     linux-nfc@lists.01.org, devicetree@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>
References: <20211010142317.168259-1-krzysztof.kozlowski@canonical.com>
 <1633894316.441793.3158669.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f955726a-eb2d-7b3e-9c5f-978358710eb6@canonical.com>
Date:   Sun, 10 Oct 2021 22:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633894316.441793.3158669.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/10/2021 21:31, Rob Herring wrote:
> On Sun, 10 Oct 2021 16:23:11 +0200, Krzysztof Kozlowski wrote:
>> Convert the NXP NCI NFC controller to DT schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../devicetree/bindings/net/nfc/nxp,nci.yaml  | 61 +++++++++++++++++++
>>  .../devicetree/bindings/net/nfc/nxp-nci.txt   | 33 ----------
>>  MAINTAINERS                                   |  1 +
>>  3 files changed, 62 insertions(+), 33 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1539010
> 
> 
> nfc@28: 'clock-frequency' is a required property
> 	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
> 

Hmm, this actually looks as mistake in bindings. First, clock-frequency
is a property of a I2C bus, not I2C child device. Second, it should not
be a required property anyway, as I2C will choose a default one matching
driver (e.g. standard speed of 100 kHz).

Except the trf7970a NFC driver, none of other NFC drivers parse the
clock-frequency.

Best regards,
Krzysztof
