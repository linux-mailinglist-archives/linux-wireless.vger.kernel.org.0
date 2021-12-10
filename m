Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5899346FD93
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhLJJXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhLJJXg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:23:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B7C061746
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:20:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y7so5922650plp.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/mF1VPMo13JARvfkDjHr5/SisaG+Ir20CU/Tf/n9Bg=;
        b=SToSPaYYAt5mCO4LV8n0LNNwad0lFzIFdUv0esQWcpbEgkFZzuux3siphGame7FM2r
         Ay23dOwBhJXGiuOqpGZJ3A65aJoJ1QiXOc8OCOC565gJTZZ64qnda05vnB/tAyJi5/XZ
         oVXhMUWhBn+VmSstg/Uhpql8Iqk3ZW3a7eq951c8IwTrcgLLc3Ov2FG0gfxvQCu9ZIRS
         DVFvgSczXQv4wcIC43mb5t0XJFy5PdYBt4rThwBV/fHvWdAzkeeocm2HhJhhBRAFbzMx
         Kv+ZbDLXHpwV1wiKc5Y/+RuDN+65wiLJ3HoHpJ6LeX7ZJMTTl4O1hGPPp2490W992ct/
         Uiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/mF1VPMo13JARvfkDjHr5/SisaG+Ir20CU/Tf/n9Bg=;
        b=y06KM3a9b5dXXqweS5MNw4g38vifEw75MhWk04bte2xbOcCP7eC/hdKQWn3N8z/3Ng
         Fl3h0OT0J3js0OyQIgoD/aazdGmN1uxPu1IFC0XC1uJktx7EUPiC3hIIma9V3kHN4tQf
         bQI/RhFV24/gH69tvuxt0CYa5qRWqKuF6gj8/JAMMiRyIUKKL9XVp3qBnbz/OaLf9AWg
         WGmlSf1b4Y2Ybmrobp94IX50oQvMDBjZfEeJ74aquLd9OQm+eCG1nGVLLKxEbd8n8Cdw
         4hstFqea30oSQsX+q2VjxGCNJYKqIAiHUPhEe1jGMCARhUbiqmXCIJLVBgPpgSZKuc99
         ATfQ==
X-Gm-Message-State: AOAM530VBoeuXL+99oNsD9HtVnYkNkem977GNldlgFGvPiJkOeheSiia
        4s+rV1MlfeFOMc1SmlxBKVIRN3pWSBScEdVKZLA86A==
X-Google-Smtp-Source: ABdhPJyR0qD6gQT9kxLS+TicnbMDkT3jme4w96GoC3u7hWvbtWBi6a1XLTQp9ydHVow7YRCzk+Jdqmz0eYrY2jqIEM0=
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr22476405pjm.141.1639128001613;
 Fri, 10 Dec 2021 01:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210082247.977043-1-tzungbi@google.com> <8735n0oneg.fsf@tynnyri.adurom.net>
In-Reply-To: <8735n0oneg.fsf@tynnyri.adurom.net>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 10 Dec 2021 17:19:50 +0800
Message-ID: <CA+Px+wXbeeHw5TgOk4yY7EdL-BTc124HDgtR6bmmm1X4VQtqjA@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921: reduce log severity levels for informative messages
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 10, 2021 at 4:49 PM Kalle Valo <kvalo@kernel.org> wrote:
>
> Tzung-Bi Shih <tzungbi@google.com> writes:
[...]
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > index 6ada1ebe7d68..99b144fd8db5 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > @@ -882,7 +882,7 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
> >       dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
> >  #endif /* CONFIG_PM */
> >
> > -     dev_err(dev->mt76.dev, "Firmware init done\n");
> > +     dev_info(dev->mt76.dev, "Firmware init done\n");
>
> Shouldn't that be a debug message? Hard to see how's that useful in
> normal operation.

I thought the message was an indicator of "the firmware is loaded
completely".  Sent v2 to use dbg instead.
