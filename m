Return-Path: <linux-wireless+bounces-8684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCE9000CD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B866628786C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB815D5C3;
	Fri,  7 Jun 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ1RE9Cq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744B15D5BD;
	Fri,  7 Jun 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756202; cv=none; b=cHASspIXKZp4AO7b0lAG12bnckTMEmusVjx/ZTPQjQfFzeQQKjqj++IEXth9eFMlQYLdVVFch8tlwH+j9pv2UnDGzJS5Y/iOthTRnwpoO9PdAkUYDuEifj3sRbfqjI5zq6gyxRHDJq/rhSRgcx46Fr36/ApsmlTQKpivM6dBo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756202; c=relaxed/simple;
	bh=y5IwuyaQDrnSDBJYNI75IW6lnQ2FscwzbDOcz+9Y8e8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f3aaAqjOkDHHFajdjFmnonFbMDil48nW30pX+XNBDBoMzRb16qFU0xU58jA5ugdF2VRuqHkVzXjfbvjcfUULBUO9pzPdp9eWfBE9JfJl3QdYRbLuoAST27+JQoGMVz4fYObX8OrqqnwjPRTp74XSx5tyjLvjcXPJnHXaaXf2h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ1RE9Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C12BC2BBFC;
	Fri,  7 Jun 2024 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717756201;
	bh=y5IwuyaQDrnSDBJYNI75IW6lnQ2FscwzbDOcz+9Y8e8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fJ1RE9CqPShL6jkbKXg+pN7edrFIkH+1YdVP8jV6lMOgeGixIMhQhGsfGUVooRVUW
	 WmgNapo5D+ms1MWzt+u3mB9cpwxFqmhz7Pqr9P4P3ETbUKrjcAhZYL/EA6w1ODhhw7
	 7dPcgs3WcpwrdSvMbppWn1J3TBDtmSPvIWk3tPxGCFNBB4A6A/TXOfkcXzduFpuzvu
	 m0y3pxWD3hkRTsTmRTsPb694fsUjmEZwPK3NPUGs65ClmYdsrQRduRT9B/rKuCwI/L
	 3q8F9PKtseEOA5mYea/nvkBXuzOPI75ZQze/eHPIMGJPNA1AcGB43HdeH1xIaZq67p
	 1Y+1kWG3vvAyQ==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,  Johannes Berg
 <johannes@sipsolutions.net>,  Wireless <linux-wireless@vger.kernel.org>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
References: <20240603110023.23572803@canb.auug.org.au>
	<875xuquyyb.fsf@kernel.org> <87tti6qt5o.fsf@kernel.org>
	<317b515f-30fb-4b18-bb99-b65091449ec4@bootlin.com>
Date: Fri, 07 Jun 2024 13:29:58 +0300
In-Reply-To: <317b515f-30fb-4b18-bb99-b65091449ec4@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Fri, 7 Jun 2024 11:44:10 +0200")
Message-ID: <87frtpoxjt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> Hello Kalle, Stephen,
>
> On 6/6/24 12:09, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>>=20
>>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>>
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the wireless-next tree got a conflict in:
>>>>
>>>>   drivers/net/wireless/microchip/wilc1000/netdev.c
>>>>
>>>> between commit:
>>>>
>>>>   ebfb5e8fc8b4 ("Revert "wifi: wilc1000: convert list management to RC=
U"")
>>>>
>>>> from the wireless tree and commit:
>>>>
>>>>   6fe46d5c0a84 ("wifi: wilc1000: set net device registration as last
>>>> step during interface creation")
>>>>
>>>> from the wireless-next tree.
>>>>
>>>> I fixed it up (see below) and can carry the fix as necessary. This
>>>> is now fixed as far as linux-next is concerned, but any non trivial
>>>> conflicts should be mentioned to your upstream maintainer when your tr=
ee
>>>> is submitted for merging.  You may also want to consider cooperating
>>>> with the maintainer of the conflicting tree to minimise any particular=
ly
>>>> complex conflicts.
>>>
>>> Thanks. We need to figure out how we solve this conflict, most probably
>>> we'll ask network maintainers to fix it when they pull wireless-next.
>>=20
>> Alexis, you know wilc1000 the best. Could you double check the conflict
>> resolution, it somewhat complicated:>
>> https://lore.kernel.org/all/20240603110023.23572803@canb.auug.org.au/
>>=20
>
> LGTM, and some quick testing on the linux-next tree with the correspondin=
g merge
> commit showed no issue (no RCU warning, and mac address loading fix behav=
ing
> properly)

Excellent, thank you so much.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

