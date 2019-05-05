Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B448C14092
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2019 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEEPVz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 May 2019 11:21:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46210 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEEPVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 May 2019 11:21:54 -0400
Received: by mail-io1-f66.google.com with SMTP id m14so9063003ion.13
        for <linux-wireless@vger.kernel.org>; Sun, 05 May 2019 08:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVBEW6sKfQcD98so0LtUodd/t1sSW5W7Xo/OMbea+DE=;
        b=ZQZW/6MmNXWmNLQh1WeUIYR3m7mstrr0c2hKUN6E8skC3SwrW5WVsr5xHbwf97LTxj
         npOukYzZXPzLjn17sR9qaz7BleeuXL7+o5Uf6WdKxEyCYBb9mf+Nk4iq7dU8Qa+UjHOL
         X/aD1Ty1Eq+8sB1E95aCnDW5n2hxB7hJwn0lH7GPbngE2sBCrekCItMI2AmhosjNtQ8H
         vG1YWNsh9bmqMlJOzfELC12m3zTU8yK7mZtQNWsFZvbMiSGKDoa53r2oL5RlS+hyquE4
         frkCEoeuJhIfemRyYiI4jvD+cAWoqjR7JoEyA55OlIYrVwhgnuDv3kdD1aBrTph7zhfh
         QBcA==
X-Gm-Message-State: APjAAAWiiVZJOShxjhdes+D2HXzTwE7mr9TViW5dzjQNfeOTssH4HS+0
        iKhKCBWIDR3a/O7aR7eonSoKJJ7CXL6k+lAc8eoYLg==
X-Google-Smtp-Source: APXvYqwmPcrFOADI8gcHnTKY+kvZPvojykreH4Pn7ACA2pGVQqOSETI9wkeLxZM9Ez/65hXOjbhNHOMqAA0cqUDBxXM=
X-Received: by 2002:a6b:4f07:: with SMTP id d7mr13015226iob.228.1557069713894;
 Sun, 05 May 2019 08:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556981521.git.lorenzo@kernel.org> <de228dd80ba394aeb79ed9987e34cb37b495509a.1556981521.git.lorenzo@kernel.org>
In-Reply-To: <de228dd80ba394aeb79ed9987e34cb37b495509a.1556981521.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 5 May 2019 17:21:43 +0200
Message-ID: <CAJ0CqmUT77ka3v6_aAVf1hgkXJHm3uxNZTkH1uuLtwR-niSpPw@mail.gmail.com>
Subject: Re: [PATCH 12/17] mt7615: mcu: do not use function pointers whenever possible
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, royluo@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Remove function pointers in mt7615_mcu_set_bss_info and run function
> directly. Moreover remove __mt7615_mcu_set_bss_info since it is run just
> by mt7615_mcu_set_bss_info and remove duplicated istructions
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 220 +++++++++---------
>  1 file changed, 105 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index 0e82fcb34e07..0632b506dd57 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -676,154 +676,107 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
>         return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
>  }
>

[...]

> @@ -832,15 +785,52 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>                 WARN_ON(1);
>                 break;
>         }
> -       memcpy(bss_info.bssid, vif->bss_conf.bssid, ETH_ALEN);
>
> -       if (en) {
> -               bss_info.feature |= BIT(BSS_INFO_OMAC);
> -               if (mvif->omac_idx > EXT_BSSID_START)
> -                       bss_info.feature |= BIT(BSS_INFO_EXT_BSS);
> +       buf = kzalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       hdr = (struct req_hdr *)buf;
> +       hdr->bss_idx = mvif->idx;
> +       hdr->tlv_num = cpu_to_le16(ntlv);
> +       hdr->is_tlv_append = 1;
> +
> +       data = buf + sizeof(*hdr);
> +       for (i = 0; i < BSS_INFO_MAX_NUM; i++) {
> +               int tag = max_t(int, ffs(features & BIT(i)) - 1, 0);
> +

Ops, I found an issue here, it should be:

int tag = ffs(features & BIT(i)) - 1;

@Felix: do I need to resubmit the whole series or just a fix for this patch?

Regards,
Lorenzo

> +               switch (tag) {
> +               case BSS_INFO_OMAC:
> +                       mt7615_mcu_bss_info_omac_header(mvif, data,
> +                                                       conn_type);
> +                       data += sizeof(struct bss_info_omac);
> +                       break;
> +               case BSS_INFO_BASIC:
> +                       mt7615_mcu_bss_info_basic_header(vif, data, net_type,
> +                                                        tx_wlan_idx, en);
> +                       data += sizeof(struct bss_info_basic);
> +                       break;
> +               case BSS_INFO_EXT_BSS:
> +                       mt7615_mcu_bss_info_ext_header(mvif, data);
> +                       data += sizeof(struct bss_info_ext_bss);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       skb = mt7615_mcu_msg_alloc(buf, len);
> +       if (!skb) {
> +               ret = -ENOMEM;
> +               goto out;
>         }
>
> -       return __mt7615_mcu_set_bss_info(dev, &bss_info);
> +       ret = mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_BSS_INFO_UPDATE);
> +
> +out:
> +       kfree(buf);
> +
> +       return ret;
>  }
>
>  static int
> --
> 2.20.1
>
