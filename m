Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F646C796D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCXINK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXINJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 04:13:09 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FE23A48
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 01:13:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O3oFXA027124;
        Fri, 24 Mar 2023 09:12:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Jdxe2QnZMKBXRctYc7VDAexUtn/tD3hW6wEw3zuHgA8=;
 b=Ag/fcrYZraBHCCxbZ+dOehCJkz8NrGKJRgCsqePfn3ORhELZswARW/62SJ8TNzO9AHIB
 ycmzM54h5W60g+wgzihsm6WojXxGP87508BYTbNNJsGpzbDqjM7ckA6zFpC5HAl1vMch
 6xeWdMklABrYuD2pID3rUMNy8dyR4H2vbTbINQBPVhIGJZCR8bGF5YKw4vCs1HKrS/ra
 aLcTFIn4C9whgDQJCy9ApKUI7pkz574DKPmThHsveyGgqP9i9iZ3Z3WqIVjy/EamlEJg
 sbjM2Pnlwds0HpiVp7CL4QssMo2ubOC4RKs4Qmw0IgDi1s2gQZCSrlnbetqsKAhTz27U ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pgxhx30pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 09:12:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60AE9100046;
        Fri, 24 Mar 2023 09:12:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CAFE20E1D9;
        Fri, 24 Mar 2023 09:12:13 +0100 (CET)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Mar
 2023 09:12:12 +0100
Message-ID: <d3dc26af-5f96-1f47-3e80-9f31eacd7345@foss.st.com>
Date:   Fri, 24 Mar 2023 09:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
References: <20230320122252.240070-1-hdegoede@redhat.com>
 <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_04,2023-03-23_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/23/23 15:33, Ulf Hansson wrote:
> + Yann, Christophe
> 

Hi Ulf,

