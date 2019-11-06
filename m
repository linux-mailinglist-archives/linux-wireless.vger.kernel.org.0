Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B81F201E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 21:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKFUyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 15:54:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36009 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfKFUyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 15:54:02 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so10220qko.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAXTXx+y7I3ABYm6s1rIW7RNlcFe9UpszDevKDlT4/k=;
        b=e2+YoGwNlA+e5m4thOFQWvvUz7P9TCxVRqlaGPD78OiFXg7dAB33VGQVlPHiqqIEq3
         yF3k5xfClE888/6GEz0359ZQ8UHIVo49+NeGiudIurC64Ma93yLGI6o5UNkMkO7BW+aL
         UpFsjVGBxsNx958W+6Ka7dlfYDFCSsGm0hugk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAXTXx+y7I3ABYm6s1rIW7RNlcFe9UpszDevKDlT4/k=;
        b=rp+F2aqzDw77LMOS9+BiXKonHOqmV1R5+hNPGwJKAjOVEHDKJCXtBpb258C2iNX/FA
         SUumuV7P7QuKdJajFsceQfZT1sfhlYJZKvQ0h97J2nhWZHkVKaeSVy5X23JzxsHoKc7R
         qgWUDY6BKW3ZUYk5tD+VfpcDLanyiTpcWVy3PDENjFR8a3xQOvngAjV9v/jL6Yt+qE8v
         NAfuud3khKhl3+CK2Jv85Rr31gRQw2uM711uQOdMQcLzLkhy/I0YTTo0eBA5/AMws/L2
         Y920GOOPxJ822fTTlOXrN8EwOosh5db4v0GMRAKdjRmdWcVOaOd66gt68uTfaPACf/6z
         wOAQ==
X-Gm-Message-State: APjAAAUVauM3qx6GKXoSopG7JtiaJX92mJ26pkMSthtge+Dcz49wAOJc
        Em3Vax8nmxOm4oqHOKzbOHT6Tf2PFrM=
X-Google-Smtp-Source: APXvYqyyy1FZSDXNNZjnru4xndITT7HAfNS+zpl4v7Wqb0w9suMY9L0C08E9ZOeLnPca9e9I8FF/Gg==
X-Received: by 2002:a37:7b83:: with SMTP id w125mr3796021qkc.343.1573073640870;
        Wed, 06 Nov 2019 12:54:00 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id b13sm20957qtj.64.2019.11.06.12.53.59
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:54:00 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id w11so2033326qvu.13
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 12:53:59 -0800 (PST)
X-Received: by 2002:ad4:5550:: with SMTP id v16mr1177231qvy.18.1573073639225;
 Wed, 06 Nov 2019 12:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20191016123301.2649-1-yhchuang@realtek.com> <20191016123301.2649-2-yhchuang@realtek.com>
 <CA+ASDXNmMiW_FaqCKowzZW6fnBhA+JXcGBJOEToBA47EShu35A@mail.gmail.com> <F7CD281DE3E379468C6D07993EA72F84D1900C92@RTITMBSVM04.realtek.com.tw>
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1900C92@RTITMBSVM04.realtek.com.tw>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 6 Nov 2019 12:53:48 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMg5hKuXUxsdAuig0_t0TNJL10ZcaZ-iQ79tVKPNjzMXg@mail.gmail.com>
Message-ID: <CA+ASDXMg5hKuXUxsdAuig0_t0TNJL10ZcaZ-iQ79tVKPNjzMXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rtw88: use macro to check the current band
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A little late on this...

On Wed, Oct 16, 2019 at 7:39 PM Tony Chuang <yhchuang@realtek.com> wrote:
> From: Brian Norris
> > On Wed, Oct 16, 2019 at 5:33 AM <yhchuang@realtek.com> wrote:
> > > index 4759d6a0ca6e..492a2bfc0d5a 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/main.h
> > > +++ b/drivers/net/wireless/realtek/rtw88/main.h
> > > @@ -58,6 +58,19 @@ struct rtw_hci {
> > >         u8 bulkout_num;
> > >  };
> > >
> > > +#define IS_CH_5G_BAND_1(channel) ((channel) >= 36 && (channel <= 48))
> > > +#define IS_CH_5G_BAND_2(channel) ((channel) >= 52 && (channel <= 64))
> > > +#define IS_CH_5G_BAND_3(channel) ((channel) >= 100 && (channel <=
> > 144))
> > > +#define IS_CH_5G_BAND_4(channel) ((channel) >= 149 && (channel <=
> > 177))
> >
> > There are channels between 48 and 52, 64 and 100, and 144 and 149.
> > What are you doing with those?
>
> These devices are not supporting those channels you mentioned.
> So I hope if some unsupported channels are used, they should hit the
> "else" case, or throw such a warn.

Maybe that argument makes sense on its own, but see below:

> > > +#define IS_CH_5G_BAND_MID(channel) \
> > > +       (IS_CH_5G_BAND_2(channel) || IS_CH_5G_BAND_3(channel))
> > > +
> > > +#define IS_CH_2G_BAND(channel) ((channel) <= 14)
> > > +#define IS_CH_5G_BAND(channel) \
> > > +       (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel) || \
> > > +        IS_CH_5G_BAND_3(channel) || IS_CH_5G_BAND_4(channel))
> >
> > Given the above (you have major holes in 5G_BAND{1,2,3,4}), this macro
> > seems like a regression.

I still think it's a terrible idea to write an intentionally
misleading macro named "IS 5G BAND" that returns false for 5G
channels. It just gives you a nice way to stub your toe if you ever
have chips that do support these channels.

Brian
