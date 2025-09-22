Return-Path: <linux-wireless+bounces-27576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10950B8F66E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117F31889CAB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C24245006;
	Mon, 22 Sep 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzS1RNse"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195642F60AD
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528323; cv=none; b=imFnzEDJRD1ylzCPiNlxcpYUft75llC8PqToMbQSXjEMc1kORvWeT3bz5nOXtb0wt3kG90K3qeQJA0EMkNMuWWB1rK0GzUuKhfNUY+DuVuT2uM1P6V68ukTmvZ+Ibom8DQvKA4Pgr0ozM5g8Y3C/MZd8kBXXLQK3VFy9FMlB+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528323; c=relaxed/simple;
	bh=HTNUj1N4/rHopqWeYeINmgos2Syd2I3wUp8ZHmKexyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvjup2DOuh24uUcziYX8OUOMFzX9kS3CRE/m9RZ5LY7DoMG++GoDnzvvLlDVPLZN8iLr6XI7mN0Bq6olw6rDxwGPNcPLwgEvYLBQwgutAxtJky0KJmrdtv/WWyoVJqLn6COpps/13KwSrZgZ3hffMmXd1TcBn8PycwMIQVMSEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzS1RNse; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-528a601a3cbso2689486137.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758528321; x=1759133121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oahqWdT4eJWKdEhecbMn96m+F3MRAL5sNNVQ7KistOo=;
        b=PzS1RNseVtbB/+OVIp/r918boCcEcaTxhNt/T3Bh2Kwuq74GzScJ5Ooz8Jo6NS/+bE
         Z4zQhEB1c+6HremffrlZFxVyDQIwJ4KA9S0UhK0Cd/DmI3iIP8Fqm/r6/1rcbC7BAqCE
         DSgvY4BEx6qNbel+03KuOXQKuUqYZEXoU39Ub6ODXlpGRDJ+6lO855b5ZLdOvnxccUee
         6i1BQNnzAn/iAyV9YuVnQbU84X6ywoKgGamAqkEYMsztFavBZIssKvoIsdw7RIW11XAW
         nG/7qFv4pG4fdnKqhzLYC0oH96pbymF1GUD8FSz+r0iF/EIk+OWwNuzWviZjmDMCp45t
         p9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758528321; x=1759133121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oahqWdT4eJWKdEhecbMn96m+F3MRAL5sNNVQ7KistOo=;
        b=RDVZFK/mjEYFOOHNuaa5ItNGBH++1bO7tAXinQQkmi0ZqcrZkKv1A0yunCjR4zgcS5
         6Lj/fem48TXN2CQFNr8znUTRFovswdZilYAEXmfqYgQs16QWDnDx424TYQbQWwkap5OS
         EkFAvke54IDiSSAtBgAjK3puR6+TR42IWUjUldV8+qLycxSp4VfxYOI1EzbQbKRzyzcj
         unAS5W6z+pKnMrrOjbzJg0Cmv2NAhvOcZycKpx1vlrhC3defOnwJ3bzQw0XfHDSJqWtM
         YNvqHNuUi4/2hNPBSOOggvilfrIaQeoAwy4jhT8Q4DfRDXIZoAqIbLMDQNBQgV3xqk/O
         +Vxw==
X-Forwarded-Encrypted: i=1; AJvYcCWfulbtuQ22yd1v6+DmCE7sW1Or5T8fyZ9SUJVcBjouoRCHqvHn4F+XEx4jgIdFeaSox6ZSP3a6+TG2mAAVUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxxIwXO77G2L7gtRzqDOxfo0C+Eyj6Zi0cO9e0e6im6YAUFTr
	vAN9edNi1ysizCMfEoXSWccp/iZahFg4Ut0hdvLHWzQhEbbAfSLhAvVvAJofkB20xLArAhfaGNm
	64LAzPKgWc95qnc/AQ+ThRw8ITvUuzkAJABSmdCpMeigELKTmrcJrfaT4
X-Gm-Gg: ASbGncv2SjH9graoEZwg4Gk9r6AV4bUnbf+61F/nBJ5q/s2z2t3J/m+zt2z/TerIBF2
	hz+g6waVgilokESZse4nPftK9p8zmTSqeQB53roLvZ4JlUSVLemhgIhB8e3Vtjf9DuOWDsuLeFO
	TlAObF91M/WJ5UszQdz5Q04Rs20Ls/g0GgwU2erVavk8+gYwdoUsH3IVXxa7MGxjQmTbDNMtGxv
	fDmMdAXjLbQE1g=
X-Google-Smtp-Source: AGHT+IF8RmArNn08xqgz2YL++Bkd1waSXT6QYxQLrepHMkn220jZgScbG31ZDE0t39Xo6Z2cBJvnXWgH9psMC4tPY90=
X-Received: by 2002:a05:6808:4f1e:b0:438:398d:b262 with SMTP id
 5614622812f47-43d6b72b33bmr5873578b6e.8.1758527901672; Mon, 22 Sep 2025
 00:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ce3c87.a00a0220.37dadf.0025.GAE@google.com> <2ea0ad29b6956b7d5b812d688b9676e1824dad30.camel@sipsolutions.net>
In-Reply-To: <2ea0ad29b6956b7d5b812d688b9676e1824dad30.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 22 Sep 2025 09:58:10 +0200
X-Gm-Features: AS18NWCEcgDFLsPjMsqTcyYqoT9kdjid6s7FWOmr5KWPuTbUV7k9nx3w9J0JWwc
Message-ID: <CANp29Y7T6JRHjMDZZN9UpcbJB0vwkuq2pJv+54VvFJRh5NXL7Q@mail.gmail.com>
Subject: Re: [syzbot ci] Re: wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ
 flags
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot ci <syzbot+cib69b4e10bd070489@syzkaller.appspotmail.com>, 
	lachlan.hodges@morsemicro.com, linux-wireless@vger.kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:46=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2025-09-19 at 22:32 -0700, syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v1] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
> > https://lore.kernel.org/all/20250919122325.f0abcf092b9b.I04478fde87a79c=
7909f1cc4249430deaf71e8bd0@changeid
> > * [PATCH wireless-next] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,=
16}MHZ flags
> >
> > and found the following issue:
> > kernel build error
>
> Hmm. I don't know if this is really useful? The 0-day bot does similar
> build tests, probably more comprehensively, and
>
> > tree:      torvalds
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/tor=
valds/linux
> > base:      f83ec76bf285bea5727f478a68b894f5543ca76e
>
> unlike syzbot, I'm pretty sure it would've known not to attempt applying
> the patches to Linus's tree when they were destined to wireless-next.
>
>
> IMHO there's enough noise already, this only adds to the noise, not to
> the signal.

I'll drop reporting build errors from syzbot ci so that only fuzzer
bugs are reported, thanks for the feedback.

--=20
Aleksandr

>
> johannes
>
> --

