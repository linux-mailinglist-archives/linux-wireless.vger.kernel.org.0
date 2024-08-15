Return-Path: <linux-wireless+bounces-11486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A8953254
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DA7289510
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5B1A0710;
	Thu, 15 Aug 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCCsjEMX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B71AC8BB
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730591; cv=none; b=gzEaMZ9y6sMnhxxtzDAwbYQB+tTvJEu6ugOy04l7fE8oC9KNvhiRevsR7D2iWj6ln1H/OwQDX7YHRFbilfcmU0KAR1TDMxChJvXuecYI8v9SjrdMLnC4uSyU3ioeZyL+Gpe/HIabsdZ8Yu3OYXXbKGFcSNpxRyVQsN1fdmxoDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730591; c=relaxed/simple;
	bh=eVQ3U6jCrHLtgSLoUrYnv1NnnjjvT+BRAWf5W+WadB0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y5cxi/Z2PBHnquS2Ce7XofouTeRfvqvWqeqAs455CHHvQF/vWtiMPK67m/vzYs0XQu/I0l6zBEzQhKK71UsKyANkUOiITAH34aSR0wkOeka6+8BaCVm5xUo8ufjsCafe+hdaREgIwG4ePjLpRRYKMM+FTOQj7hGx32TnZaH5v/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCCsjEMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054DFC4AF0D;
	Thu, 15 Aug 2024 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730590;
	bh=eVQ3U6jCrHLtgSLoUrYnv1NnnjjvT+BRAWf5W+WadB0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WCCsjEMXgWyuqwIPm3s9cTc2MiTRR0Ie2+Bf4ZUvtQK7mp2yROBt9AYmrM5oG1UO6
	 5vzuLBztCfIDm8Zjq9owzEoz36NR+3vpTrU7KT+vkC/jaelMOitScxeJqStCIKGAb8
	 unMfPcHD2eP1OQojYEu3auq+FHxlIvYx+GgLjpOZfElHrJRe865ayO+GYLEHPKg5LF
	 xdTtHfZZmez1L5FdTPFtHPtzOvdOaQoMVoxEo6ZLNptiBR1iDMVFm0NDlD43JFTma1
	 cd3Zi+T3iZqKCylOCvQ3JHy0aElyqtAFoOCNQiVbmJGiOeW6GWqqAq3Mzy2yzWg0Cu
	 /kkfk+i2ilbBg==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
	<c407064a-1c2f-46ec-ac57-32bf9cf6f5c6@gmail.com>
	<9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com>
Date: Thu, 15 Aug 2024 17:03:08 +0300
In-Reply-To: <9eafac85-2262-4f92-a70b-32109f65c05a@gmail.com> (James
	Prestwood's message of "Mon, 12 Aug 2024 10:33:30 -0700")
Message-ID: <87r0apyjc3.fsf@kernel.org>
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

> Hi,
>
> So I have no resolution to this (trying to get the AP vendor to chase
> it down), but I'm toying with the idea of trying to work around
> whatever issue the AP is having when this occurs. The only thing I can
> think of is that there is a 3 second delay between the authentication
> and reassociation, and perhaps this is causing some timeout in the AP
> and in turn the deauth.
>
> I'm wondering how long it should take to add/remove a key from the
> firmware? 3 seconds seems very long, and I question if this timeout is
> really necessary or was just chosen arbitrarily? Is this something
> that could be lowered down to e.g. 1 second without negative impacts?
> The code in question is in ath10k_install_key:
>
> ret =3D ath10k_send_key(arvif, key, cmd, macaddr, flags);
> if (ret)
> =C2=A0=C2=A0=C2=A0 return ret;
>
> time_left =3D wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
> if (time_left =3D=3D 0)
> =C2=A0=C2=A0=C2=A0 return -ETIMEDOUT;

I can't remember anymore but I'm guessing the 3s delay was chosen
arbitrarily just to be on the safe side and not get unnecessary
timeouts.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

