Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B5694D13
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 17:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBMQkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjBMQkS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 11:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF383AB1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676306370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qAAmSC/RdZV41RXB0GFMswk+G+3tU5R49dqo8QmqQA=;
        b=CLyX0IGVefQ02eRfrcpcu/Fxx3NeAfJ6rP2+jktJY5fbhs8jJMWYnixXUkR8yz7Xb+M+p7
        QF3bHNOTzrAdl2YOWUJsYSI/UwTvc5+ypjEq0UtKDAgwDJ6pHC7M8wqP06KDUC9CmiQWxE
        Uo7tQ9/FWbM0eI54XfcqBqU1wQ0+Os8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-QGEqOtqdMiqd9ysUpmBxvA-1; Mon, 13 Feb 2023 11:39:29 -0500
X-MC-Unique: QGEqOtqdMiqd9ysUpmBxvA-1
Received: by mail-vk1-f200.google.com with SMTP id n69-20020a1fbd48000000b004015f66acfdso1731591vkf.15
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676306368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qAAmSC/RdZV41RXB0GFMswk+G+3tU5R49dqo8QmqQA=;
        b=42Z0HZNANfC6hai516zJXBfydq9KRq7F9+GxzxPNOOs+pvTA9txljSn1PvYV1NLsHe
         8kiuI22gMuZZwnR2+FNnj3Tqd1OmIjIw2DSCTa/3g6NzHhMR7OL3wbLycQbIXeMxcI/X
         hV4JfHKiUbOGOTdKiIXF5mgSalbXmNRv/mXv7ZGq5p2PYkGI/A8iCwZp6kDKrDr35k1t
         /cNkBRvJmZ8MtQ0FFxHa32B+P875LCuvNK5yc7q4k8vRpnW1x6+Kq70Qvo5tJWDjzxph
         Zbv+iawTq02tVxn/ncujXj76vRX2CAxuIe1JEpBnv6ZxslrlJNrzFuH5YL2jG1zHLw88
         WH0Q==
X-Gm-Message-State: AO0yUKUoq6OEf3mhFCOkS9oSndLnry4ce8WSMeeyC9UtWzTt3qxRl5Ta
        eUtdjWSJUnacTAnOhVH+JsCEMDVRS/TlKzo6gj84ghcsO77No2Rco1DtqPMALliXhYmwj57Oj7A
        ALfIKNgbebH7pTdNPT+TBVbwbGkt16403cfHt+h4H7Xo=
X-Received: by 2002:a67:e087:0:b0:412:45d2:b3db with SMTP id f7-20020a67e087000000b0041245d2b3dbmr210451vsl.40.1676306368374;
        Mon, 13 Feb 2023 08:39:28 -0800 (PST)
X-Google-Smtp-Source: AK7set+qZ97j8GyNwGUqw/4y0w/veR+TgM//1Z1Z/a+q/FO9QSBVpNZsFnr0pldGW1SMqDW9TIaw5LwH9euZUMlrNlw=
X-Received: by 2002:a67:e087:0:b0:412:45d2:b3db with SMTP id
 f7-20020a67e087000000b0041245d2b3dbmr210426vsl.40.1676306368108; Mon, 13 Feb
 2023 08:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20230210025009.21873-1-marcan@marcan.st> <20230210025009.21873-2-marcan@marcan.st>
In-Reply-To: <20230210025009.21873-2-marcan@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 16:39:12 +0000
Message-ID: <CAOgh=FyHs+kG-hVamwyHDefE9TLOO-R=ZKs3VciaBhvW+nBsKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] wifi: brcmfmac: Rename Cypress 89459 to BCM4355
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
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Ian Lin <ian.lin@infineon.com>,
        Soontak Lee <soontak.lee@cypress.com>,
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 10 Feb 2023 at 02:59, Hector Martin <marcan@marcan.st> wrote:
>
> The commit that introduced support for this chip incorrectly claimed it
> is a Cypress-specific part, while in actuality it is just a variant of
> BCM4355 silicon (as evidenced by the chip ID).
>
> The relationship between Cypress products and Broadcom products isn't
> entirely clear but given what little information is available and prior
> art in the driver, it seems the convention should be that originally
> Broadcom parts should retain the Broadcom name.
>
> Thus, rename the relevant constants and firmware file. Also rename the
> specific 89459 PCIe ID to BCM43596, which seems to be the original
> subvariant name for this PCI ID (as defined in the out-of-tree bcmdhd
> driver).
>
> v2: Since Cypress added this part and will presumably be providing
> its supported firmware, we keep the CYW designation for this device.
>
> v3: Drop the RAW device ID in this commit. We don't do this for the
> other chips since apparently some devices with them exist in the wild,
> but there is already a 4355 entry with the Broadcom subvendor and WCC
> firmware vendor, so adding a generic fallback to Cypress seems
> redundant (no reason why a device would have the raw device ID *and* an
> explicitly programmed subvendor).
>
> Fixes: dce45ded7619 ("brcmfmac: Support 89459 pcie")
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hector Martin <marcan@marcan.st>

