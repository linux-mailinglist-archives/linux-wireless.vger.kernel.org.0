Return-Path: <linux-wireless+bounces-15800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0F9DC0E1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD5165366
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFB216DEB5;
	Fri, 29 Nov 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBLEKQrV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD21714D3;
	Fri, 29 Nov 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870433; cv=none; b=MvqxlINwWAV2Ved/KhvtYKaOfR/fvK/8Q6Xhe3c9y0D2Tw9pjpsWWN3nninb8y8U4yLlftUQo+oEf8kn7PUBIiGWXxvZP3ma4VdT8FYIrTzQ1ZQjeDY4F/Y3nwGIoiJv1cSC0EJ8xOhfn6AGUIdJXmMA7ITe//6rcTpbSd/YL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870433; c=relaxed/simple;
	bh=PWjGAU76nJzuPec0ckBdi9FcYElbQvNbyAFXD40o/MY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M8NqWm1z0fqhoKar5QLIEF2TPFDp1eSKc1YJVeXPtbRfaAKikjSy54CxI574pCJrs6T0hrC1SxT+w8xOq0SQ0/4gHTAYTHek07T4esUcQNioexPZ0V0QaSxvml0Floc79JezaHZgGdWssHGNs2v9QJvAdVusiWmeSk1yeW5xyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBLEKQrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DED1C4CED2;
	Fri, 29 Nov 2024 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732870432;
	bh=PWjGAU76nJzuPec0ckBdi9FcYElbQvNbyAFXD40o/MY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VBLEKQrV000Q1wZNquGeBb4ypPUKC6cnNAoJnOtXORzuqE+c+xHNqnMjNFZ5C4QXX
	 qMakgu6HRuTKDtUoCeFQrHRewR25vEepbHPN/x1nJgjC5Dea0i77fXr2Uhdim16Ibg
	 0qGcskpXexy+GBIp7FYhjJB6e4psoTb3vMht7kcWszhJcSb16eE0QUYQ+natd8BNJI
	 jWIiIdvGSQxLCCzb//wiuvaNaO13RsAcBtI+hfLwDjz+TKRGbAaAs6L2ubufayHT7z
	 Hok3kGlV9/GeWTHrfUU5QXnXyK7mc6pA/Zytl4BUzoY4R4zMw+QNKgL5TOupHxuuiV
	 Igl4NeIyQfxwA==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org,  LKML
 <linux-kernel@vger.kernel.org>,  regressions@lists.linux.dev
Subject: Re: WARNING: drivers/net/wireless/ath/ath10k/mac.c:8750
 ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]
References: <637c5bb4-5278-44be-9ac3-9c0ef9297162@molgen.mpg.de>
	<8734jcx60e.fsf@kernel.org>
	<5c9bf757-a035-499c-a1ef-ac33c1c6e75b@molgen.mpg.de>
Date: Fri, 29 Nov 2024 10:53:48 +0200
In-Reply-To: <5c9bf757-a035-499c-a1ef-ac33c1c6e75b@molgen.mpg.de> (Paul
	Menzel's message of "Fri, 29 Nov 2024 00:01:55 +0100")
Message-ID: <8734jav2sj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Kalle,
>
>
> Thank you for your reply.
>
>
> Am 27.11.24 um 12:36 schrieb Kalle Valo:
>> Paul Menzel writes:
>>=20
>>> On the Dell XPS 13 9360 with Linux 6.12.0-08446-g228a1157fb9f, I
>>> noticed the trace below:
>> For others, commit 228a1157fb9f is from current merge window so the
>> first release will be in v6.13-rc1.
>>=20
>>> [16805.002289] ------------[ cut here ]------------
>>> [16805.002296] WARNING: CPU: 3 PID: 65835 at drivers/net/wireless/ath/a=
th10k/mac.c:8750 ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]
>> [...]
>>=20
>>> I do not see such a message in the logs since September 19th, so I
>>> believe it=E2=80=99s a regression.
>> Have you seen it only this one time or multiple times?
>
> I have seen it only this one time.

Ok. Was it a network you regularly connect to or a new network? That
could also make a difference.

>> What kernels have you been testing prior? I'm trying to pinpoint what
>> versions kernel version work and what have this warning.
>
> Before I ran 6.12.0-07749-g28eb75e178d3 without seeing this. As it
> only occurred once, that does not give any pointer though.

Yeah, if you have seen it only once it is difficult to make any
conclusions. It could be as well an older bug which happens rarely. If
you see it again, let us know.

> PS:
>
> $ last reboot
> reboot   system boot  6.12.0-10296-gaa Thu Nov 28 22:42 - still running
> reboot   system boot  6.12-rc6-amd64   Wed Nov 27 14:04 - 22:42 (1+08:37)
> reboot   system boot  6.12.0-10296-gaa Wed Nov 27 13:21 - 14:02  (00:40)
> reboot   system boot  6.12.0-09568-g2f Tue Nov 26 18:41 - crash
> reboot   system boot  6.12.0-08446-g22 Sat Nov 23 12:27 - 18:40 (3+06:13)
> reboot   system boot  6.12.0-07749-g28 Fri Nov 22 10:14 - 10:24 (1+00:09)
> reboot   system boot  6.12.0           Wed Nov 20 09:24 - crash
> reboot   system boot  6.12.0-rc7       Wed Nov 20 09:22 - 09:23  (00:01)
> reboot   system boot  6.12.0-rc7       Tue Nov 12 08:19 - 23:27 (7+15:08)
> reboot   system boot  6.12.0-rc7       Mon Nov 11 21:54 - 00:16  (02:21)
> reboot   system boot  6.11-amd64       Mon Nov 11 21:52 - crash
> reboot   system boot  6.12.0-rc7       Mon Nov 11 20:43 - 21:52  (01:08)
> reboot   system boot  6.12.0-rc7       Mon Nov 11 17:51 - 17:52  (00:01)
> reboot   system boot  6.12.0-rc6-00077 Fri Nov  8 08:39 - 17:50 (3+09:11)
> reboot   system boot  6.12.0-rc6-00077 Thu Nov  7 07:26 - 23:24  (15:58)
> reboot   system boot  6.12.0-rc5-00047 Mon Nov  4 08:26 - crash
> reboot   system boot  6.12.0-rc5-00047 Mon Nov  4 05:42 - 05:43  (00:00)
> reboot   system boot  6.12.0-rc5-00047 Sun Nov  3 06:54 - 22:10  (15:15)
> reboot   system boot  6.12.0-rc5-00047 Sat Nov  2 07:34 - 22:05  (14:31)

Oh nice, looks really useful. I need to install that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

