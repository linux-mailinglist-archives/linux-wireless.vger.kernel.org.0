Return-Path: <linux-wireless+bounces-20306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A492A5F218
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51AE17CBBB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF3266183;
	Thu, 13 Mar 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjTjOW0o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC1265CD7
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864466; cv=none; b=g4rv/M0sTkqLsPAFFXkbwnUJ68oacgd+Tscrmgdfb7Ifj9Plfwa98TlsIx0MDjgyrqtMZEkLckRBp1+XPvEKBKO6VMQP/usaLEjPiyzlhGWl7vcmdtXpoGPo4oUnHki1T/tCA+oyCHf6eA3HeG3dfs7Brwgrbiiovs/PgsDRhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864466; c=relaxed/simple;
	bh=MMAN5UukwszNC6OHq5Y2iwjj+lOyMoN19ukxMCfVP20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiWakcwA4bfbIiExbfRGdqHz73hzzelAjEOeIEa513T8B3GCM6kS9y5EZANt+D40B+x9VMbL8FBNSuag/J7dIZYjp/eoxJri3iZdTXN3hKZT8ZR2ahsev4D7nfVnWGsoEtZBx5agfH1AnHRpqofxyMzsEUlQ+GVMhxtzOziqPp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjTjOW0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80841C4CEEB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741864465;
	bh=MMAN5UukwszNC6OHq5Y2iwjj+lOyMoN19ukxMCfVP20=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=ZjTjOW0o4jBmqa8YelechOpEsyQFBfG07GUHchS8ZQ0vIjCwJbJFA7uu7vXNwVxVq
	 x9JxLA9iYqmXVeFHaajzzjT1J7VKCOKilS+AXD4RTU2a+MUFvwLkjFRekcoD/5kaoY
	 gG6zBV7byOYwkepI0XODUTgy2TM7PN36pM2/wJX3DeMnraAEX1x5wdTYmHBI03UPPN
	 xcUyqpmJDQBKDkJkrWgO4HEY99Ru9kM/Q2h0Ln9z0gwRRaFzrySOwZt3flehaTej1s
	 truKZsu1YucasPV3acJ5XF1yRtrFdAhwqT8wjkvH+UPfGrbTijSY9P8RLJEjl5My+E
	 f+bCngs4B8zjQ==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e60ad903382so603253276.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:14:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbd4+B1TOw1rbqUIkBv2C3KeTOG5u+XQN2/TOa9ZFJuNAY1qSjyRH+QtTUXUgfonHXmg+VDWnN5Y7mcorUrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7mA3uuqyoHs3SmsWHdbHjYRw/MDZiN4zLXxRCz2GcS83SuN6
	kt6O0xLn94tGynJ9Jb6nN9im2pWrdicwh9V6CUB3TnBFMTIJC+ae3bI0Ea+BhvaIQTv5JV1UCiH
	DIHH2+n6RqN+9NVOG+jJ9dkyLbls=
X-Google-Smtp-Source: AGHT+IGYyQDgPTkeMu+sJH0m+8ZEXNvRWPeepNz6z2cwJgnL2Z8cyAqPL2Zgw+v9DKFEmtJOu3mVqdcrnZgdtvfj5cc=
X-Received: by 2002:a05:6902:cc7:b0:e60:a903:3f41 with SMTP id
 3f1490d57ef6-e635c18bde4mr33147333276.24.1741864464646; Thu, 13 Mar 2025
 04:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6784cbe4-7afe-48ca-8d74-e30339c72ca9@RTEXMBS04.realtek.com.tw>
In-Reply-To: <6784cbe4-7afe-48ca-8d74-e30339c72ca9@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 13 Mar 2025 07:14:13 -0400
X-Gmail-Original-Message-ID: <CA+5PVA49wRjKvSFk_7qSVWuS-tzL7qk+LRMwERY_D8WUcgBx0w@mail.gmail.com>
X-Gm-Features: AQ5f1JoooDTrFwiUd69dOJJzUXuFu2s3b4CitFccyfiU2W4Q1ttGcWc5LD5Uuu8
Message-ID: <CA+5PVA49wRjKvSFk_7qSVWuS-tzL7qk+LRMwERY_D8WUcgBx0w@mail.gmail.com>
Subject: Re: pull-request: update rtw89 fw for RTL8852C and RTL8922A
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	damon.chen@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/480

josh

On Wed, Mar 12, 2025 at 11:02=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Hi,
>
> Update firmware of rtw89 divers including RTL8852C and RTL8922A with
> support of secure boot.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit 89ba9b7ce05c8dac3b659b6a0ebc87a601fc35=
b1:
>
>   Merge branch 'robot/pr-0-1741722400' into 'main' (2025-03-12 13:09:10 +=
0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-03-13
>
> for you to fetch changes up to da086994b2ad7ca25167baa78cd0a5385092c584:
>
>   rtw89: 8922a: update fw to v0.35.64.0 (2025-03-13 10:58:03 +0800)
>
> ----------------------------------------------------------------
> Kuan-Chung Chen (1):
>       rtw89: 8922a: update fw to v0.35.64.0
>
> Ping-Ke Shih (2):
>       rtw89: 8852c: update fw to v0.27.125.0
>       rtw89: 8922a: update fw to v0.35.63.0
>
>  rtw89/rtw8852c_fw-1.bin | Bin 2375560 -> 2399272 bytes
>  rtw89/rtw8922a_fw-3.bin | Bin 1725278 -> 1188926 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)