LGTM

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c    | 5 ++---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 7 +++----
>  .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h  | 5 ++---
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 121893bbaa1d..3e42c2bd0d9a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -726,6 +726,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
>         case BRCM_CC_43664_CHIP_ID:
>         case BRCM_CC_43666_CHIP_ID:
>                 return 0x200000;
> +       case BRCM_CC_4355_CHIP_ID:
>         case BRCM_CC_4359_CHIP_ID:
>                 return (ci->pub.chiprev < 9) ? 0x180000 : 0x160000;
>         case BRCM_CC_4364_CHIP_ID:
> @@ -735,8 +736,6 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
>                 return 0x170000;
>         case BRCM_CC_4378_CHIP_ID:
>                 return 0x352000;
> -       case CY_CC_89459_CHIP_ID:
> -               return ((ci->pub.chiprev < 9) ? 0x180000 : 0x160000);
>         default:
>                 brcmf_err("unknown chip: %s\n", ci->pub.name);
>                 break;
> @@ -1426,8 +1425,8 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
>                 addr = CORE_CC_REG(base, sr_control1);
>                 reg = chip->ops->read32(chip->ctx, addr);
>                 return reg != 0;
> +       case BRCM_CC_4355_CHIP_ID:
>         case CY_CC_4373_CHIP_ID:
> -       case CY_CC_89459_CHIP_ID:
>                 /* explicitly check SR engine enable bit */
>                 addr = CORE_CC_REG(base, sr_control0);
>                 reg = chip->ops->read32(chip->ctx, addr);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index ae57a9a3ab05..96608174a123 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -51,6 +51,7 @@ enum brcmf_pcie_state {
>  BRCMF_FW_DEF(43602, "brcmfmac43602-pcie");
>  BRCMF_FW_DEF(4350, "brcmfmac4350-pcie");
>  BRCMF_FW_DEF(4350C, "brcmfmac4350c2-pcie");
> +BRCMF_FW_CLM_DEF(4355, "brcmfmac4355-pcie");
>  BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-pcie");
>  BRCMF_FW_CLM_DEF(43570, "brcmfmac43570-pcie");
>  BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
> @@ -62,7 +63,6 @@ BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
>  BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>  BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
>  BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
> -BRCMF_FW_DEF(4355, "brcmfmac89459-pcie");
>
>  /* firmware config files */
>  MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
> @@ -78,6 +78,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>         BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
>         BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
>         BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
> +       BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355),
>         BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
>         BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
>         BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
> @@ -93,7 +94,6 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
>         BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>         BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
>         BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378B1), /* revision ID 3 */
> -       BRCMF_FW_ENTRY(CY_CC_89459_CHIP_ID, 0xFFFFFFFF, 4355),
>  };
>
>  #define BRCMF_PCIE_FW_UP_TIMEOUT               5000 /* msec */
> @@ -2609,9 +2609,8 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID, BCA),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
> +       BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
>         BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
> -       BRCMF_PCIE_DEVICE(CY_PCIE_89459_DEVICE_ID, CYW),
> -       BRCMF_PCIE_DEVICE(CY_PCIE_89459_RAW_DEVICE_ID, CYW),
>         { /* end: all zeroes */ }
>  };
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index f4939cf62767..28b6cf8ff286 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -37,6 +37,7 @@
>  #define BRCM_CC_4350_CHIP_ID           0x4350
>  #define BRCM_CC_43525_CHIP_ID          43525
>  #define BRCM_CC_4354_CHIP_ID           0x4354
> +#define BRCM_CC_4355_CHIP_ID           0x4355
>  #define BRCM_CC_4356_CHIP_ID           0x4356
>  #define BRCM_CC_43566_CHIP_ID          43566
>  #define BRCM_CC_43567_CHIP_ID          43567
> @@ -56,7 +57,6 @@
>  #define CY_CC_43012_CHIP_ID            43012
>  #define CY_CC_43439_CHIP_ID            43439
>  #define CY_CC_43752_CHIP_ID            43752
> -#define CY_CC_89459_CHIP_ID            0x4355
>
>  /* USB Device IDs */
>  #define BRCM_USB_43143_DEVICE_ID       0xbd1e
> @@ -90,9 +90,8 @@
>  #define BRCM_PCIE_4366_2G_DEVICE_ID    0x43c4
>  #define BRCM_PCIE_4366_5G_DEVICE_ID    0x43c5
>  #define BRCM_PCIE_4371_DEVICE_ID       0x440d
> +#define BRCM_PCIE_43596_DEVICE_ID      0x4415
>  #define BRCM_PCIE_4378_DEVICE_ID       0x4425
> -#define CY_PCIE_89459_DEVICE_ID         0x4415
> -#define CY_PCIE_89459_RAW_DEVICE_ID     0x4355
>
>  /* brcmsmac IDs */
>  #define BCM4313_D11N2G_ID      0x4727  /* 4313 802.11n 2.4G device */
> --
> 2.35.1
>
>

