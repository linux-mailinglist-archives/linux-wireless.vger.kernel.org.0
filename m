Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF36341EA8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 14:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhCSNpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCSNpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 09:45:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775A5C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 06:45:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a1so12062948ljp.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmPjIQub1KJPhMOrgHtiWUuKYsN7Yn6qt2C+dcAgWOM=;
        b=vfIH/HsQlKQLUg4JfSfwODGwrxBn9e6tV8/LjWtg48YyMtI8n36pxEiG/pKMYLXeLQ
         cd5AtquilU8pp8depjciRsp6FLyIS7P8mdq3r1VXa+RntKMRg3imFo/pCvzXTNlDL6PP
         tnCKKTTAKwhsZ0It9mXw2IYAIX/mw/rIdk7El3Bet2SXEDH6dYYD85zz5tH0kNaKzT+8
         irn5eW5ES8kuMGurkujyF6d7H6GxstVQNVRwCO0sJHVqvpDmofRXK0DkQWfBhwHP2vjL
         XabX1+TLAsoPMy97BjtR6UDVCaIXeRpN4ZKVB1GQup0P868d1cTKg4XK4Ah+SmuF8Bac
         YN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmPjIQub1KJPhMOrgHtiWUuKYsN7Yn6qt2C+dcAgWOM=;
        b=VwXo1+nSBXeQ97K1AfZRvEf2crK4i4HWUbK0XJaApeaL/etyq/V5koVaAfs67slAPR
         KlCj5ux4+gBlqQFB1lzsTrTK7+crqF9eOcQ7q/RnfRODiu7U+UZQX48Vy4OPy361wrwf
         nYXLJ+gp4/HSuKH0ckPNRwpnYSzTbj4TWWmWdZZEAK/x4urRRlyjZoEdIrB0qp6wIqT5
         xI+odUhwdas4OFiHQb5I6ukC5n3LiaPkgRVfugJ/mxXRsTrE3j/OAToiFlEWddu5RL6i
         0glCj+yDV9dJxa7y6qd/q7SgPp8BOLh13LECpjZ339bP8q71sPlk7BrwGpErXNUdQCDe
         UlLA==
X-Gm-Message-State: AOAM531BMnhnB5EIvo8YoenoTO7FdXso76A23WULMhVKbqZ8qWyn7s06
        oW3LDjM8LO3LliHpVEzgZAtDVO38PkFdcnczSwT1JA==
X-Google-Smtp-Source: ABdhPJwwzI6hcNapOtQE1Dmao9QEyys5ESkG/Ik0HZrAEcOD504hhWIUOvHE4mZGUNvC+81lV05IcsSDVIGUxqBmVWM=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr995559ljj.341.1616161499767;
 Fri, 19 Mar 2021 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210315105911.138553-1-linus.walleij@linaro.org>
