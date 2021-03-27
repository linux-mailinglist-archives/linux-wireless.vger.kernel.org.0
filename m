Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4034B7FA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC0P0o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 11:26:44 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38551 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0P0b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 11:26:31 -0400
Received: by mail-oi1-f182.google.com with SMTP id f9so8834127oiw.5;
        Sat, 27 Mar 2021 08:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I893goob5tyFPm294vsvQykX3BuSFmnVNehAgzju890=;
        b=A6ASaOW57tMuOJIyh+YXG0i6QmUVzm2Aj9mX6iV5PLpB2z4jDVfX2Djh6Gbhg2rtND
         o8Vty7nkuhCt70AM6UC/C1B7af4Z46Tr81rdSCMaIMqXxuq1a7ISfNd3i7QKBRrHhUgu
         n9BXp1JnSo4URZN3gyXG0Af11xZ8VFS49UoNomoFjHeH3536o4T4Qv7cus9hZXRGar/U
         vSW1oJtPuvGCzCN1zfFrG9fpJR1UkVMHGYFwZpVipOjtemZgot71l4HR+EiTd4D1Bf0A
         h/N5QZtNUeW++0EHekp65+NrFzZIiFZL+QfazS4TquylUYlhPe7/rCwoLbQqBNN89fGE
         cAfw==
X-Gm-Message-State: AOAM530OPIb2wjGE8Cay6tx8Ej8DSXp2mCm8/jYpk8mEGL7dTMR6EOGo
        hVItg/3piqhDcw6LL+ebJw==
X-Google-Smtp-Source: ABdhPJzza96DSk99NTu0KO32DLmMvL27GelIvyg54zLrp08mra9FN88AsscFAUa5Rp+gACJsjPBkUw==
X-Received: by 2002:a05:6808:8e4:: with SMTP id d4mr13926258oic.114.1616858790880;
        Sat, 27 Mar 2021 08:26:30 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.102.185])
        by smtp.gmail.com with ESMTPSA id j72sm2436587oih.46.2021.03.27.08.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:26:29 -0700 (PDT)
Received: (nullmailer pid 147646 invoked by uid 1000);
        Sat, 27 Mar 2021 15:26:25 -0000
Date:   Sat, 27 Mar 2021 09:26:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings:net:wireless:mediatek,mt76: txt to
 yaml conversion
Message-ID: <20210327152625.GA140118@robh.at.kernel.org>
References: <cover.1616621229.git.lorenzo@kernel.org>
 <ccfdfb7236cc12e7f78d89e640a6b02b8e9b7bfb.1616621229.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfdfb7236cc12e7f78d89e640a6b02b8e9b7bfb.1616621229.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 24, 2021 at 10:50:00PM +0100, Lorenzo Bianconi wrote:
