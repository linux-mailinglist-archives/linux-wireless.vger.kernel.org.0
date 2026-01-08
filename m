Return-Path: <linux-wireless+bounces-30561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5CD02B25
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2351130A218B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA94DC55E;
	Thu,  8 Jan 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAHJgCsb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622654DC551
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875165; cv=none; b=rsl14tvfGsZOICqZNlIwXmHyOsRo0ICIFQpmk35/Lx0wk/4l05h/tQjN5Kdrujyq9v6RPL+5yRutouQLKZ1w33zVqK74YE4uWGIlsbbCYm1K/OitYcwM58DZi/il2L7nCnUbhtipFqijAFIlVjPJHuInsdXNvPTjzoQmIgiWEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875165; c=relaxed/simple;
	bh=C/PxTgSERqJ6ILqTgSVsU+Sj2XkQpUudhpR6A9+mc9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQTppofHbjVQ59pJersIPniC5ay0vRiiK2JCEaEqBM3FID+gofKCwPbBDKVtBiARM4B3ef9BnpJft1f8GYMfhB/hR6No/TALu5d3je8lcn9Oc1wE6ryVr4t1T40jWjoKu/2pzcoOtAG5sYvhLV4oZFI475IlLzoyASGxLJfJVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAHJgCsb; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64661975669so3344034d50.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875163; x=1768479963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=WAHJgCsb05DN3q1CdpQz8DYDn3sRhH/hTCvrrYAKm/6sLDKBDNBI9G261T7ujH5CeB
         5Bvnk9Q8WRC+Gl4v2/c6BRxOWxviaHNT0GVmUw26G1uszDXOWoZGjM8QCtBQL1//WPTm
         fEv2XnzzDj8VhFekJiHO22xNmgx003o/XZbKWhdVX6SU2XEELInl6GxP8vv/tXxzPQrC
         YvE4legYXB5EwDUwVS250WYSgLCsSCmWXXp0beSzyKaqYEwCJYjB7QLGk/LaNjGB3X0e
         Ws3hCh0jtlo7CCnbpJ1bVnDGahzYj9oST7lcErARQIQA4DXsNbOjRc5YUo4jL0KI4Ayu
         SuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875163; x=1768479963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQbP6K4LtPm/3Bomj038VWToPwF1ZlmXIxpj9oFDKbg=;
        b=aPXuPkxaJxw/8Tdv6b4dDs42v2y962TN8BYBwSLjvZhjpRo6CbijsFwwiMePlxvB9R
         SMIJkqDbI8pH4F5RhrKRGvKIj8EMrUHskgjYWVGV02j9L9j1sfQxl8CqgSFBJiBZ8aEp
         xGqXVfV6HNuipG6+kos13UBarwUx8wuYH8p1cMaOIGRl33JvP9vOqAMFBH0E1Yq+Wu1o
         HiHDsyRiQ6NqmyPk97boIT8IcBxkj9hQXajhI5fKBbJzSdowCh6ek4ahfeFtJ6QYF4DA
         wW5KEM3DnSi07tkd/BBrg1wABlQJ7LFK35qEZGEsZsfpXAZtwP+IHs9kRNpT95NyhNvx
         QIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUslsGrm8Riungl22QSJy/Boxq/pLUtjcmAXtKmqiMLsKWTIDpoJ/DKf1COxuGFZpM/G5hcydbzj9VCGMkWSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLk31Pr8yqtAM3hehxN/ziuCaLSIxyuemAwQEPcN4VqN3TMESP
	GSaDEWQmbu3tQUWd9Q16RAJp7RSPCMOjnQ9CtehT4amcSLsFOCXgyjoVDsuH1a+0skSSH53gARK
	/YxBrtUzYPq8VAqYnDVSWy0hfl2Z3rq8=
X-Gm-Gg: AY/fxX53+66wQBOe2sbL2wYY92pebqGyXxYYj9G+zp2DzAJnw9bpF7RIpgh2Juc6EQ8
	TYHN1VlGZFZv5wrNIVO12IUC4q2i9VAIGEUhZW1CuycKSDHjDV04MBail3kvj6xOM80Z/HW1lu/
	gqeOrj7ZRH/p4zoGYh/x2WbF1BfriFLcLiY4+UQSGwB6uEwlkfJ8AmNwAsKlbKB9PtmEuqs0M/G
	U1DjjCTKrSWO9VfZicgiIcYUc7tb43vPXvjT9YqOnsALjB1ja/rxUwf4LhjTYfX6i4FlA==
X-Google-Smtp-Source: AGHT+IE2yzRR9td4dYr8beCMOnr5E8Sv8b+0e37MZp8Y0hPbwVCOnvmprBO2NLzwb4jJvdl1Q3MsdWRhtLD5I5wdK+g=
X-Received: by 2002:a05:690e:1183:b0:63e:1df9:c895 with SMTP id
 956f58d0204a3-64716c50a58mr5519645d50.66.1767875162887; Thu, 08 Jan 2026
 04:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101927.857582-1-edumazet@google.com> <851802c967b92b5ea2ce93e8577107acd43d2034.camel@sipsolutions.net>
 <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
In-Reply-To: <CANn89iLxDc9viP0Pmj3uC01s46eUR2xu4XAUEo=he-M84aCf9A@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 8 Jan 2026 13:25:51 +0100
X-Gm-Features: AQt7F2pvm4NEm6VrnYq0Y5B6J_pXuAY_73yxlKUTPRwclpCUkgoqjALp_DmIhpM
Message-ID: <CAOiHx=mWrizoJAOU=40NWk6A1+b99WCM1EkxVwLfiJ8Sv4pDKg@mail.gmail.com>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
To: Eric Dumazet <edumazet@google.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 8, 2026 at 12:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 8, 2026 at 11:29=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >
> > On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
> > > struct iw_point has a 32bit hole on 64bit arches.
> > >
> > > struct iw_point {
> > >   void __user   *pointer;       /* Pointer to the data  (in user spac=
e) */
> > >   __u16         length;         /* number of fields or size in bytes =
*/
> > >   __u16         flags;          /* Optional params */
> > > };
> > >
> > > Make sure to zero the structure to avoid dislosing 32bits of kernel d=
ata

In case you do a V2: dislosing -> disclosing (I assume)

> > > to user space.

Best regards,
Jonas

