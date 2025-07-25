Return-Path: <linux-wireless+bounces-26025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FBB124CC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DE85A113D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE024EAB1;
	Fri, 25 Jul 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAxfSDnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9184624DFF3
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472327; cv=none; b=msFq+GzcLjvFQfwB62h2LmZ4PH6a308I4kejfkoCSoDptDOWwY3sLwA2uk66zX3BFh/DNzVEtvg9emQ2/ezdvjRnDR4eJDiWHiiIa4E+37x1kt6HpQjtX7IaToZim9HujMdU7lks7wT6lZQQwAEiwU+3osKo3/MgDy37t8XzEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472327; c=relaxed/simple;
	bh=RW0k82FWaN66w48hHqCoCFb0cqkm+Wk1ZZIoCZ4EN54=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cQmnukrH0egSgNiWVOfZYxu3OcoPRvovsAoCpERwVgMcP6zRLzjokzW3QC18OZ77lIJK9aK/tLuYNnSM3Ok8HU/ulMGxVSlThPxmp28kb0C7PgBPvt1bEsd9dp9av1OsaYxINrlI2ooOZNLqck2zPiNacBfL8XIiYlUU8VlnRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAxfSDnN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753472324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8jZ2FtMapKFlfB2QCDPsmHYJKzRLnhgnwQRJqiPyL0=;
	b=OAxfSDnNHayvtmHwq5F9h4aGd5GRBh8DZiGe2g8L0DVnXbsSeBmIk7fib6gLH2JJGttJRl
	GsDd8O6XqGqUL7pU6ZdX+8cEl46/z9zmnP4QUMoiXYaRCiuKa0a3otklIItFCVhBZf0X9d
	FeC3zdKPcv4H55QGrUD807u2MlUWRuc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-kdfGKaZiNy-fcfgRGDt7Pg-1; Fri, 25 Jul 2025 15:38:41 -0400
X-MC-Unique: kdfGKaZiNy-fcfgRGDt7Pg-1
X-Mimecast-MFC-AGG-ID: kdfGKaZiNy-fcfgRGDt7Pg_1753472321
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7071f67a934so11728466d6.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 12:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753472321; x=1754077121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8jZ2FtMapKFlfB2QCDPsmHYJKzRLnhgnwQRJqiPyL0=;
        b=CX7JX73G70mdyviqYsmRFJpfqMCLV7KezqukcZcDx5EUXxnOv8tmKnx2wNF8bp4DWs
         r2yup9PYYA5tK1dqLtP6FdjrzTIkjIIFAiz1HcRbmVxjRat6oxwCmxCM7jzVfO8T8/JH
         MCKB8qrHI4VPDD8dcwATkabsbSM7s1oydrph9Rra1woWym+AyVPf7Vpg8ph0zFzq5r+I
         lYoQJ730gutInNT2fy5o08QKe58KZbuasfl2ou7wLQRS5CPyLX1vwXlSYftuRz4CECS6
         4qwUPoHzkCBSMIYmlowPu44hmXSXwQeXvi7Yv1VzdLs3KDMXw6+aCZg81PuQtA627FVM
         +Dbw==
X-Forwarded-Encrypted: i=1; AJvYcCXPpvOK1yaAgE8hx6+IiDKqBOgpKWQ9onG3KcFEX5P+Ms6acTGO7aUbM9bCldyKpsSzC/VsiFB12Tgj0ZL/hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TKeB7OQu0MjiiwridLidpORQUbsMXhaRCowh+70/fUqPZhJS
	5GpXSmIb4erQxbwkLYTUyXcARsllelZVYEmndsJR+2AvkzR/H+/k+//4GYoap9/z3NLrA84LFZf
	CR9BFz4EK6E0DCq6RcK3bJk5taoFvHknhoaHptOYIYakY3U5j3UVl3vTS0PFD9w8MgViN
X-Gm-Gg: ASbGncsOuG2q5Ss4ftUmRDs35Kp3fAvkpANAI8Ak5TjfKCv5IQHeTbZ2utwgGYm+DYB
	7yzLusCx4FAG+ez38GWGx7oQUEt4sSWdcEoW3Q8gZA04FKRnr1mjrCJftI820nFl6Nui2jOsGm+
	VQ53DvnSmSwCkrbugmqnOqGxhd++fxpYU1Seni2EY/CmNLaVZ7Rtzont4mxd3vsFCgcIzEDjLDz
	zDnKPtksgKFmS9h3PN/GQQ7aCxpZHA2SaBkH0uINFwyQFjOo7ruK73Hi9Z6M/WJPuJhomRiB8zH
	M6DJbRSdHkuAO4wDwKb/OCEitXw0kI3GxUTEz7zs91L+i0nHGiafr/WGjkLkmf7D7fR+gzo24WD
	pjfNgybq6iw==
X-Received: by 2002:a05:6214:ccc:b0:704:9b27:1161 with SMTP id 6a1803df08f44-707205c3cd3mr49776136d6.40.1753472321258;
        Fri, 25 Jul 2025 12:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7xuWEXOSCH/T41cv96g7IcqnoTbp4n25zJN0OOBNxKF1Ug9NWq88qiGpSh7Zmzhxivjw1nA==
X-Received: by 2002:a05:6214:ccc:b0:704:9b27:1161 with SMTP id 6a1803df08f44-707205c3cd3mr49775616d6.40.1753472320798;
        Fri, 25 Jul 2025 12:38:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff109sm3812486d6.10.2025.07.25.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 12:38:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c13616d1-b11e-460a-8eda-5aa72c9123d8@redhat.com>
Date: Fri, 25 Jul 2025 15:38:38 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 John Ogness <jogness@linutronix.de>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <848qkdtlsl.fsf@jogness.linutronix.de>
 <6a27ffeb-a79b-4623-9ad3-392973a1fcce@redhat.com> <87y0scpepu.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87y0scpepu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/25/25 9:44 AM, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 20:16, Waiman Long wrote:
>> On 7/24/25 3:45 PM, John Ogness wrote:
>> I am sorry for confusing conole_owner_lock with the console_owner
>> lockdep map. Yes, this lockdep splat should be a false positive. You do
>> need to put the mutex_acquire before printk_safe_exit_irqrestore() to
>> avoid this splat.
> No. The printk code is absolutely correct as it is.
>
> Did you actually read my analysis?
I have read your analysis and I believe in your conclusion.
>
> The lockdep splat is triggered by the raw_spin_unlock_irq() in
> __flush_work() as it makes console_owner unsafe.
>
> Again:
>
>    printk()
>      local_irq_save()
>        acquire(console_owner);
>        con->write()
>          vt_console_print()
>            hide_cursor()
>              vc->vc_sw->con_cursor()
>                fbcon_cursor()
>                  fbcon_del_cursor_work()
>                    cancel_delayed_work_sync()
>                      __flush_work()
>                        raw_spin_unlock_irq()          <- FAIL
>
> The initial report from
>
> cancel_delayed_work_sync() _CANNOT_ be invoked from atomic contexts,
> unless the work is marked as BH work. And for BH work it cannot be
> called from hard interrupt context for obvious reasons.
>
> Marking that cursor work BH is not helping either, as printk() can be
> invoked from everywhere.
>
> There is no way to legitimately invoke cancel_delayed_work_sync() from
> the legacy console write() callback ever.
>
> No?

I am not disputing this.

Thanks,
Longman


