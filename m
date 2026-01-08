Return-Path: <linux-wireless+bounces-30538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD7D0400C
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799FD3120D4A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DB3A1A23;
	Thu,  8 Jan 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYI109jR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142843A35D2
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868343; cv=none; b=eU69kpve+8o0V5F9yohIG3KK7vAfwBp31KnnrfjXMlBNzwlZnh0RNx4VsoSHbbQTDTIPh6lEJhBNJwwAhXLdCyjuR6AbdFKH6ExruOFc7/TLZxlqhUhoX/0o7JKemRcpE3ecUmJ4RhDURWCpT1q/pnhQoeAG05lqzoWws2qJzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868343; c=relaxed/simple;
	bh=R2K+i1sRQKmSf8yyiZ0axORAp9DYHsv+qjGYYzdkAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR3WjkDrrWgt0c2bNgTzbB91QJSH03JIfHJDylBotXhC25ds+Uvcfa19f+M9pDpGrKSXzOZwIj5d8OSsCiUVPJcItHANoUmCUOwyXOT3ewflmTOphNMoK2Gr93nBQhdakhW01XSRmLQ5NDh8STwp9YhMhAvtPkPQp9TqjJoK0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYI109jR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4fb68720518so30644321cf.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 02:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767868337; x=1768473137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=WYI109jRM4F/eCVbKIWmEp7Ozmw8Qmb+0LULE++Sn16pPCOjjoE3k+59AXapKEsYiZ
         2wPf4Mlaipiodl3TjRwi8Ti+Etwooye5O6Yq0VucV1mZw9QLpJUbcQKVV/gEflWSv71U
         9aKEVt0N4jf1tRfcMjQjY4tnVj5PYzrx3vh+hIr9K3kqRqvJDjjBru8T0GgffVtEFmvx
         hPFOcxT4m4DnYD66aqP+mIZaiFjH8HVF0684vvFuZU9iWgjkc9FzuUUi5XQT165yKu4G
         KJ//tuwWIGV4hp4AMeiit73tXFIxfHZ82m4XgYYclPdetGuXbSsylP+zmo1dQ5kF4Aik
         bpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868337; x=1768473137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok3n6452CCn2akqoUJ4qnpNLPbUKwpWUXAR9kiMAF0c=;
        b=mHrOPxXDzOKgNYlFHf+YGMSy4LgweINQczk4c3owuiY3Oj3aayq8Va5+PI0i7Jsrr4
         59Flb1yQ7Jgps2vhd8Gy8QmoW4bgHymp6TcWG6wyMHrr/qnmNxiexyTeRTm1+i9n4WYj
         TManc1QriocMILpi7XAEge8UFIvgU9HN8+Ll1auhAmC0QYoE/pNO6VvkD5oJLyEu6zNl
         ye6/5RDI1LLRxKyV8Soe19Ri4BgGtCQ21NOPEad1fLoOEFOfQvEv/66Gg2TgYKe9Or8G
         7SbrfBKkfJRb217te3L/x0TfO0Xtw38PC0mE/xoYvHCRxQka7xT7ax/OiiZMT+QDAcze
         3Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCUKbL4eUEAgDKaLDjuP02Qmb4oDuf4vrz006XZtNc9butxDSUf9wRXgOgc8kE39KehZwPrUvdG84MIj3NRMaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OVQLPyXvNy5hrRUiQYA1kQ1sKr2+35jd6zUiL1OM05+aMSZU
	Mmug/LaeUyLryi2rMUIdA38yxSPn8fS77dezfax4x/tvzeUzeCLD0ezs/QWV25+9a5/+BY7rJ0J
	TQ6vEKHNW+l7ZkL5hI2wJHkKMIay0wTNvHDE1AjXv
X-Gm-Gg: AY/fxX5f/5wWssO7kLCZyB4R1kLt8JK+coSVG/mBP6XUegkROoHJTcm/3eNvzCESmAt
	kdQKfakfNTXAAVY62F7fgtlMykRsE5hhb7qpqw71a3phqLON22JkEJ6X5GA/B8p2OFwx44SJ1cH
	5NPUDO5wYPHbER/M8VqwnNHYTuwUTKcEMdx45NakLHHvZt9e6dJa+/EiW4KIgu4h5XgpdUBdhtF
	jodGAhppptldMJsMF2C++R+WYE9ejhX8qhAZX6fg9208ORaFF82ipOWjHn27LixuH4vCA==
X-Google-Smtp-Source: AGHT+IFY03QOD+rpaee6JMJz5V1Q+LtZHzyW9QYCkUaj/PQGgBqN8ctNNUwKRAG43fFXIBU1U0KMnEepQ85YQps45bM=
X-Received: by 2002:a05:622a:248d:b0:4f1:b1f5:277b with SMTP id
 d75a77b69052e-4ffb48a8654mr78118021cf.23.1767868336738; Thu, 08 Jan 2026
 02:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
In-Reply-To: <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 11:32:04 +0100
X-Gm-Features: AQt7F2p-y5UbYRv-TWHGNGwam1_iRtt3bbPJlg6n-RcD7sW7wTP_mSOnZxUlj-8
Message-ID: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > struct iw_point has a 32bit hole on 64bit arches.
> >
> > struct iw_point {
> >   void __user   *pointer;       /* Pointer to the data  (in user space)=
 */
> >   __u16         length;         /* number of fields or size in bytes */
> >   __u16         flags;          /* Optional params */
> > };
> >
> > Make sure to zero the structure to avoid dislosing 32bits of kernel dat=
a
> > to user space.
>
> Heh, wow. Talk about old code.
>
> > Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
> > https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google=
.com/T/#u
>
> Was that intentionally without Link: or some other tag?

Somehow the Closes: prefix has been lost when I cooked the patch.

Closes: https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@go=
ogle.com/T/#u

Let me know if you want a V2, thanks.

>
> johannes

