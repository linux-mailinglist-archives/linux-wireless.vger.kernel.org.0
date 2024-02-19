Return-Path: <linux-wireless+bounces-3780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53B85A816
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9171F20F80
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BB3A267;
	Mon, 19 Feb 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1dJvaP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18837702
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358631; cv=none; b=AseFjq3wfZj06FtXIGSJhA4o6Dg0R/B8b8cypoDNDCxEB8wLm1YnVI0xqcFyy9bOPeCUwHeV7be0dT18ZKBAXlbN8lBXhX6UlVKXXPiWu44RQZTtQ3dM89iiutI0zkqCjml8GCvPB4lKVAMjlyh8gROg/XjKwSxIyVUuOGWMAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358631; c=relaxed/simple;
	bh=bqCw6mBdYHg9rZSQB4QqNheq06hc6Et8J9deQhG2r0E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Qodz24JV6o7qCK2op9pr4zGiVIPnJXYadVEJr7NxEtQNlXAS7M4btRz6zbY5n3H5g7cAU3J99h+8R+KokmgHpA6KvImQcL7ZEFVrFcVytdNwuTtftWYGG30NF5voZ/OhYhyPmf3b/+xrSaqRB071PcNKzILfsDuqeO5C8OC6Wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1dJvaP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139ECC433C7;
	Mon, 19 Feb 2024 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358631;
	bh=bqCw6mBdYHg9rZSQB4QqNheq06hc6Et8J9deQhG2r0E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=j1dJvaP1T3v2ts8NQnJYzeKvBbsRGlJD+RVecQTFauFOXJr8PCyNPQ0xfJtsjjxlP
	 4g1tkFg5UgY5A+beFgRNg5C3lHfsx+vnq0MzUxd3uh4yEWPYfHOT9mseyLRTF/5x1i
	 6tSrx+1PjQkoc8+q0+qSQcybbjq4W+KM40QLX5OD34tEQinn+lRtvnBqoEoeXQ6IOw
	 MIIBo2bz68Ae81pLii7T0OdnblwGPoFyrYG8mO4PsFPaiKwwsgMj5TkuzO46N2FyMu
	 NlRMQ0GnOv6VAdc11BzRc2dnjU4u0GCpOwKajudee7WgdAkBQ4lFqcJAMCdVDR3t5n
	 6CCxATfvwj6MA==
From: Kalle Valo <kvalo@kernel.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Brent Roman <brent@mbari.org>,  linux-wireless@vger.kernel.org,
  martin.blumenstingl@googlemail.com
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa RockPi-S
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
	<9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
	<f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
	<b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
	<878r3hc6hy.fsf@kernel.org>
	<42772df2-32b3-2b37-045d-b528a752bef7@mbari.org>
	<874je4dfoy.fsf@kernel.org>
	<99fc641f-f73a-4fa6-b3c1-1c19ac697602@lwfinger.net>
Date: Mon, 19 Feb 2024 18:03:47 +0200
In-Reply-To: <99fc641f-f73a-4fa6-b3c1-1c19ac697602@lwfinger.net> (Larry
	Finger's message of "Mon, 19 Feb 2024 09:40:43 -0600")
Message-ID: <87le7gmof0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 2/19/24 02:24, Kalle Valo wrote:
>> Brent Roman <brent@mbari.org> writes:
>>=20
>>> Yes, that's all true.=C2=A0 However... Random MAC address assignment te=
nds
>>> to cause devices to be assigned a different IP address on each reboot.
>>> This often doesn't play nicely with port forwarding.
>> Sure, I wasn't claiming that using random addresses is the perfect
>> solution. But you could also set a fixed random address from user space
>> (hopefully that works with rtw88).
>
> That will require a new module parameter, which the community does not wa=
nt.

Where is the new module parameter needed? I was thinking about changing
the mac address using the standard interface, for example 'ip' tool or
similar. I think mac80211 supports that (see ieee80211_change_mage) but
I haven't tested it.

I'm worried that we are talking about different things here so maybe
it's best that I'll wait for the actual patch before commenting more.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

