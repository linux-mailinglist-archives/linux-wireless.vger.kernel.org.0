Return-Path: <linux-wireless+bounces-16357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C51629F05FA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10E1165641
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4A1993BA;
	Fri, 13 Dec 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JLi1Ub40"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD66192D7B
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077153; cv=none; b=bXmlhY7IQ+y90IrhB49c8xgqU7uPipjjU3hXpYFS+xZnBI5ko3V/kmVwWxjd0rlWneXHewSTd4reN7JRhS+Ihj0W4n4Up9WSgjbGnFZQGmVaaDQ731DyQ04gEMDY7QzBi6WxbQw4YRGe+LGZ1isOlF7IC3Kp4EwSnX6JLtdo5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077153; c=relaxed/simple;
	bh=Gm1aSfPWn+6Iv90/f+5lwr4JIOMPpgZfZJbELp9SPys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOqxGFuwpkvAJU+eAunTmZ9l/hqxN7Dn96mXjPAYyJcUCXyz5ap3LcxeSrCwSkxfmBKUy5SyQb6b9DtSS63XftN92O6oDKTgv1/mryK16jbZ3B/i3pEjwIUCtHK+zxO3mL4fpyi2cllKx3UEm+2uYquIK3syEPHJlbEgZMXSbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JLi1Ub40; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso191754866b.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734077150; x=1734681950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=JLi1Ub40QBv66ZjD7LttDdNXIL9STIwTkkza6loCqucui2uM3j9xdISG+PuR+Ks4Dw
         VFQm2ZqQDTqOMUf26R5D4jr4ELtV//qcPMOupX3H2QD38yq3LwEL9JRUY7kMvdi+chwg
         rpmhxVyEShwyfM3PHOB4uYy5OfJv/z9SljmG8PLFEd8Wd3OFrq+11rPlhaf0jphRYp5/
         KOE0Hj0vqdVtvPWVcyy8IVbXrKSUUV82lvIM/0O+038nVI/fPRGrHuitVOgj5Aq24nS1
         vuOheIixL6exmB/lKTzdTtIB/c0Ru20ZK2SveaNytzw3QMb5lGXpaP4PCI8XKb2vb7VL
         n1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077150; x=1734681950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=vM9ofSNohdprb2x01d6DEBCdxSDvn+ydOygvJU8Eqoo4VyCZd0W+i+VxFRhUcl+0Ku
         DQoQYQyp8V4kxwg2HGXc2ZVP94JpiV8q5Be4e9k+cQaHBhyaQWskOE85oDcnO26wFx4q
         gqWI1UndqaoKGf5AJsvJBRmlsccFYqhAxSQg9yindaR8qMk3eRH3mKtWhakULDFtoO4J
         mG6nd4QAcf6bSkZWu5KEf10psYTKhuB6xbAXHdHPGcvyLKaxlbfK2P0qAvMNsEspCeeA
         ySYAjXr3ULKBJGerWSWGns4wxXIrIYl9zcl6X5TMpUTg1/FMW+XBHoGDrB7zvbAEaxb6
         XbpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsxj6R2DFaMgMard9QEBmj8FlRHI45VLkZFy/zoJerfCU2T07LTyPwKijYHly92iqYvZJ3jWi75ctTxjXhhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRYFlz7GOe6HFl4Q3z7CrJ0upYWUrn28wHgGc5ECKRtfqr1fn
	FxSAnvS6Q7noq11uc66AWpw6xZwus5h5GDbZH+ww6JqbWeCHb/NO0TfYIvZrDG4=
X-Gm-Gg: ASbGncsPsKXujPNfS+JFdJo0bF8cpXzB6umlhS1wghoN6DDD6Mct3K1dlHGA3m7JvgQ
	KD2188uOhWeq3xF0RH7bKQUMR01wntv5wrMZiMxuNCa9A9/D2q0ZhXT1+VlVhTA3h/YO4MqhMSC
	GPXxGyUmTjz06WHRPJdPRRVwSAtFoDFLUCjBPFQHNmMSASDdOCZgmnTM3GBRSBfWcFPTisxbmJ6
	tmzC7ZBhvafRlP/PQkHgsuW/8X9IOxJjSAVREMa/Sutb7wGlm1WXz6GbA==
X-Google-Smtp-Source: AGHT+IEBU3KaEVduDDJFmDiYKp43p4o//mXEFM4u7vCzKG7h47JoeDZ5E1DdrcH3VOsdWE+nfKrYuQ==
X-Received: by 2002:a05:6402:4584:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d63c318beemr3590523a12.8.1734077150211;
        Fri, 13 Dec 2024 00:05:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ef026a41sm7507030a12.15.2024.12.13.00.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:05:49 -0800 (PST)
Date: Fri, 13 Dec 2024 09:05:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	x86@kernel.org, linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
Message-ID: <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213054610.55843-2-laoar.shao@gmail.com>

On Fri 2024-12-13 13:46:04, Yafang Shao wrote:
> Since the task->comm is guaranteed to be NUL-ternimated, we can print it
> directly. Add a new vsnprintf format specifier "%pTN" to print task comm,
> where 'p' represents the task Pointer, 'T' stands for Task, and 'N' denots
> Name. With this abstraction, the user no longer needs to care about
> retrieving task name.

What is the advantage, please?

Honestly, I believe that the meaning of

	printk("%s\n", task->comm);

is much more clear than using a cryptic %pXYZ modifier:

	printk("%pTN\n", task);


The %pXYZ modifiers makes sense only when the formatting of the printed
information needs some processing. But this is a plain string.
IMHO, it is not worth it. In fact, I believe that it is a
counter productive.

Best Regards,
Petr

