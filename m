Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7E43F42C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ2A6e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 20:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2A6e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 20:58:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D18C061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 17:56:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ee16so19158782edb.10
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02iNYarIGivgAYG46j9hVKUgfe1wBVpz8bSFnnDAryo=;
        b=lUdSPDlxpaJHm92JtgcD1+V87XBrSIHA10cIWbtsXBA5Rm04k1FNrk6cWnwkV1S+bC
         r3TH58DMW3M6ebDvyidHUAcDv+GaSWMkwGYBBXoP2fBT1nH6AS/TBb4PrvQOPGlhS+zA
         rw1X79Rv7FvU6eH19S2qcZfy8LZxMD6dNGRdiBzlkkSnqwTkN6xvG51XXLdoWm9vEn1F
         YZfZgb+BpI3LzlZ6RZs0LUnaFJlZ5F75GwJB/j5h+k/7HJ8Q8VHA69bgPZG6f9IywDZc
         y6+vzcBAk9bA6KLLeG0hKw6TVZTMcu0y0WANs7cYL8Xu4Hqm2pyged9wNz8HUB7FChtg
         7YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02iNYarIGivgAYG46j9hVKUgfe1wBVpz8bSFnnDAryo=;
        b=tCj1eL6d2hjrs/UGix2JfnulEsyk8LDs1cXTgDwv3XAF4sYoHfwIBkwKHApubji4P+
         HkxPJww3SYbjDZKbs06igZwu1nynJrHltE3acaFme/1EcjtK5hO4nfW7wZQ+vOFi/l8y
         f0jxM81qEHRlrEkjZAjdaJQzbAi+w0+kULA4sl0/4pr/sAHJsC0ArPwz/0qGcFaobJqH
         DcwHCQlfgFYvvWbPBZnUXEcw/q3vXaIccqx0S3MeSgjrm02MdW3kvvjIOnM76Atzd6lJ
         kM6jOa0UncFIDQuzdrrRtNZBz8cHMDxvfQhLyYx1sPrENAz1TA4LAeLNjUFAWf+ffOPT
         0fBQ==
X-Gm-Message-State: AOAM533nev6XvsGMH4z+lWNijfntwL4uPpwdEr8uEP4vp/HmN9+jF0fJ
        iyJYjHtoxOn1DfxoZ7oWDRBpLx0mkSjx4Yy2ocobLm+m
X-Google-Smtp-Source: ABdhPJxNot0/izRy915/AnfoF3Z8790pgFFQ0WCKMhTkLn5eXNDGWsQ45zGAD5/9geVzA4WRGoEkwiSWE6bnEknkWjo=
X-Received: by 2002:aa7:da84:: with SMTP id q4mr10703024eds.371.1635468964839;
 Thu, 28 Oct 2021 17:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080747.24388-1-shayne.chen@mediatek.com>
In-Reply-To: <20211027080747.24388-1-shayne.chen@mediatek.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 29 Oct 2021 11:55:52 +1100
Message-ID: <CAGRGNgUvTU=yYfuKcB2VvHjqLBKVPpVJaLvMpxK926y=yniKsg@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7915: add default calibrated data support
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Shayne,

On Thu, Oct 28, 2021 at 6:25 AM Shayne Chen <shayne.chen@mediatek.com> wrote:
>
> Load the default eeprom data when the content of flash/efuse is invalid.
> This could help to eliminate some issues due to incorrect or
> insufficient rf values.
>
> Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7915/eeprom.c    | 83 +++++++++++++++----
>  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 24 ++++++
>  .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
>  4 files changed, 98 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index ee3d644..626ea4a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -42,20 +89,28 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
>                                               i * MT7915_EEPROM_BLOCK_SIZE);
>         }
>
> -       return ret;
> -}
> -
> -static int mt7915_check_eeprom(struct mt7915_dev *dev)
> -{
> -       u8 *eeprom = dev->mt76.eeprom.data;
> -       u16 val = get_unaligned_le16(eeprom);
> +       if (!dev->flash_mode) {
> +               u8 free_block_num;
> +
> +               mt7915_mcu_get_eeprom_free_block(dev, &free_block_num);
> +               if (free_block_num >= 29) {
> +                       dev_warn(dev->mt76.dev,
> +                                "efuse info not enough, use default bin\n");
> +                       ret = mt7915_eeprom_load_default(dev);
> +                       if (ret)
> +                               return ret;

You've got two instances of the code where it tries to load the
default if the EEPROM data isn't valid.

You could potentially simplify this by structuring the code that calls
this function so it's something like:

ret = mt7915_eeprom_load();

if (!ret) {
    ret = mt7915_eeprom_load_default();
}

return ret;

with mt7915_eeprom_load() just returning -EINVAL if the EEPROM
contents aren't valid instead of trying to fix it itself.

This would also make the code simpler if there ends up being another
way to get EEPROM data in the future, e.g. an NVRAM partition
referenced through the device tree, etc.

> +               }
> +       }
>
> -       switch (val) {
> -       case 0x7915:
> -               return 0;
> -       default:
> -               return -EINVAL;
> +       ret = mt7915_check_eeprom(dev);
> +       if (ret) {
> +               dev_warn(dev->mt76.dev, "eeprom check fail, use default bin\n");
> +               ret = mt7915_eeprom_load_default(dev);
> +               if (ret)
> +                       return ret;
>         }
> +
> +       return ret;
>  }
>
>  void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
