Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427C21B4EB0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgDVU5h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDVU5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 16:57:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E9C03C1A9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 13:57:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so4177484wml.2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkZguKx2qMhctQ9ndYKOn55L/dBsg8PDGddSLgZYRyY=;
        b=QQCipKwDXXWjr8GwcQQsaU6GhsoC5BNMKoKmBhXwZty9Mh1tZnXnS4sgDmYnBR+2mZ
         69u0VkpPJNvwCaAkj/snKX2+stPQ7hjXkmMMu7PsPun7TNX9CKkTly/nU+2QmiNBMkM3
         qBvHs68MEui9XCNQII5j4s38hJGvyZl1GHN+f6JLaFvTAD8uQeoexZJAbdnDMTZ+/wa9
         GF1ULR7VRM5pKb8qpTFHpxLKPmlqUWpQy0fDaY5AaasC359+KYDQPmbm55YjGSBwlTX1
         aSm0q23Ra3Jee85ci9rb+iXWtELBNOgrgth/I8NFSMCDnXsstYceuPCNYLSTLWMQ1H6U
         882w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkZguKx2qMhctQ9ndYKOn55L/dBsg8PDGddSLgZYRyY=;
        b=D+Jo9PzdvFJdR7KuBsmVhMgq4PflbeJ87vmnQS0uZU063sJm5KBdsipBr4SFzQDsqR
         YjpG9KKfqEA3Qd3sWaE8WXihAtLsjdXNlyWE5OsKNncwsZ13kooZsIZSBj7TwbHg2huh
         EzVcf3JOonuH+Q9mvid54FASZi2C7oehyNDHO4pUcVrN59a2RBTuCWqw1ADq40u0Hzpm
         71+AN0h5KM3V7pyXbwyY1pNS/kwN4KkiG65AypmrvgegMzhA8q7oQzmJWN3mAVR8Ymg3
         vx0G7UHWn3jvcrr0Gtrz/SCnds3q/Crc+0iolaMMs1zzN1DZC3D8URq5rsWFFlAq4ufO
         KeDg==
X-Gm-Message-State: AGi0PuZZEqZZDwjvaOhay5ZegxTgLmt+bwzpfg2JIVRxjWQWR6hRnKnl
        EFG3GZlPpp5tw1IKGiMOqc0=
X-Google-Smtp-Source: APiQypL/42QijXKaPnrdWpARWtMXlkj3n4qcFIOEq/zb4zd6Z1YWSFQRoB6yhnCuIYnkQXPpxpFK5g==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr316242wmd.167.1587589054055;
        Wed, 22 Apr 2020 13:57:34 -0700 (PDT)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id n2sm574058wrq.74.2020.04.22.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:57:33 -0700 (PDT)
Date:   Wed, 22 Apr 2020 22:57:31 +0200
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
Message-ID: <20200422205731.GA409387@t2b3>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
 <f024b56130f7498a902dceb264a7df36@realtek.com>
 <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
 <20200422192524.GA35535@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422192524.GA35535@t2b3>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kai-Heng,

