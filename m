Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910611B5450
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDWFnQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 01:43:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWFnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 01:43:15 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jRUdj-0004pD-Hz
        for linux-wireless@vger.kernel.org; Thu, 23 Apr 2020 05:43:11 +0000
Received: by mail-pg1-f197.google.com with SMTP id j16so3822354pgg.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 22:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ESaxmGd7fPiu+688kSbCEw4tfbbskuMrw/7qsz+XCCU=;
        b=tWA2YBWdNu3vDMJ5j9WHIGzXuYNoVwnRjofOnn/hBDxE6HGD0GWOL3pPpfZKYGnazf
         AMiCBBnKaplF/Y9O5fWvZGCIeuqTWU+HIiWOC0jybf3wjGb1Wk73JAzXrBBWaSdufGZL
         WFjqaDm7ZXlRg1HhRY50GkfKz0ml8qLe0oLroPKVIGk+7LegbViKcTl23oCPG/wBdJkw
         x0q6NOD6LD1K2XdEse5LyXs4MjLygl8Gp5SnUaYd8mPUCA5zuUA8B6UqqdV/DdzY0wuY
         Ub8Jf+4b4owJK2dxkt6UOffWggEBzL00KzaUf/oY0j3ioMq3bE+VTlf0p9M+8y+0dcV5
         PXZQ==
X-Gm-Message-State: AGi0Pua6IWbF27xxbbAVD/0wvt0s4Tv4to2WIuBsvfDStDwFNQMd9sqB
        vuy5o1bUhlgF5vRAxMTBkxIhWqhhKEWUJcihzU9P0mRBJmTGlw2k+brDht+vp7fw6s6hzVdm5p6
        FItw1hZXvxos/xWCsEXEsvYdCKSTNu7fc0e9Sih9GnFF+
X-Received: by 2002:a63:f503:: with SMTP id w3mr2316500pgh.397.1587620589535;
        Wed, 22 Apr 2020 22:43:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypLul4T1+9T105EjhIho8LLcuPIkPImK6RHB6zVWHc0IsHbrtmgM4PUetpueuYo+mjljuocpKQ==
X-Received: by 2002:a63:f503:: with SMTP id w3mr2316483pgh.397.1587620589057;
        Wed, 22 Apr 2020 22:43:09 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id n17sm1350849pff.81.2020.04.22.22.43.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 22:43:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rtw88: BUG: scheduling while atomic:
 kworker/u16:0/33416/0x00000002
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200422225526.GA1605@t2b3>
Date:   Thu, 23 Apr 2020 13:43:05 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <110E6169-2516-446D-A3F4-FCD70783FB9E@canonical.com>
References: <20200421211552.GA36171@t2b3>
 <CA+ASDXN==qo2T6g5YCWpUFPXAdFgcKgww5EbmsmUTvsrSSRHug@mail.gmail.com>
 <f024b56130f7498a902dceb264a7df36@realtek.com>
 <EC470640-5835-4E4C-B0BA-BCFF3758FA0B@canonical.com>
 <20200422192524.GA35535@t2b3> <20200422205731.GA409387@t2b3>
 <20200422225526.GA1605@t2b3>
To:     "Tobias S. Predel" <tobias.predel@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> On Apr 23, 2020, at 06:55, Tobias S. Predel <tobias.predel@gmail.com> wrote:
> 
> Hello,
> 
> I guessed from the deleted lines that
> udelay(__delay_us) was missing.

