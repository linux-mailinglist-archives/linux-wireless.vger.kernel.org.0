Return-Path: <linux-wireless+bounces-826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD44814567
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6023A1C23053
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 10:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14A2D78C;
	Fri, 15 Dec 2023 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmx9wFQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717C2D7B7
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c701bd9a3cso174097a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702635707; x=1703240507; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfQDn1DGVV/BMyBkHm5XCyguQ3fbuZxY2bdynBlrT/g=;
        b=Vmx9wFQ4e4F8GAT/HuhTcz5CSCMZJQ8lXNg1I/0iYFb/QS5bhahGT/wXbNUtUFwWGr
         jYA0JBUwu9GUCHLQl9MRjH/Qw3s8/4sXd+5k7ss4xF1fxP1uHASga4C9+QgtYkgwhW8t
         BVKU3eAUgSB6K3R9oWsqwUDKZ+ulca7tFqPmv7AoJoC+RoJ9wIzAJMLY+WFjg3mx+ulA
         8Xr0Rtb6fx/uCnK7bddQomxxcIB5d7TIlWTf7yJPoB3tlc7eQ+mW1zu+H7Qzw92xBB4A
         yjx645QUkhOvcj7Z2oqu/gQFuChsymh8+g4xW06VoeP5iUNbA7N1CfXv/lNtqnVyaMta
         RmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702635707; x=1703240507;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfQDn1DGVV/BMyBkHm5XCyguQ3fbuZxY2bdynBlrT/g=;
        b=w4LH0o5S9dHWEKUy2b9nboe/rkXRTuHc8gvlPaFNMBFJAkNKq7M8QJhngF5D0ZDB0d
         rXudF+/aleub9UZ9iCX27T76Z4c4AbWH9wdgpIT6GmvXJ32eur5bplBP3qVhHsMidzKO
         nNvWKw0Xe76SPAHaBd58vGOqgTA7D0MmPWKaN/eLOlRjjJDBjo+o1BobEaOkLvLqf+pD
         Q8gBzJzdSwMOAIyioVvUkA7tGjMsXRXQJ91d1OiS8uN12PLmyVtyE3F4geLpxJE/DZV8
         i6Nz97wVT0ZWUvYjqpsez0xLZwxB0XaK32SHm7YBWHFAORU8RxmuXoA4W55KRqhvdmqV
         +lFQ==
X-Gm-Message-State: AOJu0YymOCnEV58Z6Y1O/E1kxI0+9XwecX/yBttT2Ur0rooJR1Hfer5o
	mSndlMSEHpdtE1iG9jtqDgk=
X-Google-Smtp-Source: AGHT+IH0sCBK2nsuqC8Nk78XitVO1m2SLfjzsLkgbFnd7yZ7iyZoAJ1JNeME59Cu+Uawu/nzwVzUfQ==
X-Received: by 2002:a17:902:f68b:b0:1d0:a9fa:58eb with SMTP id l11-20020a170902f68b00b001d0a9fa58ebmr6271926plg.122.1702635707172;
        Fri, 15 Dec 2023 02:21:47 -0800 (PST)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001d364210979sm3087638plg.224.2023.12.15.02.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Dec 2023 02:21:46 -0800 (PST)
Date: Fri, 15 Dec 2023 18:21:44 +0800
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiazi Li <jiazi.li@transsion.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
Message-ID: <20231215102144.GA2946@Jiazi.Li>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
 <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
 <20231026013528.GA24122@Jiazi.Li>
 <9d2e0cc7ec292a7a1ea26c43ada305f40bc22829.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2e0cc7ec292a7a1ea26c43ada305f40bc22829.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Dec 14, 2023 at 02:13:38PM +0100, Johannes Berg wrote:
> > > 
> > > Ok that's bad - so you hit the WARN_ON there? How that? We should fix
> > > that too?
> > > 
> > Yes, hit this WARN_ON in the test of direct connection between mobile
> > phones and PC. Here is the log:
> > [ 2741.982362] -----------[ cut here ]-----------
> > [ 2741.982446] WARNING: CPU: 6 PID: 2175 at net/wireless/scan.c:1496 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
> 
> Right, so you can reproduce that - can you find a fix for it?
> 

