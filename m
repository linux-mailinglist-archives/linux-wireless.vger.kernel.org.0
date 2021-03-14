Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D033A201
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Mar 2021 01:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhCNAFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 19:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhCNAFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 19:05:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A1C061574;
        Sat, 13 Mar 2021 16:05:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z1so13115230edb.8;
        Sat, 13 Mar 2021 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMX4PGAdnxUDz2rgcUrWaWmNPXTCnjfQBU+O2I1RQIU=;
        b=aLNiuIPtXynQ0D7jmFlbZ6tKjJAoE/30t8wTpWRdDuzn3aE6NrywEvZ+fGWewoCPlh
         Ok6il+rCWYs7LREk3Lxf2KJIqPodlwHh5qszl8vLgJtdmg05BxpxBtizy8i9nf38qJIa
         o/VF+xOrX0SdY7x9dMt0S3E2mOOClYxDEWU7Wifh5GZMOnthl1y3oZwsvKccbhecQF+H
         vvYCY/HdZcjDOtKl2cLZl3d7S5EBcSkZzjKVCdk5XXLF6K3wp8C0+G7JJzdloaT+ONTq
         ZCnV6eXAwaBQA9Fc5ORTqC7G6XfJaiaBP/zzM8rGPkauWdABz6YtOEhBaB5JkqOn92ab
         1lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMX4PGAdnxUDz2rgcUrWaWmNPXTCnjfQBU+O2I1RQIU=;
        b=rxmwFPkE5WYwzAWCPsp6rbWzBHkGJgRKdqTAEg1283zmPjjO5yYA6KKDpR9kSNrgsO
         /YgEZjWXjAq8KFXsRPgdLgbDTVrrCDV4CwW649zHySMYi61VGOQoRDKf5nv/ofIJVcoB
         yzLowqQz816vcESPFUtvdYwV6WIEBBVlz83ys03P5LM9F/+P1e1YtM2kbHWT73IvDCWc
         0q1ksZ98PLlv3BWBm/DNDe+eQanuIE0XSEfzZ8F76fz6sFjnI0aYJDNcoDebbi55fIQe
         tr9FnlIIwLhF7bzhxH1U38oKxH9ppyqmehFrP4HwJtN9SraJO6iGgWgjyX1BtWti2CYG
         9UcA==
X-Gm-Message-State: AOAM530XfURIMAgsoghJfrr8BbfAA28gGJ2hJ3wRSitCcL3UhhKbMpqs
        Uzya7io4QMiz43r4MbIfkcuv4La8nbwrMkPBAHA=
X-Google-Smtp-Source: ABdhPJzWWail3s8JDkQtTD/knWUAbZVCF3iT+21h9hf5MS4ptYmJQ4e1E6dsBvUpW4Jxk97wbCBNthg71GKjXSvYFPs=
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr22139260edb.29.1615680330069;
 Sat, 13 Mar 2021 16:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20210313215302.4076765-1-linus.walleij@linaro.org>
In-Reply-To: <20210313215302.4076765-1-linus.walleij@linaro.org>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 14 Mar 2021 11:05:17 +1100
Message-ID: <CAGRGNgU_C6keHC_Ty3iruJc5cwsBGJRRBm8DWH91fHjygPv0fg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert the BCM4329 bindings to YAML and extend
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-mmc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Linus,

On Sun, Mar 14, 2021 at 9:00 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This converts the BCM4329 family bindings to YAML schema, and
> extends and fixes the bindings like this:
>
> - Name the bindings after the first chip (BCM4329) since
>   wildcards like 43xx are nowadays frowned upon by the DT
>   binding reviewers. We call this the "BCM4329 family"
> - Add compatible strings for all the variants that seem to
>   exist in the wild. (Derived from firmware listings.)
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
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../net/wireless/brcm,bcm4329-fmac.yaml       | 98 +++++++++++++++++++
>  .../net/wireless/brcm,bcm43xx-fmac.txt        | 38 -------
>  2 files changed, 98 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> new file mode 100644
> index 000000000000..d172ee486cf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -0,0 +1,98 @@
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
> +    items:
> +      - enum:
> +          - brcm,bcm43143-fmac
> +          - brcm,bcm4341b0-fmac
> +          - brcm,bcm4341b4-fmac
> +          - brcm,bcm4341b5-fmac
> +          - brcm,bcm4329-fmac
> +          - brcm,bcm4330-fmac
> +          - brcm,bcm4334-fmac
> +          - brcm,bcm43340-fmac
> +          - brcm,bcm4335-fmac
> +          - brcm,bcm43362-fmac
> +          - brcm,bcm4339-fmac
> +          - brcm,bcm43430a0-fmac
> +          - brcm,bcm43430a1-fmac
> +          - brcm,bcm43455-fmac
> +          - brcm,bcm43456-fmac
> +          - brcm,bcm4354-fmac
> +          - brcm,bcm4356-fmac
> +          - brcm,bcm4359-fmac
> +          - cypress,cyw4373-fmac
> +          - cypress,cyw43012-fmac

I don't know if this is necessary for SDIO, but should the non-4329
compatibles have the 4329 compatible as an alternative?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
