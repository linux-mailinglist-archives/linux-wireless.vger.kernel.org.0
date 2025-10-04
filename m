Return-Path: <linux-wireless+bounces-27810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEABB8EEF
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 397D23469A5
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CE21CFE0;
	Sat,  4 Oct 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thLWlADK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702021C9F4
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588723; cv=none; b=Sew25UsPPFefDU6L1Hwjr/ekQFpJjA2bdC1jock4Z9qBVDybEMecMbUhb1H5EM+3VbW7ZwoiUHBYUEeT/Yx9TYiN4poVjLNDxECfajK5PYVMJ0v+iYSaPk6dBYON5sVd1X1oaqxpCQdRyRYGjxF0T94jxE+KU1a+qEntKn0kmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588723; c=relaxed/simple;
	bh=GuIMQtkMJWAIXWd25fEwJmqhedXUQqtiU4WqfVmMVIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFe8q61rxxa4fWdptlyJkYmHuHTSsBfIVNZ9ISWScTNMJFUwQZNIhX3bzNadroKgY3y7ThHNU/OSw6BwvZSwWvNtDDW8lQPj+l5QuHHyAdan15ehiG7zb2ZFcEJ3Oe7sjf5BMDFAcif73JaI0v/6h5m9MWK6fBfeN1PoGeKHBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thLWlADK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD9CC4CEFA
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759588722;
	bh=GuIMQtkMJWAIXWd25fEwJmqhedXUQqtiU4WqfVmMVIs=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=thLWlADKXkQcpHvUXtbY87KKLZj5BDf2WXa+xp1CXa3Fts2PFrYGw+XW3fVRWqBPR
	 QyU0O8p9hth5WPbtUOI+SDMzaw9UkgBTiu4xWGouexlQkqq48L1YwTnppJP/uv9ddg
	 XC4esV2iGls0/1EwnFBbSxg/VRVovM1zqFvJUEp74QaSKToth6vqvmttfutwxR0DvS
	 GwNfjyzn9D3zzlnc0VnCmZz/e4LJoFaP748ULD2GokfPfrZrwGwpRkTMOYSC55Rw/m
	 qmRsvXEMXf0mWrBzX1xOwT/PLc2kg0d8p9ZnU+ltT1dgVnA922slpUNpyW7yKR4zfX
	 PUaDosFn6plow==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so26589221fa.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 07:38:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDU/Cc+6xbYlpoL9UiMXESv+Io5TKcWmlePaf23ep/elDQ3Kwn
	DDBpUUgH0CkMCFH01RiFCgve6tSxdnO54qpcKFy8FZXUGed3nrpXY6D2xY5qFevghYATftu6tAZ
	aEk29T2+6DRWYBzTGjEEHFk67rTTSPgk=
X-Google-Smtp-Source: AGHT+IHgIjk7zN2vZ27+UEf4thIbFmw2A9A4VdaFlr5OCqbEDfD6iGxoenPRj4CA99PcdjYzi0bIGigAZbR+elccgsI=
X-Received: by 2002:a05:651c:b13:b0:35f:d228:2a5f with SMTP id
 38308e7fff4ca-374c36a70f2mr17978501fa.2.1759588721051; Sat, 04 Oct 2025
 07:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2e09391-d2fd-4456-ae45-103239dbac74@gmai.com>
In-Reply-To: <d2e09391-d2fd-4456-ae45-103239dbac74@gmai.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 4 Oct 2025 23:38:31 +0900
X-Gmail-Original-Message-ID: <CAGb2v66VXhx0ymHGOdS33W2QxUMxew1xW--+hrs+jy48u6MfoA@mail.gmail.com>
X-Gm-Features: AS18NWBtBSkT5dKeYfcvN3r4hDVY4pv_ZkfiRtbdYkCS6CUVddXMLYLJKP4bvWY
Message-ID: <CAGb2v66VXhx0ymHGOdS33W2QxUMxew1xW--+hrs+jy48u6MfoA@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Ukraine (UA) on 6GHz
To: Dmitry Geurkov <d.geurkov@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 4, 2025 at 10:36=E2=80=AFPM Dmitry Geurkov <d.geurkov@gmail.com=
> wrote:
>
> Hi,
>
> 6GHz wireless band was recently allowed by Ukraine government for WiFi
> 6e standard indoor use.
>
> Could you please add the appropriate setting to wireless-regdb
>
> I'm not familiar with wireless-regdb format nor an expert on wireless
> technology to create PR myself
>
> You can find all needed information here
>
> https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radiot=
ehnologiyi-wi-fi-6e/
> <https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-radio=
tehnologiyi-wi-fi-6e/>
>
>
> https://mrt-cert.com/en/gjxw/4323.html
> <https://mrt-cert.com/en/gjxw/4323.html>
>
>
> Best regards from Ukraine

Thank you for the notice.

Would it be possible to provide a link to an official document or web page
that describes the change? Something from a government ministry or office.
We prefer those as reference over second hand sources.


Thanks
ChenYu

