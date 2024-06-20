Return-Path: <linux-wireless+bounces-9336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B032911237
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA6C1F2246F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FC41AC765;
	Thu, 20 Jun 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VS7f0Q8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABB1B47BA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912114; cv=none; b=DovISVwOHpJb3bufzkhu/wypv/uFl7rRtaHdBkmTsWOjjdLyO02xqyLVhmSQtzGY4+2GHsAoaUkmIiOOdq1SnG71E7DNNMtKPXqL+Fsfg3qfDNHu1UWMNT4YC/QgbZJBQ/+v9gDRCz2fNSK5wnq/ZtI4I8UQjfLvOfaLL6c1PQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912114; c=relaxed/simple;
	bh=LMJhwXKqZKwDoZfSA47gsl66tl0ZA7Fm/pP5alDoprs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4CDJ2JmSatH7FdpCtDtPoGKIONPDOrK3Iind15ByK77oqbToz9+m4CyRgbEw0ZcNxYWtm94SlX4Hlvy7lLvGTAlnrdE9xPRKwCDWbonkSWlCeYIucoKjvF5KA38bEVTYDd7zOJAWa5umGsLWHXnU8zQqkdqfKtyeQ1v8UUS+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VS7f0Q8s; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso870834a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718912111; x=1719516911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=VS7f0Q8sFzlQaMEMOe07F6ml/pKMc/nohApB40bpNhXIOYvqc9zw0QH52CiOsJGwYh
         MOeYAGFV+b/4xQMk9K95vO1YVXkOyRLg4lZ2F/VSXaBzefdn6XnFqbpRRBdzrO+YdTMV
         6J6UP4sX9SQviMww0R4hYUSzoZt1B1LKgGyFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912111; x=1719516911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=SJdFNcv0sL7QEBWUirCi6acwUkjaciYODv0PaLhg8p/Zus7WS6Stuw+SUrMfnJAdkI
         f/sJokx78I4oBSKXClOoulqo+JHf48GVq/cRZsUjiRvAml2ta8G2mGjdPIkxrmclIggy
         bXLU2Kn2ty5ZU34RrlGsZ+Zt4pL8gTtGYvl5XtSEVa+oFjPSPMu3S3XgE5Y94dHA8msw
         uv5tVPfg4yalqMOeZP0/otvxs59iccZD0O9hS6l5ATuPenKqrUpD79xsu1MEp7Va6hOW
         5XcxkShzmG+ifrlVXsuxqFZc5sC7i3i8dOC1exvWwI+hjpJDR4bEAD6TNmEEnY2UaiPv
         qNRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4N1UY03fXNUpwfWxn7mq5gRfovnfeipJIEKXtoJ9CPNYRYsdpl/yP1hmNzUsUhxCo1QtP03CDGuPML43+tiMMQB1yShrFlSbRckemIH8=
X-Gm-Message-State: AOJu0YxoDvG0xPolpr5zalAXYsFEuqpLawEwi5XU8JNmoS772HQqd/Jj
	U0dshCCwxXtCA3SG4vXo+PN0yTrCcKP4FCoUeYK6FtousYNYoFqz/ByRIluw2/1qSE+lfFotRWX
	SLKUyLo4N
X-Google-Smtp-Source: AGHT+IHv3lk4g8qzrZS8BKoEtXHngJT3VKL5lQmVCqJPs5PQ3SfBAaBAaABcB2AGa86XPTqbykfnGw==
X-Received: by 2002:a05:6402:b5b:b0:57d:10d2:23ef with SMTP id 4fb4d7f45d1cf-57d10d223f9mr2807243a12.42.1718912110714;
        Thu, 20 Jun 2024 12:35:10 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7438a18sm9965706a12.82.2024.06.20.12.35.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:35:10 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so904728f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 12:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWygHHIS1bgrtt1ha4eO3d7nnvH23D3PZYqa7suDmzBJV320paljsENsmE7sZ0pmXv40LfLvYqJzVKgyJj9tVLryjN4HXI3MmSAEN/5hnY=
X-Received: by 2002:a5d:6152:0:b0:35f:308a:cab0 with SMTP id
 ffacd0b85a97d-363170ecbe5mr4379764f8f.13.1718911595412; Thu, 20 Jun 2024
 12:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad>
In-Reply-To: <ZnR1tQN01kN97G_F@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 11:32, Yury Norov <yury.norov@gmail.com> wrote:
>
> Is that in master already? I didn't get any email, and I can't find
> anything related in the master branch.

It's 5d272dd1b343 ("cpumask: limit FORCE_NR_CPUS to just the UP case").

> > New rule: before you send some optimization, you need to have NUMBERS.
>
> I tried to underline that it's not a performance optimization at my
> best.

If it's not about performance, then it damn well shouldn't be 90%
inline functions in a header file.

If it's a helper function, it needs to be a real function elsewhere. Not this:

 include/linux/find_atomic.h                  | 324 +++++++++++++++++++

because either performance really matters, in which case you need to
show profiles, or performance doesn't matter, in which case it damn
well shouldn't have special cases for small bitsets that double the
size of the code.

              Linus

