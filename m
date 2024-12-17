Return-Path: <linux-wireless+bounces-16486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2819F548A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 18:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AF9188657E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E31F9439;
	Tue, 17 Dec 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="EaNS0yuh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9B1F9A99;
	Tue, 17 Dec 2024 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456810; cv=none; b=qG/dAVqqYJ+bcu0BwLNVE8tKk2botf+7/tPs1CQ3CJ7Ktcf5o8VgRPjiPE7/dctBuRX/JMGR05RnQpI2y4+EHlHdwtJnwEGErMU6ctmvwUvM7KY77W86ewOi0zv+XcssWlHRLnDGG6Ot5DmLcTtAKUOS2w2RxgN1kEcAaF348DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456810; c=relaxed/simple;
	bh=hUI124COUPuTuBzVlqt9m3OtX7cmjQ7JUH8JgbG9mRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uBK0UaO6II+ZVUKJbMHNj+fVIKxWCOm5IiiekewXQ5o3DW0DSn2CB3LgTXt6I9rnj5K7wOibtcoGPesxA7XMebG55nlKFmVe3F9sK8ITNm0+Z85w9fCYOjqh4W2X5dzYBjH50kpl7o4bh1lav1J3bbKWtbfBH5GMd0DwjoUrufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=EaNS0yuh; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=04pTIo5ApWySSg1irLecWsNtdqZYhiDphbsaLsL2++E=;
  b=EaNS0yuhC4s6iN6WnIrnfVVUKM6YqvVWkIbgcSrxq8z6qdZxbvXYN/B4
   9evJrozXCky5ezt+egWk2fvFzCjCGhd/6dlOUNDuVRw1L3nJUFrUuyJTW
   ezsZJHG7RK8qkYyuGARiZzCMp891lCLljEEn1C5atxdbFGiHm+3aLIRi2
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,242,1728943200"; 
   d="scan'208";a="104581457"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:33:20 +0100
Date: Tue, 17 Dec 2024 18:33:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alexander Gordeev <agordeev@linux.ibm.com>
cc: Easwar Hariharan <eahariha@linux.microsoft.com>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, 
    Jozsef Kadlecsik <kadlec@netfilter.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
    Haojian Zhuang <haojian.zhuang@gmail.com>, 
    Robert Jarzmik <robert.jarzmik@free.fr>, 
    Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
    Oded Gabbay <ogabbay@kernel.org>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Jeroen de Borst <jeroendb@google.com>, 
    Praveen Kaligineedi <pkaligineedi@google.com>, 
    Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    James Smart <james.smart@broadcom.com>, 
    Dick Kennedy <dick.kennedy@broadcom.com>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    =?ISO-8859-15?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>, 
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
    Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
    Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
    Takashi Iwai <tiwai@suse.com>, Louis Peens <louis.peens@corigine.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Naveen N Rao <naveen@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
    coreteam@netfilter.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, cocci@inria.fr, 
    linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
    dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
    linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
    ath11k@lists.infradead.org, linux-mm@kvack.org, 
    linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
    linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
    live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
    oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org, 
    Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH v3 02/19] coccinelle: misc: Add secs_to_jiffies script
In-Reply-To: <Z2G02RN7VelcrjNT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <alpine.DEB.2.22.394.2412171831300.3566@hadrien>
References: <20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com> <20241210-converge-secs-to-jiffies-v3-2-ddfefd7e9f2a@linux.microsoft.com> <Z2G02RN7VelcrjNT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 17 Dec 2024, Alexander Gordeev wrote:

> On Tue, Dec 10, 2024 at 10:02:33PM +0000, Easwar Hariharan wrote:
>
> Hi Easwar,
>
> > This script finds and suggests conversions of timeout patterns that
> > result in seconds-denominated timeouts to use the new secs_to_jiffies()
> > API in include/linux/jiffies.h for better readability.
> >
> > Suggested-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  scripts/coccinelle/misc/secs_to_jiffies.cocci | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..8bbb2884ea5db939c63fd4513cf5ca8c977aa8cb
> > --- /dev/null
> > +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Find usages of:
> > +/// - msecs_to_jiffies(value*1000)
> > +/// - msecs_to_jiffies(value*MSEC_PER_SEC)
> > +///
> > +// Confidence: High
> > +// Copyright: (C) 2024 Easwar Hariharan, Microsoft
> > +// Keywords: secs, seconds, jiffies
> > +//
> > +
> > +virtual patch
> > +
> > +@depends on patch@ constant C; @@
> > +
> > +- msecs_to_jiffies(C * 1000)
> > ++ secs_to_jiffies(C)
> > +
> > +@depends on patch@ constant C; @@
> > +
> > +- msecs_to_jiffies(C * MSEC_PER_SEC)
> > ++ secs_to_jiffies(C)
>
> If you used this script only, then it did not seem to recognize line arch/s390/mm/cmm.c:207
>
> 	mod_timer(&cmm_timer, jiffies + msecs_to_jiffies(cmm_timeout_seconds * MSEC_PER_SEC));

There is the requirement that C is a constant, and cmm_timeout_seconds is
not considered to be a constant, ie it is not all capital letters.
Indeed, it doesn't seem to be a constant at all.  I don't know if the
requirement of being a comstant is really necessary.

julia

>
> Thanks!
>

