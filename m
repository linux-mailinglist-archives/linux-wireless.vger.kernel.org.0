Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE78D00F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2019 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHNJuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Aug 2019 05:50:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45727 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNJuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Aug 2019 05:50:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id m24so27915852otp.12
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2019 02:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Mpl2x0wUOtqSVNJzmCcBu6w+hNzqhf3ysgpJFe/+J4=;
        b=T7UWn1DDIQXOpNj2FALaX9dfVLPEWthJ3kdgDf39DgzA0wNj45lVxNgoSgewN9PEIx
         ElonJzvDUSTJanr9NyAF2/WsKO4rr/aKpEC9DdvASAJIenvUdOVg2l6IbLRahN9c8MVW
         sHj/wDoDpPb9ZM9CxzBMsq0RBeqaxOYQsVUG9+B4kmhwtA+neuhbnKXg6AE/qhdpABc9
         uHaUlz2evxq9lEvMMZ8duloXIswAAoPO4mh3AymfgbKOMFmfJzvEUMBlWvsYCqFVgooE
         z94ucxQesiR9MfSmsouF76EK1MWeS90Od9ZxSocWCsbuNw778A7nLoziRYfOigQQVFh+
         X9wA==
X-Gm-Message-State: APjAAAVdf6YUQmS1pJJB74EOhIQV15DMZyfVk4Fj66VF7cKjVf2vpimI
        U4e/dngECq9Mjn2F3il7vA40w0N7dtHmetYcDtV9wR3B7rg=
X-Google-Smtp-Source: APXvYqwlOfbYjTZXb8DIpxX+wZtsdstps7b7KKFeq0jv4m1BYIFvkLuZZn9g4Lsi8ufu+wAGGhpfxgN31xpAWQ9T/Aw=
X-Received: by 2002:a6b:ce19:: with SMTP id p25mr29966000iob.201.1565776223074;
 Wed, 14 Aug 2019 02:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Wed, 14 Aug 2019 11:50:12 +0200
Message-ID: <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> I can observe firmware hangs on MT7630E on station mode: tx stop
> functioning after minor activity (rx keep working) and on module
> unload device fail to stop with messages:
>
> [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
>
> Loading module again results in failure to associate with AP.
> Only machine power off / power on cycle can make device work again.
>
> It's unclear why commit 41634aa8d6db causes the problem, but it is
> related to HW encryption. Since issue is a firmware hang, that is super
> hard to debug, just disable HW encryption as fix for the issue.
>
> Fixes: 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> index 4585e1b756c2..6117e6ca08cb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> @@ -62,6 +62,19 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
>         mt76x0e_stop_hw(dev);
>  }
>
> +static int
> +mt76x0e_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> +               struct ieee80211_vif *vif, struct ieee80211_sta *sta,
> +               struct ieee80211_key_conf *key)
> +{
> +       struct mt76x02_dev *dev = hw->priv;
> +
> +       if (is_mt7630(dev))
> +               return -EOPNOTSUPP;

Hi Stanislaw,

Can you please try if disabling/enabling the tx tasklet during hw key
configuration fixes the issue?
Doing something like:

tasklet_disable(tx_tasklet)
mt76x02_set_key()
tasklet_enable(tx_tasklet)

Moreover, have you double checked if there is any performance impact
of not using hw encryption?
If so, I guess it is better to just redefine mt76_wake_tx_queue for
mt76x0e and run mt76_txq_schedule for 7630e:

void mt76x0e_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
{
        if (is_mt7630(dev)) {
            mt76_txq_schedule(dev, txq->ac);
        } else {
            tasklet_schedule(&dev->tx_tasklet);
        }
}

Regards,
Lorenzo

> +
> +       return mt76x02_set_key(hw, cmd, vif, sta, key);
> +}
> +
>  static void
>  mt76x0e_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>               u32 queues, bool drop)
> @@ -78,7 +91,7 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
>         .configure_filter = mt76x02_configure_filter,
>         .bss_info_changed = mt76x02_bss_info_changed,
>         .sta_state = mt76_sta_state,
> -       .set_key = mt76x02_set_key,
> +       .set_key = mt76x0e_set_key,
>         .conf_tx = mt76x02_conf_tx,
>         .sw_scan_start = mt76x02_sw_scan,
>         .sw_scan_complete = mt76x02_sw_scan_complete,
> --
> 1.9.3
>
