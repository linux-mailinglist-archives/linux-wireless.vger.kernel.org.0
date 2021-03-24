Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DC347FA9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 18:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhCXRkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 13:40:33 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:39734 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhCXRkM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 13:40:12 -0400
Received: by mail-il1-f178.google.com with SMTP id y17so10481431ila.6;
        Wed, 24 Mar 2021 10:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shDHM+UUdUbC+RAu23YNQvojdR5GBXy+uXbQ2ceTFTk=;
        b=Mxdz+g3n3aL0MufgLBnHNgakLMHziEDc6cNyk01uo2/Ptrp2tLxO+kskL4O4ev6Rv0
         7wvN8oWg+UjQUTTSf83uQSzQuY+u9IrU/u4TX39h8odz3HNXavMHEQnZHi/7r7pP/DIj
         xxd6WaMDf++bhnoLZR2HTyeQblp0oSncdAFxtxR/HGUvVk6IUWJlawhP+9zP7a0kZMpS
         ODWAyvo00GAg1wZV0vi0WWvQLer+VWrKJPWWDjHK50S8jzhj5sg6dSmjBksFb7ZewIN/
         dTCQfRRJMeCL4k80MZL3lFc/AEQ2xSJIOk4jdW5oUBJYbW12rlbthu8oK6J4M0aBFz2i
         SACA==
X-Gm-Message-State: AOAM5308mWyvyUzVmfYp5saGPsbYVB3PVHLpY4HsNtNYVuV0aT4YbbFI
        QoNVYMnCLEKz6IacP0zd3kuunAE+lA==
X-Google-Smtp-Source: ABdhPJyV1S5xbVTyZmfh+bt339wUrAQogFPgsvMujUdjq551faPzShcWC1HC9jbsW6spGTBnkqyojg==
X-Received: by 2002:a92:c5a3:: with SMTP id r3mr2274923ilt.155.1616607611708;
        Wed, 24 Mar 2021 10:40:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v19sm1317724iol.21.2021.03.24.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:40:11 -0700 (PDT)
Received: (nullmailer pid 3307742 invoked by uid 1000);
        Wed, 24 Mar 2021 17:40:08 -0000
Date:   Wed, 24 Mar 2021 11:40:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v2 2/2] dt-bindings:net:wireless:mediatek,mt76: txt to
 yaml conversion
Message-ID: <20210324174008.GA3296236@robh.at.kernel.org>
References: <cover.1615752835.git.lorenzo@kernel.org>
 <daa263c1ebfd01714fce3c3e65d57295691219a6.1615752835.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daa263c1ebfd01714fce3c3e65d57295691219a6.1615752835.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Mar 14, 2021 at 09:21:07PM +0100, Lorenzo Bianconi wrote:
> Convert mt76 dts bindings from .txt to .yaml
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   |  78 ------------
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 117 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 78 deletions(-)
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
> index 000000000000..f472a09609e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -0,0 +1,117 @@
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

This is defining a node 'ieee80211-freq-limit' which in turn has 
property 'ieee80211-freq-limit'. You need before 'properties':

allOf:
  - $ref: ieee80211.yaml#

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

       $ref: /schemas/leds/common.yaml#
       additionalProperties: false

> +    properties:
> +      led-sources:
> +        maxItems: 1

And then drop all this:

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          List of device current outputs the LED is connected to

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

With the above, this will need to be:

unevaluatedProperties: false

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

wifi@...

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

wifi@...

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
