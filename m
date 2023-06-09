Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59472A0A1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFIQvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFIQvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 12:51:11 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378E2D7E;
        Fri,  9 Jun 2023 09:51:07 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77807e43b7cso89126339f.1;
        Fri, 09 Jun 2023 09:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329466; x=1688921466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSSJEKpJS9ep8WBVYc80IqXbeNN7GGka4ikEwnoQKkY=;
        b=F9CfWL8DkCdcOgLQ6vQ6+ZTfr6P5b6V2qQNUVOb8mBpHq3C+JUdld5UHM/w4sGiMf6
         cHvSsO3QnRNo3TPCQT7S1doTyKi1zAFSJWcYnIJvdyxb4iR+kEyvKbjs+ZRhVqg7KDTD
         Awi9Pij1GrA3K6piwkq+M5mvYHlrIm7N1Dor15g0fny1vwS8PmIR/jQn7ii7uWze7M3v
         3gJ/Cn3KujfrvGNLK+7PVK4ykQdP8qOfzWR8UFJcsn5WMi+sOq9SmEGVC1VRumLMTseu
         xiayxUUQK00BiVuVzNt6H88rENiBn4B/0C6qHiNGPaAq7onh3S43MXe33y/jDfxnQ6t0
         JIUQ==
X-Gm-Message-State: AC+VfDwzPc96ibpYAZA9ORWV9r4Ewpzw+Ae+AEYD6JGJi9zK7pkr3Eym
        fe3eB1CfEqT/b/fWNWfmiA==
X-Google-Smtp-Source: ACHHUZ5ZEtQEXRaoNcL0DnxR5zhTN2IfUfFuYLnnfKE0ET+R0URsKnN0RwzwLGQ61w7QMCZNNrFA1Q==
X-Received: by 2002:a6b:4401:0:b0:774:94e1:3aee with SMTP id r1-20020a6b4401000000b0077494e13aeemr2107034ioa.6.1686329466676;
        Fri, 09 Jun 2023 09:51:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j12-20020a02cb0c000000b0041d859c5721sm1054666jap.64.2023.06.09.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:51:05 -0700 (PDT)
Received: (nullmailer pid 1259925 invoked by uid 1000);
        Fri, 09 Jun 2023 16:51:04 -0000
Date:   Fri, 9 Jun 2023 10:51:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/2] dt-bindings: net: ath11k: add
 ieee80211-freq-limit property
Message-ID: <20230609165104.GA1257474-robh@kernel.org>
References: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 09, 2023 at 10:44:54AM +0200, Christian Lamparter wrote:
> This is an existing optional property that ieee80211.yaml/cfg80211
> provides. It's useful to further restrict supported frequencies
> for a specified device through device-tree.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index 7d5f982a3d09..91bf69c2df01 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -58,6 +58,8 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  ieee80211-freq-limit: true
> +

You need a ref to ieee80211.yaml as well.

>    wifi-firmware:
>      type: object
>      description: |
> -- 
> 2.40.1
> 
