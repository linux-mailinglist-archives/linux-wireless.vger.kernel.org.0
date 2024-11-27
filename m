Return-Path: <linux-wireless+bounces-15757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF49DA6E7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 12:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD5B2171E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061E1F8AFB;
	Wed, 27 Nov 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQCK0hz1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795051E0DCD;
	Wed, 27 Nov 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707413; cv=none; b=JYgnitmnrLMwdyC8wR9ImRLVFGA0UhZOfU63kr+PlLXlLwYjGtCAQdVwOEJBPinNBSRQjpLXvRgTxt1IEbKAij71LFSBpS+wi0IxcI/kIbvQAaQI39NZATpcl+fZzrj2QGbNDvUONcfQZvHC+E2i3RdItfK1WlsNjx/FY28isIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707413; c=relaxed/simple;
	bh=Id9ko+s5htGXfNjMB0EdrVaOKZQiusdnbpWHrvTf2EU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FN8A0nvcls/BwW9KznI3UPOw2JX3enbe8qpAiNO1wl/T1z38BMH8+2aY48VK+mY2tj0rAwpTbHdM/rsZVW9GWNBLJiP4B44o75m4wBeHyzVJkv1L7Scir2wKL381qsdoP+K/zsUj4IUqlPpef5MHhKj2g4zOlX6W281OswrSCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQCK0hz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE18DC4CECC;
	Wed, 27 Nov 2024 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732707412;
	bh=Id9ko+s5htGXfNjMB0EdrVaOKZQiusdnbpWHrvTf2EU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qQCK0hz106So74q2QhKkrS2G3wxMb6bMIo4pOXz31vSiAtFDS71elBx4rDmgLjPsn
	 oARzQhNiRX2MABLd0Zya0o3uuVeWyrRX32dSG56weg66NhcPA+KHKkg0mcFXCx9a7v
	 zkU4xYyso+LDXPLcGY7H2crliOzlBTIJzzbXBPLNMjDsJwIQl2qoARjQRMuHUMAqOe
	 dKF8Go3v2RsDM8GvZHGPuLhncoGTkrNCZa819+nwV6FHXVc3m21ECwClcD1zZt0TBe
	 218oqATIBndIhzynWtzzHISzeiUjMSCahZx7aAU5ADLKcmSzzncc7bQgUlZ7cXq/Kj
	 l8UBzFwpVvEMA==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org,  LKML
 <linux-kernel@vger.kernel.org>,  regressions@lists.linux.dev
Subject: Re: WARNING: drivers/net/wireless/ath/ath10k/mac.c:8750
 ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]
References: <637c5bb4-5278-44be-9ac3-9c0ef9297162@molgen.mpg.de>
Date: Wed, 27 Nov 2024 13:36:49 +0200
In-Reply-To: <637c5bb4-5278-44be-9ac3-9c0ef9297162@molgen.mpg.de> (Paul
	Menzel's message of "Tue, 26 Nov 2024 09:58:22 +0100")
Message-ID: <8734jcx60e.fsf@kernel.org>
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

> On the Dell XPS 13 9360 with Linux 6.12.0-08446-g228a1157fb9f, I
> noticed the trace below:

For others, commit 228a1157fb9f is from current merge window so the
first release will be in v6.13-rc1.

> [16805.002289] ------------[ cut here ]------------
> [16805.002296] WARNING: CPU: 3 PID: 65835 at
> drivers/net/wireless/ath/ath10k/mac.c:8750
> ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]

[...]

> I do not see such a message in the logs since September 19th, so I
> believe it=E2=80=99s a regression.

Have you seen it only this one time or multiple times?

What kernels have you been testing prior? I'm trying to pinpoint what
versions kernel version work and what have this warning.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

