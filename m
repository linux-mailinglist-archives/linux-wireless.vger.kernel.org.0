Return-Path: <linux-wireless+bounces-25502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62642B069E3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB31189E508
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 23:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2F25B31B;
	Tue, 15 Jul 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0qLr8q1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BB23E320
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622179; cv=none; b=iM1HCC0yTPWoO3487hJcmM0zNd9w5fXUf8L5goNvZOiTSz8FCMfGleEquPkGzGtATzeGYJK3WUwOIlTh/CCKzCCRCXr9iIZnnqew13QnMhveKIhrDVvTWr/CFxtymBApzvWDDXbpY3ptUpg4czYBZJ90DMLo5aRmr1yfrSz4HF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622179; c=relaxed/simple;
	bh=KCefVLyeHt67wusi/u+A5bCJDM0bRI+Sue4ywQXllzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etjx97yJ6aXZNJUMvfjSQbTum5kCQx0UAs0sMxJrqTnQdZCU6udX7XwwwO76Tza4+4iw+sUt0gjreq4umXXjC7N97zck4fIT54MCTiO7W84LLzdLBmGpai3yAdV/hgpT/l8vz5hRiXqfXfgb3sHFR5yb6lo1+HPNgUxhPh6G644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0qLr8q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A16C4CEF6
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 23:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622178;
	bh=KCefVLyeHt67wusi/u+A5bCJDM0bRI+Sue4ywQXllzM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=G0qLr8q1OgCU39qe3pwOudKktsTUTrDIZ6KyBBZoaGZ+dhEDlqbTW+xqQnFqug6Q3
	 n/ftFNIl8SMqgT82T0/jKp7Fwrfif6SDjl1sr+3GIXWLYFBuOWiSnXAzS7RREDYkB3
	 A6KBAwIaSEx0XxncCAYDaYzVEuvNgUjLDE8+Amt8qKzsJIBtZGWEqzq4LgjBg4UhRk
	 7bzKkErPxsfRoSrdtcWmbgCAWSweMkqKQyQV9D3qiVRUK56q+IBVMW8NY3Uwg/19Qg
	 y8Lfo7vG9uUKa+rFbrTljEGJ4aZd3sh3/1q891tiLdH1VScNzbJb0GI23p3iRut2uG
	 mazwxNUiV3AVA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70f94fe1e40so4468737b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 16:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2kzrbUAHqknmo7e8F6R7QX6ur1AqTfyhFg67dPMuqvzt7VKfoE/ss8q126TJXj0Q94Hb826cBL3KntSs28A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJiZIBOXyXovs38vcWLjNN5rO5NwdUMWizM3L/z4FbGqQZnqp
	GLGzeDshtgBOaB1UxrRteHIV3bfPMH9m9Y7tnv3Vc3tvcGOU3lifEX81+5yRMViaMcoRh5mNepq
	EcfWrByXgtSVE7mRiszJGpwMmzEl2dyc=
X-Google-Smtp-Source: AGHT+IEJu/eBBAD3iifWrQWBSgjRMLvDefwtQwh5jkKvlvitkBGQHk6rycQbT3hypyz1bc5KJ48TJ8i7qq1zwG1U714=
X-Received: by 2002:a05:690c:9a87:b0:713:fed3:70a5 with SMTP id
 00721157ae682-71835031badmr15649077b3.9.1752622177581; Tue, 15 Jul 2025
 16:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <880417d5-c1ae-4423-9019-e3dcc2673c43@RTEXMBS04.realtek.com.tw>
In-Reply-To: <880417d5-c1ae-4423-9019-e3dcc2673c43@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 15 Jul 2025 19:29:26 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4LGpLH281XmCEFE1qiOmz=-BzeJkGzABCgrpW91JOR0w@mail.gmail.com>
X-Gm-Features: Ac12FXwrckbRQyejK9MbaPclOdLeZP6m2RttV1MSObnqzZMpp133MYQpGVFZTEY
Message-ID: <CA+5PVA4LGpLH281XmCEFE1qiOmz=-BzeJkGzABCgrpW91JOR0w@mail.gmail.com>
Subject: Re: pull-request: update rtw firmware rtw-fw-2025-07-15
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	kevin_yang@realtek.com, damon.chen@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pulled and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/615

josh

On Tue, Jul 15, 2025 at 1:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update firmware of Realtek WiFi driver rtw89 to update BB and regd
> parameters, and to support MCC P2P feature.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit ecdbd2b8af04b515732fbf11113cec16651915=
f0:
>
>   Merge branch 'robot/pr-0-1752505495' into 'main' (2025-07-14 15:45:59 +=
0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-07-15
>
> for you to fetch changes up to eb03c8ce595d75f2a2f81cbe87698c2539f64377:
>
>   rtw89: 8852b: update fw to v0.29.128.0 (2025-07-15 13:49:01 +0800)
>
> ----------------------------------------------------------------
> Kuan-Chung Chen (1):
>       rtw89: 8922a: update BB parameter V49
>
> Zong-Zhe Yang (4):
>       rtw89: 8852c: add regd fw element with version R72-R57
>       rtw89: 8922a: add regd fw element with version R72-R6
>       rtw89: 8852bt: update fw to v0.29.127.0
>       rtw89: 8852b: update fw to v0.29.128.0
>
>  rtw89/rtw8852b_fw-1.bin | Bin 1244784 -> 1290952 bytes
>  rtw89/rtw8852bt_fw.bin  | Bin 918376 -> 937688 bytes
>  rtw89/rtw8852c_fw-2.bin | Bin 2461176 -> 2463394 bytes
>  rtw89/rtw8922a_fw-4.bin | Bin 1259006 -> 1263938 bytes
>  4 files changed, 0 insertions(+), 0 deletions(-)

