Return-Path: <linux-wireless+bounces-383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F154803A1A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50EAB208C5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779E2DF73;
	Mon,  4 Dec 2023 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDRxVbwm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C532D796;
	Mon,  4 Dec 2023 16:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE7CC433C7;
	Mon,  4 Dec 2023 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701707035;
	bh=ZbKR/GiibxinMTwe3e1OL0Fk+/8nfwiJudNZL/nfcCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZDRxVbwm2GN/xBSUZOmrGkqtv7Xp4TMPCwMyiF8S+KkDBJdk/IpcWQEcnhiefUhsd
	 vXiT1+vs/5+5wUEvZF06zYVGojR9mtQyIY3YEzIFl+geUIUFptBqvGLglTr4E6IYd1
	 dYuJX7RZ57RMJ44NyozolZIJ96w81GC2xyi987CgMlRLSVPml+YiaIJDcbR8KURw0m
	 idCPWULoSF0cYuB0IRdMpIteazE7pd+yK3FdqTbkCyf93rgLT/IqQoCfxz9/5yjECJ
	 pDBgdQJ3YKuS4kzSeJjIzdIgiJFMnjmFN+FxmyDL6mmnxFgrJxg8D7Lox4LFq3jRqq
	 RuKWcGYgFZ3wA==
Date: Mon, 4 Dec 2023 08:23:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
Message-ID: <20231204082354.78122161@kernel.org>
In-Reply-To: <efd89dee78a4c42b7825fa55bbceafad9bb9df36.camel@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	<20231201104329.25898-5-johannes@sipsolutions.net>
	<20231201162844.14d1bbb0@kernel.org>
	<339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
	<20231202104655.68138ab4@kernel.org>
	<efd89dee78a4c42b7825fa55bbceafad9bb9df36.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 03 Dec 2023 19:51:28 +0100 Johannes Berg wrote:
> I think I wouldn't mind now, and perhaps if we want to sync in netlink
> we should also do this here so that it's consistent, but I'm not sure
> I'd want this to be the only way to do it, I might imagine that someone
> might want this in some kind of container that doesn't necessarily have
> (full) access there? Dunno.

Also dunno :) We can add a "sync" version of netif_carrier_ok()
and then call if from whatever places we need.

> We _could_ also use an input attribute on the rtnl_getlink() call to
> have userspace explicitly opt in to doing the sync before returning
> information?

Yeah, maybe.. IMHO a more "Rusty Russell API levels" thing to do would
be to allow opting out, as those who set the magic flag "know what they
are doing" and returning unsync'ed carrier may be surprising.
Also a "don't sync flag" we can add later, once someone who actually
cares appears, avoiding uAPI growth =F0=9F=98=81=EF=B8=8F

Anyway, up to you :)

