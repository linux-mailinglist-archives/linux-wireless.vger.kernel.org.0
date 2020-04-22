Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5311B4D4C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDVTZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgDVTZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 15:25:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A8C03C1A9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 12:25:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so2300542wrx.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HyHSDUvJGC5QEDwX+dZrsm9q+7nGydLKeebsjWAayTk=;
        b=jhaRY/ybSo4kXzpbPDEOvqyp2HKfTnyjXoH3RihRM+dHhhtDywpIPg+jsmRP4RHFvE
         NVyWnSLLDRRvuNAmFbrAh+E5zfULX5GHTAYVt+0NkG27u99U9BN9lnNKBlnAZeC6/xbj
         KYQRi0Lcb281MuIbomjoKXqOeD47GFpD6c18G0iWlpWoyzH7Lu8FJB3HbfPtIEoZINJd
         DsH7W4Vf/w68M5AylMbxdQzieACNU6Hhx8BxtmeXWuiwbCz+SRU5CCQdzryvcGJ3h+IF
         4TxGLcAYIUr7AEomk0/bvo0uDk1XWS1BqNsLnye2nQVjmkHNhzwe4Y1pgPd2YshzF5kv
         gBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HyHSDUvJGC5QEDwX+dZrsm9q+7nGydLKeebsjWAayTk=;
        b=FlWg9jGiXOZwv5+qVEmfcRe5INFJbmbNuiT46aHot0uaBxkwda0QAPXYDbDl7oDrRX
         +6sXkWp3qHKBwjdpzEx7doBaOBXPyE5f1aYZExYpLVPizzIi5ToGVPvI6OswsbgOJW/7
         CU0F7/Hex446bDTElRMsRb+WlM72y90L7BsDlY2SdqvSqExy/IEh9/6aitDAD17dvNv9
         5hVvIqIgdVI//y/tEBUUrhbpon6RDnmVGpF+FAFy7G5lE/UFfUP+0zQV7VkeQrW8V+7P
         MQat1e9oeVT+wGutS2R5Vew2VzfPNEDPu6FftoLeNIjzkbhV3Yxt42WZbm73u5oitzK3
         MghA==
X-Gm-Message-State: AGi0PubwnzUzeoA1ME+xqQQFhphcnSnzOumHwWHVkaFXnrOoTRrG1pNe
        5gv6ncIh+1wtEfbsKFG7S+VqPD88bwa+yQ==
X-Google-Smtp-Source: APiQypLKaIU64t6Yvebdg07AA649u9JKYkVd9mv9UDI3uMHCk/Sx58iY3mg32uNxjs4qpjZbEVLKgw==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr615409wrv.111.1587583527382;
        Wed, 22 Apr 2020 12:25:27 -0700 (PDT)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id i17sm335226wml.23.2020.04.22.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:25:26 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:25:24 +0200
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
Message-ID: <20200422192524.GA35535@t2b3>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
 <f024b56130f7498a902dceb264a7df36@realtek.com>
 <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kai-Heng,

