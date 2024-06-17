Return-Path: <linux-wireless+bounces-9123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66B90B531
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E2B1F22517
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833B15B96D;
	Mon, 17 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjdItWre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005761D9538;
	Mon, 17 Jun 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638034; cv=none; b=unAR950h1YnZiM67Yo6+gur1UqlaGR0DWotKiRrLoeMDfRTAZVmg8T+x2SPxKbJt6+q51deWf4Ae0J4kdOcxKmcKvPAOkc06zj4fIJA6wBzRtWaH4KKCH+B4zJlex04EM2LzhJy97qBkdLEJ71uDDvqjkuYh1GFjk7EmShA5BG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638034; c=relaxed/simple;
	bh=n+wIBWJU1LXxzUpG+e2c5+QYPfK0ydEvJGGwWKE0jUc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KOUIevusIZj6i/zUKGXPecew9SzkSIjjXPPRjd7da549v+wklDKQoAb5afqegrLr/Afj8LW1+pPPorq3FajPg6KpL0y+8Gh4T3Zgdpf0L4GY2zHdU9n+nbGnRr3K/mzLYpC4U/MZbVjYqOEptLJ1nxDmwtTzgRNt1jZT+8r53Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjdItWre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70332C4AF1D;
	Mon, 17 Jun 2024 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718638033;
	bh=n+wIBWJU1LXxzUpG+e2c5+QYPfK0ydEvJGGwWKE0jUc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JjdItWreMC/EPM8OeL2NH0i8TqCN+WOndTEB31FM1fm0300EaPp3d9sSRcTCdL/0t
	 UFcvrGp3opCkhtT/Rh4jAkNU+YwH0OaW+FqfUZlWNbwYWum6pTe0hZVac8TQe0BTxw
	 sILu9XDpvccwKGIa7R5XQ3wwDjR1SWXHZy5j7gWN4LwspNH7f5fUf9SyqHsEgUePzq
	 rQzEErBtnymU2sP6RAvhzj7pFWILURUtvCAIDH9MnGezMr+AsRkBg87aFE/5Pr46Px
	 o020GocXn7rtJDTO90E6cuWHjWaYriCRAaQitMuWiyNfotrYYRYZ8Z3d/EG/ZiG5zH
	 eZNqmhKUI0pZA==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
	<1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
Date: Mon, 17 Jun 2024 18:27:10 +0300
In-Reply-To: <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> (James
	Prestwood's message of "Mon, 17 Jun 2024 08:09:05 -0700")
Message-ID: <87iky7mvxt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Prestwood <prestwoj@gmail.com> writes:

> Hi Paul,
>
> On 6/16/24 6:10 AM, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>> connecting to a public WiFi:
>>
>> =C2=A0=C2=A0=C2=A0 ath10k_pci 0000:3a:00.0: invalid vht params rate 1920=
 100kbps
>> nss 2 mcs 9
>
> This has been reported/discussed [1]. It was hinted that there was a
> firmware fix for this, but none that I tried got rid of it. I got fed
> up enough with the logs filling up with this I patched our kernel to
> remove the warning. AFAICT it appears benign (?). Removing the warning
> was purely "cosmetic" so other devs stopped complaining about it :)
>
> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html

More reliable link to the discussion:

https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.161=
2915444.git.skhan@linuxfoundation.org/

I think we should add this workaround I mentioned in 2021:

   "If the firmware still keeps sending invalid rates we should add a
    specific check to ignore the known invalid values, but not all of
    them."

   https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/

I guess that would be mcs =3D=3D 7 and rate =3D=3D 1440?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