On Wed, Apr 22, 2020 at 09:25:24PM +0200, Tobias S. Predel wrote:
> Hi Kai-Heng,
> 
> On Thu, Apr 23, 2020 at 12:48:55AM +0800, Kai-Heng Feng wrote:
> > Hi Tobias,
> > 
> > > On Apr 22, 2020, at 10:21, Tony Chuang <yhchuang@realtek.com> wrote:
> > > 
> > > Brian Norris <briannorris@chromium.org> :
> > >> 
> > >> I'm not sure about the first half your problem, but for the
> > >> scheduling-while-atomic:
> > >> 
> > >> On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
> > >> <tobias.predel@gmail.com> wrote:
> > >>> [28125.482259] BUG: scheduling while atomic:
> > >> kworker/u16:0/33416/0x00000002
> > >> ...
> > >>> [28125.482436] Preemption disabled at:
> > >>> [28125.482443] [<0000000000000000>] 0x0
> > >> 
> > >> ^^ This line is a bit weird -- shouldn't this have a real PC?
> > >> 
> > >>> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G
> > >> W         5.7.0-rc2-next-20200421-1-next-git #1
> > >>> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85
> > >> Ver. 01.09.01 10/15/2019
> > >>> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
> > >>> [28125.482481] Call Trace:
> > >>> [28125.482495]  dump_stack+0x66/0x90
> > >>> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
> > >>> [28125.482512]  __schedule+0x686/0x7b0
> > >>> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> > >>> [28125.482525]  schedule+0x46/0xf0
> > >>> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
> > >>> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
> > >>> [28125.482546]  usleep_range+0x67/0x90
> > >>> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
> > >>> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
> > >>> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
> > >>> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
> > >>> [28125.482635]  process_one_work+0x1da/0x3d0
> > >>> [28125.482643]  worker_thread+0x4a/0x3d0
> > >>> [28125.482651]  kthread+0x122/0x160
> > >>> [28125.482658]  ? process_one_work+0x3d0/0x3d0
> > >>> [28125.482663]  ? kthread_park+0x90/0x90
> > >>> [28125.482670]  ret_from_fork+0x1f/0x40
> > >> 
> > >> This looks like it might be a regression here:
> > >> 
> > >> commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
> > >> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >> Date:   Tue Apr 7 15:33:31 2020 +0800
> > >> 
> > >>    rtw88: Add delay on polling h2c command status bit
> > >> 
> > >> That poll macros is using usleep, which obviously can sleep. We need
> > >> to be using a udelay-variant instead.
> > >> 
> > > 
> > > Maybe we need an atomic version of read_poll_timeout() ?
> > > I am not sure if this is required, but seems like it is useful for me.
> > > Noticed much of them have its atomic version, but not for this new added one.
> > 
> > Tony and Brian are right. 
> > 
> > Tobias, can you please test the following patch:
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> > index 245da96dfddc..e44767ec0532 100644
> > --- a/drivers/net/wireless/realtek/rtw88/fw.c
> > +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> > @@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
> >                 goto out;
> >         }
> >  
> > -       ret = read_poll_timeout(rtw_read8, box_state,
> > +       ret = read_poll_timeout_atomic(rtw_read8, box_state,
> >                                 !((box_state >> box) & 0x1), 100, 3000, false,
> >                                 rtwdev, REG_HMETFR);
> >  
> > diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> > index cb20c733b15a..bc89ac625f26 100644
> > --- a/include/linux/iopoll.h
> > +++ b/include/linux/iopoll.h
> > @@ -57,6 +57,48 @@
> >         (cond) ? 0 : -ETIMEDOUT; \
> >  })
> >  
> > +/**
> > + * read_poll_timeout_atomic - Periodically poll an address until a condition is
> > + *                             met or a timeout occurs
> > + * @op: accessor function (takes @addr as its only argument)
> > + * @addr: Address to poll
> > + * @val: Variable to read the value into
> > + * @cond: Break condition (usually involving @val)
> > + * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
> > + *            be less than ~10us since udelay is used (see
> > + *            Documentation/timers/timers-howto.rst).
> > + * @timeout_us: Timeout in us, 0 means never timeout
> > + * @delay_before_read: if it is true, delay @delay_us before read.
> > + *
> > + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> > + * case, the last read value at @args is stored in @val.
> > + *
> > + * When available, you'll probably want to use one of the specialized
> > + * macros defined below rather than this macro directly.
> > + */
> > +#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
> > +                                       delay_before_read, args...) \
> > +({ \
> > +       u64 __timeout_us = (timeout_us); \
> > +       unsigned long __delay_us = (delay_us); \
> > +       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > +       if (delay_before_read && __delay_us) \
> > +               udelay(__delay_us); \
> > +       for (;;) { \
> > +               (val) = op(args); \
> > +               if (cond) \
> > +                       break; \
> > +               if (__timeout_us && \
> > +                   ktime_compare(ktime_get(), __timeout) > 0) { \
> > +                       (val) = op(args); \
> > +                       break; \
> > +               } \
> > +               if (__delay_us) \

Isn't there something missing here after __delay_us? 
I got compiler error, misses ;.

> > +       } \
> > +       (cond) ? 0 : -ETIMEDOUT; \
> > +})
> > +
> >  /**
> >   * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
> >   * @op: accessor function (takes @addr as its only argument)
> > @@ -96,25 +138,7 @@
> >   * macros defined below rather than this macro directly.
> >   */
> >  #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> > -({ \
> > -       u64 __timeout_us = (timeout_us); \
> > -       unsigned long __delay_us = (delay_us); \
> > -       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > -       for (;;) { \
> > -               (val) = op(addr); \
> > -               if (cond) \
> > -                       break; \
> > -               if (__timeout_us && \
> > -                   ktime_compare(ktime_get(), __timeout) > 0) { \
> > -                       (val) = op(addr); \
> > -                       break; \
> > -               } \
> > -               if (__delay_us) \
> > -                       udelay(__delay_us);     \
> > -       } \
> > -       (cond) ? 0 : -ETIMEDOUT; \
> > -})
> > -
> > +       read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
> >  
> >  #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> >         readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
> > 
> 

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