On Thu, Apr 23, 2020 at 12:48:55AM +0800, Kai-Heng Feng wrote:
> Hi Tobias,
> 
> > On Apr 22, 2020, at 10:21, Tony Chuang <yhchuang@realtek.com> wrote:
> > 
> > Brian Norris <briannorris@chromium.org> :
> >> 
> >> I'm not sure about the first half your problem, but for the
> >> scheduling-while-atomic:
> >> 
> >> On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
> >> <tobias.predel@gmail.com> wrote:
> >>> [28125.482259] BUG: scheduling while atomic:
> >> kworker/u16:0/33416/0x00000002
> >> ...
> >>> [28125.482436] Preemption disabled at:
> >>> [28125.482443] [<0000000000000000>] 0x0
> >> 
> >> ^^ This line is a bit weird -- shouldn't this have a real PC?
> >> 
> >>> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G
> >> W         5.7.0-rc2-next-20200421-1-next-git #1
> >>> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85
> >> Ver. 01.09.01 10/15/2019
> >>> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
> >>> [28125.482481] Call Trace:
> >>> [28125.482495]  dump_stack+0x66/0x90
> >>> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
> >>> [28125.482512]  __schedule+0x686/0x7b0
> >>> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> >>> [28125.482525]  schedule+0x46/0xf0
> >>> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
> >>> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
> >>> [28125.482546]  usleep_range+0x67/0x90
> >>> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
> >>> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
> >>> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
> >>> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
> >>> [28125.482635]  process_one_work+0x1da/0x3d0
> >>> [28125.482643]  worker_thread+0x4a/0x3d0
> >>> [28125.482651]  kthread+0x122/0x160
> >>> [28125.482658]  ? process_one_work+0x3d0/0x3d0
> >>> [28125.482663]  ? kthread_park+0x90/0x90
> >>> [28125.482670]  ret_from_fork+0x1f/0x40
> >> 
> >> This looks like it might be a regression here:
> >> 
> >> commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
> >> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> Date:   Tue Apr 7 15:33:31 2020 +0800
> >> 
> >>    rtw88: Add delay on polling h2c command status bit
> >> 
> >> That poll macros is using usleep, which obviously can sleep. We need
> >> to be using a udelay-variant instead.
> >> 
> > 
> > Maybe we need an atomic version of read_poll_timeout() ?
> > I am not sure if this is required, but seems like it is useful for me.
> > Noticed much of them have its atomic version, but not for this new added one.
> 
> Tony and Brian are right. 
> 
> Tobias, can you please test the following patch:
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> index 245da96dfddc..e44767ec0532 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
>                 goto out;
>         }
>  
> -       ret = read_poll_timeout(rtw_read8, box_state,
> +       ret = read_poll_timeout_atomic(rtw_read8, box_state,
>                                 !((box_state >> box) & 0x1), 100, 3000, false,
>                                 rtwdev, REG_HMETFR);
>  
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index cb20c733b15a..bc89ac625f26 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -57,6 +57,48 @@
>         (cond) ? 0 : -ETIMEDOUT; \
>  })
>  
> +/**
> + * read_poll_timeout_atomic - Periodically poll an address until a condition is
> + *                             met or a timeout occurs
> + * @op: accessor function (takes @addr as its only argument)
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
> + *            be less than ~10us since udelay is used (see
> + *            Documentation/timers/timers-howto.rst).
> + * @timeout_us: Timeout in us, 0 means never timeout
> + * @delay_before_read: if it is true, delay @delay_us before read.
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> + * case, the last read value at @args is stored in @val.
> + *
> + * When available, you'll probably want to use one of the specialized
> + * macros defined below rather than this macro directly.
> + */
> +#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
> +                                       delay_before_read, args...) \
> +({ \
> +       u64 __timeout_us = (timeout_us); \
> +       unsigned long __delay_us = (delay_us); \
> +       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +       if (delay_before_read && __delay_us) \
> +               udelay(__delay_us); \
> +       for (;;) { \
> +               (val) = op(args); \
> +               if (cond) \
> +                       break; \
> +               if (__timeout_us && \
> +                   ktime_compare(ktime_get(), __timeout) > 0) { \
> +                       (val) = op(args); \
> +                       break; \
> +               } \
> +               if (__delay_us) \
> +       } \
> +       (cond) ? 0 : -ETIMEDOUT; \
> +})
> +
>  /**
>   * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
>   * @op: accessor function (takes @addr as its only argument)
> @@ -96,25 +138,7 @@
>   * macros defined below rather than this macro directly.
>   */
>  #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> -({ \
> -       u64 __timeout_us = (timeout_us); \
> -       unsigned long __delay_us = (delay_us); \
> -       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> -       for (;;) { \
> -               (val) = op(addr); \
> -               if (cond) \
> -                       break; \
> -               if (__timeout_us && \
> -                   ktime_compare(ktime_get(), __timeout) > 0) { \
> -                       (val) = op(addr); \
> -                       break; \
> -               } \
> -               if (__delay_us) \
> -                       udelay(__delay_us);     \
> -       } \
> -       (cond) ? 0 : -ETIMEDOUT; \
> -})
> -
> +       read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
>  
>  #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>         readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
> 

thanks for your reply!

I tried to patch it against 

$ git describe --long --tags
next-20200422-0-ga5840f9618a9

with

$ git am < ~/atomic-patch.mbox

but I get

Applying: rtw88: BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
error: corrupt patch at line 66
Patch failed at 0001 rtw88: BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

and

in am mode, then

$ git am --show-current-patch=diff

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 245da96dfddc..e44767ec0532 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
                goto out;
        }

-       ret = read_poll_timeout(rtw_read8, box_state,
+       ret = read_poll_timeout_atomic(rtw_read8, box_state,
                                !((box_state >> box) & 0x1), 100, 3000, false,
                                rtwdev, REG_HMETFR);

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index cb20c733b15a..bc89ac625f26 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -57,6 +57,48 @@
        (cond) ? 0 : -ETIMEDOUT; \
 })

+/**
+ * read_poll_timeout_atomic - Periodically poll an address until a condition is
+ *                             met or a timeout occurs
+ * @op: accessor function (takes @addr as its only argument)
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
+ *            be less than ~10us since udelay is used (see
+ *            Documentation/timers/timers-howto.rst).
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @delay_before_read: if it is true, delay @delay_us before read.
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ */
+#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
+                                       delay_before_read, args...) \
+({ \
+       u64 __timeout_us = (timeout_us); \
+       unsigned long __delay_us = (delay_us); \
+       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+       if (delay_before_read && __delay_us) \
+               udelay(__delay_us); \
+       for (;;) { \
+               (val) = op(args); \
+               if (cond) \
+                       break; \
+               if (__timeout_us && \
+                   ktime_compare(ktime_get(), __timeout) > 0) { \
+                       (val) = op(args); \
+                       break; \
+               } \
+               if (__delay_us) \
+       } \
+       (cond) ? 0 : -ETIMEDOUT; \
+})
+
 /**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
  * @op: accessor function (takes @addr as its only argument)
@@ -96,25 +138,7 @@
  * macros defined below rather than this macro directly.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
-({ \
-       u64 __timeout_us = (timeout_us); \
-       unsigned long __delay_us = (delay_us); \
-       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-       for (;;) { \
-               (val) = op(addr); \
-               if (cond) \
-                       break; \
-               if (__timeout_us && \
-                   ktime_compare(ktime_get(), __timeout) > 0) { \
-                       (val) = op(addr); \
-                       break; \
-               } \
-               if (__delay_us) \
-                       udelay(__delay_us);     \
-       } \
-       (cond) ? 0 : -ETIMEDOUT; \
-})
-
+       read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)

 #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
        readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)


>
> Yen-Hsuan


I'll try to patch manually and send back when there are news.

Kind regards,
Tobias

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
