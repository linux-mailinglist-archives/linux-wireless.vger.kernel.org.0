Return-Path: <linux-wireless+bounces-16470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1A9F4A80
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D137516381C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABFD1E0490;
	Tue, 17 Dec 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPKIrhWp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82B156644;
	Tue, 17 Dec 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436877; cv=none; b=sJlGHPJ1Yey9KYC2m+ItAi0KZlk3HxlyXSnlMV6jUAq1ACq/yz1+hs+3opYNiw3GNga2/0VjUAw+fF5lB6/NKYVpdJoQHYLaWFsj8Kb5dVZeGx6qpJ7RDYCA19cI9ZHKYWwwcEFASfIWz4Dqt+iJNCymjH2xGGMExMnHx0BCg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436877; c=relaxed/simple;
	bh=VoT3semKVuV2WPFaeaRZbL6iWWm1byKm0Re6hZoayEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brXyqt/D9lNWTzPTmdzBgPQVJJ/I53/BvDphwZCy2u5+NPI82TGfDwP4ZcGHoBsBqPQWvnoQSzJ5Toy10B1y0g/xYOnEvBUtdnq53YKqdLvAl336vAlWWhVJWRxvxUrFZjpvOe9sP/WDU4xv5C0fdi8mQe9zVRv4Fzkuf9oqlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPKIrhWp; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so45321576d6.2;
        Tue, 17 Dec 2024 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436875; x=1735041675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoT3semKVuV2WPFaeaRZbL6iWWm1byKm0Re6hZoayEA=;
        b=LPKIrhWpcdJrzNtBogbpK0CzCmYE44KTJqVJLYN4lcJ826elsz7tGsQhUYV3+UBDRm
         Pn53rh8G2rkusHRodi7OrfxpjebaIL/K8LvVVtjgcQ4VE9g2glwIZrzlx8M8l+GHekU1
         +kIXscKvVQabj9Boeq8qPmrZmhXEaodTU5/B4sXULolCoXhWgiAni+bDJO8DeQygg2jG
         NjKTI+dmizI4+aXTGZXxW1nP5UQxpxJAc1J3BhT8WyqmmV8kh6riSwiXTMa5IM+4DNne
         xY3OoH6OiNIQmCflT9aS9SllNZntQ/umeaKx9CfhTgAw9Tmh/IfioCLkTiNXwHKNa6om
         ajVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436875; x=1735041675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoT3semKVuV2WPFaeaRZbL6iWWm1byKm0Re6hZoayEA=;
        b=OwCRdCKa8ZmSIZ1Oc8v+0WQpzlx6sldqrHogyHYLtgEGAQoliKUJIYjQMS/LvebKnX
         HDS3BJ9zivIlQRoZ/TQhkAt9YR1MF8W6KzHdYwvMnqo7Zdo+v4Fd27Z5cD5F6rB3qKSt
         Dsw+SYIQX9V/BxjCvO7ynRRhpodvSRvbgGARiSISWMzbhHoTd5BeDpA+7Xh65XtF9nyd
         85h0/cGhmmQC4I5WWC1QeimEkSwgSe7BsmLq+gn02lWYJW0l1AIx37Eb43qNBsjrSPM8
         szhp8Otlkl5/bhxef7ffkbrs0lzBLXPbSnSg/PrhVzOiDZ0x/4kPBJrPwLufjKKuJ8/M
         5RmA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+YPY44FjbE9kGwnPcul8JkRNGuhSwsJDcHujOd2d3UQd1SPFIqpJPD2gpYNOixGIeNsF1qXE@vger.kernel.org, AJvYcCW0NcKngHRlrJEaeAkYKPG03hje8ElAOanukIrPhyzN53KRm6ZPSoy2Xbpjp3UuQC24588OXPXybHuBMZD9Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4MS7ZaTz1vp1P8KvHeip646T6/ETh2FDx6KuGnwDkqaLnfcN
	3p/a9WQqD2skxrEGL5tveZOfGVedzTnpzHU1e6QcejZMuVgmnacK4lR6KJgUwLFq69aXHEwhCG2
	Gl2InXy2lS+gFbd1U8hImGQfOw1w=
X-Gm-Gg: ASbGncuZg2ZhtP3vcHsiHWcXWklhSSJIsKhWnkpixeuzELjzg8HBnPwKsEP8ngA73zn
	IDgXcUEF/uOnTb43E8yVTkA5LSkqdnUD1ZFD3n2lGlpGMPN4JQ3It5VCwcnaJAz30nIU1csUH
X-Google-Smtp-Source: AGHT+IGPuy8kYfgkFw1kFHqZNhPUceVl1N0oAa24pT4dmlIPic9KYVclc86GEDfDJ+PUKE/ZAGlPoOp1PylTwRMSwUw=
X-Received: by 2002:a05:6214:194e:b0:6d8:accb:5a30 with SMTP id
 6a1803df08f44-6dc92299967mr323292606d6.36.1734436874550; Tue, 17 Dec 2024
 04:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOyWgJW-WAd+GhT07zd2Y3vUWz81+pjbZT9nUAsCc7FGQ@mail.gmail.com>
 <b27dc4d0c3456c6796437b26b887b931d9871977.camel@sipsolutions.net> <de5d98be99086a7182ba2bd0676b261349a145c4.camel@sipsolutions.net>
In-Reply-To: <de5d98be99086a7182ba2bd0676b261349a145c4.camel@sipsolutions.net>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 17 Dec 2024 20:01:03 +0800
Message-ID: <CAEkJfYP297P=RjvZ9-ctpYHXu7bDhVN0+ZBoMNz2xjzyqOakLQ@mail.gmail.com>
Subject: Re: [Bug] Deadlock between rfkill_fop_write() and nfc_unregister_device()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, pabeni@redhat.com, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, davem@davemloft.net, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:33=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2024-12-17 at 11:46 +0100, Johannes Berg wrote:
> > On Tue, 2024-12-17 at 17:33 +0800, Sam Sun wrote:
> > > Dear developers and maintainers,
> > >
> > > We originally encountered a task hung while using our modified
> > > syzkaller. It was tested against the latest upstream kernel. We
> > > analyzed the root cause and pinpoint the kernel crash log to the
> > > following two tasks.
> > >
> >
> > This issue has been known a very long time and should be fixed in NFC,
> > but I guess nobody is around to do it.
> >
> > https://syzkaller.appspot.com/bug?extid=3Dbb540a4bbfb4ae3b425d
> >
>
> I think this one is also the same:
>
> https://syzkaller.appspot.com/bug?extid=3D9ef743bba3a17c756174
>
> and that's much older still.
>

Thanks for your quick reply! I am sorry that I didn't double-check the
call stack of historical bugs reported by Syzbot. I will be careful
next time.

Best,
Yue

