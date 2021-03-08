Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05797331AC4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 00:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCHXI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Mar 2021 18:08:26 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:42041 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhCHXIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Mar 2021 18:08:13 -0500
Received: by mail-il1-f173.google.com with SMTP id p10so10431018ils.9;
        Mon, 08 Mar 2021 15:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mKMf2XkDYK89l3qq+xxsOTTt2lx+q19Osp23AWm0jn0=;
        b=WM/GYmiTr7C9J059qIbN76HaUMbhUJZ1l8y3lt4xMFqBa9HqCCO4UMmn+Pid4FkHKk
         yikiI7/VyoY3Sf7Lr536To7RqTpKvLHLswrgCaiQso1mUfFsyovNDGfLhJzF3My9jKjQ
         pmdbtjQhqG18mQ+hkTNc/CPWL7MKA/4tEiaNlMPK5Z8YQTG/3U2chUfsSs27rJK3ChsR
         aRCLHhu9xRQHVi+SMHZKJPDG/i9rjzTopAqm0EUBzaSUPte/WGZjn6HcCw0nn6Yq3MyI
         R0VsjRyk/KtThrM3H1iNpkXQ98U0lMWKRQ1fE/68wrI90A8+TUAfidK60TMiJoW0el+9
         JJBA==
X-Gm-Message-State: AOAM533pxzqNKnlepwh/4qELNgrYN7O6MxjgpN/k9YKRG6GZg2EnG/hj
        YY017aCfEUHtG3A9Ak3D0w==
X-Google-Smtp-Source: ABdhPJzuRRVD/WcuIJgRe3YhYG1qx3qeyJ3wiEJI6lhu2zktZeoQCpgwuPI2gHdy6/DV0mg0RvFxNA==
X-Received: by 2002:a05:6e02:54e:: with SMTP id i14mr22635817ils.136.1615244892964;
        Mon, 08 Mar 2021 15:08:12 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n7sm6940596ile.12.2021.03.08.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:08:12 -0800 (PST)
Received: (nullmailer pid 3119453 invoked by uid 1000);
        Mon, 08 Mar 2021 23:08:10 -0000
Date:   Mon, 8 Mar 2021 16:08:10 -0700
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:net:wireless:mediatek,mt76: txt to yaml
 conversion
Message-ID: <20210308230810.GA3111033@robh.at.kernel.org>
References: <b78122c8ddcbf4ac66adc2c0280665a84e7e9010.1615151665.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78122c8ddcbf4ac66adc2c0280665a84e7e9010.1615151665.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 07, 2021 at 10:20:44PM +0100, Lorenzo Bianconi wrote:
> Convert mt76 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   |  78 -----------
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 78 deletions(-)
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
> index 000000000000..1a6e3d36944f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -0,0 +1,125 @@
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
> +
> +description: |
> +  This node provides properties for configuring the MediaTek mt76xx
> +  wireless device. The node is expected to be specified as a child
> +  node of the PCI controller to which the wireless chip is connected.
> +  Alternatively, it can specify the wireless part of the MT7628/MT7688
> +  or MT7622 SoC.
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
> +    description:
> +      Address and length of the register set for the device

That's every reg, drop.

> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Main device interrupt

Are there others besides 'main'? If not, drop description.

> +
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Don't need a type for common properties.

> +    description:
> +      Phandle to the power domain that the WMAC is part of.

That's every 'power-domains'. Just need to define how many: 'maxItems: 1'

> +      This property is MT7622 specific

This can be a schema.

> +
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the infrastructure bus fabric syscon node.
> +      This property is MT7622 specific
> +
> +  ieee80211-freq-limit:
> +    maxItems: 1

Just make sure, only 1 freq supported?

> +    description:
> +      List of supported frequency ranges in KHz
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
> +    properties:
> +      led-sources:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array

No constraints for how many array entries?

> +        description:
> +          List of device current outputs the LED is connected to
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
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
> +    wmac: wmac@10300000 {
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
> +    wlmac: wmac@18000000 {
> +      compatible = "mediatek,mt7622-wmac";
> +      reg = <0x10300000 0x100000>;
> +      interrupts = <0 211 8>;
> +
> +      mediatek,infracfg = <&infracfg>;
> +
> +      power-domains = <&scpsys 3>;
> +    };
> -- 
> 2.29.2
> 
