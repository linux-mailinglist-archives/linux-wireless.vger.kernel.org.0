Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1D694D23
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 17:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMQpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 11:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBMQpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 11:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F90E3AB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676306668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsgfwTosbRUQDzEfsJb6jddw2oFK8bsqV0kBqfN76bI=;
        b=UgN35lPt9EQzxXnsYLKVbLZWb5KZiyTJzfHNLOl4lGlus0Cft25loW6Rk+Zm30QqqhkpGM
        jLRWyZj/JDs4HpE+VJHiF8CwIP5qn5DQ3pG9AEtHoeSiaKvswbzbN3hM7F5CXVa7YwymYf
        5dPQYw75WhAXy9GHnl5OYDfvX5mqfzQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-joGi8naBNHW59kFIzbQ6TQ-1; Mon, 13 Feb 2023 11:44:27 -0500
X-MC-Unique: joGi8naBNHW59kFIzbQ6TQ-1
Received: by mail-ua1-f72.google.com with SMTP id l42-20020ab0166d000000b00445260e9ad6so4563620uae.13
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsgfwTosbRUQDzEfsJb6jddw2oFK8bsqV0kBqfN76bI=;
        b=ie73QoCDTORp5/yFS4HfGX7peRGns4vjpqn1Kc6h3j36DT4a4xMPnJsUWwYekT7LyK
         ef68VrUYXotkmcZfGfWLn2rnYpYsgOcOC5CvNMwcNq5PgHbZLvVzTSji7uYUSSF/A7Jz
         ka/0tNDzMgzWlSJEomDoKJVULtFVy8NtGZFjKLQ7+yUSEqV3kxYdEugDlN7vUthuQqyL
         5HUEAAkJuwZ9mL6iYUkR/wHpd+q0u9mWzIWLo6LBEujnzoW7GhTqLRWJN0J0Z1+NlZ3d
         gvzKnEdY4L5iO8N7o0t5orx62tSG1YnaOBmFzNcwU/5uioms5qc/7aOxN0xQqGakltgU
         DnLA==
X-Gm-Message-State: AO0yUKWNjwYqXQSaBA2+Cc6PBfOrSVfB1DtlGfv6iiVWr46xsoJeZNFC
        WMSmlvxjMEZGdGgN4nsy4g82AgsbUuxiQoU7TJoGlSgGBzdEs4XnqewLxqLdNV0UZpJ/ByGuTiQ
        CoA739jTZFdyQY4CY/iLwn0QfTtGGRfzo6SafG/UUdww=
X-Received: by 2002:ab0:70c1:0:b0:68a:6575:553e with SMTP id r1-20020ab070c1000000b0068a6575553emr862242ual.57.1676306665364;
        Mon, 13 Feb 2023 08:44:25 -0800 (PST)
X-Google-Smtp-Source: AK7set/kA7cjqqbQSmhH8hSOVWxtbpxERo8grhio+1GjfUfR4Is7upEaQdca8nbiIJM+1sdaV72AdAi9BA9HF7HjVfg=
X-Received: by 2002:ab0:70c1:0:b0:68a:6575:553e with SMTP id
 r1-20020ab070c1000000b0068a6575553emr862225ual.57.1676306665093; Mon, 13 Feb
 2023 08:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20230212063813.27622-1-marcan@marcan.st> <20230212063813.27622-3-marcan@marcan.st>
In-Reply-To: <20230212063813.27622-3-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 16:44:09 +0000
Message-ID: <CAOgh=Fy5PwR6Cf8694nP_wwjoRyhGY+qxvFby7k4N+6XBEaj+w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] brcmfmac: pcie: Add IDs/properties for BCM4355
To:     Hector Martin <marcan@marcan.st>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Prutskov <alep@cypress.com>,
        Ian Lin <ian.lin@infineon.com>,
        Joseph chuang <jiac@cypress.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Aditya Garg <gargaditya08@live.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, asahi@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 12 Feb 2023 at 06:45, Hector Martin <marcan@marcan.st> wrote:
>
> This chip is present on at least these Apple T2 Macs:
>
> * hawaii: MacBook Air 13" (Late 2018)
> * hawaii: MacBook Air 13" (True Tone, 2019)
>
> Users report seeing PCI revision ID 12 for this chip, which Arend
> reports should be revision C2, but Apple has the firmware tagged as
> revision C1. Assume the right cutoff point for firmware versions is
> revision ID 11 then, and leave older revisions using the non-versioned
> firmware filename (Apple only uses C1 firmware builds).
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 +++++++++-
>  .../wireless/broadcom/brcm80211/include/brcm_hw_ids.h  |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 96608174a123..7135f889907a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -52,6 +52,7 @@ BRCMF_FW_DEF(43602, "brcmfmac43602-pcie");
>  BRCMF_FW_DEF(4350, "brcmfmac4350-pcie");
>  BRCMF_FW_DEF(4350C, "brcmfmac4350c2-pcie");
>  BRCMF_FW_CLM_DEF(4355, "brcmfmac4355-pcie");
> +BRCMF_FW_CLM_DEF(4355C1, "brcmfmac4355c1-pcie");
>  BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-pcie");
>  BRCMF_FW_CLM_DEF(43570, "brcmfmac43570-pcie");
>  BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
> @@ -78,7 +79,8 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>         BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
>         BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
>         BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
> -       BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355),
> +       BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x000007FF, 4355),
> +       BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFF800, 4355C1), /* rev ID 12/C2 seen */
>         BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
>         BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
>         BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
> @@ -1994,6 +1996,11 @@ static int brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
>         int ret;
>
>         switch (devinfo->ci->chip) {
> +       case BRCM_CC_4355_CHIP_ID:
> +               coreid = BCMA_CORE_CHIPCOMMON;
> +               base = 0x8c0;
> +               words = 0xb2;
> +               break;
>         case BRCM_CC_4378_CHIP_ID:
>                 coreid = BCMA_CORE_GCI;
>                 base = 0x1120;
> @@ -2590,6 +2597,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
> +       BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 28b6cf8ff286..6e27e3966655 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -72,6 +72,7 @@
>  #define BRCM_PCIE_4350_DEVICE_ID       0x43a3
>  #define BRCM_PCIE_4354_DEVICE_ID       0x43df
>  #define BRCM_PCIE_4354_RAW_DEVICE_ID   0x4354
> +#define BRCM_PCIE_4355_DEVICE_ID       0x43dc
>  #define BRCM_PCIE_4356_DEVICE_ID       0x43ec
>  #define BRCM_PCIE_43567_DEVICE_ID      0x43d3
>  #define BRCM_PCIE_43570_DEVICE_ID      0x43d9
> --
> 2.35.1
>
>

