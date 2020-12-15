Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8962DA48A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Dec 2020 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgLOAJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 19:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgLOAJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 19:09:36 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896FC061793
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 16:08:56 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id f71so4369259vka.12
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ttijJTfODj0Zw+PUd0CH6vbnNY+xpMxFmKzapopdOo=;
        b=LhdygB6+PBVsoDGFWC8aF15Je+KPpnI6r+Rt5Sz9g43Zpp0Xs2L2fC5GSgzqBlXg+S
         vq8JK7fV829mSoDKbXrHdXTSi+nic/z16m6KRLSEFk2bRFeBQhdFzKNApWYzUoMj6rBt
         rMViZEL6bvs9tRj0RLKx90ABvNFCjAPqS7G0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ttijJTfODj0Zw+PUd0CH6vbnNY+xpMxFmKzapopdOo=;
        b=bFMh43usBZ5RsG3XmTHnAe6cLJs38OBV5yCzVUv1La1RjOnuAwMrZuDijQZDNlQQM/
         oaEF9d96JqmU49+EdWqqxcrbJGLdtkvh+6QPkfIaAnksV80E0UE68IKAhZmCGEvA8xBJ
         wRRXcxA3EoGWHRqNWuL2WVLfDTFYQCk+gfe5iia8WFAUuYZmodj99a5344dYZ5Ayzu76
         qwEIm2nyIdK2sSBZpDwkklrrQqPWUQTP2/55/Oo0FyhQLLSoOTEAYHj5OJvx4HmjWNUZ
         BJcewW+6h0LZO+BS4vv73wMa5XDKjSBLK4CEo24dV3V2JK9r3OHmCT9T3EsYbGZUtMOU
         WIoQ==
X-Gm-Message-State: AOAM531jRXrVZct6PQieLYZK1MdT4rt8LcUJVgHVpXR1/mYxY043E8l7
        sbdZNXPzAbJSiVAD/h6jgOUQf3dEzRysMGJZGgEdSA==
X-Google-Smtp-Source: ABdhPJy/1hO7y7P77oLAkHG/yrijX8RVfCX/zuNWqZhUuTxFWOz7zvfhphWSajaxWShotI0auCTiSWY1pyVLaO3pj/I=
X-Received: by 2002:ac5:c5b5:: with SMTP id f21mr26908136vkl.13.1607990935654;
 Mon, 14 Dec 2020 16:08:55 -0800 (PST)
MIME-Version: 1.0
References: <4f0b3800cd92e1a45a1a47598174e3ff8e944204.1607949735.git.objelf@gmail.com>
In-Reply-To: <4f0b3800cd92e1a45a1a47598174e3ff8e944204.1607949735.git.objelf@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 15 Dec 2020 08:08:44 +0800
Message-ID: <CANMq1KAgYKBXGPMgpMpAF=6rWv3zVsHBBjwX1fOCRC2THCYM5Q@mail.gmail.com>
Subject: Re: [PATCH -next v2] mt76: mt7921: introduce mt7921e support
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        Ryder Lee <ryder.lee@mediatek.com>, robin.chiu@mediatek.com,
        ch.yeh@mediatek.com, Eric.Liang@mediatek.com,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, YN.Chen@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Soul.Huang@mediatek.com,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 14, 2020 at 8:56 PM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Introduce support for mt7921e 802.11ax (Wi-Fi 6) 2x2:2SS chipset.
>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
> Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2:
>  - Mark the patch as -next
> ---
>  drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
>  drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
>  .../net/wireless/mediatek/mt76/mt7921/Kconfig |   10 +
>  .../wireless/mediatek/mt76/mt7921/Makefile    |    6 +
>  .../wireless/mediatek/mt76/mt7921/debugfs.c   |  180 ++
>  .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 +++
>  .../wireless/mediatek/mt76/mt7921/eeprom.c    |  247 ++
>  .../wireless/mediatek/mt76/mt7921/eeprom.h    |  126 +
>  .../net/wireless/mediatek/mt76/mt7921/init.c  |  482 +++
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1387 +++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mac.h   |  367 +++
>  .../net/wireless/mediatek/mt76/mt7921/main.c  |  854 ++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2588 +++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  991 +++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  379 +++
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  209 ++
>  .../net/wireless/mediatek/mt76/mt7921/regs.h  |  455 +++
>  17 files changed, 8639 insertions(+)

I'm not likely to review this, but, this is a _huge_ patch, is there a
way to split it in easier to digest parts?

[snip]

> +static void
> +mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
> +{
> +       struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
> +       struct debug_msg {
> +               __le16 id;
> +               u8 type;
> +               u8 flag;
> +               __le32 value;
> +               __le16 len;
> +               u8 content[512];
> +       } __packed * debug_msg;
> +       u16 cur_len;
> +       int i;
> +
> +       skb_pull(skb, sizeof(*rxd));
> +       debug_msg = (struct debug_msg *)skb->data;
> +
> +       cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
> +
> +       if (debug_msg->type == 0x3) {
> +               for (i = 0 ; i < cur_len; i++)
> +                       if (!debug_msg->content[i])
> +                               debug_msg->content[i] = ' ';
> +
> +               trace_printk("%s", debug_msg->content);

Please do not use trace_printk in production code [1,2], it is only
meant for debug use. Consider using trace events, or dev_dbg.

[1] https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3158
[2] https://elixir.bootlin.com/linux/v5.8/source/include/linux/kernel.h#L766

> +       }
> +}
> +

> --
> 2.25.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
