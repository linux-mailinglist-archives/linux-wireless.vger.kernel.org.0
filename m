Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42748EA1FC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 17:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfJ3Qo7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 12:44:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40230 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJ3Qo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 12:44:59 -0400
Received: by mail-ua1-f67.google.com with SMTP id i13so908375uaq.7
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2019 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3/pbvedwS4IhZb4B6nbOhbMOZh2AXw7ndulwhv3TfM=;
        b=uKbzD6z3ZGjc1fWALJKpEEB/bbWW4HPabd5njl25crREYFACWhI8l1Kir807xOxFpf
         uaLa/jYOBB4myt492ky0Bm4YMaUYwzK/94ra2AKsk/hjtGfxyIUNsYZMw3k03FhB7aa+
         D2OMDUrVDFG4lh3JnM9JNhFiNrQATzIWHgWWrsFo/gfWlZcp7D/KPuimOVmXF9dmZDOE
         kqpQKHr+JjnMM9ArF0cPmyy5HSVupmLBQmTJ2rUO9BmpLiphAUI7CTD1n8sVbxM3f7P+
         y4tJ9cXCf+NQfuudxvOK6UYmowPV5Kf2WNvQcUvzZdfMJCJXPEp22cQ//ywxY1dvTRRP
         vp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3/pbvedwS4IhZb4B6nbOhbMOZh2AXw7ndulwhv3TfM=;
        b=M7QYmxlBzx1id1nZ15rUiHnOgp/FIUk7AeCSv8ROGJLOYsGIsWGTrk+LzrP21RnVp3
         UDnfcN8Rpcc6rNdYwcAQzRTzcDGZagbopyWZjMmFWQSlc6N2p7AgIse1JG9x61AJW/In
         VsWWVGk3LfqegAxenHiJbeZPXQutlyzqZBzdvej5LFJa/3SDvagCoTy4U1VKyeRvQU/p
         5VlQyULXb8HHdWD4Q/hwDn+FV8/pBDasBHBvdyCz1tBJiU75UynNvvc+N/Q7Y74ZbKtC
         v4MG2LVLmH8KY6nhJSPAzKMS9GZAqV45Nfvri2HQDfGfPZUdMt2p0XizJk9skzURhz62
         0fRw==
X-Gm-Message-State: APjAAAUiNvszNVnM39EY/Dm2fD4Av73/UqoAzU8/z9Zo5fl7Qq9Q/51i
        +42Z8Ok9+l41IaBjk/5XkVz5UfSsREIuFe3u5qEXKw==
X-Google-Smtp-Source: APXvYqxJtN6SyNTtxvr9eHmowjOiNggxSentSJ3MZnyqcgsnfmMgt0WjJPDMGJJ+lnTYhFM/TEriRkTW1hDBpWXDXFc=
X-Received: by 2002:ab0:2258:: with SMTP id z24mr367974uan.100.1572453897721;
 Wed, 30 Oct 2019 09:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571510481.git.hns@goldelico.com> <bec9d76e6da03d734649b9bdf76e9d575c57631a.1571510481.git.hns@goldelico.com>
In-Reply-To: <bec9d76e6da03d734649b9bdf76e9d575c57631a.1571510481.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Oct 2019 17:44:21 +0100
Message-ID: <CAPDyKFrMQ3fBaeeAYVJfUdL8m=PDRU9Xt_9oGw6D1XOY68qDuQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] DTS: ARM: pandora-common: define wl1251 as child
 node of mmc3
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kalle Valo <kvalo@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Sterba <dsterba@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 19 Oct 2019 at 20:42, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Since v4.7 the dma initialization requires that there is a
> device tree property for "rx" and "tx" channels which is
> not provided by the pdata-quirks initialization.
>
> By conversion of the mmc3 setup to device tree this will
> finally allows to remove the OpenPandora wlan specific omap3
> data-quirks.
>
> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: <stable@vger.kernel.org> # 4.7.0
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 37 +++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> index ec5891718ae6..c595b3eb314d 100644
> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -226,6 +226,18 @@
>                 gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;     /* GPIO_164 */
>         };
>
> +       /* wl1251 wifi+bt module */
> +       wlan_en: fixed-regulator-wg7210_en {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwlan";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;

I doubt these are correct.

I guess this should be in the range of 2.7V-3.6V.

> +               startup-delay-us = <50000>;
> +               regulator-always-on;

Always on?

> +               enable-active-high;
> +               gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         /* wg7210 (wifi+bt module) 32k clock buffer */
>         wg7210_32k: fixed-regulator-wg7210_32k {
>                 compatible = "regulator-fixed";
> @@ -522,9 +534,30 @@
>         /*wp-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;*/    /* GPIO_127 */
>  };
>
> -/* mmc3 is probed using pdata-quirks to pass wl1251 card data */
>  &mmc3 {
> -       status = "disabled";
> +       vmmc-supply = <&wlan_en>;
> +
> +       bus-width = <4>;
> +       non-removable;
> +       ti,non-removable;
> +       cap-power-off-card;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc3_pins>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       wlan: wl1251@1 {
> +               compatible = "ti,wl1251";
> +
> +               reg = <1>;
> +
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;  /* GPIO_21 */
> +
> +               ti,wl1251-has-eeprom;
> +       };
>  };
>
>  /* bluetooth*/
> --
> 2.19.1
>

Kind regards
Uffe
