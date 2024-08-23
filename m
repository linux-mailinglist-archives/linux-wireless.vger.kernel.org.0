Return-Path: <linux-wireless+bounces-11851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B417595D13D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352CAB2D02E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB9188A03;
	Fri, 23 Aug 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0brHzPs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95050188A04;
	Fri, 23 Aug 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425652; cv=none; b=urAlv18T4BgAubhwHbmUVawkHS9+2Wo91Ng15clcqRwlVEO4hc8k7/Wa7NhZQdgUpQlJq4eVk0Ne4hvwlafTgdNS5bwBKx4jGlVEyhgpXwJUOODaqmJN9KKufk7GTRgdVzdeACrUiZH9cZRHMft5I7Da6HOROTWLqOJRe10IcuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425652; c=relaxed/simple;
	bh=+aYPioaCTKJ31j15avs8Y4IbRInMqsYWr5TM+2fj4W4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=r+GYsHXP6wPkWXE4ONJ7Mr8HJHJOTihnEEpeWn6NrlDnNUuZh5t/MyaUOE91d9llgBi0ZDUAXu5DJIhKHn/ZAJ6XR+fZU0KgERpX+Dw+LFoG94mN9ip3RJVSZ0Lix+tlW+kGpNWVTcYD825EeJMGtlkQDz0E1vyjTFbhzTyOKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0brHzPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B5FC32786;
	Fri, 23 Aug 2024 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724425652;
	bh=+aYPioaCTKJ31j15avs8Y4IbRInMqsYWr5TM+2fj4W4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W0brHzPswrdmOoOH0RQKJIk82725+K4MLChFvlDaJ03VOds33SAmKrBmFAOY43eHy
	 YcsFo3FeyRxNmO+7Cm8zQR4IU7xp2kac4FttHFXe1DhnWEpP7cx5oDictFX0dsyco3
	 jJQsAJZU7EuswbMGE0ilQT1UqWOK2o00CAaHE2dXEyvnSoQpXDEwv0Fj3OS+H7RYXb
	 t1Q639lr2nqd0/DrdKrVn8apDJxSna9ZDGorngTeHpeIY/jIOPNQXQEpt9jXG6IyWJ
	 yEkaTz7fvJj8djw0OTMHPlVDtXKJyaygSXE9SESrS5n7NbB5EaM5Wb6saogRdeB0NG
	 ler/huYQHdMYg==
From: Kalle Valo <kvalo@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-wireless@vger.kernel.org,  =?utf-8?B?SsOpcsO0bWU=?= Pouiller
 <jerome.pouiller@silabs.com>,  Dmitry Antipov <dmantipov@yandex.ru>,
  stable@vger.kernel.org
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
Date: Fri, 23 Aug 2024 18:07:29 +0300
In-Reply-To: <20240823131521.3309073-1-alexander.sverdlin@siemens.com> (A.
	Sverdlin's message of "Fri, 23 Aug 2024 15:15:20 +0200")
Message-ID: <87o75juvke.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"A. Sverdlin" <alexander.sverdlin@siemens.com> writes:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> RSN IE missing in beacon is normal in open networks.
> Avoid returning -ENODEV in this case.
>
> Steps to reproduce:
>
> $ cat /etc/wpa_supplicant.conf
> network={
> 	ssid="testNet"
> 	mode=2
> 	key_mgmt=NONE
> }
>
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> nl80211: Beacon set failed: -22 (Invalid argument)
> Failed to set beacon parameters
> Interface initialization failed
> wlan0: interface state UNINITIALIZED->DISABLED
> wlan0: AP-DISABLED
> wlan0: Unable to setup interface.
> Failed to initialize AP interface
>
> After the change:
>
> $ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
> Successfully initialized wpa_supplicant
> wlan0: interface state UNINITIALIZED->ENABLED
> wlan0: AP-ENABLED

BTW excellent commit message, immediately obvious what was the problem
and how it was tested. I wish everyone would do the same.

> Cc: stable@vger.kernel.org
> Fixes: fe0a7776d4d1 ("wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

I think this should go to wireless tree for v6.11, right?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

