Return-Path: <linux-wireless+bounces-15385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C765C9CFA7E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 23:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB103B2526F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 22:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E61FE0F5;
	Fri, 15 Nov 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xurk/K9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDFF1EB9F1;
	Fri, 15 Nov 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706491; cv=none; b=DgO50fD/yh7mqHhI9IIq9MPI3ZDRI9pL3ELc3x8njZnQxPlIqHD+AshUOt8slH4e05H8mgd2lBIjZQlpQBThHrBVjdQlhFySgM0mAaUnItFM0QqaM9Vu0CNfvExoXOH5kr98A3gM6OblujE4VQbD39a4eWZl1PmJN2gD9OLRTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706491; c=relaxed/simple;
	bh=ynYosdbbpOY3VrI3Suc9RBL1xgUDIqoX2LZt7ciANKc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uzMh4s9JePX3prbtdCiqFxVVXtMli75vS4biTGqF/8WanEozNo13GaWvUAXlNViZNSI3l/BNyoMmJoxlx+sEgplVV/2VfHHXOom1Qh0Y3z6FOYjPDkppoHgnmpLOgGZcqcoTfWQbnHBdNoGN1GxU5qftM1ae8KbXx1Eux36YX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xurk/K9N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 684CD2064AE8;
	Fri, 15 Nov 2024 13:34:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 684CD2064AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731706489;
	bh=OEAxYqndmV97fB2t7JocLL7u1S4ql6E8JdtDlfM98mA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Xurk/K9NZ4Pt7R0qwaS9VSYSKCTMSaNp/aapEsQZCtIT74ft5tvctXWuFivs3Zswx
	 hrelPOn+ppZ3FOsJiI+79MeaWo7lX97CMgyLO8+gyOebFfO+/iJc5GjxBT3U1ILKzl
	 NFamFr9+2AnMiAp4lQnkRWbNDRlCI9FqXsyeg14c=
Message-ID: <ae1f83c3-88fe-4b75-9446-e7e711b954ae@linux.microsoft.com>
Date: Fri, 15 Nov 2024 13:34:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, netfilter-devel@vger.kernel.org,
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
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Michael Kelley <mhklinux@outlook.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 22/22] jiffies: Define secs_to_jiffies()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-22-19aadc34941b@linux.microsoft.com>
 <e1ff4b71-7abf-4ac6-8b82-86aad5394de6@quicinc.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <e1ff4b71-7abf-4ac6-8b82-86aad5394de6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/2024 1:30 PM, Jeff Johnson wrote:
> On 11/15/2024 1:22 PM, Easwar Hariharan wrote:
>> secs_to_jiffies() is defined in hci_event.c and cannot be reused by
>> other call sites. Hoist it into the core code to allow conversion of the
>> ~1150 usages of msecs_to_jiffies() that either:
>>
>>  - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
>>  - have timeouts that are denominated in seconds (i.e. end in 000)
>>
>> It's implemented as a macro to allow usage in static initializers.
>>
>> This will also allow conversion of yet more sites that use (sec * HZ)
>> directly, and improve their readability.
>>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com
> 
> your signed-off-by should be last.
> 
> and you have a patch ordering problem since this patch must come before all
> the patches that use secs_to_jiffies(), otherwise this series cannot be bisected

Thanks for the quick response, indeed this patch is already in tip[1], I
pulled it in for testing the series but missed out on removing it before
sending. Please review v2 that excludes this:
https://lore.kernel.org/all/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com/

[1]: https://git.kernel.org/tip/b35108a51cf7bab58d7eace1267d7965978bcdb8

Thanks,
Easwar

