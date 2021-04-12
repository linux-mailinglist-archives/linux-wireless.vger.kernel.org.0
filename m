Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5A35D0C6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbhDLTG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 15:06:58 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36678 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbhDLTG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 15:06:56 -0400
Received: by mail-oi1-f176.google.com with SMTP id c16so14527076oib.3;
        Mon, 12 Apr 2021 12:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tF65GDCq8/c2QBhyvuAXcU4LBayB7FvPQt7YSigAsg0=;
        b=HJWMcwsTLMrrl21Kziya+/nQCJQXJRKYvYPBT74Lp3+tAYCNj8R2aGz0M/uvgUoXKt
         Y/+RL/EYXZBlKm2NaZXqYDzFta/V/x7cmpCim6/1asW4xm055IC1OSjblJ4OWAIrSIL/
         T1wtFBMF8TSkqBeRgpe8gaNBJ9RDszXX495uaGaycBSt5EzZHQ6zb/Ay41TxaQ4VTntV
         UrQAJbRYVXP2SapxcKReAk1lqQeiR8OZ/tTtJBwB33FaC6evaltLmyM+8MSxVuR+9Ska
         atH2ltMyIyc1L15s0yBXo7IBIVQhwCxyfk7B+Z4nbRCe8b6+3rt7txEKo+juLFID/1gO
         8EWQ==
X-Gm-Message-State: AOAM532ExxE2zCNZsN/nQ6d4HgG5FJGCRndFtwe0ear08yHDhyRgPMno
        GMeogeaRfIJV+coXBZXMlw==
X-Google-Smtp-Source: ABdhPJw2kgDZjayu+yWTWkeg8od38dM/ff2h0jGstYRyL7rXobLt+cTYs/rvQPBwysVOySSQBCBJqA==
X-Received: by 2002:aca:cfce:: with SMTP id f197mr482567oig.164.1618254397377;
        Mon, 12 Apr 2021 12:06:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm2329668oou.26.2021.04.12.12.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:06:36 -0700 (PDT)
Received: (nullmailer pid 15970 invoked by uid 1000);
        Mon, 12 Apr 2021 19:06:35 -0000
Date:   Mon, 12 Apr 2021 14:06:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings:net:wireless:mediatek,mt76: introduce
 power-limits node
Message-ID: <20210412190635.GA4168984@robh.at.kernel.org>
References: <cover.1618008449.git.lorenzo@kernel.org>
 <5712c0901cd826d49f881b6c632df35db1678a37.1618008449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5712c0901cd826d49f881b6c632df35db1678a37.1618008449.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Apr 10, 2021 at 12:51:46AM +0200, Lorenzo Bianconi wrote:
> Introduce power-limits node in mt76 binding in order to specify
> per-rate power limit values for each 802.11n/802.11ac rate
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index d6f835d17d66..f459323b8972 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -72,6 +72,79 @@ properties:
>        led-sources:
>          maxItems: 1
>  
> +  power-limits:
> +    type: object

       additionalProperties: false

> +    patternProperties:
> +      "^r[0-9]+":
> +        type: object

           additionalProperties: false
         
> +        properties:
> +          regdomain:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description:
> +              Regdomain refers to a legal regulatory region. Different
> +              countries define different levels of allowable transmitter
> +              power, time that a channel can be occupied, and different
> +              available channels
> +            enum:
> +              - FCC
> +              - ETSI
> +              - JP
> +
> +        patternProperties:
> +          "^txpower-[256]g$":
> +            type: object

               additionalProperties: false

> +            patternProperties:
> +              "^b[0-9]+$":
> +                type: object

                   additionalProperties: false

> +                properties:
> +                  channels:
> +                    $ref: /schemas/types.yaml#/definitions/uint32-array
> +                    minItems: 2
> +                    maxItems: 2
> +                    description:
> +                      Pairs of first and last channel number of the selected
> +                      band
> +
> +                  rates-cck:
> +                    $ref: /schemas/types.yaml#/definitions/uint8-array
> +                    minItems: 4
> +                    maxItems: 4
> +                    description:
> +                      4 half-dBm per-rate power limit values
> +
> +                  rates-ofdm:
> +                    $ref: /schemas/types.yaml#/definitions/uint8-array
> +                    minItems: 8
> +                    maxItems: 8
> +                    description:
> +                      8 half-dBm per-rate power limit values
> +
> +                  rates-mcs:
> +                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
> +                    description:
> +                      Sets of per-rate power limit values for 802.11n/802.11ac
> +                      rates for multiple channel bandwidth settings.
> +                      Each set starts with the number of channel bandwidth
> +                      settings for which the rate set applies, followed by
> +                      either 8 or 10 power limit values. The order of the
> +                      channel bandwidth settings is 20, 40, 80 and 160 MHz.

This can be expressed as a schema:

maxItems: 4
items:
  minItems: 9
  maxItems: 11

> +
> +                  rates-ru:
> +                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
> +                    description:
> +                      Sets of per-rate power limit values for 802.11ax rates
> +                      for multiple channel bandwidth or resource unit settings.
> +                      Each set starts with the number of channel bandwidth or
> +                      resource unit settings for which the rate set applies,
> +                      followed by 12 power limit values. The order of the
> +                      channel resource unit settings is RU26, RU52, RU106,
> +                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.


items:
  minItems: 13
  maxItems: 13

> +
> +                  txs-delta:
> +                    $ref: /schemas/types.yaml#/definitions/uint32-array
> +                    description:
> +                      Half-dBm power delta for different numbers of antennas
> +
>  required:
>    - compatible
>    - reg
> @@ -93,6 +166,29 @@ examples:
>          led {
>            led-sources = <2>;
>          };
> +
> +        power-limits {
> +          r0 {
> +            regdomain = "FCC";
> +            txpower-5g {
> +               b0 {
> +                   channels = <36 48>;
> +                   rates-ofdm = /bits/ 8 <23 23 23 23 23 23 23 23>;
> +                   rates-mcs = /bits/ 8 <1 23 23 23 23 23 23 23 23 23 23>,
> +                                        <3 22 22 22 22 22 22 22 22 22 22>;
> +                   rates-ru = /bits/ 8 <3 22 22 22 22 22 22 22 22 22 22 22 22>,
> +                                       <4 20 20 20 20 20 20 20 20 20 20 20 20>;
> +               };
> +               b1 {
> +                   channels = <100 181>;
> +                   rates-ofdm = /bits/ 8 <14 14 14 14 14 14 14 14>;
> +                   rates-mcs = /bits/ 8  <4 14 14 14 14 14 14 14 14 14 14>;
> +                   txs-delta = <12 9 6>;
> +                   rates-ru = /bits/ 8  <7 14 14 14 14 14 14 14 14 14 14 14 14>;
> +               };
> +             };
> +          };
> +        };
>        };
>      };
>  
> -- 
> 2.30.2
> 
