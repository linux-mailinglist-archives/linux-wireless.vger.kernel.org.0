Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267BE1B5090
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDVWzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 18:55:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3100C03C1A9
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 15:55:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so4578688wrv.10
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Nau+RtMSmcVjkCADjVs1rFmIt6Oh7QnU+Ln9WKU2o0=;
        b=qLAh/9VVvZTT9iRq2nE4yVCyNkJ9Yud5F3VOsf9wCseobQY7U6rsoUcnc7QuP+K/Xp
         6OkBNddxTsH18AQzbXdjvd0+hVjDEa6WlZEnpQcKc8Dj01ep29z+/MescI5zWAlkY5pv
         sjOiNOw/cFbotErD8ywnv8YFZo9dCjSadlroatXFITgrTYPe+0CrLPYLK6RusWbbgcTj
         N33//pVexChnpKfTivOv6amkrjLiV0KcsmpRHPqJqlVSn2dd4aF9VinKsmfRDuB8DuNe
         nM5SYYTOQsxWDCxjI2/Ou/iNnZNxh+NJ16z3V0BBDpAiQICKbX2mwoP1dwQRyCHAhcKo
         JfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Nau+RtMSmcVjkCADjVs1rFmIt6Oh7QnU+Ln9WKU2o0=;
        b=eUS+WrG2s3M2K5UdwR8+N39FOT98pM7NGhfuCEXJUJboJijmFkMGzdwkAh71j6Ue0M
         aQGsNogGUzptNe9lVGym6jiujYUxhRBX9eXiYhobhZ/V2SkNRruYB68EsIE+9+kpBOF3
         FzgXS9eXS0hAgJlxkCZF80cCGui6qMcRMKu8D5PO3SEZaDwXqhDxVqGEOjJAqR6cMV7T
         A5TdpHLoutTPXgkUgmR6X/pRToE/oe3e2GBirIEi25V5MQKyMW6Mte6pQlXx5MBI0opt
         +0JlhcTT7jGlnSY47bYipxQ+iCkOw2vPBIxy7gWP5+zi0ozOEiuD2+8nnLn+ETzw1kkE
         Bjuw==
X-Gm-Message-State: AGi0PuZ1LkFPj/r9Z/C5T9ofynAk1pjDC7m79BeC37UFWylmCX/9VEjl
        zWtR76Hinz8znrgSob0AIgPlUJpUgfE=
X-Google-Smtp-Source: APiQypJeam6s1GmOQTZe8lwxN0svgUlRJcCadpuh5dPQOnTN3Ujf6uFJaZkueN6oKg6ll1uNEkhFAA==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr1510115wrr.96.1587596132429;
        Wed, 22 Apr 2020 15:55:32 -0700 (PDT)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id q143sm1081143wme.31.2020.04.22.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 15:55:31 -0700 (PDT)
Date:   Thu, 23 Apr 2020 00:55:26 +0200
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
Message-ID: <20200422225526.GA1605@t2b3>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
 <f024b56130f7498a902dceb264a7df36@realtek.com>
 <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
 <20200422192524.GA35535@t2b3>
 <20200422205731.GA409387@t2b3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20200422205731.GA409387@t2b3>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I guessed from the deleted lines that
udelay(__delay_us) was missing.

So I compiled successfully and will observe how it will work out.
But for the first start on the patched kernel it's working and I will report.

Thanks for your patch! Patch against commit a5840f9618a90ecbe1617f7632482563c0ee307e 
is attached.

Kind regards,
Tobias


diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 245da96dfddc..e44767ec0532 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 		goto out;
 	}
 
