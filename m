Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADCB48B9F6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 22:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbiAKVxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 16:53:41 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34511 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiAKVxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 16:53:40 -0500
Received: by mail-ot1-f45.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso384464oti.1;
        Tue, 11 Jan 2022 13:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2PErXX1Zu38N/AijxY4TcRNrpCVzT0t6yIta9Nhwho=;
        b=X4cU2RzTG+D8gHwqbyuVeGWgE32DIHwgn5trCarHngiyzHo9KSOGoInacX1cFxwRW6
         +rup8A6OL1Bu/monOc4HP1zaoSI75gvH3a8+DJO0J0yPjlLJH/E9jFq+JdnZPJu4tK+8
         x+regDlr35IULs/8mGzHQ/92ADDxO/OtOJxCHSQ+ckw7rjIL0ObqPjZDu2I1Im+3eZXv
         hHeNSMJZsUxaYiKqzJKGOSHluSnhf0TmDZbnvFZ9o4c8qjy9p7XbHlbK9a8pOsz4YRpd
         AaX27I14VyPBBXgjEQM3tLUQwige17OBrS1UpwS31RS1nLIGePnCGQ8PcmfK53JEOuKd
         3nsg==
X-Gm-Message-State: AOAM530rnMZjUQqSki3XTuRq8xpoMBcNyqvcokyhh431/az5nJYLB0hi
        IG4tR6SU6dPQHTMP4R7jU/8QwlF9sg==
X-Google-Smtp-Source: ABdhPJyhokbTnN7kDaqb7DInRuN4ZE9YSE3zro1thlS1Svg9t/77MACWGuoJyoWh9lwbYtd64YL1kA==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr4649159otq.215.1641938020231;
        Tue, 11 Jan 2022 13:53:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h14sm2268808otr.4.2022.01.11.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:53:39 -0800 (PST)
Received: (nullmailer pid 3570275 invoked by uid 1000);
        Tue, 11 Jan 2022 21:53:38 -0000
Date:   Tue, 11 Jan 2022 15:53:38 -0600
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
Subject: Re: [PATCH v2 1/5] dt-bindings: net: wireless: mt76: document
 bindings for MT7986
Message-ID: <Yd38YhK5IC0PDkVJ@robh.at.kernel.org>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
 <67eb9adaa2ed281cb6b8f3c74afc0cc7081f0f6b.1641901681.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67eb9adaa2ed281cb6b8f3c74afc0cc7081f0f6b.1641901681.git.Bo.Jiao@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 11, 2022 at 07:59:17PM +0800, Bo Jiao wrote:
> From: Peter Chiu <chui-hao.chiu@mediatek.com>
> 
> Add an entry for MT7986 SoC.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 1489d3c..4444524 100644
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
> @@ -29,9 +29,10 @@ properties:
>        - mediatek,mt76
>        - mediatek,mt7628-wmac
>        - mediatek,mt7622-wmac
> +      - mediatek,mt7986-wmac
>  
>    reg:
> -    maxItems: 1
> +    maxItems: 3

You just changed existing users. You need 'minItems: 1' to keep 1 reg 
entry being valid.

>  
>    interrupts:
>      maxItems: 1
> @@ -39,6 +40,17 @@ properties:
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
> @@ -231,3 +243,16 @@ examples:
>  
>        power-domains = <&scpsys 3>;
>      };
> +
> +  - |
> +    #include <dt-bindings/reset/mt7986-resets.h>
> +    wifi@18000000 {
> +        compatible = "mediatek,mt7986-wmac";
> +        resets = <&watchdog MT7986_TOPRGU_CONSYS_RST>;

I'd suggest you don't use the define here to avoid the dependency.

> +        reset-names = "consys";
> +        reg = <0 0x18000000 0 0x1000000>,
> +              <0 0x10003000 0 0x1000>,
> +              <0 0x011d1000 0 0x1000>;
> +        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&wmcpu_emi>;
> +    };
> -- 
> 2.18.0
> 
> 
