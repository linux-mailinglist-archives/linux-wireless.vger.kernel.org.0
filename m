Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB772A42C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFIUOX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFIUOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 16:14:22 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB9B9;
        Fri,  9 Jun 2023 13:14:21 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33b04c8f3eeso8724765ab.0;
        Fri, 09 Jun 2023 13:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341660; x=1688933660;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dm3YQcYKNWwZSM4iR7CtEb9BHyaQ/m2Q8HtJl86RiRU=;
        b=T9GSe8ftSsJ0da+//C8PGdR6Luu791ezmPHJ2RfhMCWyv/SeTvmuwl/NHP9TR7HkvJ
         WGzwC9HJ/QY50hysPfnkPK+q7MZ4UNGsnkWIc3QQhHBH1hT8c8bUMDaGy/J/DVp2e+8X
         miytYSeVv6dmlHCI9Rg0ughOFV7TX11cRB2Xt1WqZipUck82KD+Yz6DoIbNmPiFvbhrq
         hAtxdZPdfLz5gfMDazu6+7/aPjXKUPZuP7qoQvMMxEbkSLdixF4TpWT8XP8VAvpIKn02
         HtxE1VhlUDnQqR+Z8IYhQDnrQjLb/LnJGsONwmFSlkzAjQcdZ1o8rlBLET2+QrpoVNEN
         xegw==
X-Gm-Message-State: AC+VfDyVkO/rXRZdECROA/AR0bIbzcr3DXHx1lc1Pw7HtohWwKSEPMvd
        MTt3FkwemfvfdmzRb3jfIa5D+5N72g==
X-Google-Smtp-Source: ACHHUZ5HLQ62qVYYmTaI/TXCWHChzO0EtCriKFYSmrqmniVxwa3NdMPVMwSdaJU0phW928qsX1qZPw==
X-Received: by 2002:a92:cd4a:0:b0:33e:8adf:17a with SMTP id v10-20020a92cd4a000000b0033e8adf017amr2321162ilq.16.1686341660462;
        Fri, 09 Jun 2023 13:14:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g9-20020a926b09000000b0033e4937640esm1257957ilc.80.2023.06.09.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:14:19 -0700 (PDT)
Received: (nullmailer pid 2082637 invoked by uid 1000);
        Fri, 09 Jun 2023 20:14:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, ath10k@lists.infradead.org,
        kvalo@kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org
In-Reply-To: <f30552d1bfdb4c56f99ca79d8fbf52d3fcf71686.1686331623.git.chunkeey@gmail.com>
References: <f30552d1bfdb4c56f99ca79d8fbf52d3fcf71686.1686331623.git.chunkeey@gmail.com>
Message-Id: <168634165805.2082604.10984266765372350762.robh@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: net: wireless: ath10k: add
 ieee80211-freq-limit property
Date:   Fri, 09 Jun 2023 14:14:18 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Fri, 09 Jun 2023 19:27:23 +0200, Christian Lamparter wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> The driver supported this since ~2018 by
> commit 34d5629d2ca8 ("ath10k: limit available channels via DT ieee80211-freq-limit")
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> 
> Note: this is for ath10k. The other patch is for a different driver (ath11k).
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml:171:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/net/wireless/qcom,ath10k.example.dts'
Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml:171:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/wireless/qcom,ath10k.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml:171:1: found duplicate key "allOf" with value "[]" (original value: "[]")
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 62, in <module>
    ret |= check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 31, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line 736, in iter_schema_errors
    cls.annotate_error(error, meta_schema, error.schema_path)
  File "/usr/local/lib/python3.10/dist-packages/dtschema/lib.py", line 712, in annotate_error
    schema = schema[p]
KeyError: 'type'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f30552d1bfdb4c56f99ca79d8fbf52d3fcf71686.1686331623.git.chunkeey@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