I am responsible for kernel stability and I am not very familiar with wireless code.
The colleague in charge of the WiFi module also couldn't find the root cause, so we
used the workaround solution I mentioned earlier to address this issue.

> > I don't know why this is happening yet.
> 
> OK ...
> 
> We have some basic kunit infrastructure, maybe you can work out
> something there.
>

I would suggest that my WiFi colleagues use basic kunit infrastructure to identify
the root cause of the problem.

> > > > this bss->rbn will continue to hold
> > > > expired data, such as __rd_parent_color.
> > > 
> > > Does that matter in any way?
> > > 
> > It caused a null pointer issue in rb_erase:
> 
> Well, OK, so the thing isn't about it holding a color or 'expired' data
> or whatever, it's about it being still on the rbtree, no?
> 

I think the thing is rbn has been erased in cfg80211_update_assoc_bss_entry, but
it couldn't be reinserted into rbtree:
  	rb_erase(&cbss->rbn, &rdev->bss_tree);
  	rb_insert_bss(rdev, cbss);//reinsert fail
  	rdev->bss_generation++;

So bss->rbn is not in rbtree now, but bss still in rdev->bss_list.
This leads to erasing this rbn that is not in the rbtree in __cfg80211_bss_expire.
Expired __rb_parent_color, rb_right, and rb_left in this rbn may cause various crash issues:
1.
[56994.336470][T312578] WARNING: CPU: 3 PID: 12578 at net/wireless/scan.c:1495 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
......
[57049.728279][T712578] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
......
[57049.765847][T712578] pc : [0xffffffe95cc51388] cmp_bss+0x30/0x3a4 [cfg80211]
[57049.765973][T712578] lr : [0xffffffe95cc50c68] cfg80211_bss_update+0x7c/0x76c [cfg80211]
2.
[12114.124799][T412320] WARNING: CPU: 4 PID: 12320 at net/wireless/scan.c:1496 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
......
[12418.513153][T212320] Unable to handle kernel paging request at virtual address ffff81b1d69f1928
......
[12418.548440][T212320] pc : [0xffffffec9e669630] rb_insert_color+0xe4/0x164
[12418.548762][T212320] lr : [0xffffffec99766fb0] cfg80211_bss_update+0x3d4/0x76c [cfg80211]

I have encountered crashes in the code of other modules, and it is speculated that the use after free of rbn has damaged the memory used by other modules.
3.
[ 3981.870858][T510216] WARNING: CPU: 5 PID: 10216 at net/wireless/scan.c:1496 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
......
[ 4020.227747][ T4070] list_del corruption. prev->next should be ffffff80ebeace00, but was ffffff81950e8b30
[ 4020.227892][ T4070] ------------[ cut here ]------------
[ 4020.227913][ T4070] kernel BUG at lib/list_debug.c:61!
[ 4020.359413][ T4070] pc : [0xffffffd0985eecf8] __list_del_entry_valid+0xc0/0xd4
[ 4020.359438][ T4070] lr : [0xffffffd0985eecf8] __list_del_entry_valid+0xc0/0xd4
4.
[ 4858.776299][T102099] WARNING: CPU: 1 PID: 2099 at net/wireless/scan.c:1496 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
......
[ 5557.453407][T732106] Unable to handle kernel paging request at virtual address 20ffffff813691f8
......
[ 5557.466271][T732106] pc : [0xffffffd0ce5bda08] binder_open+0x208/0x608
[ 5557.466273][T732106] lr : [0xffffffd0ce5bd9f4] binder_open+0x1f4/0x608

> > > > And this bss still in rdev->bss_list, maybe double erase in
> > > > __cfg80211_bss_expire later.
> > > > Double erase a rbtree node(with expired parent and color data) maybe
> > > > corrupt rbtree, so add a in_rbtree flag to fix this issue.
> > > 
> > > This seems overly complex - couldn't we just remove it from the list too
> > > or something? It's already a case that "should never happen" so ... not
> > > sure we need to do something "good"?
> > > 
> > Will remove it from list when re-insert fail cause confusion in it's
> > refcount? Which could lead to leakage or use-after-free?
> > > 
> 
> It's a warn-on anyway, better we leak it than crash?
> 

Inaccurate refcount may cause use after free, which can also lead to crash.

> johannes

