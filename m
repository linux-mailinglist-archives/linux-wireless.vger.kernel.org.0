Return-Path: <linux-wireless+bounces-15329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83039CF207
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E5296138
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB81D6193;
	Fri, 15 Nov 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K0X45QKZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D01E4A6;
	Fri, 15 Nov 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689158; cv=none; b=RZcCLQRcDjOTzkj9fkdkRlMaPCJ7uhwBqQAvQHHpxzgEe0leXUO2wq/mw0Dg2aZAPU69qUWuQXpkpJ1T32nuJLbxX2dU+DdrVrDG0y7vFOMnjncI4zFA1SqV9US1e9XEA8XxLNCa0y97QF8LLgOD2++bFTVVqs02YJQMMH4rcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689158; c=relaxed/simple;
	bh=QlTFpx4lRlHiQlpCKvHFweBi6bjTVBt/ODsa8/fKl5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkPc48Z3I3LLj8bskWvr2E5z4M2L349escYoM/4iasnNCR/95LzShw7EFQWg0eqLdmySVOLQAv4UDNZ9fe9ZXmyqxHi7HYYsUHyY6j/f/pL6YFbkc7TniRdgyPUN3dhfZjPXVG5Ru6dHJzTfupzDYYo/WYAHreu/6kLvZFFVpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K0X45QKZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3KHZY67bwe+QllEESueRK1qzee8uwp0gZy3HnGfpwfY=;
	t=1731689157; x=1732898757; b=K0X45QKZw+dxDS7o/vdIceLqaHneh/0r8FFDZljzssWof55
	LonLWOcZqlr7bZt1B6ZvHP3uf8H5ceKCalMdwkEKOZ2uR8csB1oYDiZK1V3leaJoVGF8vZV1G7PZT
	iwJ+1FmQP0nk8z+5Jo4jsIy5r4Fp11T1oYZI7Y9rrZrXboP99Yc3KvgX6ETn8JBwar8efzHtWHmk+
	t9z/xKEiZPCKrdIAJXHmXIEDFu9jhJdRZdd3wXIBcYWlcCOBlSZMvAAD0mH/1c8PlM7whygSli9/T
	09b6wjfxDJbaOApkm/sMeX9Klwai+YwF/efpuzArP9QeYIKXEjUm6NkhVjyPmakg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBzS0-00000005eqO-14gI;
	Fri, 15 Nov 2024 17:45:40 +0100
Message-ID: <49aec9dffbd9cf4d1ea0efe9d3cb36afb3e31aea.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	pablo@netfilter.org, linux@armlinux.org.uk, richardcochran@gmail.com, 
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com, dsahern@kernel.org, 
	wintera@linux.ibm.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	jhs@mojatatu.com, jiri@resnulli.us, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, netfilter-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Fri, 15 Nov 2024 17:45:39 +0100
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
References: <20241115163612.904906-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-11-15 at 08:36 -0800, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
>=20
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).

Sure, I thought we were running kernel-doc pretty strictly now, but I
guess there's always something to add :)

LGTM. I guess some like e.g. netif_attrmask_next_and() could also get
just more docs in general, in that example have something like "returns
the next set bit or >=3D nr_bits if ..." but that's really unrelated.

As far as wireless is concerned:

>  include/linux/rfkill.h             |  2 +-
>=20
>  include/net/cfg80211.h             |  2 +-
>=20
>  include/net/mac80211.h             |  2 +-

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