Thanks for the forward!
The patch only changes code under CONFIG_ACPI, which isn't enabled on 
Arm platforms. So no impact for STM32MP1 on which we saw the first 
issue, and for which you made the ("brcmfmac: Avoid keeping power to 
SDIO card unless WOWL is used") patch.


Best regards,
Yann

> On Mon, 20 Mar 2023 at 13:22, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
>> unless WOWL is used"), the wifi adapter by default is turned off on suspend
>> and then re-probed on resume.
>>
>> In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
>> the newly added re-probe on resume fails like this:
>>
>>   brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>>   ieee80211 phy1: brcmf_bus_started: failed: -110
>>   ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
>>   brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>>
>> It seems this specific brcmfmac model does not like being reprobed without
>> it actually being turned off first.
>>
>> And the adapter is not being turned off during suspend because of
>> commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
>> driver").
>>
>> Now that the driver is being reprobed on resume, the disabling of ACPI
>> pm is no longer necessary, except when WOWL is used (in which case there
>> is no-reprobe).
>>
>> Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
>> the brcmfmac43430a1 suspend/resume regression and should help save some
>> power when suspended.
>>
>> This change means that the code now also may re-enable ACPI pm when WOWL
>> gets disabled. ACPI pm should only be re-enabled if it was enabled by
>> the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
>> to save the original state for this.
>>
>> This has been tested on the following devices:
>>
>> Asus T100TA                brcmfmac43241b4-sdio
>> Acer Iconia One 7 B1-750   brcmfmac43340-sdio
>> Chuwi Hi8                  brcmfmac43430a0-sdio
>> Chuwi Hi8                  brcmfmac43430a1-sdio
>>
>> (the Asus T100TA is the device for which the prohibiting of ACPI pm
>>   was originally added)
>>
>> Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Seems reasonable to me, thanks for fixing this! Feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
>> ---
>> Changes in v2:
>> - Drop no longer used "struct device *dev" local variable from
>>    brcmf_ops_sdio_probe() - Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> - Note this is a resend of v2 with Kalle Valo/s email address fixed
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 36 +++++++++++++------
>>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  2 ++
>>   2 files changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> index b7c918f241c9..65d4799a5658 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> @@ -994,15 +994,34 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
>>   MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
>>
>>
>> -static void brcmf_sdiod_acpi_set_power_manageable(struct device *dev,
>> -                                                 int val)
>> +static void brcmf_sdiod_acpi_save_power_manageable(struct brcmf_sdio_dev *sdiodev)
>>   {
>>   #if IS_ENABLED(CONFIG_ACPI)
>>          struct acpi_device *adev;
>>
>> -       adev = ACPI_COMPANION(dev);
>> +       adev = ACPI_COMPANION(&sdiodev->func1->dev);
>>          if (adev)
>> -               adev->flags.power_manageable = 0;
>> +               sdiodev->func1_power_manageable = adev->flags.power_manageable;
>> +
>> +       adev = ACPI_COMPANION(&sdiodev->func2->dev);
>> +       if (adev)
>> +               sdiodev->func2_power_manageable = adev->flags.power_manageable;
>> +#endif
>> +}
>> +
>> +static void brcmf_sdiod_acpi_set_power_manageable(struct brcmf_sdio_dev *sdiodev,
>> +                                                 int enable)
>> +{
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +       struct acpi_device *adev;
>> +
>> +       adev = ACPI_COMPANION(&sdiodev->func1->dev);
>> +       if (adev)
>> +               adev->flags.power_manageable = enable ? sdiodev->func1_power_manageable : 0;
>> +
>> +       adev = ACPI_COMPANION(&sdiodev->func2->dev);
>> +       if (adev)
>> +               adev->flags.power_manageable = enable ? sdiodev->func2_power_manageable : 0;
>>   #endif
>>   }
>>
>> @@ -1012,7 +1031,6 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>>          int err;
>>          struct brcmf_sdio_dev *sdiodev;
>>          struct brcmf_bus *bus_if;
>> -       struct device *dev;
>>
>>          brcmf_dbg(SDIO, "Enter\n");
>>          brcmf_dbg(SDIO, "Class=%x\n", func->class);
>> @@ -1020,14 +1038,9 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>>          brcmf_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
>>          brcmf_dbg(SDIO, "Function#: %d\n", func->num);
>>
>> -       dev = &func->dev;
>> -
>>          /* Set MMC_QUIRK_LENIENT_FN0 for this card */
>>          func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
>>
>> -       /* prohibit ACPI power management for this device */
>> -       brcmf_sdiod_acpi_set_power_manageable(dev, 0);
>> -
>>          /* Consume func num 1 but dont do anything with it. */
>>          if (func->num == 1)
>>                  return 0;
>> @@ -1059,6 +1072,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>>          dev_set_drvdata(&sdiodev->func1->dev, bus_if);
>>          sdiodev->dev = &sdiodev->func1->dev;
>>
>> +       brcmf_sdiod_acpi_save_power_manageable(sdiodev);
>>          brcmf_sdiod_change_state(sdiodev, BRCMF_SDIOD_DOWN);
>>
>>          brcmf_dbg(SDIO, "F2 found, calling brcmf_sdiod_probe...\n");
>> @@ -1124,6 +1138,8 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
>>
>>          if (sdiodev->settings->bus.sdio.oob_irq_supported ||
>>              pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
>> +               /* Stop ACPI from turning off the device when wowl is enabled */
>> +               brcmf_sdiod_acpi_set_power_manageable(sdiodev, !enabled);
>>                  sdiodev->wowl_enabled = enabled;
>>                  brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
>>                  return;
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
>> index b76d34d36bde..0d18ed15b403 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
>> @@ -188,6 +188,8 @@ struct brcmf_sdio_dev {
>>          char nvram_name[BRCMF_FW_NAME_LEN];
>>          char clm_name[BRCMF_FW_NAME_LEN];
>>          bool wowl_enabled;
>> +       bool func1_power_manageable;
>> +       bool func2_power_manageable;
>>          enum brcmf_sdiod_state state;
>>          struct brcmf_sdiod_freezer *freezer;
>>          const struct firmware *clm_fw;
>> --
>> 2.39.1
>>