-	ret = read_poll_timeout(rtw_read8, box_state,
+	ret = read_poll_timeout_atomic(rtw_read8, box_state,
 				!((box_state >> box) & 0x1), 100, 3000, false,
 				rtwdev, REG_HMETFR);
 
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index cb20c733b15a..e4462712b541 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -57,6 +57,49 @@
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
+				delay_before_read, args...) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __delay_us = (delay_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	if (delay_before_read && __delay_us) \
+		udelay(__delay_us); \
+	for (;;) { \
+		(val) = op(args); \
+		if (cond) \
+			break; \
+		if (__timeout_us && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = op(args); \
+			 break; \
+		 } \
+		 if (__delay_us) \
+			udelay(__delay_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+
 /**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
  * @op: accessor function (takes @addr as its only argument)
@@ -96,25 +139,7 @@
  * macros defined below rather than this macro directly.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
-({ \
-	u64 __timeout_us = (timeout_us); \
-	unsigned long __delay_us = (delay_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	for (;;) { \
-		(val) = op(addr); \
-		if (cond) \
-			break; \
-		if (__timeout_us && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = op(addr); \
-			break; \
-		} \
-		if (__delay_us) \
-			udelay(__delay_us);	\
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
-
+	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
 
 #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)


On Wed, Apr 22, 2020 at 10:57:31PM +0200, Tobias S. Predel wrote:
> Hi Kai-Heng,
> 
> On Wed, Apr 22, 2020 at 09:25:24PM +0200, Tobias S. Predel wrote:
> > Hi Kai-Heng,
> > 
> > On Thu, Apr 23, 2020 at 12:48:55AM +0800, Kai-Heng Feng wrote:
> > > Hi Tobias,
> > > 
> > > > On Apr 22, 2020, at 10:21, Tony Chuang <yhchuang@realtek.com> wrote:
> > > > 
> > > > Brian Norris <briannorris@chromium.org> :
> > > >> 
> > > >> I'm not sure about the first half your problem, but for the
> > > >> scheduling-while-atomic:
> > > >> 
> > > >> On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
> > > >> <tobias.predel@gmail.com> wrote:
> > > >>> [28125.482259] BUG: scheduling while atomic:
> > > >> kworker/u16:0/33416/0x00000002
> > > >> ...
> > > >>> [28125.482436] Preemption disabled at:
> > > >>> [28125.482443] [<0000000000000000>] 0x0
> > > >> 
> > > >> ^^ This line is a bit weird -- shouldn't this have a real PC?
> > > >> 
> > > >>> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G
> > > >> W         5.7.0-rc2-next-20200421-1-next-git #1
> > > >>> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85
> > > >> Ver. 01.09.01 10/15/2019
> > > >>> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
> > > >>> [28125.482481] Call Trace:
> > > >>> [28125.482495]  dump_stack+0x66/0x90
> > > >>> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
> > > >>> [28125.482512]  __schedule+0x686/0x7b0
> > > >>> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> > > >>> [28125.482525]  schedule+0x46/0xf0
> > > >>> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
> > > >>> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
> > > >>> [28125.482546]  usleep_range+0x67/0x90
> > > >>> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
> > > >>> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
> > > >>> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
> > > >>> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
> > > >>> [28125.482635]  process_one_work+0x1da/0x3d0
> > > >>> [28125.482643]  worker_thread+0x4a/0x3d0
> > > >>> [28125.482651]  kthread+0x122/0x160
> > > >>> [28125.482658]  ? process_one_work+0x3d0/0x3d0
> > > >>> [28125.482663]  ? kthread_park+0x90/0x90
> > > >>> [28125.482670]  ret_from_fork+0x1f/0x40
> > > >> 
> > > >> This looks like it might be a regression here:
> > > >> 
> > > >> commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
> > > >> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > >> Date:   Tue Apr 7 15:33:31 2020 +0800
> > > >> 
> > > >>    rtw88: Add delay on polling h2c command status bit
> > > >> 
> > > >> That poll macros is using usleep, which obviously can sleep. We need
> > > >> to be using a udelay-variant instead.
> > > >> 
> > > > 
> > > > Maybe we need an atomic version of read_poll_timeout() ?
> > > > I am not sure if this is required, but seems like it is useful for me.
> > > > Noticed much of them have its atomic version, but not for this new added one.
> > > 
> > > Tony and Brian are right. 
> > > 
> > > Tobias, can you please test the following patch:
> > > 
> > > diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> > > index 245da96dfddc..e44767ec0532 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/fw.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> > > @@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
> > >                 goto out;
> > >         }
> > >  
> > > -       ret = read_poll_timeout(rtw_read8, box_state,
> > > +       ret = read_poll_timeout_atomic(rtw_read8, box_state,
> > >                                 !((box_state >> box) & 0x1), 100, 3000, false,
> > >                                 rtwdev, REG_HMETFR);
> > >  
> > > diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> > > index cb20c733b15a..bc89ac625f26 100644
> > > --- a/include/linux/iopoll.h
> > > +++ b/include/linux/iopoll.h
> > > @@ -57,6 +57,48 @@
> > >         (cond) ? 0 : -ETIMEDOUT; \
> > >  })
> > >  
> > > +/**
> > > + * read_poll_timeout_atomic - Periodically poll an address until a condition is
> > > + *                             met or a timeout occurs
> > > + * @op: accessor function (takes @addr as its only argument)
> > > + * @addr: Address to poll
> > > + * @val: Variable to read the value into
> > > + * @cond: Break condition (usually involving @val)
> > > + * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
> > > + *            be less than ~10us since udelay is used (see
> > > + *            Documentation/timers/timers-howto.rst).
> > > + * @timeout_us: Timeout in us, 0 means never timeout
> > > + * @delay_before_read: if it is true, delay @delay_us before read.
> > > + *
> > > + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> > > + * case, the last read value at @args is stored in @val.
> > > + *
> > > + * When available, you'll probably want to use one of the specialized
> > > + * macros defined below rather than this macro directly.
> > > + */
> > > +#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
> > > +                                       delay_before_read, args...) \
> > > +({ \
> > > +       u64 __timeout_us = (timeout_us); \
> > > +       unsigned long __delay_us = (delay_us); \
> > > +       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > > +       if (delay_before_read && __delay_us) \
> > > +               udelay(__delay_us); \
> > > +       for (;;) { \
> > > +               (val) = op(args); \
> > > +               if (cond) \
> > > +                       break; \
> > > +               if (__timeout_us && \
> > > +                   ktime_compare(ktime_get(), __timeout) > 0) { \
> > > +                       (val) = op(args); \
> > > +                       break; \
> > > +               } \
> > > +               if (__delay_us) \
> 
> Isn't there something missing here after __delay_us? 
> I got compiler error, misses ;.
> 
> > > +       } \
> > > +       (cond) ? 0 : -ETIMEDOUT; \
> > > +})
> > > +
> > >  /**
> > >   * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
> > >   * @op: accessor function (takes @addr as its only argument)
> > > @@ -96,25 +138,7 @@
> > >   * macros defined below rather than this macro directly.
> > >   */
> > >  #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> > > -({ \
> > > -       u64 __timeout_us = (timeout_us); \
> > > -       unsigned long __delay_us = (delay_us); \
> > > -       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> > > -       for (;;) { \
> > > -               (val) = op(addr); \
> > > -               if (cond) \
> > > -                       break; \
> > > -               if (__timeout_us && \
> > > -                   ktime_compare(ktime_get(), __timeout) > 0) { \
> > > -                       (val) = op(addr); \
> > > -                       break; \
> > > -               } \
> > > -               if (__delay_us) \
> > > -                       udelay(__delay_us);     \
> > > -       } \
> > > -       (cond) ? 0 : -ETIMEDOUT; \
> > > -})
> > > -
> > > +       read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
> > >  
> > >  #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > >         readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
> > > 
> > 
> 
> -- 
> Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.

