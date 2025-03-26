Return-Path: <linux-wireless+bounces-20851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FEEA71991
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389553AD5D1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC5189903;
	Wed, 26 Mar 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlbKHQWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330791F4175
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000894; cv=none; b=jDAO0SAKpyOfMp0wYpFxGO24G0WJ7h+cMZ4j8249YaEj/YPCkJtLH6b32U3qv5dwfGoDHFY9IQussTBqRPicIw4/o2hn9z3yqP16DsL5o1HHem3u3zqwfyaxwkvITPZ+sfdADkArYc6ezr+dvV+m7iF+QmxnUiU/wccMgN4bAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000894; c=relaxed/simple;
	bh=02X6yN4SswI/9hcxh3NzYkNAPF+BwgR9jvGHnZrFNrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuLWrusHOND8Sv3jXzOi0f4GSs1n3XYgHEvLWsHygXUVvvs11oqVU6D7c+xy9WBraMA87OXxOptl4IbgNK9Yic08f1Se7a2zgyecYSjn2jl5PTxjGLL7DLVngS22fsnsaPbDrIOc/GZiksnp41HfD0hp9ogWoxJ/6/YNezCflls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlbKHQWf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6c90b51c3so76356137b3.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743000892; x=1743605692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=02X6yN4SswI/9hcxh3NzYkNAPF+BwgR9jvGHnZrFNrU=;
        b=VlbKHQWfJDLGiLvsDFgls6mRA9nXSriwaN2aGfTM10SooyRkqED2ds2uFxFV57uewO
         Vpg0rpFzfyTTrgCwYr5EqMOdbJa1GpODEhvm4z5yxewYzbwUM+iQNa9U3IEMuoDqBXmH
         XGYlO4FxDX/6NV2tA1Z9Kv0kW/NyK65kxQ7RiFQGtMeKe6yC1RCx/4uuPm71JcAh7KIs
         AX5gFTIsWUe9QL1VFIehUEINW05nhrXbmSVNLR39hMONRZP2Krmlv+QXq+zDPSAI0Irk
         BeqQnev14RpBHibQriNkSuvM53xuPp7c/8Lbm5uch92MxwCP7CHspZzs1Ai0CNu/pgwn
         TpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000892; x=1743605692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02X6yN4SswI/9hcxh3NzYkNAPF+BwgR9jvGHnZrFNrU=;
        b=GLkTGs5gOz4luyxG3KZO+3/5DSs99b6vWqTdaWcXqxpFsBhKReBAiiud8L/VitBamM
         AknxWrH7FfdHoAUS1dn72iE3QILqLsXhsprvshrCpMOpLv4ckDBdMNhL6XZbf0pWBW2l
         kAl8QgRYBUHWwoGEPu/votbc9kFIVm8x3W2lpjJ/blorKSs6wqqSre6E+JqX0d6em7Me
         8XaaDoJZzzzFkdyeXW436GxvlQex0s8zxtonRPiqzsZgjrZLjKu0tb+n3OxR49Jgq12o
         wB4Sfyb5eImh0OPwgSvi49Fw7ddn8kVn5D5uIBFCDEGsYN/q2BWB5ez1Ycv728ZJ4xZv
         3Ipw==
X-Gm-Message-State: AOJu0Yz5XfC3oB40Mm/l+2bKTNc4JS9CnQflPRSuOev/EPfjKSAhqUtb
	vrJbNqIUR1HTG7lu/Kb54OE3THtyNYpna0BRhBHfOL67sodDaj3AY0hnN+gsf8PtNDQMB0RN3wY
	w0JRqCtRpZwviipK5eA6nGookJsQyVBnTMV4=
X-Gm-Gg: ASbGncsQ3XW0lyDl/d/B79SoQmjMsLYaCh+QckIUkBdnN6zctche1XJp2J7DA0/Crhe
	8UPfXeap+/Hn3R8/a63qfImzoH6qyrHB4vtagiqrFlCFopakH3y9fsFAugcV6kUM+VmZ6dJ7dma
	YnhOQCCQDgrHoKR7loHMTxrF7QI7C5/SrvcdDcl+yJeIIiXiN5u0UH86DwguE=
X-Google-Smtp-Source: AGHT+IFi5q4gE0Mg2Cb0WVtsLpHpLob8VAUW3HFAyPXEifnXwd2HKTT3Mf9IvJOzq4flnb9WeXAC8wM77OVOywt8Mpc=
X-Received: by 2002:a05:690c:c09:b0:6f9:9e80:46bf with SMTP id
 00721157ae682-700bacfc23amr274557107b3.29.1743000891785; Wed, 26 Mar 2025
 07:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com> <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
In-Reply-To: <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Wed, 26 Mar 2025 14:54:40 +0000
X-Gm-Features: AQ5f1JrFGcJKO_go_hszrWqOvwd4pr-9LVI_gBcazdsIwCJkluHfBXi78KEDGlM
Message-ID: <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 11:26, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> On Tue, 2024-09-10 at 10:23 +0100, Chris Bainbridge wrote:
> > On Sat, 7 Sept 2024 at 22:21, Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> > >
> > > It's possible that the
> > > HP BIOS turns off the wifi when suspended on battery power
> >
> > This is not the case. Suspending while on battery power and then
> > resuming (still on battery power) works without error.
> >
> > If the laptop is docked, and powered via both the dock USB-C *and* a
> > mains PSU on the separate PSU connector, then suspended, then either
> > the dock or the PSU are disconnected, then the error happens on
> > resume, even though the laptop is continuously mains powered via the
> > other power supply. It appears there's something about a powered
> > dock/PSU unplug event while suspended that causes the error, as
> > opposed to just being suspended while running on battery.
>
> Ok.. so that's really pointing in the direction of the BIOS or the system's firmware. Sure we made a
> change in the driver that is now sensitive to that problem so it pops up.
> Since wifi is available for you after resume, I think it's better not to fix that for the coming
> release which is almost out. I'll funnel the fix patch I sent through the regular channel but you'll
> see errors even with that patch.

Was this ever fixed? I see there was some kind of fix that was picked
up by regzbot but it looks like it was for a different issue caused by
the same original commit. I'm now on a different laptop, and hitting
the "Timeout waiting for hardware access (CSR_GP_CNTRL 0x08040008) ...
iwl_mvm_check_rt_status failed, device is gone during suspend" error
on every suspend/resume cycle (even if laptop remains plugged in while
suspended). I see it's also been reported elsewhere too, e.g.
https://www.reddit.com/r/debian/comments/1g7yook/iwlwifi_crashes_after_resume_from_s3_sleep_on/

I know the wifi is still functional after the error, but spamming the
kernel log with a stack trace and register dump seems excessive given
that the BIOS turning off power to the wifi when suspended seems
reasonably common.

