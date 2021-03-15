Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2381933B021
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 11:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCOKkf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCOKkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 06:40:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE701C061574;
        Mon, 15 Mar 2021 03:40:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lr13so65338292ejb.8;
        Mon, 15 Mar 2021 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqzTiNwq7F43KRl7MeDTQAW5DfLX3HRrkcyj01ylqdg=;
        b=OAHm4NsI295ATwtqDJ6uWfMyjCp1UrvV1Os5KFJTwp8mV0pF0TJxhe+NYcMIYNKKHX
         xAxkXLUnteNgUGFYKjLHX7Owotbf98s3hFsrRFjlO4iK1exkBb7UL3QIsrDXWjTbIZi9
         Sm2IflJgyHcnkuo9+cEtWy9YadMu7e840pufNuXSEym5LHB/unl/DnJU7SvW/9JpSYYK
         S2p5mO9jR9BlJMcBRPgZuskkVEnGE0I3h582BELwrOemv1x/hW6hchxEG7nm1UBwDeES
         c0oE+dj/5zgFkOtef9Hq9/Db1JvYQVWDrE1gU/N94ULNqTIUYRRx/KeVmwInA+sEax1b
         Oldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqzTiNwq7F43KRl7MeDTQAW5DfLX3HRrkcyj01ylqdg=;
        b=fBof9wcxbb8ReKcW4RRC9I9HlG+yJMab+UxHwovWW8gf6Iz0sFDihgKa5zWI6RGRAi
         OanFz+2YyU6T2O6C0hkst1c0Q0rzCTuuNm0FEcHlqLULmFcxgK4PZyhyWeXjsTaHCSi8
         XrYD4FTN0IOrxCZGfm5IFMt1IzCbBz8BuIAsfdSw1mMBTSbyZXURSPbA2Jc5SIS0nrTl
         DFyrH+ZojIMu41fuQCOZRHL4vwM3uqoWlPLlzmMF3l8Zm++aVKKmuxN1CYAHdPS5oxmU
         EQSz76pTOQMnj6MgwPUafzPa1bkk5LuB9ofd3qBxVvpyZXxPXn/5XsTrLbRG1bRXPXx9
         mCyA==
X-Gm-Message-State: AOAM532oLVS76YWtR2LvgWu7/52SeLpMOkjzbxNE8z23YVeckX26As8x
        VRDSGWu4mVUNP9oaLL0Pi40AavZckVu384pCeA8=
X-Google-Smtp-Source: ABdhPJyMTPKqLAPCgX5HECYtPHc584QK7Bo03u0+OSFE3M17en7cxnIzQqX+5hZ0KYbIC+jQn+YkMke4VpejGjHc66Y=
X-Received: by 2002:a17:906:3849:: with SMTP id w9mr23036529ejc.7.1615804811719;
 Mon, 15 Mar 2021 03:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210313215302.4076765-1-linus.walleij@linaro.org>
 <CAGRGNgU_C6keHC_Ty3iruJc5cwsBGJRRBm8DWH91fHjygPv0fg@mail.gmail.com> <CACRpkdbHfH=+m3EJ9CBGkQ3rh6MGtKy4ixk3fgu15rxEzMg5dw@mail.gmail.com>
In-Reply-To: <CACRpkdbHfH=+m3EJ9CBGkQ3rh6MGtKy4ixk3fgu15rxEzMg5dw@mail.gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 15 Mar 2021 21:40:00 +1100
Message-ID: <CAGRGNgUNzzHTre1oOjvV7-c-4mvjDuOAAmYRc4Nd_D6m+tLdPg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert the BCM4329 bindings to YAML and extend
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Linus,

On Mon, Mar 15, 2021 at 10:43 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Mar 14, 2021 at 1:05 AM Julian Calaby <julian.calaby@gmail.com> wrote:
>
> > I don't know if this is necessary for SDIO, but should the non-4329
> > compatibles have the 4329 compatible as an alternative?
>
> I can, and I guess I should add it, as I grep:ed and saw this:
>
> arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
>
> So from more to less specific.
>
> Yours,
> Linus Walleij

If it helps, the pattern I've seen before for this is:

oneOf:
  - const: vendor,specific-device-1234
  - items:
    - enum:
      - vendor,compatible-device-2345
      - vendor,compatible-device-3456
    - const: vendor,specific-device-1234

See https://elixir.bootlin.com/linux/v5.12-rc3/source/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
for an example.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
