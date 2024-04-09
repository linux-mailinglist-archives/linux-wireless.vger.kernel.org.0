Return-Path: <linux-wireless+bounces-6008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69A89D93E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4281C21111
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257F1C3D;
	Tue,  9 Apr 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP4KjDcF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8F384
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665883; cv=none; b=GBj8YUVSEseraEQoAITPV3dTjR3/wfGUjcBojF0psW14UTT8ktneCCOL3YhjkwQdrKR6bvtUbpxzcq7YS09woSPiFaRVeRdAgUYJ8TfDhpv7ydrl2wLGQh5kyPHLYCzpNrUOm3k/XqYphOkzDQdreE5NfHyKWQPCcS8itEA/O3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665883; c=relaxed/simple;
	bh=Smf8CqsXg9haM1YfQmcDVxHR/BjPzeFlKSG9GLUaZc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l17EGCqgLfqXglzqV4jRhI5EHdMtrwymqO44hh5BMJgZBrazgYFXAQZaImrJ+JwwXtONtDbuCuQM8udUx1I0nl2BaUR3pH1mCB+xSm1rXoY4AvzPIkrLnh+qVvdWvBQ1kpOaPfFiHV9CUKS4gsFA8xsPBtyxD4+8J8B82x+3WAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP4KjDcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE50C43394
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712665883;
	bh=Smf8CqsXg9haM1YfQmcDVxHR/BjPzeFlKSG9GLUaZc4=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=SP4KjDcFJ2bCEYqa0OlTYSGyYm1+MGf3qTmWEgLDGYhvBurCkkVYo15Iq3paVftq/
	 WE6Iw0crN6YTofAoElRw2TzZvqpmSDTQkyrLZ9elNII5Lp0Ri8YFAP3RPPg1rT/c+2
	 JmXoSOC1/lPll8GZQ2+YpdouZIOu/y4pferiqrKmWjQW9zwGTA8kRGAyS1EDElHY7+
	 vBPP8WpCkC2sV5fJX6W9TyV8hUEDB3m3VfFvdvbKh2/5lzopc/fdFCJRYP84+plMUG
	 IfQ6Y+vtoahGB7mnk1R3ZHbpS1JrS5WoCSzSxiAHaFIpFDVaXBF2UkWZP1qWpZClvG
	 q51ccIsRdaUXA==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso6381077276.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 05:31:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjMfdygJHaEQXSZmWeFwACvtnIB5+8DEv2htEx0gHqk734xBMmT1ZhQGPuXuhbudH0bZW836fcNovFV1cGO55FbUF+YOmOvnIV5ynbuP4=
X-Gm-Message-State: AOJu0Ywea356a7pXdwZwIzsch5KLQ7JyPXybfFcYsLnwnu5bWv4mkd6c
	hnAMpLvL4tpd8/IfX9UyJ7r9FH+d/bsyo68S8rFKpyqVroiTwGZgYX+Er9C5b4iWtrSwij9HaJ1
	Vb/i9h1oWC3KoRbSrqoZw1LUuYWI=
X-Google-Smtp-Source: AGHT+IE99X1JBsIJgtH7+iJVAR6Bk+3/OL9aBba9eT9vOnm5TO7JumZsOpnQnVxXUOhdxZX7RC4CQFfWOA+kNjIU8D8=
X-Received: by 2002:a25:9947:0:b0:de1:1ac2:98e1 with SMTP id
 n7-20020a259947000000b00de11ac298e1mr620160ybo.37.1712665882252; Tue, 09 Apr
 2024 05:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <063c9937acb36ccf352056d212a9a2733abb9dd5.camel@realtek.com>
In-Reply-To: <063c9937acb36ccf352056d212a9a2733abb9dd5.camel@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 9 Apr 2024 08:31:10 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5T4imRCyiww4gzry0Qi+gVY2EQ9jznxvhCn3RL9Q-Wnw@mail.gmail.com>
Message-ID: <CA+5PVA5T4imRCyiww4gzry0Qi+gVY2EQ9jznxvhCn3RL9Q-Wnw@mail.gmail.com>
Subject: Re: pull request: rtw: update/add firmware of Realtek WiFi 8703B,
 8852C and 8922A
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Timlee <timlee@realtek.com>, 
	"fiona.klute@gmx.de" <fiona.klute@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:23=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Hi,
>
> Add/update three firmware including
>
>  - add initial firmware v11.0.0 for 8703
>  - update 8852C to v0.27.56.14
>  - add initial firmware v0.35.18.0 for 8922A
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit 22ee1d8ca6663ca7c28477581993d6ed5cc543=
23:
>
>   Merge branch 'robot/pr-0-1710861164' into 'main' (2024-03-19 19:07:14 +=
0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git HEAD

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/189

josh

>
> for you to fetch changes up to 08259e7f17f553d5f985a530f825ac8ad6f48450:
>
>   rtw89: 8852c: update fw to v0.27.56.14 (2024-03-21 11:02:32 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8852c: update fw to v0.27.56.14
>
> Fiona Klute (1):
>       rtw88: Add RTL8703B firmware v11.0.0
>
> Ping-Ke Shih (1):
>       rtw89: 8922a: add firmware v0.35.18.0
>
>  WHENCE                    |  12 +++++++++---
>  rtw88/README              |   3 +++
>  rtw88/rtw8703b_fw.bin     | Bin 0 -> 20290 bytes
>  rtw88/rtw8703b_wow_fw.bin | Bin 0 -> 23074 bytes
>  rtw89/rtw8852c_fw.bin     | Bin 1532736 -> 1532656 bytes
>  rtw89/rtw8922a_fw.bin     | Bin 0 -> 1537690 bytes
>  6 files changed, 12 insertions(+), 3 deletions(-)
>  create mode 100644 rtw88/rtw8703b_fw.bin
>  create mode 100644 rtw88/rtw8703b_wow_fw.bin
>  create mode 100644 rtw89/rtw8922a_fw.bin
>

