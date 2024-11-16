Return-Path: <linux-wireless+bounces-15403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EB9CFD68
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B78286BF1
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D51917D2;
	Sat, 16 Nov 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMPFMWaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F12524C
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731747537; cv=none; b=ubeM93sxC6JqJXMaWVmRWKbQmuv60EUQ8NS7HUpVoz2F6efI1xsE5RrgK9qogzpvATeuTZ2gnB9sUy0GjvlfASSqp/mEqb8LlSxxSfR5fZzq2GGoDkNQby8T2kj2nnZzB501JlrB6gcEruTYQVn6jN+q6HpiqChIXXkVq8ZtfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731747537; c=relaxed/simple;
	bh=lX2mz6euq31gOzNNmcgqZAwIoI03oMF5nZ0eHul497E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJF5p77vR5xHbbAEkafcYUTwv5gk33I/+qL5QTMNL70j1vMzKCHgt++YiBdx0pSU400Nr4ZWH0rkbd4mUCETYlZ4Gc+7s4px1KpiKwbEiTaBco82LkJASxom8Aee7QDzdDmj0vGeHRpWqiDM9S9buqc/Z24ukRSPAokm0eVqXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMPFMWaQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso342240566b.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731747534; x=1732352334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lX2mz6euq31gOzNNmcgqZAwIoI03oMF5nZ0eHul497E=;
        b=kMPFMWaQVsWfmQ1U5zw0Ka+4CXHROXzaCX5kj627xcss5K42k4EHVD+7Acly2tLetX
         oqyDfc3b6c7uqqekDWbxaOpxp4d3gePWMdCQm4AGbXDgG4RWWB7h54zM0IsDO4L0sBTN
         SyaocZ3X47MTzh0PMOItyQWHJzdskHJDSddktF/DoMZUrrcwHTvAxO9WTdwv7Sy5ejo8
         SQVK8Q37j89JN/doX/LO8OSzV2BSZwnatv9GDdRRGrZ3UzH4Ygwjx44VYwaAIjXg0yl9
         qUtLr8cEW4CvGkE4y/zCtAELGRVt84O97ptk1Na5Q+E9ef5bXEYFFKe+X/wgIcJ+jvCD
         nDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731747534; x=1732352334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX2mz6euq31gOzNNmcgqZAwIoI03oMF5nZ0eHul497E=;
        b=We7U9/ffFTvARAWpKtmGDvTdOk8XMOnG6NvJglBaTvUhfF/o1Lp0wByh6UGNgjYJjX
         ie7dQctsWDuE8cYaQmonkd9Dbn7/Ou954ji137ulQAJyX3kKSyvY0z02ZoVc+GuUXH+A
         fG3icwgD35PsS9UqTiC7Zq78htmKTdRotBc/sTX9EJMgc2YbWlhnhJnruyZpfWM4bp94
         K/WfHoe9RAe7YYM4fiPr7xPv3Q+dNUH6sO2DmmAgc0uaqmCjAmGw909EgP3qk5IcJWxt
         7CYadTjYEm4XPLxu+bINTJIgb8IEq93lVOmolSeJG7OsdCRjDAX9/Gda4W6713s/5Khp
         /TLw==
X-Forwarded-Encrypted: i=1; AJvYcCVnBNG6p461XLBaiLnQ3R6goH/FMm3oHb4zBpHMLW/uaGfXjVBUQZ8xcoQBJOuyaw3XG8n5jQkfqfb2a5xc/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmL+5HbBwRb3ixwL4/7SSRQaC/KkfpgfPwPWpd+hsVbYNRcsr
	R4P5zyEGPJItZ0DFEoX37my+J1iDGlcMIBzJoX4r7WwZ7pB8MyzUVS8bOhM0OVFAjZTNAEAe81W
	BimYLD1MCDsFa27rYV90JHh6ElbU=
X-Google-Smtp-Source: AGHT+IHIzVuyy9zeCiS+HpgWMOmLGakMMuu4pEwqaCJOEh4vmj719Xb4gwHWTATrNNNa7xs9o7MhLpOie5hCf9efviE=
X-Received: by 2002:a17:906:ee8b:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-aa483489427mr564127666b.36.1731747533738; Sat, 16 Nov 2024
 00:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116082417.8720-1-pkshih@gmail.com> <ca8e16a2dbc9c38e5bf2f3e426a2132393b381be.camel@sipsolutions.net>
 <d783a6d6a429feec6763077126e76445b6f186e2.camel@sipsolutions.net>
In-Reply-To: <d783a6d6a429feec6763077126e76445b6f186e2.camel@sipsolutions.net>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Sat, 16 Nov 2024 16:58:07 +0800
Message-ID: <CAHrRpukU-6MOoDsX+HRQ1XbdvoDMpUDuR4s=J-_9ODm3jreU9g@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: assert and correct maximum bandwidth
 within frequency difference
To: Johannes Berg <johannes@sipsolutions.net>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org, combuster@gmail.com
Content-Type: text/plain; charset="UTF-8"

Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Sat, 2024-11-16 at 09:33 +0100, Johannes Berg wrote:
> > On Sat, 2024-11-16 at 16:24 +0800, Ping-Ke Shih wrote:
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > Since kernel will reject max bandwidth being larger than freq_diff in
> > > is_valid_reg_rule(), as well reject it ahead.
> >
> > Not sure that's generally true, if you have AUTO-BW I think it should be
> > OK?
> >
>
> Sorry, no, I guess AUTO-BW just lets it expand the bandwidth beyond the
> listed, if there are adjacent ranges. Been ages since I looked at this.
>

I have similar thought as you, but I should admit I have not yet
looked into reg.c
to know the detail.

I quickly check the warning reported by user "kernel: cfg80211:
Invalid regulatory domain detected: RS.",
and lookup possible cause could be is_valid_reg_rule() to make this patch.

I hope original reporter can help to test this, or I will try it when
I have free time.

> Anyway this probably doesn't fix the user's problem, it just makes it
> rejected when compiling already ;-)

Honestly these mistakes were made by me. I should fix them.
Since rtw89 still use wireless-regdb, I will keep updating the
regulatory especially
lack of 6GHz frequencies.

