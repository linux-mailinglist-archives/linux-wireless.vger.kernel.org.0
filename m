Return-Path: <linux-wireless+bounces-11071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BAC94A286
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4FBB229B3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253C1C5781;
	Wed,  7 Aug 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz5p3paD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090A18D63A;
	Wed,  7 Aug 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018456; cv=none; b=BOq7f8RKU4Vqz8R7RvNgb7LHdGMMiul8Wvhd4oISHz8jQcaW00vqBJNzr3giNK7K+CKwLcW9WtLS7ta1JnlMqah4WlOb+4pkflkO97Qs3+V++XS3ihjLuEwnU7bidKOL74VF2E7V/R0ceahSZxz/1jWS1JMWaVzpuagtAGog8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018456; c=relaxed/simple;
	bh=xGOE/Rqpe5wqGr2Rw7Tt55WVZ0LS6kGCawP4TtAXfYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxzHR5395MnD9cKLk3t/fWMngt3n4YirBAh1lrHXkYF5AP8p6+lkqbN8m5XX0kEHwHFVpg8bhpTic2+tC75j+waQG4RV9cOEkuZCmWIwv1OzUbjoxEAxlpiZ+YqjsoJq/BSnKFxawiusge5nuQlne0B9J5NWc2Utos1UlbIWov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz5p3paD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so960970a12.0;
        Wed, 07 Aug 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723018454; x=1723623254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGOE/Rqpe5wqGr2Rw7Tt55WVZ0LS6kGCawP4TtAXfYU=;
        b=Qz5p3paDCeUTjppgfdjCNXHftc5OHXMeMI2GMutfkc2RHXINVou58p9l00aaX1VuDY
         VkZxb9K8iAHRjpD0WanaXB2QGOzYMUxSgKz95CEr5k5ApcVn+ZGx9UTXk/N61+WklVwy
         kIavKJPNBUApYF89fU8qsmzuY2vIANfUWHC/qVPHdb7WKvZvU5N56SDyAJVwzKaiEQki
         ypVby23SA3Se1Mtde3N+xvSma2defPji7X3PRFDytyivAIT29uqJ0jURoqxGLiVfqL3n
         dYbfzx8o6UlFxLJYvhJnMwdHSUEL76lEQ0dL61//qrhdz4C/MDSAStLgRfRGgdG/lhZe
         g6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723018454; x=1723623254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGOE/Rqpe5wqGr2Rw7Tt55WVZ0LS6kGCawP4TtAXfYU=;
        b=slAiVOvVhQD823Veq3mGlXBinXB7+rZV6VCzLiI7XHJJKM8O7wV2A8bIGLRS60ed8g
         Sh9yZQ92f5Lp6rwIUBNvQZyFR9a08TTL3j96O4jr1AUWnA3Lg3iHHzcmtcWjaTedj+BJ
         17ct+pmD5iU7lJvV+ybqgJtM05uYRa9A/r/5rx9QYcZC3Br+kA4G5fpcePacmhdhQSPe
         yuOoz34fdQJgWmpwoLT9O3fqh74pKFZsx9KYERUh4i4GSyRSWKZB4B0QPOAlmExLMKmv
         OSInMVf23MNrJFkuQdvmCGhSLFCBxMNdlUwbtIpIo4YJy54s6XFf86TVSnl/fAqrQLu0
         5Ftg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKBg5h1EbkKRhdgoAO2EvMCEMU/r56aWbFQJx0dAEvCgWfi/1hoc5CqbsPzAgKXf+BWFE/Gck4bz8DHibO3iixCoKg6Yv1gtXSiaYMTlwDx2AzVisysO+vQs8HiS4CWsmFIvHXihPlLRJpiPLkrkuwFhTScq/ZI7qZIS+8TOfr6UV/f0=
X-Gm-Message-State: AOJu0YyXhfx8lVSprYmGZv9Az92vceigdgve7rEHg4oA92YGqbsSYMVr
	fuG7OoeVEraSErm4CjR/elBsk/I6ECgp/rnW+H7U5Zg4yY5q2rzek5omFwUflHTdM//h9Eg9cgG
	P2SYesTHB3HaQHVpro/y2FEwHvmY=
X-Google-Smtp-Source: AGHT+IF9aJeXLSs92hnq+Z/eOQQVXBSK2NbgKbVKiZoV3tzpx2GqtTdjbOj37bUfTuogxl0r/63bkHy9IwoKRMRJGbo=
X-Received: by 2002:a17:90a:62c8:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2cff9447498mr20746657a91.20.1723018454172; Wed, 07 Aug 2024
 01:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805071743.2112-1-hhoracehsu@gmail.com> <20240806090844.GR2636630@kernel.org>
 <ZrIDQq1g6w/zO25l@debian> <87ttfwiyn6.fsf@kernel.org>
In-Reply-To: <87ttfwiyn6.fsf@kernel.org>
From: =?UTF-8?B?5b6Q6YOB6ZaO?= <hhoracehsu@gmail.com>
Date: Wed, 7 Aug 2024 16:13:37 +0800
Message-ID: <CAG_MuouHwMqHDsTw=7j9dYd4Ow_HvgyjuU1MK6aVb2Vb+uz4sw@mail.gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect User Priority
To: Kalle Valo <kvalo@kernel.org>
Cc: Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, 
	=?UTF-8?B?5b6Q6YOB6ZaO?= <hhoracehsu@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Kalle Valo <kvalo@kernel.org> writes:
>
> Guillaume Nault <gnault@redhat.com> writes:
>
> > On Tue, Aug 06, 2024 at 10:08:44AM +0100, Simon Horman wrote:
> >> + Guillaume and Ido
> >>
> >> On Mon, Aug 05, 2024 at 03:17:42PM +0800, hhorace wrote:
> >> > According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
> >> > AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4
> >> > and AC_VI (Video).
> >> >
> >> > However, the original code remain the default three Most Significant
> >> > Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> >> > and AC_BE (Best Effort).
> >> >
> >> > Signed-off-by: hhorace <hhoracehsu@gmail.com>
> >>
> >> Adding Guillaume and Ido as this relates to DSCP.
> >
> > Thanks. The patch looks good to me (only missing a Fixes tag).
> >
> > Just a note to hhorace: the entry for CS5 (case 40) is useless as CS5
> > is 101000. So the value of the 3 high order bits already is 5 (in case
> > you want to make a followup patch for net-next).

Sure. I will add it in next version.

>
> Minor clarification: cfg80211 patches go to wireless-next, not net-next.

Thanks for your clarification.

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

