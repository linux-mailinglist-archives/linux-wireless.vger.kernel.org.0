Return-Path: <linux-wireless+bounces-1881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98382CE3C
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 20:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DD1B22020
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCD6122;
	Sat, 13 Jan 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcE+xHZT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866B610D
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705173151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1Qtp1zHGgOhkFZedtgiIncadcUkn1bw6yNVXo83LI0=;
	b=dcE+xHZTZ21XVw0XbNqBldiqVhPENZH0eQv+qx7LvFrtgz11SrGzQEjtPgE2s9k5hFjZfS
	olAHoeDjQDaW4Yv4OUnwkYUKUj/wqAcHi+h8co3I1iZ4At/p2lUJ8Mq7S9oie9nUqO2225
	2gOvTP34rMk7XPCkxtat0j4GtzCJ2DM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-1zX1rek1M-WYxWT1qPfIcA-1; Sat, 13 Jan 2024 14:12:28 -0500
X-MC-Unique: 1zX1rek1M-WYxWT1qPfIcA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28c0420e177so8243478a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 11:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705173147; x=1705777947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Qtp1zHGgOhkFZedtgiIncadcUkn1bw6yNVXo83LI0=;
        b=DQQJkFIbue/LCqWRKPE6edB6WN8EPiqGmclPgbE7MPZ8ID9qiYzNgXvPPg4wXzcqbw
         H6K+42ve/8q5DUMFUeyJaBmjzJ3B5BAM2FUBY0IgT0tiCRxX7uxXhTL4kUX3UcaciqCx
         Pa2Mcy1UBktGjVOUlz7Hr07xUu3e27ffdIpOXuxoV22uMFDYHGJ4wfgP6e9agHIBTd+L
         3VuXl7Wq2cSIALxLPLqzzCWSt+IiQIqP9e/NM832kwr4+tfW5eZkxRGfYjeNOUBlTGhJ
         P6PmnNX9vGVbI1SfoDQinmdLgNR1zVIRvYcsDkSjT8o/UPLLTOPox0jonpM1E0VKSZ65
         U+Lw==
X-Gm-Message-State: AOJu0YxX22R3TJz7D/urUPnIx9Qx0zbHJ8JbqRObmxRDee3gUbypZxXI
	o3Lsa7tvIXUsTmIMvnZKFJ2sXuBJvggUc1doUprs91UAA3t5JevNUEDCPXUHNpS+neY28P6PyUz
	jifUfN/vWfJwK8g9Db9XWBXeYr22mBAzZRv/56ATssbadbWxhiGZU7Y/Ac/U=
X-Received: by 2002:a17:90a:9e7:b0:28e:db1:49c8 with SMTP id 94-20020a17090a09e700b0028e0db149c8mr1675181pjo.53.1705173147180;
        Sat, 13 Jan 2024 11:12:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5JVmWi06sginF0pJC1IlYJxHHs92Y1/+oEg/bspbhraOOMILDBzVZ/fp4g2alo6KRGXHWgLO4R+1iVQZWXMo=
X-Received: by 2002:a17:90a:9e7:b0:28e:db1:49c8 with SMTP id
 94-20020a17090a09e700b0028e0db149c8mr1675174pjo.53.1705173146893; Sat, 13 Jan
 2024 11:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220095750.307829-1-arend.vanspriel@broadcom.com>
 <87h6kcq1yn.fsf@kernel.org> <ec670eed-cd63-470c-b37b-76925a1ec6d5@broadcom.com>
 <87r0il8ahu.fsf@kernel.org>
In-Reply-To: <87r0il8ahu.fsf@kernel.org>
From: Eric Curtin <ecurtin@redhat.com>
Date: Sat, 13 Jan 2024 19:11:50 +0000
Message-ID: <CAOgh=Fy2CUxhU7=0JfY+y1Bc59Pz+mVMbEYvMJ0zL7Z=s4LSug@mail.gmail.com>
Subject: Re: [PATCH] wifi: orphan brcm80211 broadcom drivers
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	Fernando Piacente <nandopiacente@gmail.com>, Paolo Perego <pperego@suse.de>, 
	Sreekanth <chvsreekanth@gmail.com>, Izabela Bakollari <ibakolla@redhat.com>, 
	Daniel Berlin <dberlin@dberlin.org>, Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 16:27, Kalle Valo <kvalo@kernel.org> wrote:
>
> (sorry for the really late reply, I was on a long vacation)
>
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>
> > On 12/20/2023 5:21 PM, Kalle Valo wrote:
> >
> >> I am so sad about this but I fully understand your decision. You have
> >> the best knowledge of Broadcom devices and you were involved with
> >> brcm80211 from the beginning. I can guess how difficult lately it has
> >> been for you to find time for upstream work but even still you
> >> replied to my mails and tried to support the community the best you
> >> can, which I appreciated so much. Everyone else in the corporate
> >> world usually just ignore, you did not do that.
> >
> > Hi Kalle,
> >
> > Maybe I should reconsider, because it feels a bit like high school and
> > the bullies won. I agreed that I can not meet expectations and the
> > main aspect being testing patch series on fair amount of devices.
>
> Yes, please reconsider! I didn't apply your patch because I was hoping I
> could still convince you to continue maintaining it :)
>

+1 on @Arend van Spriel reconsidering.

We need another maintainer also though, for the amount of users of
this code, this is undermaintained.

CC'ing @Izabela Bakollari who has a Raspberry Pi 4 coming in the mail
who offered to help test patches, help with maintenance, etc. She has
been in contact with @Daniel Berlin .

> I fully understand the challenges of maintaining a huge driver like
> brcm80211: no proper documentation available, several companies
> involved, a plethora of firmware branches which might work a bit
> different and so many hardware variants.
>
> > Do you think we can address that with some help? For instance by
> > reaching out to several people in the community that use brcmfmac and
> > ask them if they are willing to regularly test on wireless-testing. My
> > experience with community members is not so great as they tend to
> > loose interest and move on, but it may be worth a try. Let me know
> > what you think.
>
> I definitely think that getting a small community around brcm80211 would
> be beneficial. For example, a good start would be to create a dedicated
> list for brcm80211 where people can discuss about anything from testing
> to developing patches and all between. lists.infradead.org is one good
> place and there's also lists.linux.dev.
>
> Let me know if there's anything I can help with. I have also CCed people
> who expressed interest in helping brcm80211 development before the
> holidays.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>


