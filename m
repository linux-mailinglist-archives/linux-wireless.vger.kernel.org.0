Return-Path: <linux-wireless+bounces-20455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42BA65A81
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931581690B8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15031A264A;
	Mon, 17 Mar 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3mS6RQk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799F1553A3;
	Mon, 17 Mar 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231976; cv=none; b=CrThQh8ad3N6ylzKAAMpSdT3lJr9lkQ7KK3NY4izlZV42xSV6F4vO4XhUozFdT9sf4jpLJKKofUtFHIE2ojpASRPQ2l2ZFhd5BaGhqJNQWb7GngxJrPwUal7KWILnN898OjH7Ma8V+yhpZDHFX4Br1vwK+z6RTBx1c00Qn1Pac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231976; c=relaxed/simple;
	bh=ZEAT6RFypcPN7L/ki3+46/Vv2kxpEG6Ybgc4eh+vFoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtGgay0RFJqrYeFUrtwtNTf7KxPg76i0riomZPf42sbEAYYtinvHbUM+PhFKrIIH3EVJxJJaoxvV8Ai02Xun1zzz1e45fu6tnKETYGm1Sxw00C3NCCzenQHNNCuMKBrsJDL4dgZ5wlQ5mnJ1sJkNLtaW9pr9Ta7JijwGIimZ4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3mS6RQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA0FC4CEEC;
	Mon, 17 Mar 2025 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231976;
	bh=ZEAT6RFypcPN7L/ki3+46/Vv2kxpEG6Ybgc4eh+vFoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3mS6RQkrtJGb10kNAUFbhlWCr7o83NPgrxmqdG4GEt9eclcKu/5/TLcZhhasdTf+
	 4elpQdWsr05S02wW2h2CmXf6SiEp7/XhMh2Lg+9XT4bfKVfyR4s/0brKM0ViR6AgXw
	 CZuAYwHQiA97ce6tMAPe9QM6J0XpUcRYS4V6Z46NaoISE21+hSrx3lPFSmwprM9D82
	 zFP/vnmHpfZx+aVrrJW+m1NhNzK2hpSQNhI8G3l5BuZqHO9YNQXvVJOcOhpTzuy6/m
	 bSLpC7oMTRB5Kt5eO3FfJAsPQfm1LR8NYS+sIQYO4oD2lsDPInaaZhwBlZuMn/U2Pa
	 stpywV2sloKtg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7884657a12.3;
        Mon, 17 Mar 2025 10:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzPCtddxIjYnYGQ73JLtRbeNYSy7zL/eB8ETulWYibjOQJANrrxnhbazy+Pz5ESLse9JBpmbyKOeRFrn/V6NA=@vger.kernel.org, AJvYcCXbKw7nWXbas2myBdRmSznvbFks4izJAGTSpwSZJdW+/ljUVVY3g/wB3GYslNRiVPTnXLy6aEHHWcX9sc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXdmMMejNGq+GGWErPHfj/jNNfjO5dAbVlzN+X93cZR+uP4zY
	djzscVwNhs1T/6Hmtrn8EKt+q+KqNAv4og0/1siqa5XPuaYew9aYN42r7x5nzaF+aFT80BLNhvl
	R3pPym3GsMxfpwz50Aw+6V0p24g==
X-Google-Smtp-Source: AGHT+IHci5hAASurc/lxodNyDclZIUpIuFlvwsFb/ZFbzWYKAntadGtYvqA1Ubo84Yz/rBl32SRf+JP56TiMbCS2Sng=
X-Received: by 2002:a05:6402:4301:b0:5e5:bcd6:4ad8 with SMTP id
 4fb4d7f45d1cf-5e89f24c63fmr12982673a12.9.1742231974609; Mon, 17 Mar 2025
 10:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314233831.2535170-1-robh@kernel.org> <CAOiHx=mr+MFE_7Krue4BPrtvtyJW0pWUBXCrqbViVH5oOTT2Hw@mail.gmail.com>
In-Reply-To: <CAOiHx=mr+MFE_7Krue4BPrtvtyJW0pWUBXCrqbViVH5oOTT2Hw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 17 Mar 2025 12:19:23 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+L2W-=4m2c2zAKNAP9vsrbZkOBHUYqPevcdM9L_3xHtA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp7GjAUd9blnwfMaOZafCeEHVPVcCYh5g6hLxjUn1VGcrND5MvV8CKr6T0
Message-ID: <CAL_Jsq+L2W-=4m2c2zAKNAP9vsrbZkOBHUYqPevcdM9L_3xHtA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: Drop of_get_property() call
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 5:07=E2=80=AFAM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> Hi,
>
> On Sat, Mar 15, 2025 at 12:39=E2=80=AFAM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> >
> > There's no need to check the property presence and length before callin=
g
> > of_property_read_u8_array() as it will return an error if the property
> > is missing or the length is too small. The return errno doesn't matter
> > to the caller, so no change in behavior there.
> >
> > Change of_property_read_u8_array() to of_property_read_variable_u8_arra=
y()
> > as the former allows properties to be longer than the requested length.
> > Now the property has to be the exact length requested as the removed
> > check required.
> >
> > This part of a larger effort to remove DT functions like
> > of_get_property() and of_find_property() which return raw DT data
> > having no reference counting.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - Add check that cal_data_len is non-zero
> > ---
> >  drivers/net/wireless/ath/ath10k/core.c | 24 +++++++-----------------
> >  1 file changed, 7 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wirel=
ess/ath/ath10k/core.c
> > index b3294287bce1..47206b171aa5 100644
> > --- a/drivers/net/wireless/ath/ath10k/core.c
> > +++ b/drivers/net/wireless/ath/ath10k/core.c
> > @@ -1889,39 +1889,29 @@ static int ath10k_download_cal_file(struct ath1=
0k *ar,
> >  static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_na=
me)
> >  {
> >         struct device_node *node;
> > -       int data_len;
> > +       int data_len =3D ar->hw_params.cal_data_len;
> >         void *data;
> >         int ret;
> >
> >         node =3D ar->dev->of_node;
> > -       if (!node)
> > +       if (!node || !data_len)
> >                 /* Device Tree is optional, don't print any warnings if
> >                  * there's no node for ath10k.
> >                  */
> >                 return -ENOENT;
> >
> > -       if (!of_get_property(node, dt_name, &data_len)) {
> > -               /* The calibration data node is optional */
> > -               return -ENOENT;
> > -       }
> > -
> > -       if (data_len !=3D ar->hw_params.cal_data_len) {
> > -               ath10k_warn(ar, "invalid calibration data length in DT:=
 %d\n",
> > -                           data_len);
> > -               ret =3D -EMSGSIZE;
> > -               goto out;
> > -       }
> > -
> >         data =3D kmalloc(data_len, GFP_KERNEL);
> >         if (!data) {
> >                 ret =3D -ENOMEM;
> >                 goto out;
> >         }
> >
> > -       ret =3D of_property_read_u8_array(node, dt_name, data, data_len=
);
> > +       ret =3D of_property_read_variable_u8_array(node, dt_name, data,=
 data_len, data_len);
> >         if (ret) {
>
> of_property_read_u8_array() returns 0 on success, but
> of_property_read_variable_u8_array() returns the number of elements
> read on success, so this check needs to be ret < 0 now.

Indeed. Thanks for catching that.

Rob

