Return-Path: <linux-wireless+bounces-13408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1E98D17C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 12:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4701F23380
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421001E765F;
	Wed,  2 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLfnVBlq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB71E7658
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865739; cv=none; b=N84D58JeE5h0GcY0fecIG5o1HdLvPtjSTQhX17tI3RiH6ETiYqO71VvvycxMhohiEbaHETqXHFYey77ZS7h2A89/Yf7KPx3Meh22YcULC4VUBfD/Bzlh4+DHwApX5YoWXtC3fHrKMvvjE4AISkmxzfh8PJWsJ1aJYfilqmaqha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865739; c=relaxed/simple;
	bh=bIYRMIBF5Zfat3PZIQHj+EOqAvrMF/b5OdVFZImmLa8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HowyX9Wnr/gHb1jmAq4+zn1TDdvT5Ilj1RINNj2XZcYghZfyUcYO73LM6gsoYaZTA4MmuIuaR7zVHi4dxHpIyp+XkPj7Ap/ybE2fcbpFznDZiGlA3zt4DGjmQ/RVTG2YxVy9qIty8UcLA76IZIsUzCzstiY5k2Ws0k/mcd72RwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLfnVBlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ADCC4CECD;
	Wed,  2 Oct 2024 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727865738;
	bh=bIYRMIBF5Zfat3PZIQHj+EOqAvrMF/b5OdVFZImmLa8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OLfnVBlqL/mv2qIbiAN0Edems8fsWGpSxukrc0ryPkI8ug/SM+UYn/VCIbwjf7gpQ
	 xfBRExaYZCEetxgd1di8y9SxYKt7ewEh4KLx5J69j7fTFbECIO0ndFn8O2SCN6Urs9
	 uxvwEWqXfHdIkHHw+9jDoKUQ6ugM2qQQqLe7/Z0o5TOtTlhBxjOCSAeVtKgLg1oH6Q
	 MyyFOlPWDtND2mttpd/8nrmRqi95H5DWFVXscY7AhfASfCoGsyMV8huvBSDP4q9T2p
	 +eZ1j7QJ0WR3v1Gk7QMgHoO1hmVzzo/CGCe/a+SbARft9So+so6HTVmgipoVnYHZIO
	 BnS7uPHjL+Chg==
From: Kalle Valo <kvalo@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] iwlegacy: Clear stale interrupts before resuming device
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
	<20241001200745.8276-1-ville.syrjala@linux.intel.com>
	<20241002064952.GA15679@wp.pl> <87frpf6iin.fsf@kernel.org>
	<Zv0Y4idp6NsQ8j8g@intel.com>
Date: Wed, 02 Oct 2024 13:42:16 +0300
In-Reply-To: <Zv0Y4idp6NsQ8j8g@intel.com> ("Ville =?utf-8?B?U3lyasOkbMOk?=
 =?utf-8?B?Iidz?= message of "Wed,
	2 Oct 2024 12:56:50 +0300")
Message-ID: <874j5u7pmf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> writes:

>> >> v2: Clear only in il_pci_resume() instead of il_enable_interrupts()
>> >>     to miminize changes to runtime behaviour
>>=20
>> In wireless we don't include the list of changes so I'll remove this.
>
> Ack. I was wondering about that since most commits in the wireless
> code didn't seem to have one, but there were some counterexamples
> as well.

Oh, there are? It's a bit awkward that some subsystems do this and some
not, some consistency would be nice :) Not sure what we should do in
wireless..

> Maybe I'll remember for the next time, maybe not :)

No h=C3=A4t=C3=A4. I implemented an edit command to my patchwork script jus=
t for
cases like this :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

