Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025370198C
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEMTtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjEMTtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 15:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A31FDA
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684007293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOWXtGClXTGyVkmNieaR+4IKrzuDtp9Iq5EkIJHQ6Bk=;
        b=IPEDpWMHxCSJ2tYOHuDt6X81bKPXnWO5Lf5Vl/kDPNlz1SA1vZvZDL/W7VlPGm83236D81
        iziecoR5lpDTWWzV+OXOseW3wJHyMwCqM4NBsKd7jP7VuziJx09ZGTX90rCoXeg3FjkN/6
        ZQshVLs2G8wbwA6iq6Ie8wukhdrhpW8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--xYssqhcPG6gYPfEaykglw-1; Sat, 13 May 2023 15:48:11 -0400
X-MC-Unique: -xYssqhcPG6gYPfEaykglw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so1315822066b.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 12:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684007290; x=1686599290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOWXtGClXTGyVkmNieaR+4IKrzuDtp9Iq5EkIJHQ6Bk=;
        b=ByomclG1VHNh0RjSuGnLpho9sQFl/VpJneFvQLftQWZbeZHgEQshL6+//NeWm4Gwjf
         sTDYCDOltvTD/1cPXs1jxC/hJYop7FgVojRDagrStLtKvNSu+d8g3F2yUBRiL8UWjmjt
         nTjn5ArJR08+eyvNKeN1K+RokKr08VFC+ex5cORfTDMCPpbEhHgUHs/+fegxPy287m0W
         gKVxaZjc3CdJCHzkqwWYz/8Gc4H6HhXl7BRrryKcyIYZQrwi1SRbxJpqX4sQv9bufGxp
         n7PiHRM4X1viKoGjtZEyV1HQ0UWPubCC5GWzJ5BJKbasW9vigvenaC2yGqCvIWMjsD5V
         sE+w==
X-Gm-Message-State: AC+VfDxqK+5ocwkDVsBaUv2INpm02SarPlYJb2vyjkhEQyVdb3pHiTFR
        8mbj3N5OEbVtOYfuQYulp+CZ/r7ffGKjqFlLGGPAzjiE5g5iysL9oy5nZ4ghru+z+VcuziB0zR2
        mcuB9C7iu5nraXEIwojqbkvqeisg=
X-Received: by 2002:a17:907:3f83:b0:94e:8d26:f610 with SMTP id hr3-20020a1709073f8300b0094e8d26f610mr25849267ejc.28.1684007290632;
        Sat, 13 May 2023 12:48:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4uV0zikgGK1Uto4jgYWjfBrTLZ/7APRhpNdrc9hzNOujOvfLfyiV1UUUtLhdEQKwx2H9scSQ==
X-Received: by 2002:a17:907:3f83:b0:94e:8d26:f610 with SMTP id hr3-20020a1709073f8300b0094e8d26f610mr25849252ejc.28.1684007290273;
        Sat, 13 May 2023 12:48:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tk13-20020a170907c28d00b0094f185d82dcsm7030372ejc.21.2023.05.13.12.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 12:48:09 -0700 (PDT)
Message-ID: <b2f19e4b-7d33-695d-4a7a-e4aabe5d2d99@redhat.com>
Date:   Sat, 13 May 2023 21:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH REGRESSION FIX v2] wifi: brcmfmac: Check for probe() id
 argument being NULL
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, regressions@lists.linux.dev,
        Felix <nimrod4garoa@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        stable@vger.kernel.org
