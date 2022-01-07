Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE50486F23
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 01:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbiAGAxu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 19:53:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43710 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiAGAxu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 19:53:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B74DF61C55
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 00:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BE4C36AF2
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 00:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641516829;
        bh=nYMfX0PQEEcGyF0H8x+KlP1s0dR8rB1ycPBC9UYkQso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TDgQUoazanv32fETyq7r+fCtK2KZ7Mo65QL5VwqIpftXwZDXZdmaLH/VnZrqiTaNA
         ZU5nj9eh6NyahngxRnYIvuXAYz4Q6Kchc3Z+0cgXKjAa8lpD4MNnROwyvCqUUUI8rz
         AizidV7wBVzEfLYGnpbyE4hZYysA3ldTjbD+EB2NzAGOFeHyNrAai3KfEDZGu9K+tg
         S5sCzQe8rnQzAB8EptnqDISWOUSRwiNJe/96ZBBLEaQq1ZEqE9f30pPMTCAsl6X/j3
         Xjp5WsxssWfK7A6x5CIGvOfoXtYfStEb+i/Bp5qXwAvUpl9rB/VcCCIBzyvi9MfVco
         C0oA58FWh5pqA==
Received: by mail-ed1-f50.google.com with SMTP id a18so14949590edj.7
        for <linux-wireless@vger.kernel.org>; Thu, 06 Jan 2022 16:53:49 -0800 (PST)
X-Gm-Message-State: AOAM532aAlxtSEo7n5aldKHK/78pCY992eZkDegks0i/lBrVF4BJSEf/
        QYja5AGgXP0xK0BgYUcl0M49tnELWiEO7punih8=
X-Google-Smtp-Source: ABdhPJw0Gc0TNtKOHZ5twchJsi3kTNJ1Wu5XZ+ztGL+GlEdOyTbnfsvhpaOq1NuMYoFC4vUCi4Nz44/bY9IiymXRnIE=
X-Received: by 2002:a05:6402:1a35:: with SMTP id be21mr58560242edb.215.1641516827342;
 Thu, 06 Jan 2022 16:53:47 -0800 (PST)
MIME-Version: 1.0
References: <77cd7840525c8c967ced523bcc954471930e17c5.1641420635.git.objelf@gmail.com>
In-Reply-To: <77cd7840525c8c967ced523bcc954471930e17c5.1641420635.git.objelf@gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 6 Jan 2022 16:53:34 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoZyYZgT8_mvQHPRYW2gS5QuYcPpNjXnWscrUJEB4_OZg@mail.gmail.com>
Message-ID: <CAGp9LzoZyYZgT8_mvQHPRYW2gS5QuYcPpNjXnWscrUJEB4_OZg@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix reset failure in mt7921_pci_probe
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

@nbd please drop the patch, I will post a new one to fix the aspm issue

On Thu, Jan 6, 2022 at 1:32 PM <sean.wang@mediatek.com> wrote:
>
> From: Deren Wu <deren.wu@mediatek.com>
>
> Ensure that the device returns to the driver's own state to switch ASPM
> into the active state before we start resetting the device to fix
> the following kernel panic.
>
> [   17.164952]  dump_stack_lvl+0x48/0x5e
> [   17.164955]  bad_page.cold+0x63/0x94
> [   17.164957]  free_pcppages_bulk+0x1f2/0x360
> [   17.164961]  free_unref_page+0xb4/0x120
> [   17.164963]  mt76_dma_rx_cleanup+0x94/0x110 [mt76]
> [   17.164969]  mt7921_wpdma_reset+0xbc/0x1c0 [mt7921e]
> [   17.164972]  mt7921_register_device+0x32b/0x5d0 [mt7921_common]
> [   17.164976]  mt7921_pci_probe+0x1d5/0x210 [mt7921e]
> [   17.164977]  ? __pm_runtime_resume+0x58/0x80
> [   17.164979]  local_pci_probe+0x45/0x80
> [   17.164981]  ? pci_match_device+0xac/0x130
> [   17.164983]  pci_device_probe+0xd2/0x1c0
> [   17.164984]  really_probe+0x1f5/0x3f0
> [   17.164987]  __driver_probe_device+0xfe/0x180
> [   17.164988]  driver_probe_device+0x1e/0x90
> [   17.164990]  __driver_attach+0xc0/0x1c0
> [   17.164991]  ? __device_attach_driver+0xe0/0xe0
> [   17.164992]  ? __device_attach_driver+0xe0/0xe0
> [   17.164994]  bus_for_each_dev+0x78/0xc0
> [   17.164995]  new_id_store+0xfc/0x1d0
> [   17.164996]  kernfs_fop_write_iter+0x11c/0x1b0
> [   17.164998]  new_sync_write+0x11f/0x1b0
> [   17.165001]  vfs_write+0x209/0x2a0
> [   17.165003]  ksys_write+0x5f/0xe0
> [   17.165004]  do_syscall_64+0x3b/0xc0
> [   17.165006]
>
> Fixes: bf3747ae2e25 ("mt76: mt7921: enable aspm by default")
> Reported-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/dma.c    |  4 ++++
>  .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 +
>  .../wireless/mediatek/mt76/mt7921/pci_mcu.c    | 18 ++++++++++++++----
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> index cdff1fd52d93..0c4b0e0e634a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -364,6 +364,10 @@ int mt7921_dma_init(struct mt7921_dev *dev)
>         if (ret)
>                 return ret;
>
> +       ret = __mt7921e_mcu_drv_pmctrl(dev);
> +       if (ret)
> +               return ret;
> +
>         ret = mt7921_wfsys_reset(dev);
>         if (ret)
>                 return ret;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 8b674e042568..63e3c7ef5e89 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -443,6 +443,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev);
>  int mt7921s_wfsys_reset(struct mt7921_dev *dev);
>  int mt7921s_mac_reset(struct mt7921_dev *dev);
>  int mt7921s_init_reset(struct mt7921_dev *dev);
> +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> index f9e350b67fdc..36669e5aeef3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> @@ -59,10 +59,8 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
>         return err;
>  }
>
> -int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
>  {
> -       struct mt76_phy *mphy = &dev->mt76.phy;
> -       struct mt76_connac_pm *pm = &dev->pm;
>         int i, err = 0;
>
>         for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> @@ -75,9 +73,21 @@ int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
>         if (i == MT7921_DRV_OWN_RETRY_COUNT) {
>                 dev_err(dev->mt76.dev, "driver own failed\n");
>                 err = -EIO;
> -               goto out;
>         }
>
> +       return err;
> +}
> +
> +int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> +{
> +       struct mt76_phy *mphy = &dev->mt76.phy;
> +       struct mt76_connac_pm *pm = &dev->pm;
> +       int err;
> +
> +       err = __mt7921e_mcu_drv_pmctrl(dev);
> +       if (err < 0)
> +               goto out;
> +
>         mt7921_wpdma_reinit_cond(dev);
>         clear_bit(MT76_STATE_PM, &mphy->state);
>
> --
> 2.25.1
>
