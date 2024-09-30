Return-Path: <linux-wireless+bounces-13315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D63989D22
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1930D2845E4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC914B941;
	Mon, 30 Sep 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLNQ0F8m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A941364A0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685919; cv=none; b=BNwcsuSPtj3/QYgr+XempOVR3wp14Bq0PARoESE5PgBAkQNZ5Zs9XJCdrIiWToA3O9gLYbpZXXKvFDrlYDNRt2rQ9LV5T8URQdr0UaSI2kXOyVNB57ZzV3VD6XWWL92uf5e+qGzKexWDjJSQa5kOQ2pZtn7CosKjseHqX2ukl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685919; c=relaxed/simple;
	bh=YtdiE0ER9ebWMUDh6CaUC2tvWMgZ88ivFXpidSVzPz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyv6EKlzumczpRzDgRvl1BseU204wo7YwzU1ey8KKF8Al/6TFuFM2z1ONNbG7GbwLh7l5cv6BCjgZW8a0lvhIudiTS/EVBhDtA0a0SaT6tdrcTUweIL6zYTag8CVMmJiu9WuTrMPc0b1muiiRwSIcXXMWsMKNVwAAdWIMQzfNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLNQ0F8m; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so404398566b.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727685916; x=1728290716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I/lGPCSbuIyJIsmteHQqKPwzwgdEUPdJgNlOfuPdWI=;
        b=cLNQ0F8m4FnOYk+43eO3LiRehUerMaVa8C334ai3GRY9eZu+Ya9PQ37ne3nGF9oQBc
         gz1CVFF5NbSyA/KSEQkVC8bf9U1o8QpMSKGIb+Jv25h71ECJuQ14arIklqiZmr4M+3P7
         wtj1iDv9PwO9HXtQjhA7Wg7rXhKEpu/KJX5HsQg8mQPPcSPxqeu64kLSwdBKAFqPgcR9
         i5VhyKkvP2w/bhEt/zOKPOW2JsihvuG45C5gLgPwrl0rOboqzbK+/MfIMLZCSWxcCgsW
         FGw2PD92sY77xytnJg8me5qkQ1NmMqvv0W1C42C2cIO953hFOgrqWir+MEZiKxGSgPeF
         Lfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685916; x=1728290716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I/lGPCSbuIyJIsmteHQqKPwzwgdEUPdJgNlOfuPdWI=;
        b=gTWG3SCiXYaR2EqiM4XM8Rm6slk1iDaXZLnehMocUit5VUPMBzZEGmHSQJOSi2hxX0
         e7prXVwI+W1BuddKp0DLtIaM0TyGJS8DP1rQwnhuqkgDnR4MyBTSkjZ+8dMdpmsEP7YY
         2ZnpAMv+/f2X/A/YarVbe8xwmY/sVzE7AtyDXtTRWc2UathViUcBpYtv1uhJ5nk7SZf5
         i5Y+4C47kaktv2Y92pJ/+07s5IyRJleFC9RRUIZGw4pkqFf0A8qe0ym1uRTHx8UiMo5T
         +8Y6OkO6Q7NmPMaZdLRHjZES11n/R2cuvQnUmU7xcbJoBLDH46G3zGvK8IYW9mPLdJXw
         cx4g==
X-Gm-Message-State: AOJu0YwlWY2/Mhth98TQPgcAe/M/MVsfUH10f2iNtDMsdT0IF7c/B45R
	1wXSp8vsgp2tBBKAQuDDGsrbAu7xgXKNMAXeYFl64YVmZk/ykV1PeFDXF2HBWeCVbEOqSB1790s
	OcP3F32cetssC4vtOoMHfbBr4ilRRhQGI
X-Google-Smtp-Source: AGHT+IFZzSCLd7/MCF7USN75uNQ0wZI+FbjfyoXU1amJOsTDB4gms/++Ii6xkR/4OklFeDYm+1PxFQKgA00Aae7uSAM=
X-Received: by 2002:a17:907:3205:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a93c496565bmr1194138466b.32.1727685916256; Mon, 30 Sep 2024
 01:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920011901.5038-1-pkshih@gmail.com> <CAGb2v65J1FV-POEh+QciWUxE-OZyRuh+Wfad9TuimJrrDHcjkQ@mail.gmail.com>
In-Reply-To: <CAGb2v65J1FV-POEh+QciWUxE-OZyRuh+Wfad9TuimJrrDHcjkQ@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 30 Sep 2024 16:45:05 +0800
Message-ID: <CAHrRpukWTimT_dRtdQwpX-RYAonWic1aE_3KMtEZ3bvr1+iW3w@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Tanzania (TZ)
 for 2024
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Fri, Sep 20, 2024 at 9:19=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > United Republic of Tanzania, Tanzania Communications Regulatory Authori=
ty
> > released Minimum Technical Specifications for Short Range Devices (SRDs=
)
> > on 2024 [1].
> >
> >  * 2400-2483.5 MHz
> >    - 100 mW e.i.r.p.
> >  * 5150-5350 MHz
> >    - 200 mW mean e.i.r.p.
> >      * The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
> >        in any 1 MHz band.
> >    - EN 301 893
>
> This also restricts 5250-5350 to 100 mW due to lack of TPC.

I think you meant the description below in Table A.1 pp. 88

2) Not required for devices that operate at a maximum mean e.i.r.p. of
20 dBm when operating in 5 250 MHz to 5 350 MHz or 27 dBm when
operating in 5 470 MHz to 5 725 MHz.

I was not aware of this. Thanks for the info.

Ping-Ke

