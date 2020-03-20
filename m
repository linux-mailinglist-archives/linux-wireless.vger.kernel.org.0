Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1018D65B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCTR7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 13:59:24 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45939 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTR7X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 13:59:23 -0400
Received: by mail-il1-f195.google.com with SMTP id m9so6401806ilq.12;
        Fri, 20 Mar 2020 10:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95Suyv4ag/UW0GMJDUqwKID1E5LJYUXds0iFnK4QjiI=;
        b=Dpx0kyIKugARf40N5g3nCYvNuF+BhUMTYqCCk+DN2R3cu+E5r02V1R2KpeEDPTXt2n
         bZcfDBbjfdpHIMUewmFqXlsGrZcH1yn8XF5umT6JkYo1uBCejYbOsFVvYsnjHgeGLMrD
         jqiC1MziBsHEmXGFZ2k7YPo9bac9w2rK8DzNQb+rLkGjt6Cpbheuq6IVEohdL0kBxpS2
         +zNDvueoY51uT2GVvJiRasumPZkLqXBN+QplTo26LY7KOfyUwkv6mMU8d3ghQ6IB1AUs
         vrOzpmYApGJxZPbc4PhK6VCmY2fLJbGWey7ihYRgHTa59Skgs7+uuLT+Lr6lsqvwGbRA
         Q5rA==
X-Gm-Message-State: ANhLgQ3N8GpAY2Ol+/6pyQtGKyvmkDBxuJhfZbp9j6kbZ7fg9NebS0U5
        B0oFpCDK6youLFYVHe2rKE+f8Ow=
X-Google-Smtp-Source: ADFU+vt7qmPnUmzTMPbajCklZuNV66re7YCKjK/pSmVBOIAgFLPoaGoK9cfTLRSFh8EnaJJFE/KSYg==
X-Received: by 2002:a92:b61d:: with SMTP id s29mr9370804ili.66.1584727163066;
        Fri, 20 Mar 2020 10:59:23 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u77sm2236931ili.35.2020.03.20.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:59:21 -0700 (PDT)
Received: (nullmailer pid 5880 invoked by uid 1000);
        Fri, 20 Mar 2020 17:59:20 -0000
Date:   Fri, 20 Mar 2020 11:59:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com,
        Venkateswara.Kaja@microchip.com
Subject: Re: [PATCH v5 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Message-ID: <20200320175920.GA31641@bogus>
References: <20200311121809.5610-1-ajay.kathat@microchip.com>
 <20200311121809.5610-17-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311121809.5610-17-ajay.kathat@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 11, 2020 at 12:18:50PM +0000, Ajay.Kathat@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> This file describes the binding details to connect wilc1000 device. It's
> moved from staging to 'Documentation/devicetree/bindings/net/wireless'
> path.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  .../net/wireless/microchip,wilc1000.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> new file mode 100644
> index 000000000000..bc6cc5d3f347
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
> @@ -0,0 +1,72 @@
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
> +  spi-max-frequency: true
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
> +  - interrupts
> +
> +examples:
> +  - |
> +    spi1: spi@fc018000 {

spi {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      cs-gpios = <&pioB 21 0>;

Drop this. Not relevant to the example.

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

Drop the label. Either drop the unit address or add a 'reg' property to 
match.

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
> -- 
> 2.24.0
