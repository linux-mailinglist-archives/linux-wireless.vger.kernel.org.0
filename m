Return-Path: <linux-wireless+bounces-7679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D58C6213
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3F81C20DB9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529447F53;
	Wed, 15 May 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drzJz1u1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABD47A79;
	Wed, 15 May 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759345; cv=none; b=BETOZ2+Qpn34h+gxVHRmDg0u0WwCXAgxSukT3KaiPVK23VyoxPTNQ88+K+0fJezJeSAhbr5l/gjNk2V+PE3vUEjRykvZ4zfl7aHx209tXVxEMptcG7tGBhb3bbU/u27spy4Gp1cTf8UmY9JgnOxnq0SLUg6P0f5IG6GQuzRshuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759345; c=relaxed/simple;
	bh=ge8e4h3UMypPCIdfQ9dILMu/Uub24xtFTsawJKyXGXA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O33jHbmmupkeoytKtfNvNUX/EmkDpaDUupbseQCS8Ivf1/KKE1bGRAfdE3D4O7KbpVzdk+Kja8ohA2V+D9G/w/nmbJNZCN7Hqqmf2HQluyauPUkr/WSqWuyOWtnh20V+K3r29OdhPKY7oaBL+h/txc4Q/E27WLHsQJ9/NHVu570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drzJz1u1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6255BC116B1;
	Wed, 15 May 2024 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715759344;
	bh=ge8e4h3UMypPCIdfQ9dILMu/Uub24xtFTsawJKyXGXA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=drzJz1u1/ePj3xCPiPsgyWP2UtQ9Tc2bHK6Fx/miLrBfoqCZd31POrlfy7mi8V4zK
	 deIdpBqlx2zfdxgCIZOCEMwsl7/j7lD7G+PvbiSPqw1SzYINeI/HO04E4AsZegECxN
	 V8qR8CL2MCJYkrhmYOHxQ9BP3HkTZxtpVMZqBizGeNA11X/32nQOdA+rKc0qqhfhs0
	 VCBwc80fx/eyIEl0Nn+IPMce+5Shnjo05AwfxH48bEVLa3ndqatQMppDOFV/W8vfPY
	 k0ROHvuajNuzw5g8Vo1BtnUvpe0wzE5XeA/HKuU21TEdhkjC0yx1Z6r8dqrD+RbrHE
	 LaW5HOfpMNQ6A==
From: Kalle Valo <kvalo@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org,  "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
  Johannes Berg <johannes@sipsolutions.net>,
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
	<2200096.irdbgypaU6@natalenko.name>
Date: Wed, 15 May 2024 10:48:59 +0300
In-Reply-To: <2200096.irdbgypaU6@natalenko.name> (Oleksandr Natalenko's
	message of "Wed, 15 May 2024 09:15:12 +0200")
Message-ID: <87v83fcy6s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oleksandr Natalenko <oleksandr@natalenko.name> writes:

> Hello Johannes.
>
> On st=C5=99eda 15. kv=C4=9Btna 2024 8:23:35, SEL=C4=8C Johannes Berg wrot=
e:
>> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
>> > Also /cc Johannes because of this commit:
>> >=20
>> > 6092077ad09ce wifi: mac80211: introduce 'channel request'
>> >=20
>> > On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natal=
enko wrote:
>> > > Hello Felix, Lorenzo et al.
>> > >=20
>> > > With v6.9 kernel the following card:
>> > >=20
>> > > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax =
PCI Express Wireless Network Adapter [14c3:7915]
>> > >=20
>> > > doesn't work any more. Upon mt7915e module insertion the following s=
plat happens:
>> > >=20
>>=20
>> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
>> chanctx ops")? Huh?
>
> Yes, you are right, this commit is not present in v6.9, and I can find it=
 in the "next" branch only.
>
> I can also confirm this commit fixes the regression for me.

Thanks for testing.

#regzbot fix: 2f7cf3b61d85

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

