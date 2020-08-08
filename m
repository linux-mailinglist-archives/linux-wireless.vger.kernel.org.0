Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2C23F86A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Aug 2020 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHHSBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Aug 2020 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgHHSBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Aug 2020 14:01:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAEFC061756
        for <linux-wireless@vger.kernel.org>; Sat,  8 Aug 2020 11:01:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i6so3536664edy.5
        for <linux-wireless@vger.kernel.org>; Sat, 08 Aug 2020 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNMGWRpxLCRNhvFBGn2jHdGfSMLwsC5v0n8Wvl9tloI=;
        b=RrDAKLp+DIWJDyBxuL7EGjOl+uvuEsQWiMmxUldIQgundkg4I5B+fJZqXWuFx1vMnE
         pGVgzvDoVkSAMQbP7EjI/F3/LUYCucJecIctDzjrUp1n9/R+VfYTI2JS0QkiRDYQOF4Z
         DvM6XxjspJ+Ff2KVkWQTDpGIaMdlspoiKIuCCuRkWxDbgrkWLMy4FRvrDIbmocZj4aao
         LnARnBq7PpbwacoH6MRpzJ/o6Ny1JRIJ1hBmPBh5jCyuaH4iz87VK/hWMo1flcQec+z+
         MEf8hrDrO+GsKiYxtexufv5iIz5CuLQEVdukZdjPrIi1MY8tbeJySfoN/6gPb7DlJmDH
         N+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNMGWRpxLCRNhvFBGn2jHdGfSMLwsC5v0n8Wvl9tloI=;
        b=YHqYlm94rD7o48NgAJauR3bwX1Tiv1jNVyjbjPXNLlzuUMumKxTHm1hhnYF51y5vVC
         L+l5ZM6s21vj3RORxXgI8hnOJCMfpRhGsaCl78xavFNK2TstHtnHqHDzoyW4cVWgnsiW
         c3vkQtdmoYDTWQALPI9uE5DlnJkTojWzSUY2hDPz6S6eBOXpe+/w8QoIsDJQAl2yeEzH
         m7d6IqQcHSHBs1HsOLwKnBf+7NcbP8yCvYruL20vTkEhSHy9u71jg7gp7+1AC+meQw2Q
         WOOXdk+i9ziVRAshPMFVyiYb7OS9bj/xI40X25XoFu6UUcd6ERz406CI+Kr81YTAlc0E
         xVag==
X-Gm-Message-State: AOAM530yxd+x99dui/Pt8j1r0305QPa9T9Rgf6wODvZbDSwh1p/GhNCG
        qdx44xnDtFSJD1zxkZ5AYGF6attV4KVCl+dx1Kw=
X-Google-Smtp-Source: ABdhPJwO+qAYZzfY4DVdu4jrtJuqEQEAgJDBQPgUcmUAsW8uqauCkwC2Ac8pWaKoqOLRGUTaLHz6kTE1GQvFWurJiiY=
X-Received: by 2002:a05:6402:6cc:: with SMTP id n12mr14807902edy.258.1596909683186;
 Sat, 08 Aug 2020 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200804104535.GA398141@mwanda>
In-Reply-To: <20200804104535.GA398141@mwanda>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Sat, 8 Aug 2020 20:01:16 +0200
Message-ID: <CAA2SeNKdO6bq5yp4k3q6phJmTDnU5oL5vbJ_mFY78uKMz4CFgQ@mail.gmail.com>
Subject: Re: [bug report] mt76: mt7615: wake device before accessing regmap in debugfs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Hello Lorenzo Bianconi,
>
> The patch ea4906c4be49: "mt76: mt7615: wake device before accessing
> regmap in debugfs" from Jul 3, 2020, leads to the following static
> checker warning:

Hi Dan,

thx for the report. I will post a fix soon.

Regards,
Lorenzo

>
>         drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c:179 mt7615_reset_test_set()
>         warn: inconsistent returns 'dev->mt76.mutex'.
>
> drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
>    159  static int
>    160  mt7615_reset_test_set(void *data, u64 val)
>    161  {
>    162          struct mt7615_dev *dev = data;
>    163          struct sk_buff *skb;
>    164
>    165          if (!mt7615_wait_for_mcu_init(dev))
>    166                  return 0;
>    167
>    168          mt7615_mutex_acquire(dev);
>    169
>    170          skb = alloc_skb(1, GFP_KERNEL);
>    171          if (!skb)
>    172                  return -ENOMEM;
>                         ^^^^^^^^^^^^^^
> This is returning with the mutex held.  What is the mutex protecting?
> We could move the allocation and the skb_put() before the
> mt7615_mutex_acquire().
>
>    173
>    174          skb_put(skb, 1);
>    175          mt76_tx_queue_skb_raw(dev, 0, skb, 0);
>    176
>    177          mt7615_mutex_release(dev);
>    178
>    179          return 0;
>    180  }
>
> regards,
> dan carpenter



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
