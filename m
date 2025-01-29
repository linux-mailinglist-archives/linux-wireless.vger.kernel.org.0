Return-Path: <linux-wireless+bounces-18125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAAA219CC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330BC1885F34
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2A19CC1C;
	Wed, 29 Jan 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSQ9L9RF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9B2D627;
	Wed, 29 Jan 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142623; cv=none; b=WFA3G1tYsEYPJqsMr9Bm0F6bhaNRAOWeVQxlc9hRmpwXuVnhcyLTv5mdVsvZcptSY/tBr2a4/z9dHxztbm0ZuVTxauN18AfBVPR70wfmF4llZ5kZoYhMjaIjjvngS5J7XwOZDbTj/Wn2jMSkA0Kwxo6315F/uxVOyXFHQolT/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142623; c=relaxed/simple;
	bh=dkVtFYf2MVcLNdpgF/1FM6AyzPrPgahv/4qNthU6GjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVLb6kCSI7CgPDUs3ee4pjGQjuEqCP4U0Bi7+miwKZ1DZ8h8rMpUzitMUK4A8YghgoFHwMPxClmVtufIAo2qBxIPJFKs2HXp5qzq504R0wQsBZoUzeUZrPf6Dyvf0VDYrHboILoz3siFbWNWo61gSNkGuBwVrnvo+8/Pg1qOGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSQ9L9RF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so778413a91.0;
        Wed, 29 Jan 2025 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738142621; x=1738747421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkVtFYf2MVcLNdpgF/1FM6AyzPrPgahv/4qNthU6GjE=;
        b=NSQ9L9RFQT82wLnGeX4dJ1uMMDCoS//drFxcOa4XQKorSv7OMvT8ra//Ke9Sf6OgEY
         n4ynuF2aTzAhjZC2pQ5YgDs8U5rr0UjQCohxVcCwoj+e7JCInEtllE/+CQg0A27a8Dco
         eHA9RVUu6aJm7qdLo5pgxjyIvZYoeyyXrVaw2w3DWve5eCqD6iwb5caziJBuLAikUmX7
         Ftl+BL8AlxdYPnro3Q3aVu7vpOYgNiuu9wf4s7NjF2SnOey7mkT7kJbPklYeMsENVbwA
         kU4Zc+/xkUbWnHiG5Dypql88P82OPj6zZSXTUGVp424BADVXPLE8qP0EHTTPUgNbcYDM
         ibzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738142621; x=1738747421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkVtFYf2MVcLNdpgF/1FM6AyzPrPgahv/4qNthU6GjE=;
        b=BgizHuMGH4JXOyZRpi8AV8VIvK9gavIL8hWT1fekVTDIroACo0YhFGHp4KUmimWkRs
         ot8dKFdNtC/c3JAn2ocoPwHmP/qrcHowRNJV+kP/Lom9HmGaABA1SUAZ0wyI3ohiHXYv
         AdFZeRKQ3uUaSfDaWa0b0WFvoFSRE7ElV8qjFM4T2xIbrBPkX8oxzZ9PD6LswJs5TDNX
         RigZbaV3YS/a1QbKbar490kD//ZCuiJcF+XmpqzkaJNrXWyDZuc8/tl5QaNPEihusUPT
         DRAcWWsZ93kpdeSPwdq7879JxzQ3ws/edyiKVNzAm4GSwYPkacqZ3t14qfjn6PBeru3k
         F0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUVMSdYA7/RCk0nL5np0Qr/NCOlqlH7QFNh5WGNVeQl52EG3cn0Ow5K26z7T8AkA4djDx7ND9Y+vcMk/qoYfg==@vger.kernel.org, AJvYcCXvQuzOtFzivK5O9gG9NYO/0F6Vs9P4SVB4tDQXXlVQstEJ9MagaYq9lYGxSMIPW8OT0XpHALHG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7/sKy53SCyGjjwMkVBLBvSroskKux/ZN7SvAiCZSATPaPqj4
	9auReLJU9YQ4WeIsoj6AUwXOkfimJL6BFwpOa6SpwQmcEXQ5J3hhQlwm0Ou06WOM78B4vKkyTo/
	pfeiLEPKJkHrlPG3XYRWrwGWGQCc=
X-Gm-Gg: ASbGncuA5xeMaUNR5DpI/wghGOZnwrqMaXw1Qmy8KUVEQleq8uw6Y8Vjjiq06smwc+f
	o7JQ4jt2MtR/IS8p55p2UBibUSqxUDsHsT89E1b8GgjuHJNKLPAd+PyYM/jpk76CUthK0xW9NnA
	==
X-Google-Smtp-Source: AGHT+IG0NT5+Ebjs5FpztVqBT9QwuXSYNyzgvElMDH+2iRgo6k0KnderKKdowGTHlRb3LEKlUYgj7jqgzgwCWWUfrYM=
X-Received: by 2002:a17:90b:4ecf:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-2f83a05c569mr3598722a91.9.1738142621531; Wed, 29 Jan 2025
 01:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87wmefguqt.fsf@kernel.org> <e64c416a975d8fcc4e245db78f31b0daef358e89.camel@tuxdriver.com>
In-Reply-To: <e64c416a975d8fcc4e245db78f31b0daef358e89.camel@tuxdriver.com>
From: Emmanuel Grumbach <egrumbach@gmail.com>
Date: Wed, 29 Jan 2025 11:23:30 +0200
X-Gm-Features: AWEUYZnYaDjc0TciMfJF2gwFNzQ1rD_qqkGo6wdKEgYfWf7G52X1E5mNencBTLo
Message-ID: <CANUX_P3Z2qQC1+SwqqczrQx-9_EOBwDnh-KtvkGFf0heJ81AXw@mail.gmail.com>
Subject: Re: Stepping down as maintainer
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Tue, Jan 28, 2025 at 5:18=E2=80=AFPM John W. Linville <linville@tuxdrive=
r.com> wrote:
>
> On Tue, 2025-01-28 at 11:20 +0200, Kalle Valo wrote:
> > Hi everyone,
> >
> > I'm stepping down from all my maintainer roles. My first commit
>
> Well, my friend, I suppose the time has come for you to move on to
> something else? I truly hope that something exciting and rewarding
> awaits you!
>
> You have done a great job in this maintainer role, and I am very
> certain that you will be missed. Few people realize how thankless such
> a role can be, but I do. I hope you will now have some some time to
> enjoy your sauna as you consider what comes next for you.
>
> Thanks for the job you have done.
>

I think we met only once in Seville in ... 2016..

I also would like to take a few moments to thank you for the work you've
done for us all. Just like for many areas in life, we take things for grant=
ed
and only when there is a change we sometimes become more attentive to
what people have done for so many years without being recognized enough.

Good luck and I hope you'll enjoy the ride of your next adventure!

John, I think the last mail I got from you was when you stepped down... I a=
ssume
that the equipment that was considered then state of the art is now under h=
eavy
development as part of your vintage hobby? ;)

