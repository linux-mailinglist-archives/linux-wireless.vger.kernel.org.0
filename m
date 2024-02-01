Return-Path: <linux-wireless+bounces-2933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B400B8454DC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E622E1C248A9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F45157E8C;
	Thu,  1 Feb 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyhZML6f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A64DA1D
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782090; cv=none; b=NAa9y+Pm6oVcgiLZUnsfUDpLKOYO6ORsJEknY0MsTVa8j8Ame+NIfynv/pse7jF5U3yIQniVdjbqgwTJbWdcc8JwvEWe5/t+R5VrycNAI7zOatYCiPL8SRsOBs3/NiwqAYR8YV9VTwaDjXpGINSzNUi0lFzldSAOo6YZzHdmYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782090; c=relaxed/simple;
	bh=Gdv8hIKt6eBad+N3DBjY72wf8KMfr3gxUJndyEoNEuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=damNWD0S6nlvJt16oaXbKZGqe2NXOTImix49aPxK5CeS8/yC35V8ktZx02oJMPncdyosW08lnMpdxdabvD4FtT+8jS3+py+0pFnOABd3q6l5ruKRWuXMsPt2Bq5/6EWpxmxkdYzGpkReerlWDpoxb9pdR2KOltG89NtU2uvyiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyhZML6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710AC433C7;
	Thu,  1 Feb 2024 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782089;
	bh=Gdv8hIKt6eBad+N3DBjY72wf8KMfr3gxUJndyEoNEuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GyhZML6fzQmLZmW1XxarFRpZZ5O4rQW9Awpm7+jONVPEL4NFgdrqCASvfptPNVYKE
	 u2LcAgQJ4dyjpdzflZhZ1xbQVFhEipgPHNJbuR7mFeh1K06ZX/BTadEvKCJBAVxBSR
	 wFPPetRZhsId0ztxZfNWOmTb+hfzEqeSGu7+gc1OuHHh91Wi713JVw1weqvoLl/Uib
	 3bQI6/QxZ8rypIwpkAYldAs3eDT3mOpOP8ag6ReK7i00PNI41wh+ERgKFM3C4xXWPb
	 z6eGxijQ/pbp4rDgbYQlPQF20HNUeE21SXrHVOF2fVU6mYqrpeVLk3wgWZK38MGtqz
	 bx9tYdCIzc33Q==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: David Mosberger-Tang <davidm@egauge.net>,
  linux-wireless@vger.kernel.org,  Ajay.Kathat@microchip.com
Subject: Re: [PATCH] [v4] wifi: wilc1000: validate chip id during bus probe
References: <20240127004331.1334804-1-davidm@egauge.net>
	<415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com>
Date: Thu, 01 Feb 2024 12:08:06 +0200
In-Reply-To: <415a0e6e-5824-44a2-af2a-a75115d5a62e@bootlin.com> ("Alexis
	=?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 30 Jan 2024 10:06:44 +0100")
Message-ID: <87cytgv6nt.fsf@kernel.org>
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

> On 1/27/24 01:43, David Mosberger-Tang wrote:
>> Previously, the driver created a net device (typically wlan0) as soon
>> as the module was loaded.  This commit changes the driver to follow
>> normal Linux convention of creating the net device only when bus
>> probing detects a supported chip.
>
> As already mentioned multiple times, I am skeptical about the validity of
> keeping netdev registration before chip presence check, but I am not the
> maintainer, so I let Ajay and Kalle decide for this.

I haven't checked the code but as a general comment I agree with Alexis,
registering netdev before the hardware is ready sounds odd to me.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

