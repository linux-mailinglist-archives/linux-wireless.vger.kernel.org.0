Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3104C21FA9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEQVft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 17:35:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33087 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfEQVfs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 17:35:48 -0400
Received: by mail-io1-f67.google.com with SMTP id z4so6668946iol.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2019 14:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vsolVvxUAyaGD+ep6hBLxhR4l5wSZuWQlF+qKUotMQ=;
        b=msKXmY+I7Ub8YEJ3xKA/XcNkPSBNyWjcc2hNyOizN+/+f+WysTEuRK7v+FoSPBitC4
         9qNfNpmPYhTn9taZx/eTbeTMUGUbmM0Fl9kz0Qmj91YHodeZVbj65acBpz0h1/bCxHej
         bm6whG6GgObYZ3ui9k4LQFFaCOFGio9VcbQh+lZ7a+07/9eqT2ywp9bmBvzRHJ/UY+pa
         6c4LsM5Nicbso1WN8e5wOKjL9nhf8H/ByMco2J0bgn7Ub3v/YZG9oH/p53dn6GxtnVdA
         7DMd2xEgkKHYlajl2fK0iu1Osn6X5GtmaqfvUk21mJD5WlVwC9rhz1o5JnQkM3yL6u+N
         hZ5g==
X-Gm-Message-State: APjAAAXIEaWcWHxfJrVQCDSyfdtyxEnyK/jG5QnrGhbCzF1rJ+mT9D0i
        /6fnkKxZuHlHU+iZWUPkF1MuoQu7lVOyoMAyq2EW8A==
X-Google-Smtp-Source: APXvYqxHQ6FTN0GBZEX3Eql3QrZLqWW2mP7z5YZDwvBQskiqrBuqA0CCtz06bsbkoUrJlCcx7dvow/zz1fNUNGL9idk=
X-Received: by 2002:a6b:b408:: with SMTP id d8mr10061196iof.12.1558128948222;
 Fri, 17 May 2019 14:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558127930.git.lorenzo@kernel.org> <38aa977df45a92f60d78d9cb7e575289ccbaeef6.1558127930.git.lorenzo@kernel.org>
In-Reply-To: <38aa977df45a92f60d78d9cb7e575289ccbaeef6.1558127930.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Fri, 17 May 2019 23:35:37 +0200
Message-ID: <CAJ0CqmXen_WGJRxjt4Kzr0SPrT=rTSUToUXFz=d7EZnLP11a3w@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7615: select wifi band according to eeprom
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, royluo@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Select supported band according to the value read from
> eeprom mtd/otp partition
>

I forgot to mention this patch is based on 'mt76: mt7615: add support
for mtd eeprom parsing'
https://patchwork.kernel.org/patch/10947385/

Regards,
Lorenzo

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../wireless/mediatek/mt76/mt7615/eeprom.c    | 24 ++++++++++++++++---
>  .../wireless/mediatek/mt76/mt7615/eeprom.h    |  9 +++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> index 1712f66520a8..714590878d65 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> @@ -90,6 +90,26 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
>         }
>  }
>
> +static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
> +{
> +       u8 val, *eeprom = dev->mt76.eeprom.data;
> +
> +       val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
> +                       eeprom[MT_EE_WIFI_CONF]);
> +       switch (val) {
> +       case MT_EE_5GHZ:
> +               dev->mt76.cap.has_5ghz = true;
> +               break;
> +       case MT_EE_2GHZ:
> +               dev->mt76.cap.has_2ghz = true;
> +               break;
> +       default:
> +               dev->mt76.cap.has_2ghz = true;
> +               dev->mt76.cap.has_5ghz = true;
> +               break;
> +       }
> +}
> +
>  int mt7615_eeprom_init(struct mt7615_dev *dev)
>  {
>         int ret;
> @@ -103,9 +123,7 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
>                 memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
>                        MT7615_EEPROM_SIZE);
>
> -       dev->mt76.cap.has_2ghz = true;
> -       dev->mt76.cap.has_5ghz = true;
> -
> +       mt7615_eeprom_parse_hw_cap(dev);
>         memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
>                ETH_ALEN);
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
> index a4cf16688171..b422e395d6ee 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
> @@ -11,8 +11,17 @@ enum mt7615_eeprom_field {
>         MT_EE_VERSION =                         0x002,
>         MT_EE_MAC_ADDR =                        0x004,
>         MT_EE_NIC_CONF_0 =                      0x034,
> +       MT_EE_WIFI_CONF =                       0x03e,
>
>         __MT_EE_MAX =                           0x3bf
>  };
>
> +#define MT_EE_NIC_WIFI_CONF_BAND_SEL           GENMASK(5, 4)
> +enum mt7615_eeprom_band {
> +       MT_EE_DUAL_BAND,
> +       MT_EE_5GHZ,
> +       MT_EE_2GHZ,
> +       MT_EE_DBDC,
> +};
> +
>  #endif
> --
> 2.20.1
>
