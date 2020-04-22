Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B421B4AD7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVQtE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:49:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVQtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:49:04 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jRIYX-0002di-Cz
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 16:49:01 +0000
Received: by mail-pg1-f200.google.com with SMTP id i21so2169128pgl.19
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n3uKzNavhmA8LWZ9eVBRa7sx4099RYR7kdCp2l5XlVg=;
        b=m0gQ0NCpLlIoLsXNjkwRhIsQ8HfLpHaWPjFAnkU05CNfLw/0ggm2w1oJOWtdT4SvFf
         AZwhW3Tq32Wys4MtSW5NXTGTrdsiFCLRYS4ea/Vu4ADsI6WQtZnusI+LlYx5DZKiws14
         4aTkIszRYqm74vnPUCHcIea42nzxl/8lVJFwni1yOAGrDO2ORwvVwveQ6BFtuWkjOicP
         F2Nu19mFhJWf2jvuig4LEBXwhOMdFiveo54Sv5bsfu/whrG6bNnH13heN1Rl1om8PBYa
         D2ZMTDfvS4cDPNGXhUdpMErc1WJNexBNDYNJTTFzQq4KIo/zqQsuDQIntr8cKbYJP/YN
         bDNw==
X-Gm-Message-State: AGi0PuZUQJY/KBH2YI900Ep5bAfI7M1LI67oZNPK/wkC0BzZDnrr2Vk0
        j3nevsW30wuOiN4QJ2jLG79tv6UXHFHpgZpqUd2YP5XPj+GSjPzLNwGeHorRn/J4g+bmyogGVEt
        zH25fTeUrexsK6dz2gUuj+HzpVdB8CRDrAS14j5OPPCq6
X-Received: by 2002:a63:4c1:: with SMTP id 184mr26648132pge.156.1587574139797;
        Wed, 22 Apr 2020 09:48:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0ITpWieEpRNwKJ0UjmwKw3+JQQHSaJ4rGm/Ts3vSUavz1Nfx9Uy7vFmUsnQvoU7iIRrB5Ng==
X-Received: by 2002:a63:4c1:: with SMTP id 184mr26648100pge.156.1587574139359;
        Wed, 22 Apr 2020 09:48:59 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id v32sm2386367pgn.35.2020.04.22.09.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:48:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <f024b56130f7498a902dceb264a7df36@realtek.com>
Date:   Thu, 23 Apr 2020 00:48:55 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
 <f024b56130f7498a902dceb264a7df36@realtek.com>
To:     "Tobias S. Predel" <tobias.predel@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tobias,

> On Apr 22, 2020, at 10:21, Tony Chuang <yhchuang@realtek.com> wrote:
> 
> Brian Norris <briannorris@chromium.org> :
>> 
>> I'm not sure about the first half your problem, but for the
>> scheduling-while-atomic:
>> 
>> On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
>> <tobias.predel@gmail.com> wrote:
>>> [28125.482259] BUG: scheduling while atomic:
>> kworker/u16:0/33416/0x00000002
>> ...
>>> [28125.482436] Preemption disabled at:
>>> [28125.482443] [<0000000000000000>] 0x0
>> 
>> ^^ This line is a bit weird -- shouldn't this have a real PC?
>> 
>>> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G
>> W         5.7.0-rc2-next-20200421-1-next-git #1
>>> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85
>> Ver. 01.09.01 10/15/2019
>>> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
>>> [28125.482481] Call Trace:
>>> [28125.482495]  dump_stack+0x66/0x90
>>> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
>>> [28125.482512]  __schedule+0x686/0x7b0
>>> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
>>> [28125.482525]  schedule+0x46/0xf0
>>> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
>>> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
>>> [28125.482546]  usleep_range+0x67/0x90
>>> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
>>> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
>>> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
>>> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
>>> [28125.482635]  process_one_work+0x1da/0x3d0
>>> [28125.482643]  worker_thread+0x4a/0x3d0
>>> [28125.482651]  kthread+0x122/0x160
>>> [28125.482658]  ? process_one_work+0x3d0/0x3d0
>>> [28125.482663]  ? kthread_park+0x90/0x90
>>> [28125.482670]  ret_from_fork+0x1f/0x40
>> 
>> This looks like it might be a regression here:
>> 
>> commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
>> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Date:   Tue Apr 7 15:33:31 2020 +0800
>> 
>>    rtw88: Add delay on polling h2c command status bit
>> 
>> That poll macros is using usleep, which obviously can sleep. We need
>> to be using a udelay-variant instead.
>> 
> 
> Maybe we need an atomic version of read_poll_timeout() ?
> I am not sure if this is required, but seems like it is useful for me.
> Noticed much of them have its atomic version, but not for this new added one.

Tony and Brian are right. 

Tobias, can you please test the following patch:

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