Yea I fail to copy that line :(

> 
> So I compiled successfully and will observe how it will work out.
> But for the first start on the patched kernel it's working and I will report.

Thanks. I'll send the patch.

Kai-Heng

> 
> Thanks for your patch! Patch against commit a5840f9618a90ecbe1617f7632482563c0ee307e 
> is attached.
> 
> Kind regards,
> Tobias
> 
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> index 245da96dfddc..e44767ec0532 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
> 		goto out;
> 	}
> 
> -	ret = read_poll_timeout(rtw_read8, box_state,
> +	ret = read_poll_timeout_atomic(rtw_read8, box_state,
> 				!((box_state >> box) & 0x1), 100, 3000, false,
> 				rtwdev, REG_HMETFR);
> 
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index cb20c733b15a..e4462712b541 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -57,6 +57,49 @@
> 	(cond) ? 0 : -ETIMEDOUT; \
> })
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
> +				delay_before_read, args...) \
> +({ \
> +	u64 __timeout_us = (timeout_us); \
> +	unsigned long __delay_us = (delay_us); \
> +	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +	if (delay_before_read && __delay_us) \
> +		udelay(__delay_us); \
> +	for (;;) { \
> +		(val) = op(args); \
> +		if (cond) \
> +			break; \
> +		if (__timeout_us && \
> +		    ktime_compare(ktime_get(), __timeout) > 0) { \
> +			(val) = op(args); \
> +			 break; \
> +		 } \
> +		 if (__delay_us) \
> +			udelay(__delay_us); \
> +	} \
> +	(cond) ? 0 : -ETIMEDOUT; \
> +})
> +
> +
> /**
>  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
>  * @op: accessor function (takes @addr as its only argument)
> @@ -96,25 +139,7 @@
>  * macros defined below rather than this macro directly.
>  */
> #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
> -({ \
> -	u64 __timeout_us = (timeout_us); \
> -	unsigned long __delay_us = (delay_us); \
> -	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> -	for (;;) { \
> -		(val) = op(addr); \
> -		if (cond) \
> -			break; \
> -		if (__timeout_us && \
> -		    ktime_compare(ktime_get(), __timeout) > 0) { \
> -			(val) = op(addr); \
> -			break; \
> -		} \
> -		if (__delay_us) \
> -			udelay(__delay_us);	\
> -	} \
> -	(cond) ? 0 : -ETIMEDOUT; \
> -})
> -
> +	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
> 
> #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> 	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
> 
> 
> On Wed, Apr 22, 2020 at 10:57:31PM +0200, Tobias S. Predel wrote:
>> Hi Kai-Heng,
>> 
>> On Wed, Apr 22, 2020 at 09:25:24PM +0200, Tobias S. Predel wrote:
>>> Hi Kai-Heng,
>>> 
>>> On Thu, Apr 23, 2020 at 12:48:55AM +0800, Kai-Heng Feng wrote:
>>>> Hi Tobias,
>>>> 
>>>>> On Apr 22, 2020, at 10:21, Tony Chuang <yhchuang@realtek.com> wrote:
>>>>> 
>>>>> Brian Norris <briannorris@chromium.org> :
>>>>>> 
>>>>>> I'm not sure about the first half your problem, but for the
>>>>>> scheduling-while-atomic:
>>>>>> 
>>>>>> On Tue, Apr 21, 2020 at 2:16 PM Tobias S. Predel
>>>>>> <tobias.predel@gmail.com> wrote:
>>>>>>> [28125.482259] BUG: scheduling while atomic:
>>>>>> kworker/u16:0/33416/0x00000002
>>>>>> ...
>>>>>>> [28125.482436] Preemption disabled at:
>>>>>>> [28125.482443] [<0000000000000000>] 0x0
>>>>>> 
>>>>>> ^^ This line is a bit weird -- shouldn't this have a real PC?
>>>>>> 
>>>>>>> [28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G
>>>>>> W         5.7.0-rc2-next-20200421-1-next-git #1
>>>>>>> [28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85
>>>>>> Ver. 01.09.01 10/15/2019
>>>>>>> [28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
>>>>>>> [28125.482481] Call Trace:
>>>>>>> [28125.482495]  dump_stack+0x66/0x90
>>>>>>> [28125.482505]  __schedule_bug.cold+0x8e/0x9b
>>>>>>> [28125.482512]  __schedule+0x686/0x7b0
>>>>>>> [28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
>>>>>>> [28125.482525]  schedule+0x46/0xf0
>>>>>>> [28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
>>>>>>> [28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
>>>>>>> [28125.482546]  usleep_range+0x67/0x90
>>>>>>> [28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
>>>>>>> [28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
>>>>>>> [28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
>>>>>>> [28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
>>>>>>> [28125.482635]  process_one_work+0x1da/0x3d0
>>>>>>> [28125.482643]  worker_thread+0x4a/0x3d0
>>>>>>> [28125.482651]  kthread+0x122/0x160
>>>>>>> [28125.482658]  ? process_one_work+0x3d0/0x3d0
>>>>>>> [28125.482663]  ? kthread_park+0x90/0x90
>>>>>>> [28125.482670]  ret_from_fork+0x1f/0x40
>>>>>> 
>>>>>> This looks like it might be a regression here:
>>>>>> 
>>>>>> commit 6343a6d4b2130be9323f347d60af8a7ba8f7242c
>>>>>> Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>> Date:   Tue Apr 7 15:33:31 2020 +0800
>>>>>> 
>>>>>>   rtw88: Add delay on polling h2c command status bit
>>>>>> 
>>>>>> That poll macros is using usleep, which obviously can sleep. We need
>>>>>> to be using a udelay-variant instead.
>>>>>> 
>>>>> 
>>>>> Maybe we need an atomic version of read_poll_timeout() ?
>>>>> I am not sure if this is required, but seems like it is useful for me.
>>>>> Noticed much of them have its atomic version, but not for this new added one.
>>>> 
>>>> Tony and Brian are right. 
>>>> 
>>>> Tobias, can you please test the following patch:
>>>> 
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> index 245da96dfddc..e44767ec0532 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> @@ -228,7 +228,7 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
>>>>                goto out;
>>>>        }
>>>> 
>>>> -       ret = read_poll_timeout(rtw_read8, box_state,
>>>> +       ret = read_poll_timeout_atomic(rtw_read8, box_state,
>>>>                                !((box_state >> box) & 0x1), 100, 3000, false,
>>>>                                rtwdev, REG_HMETFR);
>>>> 
>>>> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
>>>> index cb20c733b15a..bc89ac625f26 100644
>>>> --- a/include/linux/iopoll.h
>>>> +++ b/include/linux/iopoll.h
>>>> @@ -57,6 +57,48 @@
>>>>        (cond) ? 0 : -ETIMEDOUT; \
>>>> })
>>>> 
>>>> +/**
>>>> + * read_poll_timeout_atomic - Periodically poll an address until a condition is
>>>> + *                             met or a timeout occurs
>>>> + * @op: accessor function (takes @addr as its only argument)
>>>> + * @addr: Address to poll
>>>> + * @val: Variable to read the value into
>>>> + * @cond: Break condition (usually involving @val)
>>>> + * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
>>>> + *            be less than ~10us since udelay is used (see
>>>> + *            Documentation/timers/timers-howto.rst).
>>>> + * @timeout_us: Timeout in us, 0 means never timeout
>>>> + * @delay_before_read: if it is true, delay @delay_us before read.
>>>> + *
>>>> + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
>>>> + * case, the last read value at @args is stored in @val.
>>>> + *
>>>> + * When available, you'll probably want to use one of the specialized
>>>> + * macros defined below rather than this macro directly.
>>>> + */
>>>> +#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
>>>> +                                       delay_before_read, args...) \
>>>> +({ \
>>>> +       u64 __timeout_us = (timeout_us); \
>>>> +       unsigned long __delay_us = (delay_us); \
>>>> +       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
>>>> +       if (delay_before_read && __delay_us) \
>>>> +               udelay(__delay_us); \
>>>> +       for (;;) { \
>>>> +               (val) = op(args); \
>>>> +               if (cond) \
>>>> +                       break; \
>>>> +               if (__timeout_us && \
>>>> +                   ktime_compare(ktime_get(), __timeout) > 0) { \
>>>> +                       (val) = op(args); \
>>>> +                       break; \
>>>> +               } \
>>>> +               if (__delay_us) \
>> 
>> Isn't there something missing here after __delay_us? 
>> I got compiler error, misses ;.
>> 
>>>> +       } \
>>>> +       (cond) ? 0 : -ETIMEDOUT; \
>>>> +})
>>>> +
>>>> /**
>>>>  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
>>>>  * @op: accessor function (takes @addr as its only argument)
>>>> @@ -96,25 +138,7 @@
>>>>  * macros defined below rather than this macro directly.
>>>>  */
>>>> #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
>>>> -({ \
>>>> -       u64 __timeout_us = (timeout_us); \
>>>> -       unsigned long __delay_us = (delay_us); \
>>>> -       ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
>>>> -       for (;;) { \
>>>> -               (val) = op(addr); \
>>>> -               if (cond) \
>>>> -                       break; \
>>>> -               if (__timeout_us && \
>>>> -                   ktime_compare(ktime_get(), __timeout) > 0) { \
>>>> -                       (val) = op(addr); \
>>>> -                       break; \
>>>> -               } \
>>>> -               if (__delay_us) \
>>>> -                       udelay(__delay_us);     \
>>>> -       } \
>>>> -       (cond) ? 0 : -ETIMEDOUT; \
>>>> -})
>>>> -
>>>> +       read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
>>>> 
>>>> #define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>>>>        readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
>>>> 
>>> 
>> 
>> -- 
>> Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
> 
> -- 
> Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
> <0001-rtw88-Make-read_poll_timeout-atomic.patch>

