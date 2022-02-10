Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953954B0254
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 02:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiBJBbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 20:31:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiBJBa7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 20:30:59 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629F22526
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 17:31:00 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z18so3228439iln.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Feb 2022 17:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4w1CApPhPDgmcFgoua9r1tKXruanOSQmLFyp0HkppI=;
        b=RBcfMgtXqLtIv9YJQLaPRKF42VFVYLSLtyXrVcIFzeZdBZAXqjMZE4pPfVx8KMW+sc
         AbaJxQFfLnQfZhCNqdGtlu6F/mzRB8thWMz0cejSGY6ZYbaAPGBdGDmk9RJgFluWmkVa
         +QLMI4Rp850o4+P6UR9PXCRIi4zJPlEHIdlbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4w1CApPhPDgmcFgoua9r1tKXruanOSQmLFyp0HkppI=;
        b=HddTLmjGMZ1dzzGbx+j1YExcD+YgSihvKI14dG6sJPJQWGkQZE5hSpKls+JrBpcZIv
         zoz95On0Wfi0YfHdRoGMYMEjhwJxRXMqaFv+cniE8u2Mdb+vCQ8BOJpyWpYGPtTaf8v7
         2rbrysBy0QDo1G6uXZRL6/afF0dqxrEfwsL3pc0Ec/78Pjh7wd7Rkw35BWo9LHj4Qjvi
         F6Vo5hr2VXjtRNeql7rKVpsJH4A+Czw3IXRrPDwOabX7RoJQHYn24/4TeOPDFy2Uw4Nc
         Y3GMhD2db+41ngBTfviv5g5t/KhtBL9G53NnjdNmOcFNB1yqE/YTCENojeWzHjdin/mD
         y/EQ==
X-Gm-Message-State: AOAM530WVdd0e4SLH6STQH9ecwsTGXbhsAXmWgugLuIkX/j6lpJSeEMp
        yP8530T5M2FH51jSOpABCjhkK8ITX7U2B81PMPtVkWvXPRw=
X-Google-Smtp-Source: ABdhPJwNbjhKO1NI3h25Hc1gnTydBgfZyYC9Qo/rZi9Jc8eA2/B4A82ki8D3OQ3s8Fw/7xtoGh5TmcCkdpK6Xo6MEag=
X-Received: by 2002:a05:6e02:1e08:: with SMTP id g8mr2784767ila.278.1644455133779;
 Wed, 09 Feb 2022 17:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20220207093023.10605-1-quic_bqiang@quicinc.com>
In-Reply-To: <20220207093023.10605-1-quic_bqiang@quicinc.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Wed, 9 Feb 2022 17:05:23 -0800
Message-ID: <CACTWRwugAHA87-AuEkC7tXEEuOhef_FrWBjjk4pQXZvpmHQ65A@mail.gmail.com>
Subject: Re: [PATCH] ath11k: Reset PCIE_GPIO_CFG_REG register when power on
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Abhishek Kumar <kuabhs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 7, 2022 at 1:41 AM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>
> On some modules, PCIE_GPIO_CFG_REG is not initialized to right value,
> this will cause WCN6855 hardware fails to be enumerated.
>
> Fix it by force writing the correct value to this register when power
> on.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Can you elaborate how you tested this ? I can see due to this patch
shows resource temporarily unavailable after running simulated wifi
crash in a loop.
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 11 +++++++++++
>  drivers/net/wireless/ath/ath11k/pci.h |  3 +++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index d73b522a0081..06968ad488b0 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -445,6 +445,16 @@ static void ath11k_pci_force_wake(struct ath11k_base *ab)
>         mdelay(5);
>  }
>
> +static void ath11k_pci_gpio_reset(struct ath11k_base *ab)
> +{
> +       int val;
> +
> +       ath11k_pci_write32(ab, PCIE_GPIO_CFG_REG, PCIE_GPIO_RESET_VAL);
> +       mdelay(10);
> +       val = ath11k_pci_read32(ab, PCIE_GPIO_CFG_REG);
> +       ath11k_dbg(ab, ATH11K_DBG_PCI, "gpio cfg: 0x%x\n", val);
> +}
Looks like you have added delay before reading which gets printed as a
debug log. In this case, I don't think you should add the
unconditional delay and read the register unconditionally but rather
should do only if debug is enabled. Thought ?
> +
>  static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>  {
>         mdelay(100);
> @@ -461,6 +471,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>         ath11k_pci_clear_dbg_registers(ab);
>         ath11k_pci_soc_global_reset(ab);
>         ath11k_mhi_set_mhictrl_reset(ab);
> +       ath11k_pci_gpio_reset(ab);
>  }
>
>  int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
> diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
> index 61d67b20a0eb..2716fc7745d6 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.h
> +++ b/drivers/net/wireless/ath/ath11k/pci.h
> @@ -52,6 +52,9 @@
>  #define WLAON_QFPROM_PWR_CTRL_REG              0x01f8031c
>  #define QFPROM_PWR_CTRL_VDD4BLOW_MASK          0x4
>
> +#define PCIE_GPIO_CFG_REG                      0x0180e000
> +#define PCIE_GPIO_RESET_VAL                    0xc5
> +
>  struct ath11k_msi_user {
>         char *name;
>         int num_vectors;
> --
> 2.25.1
>

Thanks
Abhishek
