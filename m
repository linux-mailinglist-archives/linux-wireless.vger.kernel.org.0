Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1877242839B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Oct 2021 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhJJUy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Oct 2021 16:54:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35518
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhJJUy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Oct 2021 16:54:58 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7AFD83F324
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633899178;
        bh=VUoZvUcEz5W61r6JJ0vnYx7Iv2cJ136M8cBt3vNkKRo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Cg6GwNaIpXwBsjoB2F2R5WeCYlJG/1vXNWTvJjDwvb401T8dudGZIiZ6AJKwmhvcW
         /WxPq4qGvcFzqPXCSStGIlh/8avTGjkhoCTuTCirk/a02BOKESLkUicK1ssuk+4+8/
         2LkLhjnrPcajpYOHpOpeg2NmbfN94M8WxGnnfgUXw5JwJRzGTrRXa5he+v0lMT4QNn
         0M4AHLCp1AW35YVwqgHRH9mE3x17hbCbhpAozLD4k72pop/Y/P8WIfl3r8UAmOwXly
         jvr624nYId3tlIApY95NN7y7VrLDIi/yigCILsUmfMnHxyA7zzafW+ENwlFbDd0KUX
         tbF6vwg8Ak6mg==
Received: by mail-ed1-f72.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so3022328edx.13
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 13:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUoZvUcEz5W61r6JJ0vnYx7Iv2cJ136M8cBt3vNkKRo=;
        b=LuYXApnG1puHEvjGY1Mg0BZKjUveq6oiZCUBkA/zCz+3To7uSZrq8zFZVOXIAVowNS
         qWG7FwXnZukeza0lYxMhA87nhSiCwRvxHm4LEmgpnS9+GDBLPLA17DoKkOazqcA9gAIk
         E+YlOmq80dR4pNHNPzffw6gguVaXSpIppDAJ6X4WdlGQVs/oNVOr51YJoScthK7fdWco
         hshG8y6VfFYMLrlF1lOepAf6ymRB/RBrw8a2opNFZs0HSa8cAokXD/hmFhP0mrlvS2Fo
         I6JF/IUlELdBPHDUlj6c9k2A25xmcoFO6ici9f3gXMeiZNieRhaUP8QN8SDuW+3YDWzL
         AGQg==
X-Gm-Message-State: AOAM531PbrmBi+9APV/kQeZ/TS4egNcu1RCcrAOieNer58fmymF9+HLg
        xovkqkOIENzul9x+TXP3zst5VasgrIpHHvjmXQcJ7EhhbDrHLDyEXiOAlMWUQ5Bm1LAKqKX/p6Z
        rBlfoQAMSlXvsOcd2k9HhfZeqrzmqbhCG+qInR9FVBOah
X-Received: by 2002:a17:906:d0c3:: with SMTP id bq3mr21252748ejb.277.1633899178188;
        Sun, 10 Oct 2021 13:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUsaX5GVNNhedfg3aGctYY89+Bp8z44cavbVqI0d3fIzvOES2m0gz5xMXHfGP+pcKi3YgXYA==
X-Received: by 2002:a17:906:d0c3:: with SMTP id bq3mr21252732ejb.277.1633899178038;
        Sun, 10 Oct 2021 13:52:58 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w2sm3061619edj.44.2021.10.10.13.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 13:52:57 -0700 (PDT)
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
Message-ID: <0e26d0e6-9468-63b5-a357-af4c4e7ec677@canonical.com>
Date:   Sun, 10 Oct 2021 22:52:56 +0200
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
> nfc@28: compatible:0: 'nxp,nxp-nci-i2c' was expected
> 	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
> 
> nfc@28: compatible: Additional items are not allowed ('nxp,nxp-nci-i2c' was unexpected)
> 	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
> 
> nfc@28: compatible: ['nxp,pn547', 'nxp,nxp-nci-i2c'] is too long
> 	arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dt.yaml
> 
> nfc@30: 'clock-frequency' is a required property
> 	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml
> 
> nfc@30: compatible:0: 'nxp,nxp-nci-i2c' was expected
> 	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml
> 
> nfc@30: compatible: Additional items are not allowed ('nxp,nxp-nci-i2c' was unexpected)
> 	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml
> 
> nfc@30: compatible: ['nxp,pn547', 'nxp,nxp-nci-i2c'] is too long
> 	arch/arm/boot/dts/ste-ux500-samsung-janice.dt.yaml
> 

I missed that new compatible. I'll send a patch adding nxp,nxp-nci-i2c
and try to fix the DTS (missing clock-frequency).

Best regards,
Krzysztof
