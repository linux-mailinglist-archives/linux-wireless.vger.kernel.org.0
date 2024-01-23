Return-Path: <linux-wireless+bounces-2371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464F838CEF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB00B2706C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424C5C917;
	Tue, 23 Jan 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rry5TbVa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A485C90E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008002; cv=none; b=FVlzeoJx5zT0gNGAO9DkQ6ewGUj7T0v3yy8WUoNeILiMSauy19nP/Ux7wIaoplD9AbuXVgAMfJwKfULtWm+S3DLtHwUOtpDwhkKfOTDWJXwZE2+/qgUQ7cHscAkOylFXfAYFq9XiChcw4gc+LZQWBDUEnSRN9AuTtIT/mn17fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008002; c=relaxed/simple;
	bh=zs5CHJy++SQwl6/eB9vKcVhuU+5vvUQ9UmFJz6zXHLw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XS7cExr/Apf9ljPTGeURztTmvaiQHSOMECCcP9IoQxwIUA2yFod9cHKtxhkxOr6s4BOCjDUAcrChU3iMsgV6RaN5yNStUwUMWHm9kjivScDHm3MysFudmBvGS+V4GbiHn2FmTlb/fY9lVPeHXAmdMlXfBkAVhmvjLjRL5YY9Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rry5TbVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4449EC433C7;
	Tue, 23 Jan 2024 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706008002;
	bh=zs5CHJy++SQwl6/eB9vKcVhuU+5vvUQ9UmFJz6zXHLw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Rry5TbVae3sni9V7KNqJK8IY6k9ixcvW4y6yDtTlfpqxj/Z1R9A0IvgdNV2EsJI4b
	 F5YjuhXhDdtcbNgmGjYQVg8kGDFXLk/Yp6khJw93ySQTRhtmyZ3KhQyPAKoKcx4TyH
	 a82gP6p7TEMVFr5aet++oBiLeW5GGK7vOBJU+WQpF2dg9KjM8KVJMc+rkxiugRWUYZ
	 EDomC8tCVph3qpH2bCfkp8se3BhEWwDVJ3DoHd/e0oZrZNyFZalo4u5W9pRNVH49rG
	 nECOeSQs/SIVspERD/dFHE6UGjvwmBSrxmO6iDqqIuO5Hs7HZNumaFPodB+GDYRCeY
	 UtLBqOjQvDh9g==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: David Mosberger-Tang <davidm@egauge.net>,
  linux-wireless@vger.kernel.org,  Ajay.Kathat@microchip.com
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
References: <20240122211315.1444880-2-davidm@egauge.net>
	<20240122220350.1449413-1-davidm@egauge.net>
	<751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
Date: Tue, 23 Jan 2024 13:06:38 +0200
In-Reply-To: <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 23 Jan 2024 11:18:36 +0100")
Message-ID: <8734uo2ts1.fsf@kernel.org>
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

> On 1/22/24 23:03, David Mosberger-Tang wrote:
>> Previously, the driver created a net device (typically wlan0) as soon
>> as the module was loaded.  This commit changes the driver to follow
>> normal Linux convention of creating the net device only when bus
>> probing detects a supported chip.
>
> I would gladly help review/test the patch, but please give us some time b=
etween
> versions to take a look (even if you can mention if you found issues your=
self).
> Also, each version should be a separate thread, bearing the new version i=
n the
> "Subject" line.
> Additionally (to answer your cover letter), the patches must target the w=
ireless
> branches (likely wireless-testing), not linux-next
> (https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)

Actually wireless-next is preferred for the baseline (unless it's a fix
going to -rc releases):

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

