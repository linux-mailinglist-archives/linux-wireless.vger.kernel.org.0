Return-Path: <linux-wireless+bounces-23063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41502AB9770
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDFA4E839B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D7224B05;
	Fri, 16 May 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMnEsJyo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D622DFB6
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383650; cv=none; b=FbRy3PfKQLVR7EytxhB0C4QASY2BozYWZJoe3vc3sA44xhG4g+vqJByk4vY2MAtva/Nmduqq8/5MxlWYF7L6xRlpu3YbtUQSWVmWJInOfZ/u1euRzETPHAUQMbs5JEEYm9+VtcTM5P9b38HKIeAyHAgblTO4q/Pwws0VXuYX2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383650; c=relaxed/simple;
	bh=Z9yHLCOcUTvAJaDRoOqBHTW1paqPZ4hEEJAWtS+PHPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8idBLIKRE/2xUWjz3D/YZkU6dpPtSryotkblalP9gRDIkskJZMRn+tbGMZri/qOiZtS+bFVk2fANu2hNyX0ONpjsPwSEmjGcxCpgNB1WUR7tgak6w62V/gMTHy/G1PnifapGQGmxliUAwKWTLJt+XUS5v7RbCgjwOeH0IR1EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMnEsJyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C68C4CEEB
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747383650;
	bh=Z9yHLCOcUTvAJaDRoOqBHTW1paqPZ4hEEJAWtS+PHPg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LMnEsJyojFOs1eKC+AaeJ4oYf6JLUoJIvgYj4lk2xsS8FrfjV91jlJDkxXcEMy4JL
	 JLpDQH+zLnm+ttE/HlAQtv81OAyM77lmLLncY296uYMm7+4fD9WowKA0UsziMFE3zz
	 g31sMy6xkN3ZQO91GJsO91kXl5gRoAL0kyyD3iMLRJDj9DeNJNuEGjc3nqmnJM+HN9
	 D0yp/nTUEmK1hS9zdaurgoC1zaF8kQDybXK5CZqOiQp6W77l4FKi7FtOXhN4gNXlv4
	 oNnoZ3Y5+WwJ2B+ucDWJ7ESEfNKCl5CSNfSf4175bXdG/yjntTju/KR9Z79CMjlcjI
	 OxjQcehuUxcAg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-327fa3cec3fso14631861fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 01:20:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YytEoyiScGHLVIsao888h3Bakm91xD6Gw0ZgnDuxiWss5KHUyWD
	zbp+8Sa+ecGGNcOa/HwaLh2x9M8KPgOpgc/VrfR/2GfGreoEKp6+e1r5LyfLSlbx0IDK+N+lfPf
	d1/C/FJg4IodUCvyPrEcNxGFhswRr5sM=
X-Google-Smtp-Source: AGHT+IFOUDfa13iDohf+REfjZamfX5SNyDISO8nLy9XQVzgpJAurr3TSu0MSfkO50YCvVlzWPZhYmgN39RYWozx5Oxc=
X-Received: by 2002:a2e:b88e:0:b0:30d:e104:b795 with SMTP id
 38308e7fff4ca-328077d4cf2mr8224481fa.39.1747383648317; Fri, 16 May 2025
 01:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC=t7aR6tripS=+LJprV25wzcqd_T47iAHepZrRQOzDRKzuGtg@mail.gmail.com>
 <CAC=t7aQZL9uih-e+8Eq-rikJExspYRUi7gt4N_DpddzszTOGMQ@mail.gmail.com> <CAC=t7aT8SanBhCBrJi+fE1ym0zfEvXUULYfXtwBfc7u1hB=Xzw@mail.gmail.com>
