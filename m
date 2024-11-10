Return-Path: <linux-wireless+bounces-15158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991D69C331F
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCCDB20D37
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Nov 2024 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4DC40BF5;
	Sun, 10 Nov 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSy5mIj4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD395A923
	for <linux-wireless@vger.kernel.org>; Sun, 10 Nov 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252360; cv=none; b=H38Xn2V09OpUKtt0dgzzdkI7PZOi5YytyvRJubl01cBwQJgSaOSD6vVVK88/mI7dyPF8zkotVT7OFzb3Z2yfh/GxYpDapicyYwkef620+dtInHy0Oj5QRtjzPEipKoQA4EC1FPmcmQQYJ1+EL3cCNHkGcspJPGow5x8XacpB9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252360; c=relaxed/simple;
	bh=lCY9Dk9j/RnYTEJ0QzN73BMuTGFNxPCLRKXEMC0vnZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyt7s7DzmfnOPxF1ZeclJDXdxROXe2+5CmEmBYMOTFAQ4mYF4IYbu6yNQ1BU1OVXkqGVOo3MqgfIP0Hdnux4Pgw/RKNjYX3MQZqxQovcfN9BRtoijL2aa84RRfcvt9PeH+EG6SwlfpC5VOF6kKnJNk6OyXLnwLYtktUm9V76qnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSy5mIj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE89C4CECF
	for <linux-wireless@vger.kernel.org>; Sun, 10 Nov 2024 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731252360;
	bh=lCY9Dk9j/RnYTEJ0QzN73BMuTGFNxPCLRKXEMC0vnZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=VSy5mIj4PH703q/7TySF1Ueo5Y498hP+1w+g5XD7nQXdf7KNOFOLTcRhVrqoOiLJJ
	 4N3LEgTLIlV+h/4MpeAqCBQdLIfqtkTly6dCw25f+2Xq1k1KqCbLEpuewX21QvDJQe
	 pkENrrQESafWuI+40f7jc11Q2WlDVf+xq4H+S9a3VICy3WuaJ6E6+MWFdp8qYdHKJJ
	 ZtJ9weL1SRvMVxhDg7X1IXMT4OlYDT5J1lyODmty4iJi5yHM09uwLCzagI8cA3Fsew
	 7/3tQdMUGf9ZSjyhBOFdC7i5R4FvjUD+UmqE3J5ForhHxrdrTu5AXKlJ3h5xDo87uo
	 mduqEu8rKyvuA==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e35bf59cf6so42642967b3.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 Nov 2024 07:26:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8LO6tKvtQzRwAOajPU7UjrVfTJBBKV2DM+sSlll3SPxhzPRwf/yKD6sIrXa7QYW4R88ZqRAih+r8dmbIJfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyktAAv3pLytOV8+LX+Tdl6oevm0dPrk1hh4nufQuhjXFTtaFrm
	KXdl72IgnVdXs//xmybHDMmbUgPmkGZjE4M4frBVvYHntk24nxRm7tYd3dtK87vfB5NkEcKPL6t
	8L9GLeqAvt8pTwLgrDxKg3TOVHlU=
X-Google-Smtp-Source: AGHT+IG0Vy7ECc59ERZ3pJT5mWmHLbRRB3Tloo6IhYXDtlTlxTRtjl86D6gJELf4iWNR3yEQEfQEXxFIMAi1sYkZPU4=
X-Received: by 2002:a05:690c:6ac6:b0:6ea:7fa3:ab22 with SMTP id
 00721157ae682-6eade41955cmr69448657b3.8.1731252359583; Sun, 10 Nov 2024
 07:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1082df9a-5d1f-4044-b679-b2308971fc47@RTEXMBS04.realtek.com.tw>
In-Reply-To: <1082df9a-5d1f-4044-b679-b2308971fc47@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Sun, 10 Nov 2024 10:25:48 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5iko5JVP_XqAtHWKD7GkuDxFz=QAV=OqsmXNmr3yjwbA@mail.gmail.com>
Message-ID: <CA+5PVA5iko5JVP_XqAtHWKD7GkuDxFz=QAV=OqsmXNmr3yjwbA@mail.gmail.com>
Subject: Re: [RESEND v2] pull-request: rtw89: 8852a: update fw to v0.13.36.2
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	gary.chang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:52=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Hi,
>
> Update firmware of 8852a to v0.13.36.2
>
> Sorry that I messed my script to send improper first pull-request.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit e817e483c4b5bd0cd73a3d7e26c0a59c86b8c9=
95:
>
>   Merge branch 'rtw88' into 'main' (2024-11-07 13:29:19 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-11-08

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/361

josh

>
> for you to fetch changes up to b6bfff1a5b0fad254a693b9d4275271d4dda7f03:
>
>   rtw89: 8852a: update fw to v0.13.36.2 (2024-11-08 13:35:28 +0800)
>
> ----------------------------------------------------------------
> Chih-Kang Chang (1):
>       rtw89: 8852a: update fw to v0.13.36.2
>
>  rtw89/rtw8852a_fw.bin | Bin 1423232 -> 1428272 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

