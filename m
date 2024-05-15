Return-Path: <linux-wireless+bounces-7677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11AC8C61E1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926D41F21A1A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4F446A9;
	Wed, 15 May 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zv407TC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7B41C84;
	Wed, 15 May 2024 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758852; cv=none; b=ioXpm2CaEP7CMz5uSMTsfWLR0GeA/om7K/2ig3Yb0of/WKmihVKRbnrNabUpWrqSKRS/+W2PcLIyPCq1xiUvfP+P2/nRIj0shDh26A46xPpNpmcV03N/TctFMmupMIZ0H5lnbYNmlo1jKR0EeItVf6p5P21WvgVxfcJ6i7C11aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758852; c=relaxed/simple;
	bh=tm9iZ5Vsk/yIko8E+mwizjkCNZhxhwBScDzHvZpwOPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujjrOyXbRx0sIts7GEgzq9AWPaoqMORGnVcG4SsJ49QGyE6Ym7Eem90cM/dXhNCBkshzv6v2rrrIKMKPtNDiqpCnAvicm+d8+WxwX0K3+rNDNdes4BTgt3a1byE6uxOixdNFewFA/FteFiq9kWz08ILmKUYvRPQu8kNJhSBu3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zv407TC0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=aGfHdT97q06/TBHLdt84bAk2QjFXy+qL8wCDQ3NgfeQ=;
	t=1715758850; x=1716190850; b=zv407TC0WXz9WWrZX7H/CfF4T5FsumdLLIpWt0962j+FVKW
	d0uqc2IWsD4AKZqcj2joRAa2uJilOYYv8Fa0I2YSV6HcaDSbM7MHgEA+ibBKT+rcWidxMLivpSC60
	d9bCuvY5E6206qKvxY1VvWC8BlAV1vwanVEDiVdE5U41T36r2jbVj5w4n4WzptJx8ms/8x3ddCTxO
	GQAIlVBIoHdge/sZ/c418+7+n9YVYrqw7Vo1kV53dSWnZQtRTVVrgMHaZLU56Itz/wQzcSWaJEnmR
	sKo5vVpXH14+4fJ64u6anoF5R0/rfg30dqGPJtIA5vM51BTAKGdHahCsVrEg/Ldw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s79Fh-00045X-MQ; Wed, 15 May 2024 09:40:41 +0200
Message-ID: <a603a67b-6703-4f63-93ee-98a05c605d02@leemhuis.info>
Date: Wed, 15 May 2024 09:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <6061263.lOV4Wx5bFT@natalenko.name>
 <2341660.ElGaqSPkdT@natalenko.name>
 <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
 <2200096.irdbgypaU6@natalenko.name>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2200096.irdbgypaU6@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715758850;64bb5be7;
X-HE-SMSGID: 1s79Fh-00045X-MQ

On 15.05.24 09:15, Oleksandr Natalenko wrote:
> On středa 15. května 2024 8:23:35, SELČ Johannes Berg wrote:
>> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
>>> Also /cc Johannes because of this commit:
>>>
>>> 6092077ad09ce wifi: mac80211: introduce 'channel request'
>>>
>>> On středa 15. května 2024 0:43:40, SELČ Oleksandr Natalenko wrote:
>>>> Hello Felix, Lorenzo et al.
>>>>
>>>> With v6.9 kernel the following card:
>>>>
>>>> 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless Network Adapter [14c3:7915]
>>>> doesn't work any more. Upon mt7915e module insertion the following splat happens:
>>
>> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
>> chanctx ops")? Huh?

FWIW, seems there was and earlier report about this that I missed:
https://lore.kernel.org/all/CAAMvbhGHe4PM5M=JJZRQ2m5_aVZ=4DPG76MT+q5qi3HA+7_wzQ@mail.gmail.com/

> Yes, you are right, this commit is not present in v6.9, and I can find it in the "next" branch only.
> 
> I can also confirm this commit fixes the regression for me.

So all we need to resolve this is to ask Greg to pick up the patch for
the next 6.9.y. release? Then I'll take care of that in a few hours,
unless somebody else does it first or I get some kind of "might be a bad
idea for now" signal from anyone.

Ciao, Thorsten