In-Reply-To: <CAC=t7aT8SanBhCBrJi+fE1ym0zfEvXUULYfXtwBfc7u1hB=Xzw@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 16 May 2025 16:20:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65_MXsuQjCPB-uHOYQVgLU+Zs7MtB5_X9Q3O-aQ=_39nA@mail.gmail.com>
X-Gm-Features: AX0GCFv1WvHzXvsGtH5a1vFCXaS2pA8JzlMACIpC6Apa9ohfxXE3VFdKK8cbGC8
Message-ID: <CAGb2v65_MXsuQjCPB-uHOYQVgLU+Zs7MtB5_X9Q3O-aQ=_39nA@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Iraq (IQ)
To: Mohammed Abdullah Ali Al-Obaidi <mnewiraq2000@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 6, 2025 at 2:32=E2=80=AFPM Mohammed Abdullah Ali Al-Obaidi
<mnewiraq2000@gmail.com> wrote:
>
> Dear wireless-regdb maintainers,
>
> I understand that my previous email was flagged as spam. I apologize
> for any inconvenience. I will try again with a shorter version.

It could be that you were sending the emails in HTML, which the Linux
kernel mailing lists don't accept. Attachments also don't work well.

> I am reaching out to propose an update to the wireless regulatory
> database to reflect Wi-Fi frequency regulations in Iraq. Attached is
> the official documentation detailing these regulations. Could you
> please guide me on submitting these changes?

Please follow the documentation at:

https://wireless.docs.kernel.org/en/latest/en/developers/regulatory/wireles=
s-regdb.html

In essence, you:
  1. clone the wireless-regdb repository
  2. make an edit to the db.txt file to add an entry block for Iraq
  3. make a git commit from the edit
  4. make a patch file from the git commit
  5. send the patch to this mailing list

> The source of the provided document is
> https://cmc.iq/ar/wp-content/uploads/2025/03/Republic-of-Iraq-National-Fr=
equency-Allocation-Table-2-Final.pdf

The document only lists the allocation, but not the power limits for each
band, or any other restrictions. You would need to track that down.


Thanks
ChenYu

> Regards,
>
> Mohammed
>
>
>
> Regards,
>
> Mohammed Abdalla
> +9647902729029
> mnewiraq2000@gmail.com
>
>
> On Tue, May 6, 2025 at 12:30=E2=80=AFAM Mohammed Abdullah Ali Al-Obaidi
> <mnewiraq2000@gmail.com> wrote:
> >
> > Dear wireless-regdb maintainers,
> >
> > I understand that my previous email was flagged as spam. I apologize fo=
r any inconvenience. I will try again with a shorter version.
> >
> > I am reaching out to propose an update to the wireless regulatory datab=
ase to reflect Wi-Fi frequency regulations in Iraq. Attached is the officia=
l documentation detailing these regulations. Could you please guide me on s=
ubmitting these changes?
> >
> > The source of the provided document is https://cmc.iq/ar/wp-content/upl=
oads/2025/03/Republic-of-Iraq-National-Frequency-Allocation-Table-2-Final.p=
df
> >
> > Regards,
> >
> > Mohammed
> >
> > On Tue, 6 May 2025, 12:18=E2=80=AFam Mohammed Abdullah Ali Al-Obaidi, <=
mnewiraq2000@gmail.com> wrote:
> >>
> >> Good day,
> >>
> >> I hope you=E2=80=99re doing well. I am reaching out to propose an upda=
te to the wireless regulatory database to correctly reflect Wi-Fi frequency=
 regulations in Iraq.
> >>
> >> Currently, OpenWrt maps Iraq=E2=80=99s IQ code to the world 00 domain,=
 which does not account for the specific frequency and power limitations se=
t by Iraqi authorities. To address this, I would like to submit official re=
gulatory documentation outlining Iraq=E2=80=99s permitted bands, transmit p=
ower levels, and any necessary restrictions.
> >>
> >> Attached to this email is official documentation detailing these regul=
ations. I kindly request your guidance on how best to submit these changes =
and ensure accurate representation for the IQ country code within the Linux=
 Wireless framework.
> >>
> >> Please let me know if any additional information is required, and than=
k you for your time and support in maintaining an up-to-date wireless regul=
atory database.
> >>
> >> Regards,
> >>
> >> Mohammed Abdalla
> >> +9647902729029
> >> mnewiraq2000@gmail.com