In-Reply-To: <20210315105911.138553-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 14:44:23 +0100
Message-ID: <CAPDyKFpGM5QeDztoDBEc1_xm8EHY3nCPCoZFavofMM=Tse4PsQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Convert the BCM4329 bindings to YAML and extend
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 15 Mar 2021 at 12:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This converts the BCM4329 family bindings to YAML schema, and
> extends and fixes the bindings like this:
>
> - Name the bindings after the first chip (BCM4329) since
>   wildcards like 43xx are nowadays frowned upon by the DT
>   binding reviewers. We call this the "BCM4329 family"
> - Add compatible strings for all the variants that seem to
>   exist in the wild. (Derived from firmware listings.)
> - Support specific-to-generic compatible strings (as already
>   in use in DTS files).
> - Add required reg property (SDIO function number)
> - Add reset-gpios property (some systems wire this to a GPIO
>   line).
> - I have only listed Arend as maintainer for now, volunteers
>   can be added.
>
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Wright Feng <wright.feng@infineon.com>
> Cc: Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
> Cc: Julian Calaby <julian.calaby@gmail.com>
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> ChangeLog v1->v2:
> - Specify specific-to-generic compatible strings such as
>   "brcm,bcm4334-fmac", "brcm,bcm4329-fmac"
> - Also allow just "brcm,bcm4329-fmac" for legacy platforms.
> - Use this scheme in the example.
> ---
>  .../net/wireless/brcm,bcm4329-fmac.yaml       | 101 ++++++++++++++++++
>  .../net/wireless/brcm,bcm43xx-fmac.txt        |  38 -------
>  2 files changed, 101 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> new file mode 100644
> index 000000000000..b5fcc73ce6be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM4329 family fullmac wireless SDIO devices
> +
> +maintainers:
> +  - Arend van Spriel <arend@broadcom.com>
> +
> +description:
> +  The Broadcom Single chip MAC part for the BCM4329 family and
> +  later Cypress chips in the same family named CYW4373 and similar.
> +  These chips also have a Bluetooth portion described in a separate
> +  binding.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm43143-fmac
> +              - brcm,bcm4341b0-fmac
> +              - brcm,bcm4341b4-fmac
> +              - brcm,bcm4341b5-fmac
> +              - brcm,bcm4329-fmac
> +              - brcm,bcm4330-fmac
> +              - brcm,bcm4334-fmac
> +              - brcm,bcm43340-fmac
> +              - brcm,bcm4335-fmac
> +              - brcm,bcm43362-fmac
> +              - brcm,bcm4339-fmac
> +              - brcm,bcm43430a0-fmac
> +              - brcm,bcm43430a1-fmac
> +              - brcm,bcm43455-fmac
> +              - brcm,bcm43456-fmac
> +              - brcm,bcm4354-fmac
> +              - brcm,bcm4356-fmac
> +              - brcm,bcm4359-fmac
> +              - cypress,cyw4373-fmac
> +              - cypress,cyw43012-fmac
> +          - const: brcm,bcm4329-fmac
> +      - const: brcm,bcm4329-fmac
> +
> +  reg:
> +    description: SDIO function number for the device, for most cases
> +      this will be 1.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Out-of-band (OOB) IRQ line for waking up the host
> +      in response to WLAN activity. This corresponds to the HOST_WAKE
> +      line into the chip.
> +
> +  interrupt-names:
> +    description: Name for the OOB IRQ, this must be set to "host-wake".
> +    const: host-wake
> +
> +  brcm,drive-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Drive strength used for the SDIO pins on the device in mA.
> +    minimum: 0
> +    maximum: 32
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: A GPIO line connected to the WL_RST line, if present
> +      this shall be flagged as active low.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    mmc@80118000 {
> +      compatible = "arm,pl18x", "arm,primecell";
> +      reg = <0x80118000 0x1000>;
> +      clocks = <&clk 0>, <&clk 1>;
> +      clock-names = "mclk", "apb_pclk";
> +      interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
> +      bus-width = <4>;
> +      non-removable;
> +      vmmc-supply = <&wl_bt_reg>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      wifi@1 {
> +        compatible = "brcm,bcm4334-fmac", "brcm,bcm4329-fmac";
> +        reg = <1>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-names = "host-wake";
> +        reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> deleted file mode 100644
> index cffb2d6876e3..000000000000
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Broadcom BCM43xx Fullmac wireless SDIO devices
> -
> -This node provides properties for controlling the Broadcom wireless device. The
> -node is expected to be specified as a child node to the SDIO controller that
> -connects the device to the system.
> -
> -Required properties:
> -
> - - compatible : Should be "brcm,bcm4329-fmac".
> -
> -Optional properties:
> - - brcm,drive-strength : drive strength used for SDIO pins on device in mA
> -       (default = 6).
> - - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
> -       When not specified the device will use in-band SDIO interrupts.
> - - interrupt-names : name of the out-of-band interrupt, which must be set
> -       to "host-wake".
> -
> -Example:
> -
> -mmc3: mmc@1c12000 {
> -       #address-cells = <1>;
> -       #size-cells = <0>;
> -
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mmc3_pins_a>;
> -       vmmc-supply = <&reg_vmmc3>;
> -       bus-width = <4>;
> -       non-removable;
> -
> -       brcmf: wifi@1 {
> -               reg = <1>;
> -               compatible = "brcm,bcm4329-fmac";
> -               interrupt-parent = <&pio>;
> -               interrupts = <10 8>; /* PH10 / EINT10 */
> -               interrupt-names = "host-wake";
> -       };
> -};
> --
> 2.29.2
>
