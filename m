Return-Path: <linux-wireless+bounces-11299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E894EB0D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040501C2157C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469717B43F;
	Mon, 12 Aug 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlm1HdE3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35317ADFB;
	Mon, 12 Aug 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458547; cv=none; b=lzemaQgWND9OnhBRDNS6KR6eTEUlNKQ4Ffrn9v4Ef/C0Ujp1bg+ftjoyBZpkPToU90X4aUOju/0KxLbbEF4Pnc5XrcFV1yW4cSfb8JQpm0SbvdnZNqAkP+l07GdwvAKNS8BJwx2atlK+lcEABJQza1IyayZo9yBQ7VUDkp/0eG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458547; c=relaxed/simple;
	bh=CLyWWOYt22DzrQD3+24twqwW5p6ENAk4u846K2Y3tgY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=muKEakVWqMo0H2ZEWE/0tYrTBmFTVyEoTnzu+ceUArfIrzt6RcwRHf3u+JXkGnbMHCFoP0jyGSNtPz5aI4tD+J0y+HIdhEo0QlOiRNh1PpMYf32an801rI9jQ1Ez6U6t4U74MUA0LmOEs+c/MANFo+mUVBDWFp3b3oKntFN8Lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlm1HdE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE4FC32782;
	Mon, 12 Aug 2024 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723458546;
	bh=CLyWWOYt22DzrQD3+24twqwW5p6ENAk4u846K2Y3tgY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tlm1HdE3fmkzZ2c1IYHfNI8S+derlQvbNjunFM/xdndnI/+jhR7T9sgDY4Ob/b2p2
	 YzS7B08GDPfVQtqT1PZWOPmy6TDc+wS5Cr0XJkmYiNjBZk0iDmousNuCYkmiwo7pol
	 7rexniM57Arc4rhM6QHJOfwHHm/IrlseprByDx59xfIltKOg3wkydE7bQLSXRYk6lF
	 7YaqNxzCMGRviC4EImuc9AdC8tIQ5BoS3Fe5A/QEEd+G0Cj8ZSGihzmjxu8yoYLgqX
	 PtGGCijV5lPyWcsetb3Z36/UUbmD0/L8HpqaDuYfBQoPqfNtJjRMQWT56m7fKWSgzN
	 nrgsT5EbI+z2g==
From: Kalle Valo <kvalo@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Felix Fietkau <nbd@nbd.name>,  Sean Wang <sean.wang@kernel.org>,
  deren.wu@mediatek.com,  linux-mediatek@lists.infradead.org,
  linux-wireless@vger.kernel.org,  lorenzo.bianconi@redhat.com,
  mingyen.hsieh@mediatek.com,  sean.wang@mediatek.com,
  linux-kernel@vger.kernel.org
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
References: <20240711175156.4465-1-spasswolf@web.de>
	<CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	<adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	<4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	<2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
	<65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de>
	<87frrqkkpm.fsf@kernel.org>
	<e32ab97963e850b4425e4f5c45d2c502d50be480.camel@web.de>
	<62226273aaafafda1a4f3abc0f8c95220407b3a7.camel@web.de>
Date: Mon, 12 Aug 2024 13:29:01 +0300
In-Reply-To: <62226273aaafafda1a4f3abc0f8c95220407b3a7.camel@web.de> (Bert
	Karwatzki's message of "Mon, 12 Aug 2024 10:57:31 +0200")
Message-ID: <87y15211ci.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bert Karwatzki <spasswolf@web.de> writes:

> Am Dienstag, dem 06.08.2024 um 13:22 +0200 schrieb Bert Karwatzki:
>> Am Mittwoch, dem 31.07.2024 um 11:51 +0300 schrieb Kalle Valo:
>> > Bert Karwatzki <spasswolf@web.de> writes:
>> >
>> > > Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
>> > >
>> > > > On 17.07.24 16:38, Bert Karwatzki wrote:
>> > > >
>> > > > > So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. The early
>> > > > > return in that case avoids the NULL pointer and mvif->phy
>> > > > > has its usual value
>> > > > > again on the next call to mt7921_ipv6_addr_change so Wifi is
>> > > > > working again. I
>> > > > > don't know how this could happen but perhaps you have an idea.
>> > > >
>> > > > This change should fix it: https://nbd.name/p/0747f54f
>> > > > Please test.
>> > >
>> > > The BUG is still present in linux-6.11-rc1.
>> >
>> > I'm not sure what's the status with this. There's one mt76 patch going
>> > to v6.11-rc2:
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=6557a28f3e3a54cff4f0dcdd1dfa649b26557ab3
>> >
>> > But that looks to be a fix for a different problem, right? Felix, are
>> > you planning to submit that 0747f54f as a proper patch? I could then
>> > take it to wireless tree.
>> >
>> The Bug is still present in linux-6.11-rc2 and linux-next-20240806. Also the
>> mvif->phy NULL check in the original patch is not neccessary (and feels a little
>> out of place as mvif->phy is not needed anymore). This patch is sufficient to
>> fix the NULL pointer dereference:
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> index 1bab93d049df..23b228804289 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> @@ -1183,7 +1183,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw
>> *hw,
>>                                     struct inet6_dev *idev)
>>  {
>>         struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
>> -       struct mt792x_dev *dev = mvif->phy->dev;
>> +       struct mt792x_dev *dev = mt792x_hw_dev(hw);
>>         struct inet6_ifaddr *ifa;
>>         struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
>>         struct sk_buff *skb;
>>
>> Bert Karwatzki
>
> This error is still present in v6.11-rc3.

Bert, can you send your fix as a proper patch? More information in the
wiki below and please mark it for wireless tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

