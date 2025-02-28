Return-Path: <linux-wireless+bounces-19591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF048A49BD0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21223B2D38
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7726D5AD;
	Fri, 28 Feb 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFIenLh+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD426B971
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752564; cv=none; b=oFN8iH2X1Xf3/SiuZ9z1BlYMB6PNsufwOO2x6NlIPAy0b446INhst0E86nhweF3yogtuuAV7arUdskm5e2pSf0fWyJkam8gkM9IX+LpyukEmCC4XJ/xzXa56Gg1prw3VE029KRraqkUH5QBOJSpuOOACcJcL+uaEDZol+Zg8xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752564; c=relaxed/simple;
	bh=YrAZZ0PXP5RjSr4W8+ynydCh7w4dki4z3wY77uRoG9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0pJgTfXTEeMG85jsXDjQzfdGl7ifkLx086n8vMVnZPxZ95N97Vhpr5EPZ/VHHzqgjYUKm2lPwviWhHhb25W2bhrcB+BRjsj4nXGWTYFgIFXofYra5GJEnx5DhPdz5Mo6qSwuoWNBU9dqqhSH0/eFBHvL3615KpFvIkbRPnZ+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFIenLh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C946C4CEE8
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752564;
	bh=YrAZZ0PXP5RjSr4W8+ynydCh7w4dki4z3wY77uRoG9E=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=EFIenLh+3t6G/0EDNTEcT26Vcdx3srf/mqTsWArGGLIvFNYr+bpbP1HLGruAHp0cR
	 Mxqbn887JD6CeYxp9jtOfzx+8rL3WJA0KpcRc55WxGnOv2nLzrHwoBKP8C08FJlDWd
	 3eJjchTBLZEvCDqcOGssNJZzvEC/bipJkhFXJfjZBjdKMUonI1B1TQQNVQAMMr7Del
	 X18xaX/bMB7iYYL1I38wShIT5KDJI6KW/cyoA7GXeR+2yRngKhT4XZ1o1xGC5L62QM
	 jx6i0Mo2sBb4LAodVTjRdiWdvdHROL3/CMXHlck8vDZmS4rLVc/l8D9Ejfu+MpU79R
	 oXGUpHS8vJmMw==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6091256429so1809214276.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 06:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZzqwNyUDnwUjf1S1h11mXtN8Go5A/c2Tvel+t+ORtoak2TH7cXbWeHsv7ObgMzXGFa0uT8g+zIMGz5nX95g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiV5c121jXbiHNKTZBD/xr81Sxe1OkptC7Ooe6ZLY4c25XBNmX
	+OTe+WUDo309wyjQy5FqI+sRMQr3Fwm+eiFv0l7vHZael/KvRy1CAJwrTWbHxerNY5syM3rW0bT
	tDPHhugSlpo97/1lDOX9GhdVZg0Q=
X-Google-Smtp-Source: AGHT+IFfyUh86GcvZnrtYJPKMoqrbcpz+KFHRuNfCwiOATtnh4qd+SJoWoK730GrjXadozCYh+sJzkIMhFBLKCP6o14=
X-Received: by 2002:a05:690c:4c04:b0:6fb:b907:d94b with SMTP id
 00721157ae682-6fd4a08f53fmr48737467b3.17.1740752563081; Fri, 28 Feb 2025
 06:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81e6a3ea-70a9-41ff-ba13-6121aa66d487@RTEXMBS04.realtek.com.tw>
In-Reply-To: <81e6a3ea-70a9-41ff-ba13-6121aa66d487@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 28 Feb 2025 09:22:31 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7Pbyf8rWZp88NkvHE8ACxs6g5BdB5ffCVGTbjs65Xg6w@mail.gmail.com>
X-Gm-Features: AQ5f1JpdpDnNsEsPYD_tNovf09kbvTFnhgJ5fqT_AayksyqNBl5z7nO-rU6cXd4
Message-ID: <CA+5PVA7Pbyf8rWZp88NkvHE8ACxs6g5BdB5ffCVGTbjs65Xg6w@mail.gmail.com>
Subject: Re: pull-request: rtw89: 8852bt: update fw to v0.29.122.0 and BB
 parameter to 07
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	timlee@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 10:11=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Hi,
>
> Update firmware of RTL8852BT to v0.29.122.0 including BB parameters 07.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit 6cf959daab2a38d074b059f73c24aab9d4dbcb=
c3:
>
>   Merge branch 'amd-sev-fw' into 'main' (2025-02-20 18:38:39 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-02-24

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/460

josh

>
> for you to fetch changes up to 0a69dcd33a4b2d9ec7286146c99cf6c37714d09e:
>
>   rtw89: 8852bt: update fw to v0.29.122.0 and BB parameter to 07 (2025-02=
-24 10:54:49 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8852bt: update fw to v0.29.122.0 and BB parameter to 07
>
>  rtw89/rtw8852bt_fw.bin | Bin 913992 -> 918376 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

