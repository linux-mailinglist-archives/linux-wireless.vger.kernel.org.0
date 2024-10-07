Return-Path: <linux-wireless+bounces-13607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98434992FA4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F16B1F22481
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983491D47C8;
	Mon,  7 Oct 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcuNPxs/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EA1D1E89;
	Mon,  7 Oct 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312182; cv=none; b=qwdhZe/jQ9Z5xkTdshxI4sArJpUybILCAk0smsIunUN5K5ciGeCPFbtm0IXtuQiwM5hDDkxezViyUZ5UFeAOAHXWoV9GLEFB72PT9EutzL46M4/ABjUNht+W06DXl15ZN3/QfbGwQEThTQEvmvBn9CrGx0dgos0YSUhw+n/6G4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312182; c=relaxed/simple;
	bh=bxflFMmoIHHJ2/sBv0Phldh29w5xHLxp+lQC/bWZNv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWuvKdhNnDD5Zujk2wCuyC4oNYqfVVkmFfYccPVCWqF34eReoPP8pUvasTCr/Dk9orYvNMCwzUzX4ZVaAVwrUpzoFcWkWw8exgGycKxG0HMGN3e/aUfvEwiUnIMVhLVcVckwq9EBQd0PMJo69tfpdKzsKRKHbTALgRAvRIKZQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcuNPxs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C18C4CEC6;
	Mon,  7 Oct 2024 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728312182;
	bh=bxflFMmoIHHJ2/sBv0Phldh29w5xHLxp+lQC/bWZNv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CcuNPxs/u1FJaZxX+XoWvGn/ym3/gjY60SIr/QO7BtA5UVKVBHiobJSrcEAotYKxt
	 lNGDTf2pQ5PDkAiehu7DPJRJNpkC0JJ6geditV/CVgGfjzrhlfHLxy4grpZdRVsBvd
	 h9nL0GNt+jdZamVZ9ztoeXVjgygtinbH6wKb1XHXxRIZRPN7e+R/UJ90Ttxf4vVUjC
	 6Aa9Rt+DcWGbVWLiaGJb4XF0Mu++6boeq803kYVMS7uPPt3sbe25p50loq2JEXpjpp
	 AQOlo1EUL+Fga8INzSuqo15zb1lVokP3q0ZjXMBzVMhbiljbi4mNYdGiYFaRlM0FVT
	 pppiAmPa+c4SQ==
From: Kalle Valo <kvalo@kernel.org>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: Arend van Spriel <"arend.vanspriel@broadcom.com>, Vinoth.Sampath@infineon.com, Syed.Hussain"@infineon.com>,
	<Double.Lo@infineon.com>, <Carter.Chen@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>, <brcm80211@lists.linux.dev>,
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: wifi: brcm80211: add Infineon DEV list for
 communication & maintenance
In-Reply-To: <20241007142955.111232-1-gokulkumar.sivakumar@infineon.com>
	(Gokul Sivakumar's message of "Mon, 7 Oct 2024 19:59:55 +0530")
References: <20241007142955.111232-1-gokulkumar.sivakumar@infineon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 07 Oct 2024 17:42:58 +0300
Message-ID: <87zfng3rf1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gokul Sivakumar <gokulkumar.sivakumar@infineon.com> writes:

> The Infineon E-Mail distribution list <wlan-kernel-dev-list@infineon.com>
> is a replacement for the obsolete list <SHA-cyfmac-dev-list@infineon.com>,
> which got removed from the BRCM80211 section in the MAINTAINERS file.
>
> The new distribution list can be used by the community to contact Infineon
> WLAN Kernel DEV team, and also for Infineon team to get notified with the
> activity in the upstream kernel brcm80211 subsystem.
>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77fcd6f802a5..adfbf5af9eb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4475,6 +4475,7 @@ M:	Arend van Spriel <arend.vanspriel@broadcom.com>
>  L:	linux-wireless@vger.kernel.org
>  L:	brcm80211@lists.linux.dev
>  L:	brcm80211-dev-list.pdl@broadcom.com
> +L:	wlan-kernel-dev-list@infineon.com
>  S:	Supported
>  F:	drivers/net/wireless/broadcom/brcm80211/
>  F:	include/linux/platform_data/brcmfmac.h

A lot simpler is that Infineon subscribes to brcm80211@lists.linux.dev
list, that way there's just one list for all communication. And actually
broadcom could do the same?

I'll also fix the linux-wireless list address, it was wrong originally.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