-- 
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-rtw88-Make-read_poll_timeout-atomic.patch"

From 2652ea8d9120b67c79dc85a9073cc5e85d6fc2dc Mon Sep 17 00:00:00 2001
From: Tobias Predel <tobias.predel@gmail.com>
Date: Thu, 23 Apr 2020 00:44:15 +0200
Subject: [PATCH] rtw88: Make read_poll_timeout atomic

---
 drivers/net/wireless/realtek/rtw88/fw.c |  2 +-
 include/linux/iopoll.h                  | 63 +++++++++++++++++--------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 245da96dfddc..e44767ec0532 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 		goto out;
 	}
 
-	ret = read_poll_timeout(rtw_read8, box_state,
+	ret = read_poll_timeout_atomic(rtw_read8, box_state,
 				!((box_state >> box) & 0x1), 100, 3000, false,
 				rtwdev, REG_HMETFR);
 
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index cb20c733b15a..e4462712b541 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -57,6 +57,49 @@
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
+				delay_before_read, args...) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __delay_us = (delay_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	if (delay_before_read && __delay_us) \
+		udelay(__delay_us); \
+	for (;;) { \
+		(val) = op(args); \
+		if (cond) \
+			break; \
+		if (__timeout_us && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			(val) = op(args); \
+			 break; \
+		 } \
+		 if (__delay_us) \
+			udelay(__delay_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+
 /**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
  * @op: accessor function (takes @addr as its only argument)
@@ -96,25 +139,7 @@
  * macros defined below rather than this macro directly.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
-({ \
-	u64 __timeout_us = (timeout_us); \
-	unsigned long __delay_us = (delay_us); \
-	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
-	for (;;) { \
-		(val) = op(addr); \
-		if (cond) \
-			break; \
-		if (__timeout_us && \
-		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = op(addr); \
-			break; \
-		} \
-		if (__delay_us) \
-			udelay(__delay_us);	\
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
-
+	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
 
 #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
-- 
2.26.2


--huq684BweRXVnRxX--
