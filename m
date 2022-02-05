Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9568E4AA58E
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 03:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378943AbiBECJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 21:09:17 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33447 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356172AbiBECJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 21:09:17 -0500
Received: by mail-oi1-f171.google.com with SMTP id x193so10759206oix.0;
        Fri, 04 Feb 2022 18:09:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlm/DoIWX/vryslRDMyLqsOKh1vDr7UP4z3/6RoNcP0=;
        b=DeU+AXNHm1G/NZH9dMrcOTcUumvtZd4sjT8dGOTc6MJ60GiBk4e8K0vCvP29F+mz8k
         BPA0MjTBzgZLLNhKmjRjVE/2uOZlanYDvRgtcXlS2zYkB3aBatNlYecg/m/jCOzvcys4
         R76Npx0q4+GqQ5hzNWoLDtnIgYvB++y9tphOdC2WzBZbTSqCXDG7pDgwJrCO4Z3Cr/BT
         uC7wpT3MHeEL31jCvTyk+2HGl6NRytv/EfUx5i2rlDhZ7uJaLNHx83QSBkIin1SR6Q3T
         pVcMnI2L46lpMtGa66AmTc+k7GcXH4bfO4TceeIJ+IXq/QVfqVwEt7AeivskaqBGmQJF
         L8iQ==
X-Gm-Message-State: AOAM530Yxn8gHUrIpD4OEseOPX6sfvgrHFHd71MS1NtbKn9WRTRObPCX
        CbD2EOSJGUtUCRidIhLyDcoy4f8vFg==
X-Google-Smtp-Source: ABdhPJyVS0PG5yTiDBcZK/QCZ0tOeDl6uPjDN421zx47NmuJYe9hhhMoFBleBbSxq0pBVid0d/dinw==
X-Received: by 2002:a05:6808:14c1:: with SMTP id f1mr865934oiw.12.1644026956758;
        Fri, 04 Feb 2022 18:09:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g4sm1365784otl.1.2022.02.04.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:09:16 -0800 (PST)
Received: (nullmailer pid 3610125 invoked by uid 1000);
        Sat, 05 Feb 2022 02:09:15 -0000
Date:   Fri, 4 Feb 2022 20:09:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: wireless: mt76: document
 bindings for MT7986
Message-ID: <Yf3cSyKJz9ymj+Fq@robh.at.kernel.org>
References: <cover.1642128031.git.Bo.Jiao@mediatek.com>
 <c6a6ddd797269ea92698f612d6b7c66c9ec03765.1642128031.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a6ddd797269ea92698f612d6b7c66c9ec03765.1642128031.git.Bo.Jiao@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 14, 2022 at 10:53:20AM +0800, Bo Jiao wrote:
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Add an entry for MT7986 SoC.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Cc: devicetree@vger.kernel.org
> ---
> v3:
>  - fix yamllint warnings and errors
>  - add 'minItems: 1' to keep 1 reg entry being valid
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 1489d3c..d630a7e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -18,7 +18,7 @@ description: |
>    wireless device. The node is expected to be specified as a child
>    node of the PCI controller to which the wireless chip is connected.
>    Alternatively, it can specify the wireless part of the MT7628/MT7688
> -  or MT7622 SoC.
> +  or MT7622/MT7986 SoC.
>  
>  allOf:
>    - $ref: ieee80211.yaml#
> @@ -29,9 +29,11 @@ properties:
>        - mediatek,mt76
>        - mediatek,mt7628-wmac
>        - mediatek,mt7622-wmac
> +      - mediatek,mt7986-wmac
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3

With more than 1, you need to define what each one is.

>  
>    interrupts:
>      maxItems: 1
> @@ -39,6 +41,17 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +    description:
> +      Specify the consys reset for mt7986.
> +
> +  reset-name:
> +    const: consys
> +
>    mediatek,infracfg:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -165,7 +178,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> @@ -231,3 +244,15 @@ examples:
>  
>        power-domains = <&scpsys 3>;
>      };
> +
> +  - |
> +    wifi@18000000 {
> +        compatible = "mediatek,mt7986-wmac";
> +        resets = <&watchdog 23>;
> +        reset-names = "consys";
> +        reg = <0x18000000 0x1000000>,
> +              <0x10003000 0x1000>,
> +              <0x11d10000 0x1000>;
> +        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&wmcpu_emi>;
> +    };
> -- 
> 2.18.0
> 
> 
