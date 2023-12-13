Return-Path: <linux-wireless+bounces-751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6D811C30
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E362829E3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33559B60;
	Wed, 13 Dec 2023 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC5RWoWM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FF59B59
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 18:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7DBC433C8;
	Wed, 13 Dec 2023 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702491534;
	bh=PjfwdZOSR2dwBs3EAJKkgyjx0b0MU1xrVZTWAWbnAYg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PC5RWoWME/Cb01hoJ4tntBmUrXtAKuXoxFLNoat77qpUCkpi6EHqrE/iIP2i9e9eP
	 oXMkSt/45erQi7CTpnE9V/5F8/bz91tZHHLkEayh1Gxeam5OUf5uPEulZnRCBflOnD
	 ulDOExq2qlbPkWGzDJ//bBMkrqUKzApzlhW6S3bSaoj6lCiC83x37rXKHjPSFGNbly
	 abUHlvrBUFnWh4vNcuunwFVNdZp7LcEgxOaVUHtSMwVEDupR7gXNSOm47xS+A9pBjE
	 IgMYMA6dnziiUQVe36g3uBnISWV4iSORhMxnEaYUDDG97RJY8W9QjRD+77ZZj3u3CC
	 agrZuxgTksK3w==
From: Kalle Valo <kvalo@kernel.org>
To: rwahler@gmx.net
Cc: linux-kernel@vger.kernel.org,  Sultan Alsawaf <sultan@kerneltoast.com>,
    linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
References: <874jgmnud8.fsf@kernel.org>
	<20231213172757.46199-1-rwahler@gmx.net>
Date: Wed, 13 Dec 2023 20:18:51 +0200
In-Reply-To: <20231213172757.46199-1-rwahler@gmx.net> (rwahler@gmx.net's
	message of "Wed, 13 Dec 2023 18:27:57 +0100")
Message-ID: <87sf46m0dw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(adding back linux-wireless, please don't drop lists and people from Cc)

rwahler@gmx.net writes:

> From: Sultan Alsawaf <sultan@kerneltoast.com>
>
> Sultan Alsawaf <sultan@kerneltoast.com> writes:
>
>> 3. For insignificant/low-bandwidth traffic like ICMP to the AP, high latency is
>>    expected since the amount of traffic doesn't warrant kicking the chipset out
>>    of powersave. So although it's not pretty to look at, bad ping times to the
>>    AP aren't representative of the full user experience.
>
> Without the proposed patch ping times are often > 3000ms with a packet
> loss of ~20%. And it's not only ICMP packets because i.e. ssh to the
> laptop is also not working. It is unusable slow and very often the
> connection breaks completely.

To which direction? When reporting power save issues it's a good idea to
be specific as possible, we don't have crystal balls.

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>
>> > Several users have reported awful latency when powersaving is enabled
>> > with certain access point combinations.
>>
>> What APs are these exactly? In the past 802.11 Power Save Mode was
>> challenging due to badly behaving APs. But nowadays with so many mobile
>> devices in the market I would assume that APs work a lot better. It
>> would be best to investigate the issues in detail and try to fix them in
>> mt76, assuming the bugs are in mt76 driver or firmware.
>
> I'm using a FritzBox 6591 Cable Router with latest Firmware for Wlan
> and use a Framework13 Laptop with built in MT7921 module. I can
> reliably reproduce the problem with high round trip times and packet
> loss for inbound connections.

Have you tried other clients with that AP? Especially mobile devices
like phones is good to test, they usually have pretty aggressive power
savings. Also testing with other APs is good.

> If i can help with some tests to find the problem i'm happy to support you.

I don't know about mt76 driver internals but hopefully others can help.
But what I recommend is to provide comprehensive and detailed bug
reports, even better if you can include a 802.11 frame capture from a
sniffer. Just saying "it doesn't work" doesn't get very far.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

