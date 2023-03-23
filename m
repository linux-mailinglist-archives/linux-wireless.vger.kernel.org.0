Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEF6C6B1B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCWOeY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOeX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 10:34:23 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE204269F
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 07:34:21 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n125so25015473ybg.7
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679582061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCK+AHdWmI6lLOi6XUzKF4IhKIkwo19qhm7zeCNU2mk=;
        b=qEpbcObdbnC7Wl2DxZPR+JzlyjFMMIWyZrzmMfncdzih180CWOza5fQmW03v9E+vHz
         +tzxg5IU2naC22GCF8fAC/tpHYOUBswSrRPt7vnmjEV7KLugvJJzALj2DOJjLHSg4hJ3
         eI6ntm6o+0KPBjujfK5IDHDPIHZDnkTWIMbw0n+80Hu3eCR2OuPP6db0MM6VaR0byFnb
         c7rCTCOFeNf/+8FE3jLQpdZ4qr8BH4u79Hw0nP2Vn3YBUELlL7u1kqm4J0KL9HDMV1Nk
         1WfniNi39QJE2eZYNdXqQXi3r6V9Lr8J2Z50zLm7RljUPANmiyne9bUQldr3DFEBGeaJ
         +4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCK+AHdWmI6lLOi6XUzKF4IhKIkwo19qhm7zeCNU2mk=;
        b=CPHAVs2Hg8nry1XkBQPB20MmX4VynbG47vcOW6FSAFL/PDuVrDq0DhPCkL6/tUdpN/
         kLmB/rdp4veIvpEQ5VRq8nPy5ovLD7kkLgt2gL31WJFme/8B6aN/T/NHk7o3YwYUbQiL
         dQubjjFeb7/iy2raiXmGMfyAw1SXg81qK/wusa6fOSibvEEctJg7qUoDOxDiOMGWAZ2B
         PpG3tdw7JhdV+oIsyIgC6kD54gKdPEvSHcdJKAdNrRM+qdVtAdA71OAySVrnFKc8pWa+
         BBGMi+QhpTWiS51oEMaP8m1FZfSkF3WPsSGRWQMA6gO5eY3iiALJOgGRjxU66gca2DM5
         ODEQ==
X-Gm-Message-State: AAQBX9dGz2Mc4G2NMB5uAKg/WDmbLxzpTwKEcQP64J61usKF3on1IA0F
        YmpNYuIx0wYV6LfRHG8fYdATsHJlpwOyEwwFFZ/tFA==
X-Google-Smtp-Source: AKy350aDFlGC/qXxElMHcf8CD335Ui2s0qvCzX8oeeajtJTt5xe0C6ETaotIMSkNM/pVICSmYbv0eP8M2S2uGhYyA7k=
X-Received: by 2002:a05:6902:1689:b0:b75:8ac3:d5d9 with SMTP id
 bx9-20020a056902168900b00b758ac3d5d9mr1232607ybb.3.1679582060822; Thu, 23 Mar
 2023 07:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230320122252.240070-1-hdegoede@redhat.com>
In-Reply-To: <20230320122252.240070-1-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 15:33:44 +0100
Message-ID: <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Yann, Christophe

