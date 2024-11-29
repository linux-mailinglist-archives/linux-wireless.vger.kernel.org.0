Return-Path: <linux-wireless+bounces-15499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C79D21F0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F13B2366F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971BB1C0DCB;
	Tue, 19 Nov 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwX88J07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A21AF0AC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006380; cv=none; b=slWfV3fbnYEqt3eCRpIRrtYWuLjVk2LDWyUQOF80JEYNYCHQ+LLUowQOp4CjSFFBy0rzsSZA8j3I0yRtJBz7WBBbfDlGCxavpPQl+5pVpZvckK1hIhAytmTQkTtJMRvukNRStygtze6irybgJxZexxyEiLwvMokaOdqdtM8bcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006380; c=relaxed/simple;
	bh=1PQE1f1xCJGY7Tky1gUdhI5mXqSifmAXMo1KKarsrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBKoLwSXUeABlEvsnq5T1QGrWkIr1QaGBFKwmjJmrTatxym6RkEm+nVfH8eRU7zeqi+Esn53n9yIuihXk7EJNlrUOsj7ZcL1KYo3UG9CBvqwa/bW9BsxG3s+qwEdqKJKUHqgD6YEUjvWyqElWnFXWzX7LlQv3ky41NDkC1ozGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwX88J07; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d866f70fso5658835e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732006375; x=1732611175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qaBG3Z7R9DOuiOybc185RSD4M8rIPEBBhrkZgjFmOxU=;
        b=YwX88J07/QkBNEkAjW82kPZVlFUMTCMLsjf6gwhsceK2l+pfQq+2IhMEYkPxcbHwhM
         iIQcYiE8dfVaomj+NhbmG33a7kOfZvnjheNotc1ehgHzsh9k5KiMvqplMIWd1Ktpn9J3
         Jl0NwUBhIo15kB0LHJKNp3KvnQt5IzMLrmOUt5OqKtW5fSa8heyxjOg/WBK+TsNjc4QK
         7m994E+mkEwkTIETkvQ3HV9EOmS6rF7kT/r6PvKAWOsvp3P9FDmpG8UYYfYu5j2pKTin
         nV23yVqo7cve/XHz6GfmTRniT88Dp7udY5CmrOUKjj10LxJKyDd7AoBmqCML/ASfnVOk
         i85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732006375; x=1732611175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaBG3Z7R9DOuiOybc185RSD4M8rIPEBBhrkZgjFmOxU=;
        b=gey/SkWBQ9e0icLgJkTzdeP+5RUWpQVckUY63fCziDv68pD+B+czrUAibnKTMXUW+h
         ySijvtq/nx4PGixp71BYSsmcrXMkYWzA9+MDCs0h4xq9zV5/rS38/gbT9UU24rE8WKPG
         QX2vbpkJ2mNe6N+QrkCq1Rk+Z6uYFsep0wIR0xzNa5r3MKZqx/Hq1sx2RDMatHBBfvIU
         /uy8C73Gldw9jJcx9aT7+/ojktFEmomC5GvqLFH3pFpe+q/vK7gZyrqntiU1JmqfPFip
         v4ySBr52JD3fNJrfi41fxabcZtqRQc2cW3u2m6qIYanMmnJ1rUozRcJX58z4zcjEcXM+
         JOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXco245olBqqKbklSQKG/ddhHYDDGFEncHT5n7If4pVNNH41NNEknJMopkzhsRTz8ywaKLZ3sAtyniHX/cbfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuM9mn8Ql0qkfpZvY+YhDOIWqytjhnC+vf9vyaH8aiIU0fXbAs
	8kA1OapZuY8pSGUMVNs39XCwA0na4MraUZZbOl/uVd9cl/Wxvvf+FB0lRvS36DI=
X-Google-Smtp-Source: AGHT+IHrqP9nC2rPwknktgIKbjWoIt1yh0m5e2N0IUvcTBAuP3H8V/AdHOWp2OIw94YWQU//ijQi/A==
X-Received: by 2002:a5d:6d0f:0:b0:382:2492:3218 with SMTP id ffacd0b85a97d-38225aaee39mr12773115f8f.47.1732006374705;
        Tue, 19 Nov 2024 00:52:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824a8109a7sm3705943f8f.104.2024.11.19.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:52:54 -0800 (PST)
Date: Tue, 19 Nov 2024 09:52:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Louis Peens <louis.peens@corigine.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org,
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org,
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH v2 19/21] livepatch: Convert timeouts to secs_to_jiffies()
Message-ID: <ZzxR3uAcWFEPUIUK@pathway.suse.cz>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
 <718febc4-59ee-4701-ad62-8b7a8fa7a910@csgroup.eu>
 <Zzsfuuv3AVomkMxn@pathway.suse.cz>
 <96f3b51b-c28c-4ea8-b61e-a4982196215f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f3b51b-c28c-4ea8-b61e-a4982196215f@linux.microsoft.com>

On Mon 2024-11-18 10:18:49, Easwar Hariharan wrote:
> On 11/18/2024 3:06 AM, Petr Mladek wrote:
> > On Sat 2024-11-16 11:10:52, Christophe Leroy wrote:
> >>
> >>
> >> Le 15/11/2024 � 22:26, Easwar Hariharan a �crit�:
> >>> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. D�couvrez pourquoi ceci est important � https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> Changes made with the following Coccinelle rules:
> >>>
> >>> @@ constant C; @@
> >>>
> >>> - msecs_to_jiffies(C * 1000)
> >>> + secs_to_jiffies(C)
> >>>
> >>> @@ constant C; @@
> >>>
> >>> - msecs_to_jiffies(C * MSEC_PER_SEC)
> >>> + secs_to_jiffies(C)
> >>>
> >>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >>> ---
> >>>   samples/livepatch/livepatch-callbacks-busymod.c |  2 +-
> >>>   samples/livepatch/livepatch-shadow-fix1.c       |  2 +-
> >>>   samples/livepatch/livepatch-shadow-mod.c        | 10 +++++-----
> >>>   3 files changed, 7 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
> >>> index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
> >>> --- a/samples/livepatch/livepatch-callbacks-busymod.c
> >>> +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> >>> @@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
> >>>   {
> >>>          pr_info("%s\n", __func__);
> >>>          schedule_delayed_work(&work,
> >>> -               msecs_to_jiffies(1000 * 0));
> >>> +               secs_to_jiffies(0));
> >>
> >> Using secs_to_jiffies() is pointless, 0 is universal, should become
> >> schedule_delayed_work(&work, 0);
> > 
> > Yes, schedule_delayed_work(&work, 0) looks like the right solution.
> > 
> > Or even better, it seems that the delayed work might get replaced by
> > a normal workqueue work.
> > 
> > Anyway, I am working on a patchset which would remove this sample
> > module. There is no need to put much effort into the clean up
> > of this particular module. Do whatever is easiest for you.
> > 
> > Best Regards,
> > Petr
> 
> If we're removing the module, I'll drop it from the series. Just to
> clarify, do you mean to remove all of samples/livepatch/* or some
> particular file(s)?

To be precise, I am going to replace:

	samples/livepatch/livepatch-callbacks-demo.c
	samples/livepatch/livepatch-callbacks-mod.c
	samples/livepatch/livepatch-callbacks-busymod.c

with a completely different modules because I am reworking the
callbacks API.

All other sample modules are going to stay.

Feel free to remove livepatch-callbacks-busymod.c from the patchset.
But also feel free to keep it. The API rework goes slowly. I am not
sure if it would be ready for 6.14.

Best Regards,
Petr

