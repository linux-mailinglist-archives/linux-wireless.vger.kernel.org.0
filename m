Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F386817C1E8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 16:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCFPfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 10:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCFPfb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 10:35:31 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F432073D;
        Fri,  6 Mar 2020 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583508930;
        bh=iNFqdKLv+eRvs3H2Mi3RchCyVRMkK9tatJ+t/BU07yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iRtX8L9N2ARyt/i4JwDyOinTaKffwSoBdwG2XQievED77xfIsOBUuRbLWg5OznX6Z
         HbgZqkv0uPQ1LlDHbTLY+oID44WU8dj4nvhopLhTynSYXRqnpITMsdGBw4eKOPbzJZ
         TAJk/vvYcGjz4r2UZqPNbtrwahqJZjCJ2VgoC9u8=
Received: by mail-qv1-f50.google.com with SMTP id g16so1107973qvz.5;
        Fri, 06 Mar 2020 07:35:30 -0800 (PST)
X-Gm-Message-State: ANhLgQ31rs7u+LrFFlyELK156faOXBnesiHusJYOLPMk8diSVLqpP8Rt
        TZQUjcrh27bgCrSmgspew+2ZYts42CsCT2zSLA==
X-Google-Smtp-Source: ADFU+vuhZOwle3B1BdZhiJMPa1o4Ows241SJR8YEgkbTjVTAQFPyg8WmNmCIyOgO1eykQ9B8gJHEPH/0gdrGV5yipJg=
X-Received: by 2002:ad4:4593:: with SMTP id x19mr3274776qvu.79.1583508929178;
 Fri, 06 Mar 2020 07:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20200306144400.4269-1-ajay.kathat@microchip.com> <20200306144400.4269-2-ajay.kathat@microchip.com>
In-Reply-To: <20200306144400.4269-2-ajay.kathat@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Mar 2020 09:35:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKP-9bBMpkvMfphyAfdeVd44=pYDSOY=fSsx5xYkJPCjA@mail.gmail.com>
Message-ID: <CAL_JsqKP-9bBMpkvMfphyAfdeVd44=pYDSOY=fSsx5xYkJPCjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: wilc1000: use 'interrupts' property instead
 of 'irq-gpio'
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adham.Abozaeid@microchip.com,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 6, 2020 at 8:44 AM <Ajay.Kathat@microchip.com> wrote:
>
> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Make use of 'interrupts' property instead of using gpio for handling
> the interrupt as suggested in [1].
>
> [1]. https://lore.kernel.org/linux-wireless/20200303015558.GA6876@bogus/
>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  .../net/wireless/microchip,wilc1000.yaml      | 79 +++++++++++++++++++
>  .../wilc1000/microchip,wilc1000,sdio.yaml     |  8 +-
>  .../wilc1000/microchip,wilc1000,spi.yaml      |  8 +-

Bindings should be a separate patch.

>  drivers/staging/wilc1000/netdev.c             | 24 ++----
>  drivers/staging/wilc1000/netdev.h             |  1 -
>  drivers/staging/wilc1000/sdio.c               | 31 +++-----
>  drivers/staging/wilc1000/spi.c                | 15 +---
>  drivers/staging/wilc1000/wlan.h               |  1 -
>  8 files changed, 108 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> new file mode 100644
> index 000000000000..a1914449ad07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip WILC wireless devicetree bindings
> +
> +maintainers:
> +  - Adham Abozaeid <adham.abozaeid@microchip.com>
> +  - Ajay Singh <ajay.kathat@microchip.com>
> +
> +description:
> +  The wilc1000 chips can be connected via SPI or SDIO. This document
> +  describes the binding to connect wilc devices.
> +
> +properties:
> +  compatible:
> +    const: microchip,wilc1000
> +
> +  spi-max-frequency:
> +    description: Maximum SPI clocking speed of device in Hz.
> +    maxItems: 1

No need to redefine a common property. Just:

spi-max-frequency: true

> +
> +  reg:
> +    description: Chip select address of device.

Drop this.

> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: phandle to the clock connected on rtc clock line.
> +    maxItems: 1
> +
> +  clock-names:
> +    const: rtc
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    spi1: spi@fc018000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      cs-gpios = <&pioB 21 0>;
> +      wifi@0 {
> +        compatible = "microchip,wilc1000";
> +        spi-max-frequency = <48000000>;
> +        reg = <0>;
> +        interrupt-parent = <&pioC>;
> +        interrupts = <27 0>;
> +        clocks = <&pck1>;
> +        clock-names = "rtc";
> +      };
> +    };
> +
> +  - |
> +    mmc1: mmc@fc000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
> +      non-removable;
> +      vmmc-supply = <&vcc_mmc1_reg>;
> +      vqmmc-supply = <&vcc_3v3_reg>;
> +      bus-width = <4>;
> +      wifi@0 {
> +        compatible = "microchip,wilc1000";
> +        reg = <0>;
> +        interrupt-parent = <&pioC>;
> +        interrupts = <27 0>;
> +        clocks = <&pck1>;
> +        clock-names = "rtc";
> +      };
> +    };
> diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml b/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
> index b338f569f7e2..9df7327bc668 100644
> --- a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
> +++ b/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml

Why aren't you just removing this file and the spi one?

Rob
