Return-Path: <linux-wireless+bounces-8055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14C18CEE0C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 08:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64272281685
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D0B660;
	Sat, 25 May 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG560QP0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E7B65C;
	Sat, 25 May 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716618944; cv=none; b=qQ4uNkffeDwG2wwWJQac/7fkZQE3pQnBukjmYwWnPW3x0lhFo+DPmFkz/cKq3j2Lfo/OxKQthFih2ALagrb3ktw9M1wRyYcTmGcwqZy10sBOdF0EN4f5ujw3wAFkDhZc8DAQ9Dm+AgyT2jsmJSvRIaHOl3mDe/hKa0b0Rrv11LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716618944; c=relaxed/simple;
	bh=RkSOasl4Cv6gTpeIPkA439lTvWAtTE6MvjOB6/84eGE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=K6VLmUwtJph/ReOPEjHkgWUT0kPRlaGQXaZncmomfSGA7Ucz8HhVfm8s2RpyqLqPkr5G73l4+UiXj2U8ABNoodFk5/vxESp12cPqh1tTzI6bABDVXhaRCehIEQyTmWQUs5yHquFDeY6R/70K+hVqNi90SjD0ivAJOOolE0ei6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG560QP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C4AC3277B;
	Sat, 25 May 2024 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716618944;
	bh=RkSOasl4Cv6gTpeIPkA439lTvWAtTE6MvjOB6/84eGE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=BG560QP0UQxEWQoWfBDB4EzUDAgarM8NaD1brHxJIl4va5VvnTnDLhgU9RmF3VwJO
	 lIqke26BqnMsQrX+hQBExNl2u1ydwWB2R6+dPbvW8CBk7MitPiiz1WmfztYHnd4FvJ
	 eJzYblpUGpZBapkJQ2FUt/zPadAqBvENABxBuWzVSmArPVKFNECKFirLPRp2Gdqto+
	 fcAO9XwQAl87KnDbQdhlDHG6KIr3q5zGNAVkV0Um2iW1cJASuh5gu9QK1VaOUioKeU
	 OWMsayQgurS8WIWtxO1DK4VdJgedMmWpB8afQpHzc5MzAx7cGfF4ej0TjPYAF+nfU1
	 DYZLZH3iDNIAQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
  linux-mediatek@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  Felix Fietkau <nbd@nbd.name>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Ryder Lee
 <ryder.lee@mediatek.com>,  Shayne Chen <shayne.chen@mediatek.com>,  Sean
 Wang <sean.wang@mediatek.com>,  Matthias Brugger <matthias.bgg@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
  Peter Chiu <chui-hao.chiu@mediatek.com>,  StanleyYP Wang
 <StanleyYP.Wang@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
References: <6061263.lOV4Wx5bFT@natalenko.name>
	<2341660.ElGaqSPkdT@natalenko.name>
	<60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
	<878qzy9zly.fsf@kernel.org>
Date: Sat, 25 May 2024 09:35:38 +0300
In-Reply-To: <878qzy9zly.fsf@kernel.org> (Kalle Valo's message of "Sat, 25 May
	2024 09:26:01 +0300")
Message-ID: <874jam9z5x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> Johannes Berg <johannes@sipsolutions.net> writes:
>
>> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
>>> Also /cc Johannes because of this commit:
>>>=20
>>> 6092077ad09ce wifi: mac80211: introduce 'channel request'
>>>=20
>>> On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natale=
nko wrote:
>>> > Hello Felix, Lorenzo et al.
>>> >=20
>>> > With v6.9 kernel the following card:
>>> >=20
>>> > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E
>>> > 802.11ax PCI Express Wireless Network Adapter [14c3:7915]
>>> >=20
>>> > doesn't work any more. Upon mt7915e module insertion the following sp=
lat happens:
>>> >=20
>>
>> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
>> chanctx ops")? Huh?
>
> Yeah, commit 2f7cf3b61d85 should have been taken to wireless tree but it
> fell through the cracks. I didn't realise that it's an important bugfix
> and the commit message didn't give any indication of that either.
>
> But commit 2f7cf3b61d85 is now in Linus' tree so it would be good if
> someone could submit it to stable releases.

Johannes pointed out to me that the commit is already in stable:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-6.9.y&id=3Dddb02739a2be54ed922bce3cb57d5f901590ee70

So all should be good now.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

