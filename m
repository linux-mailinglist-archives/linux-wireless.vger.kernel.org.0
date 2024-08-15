Return-Path: <linux-wireless+bounces-11484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B5952DB2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7061B26BBF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C21714B4;
	Thu, 15 Aug 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUZgsS5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857C7DA6D;
	Thu, 15 Aug 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722300; cv=none; b=JCKMQYLWOUbQw6QTyajFaQDdt0vnfENVn4MGG1oSd8vdJOAYqBAqbpkAcrhnK4AYoTON2//7kHCOfC+85iCP2sK2utijUJ98MGdAuil9sfqzSkm+h9BtAwecGFli91dkvO2qBLbm1JuFMCeqXRgZlSARCBFs0okY1hyv+4b4Rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722300; c=relaxed/simple;
	bh=DD04X7e+IRTT47kw4861eORV8QakL3FUlZzRdWiImvI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EmO1r7VeRB7SfypDhS7B1izzJHg7Fdr6NIsNI0Cx0gMc8OyAwB0zNWPYBXRoKZi8jcUXzTTw6YeJzb+nYYq05wMQNEmYuXoOWR8WKvC59SYzTvkYmnlbHMmjZQZvZSI+bQFYskqA/OGz2y2ORGWV3spP5Y5p03e320ZCewOZLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUZgsS5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF285C32786;
	Thu, 15 Aug 2024 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723722300;
	bh=DD04X7e+IRTT47kw4861eORV8QakL3FUlZzRdWiImvI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JUZgsS5oaxQrKe/f9VIi3RLHwFPM7lXdLegMG1yepHdfce8Fix+Yzc5E2sk0xgGDa
	 c6FCplqIzpMXN1WNaXi6ZVRY7tkVLhI5cVJZ67IS3+kHCbsXyBFcbnNVJ+b1kH0Xfp
	 4N4O4ilYVctoAxOcwNkmTRiEBuNImKfVar5h40OQqFD9Y+BXrKjp9gAKyUnjBBv3kJ
	 ATTtKQu/i197OistiVYU9dVEszL8klK3I3nGszgvZMH5WoI6HuSDzPvSUZwvtTQ3Hk
	 ligtXcte8h2VL+VNVsTRkQt8daAO+NMOe6IH/f9h8Av3XhXNEP7G2e6Lvin1A1eVfJ
	 2cNFWiXeF1X3Q==
From: Kalle Valo <kvalo@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Lin <yu-hao.lin@nxp.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>,  "briannorris@chromium.org"
 <briannorris@chromium.org>,  "francesco@dolcini.it"
 <francesco@dolcini.it>,  Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<20240809094533.1660-41-yu-hao.lin@nxp.com>
	<2024081430-derail-diocese-78dc@gregkh>
	<PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
	<2024081523-curator-pronounce-4619@gregkh> <877cciyvdg.fsf@kernel.org>
	<2024081500-essential-recovery-374f@gregkh>
Date: Thu, 15 Aug 2024 14:44:57 +0300
In-Reply-To: <2024081500-essential-recovery-374f@gregkh> (Greg KH's message of
	"Thu, 15 Aug 2024 11:58:28 +0200")
Message-ID: <87v802xb5y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Aug 15, 2024 at 12:43:07PM +0300, Kalle Valo wrote:
>
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> 
>> > On Thu, Aug 15, 2024 at 01:52:18AM +0000, David Lin wrote:
>> >> Hi Greg,
>> >> 
>> >> 	Following the guideline for new driver, it should let every
>> >> file as a single patch for review and generate a final
>> >> 	single patch after reviewing. I think stuffs mentioned by you can be got from cover letter.
>> >> 
>> >> 	If I misunderstood anything, please let me know.
>> >
>> > Please read the kernel documentation for how to submit kernel changes in
>> > a way that we can properly review, and accept them.  As-is, there is
>> > nothing we can do with this series at all, sorry.
>> 
>> Greg, just a bit background for this:
>> 
>> Because wireless drivers can be huge in our documentation we have
>> actually requested to split the driver one patch per file for easier
>> review and avoid mailing list limits:
>> 
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver
>> 
>> The final patch to be commited will be just one big patch with a proper
>> commit message.
>
> Ick, wow, good luck!

Wireless drivers can be 40 kLOC and even if you can review a monster
patch like that, us mere mortals cannot :)

> That being said, you still can't take patches without any changelog text
> and most importantly, no signed-off-by lines, right?

I will not accept empty commit messages. I think you misunderstood what
we do so I'll give a concrete example with rtw89 driver. Here's how the
driver was split for review one file per patch:

https://lore.kernel.org/linux-wireless/20201230044223.14085-1-pkshih@realtek.com/

And here's the one big commit the driver was applied to the tree:

https://git.kernel.org/linus/e3ec7017f6a2

Actually initial rtw89 version was a whopping 92 kLOC.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