References: <20230510141856.46532-1-hdegoede@redhat.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230510141856.46532-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 5/10/23 16:18, Hans de Goede wrote:
> The probe() id argument may be NULL in 2 scenarios:
> 
> 1. brcmf_pcie_pm_leave_D3() calling brcmf_pcie_probe() to reprobe
>    the device.
> 
> 2. If a user tries to manually bind the driver from sysfs then the sdio /
>    pcie / usb probe() function gets called with NULL as id argument.
> 
> 1. Is being hit by users causing the following oops on resume and causing
> wifi to stop working:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> <snip>
> Hardware name: Dell Inc. XPS 13 9350/0PWNCR, BIDS 1.13.0 02/10/2020
> Workgueue: events_unbound async_run_entry_fn
> RIP: 0010:brcmf_pcie_probe+Ox16b/0x7a0 [brcmfmac]
> <snip>
> Call Trace:
>  <TASK>
>  brcmf_pcie_pm_leave_D3+0xc5/8x1a0 [brcmfmac be3b4cefca451e190fa35be8f00db1bbec293887]
>  ? pci_pm_resume+0x5b/0xf0
>  ? pci_legacy_resume+0x80/0x80
>  dpm_run_callback+0x47/0x150
>  device_resume+0xa2/0x1f0
>  async_resume+0x1d/0x30
> <snip>
> 
> Fix this by checking for id being NULL.
> 
> In the PCI and USB cases try a manual lookup of the id so that manually
> binding the driver through sysfs and more importantly brcmf_pcie_probe()
> on resume will work.
> 
> For the SDIO case there is no helper to do a manual sdio_device_id lookup,
> so just directly error out on a NULL id there.
> 
> Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
> Reported-by: Felix <nimrod4garoa@gmail.com>
> Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This is now also:

Tested by: Nimrod MacIomhair <nimrod4garoa@gmail.com>

Can we get this regression fix merged please ?

Regards,

Hans




> ---
> Changes in v2:
> - Using BRCMF_FWVENDOR_INVALID will just lead to a probe() error later on,
>   if NULL error out immediately instead of using BRCMF_FWVENDOR_INVALID.
> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |  5 +++++
>  .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 11 +++++++++++
>  .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c    | 11 +++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index 65d4799a5658..f06684f84789 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -1032,6 +1032,11 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
>  	struct brcmf_sdio_dev *sdiodev;
>  	struct brcmf_bus *bus_if;
>  
> +	if (!id) {
> +		dev_err(&func->dev, "Error no sdio_device_id passed for %x:%x\n", func->vendor, func->device);
> +		return -ENODEV;
> +	}
> +
>  	brcmf_dbg(SDIO, "Enter\n");
>  	brcmf_dbg(SDIO, "Class=%x\n", func->class);
>  	brcmf_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index a9b9b2dc62d4..d9ecaa0cfdc4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -2339,6 +2339,9 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
>  }
>  #endif
>  
> +/* Forward declaration for pci_match_id() call */
> +static const struct pci_device_id brcmf_pcie_devid_table[];
> +
>  static int
>  brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> @@ -2349,6 +2352,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct brcmf_core *core;
>  	struct brcmf_bus *bus;
>  
> +	if (!id) {
> +		id = pci_match_id(brcmf_pcie_devid_table, pdev);
> +		if (!id) {
> +			pci_err(pdev, "Error could not find pci_device_id for %x:%x\n", pdev->vendor, pdev->device);
> +			return -ENODEV;
> +		}
> +	}
> +
>  	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
>  
>  	ret = -ENOMEM;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 246843aeb696..2178675ae1a4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -1331,6 +1331,9 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
>  	brcmf_usb_detach(devinfo);
>  }
>  
> +/* Forward declaration for usb_match_id() call */
> +static const struct usb_device_id brcmf_usb_devid_table[];
> +
>  static int
>  brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  {
> @@ -1342,6 +1345,14 @@ brcmf_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	u32 num_of_eps;
>  	u8 endpoint_num, ep;
>  
> +	if (!id) {
> +		id = usb_match_id(intf, brcmf_usb_devid_table);
> +		if (!id) {
> +			dev_err(&intf->dev, "Error could not find matching usb_device_id\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	brcmf_dbg(USB, "Enter 0x%04x:0x%04x\n", id->idVendor, id->idProduct);
>  
>  	devinfo = kzalloc(sizeof(*devinfo), GFP_ATOMIC);

