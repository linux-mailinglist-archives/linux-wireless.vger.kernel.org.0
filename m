Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2683C176A56
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 03:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCCCCc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 21:02:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34641 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCCCc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 21:02:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so1485388otl.1;
        Mon, 02 Mar 2020 18:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RtixrG9AQvpOs2d4QLEzLorqikP02pM+UwgYV/xmhrM=;
        b=CKmrHsIEJkkk+Ks5WC1w0KGsyXqLdfLvaAlV/CuO46M8Y5Vr+5No7HEyw0aSYWnriv
         JujHD+A5pvf9RnWrM3VZ1Xy9TOyLl1x/Tehjaunmh+vd1fSvkzhsrt5lYExHTxNOx8Jt
         hTTLmfnV9lVZOwavV0UbhyCw3xoz75qtlkpQeyLtPcFK0dtzxR1NqW0LkZfJeWLy9bBS
         uBrAfAQyo4V2xUrfXKOYmdpp5BmxZZ68U6BR91vaAByQxeHRy7AbLtUnuAzmeNeD4t+E
         buGQ23AQBNUUyE89Tliaf3s9tzsomkAjcBQwuzGZKfWDsTIxbhuZ/U6mLF1IPWtmCU9A
         W7nw==
X-Gm-Message-State: ANhLgQ0jimin/FLeNC9jX4V4OcUpaoZ1NOB305T2fg0uVpJUuLK50+yz
        CghCGnAJwzkEVBpMJ3v5xpQukqA=
X-Google-Smtp-Source: ADFU+vuhYpzQz9XvzyQDfJMuF7vroKr5isl1iZnuLB8Mgo4b7r4I1KCoCpnc42teUBpwzRA0cW6BOA==
X-Received: by 2002:a9d:7695:: with SMTP id j21mr1664602otl.157.1583200951832;
        Mon, 02 Mar 2020 18:02:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm3291374oiw.43.2020.03.02.18.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 18:02:31 -0800 (PST)
Received: (nullmailer pid 22840 invoked by uid 1000);
        Tue, 03 Mar 2020 02:02:30 -0000
Date:   Mon, 2 Mar 2020 20:02:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Venkateswara.Kaja@microchip.com
Subject: Re: [PATCH v4 17/18] dt: bindings: net: add
 microchip,wilc1000,spi.yaml
Message-ID: <20200303020230.GA15543@bogus>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
 <20200302163414.4342-18-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302163414.4342-18-ajay.kathat@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 02, 2020 at 04:34:40PM +0000, Ajay.Kathat@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Moved '/drivers/staging/wilc1000//microchip,wilc1000,spi.yaml' to
> 'Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml'.

Not a useful changelog.

I think this should be combined with the SDIO version. Details below.

> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  .../net/wireless/microchip,wilc1000,spi.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml
> new file mode 100644
> index 000000000000..cc8ed64ce627
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip WILC wireless SPI devicetree bindings
> +
> +maintainers:
> +  - Adham Abozaeid <adham.abozaeid@microchip.com>
> +  - Ajay Singh <ajay.kathat@microchip.com>
> +
> +description:
> +  The wilc1000 chips can be connected via SPI. This document describes
> +  the binding for the SPI connected module.
> +
> +properties:
> +  compatible:
> +    const: microchip,wilc1000-spi

You can drop '-spi' (and '-sdio'). They don't need to be different 
because they already sit on different buses.

> +
> +  spi-max-frequency:
> +    description: Maximum SPI clocking speed of device in Hz.
> +    maxItems: 1
> +
> +  reg:
> +    description: Chip select address of device.
> +    maxItems: 1
> +
> +  irq-gpios:
> +    description: The GPIO phandle connect to a host IRQ.
> +    maxItems: 1
> +
> +  clocks:
> +    description: phandle to the clock connected on rtc clock line.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - spi-max-frequency

This should not be required.

> +  - reg
> +  - irq-gpios
> +
> +examples:
> +  - |
> +    spi1: spi@fc018000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      cs-gpios = <&pioB 21 0>;
> +      status = "okay";
> +      wilc_spi@0 {
> +        compatible = "microchip,wilc1000-spi";
> +        spi-max-frequency = <48000000>;
> +        reg = <0>;
> +        irq-gpios = <&pioC 27 0>;
> +        clocks = <&pck1>;
> +        clock-names = "rtc_clk";

Not documented. '_clk' is redundant.

> +        assigned-clocks = <&pck1>;
> +        assigned-clock-rates = <32768>;

Not documented.

> +        status = "okay";
> +      };
> +    };
> -- 
> 2.24.0
