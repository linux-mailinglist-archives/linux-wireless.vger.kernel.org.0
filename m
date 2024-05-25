Return-Path: <linux-wireless+bounces-8054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE28CEE0A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 08:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341981F21BC2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D6B65F;
	Sat, 25 May 2024 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q83foUHe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48CAD35;
	Sat, 25 May 2024 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716618368; cv=none; b=ilCenNdAFt3LVsKORp3kaTtABuElO/IVau3ouF43WyVwKK8cLv+HyB5vZUVYy6RpZ4hoXN6tOdN1c2oPOrhaOjzKj26nI2g3LZ8S7PWOFdRMXjenmXZXv9AwR4OCFDzdymF+98fbQaWUqCewrjY4S/LGbdS+HtHbRhds2cCMQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716618368; c=relaxed/simple;
	bh=FrQ0Seq2BG84rF7oUlf//L0FC3fJbD13/F2+vZoZNqU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=paE0HKJl2GAWn2Polnf/3ampiLPnQwMJsNMVAyHtEGk20KZM3ui4HwdFBy/BSPKSobyyDN+C/1QeBG/SJ/0194pn0Fdk3hzuorBoBJVvAMaxLpW8h3RpI9px+1Ce4aVgmcIExHfQjRyoNUvYrfu4zXaTLjT9/tx42JFHRYDglDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q83foUHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CEC3277B;
	Sat, 25 May 2024 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716618367;
	bh=FrQ0Seq2BG84rF7oUlf//L0FC3fJbD13/F2+vZoZNqU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Q83foUHevDHnZksCEJB4J9NU2Ty3Fr82O1d/5JBoTa/OpPMxoZgWRg//YiFLFSMxf
	 H98Pze5DoOJ47RYX12GwQO6Nip/K7B06qRxGl3MwWETp92FjreN/INaDeX6ztdQs6D
	 JQ4QiOKFsMNnKcscQeLk215uOesIlYY/iEIcF8H3rwidFwDnno+wUq/sXrv0db/PST
	 s1Z7vu35rKpQsFpRmP16a13teMChMguX/RvPuPrCuSc2Xrm/xi3Gca56i/TycfISSn
	 zb4RrPCay1Mm8gSpvS9gKsf2jx4LI1KohYMSDD91/Z5nnTEK/6ArEBu142B/g++Btq
	 w/YfBTQoB33/g==
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
Date: Sat, 25 May 2024 09:26:01 +0300
In-Reply-To: <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 15 May 2024 08:23:35 +0200")
Message-ID: <878qzy9zly.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
>> Also /cc Johannes because of this commit:
>>=20
>> 6092077ad09ce wifi: mac80211: introduce 'channel request'
>>=20
>> On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natalen=
ko wrote:
>> > Hello Felix, Lorenzo et al.
>> >=20
>> > With v6.9 kernel the following card:
>> >=20
>> > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E
>> > 802.11ax PCI Express Wireless Network Adapter [14c3:7915]
>> >=20
>> > doesn't work any more. Upon mt7915e module insertion the following spl=
at happens:
>> >=20
>
> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
> chanctx ops")? Huh?

Yeah, commit 2f7cf3b61d85 should have been taken to wireless tree but it
fell through the cracks. I didn't realise that it's an important bugfix
and the commit message didn't give any indication of that either.

But commit 2f7cf3b61d85 is now in Linus' tree so it would be good if
someone could submit it to stable releases.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

