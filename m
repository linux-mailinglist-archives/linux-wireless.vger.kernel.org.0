Return-Path: <linux-wireless+bounces-22796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140FAB1AE0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1B4A20FFB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F17230981;
	Fri,  9 May 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZdTkC2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B77231859
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809391; cv=none; b=ukBjXnsov8+zplnIgAf0CaG7YxyQ78zv4rBCvBVPpC1fKQTADKdns0gKdcg6tho2wkKwIJU7KcM60locIcldlEXkNoZO7wnvI49OX3zM1M+30qOSTbGYC2sPkCMb63FvnGT2ndKyc0I4gMOaHgOcPbOb3GPhxNJ7JIdStU9XdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809391; c=relaxed/simple;
	bh=1xu5LZUoBbfxw1eTbj+EbiRX2w96mb17HBTdADCKICE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9ZetIq4VPdkEWuOFW1Gab7yu5glR8Cg+kw+kAx1IOXWBVfrljaOAn33tcsFA1Tp9G4pmT4my8yT664Z7NIcrOW/w8FVCMWAfkUF8MKBkEMS9c7XNqccq9lAXzyl8FVJikEcHHDqU0ZkjdAzHCgb87YtH7RH9WWNcAaGVyW1YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZdTkC2Z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2963dc379so372945266b.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 May 2025 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746809388; x=1747414188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH/i1EzR1Piry5ma6cW+tHzXDGyZFx9Osy8SmIxpHUk=;
        b=NZdTkC2ZRaRP69KpH8PwneFOe9SOrgtzJY604CXHpQpuYa+D0gkDjQFxUqJzIgMa7K
         nQtBSQ6LOuaA93azKoOocDZuz+vIDYhtJQxU/DyCBbBkJunAhtGWDwNi57+jhy2osjXz
         T6VZVZK1Ilm41/Qzw18Ecppn1ejeLEEeU/v2eIL/RmC1ka3ks4nGYTyCBh+zar+aysbI
         XdD9Fs0krbLO66Y4knDXwG3b80nwFf4XucllpD5Ing+f/IaTtWRZBR8dWnohjvp75MBK
         7kk+bsQPB67ye68Qrzhe2awwxjJWZXwip71sjqQYM425DuVlEUJt0kzsaTOEini+2sO8
         bcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809388; x=1747414188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH/i1EzR1Piry5ma6cW+tHzXDGyZFx9Osy8SmIxpHUk=;
        b=XodY3mAIgzvG+dA58AXL0fP0hRg9AGIp7WJWlPJUTG+XjIs0TrQejlA3PuuEONVXRL
         SuUALvSuVrFpwYbL+JnvBbJSc0GHUZPWnbLoCgaTkI99EzjIa7o4hKnnkVF/DQEbEPVx
         UdIkqgagVYmcGGJZc677hQtbRhzIdX+Enan3mZX8HkqrY3M4GAv/fEVi31RkeFH6FORZ
         RmVh7BZXUxWTYAqoQ2rh0P381k01dw8H2yn9NbLxnn6SBRjmZfdLw7PUTSvCWUju6E8y
         nGT43xQ31rRpSih8qDe3BkUwS9S9HjksMUxVnwL+v1iYRerVtNCE+2zEl57m6UmWDT3t
         LeXQ==
X-Gm-Message-State: AOJu0YyCENXIOHZDg/0g4hhkY/tMP/CKLulCrpoMgTvGkJug4HRCz1VI
	qn8uiPCC7ZQf4id55Mm+yYimxo6QLh6DXPWe/8HDikuNKp3HDcUkUyQPr7kbWtZZnlc5Uz/OlWF
	qM+xRJPZOtCTWYnjJvgqX6OW4OaFyOgMZ
X-Gm-Gg: ASbGnctQO2jDXQM/pHrfke9LMiI/irtYZRw/emq1hKBH46Ejjk5o8Hxgdu+FELrVL1i
	7N2M+DucNtatUYrnCVozEPagPNAfc9mQxwTNKdAxUdo2JiXqC43Bvd3yMernWCqyqTKXvV4RgS8
	qDVwjhVV4D5ZE7RfEUzsrImQUtJjoGaGzwOC+78Owbl40LIsQhTeYINw==
X-Google-Smtp-Source: AGHT+IE6Y9JA3FeCCg3xNTCSzxPDhd4HY3teyOze4aDpX/y/vBzSyDMmDOAeP62j2eev2bDE0LMvnnzNgCB30Y62oPA=
X-Received: by 2002:a17:907:d16:b0:ad2:3616:8c33 with SMTP id
 a640c23a62f3a-ad236168f2fmr4791766b.27.1746809387845; Fri, 09 May 2025
 09:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com> <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
 <ae5013a930574e68b96544df82f93157@realtek.com> <CAD+XiyEQPt9HGngt0XBB7Hf=0tDHHcU+3=E20vhPnC3VL1Y+vg@mail.gmail.com>
 <31b6571789b34b95aca2bca73dca2d62@realtek.com> <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
 <f4355539f3ac46bbaf9c586d059a8cbb@realtek.com> <CAD+XiyGWqu6TA==PBZaffnsABbHFycuzQDBKE4mBDWPOw9fx7Q@mail.gmail.com>
 <5f46a63596734dc1b2287a0ac6f2ac8b@realtek.com>
In-Reply-To: <5f46a63596734dc1b2287a0ac6f2ac8b@realtek.com>
From: Samuel Reyes <zohrlaffz@gmail.com>
Date: Fri, 9 May 2025 10:49:30 -0600
X-Gm-Features: AX0GCFsk_-DNpb-TH_Lp-ZnlLUjUc68wcGelT6iIEG5L6KrsjubP2qywQO4MOBc
Message-ID: <CAD+XiyHuFOanmyxh08w-Ra2U5iQo0nA8pepCk9Ns=3CJ_t9bKw@mail.gmail.com>
Subject: Re: RTL8922AE driver issues
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 1:00=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > On Thu, May 8, 2025 at 6:38=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> > >
> > > Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > > > On Wed, May 7, 2025 at 7:23=E2=80=AFPM Ping-Ke Shih <pkshih@realtek=
.com> wrote:
> > > For me, these dips seems to be acceptable. If you want to dig further=
,
> > > I should check PHY rate first via debugfs:
> > >
> > >    cd /sys/kernel/debug/ieee80211/phy0/rtw89
> > >    watch cat phy_info
> > >
> > > And, capture video as before.
> > >
> > > I admit this is only first step to see if the symptom is caused by
> > > PHY rate. If yes, I need air sniffer to know how it happens. If not,
> > > maybe system enters power save mode or others.
> >
> > I agree, they don't make a meaningful impact on my connection. For the
> > sake of getting to the bottom of the issue I went ahead and followed
> > your advice. I recorded 5 of those dips, they can be found at the
> > following timestamps within the video: 2:45, 5:40, 10:47, 13:12, and
> > 15:50.
>
> At the first dip (2:45), the RX packets drop to zeros. Others' PHY rate
> looks normal and only RX counter is smaller. Seemingly it isn't simple to
> address problems, so I would like to stop digging. How about you?
>
>

That works for me. Thanks for all of your help!