On Mon, 20 Mar 2023 at 13:22, Hans de Goede <hdegoede@redhat.com> wrote:
>
> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
> unless WOWL is used"), the wifi adapter by default is turned off on suspend
> and then re-probed on resume.
>
> In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
> the newly added re-probe on resume fails like this:
>
>  brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>  ieee80211 phy1: brcmf_bus_started: failed: -110
>  ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
>  brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>
> It seems this specific brcmfmac model does not like being reprobed without
> it actually being turned off first.
>
> And the adapter is not being turned off during suspend because of
> commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
> driver").
>
> Now that the driver is being reprobed on resume, the disabling of ACPI
> pm is no longer necessary, except when WOWL is used (in which case there
> is no-reprobe).
>
> Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
> the brcmfmac43430a1 suspend/resume regression and should help save some
> power when suspended.
>
> This change means that the code now also may re-enable ACPI pm when WOWL
> gets disabled. ACPI pm should only be re-enabled if it was enabled by
> the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
> to save the original state for this.
>
> This has been tested on the following devices:
>
> Asus T100TA                brcmfmac43241b4-sdio
> Acer Iconia One 7 B1-750   brcmfmac43340-sdio
> Chuwi Hi8                  brcmfmac43430a0-sdio
> Chuwi Hi8                  brcmfmac43430a1-sdio
>
> (the Asus T100TA is the device for which the prohibiting of ACPI pm
>  was originally added)
>
> Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Seems reasonable to me, thanks for fixing this! Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Changes in v2:
> - Drop no longer used "struct device *dev" local variable from
>   brcmf_ops_sdio_probe() - Reported-by: kernel test robot <lkp@intel.com>
> ---
> - Note this is a resend of v2 with Kalle Valo/s email address fixed
> ---
>  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 36 +++++++++++++------
>  .../broadcom/brcm80211/brcmfmac/sdio.h        |  2 ++
>  2 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index b7c918f241c9..65d4799a5658 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -994,15 +994,34 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>  MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
>
>
> -static void brcmf_sdiod_acpi_set_power_manageable(struct device *dev,
> -                                                 int val)
> +static void brcmf_sdiod_acpi_save_power_manageable(struct brcmf_sdio_dev *sdiodev)
>  {
>  #if IS_ENABLED(CONFIG_ACPI)
>         struct acpi_device *adev;
>
> -       adev = ACPI_COMPANION(dev);
> +       adev = ACPI_COMPANION(&sdiodev->func1->dev);
>         if (adev)
> -               adev->flags.power_manageable = 0;
> +               sdiodev->func1_power_manageable = adev->flags.power_manageable;
> +
> +       adev = ACPI_COMPANION(&sdiodev->func2->dev);
> +       if (adev)
> +               sdiodev->func2_power_manageable = adev->flags.power_manageable;
> +#endif
> +}
> +
> +static void brcmf_sdiod_acpi_set_power_manageable(struct brcmf_sdio_dev *sdiodev,
> +                                                 int enable)
> +{
> +#if IS_ENABLED(CONFIG_ACPI)
> +       struct acpi_device *adev;
> +
> +       adev = ACPI_COMPANION(&sdiodev->func1->dev);
> +       if (adev)
> +               adev->flags.power_manageable = enable ? sdiodev->func1_power_manageable : 0;
> +
> +       adev = ACPI_COMPANION(&sdiodev->func2->dev);
> +       if (adev)
> +               adev->flags.power_manageable = enable ? sdiodev->func2_power_manageable : 0;
>  #endif
>  }
>
> @@ -1012,7 +1031,6 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>         int err;
>         struct brcmf_sdio_dev *sdiodev;
>         struct brcmf_bus *bus_if;
> -       struct device *dev;
>
>         brcmf_dbg(SDIO, "Enter\n");
>         brcmf_dbg(SDIO, "Class=%x\n", func->class);
> @@ -1020,14 +1038,9 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>         brcmf_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
>         brcmf_dbg(SDIO, "Function#: %d\n", func->num);
>
> -       dev = &func->dev;
> -
>         /* Set MMC_QUIRK_LENIENT_FN0 for this card */
>         func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
>
> -       /* prohibit ACPI power management for this device */
> -       brcmf_sdiod_acpi_set_power_manageable(dev, 0);
> -
>         /* Consume func num 1 but dont do anything with it. */
>         if (func->num == 1)
>                 return 0;
> @@ -1059,6 +1072,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>         dev_set_drvdata(&sdiodev->func1->dev, bus_if);
>         sdiodev->dev = &sdiodev->func1->dev;
>
> +       brcmf_sdiod_acpi_save_power_manageable(sdiodev);
>         brcmf_sdiod_change_state(sdiodev, BRCMF_SDIOD_DOWN);
>
>         brcmf_dbg(SDIO, "F2 found, calling brcmf_sdiod_probe...\n");
> @@ -1124,6 +1138,8 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
>
>         if (sdiodev->settings->bus.sdio.oob_irq_supported ||
>             pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
> +               /* Stop ACPI from turning off the device when wowl is enabled */
> +               brcmf_sdiod_acpi_set_power_manageable(sdiodev, !enabled);
>                 sdiodev->wowl_enabled = enabled;
>                 brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
>                 return;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> index b76d34d36bde..0d18ed15b403 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
> @@ -188,6 +188,8 @@ struct brcmf_sdio_dev {
>         char nvram_name[BRCMF_FW_NAME_LEN];
>         char clm_name[BRCMF_FW_NAME_LEN];
>         bool wowl_enabled;
> +       bool func1_power_manageable;
> +       bool func2_power_manageable;
>         enum brcmf_sdiod_state state;
>         struct brcmf_sdiod_freezer *freezer;
>         const struct firmware *clm_fw;
> --
> 2.39.1
>
