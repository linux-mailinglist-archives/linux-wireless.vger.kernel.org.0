Return-Path: <linux-wireless+bounces-8419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFD8D7F92
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C29028C3CF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA67E796;
	Mon,  3 Jun 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV7kgAp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951715BB;
	Mon,  3 Jun 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408912; cv=none; b=J8kLraQuTtDHs5lQAgwudKRT5y/rjxJ5d1QgldUFEGViVQ12GiEtgFH4qnpv4MRiI3xAfUb/sbK979+PeYrGeP5n/J1j/qp1uuJSr7xFahG5GjhHUO/BWVEuZGAI9FiWwRQcK82GYE9YkB0jjisVd/JAL0PpRYw/B/9EhfXW33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408912; c=relaxed/simple;
	bh=uLEf7qEfTUJ9Z6AQPw+OI7k1bYnoKO7ZNGc7O+74gYQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BHAqjknl9IFUHE+ctPhyO5C4yVMmDIQ9oox3Q9okZoAMEPGeGP2TuIVvpOFucN7k3W+HjzDRZn3DrOAavT8gsBkQzYJdzcEtjLKHwHbIRq38cpdwPt/PjlMFsf3P1wKUttvYFqOFfeQH9tsQtYHgqhXclVCNJqf+kcej/3ZCMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV7kgAp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC2AC2BD10;
	Mon,  3 Jun 2024 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717408912;
	bh=uLEf7qEfTUJ9Z6AQPw+OI7k1bYnoKO7ZNGc7O+74gYQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pV7kgAp/1w6u0Oh8cJkZpvcuEDwm2zeICSqbmhqCS7c6qqSTk1towBosbbVdI3O85
	 tXozP2v5TXqlXMiYKXGN2uofVNrqrApnvu9kO90kkkBTIc2UDsX3E6+CavZLq1zxat
	 JV2ru4YZQmfTkdgHZ4zmjKokczxJskuMeErjnsCckEKW4veT5g8iEWa6YsYtcbqei7
	 1lFP/25YT1qeVDDRxoiEtri5K5Fndtj5i0YUcLrkn1vh+56ask+g+H2fPfrCmioQ0M
	 RUSI/1Jr9Z/tTZv9si4YB0XF1DdrWAGF4yN3nXEVcWMrjMMHpfVaTTnT7SbHglL/Ey
	 JM9XEM+yZKzkA==
From: Kalle Valo <kvalo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Johannes Berg <johannes@sipsolutions.net>,  Wireless
 <linux-wireless@vger.kernel.org>,  Alexis =?utf-8?Q?Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
References: <20240603110023.23572803@canb.auug.org.au>
Date: Mon, 03 Jun 2024 13:01:48 +0300
In-Reply-To: <20240603110023.23572803@canb.auug.org.au> (Stephen Rothwell's
	message of "Mon, 3 Jun 2024 11:01:12 +1000")
Message-ID: <875xuquyyb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the wireless-next tree got a conflict in:
>
>   drivers/net/wireless/microchip/wilc1000/netdev.c
>
> between commit:
>
>   ebfb5e8fc8b4 ("Revert "wifi: wilc1000: convert list management to RCU"")
>
> from the wireless tree and commit:
>
>   6fe46d5c0a84 ("wifi: wilc1000: set net device registration as last
> step during interface creation")
>
> from the wireless-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks. We need to figure out how we solve this conflict, most probably
we'll ask network maintainers to fix it when they pull wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