> Convert mt76 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   |  78 -----------
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 122 ++++++++++++++++++
>  2 files changed, 122 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> deleted file mode 100644
> index ab7e7a00e534..000000000000
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -* MediaTek mt76xx devices
> -
> -This node provides properties for configuring the MediaTek mt76xx wireless
> -device. The node is expected to be specified as a child node of the PCI
> -controller to which the wireless chip is connected.
> -
> -Alternatively, it can specify the wireless part of the MT7628/MT7688 or
> -MT7622 SoC. For SoC, use the following compatible strings:
> -
> -compatible:
> -- "mediatek,mt7628-wmac" for MT7628/MT7688
> -- "mediatek,mt7622-wmac" for MT7622
> -
> -properties:
> -- reg: Address and length of the register set for the device.
> -- interrupts: Main device interrupt
> -
> -MT7622 specific properties:
> -- power-domains: phandle to the power domain that the WMAC is part of
> -- mediatek,infracfg: phandle to the infrastructure bus fabric syscon node
> -
> -Optional properties:
> -
> -- ieee80211-freq-limit: See ieee80211.txt
> -- mediatek,mtd-eeprom: Specify a MTD partition + offset containing EEPROM data
> -- big-endian: if the radio eeprom partition is written in big-endian, specify
> -  this property
> -- mediatek,eeprom-merge-otp: Merge EEPROM data with OTP data. Can be used on
> -  boards where the flash calibration data is generic and specific calibration
> -  data should be pulled from the OTP ROM
> -
> -The MAC address can as well be set with corresponding optional properties
> -defined in net/ethernet.txt.
> -
> -Optional nodes:
> -- led: Properties for a connected LED
> -  Optional properties:
> -    - led-sources: See Documentation/devicetree/bindings/leds/common.txt
> -
> -&pcie {
> -	pcie0 {
> -		wifi@0,0 {
> -			compatible = "mediatek,mt76";
> -			reg = <0x0000 0 0 0 0>;
> -			ieee80211-freq-limit = <5000000 6000000>;
> -			mediatek,mtd-eeprom = <&factory 0x8000>;
> -			big-endian;
> -
> -			led {
> -				led-sources = <2>;
> -			};
> -		};
> -	};
> -};
> -
> -MT7628 example:
> -
> -wmac: wmac@10300000 {
> -	compatible = "mediatek,mt7628-wmac";
> -	reg = <0x10300000 0x100000>;
> -
> -	interrupt-parent = <&cpuintc>;
> -	interrupts = <6>;
> -
> -	mediatek,mtd-eeprom = <&factory 0x0000>;
> -};
> -
> -MT7622 example:
> -
> -wmac: wmac@18000000 {
> -	compatible = "mediatek,mt7622-wmac";
> -	reg = <0 0x18000000 0 0x100000>;
> -	interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
> -
> -	mediatek,infracfg = <&infracfg>;
> -
> -	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
> -};
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> new file mode 100644
> index 000000000000..65b2d82caad4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/mediatek,mt76.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek mt76 wireless devices Generic Binding
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +  - Ryder Lee <ryder.lee@mediatek.com>
> +
> +description: |
> +  This node provides properties for configuring the MediaTek mt76xx
> +  wireless device. The node is expected to be specified as a child
> +  node of the PCI controller to which the wireless chip is connected.
> +  Alternatively, it can specify the wireless part of the MT7628/MT7688
> +  or MT7622 SoC.
> +
> +allOf:
> +  - $ref: ieee80211.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt76
> +      - mediatek,mt7628-wmac
> +      - mediatek,mt7622-wmac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the infrastructure bus fabric syscon node.
> +      This property is MT7622 specific
> +
> +  ieee80211-freq-limit:
> +    $ref: ieee80211.yaml#

Drop the $ref.

Just 'ieee80211-freq-limit: true' unless there are some constraints you 
can define like how many entries.

> +
> +  mediatek,mtd-eeprom:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle to a MTD partition + offset containing EEPROM data
> +
> +  big-endian:
> +    type: boolean
> +    description:
> +      Specify if the radio eeprom partition is written in big-endian

That's not how this property is defined. It applied to how 'reg' is 
accessed. But I guess it's already used...

> +
> +  mediatek,eeprom-merge-otp:
> +    type: boolean
> +    description:
> +      Merge EEPROM data with OTP data. Can be used on boards where the flash
> +      calibration data is generic and specific calibration data should be
> +      pulled from the OTP ROM
> +
> +  led:
> +    type: object
> +    $ref: /schemas/leds/common.yaml#
> +    additionalProperties: false
> +    properties:
> +      led-sources:
> +        maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

'additionalProperties: false' should work here and is a bit stricter.

> +
> +examples:
> +  - |
> +    pcie0 {
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      wifi@0,0 {
> +        compatible = "mediatek,mt76";
> +        reg = <0x0000 0 0 0 0>;
> +        ieee80211-freq-limit = <5000000 6000000>;
> +        mediatek,mtd-eeprom = <&factory 0x8000>;
> +        big-endian;
> +
> +        led {
> +          led-sources = <2>;
> +        };
> +      };
> +    };
> +
> +  - |
> +    wifi@10300000 {
> +      compatible = "mediatek,mt7628-wmac";
> +      reg = <0x10300000 0x100000>;
> +
> +      interrupt-parent = <&cpuintc>;
> +      interrupts = <6>;
> +
> +      mediatek,mtd-eeprom = <&factory 0x0>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    wifi@18000000 {
> +      compatible = "mediatek,mt7622-wmac";
> +      reg = <0x10300000 0x100000>;
> +      interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
> +
> +      mediatek,infracfg = <&infracfg>;
> +
> +      power-domains = <&scpsys 3>;
> +    };
> -- 
> 2.30.2
> 
