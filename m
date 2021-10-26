Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2043B489
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhJZOpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhJZOpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626EC061767
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 07:42:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j2so4886605lfg.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Oct 2021 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IeDPLqe3LBKUpRJz9gheIRoaNjTzo/azi2xTKJ59u4Q=;
        b=rtTjZwJ3hBs0LVsm1btVhVOPMJ9I5MezaBoSmoqbce3/qjWaQC2+rhDsqRinNFpWQ9
         XEIv2SKGN2wjW6chPzCLFT9zXOXt09mKGJ/wp/DNysqfz/QAU71tshSVm8II8W/47Zro
         fFViFfYJTYFIggox35NWeXMsLXyiHz4KJZOhp09/tVEVgiKZNFcmb7ZD3JDtHb1fBhVQ
         yS2F4rXj6uNpRlrHm4EgqyOu1tCiRlDKS7dy0yVGyj64Vd+6Vc46iZY7ovCpsczbeLZF
         xEdJJP60JLVtl8SPNzMqy327fFe1kk/K19U6B1zRdDm/RDl/oaOFpQn9GHaOGF5wYdRV
         5zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IeDPLqe3LBKUpRJz9gheIRoaNjTzo/azi2xTKJ59u4Q=;
        b=2IFh/Emn3c87TvGH99vqh4tM2VQJpojXUbvpl5pNJfHecNUHRD4dmg1xR7qkbra8IW
         m8UNPkRjN+pNSjUJ1aroDcTienSo2KEsg1efTs/DgxWfuV2D1pBL4F2TZTFiKw4i6e6v
         FN5RvJ0MxW89/ulCpyj+uaC26+rbynmR/JuOtHZD/Hx72fpmwtKpuQYtiqwDi1FMCPLZ
         oFl/Pu4PR5TuixCvDwMqtBhdorgPVQslDPG46nZ5ApnXJZ/7mT86vtettgFioqRN8Rt4
         t7iZCLAlr6yeRCVwavv2kLtv3JbXz4vJ+rCMcZ3wc2F6mur2cyrRK3JsrB/a/NHSPNbV
         rPaQ==
X-Gm-Message-State: AOAM533MnK9KJyF5qMOM4crR6W4R5kyO6F7F0AocRzcsmMYESnQPexnZ
        AEM0hGidqxtpfEhugcSFJIzqKQ==
X-Google-Smtp-Source: ABdhPJzbC4V4BOc77PUffVI7AxDyDMkYAgocDN0aDe9m5/bXIjvUGOQ5RhLNx5fCyuk5xWO+M9NHyA==
X-Received: by 2002:a05:6512:3407:: with SMTP id i7mr24013249lfr.563.1635259375652;
        Tue, 26 Oct 2021 07:42:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bi9sm2256901lfb.40.2021.10.26.07.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:42:55 -0700 (PDT)
Subject: Re: [PATCH v1 01/15] dt-bindings: add pwrseq device tree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
 <20211006035407.1147909-2-dmitry.baryshkov@linaro.org>
 <YXf6TbV2IpPbB/0Y@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <37b26090-945f-1e17-f6ab-52552a4b6d89@linaro.org>
Date:   Tue, 26 Oct 2021 17:42:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXf6TbV2IpPbB/0Y@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 26/10/2021 15:53, Rob Herring wrote:
> On Wed, Oct 06, 2021 at 06:53:53AM +0300, Dmitry Baryshkov wrote:
>> Add device tree bindings for the new power sequencer subsystem.
>> Consumers would reference pwrseq nodes using "foo-pwrseq" properties.
>> Providers would use '#pwrseq-cells' property to declare the amount of
>> cells in the pwrseq specifier.
> 
> Please use get_maintainers.pl.
> 
> This is not a pattern I want to encourage, so NAK on a common binding.


Could you please spend a few more words, describing what is not 
encouraged? The whole foo-subsys/#subsys-cells structure?

Or just specifying the common binding?

> 
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   .../bindings/power/pwrseq/pwrseq.yaml         | 32 +++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq.yaml b/Documentation/devicetree/bindings/power/pwrseq/pwrseq.yaml
>> new file mode 100644
>> index 000000000000..4a8f6c0218bf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq.yaml
>> @@ -0,0 +1,32 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/pwrseq/pwrseq.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Power Sequencer devices
>> +
>> +maintainers:
>> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> +
>> +properties:
>> +  "#powerseq-cells":
>> +    description:
>> +      Number of cells in a pwrseq specifier.
>> +
>> +patternProperties:
>> +  ".*-pwrseq$":
>> +    description: Power sequencer supply phandle(s) for this node
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    qca_pwrseq: qca-pwrseq {
>> +      #pwrseq-cells = <1>;
>> +    };
>> +
>> +    bluetooth {
>> +      bt-pwrseq = <&qca_pwrseq 1>;
>> +    };
>> +...
>> -- 
>> 2.33.0
>>
>>


-- 
With best wishes
Dmitry
