Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1947E10C0B6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 00:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfK0XkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 18:40:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44799 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfK0XkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 18:40:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id d199so7385436pfd.11
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2019 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=raddepcS3XU/VKmJZp7vh07W9acc4obuzJakh7dtDEc=;
        b=lMUaEIEF/K8o7ISuIzD701KA5iJfJ5QQN3kOxf7daHFO90oqdvjU4qDL035s5iaUAD
         HJIO+RQjstGi9TvP3WvYABOU07+/BCQR89mGYmIH7ddA/VTBp/T8VKn2xcp5EdsMrJqg
         HmJmg9meuWINbhZq9L8OXg6SYEMQuUOiDZjlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=raddepcS3XU/VKmJZp7vh07W9acc4obuzJakh7dtDEc=;
        b=VayJlP+Jib+xFGLgNaDXkZaa7lLQHnUe/XWN48czjpFpCKaZ1UoUOqLvQnMbly+t5o
         PjMTlAUEeRMBrD+r/shPH707kMvEWhW1ZEMEKw01GnWTGM3FQMOPRDPnOI+P6tLkfIsN
         ris8MmRWmnGB04+wBrt8qiDPAE/oXGSU+KRwOuuPgI6xkAv6AEATcd60Vo+3I9Ck2MXB
         Gfl4gi5gVML42OsC5AiwkRxkkXxXD3IX7cK5aI82BGpovLFHbYn2DU7IFr+RXv3xF1qt
         wwlIYi9XU1A5aevibSBhhcdvvAzVmJyLyh28cbiAHvu1RgNKNE7OH/ql7BIE+OKBDkdj
         X2Sw==
X-Gm-Message-State: APjAAAVsBTu3sNkT6rhF443u84CjJbWRkLv2cWziJ2lr/YWVrLCHyl01
        cGkdteH3YzazfY6edOlTU87eEQ==
X-Google-Smtp-Source: APXvYqypr/l+jjqzsq81qEK0oqfxAiDdCm613PhZMl4MTaSlBPa6Q24tTOmN+mvg8FpR1scT/s6jDQ==
X-Received: by 2002:aa7:9465:: with SMTP id t5mr6471353pfq.18.1574898001530;
        Wed, 27 Nov 2019 15:40:01 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k13sm17737283pgl.69.2019.11.27.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 15:40:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:39:58 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless: Use offsetof instead of custom macro.
Message-ID: <20191127233957.GA217817@google.com>
References: <20190418075016.252988-1-pihsun@chromium.org>
 <CANMq1KCwcVawg6L1hTKXBgBi66EKdHQrvxr_chR9Kv1ifFREnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KCwcVawg6L1hTKXBgBi66EKdHQrvxr_chR9Kv1ifFREnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

[Top-posting because the important stuff is up here, and the rest is
missing from linux-wireless]

Hey Pi-Hsun, Nicolas: you failed to copy linux-wireless, so no one's
going to pick this patch up. Please re-send if you care.

Regards,
Brian

On Thu, May 02, 2019 at 03:56:33PM +0800, Nicolas Boichat wrote:
> On Thu, Apr 18, 2019 at 3:50 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> >
> > Use offsetof to calculate offset of a field to take advantage of
> > compiler built-in version when possible, and avoid UBSAN warning when
> > compiling with Clang:
> >
> > ==================================================================
> > UBSAN: Undefined behaviour in net/wireless/wext-core.c:525:14
> > member access within null pointer of type 'struct iw_point'
> > CPU: 3 PID: 165 Comm: kworker/u16:3 Tainted: G S      W         4.19.23 #43
> > Workqueue: cfg80211 __cfg80211_scan_done [cfg80211]
> > Call trace:
> >  dump_backtrace+0x0/0x194
> >  show_stack+0x20/0x2c
> >  __dump_stack+0x20/0x28
> >  dump_stack+0x70/0x94
> >  ubsan_epilogue+0x14/0x44
> >  ubsan_type_mismatch_common+0xf4/0xfc
> >  __ubsan_handle_type_mismatch_v1+0x34/0x54
> >  wireless_send_event+0x3cc/0x470
> >  ___cfg80211_scan_done+0x13c/0x220 [cfg80211]
> >  __cfg80211_scan_done+0x28/0x34 [cfg80211]
> >  process_one_work+0x170/0x35c
> >  worker_thread+0x254/0x380
> >  kthread+0x13c/0x158
> >  ret_from_fork+0x10/0x18
> > ===================================================================
> >
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> 
> The warning from clang is spurious, but in another case, we felt that
> the cleanup was worth it, nevertheless
> (https://lore.kernel.org/patchwork/patch/1050040/).
> 
> Reviewed-By: Nicolas Boichat <drinkcat@chromium.org>
> 
> > ---
> >  include/uapi/linux/wireless.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> > index 86eca3208b6b..f259cca5cc2b 100644
> > --- a/include/uapi/linux/wireless.h
> > +++ b/include/uapi/linux/wireless.h
> > @@ -1090,8 +1090,7 @@ struct iw_event {
> >  /* iw_point events are special. First, the payload (extra data) come at
> >   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
> >   * we omit the pointer, so start at an offset. */
> > -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> > -                         (char *) NULL)
> > +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
> >  #define IW_EV_POINT_LEN        (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
> >                          IW_EV_POINT_OFF)
> >
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
