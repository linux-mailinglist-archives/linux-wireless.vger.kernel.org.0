Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB35A6AA0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiH3Rbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiH3RbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 13:31:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7B12EC6C
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 10:27:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id by6so12105041ljb.11
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KgBuun5MUMbC1cLHpEsYOW1ltE2MSZUVgIoptXfoUwU=;
        b=PHQq8Bm1Aa8YGdbMElujp9pCW2YsHrzcvSqwHbA/ocHa8ELvDwUfUUqGsjHz/KK3QP
         mMeNiQrIvUcjRCAmKhiAYPbfH0v7xgkrb/atZgLSKAhFVaw80k9efhb8hmYUTz0LsvGz
         K+TJid5kHjDJqYbqZcT695AA2oUccvIugvOhv/cOGpneAwHI/4J+WnvHBWgpXkGUbG0M
         AH2qqVpxMdklLa6+q4KFlVgL4FeVQJejFdHYvx0hc/i0xA/qN9IzUNFbpKxJUHUHylbh
         UshwJkOuAOf4FohPIvyKjz9c6gRQdCs+IQ3CraCSg0j5QPYzdKKkQJQSwajFheM7jLSn
         wn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KgBuun5MUMbC1cLHpEsYOW1ltE2MSZUVgIoptXfoUwU=;
        b=AjazL+vtHJoU9tXSRLCDy6OUHJUhrPLPtILkUo9z9KShdN53S9T3SKqLEPv34SoFTX
         swlw/leguqVss8aLT0IP/0zQ63IqukOTmeAFP0t6MJR4ehwWWvGsd1bRD8a+nSD/QXsL
         ua4v4Nm+HmrIJn8SYdj5/2rrdc9UfEjhHM5icSH5xn6iTQKN05O6QqLDCChira8P5/NB
         /MlwBJmN8JTAb2Ev2LD1ms/GZUpyXXoCSVr4i7xU+i/P23opWtNCeqnLiRADcmlkePq/
         Dx6BXl2CdtmGGbxMqaxZUJ6wmymwpymOgk/VEA6elI6FT3GAJu99i0WLDvWt/0D2Q3et
         hd7w==
X-Gm-Message-State: ACgBeo10QjhRkhVhAKAsnvrvEbAGC84ZwCtWrbwjsyV4cZ85rT8QD0RF
        kNsB9znS0Zje2ZLsxalqGr7prQ==
X-Google-Smtp-Source: AA6agR7AMkNLzldsN7CSndDsJ/IajUZ+QIqAcfUHAeF1dxFSuX7EUio6GcUstiS8SvFpou+/tJ1xFw==
X-Received: by 2002:a2e:8857:0:b0:261:b1b3:ab93 with SMTP id z23-20020a2e8857000000b00261b1b3ab93mr7776341ljj.270.1661880357694;
        Tue, 30 Aug 2022 10:25:57 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c11-20020a19654b000000b0049461118812sm270646lfj.285.2022.08.30.10.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:25:57 -0700 (PDT)
Message-ID: <3b169ca3-2962-339f-c8cb-c48ac41c9aa5@linaro.org>
Date:   Tue, 30 Aug 2022 20:25:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt: bindings: net: add bindings to add WoW support
 for WCN6750
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
References: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
 <20220829124323.26874-2-quic_mpubbise@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829124323.26874-2-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 29/08/2022 15:43, Manikanta Pubbisetty wrote:
> Add required bindings to support WoW (Wake on Wireless) for
> WCN6750 which is based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Use scripts/get_maintainers.pl to CC all maintainers and relevant
mailing lists.

> ---
>  .../bindings/net/wireless/qcom,ath11k.yaml      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index a677b056f112..307a5b9d1588 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -66,6 +66,14 @@ properties:
>      required:
>        - iommus
>  
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: State bits used in WCN6750 to signal the firmware
> +                 to exit from WoW.

You need to describe the item (s).

> +
> +  qcom,smem-state-names:
> +    description: The names of the state bits used for SMP2P output

You need to describe the item (s).

> +
>  required:
>    - compatible
>    - reg
> @@ -410,6 +418,13 @@ examples:
>          };
>      };
>  
> +    smp2p-wpss {
> +        wlan_smp2p_out: wlan_smp2p_out {

No underscores in node names. This example is incomplete and I am not
sure what is the benefit of adding provider example to the consumer
binding... Just skip it.

Best regards,
Best regards,
Krzysztof
