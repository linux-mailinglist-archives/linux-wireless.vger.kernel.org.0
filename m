Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA26E176A41
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCCB4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 20:56:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44120 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCB4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 20:56:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id v22so1401098otq.11;
        Mon, 02 Mar 2020 17:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wU+iQU10o8A0zqKTfobuWZ7wNf9lzAIbOUXJE7/Vvk=;
        b=Ns7fp4KAVJf7qnazFyq29fQByWt+tsZ0EYno7uq5FzlgqyixORzKw//irnmA2W2h90
         NsOaPqMN3YQrrwPBTzxVIVUfDxBWrOvsVwBOzg5+KS3N4EZaDvMQA76gwLx6LkdkvoOp
         PdUyK+FY9gml5AKpx9I7BthxvMl07wYeRu70lppIBmR/yJxZBRhntH1SeUeI3R8wBL/y
         W6GhyWOk4pCoGFBtx8vu6nASGM/bL+YAD7Z1+80XRYgiY9AX94diDvigbE4KDSzoD0ko
         lKcS0qK7iHZu7xuN+rjGZgDWy9s6hP2/Eftn4G1xP/7W1mURlAzsF43M0KfOKSqf0AgZ
         +xxw==
X-Gm-Message-State: ANhLgQ1jo9geSCoqyjk4acy+bPf1x3vXk3Fxin2b8FJfv9sgYQfPKI3s
        Ht+q0R2xoAZ0TtwKxS3c3y+Mfx0=
X-Google-Smtp-Source: ADFU+vve24zXbvrJ5KqKxMiEejDGOBgBCPa+DEVNrcccvUHzbaA2GMWwFb4xvxUS9FkHZcCY7jLmTQ==
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr1633603oto.241.1583200560125;
        Mon, 02 Mar 2020 17:56:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm6991570oic.31.2020.03.02.17.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:55:59 -0800 (PST)
Received: (nullmailer pid 13760 invoked by uid 1000);
        Tue, 03 Mar 2020 01:55:58 -0000
Date:   Mon, 2 Mar 2020 19:55:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Venkateswara.Kaja@microchip.com
Subject: Re: [PATCH v4 16/18] dt: bindings: net: add
 microchip,wilc1000,sdio.yaml
Message-ID: <20200303015558.GA6876@bogus>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
 <20200302163414.4342-17-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302163414.4342-17-ajay.kathat@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 02, 2020 at 04:34:40PM +0000, Ajay.Kathat@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Moved '/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml' to
> 'Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yaml'.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  .../net/wireless/microchip,wilc1000,sdio.yaml | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yaml
> new file mode 100644
> index 000000000000..b338f569f7e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip WILC wireless SDIO devicetree bindings
> +
> +maintainers:
> +  - Adham Abozaeid <adham.abozaeid@microchip.com>
> +  - Ajay Singh <ajay.kathat@microchip.com>
> +
> +description:
> +  The wilc1000 chips can be connected via SDIO. The node is used to
> +  specify child node to the SDIO controller that connects the device
> +  to the system.
> +
> +properties:
> +  compatible:
> +    const: microchip,wilc1000-sdio
> +
> +  irq-gpios:

Unless you need GPIO control of the line, use 'interrupts' instead.

> +    description: The GPIO phandle connect to a host IRQ.
> +    maxItems: 1
> +
> +  reg:
> +    description: Slot ID used in the controller.

No, it's the function number. But you can just drop this.

> +    maxItems: 1
> +
> +  clocks:
> +    description: phandle to the clock connected on rtc clock line.
> +    maxItems: 1
> +
> +  bus-width:

I believe this is defined to go in the parent node.

> +    description: The number of data lines wired up the slot.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 4, 8]
> +      - default: 1
> +
> +required:
> +  - compatible
> +  - irq-gpios
> +  - reg
> +
> +examples:
> +  - |
> +    mmc1: mmc@fc000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
> +      non-removable;
> +      vmmc-supply = <&vcc_mmc1_reg>;
> +      vqmmc-supply = <&vcc_3v3_reg>;
> +      status = "okay";

Don't show 'status' in examples.

> +      wilc_sdio@0 {

wifi@0

> +        compatible = "microchip,wilc1000-sdio";
> +          irq-gpios = <&pioC 27 0>;
> +          reg = <0>;
> +          clocks = <&pck1>;
> +          clock-names = "rtc_clk";
> +          assigned-clocks = <&pck1>;
> +          assigned-clock-rates = <32768>;
> +          status = "okay";
> +          bus-width = <4>;
> +        };
> +    };
> -- 
> 2.24.0
