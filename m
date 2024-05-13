Return-Path: <linux-wireless+bounces-7600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABD8C43CD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF231C20A96
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085D1DDC5;
	Mon, 13 May 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="j7Zjeioy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A157C97
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612815; cv=none; b=J9qMt18L7Va23ZeCDgjEFuyo0DFyY3HVlKCU8XzfJVeLCx4pGjncLhAaeMUQgtV4nMp5tMljcOPcP26I1I7NyZvtDR4/9apbhHe7r5ldF6ZNUZePrQjMkQEa9SnDvhDYiJkMLKaHD6lYqca4/Hh3hEQNdmfbTdJHTlge/cWmZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612815; c=relaxed/simple;
	bh=yRLKQtJMHk/KHyK5GJ9hiBA/zwIirWhmcUm/w3Yo7w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urDKgea0aEdjMaHmYEjleCPrMtdK9DlL/YacTXHzkXOjMPSE1nIgu0NzfzdGDzpu5A13hrrmWzfnJKCXpV5Gz3UTLuku9x1pfrlA6g4yEFZqakma0axoHjSDOP50TT+Q9mfeUP+Dd7aGhD+1ovriyrPlU9TnqCx2oBtBIDHUEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=j7Zjeioy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AA83B88210;
	Mon, 13 May 2024 17:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715612812;
	bh=7pKzpnFZTfg1XkoB392nlEwWJtKSc4VJ7EameRTBfnA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j7Zjeioy6HuZARpb+upPamIrPhySUfzMMVys3MJ8ncnW20MbDLwCYMQjyj2VHOQuv
	 6ErjQncn6BoKv7inqO9GQJIA6VrBDJw6ZU3wvqGvKIHGuRC4IjiBrVcmiihyH19P+W
	 N5RzSj4bcvmboc6mzwY3SW4zL6vNR3fZFP7NmI6cXhs+iG/B9T4FbgEN048ef5rhiO
	 u5IUOfMM3YhxC2ycMwB5xbSoOltA1VwVrJeTFLiOeWY/bWbehU6PHiKshT2NNY+Dri
	 UYEHTvdTY0SQmawARx5UcrnxGaJl47YP6Tf1TmpLZjgFHe0Cwedx8P6T+dqRA0qjUn
	 13eHSeNiVrwXw==
Message-ID: <3fb87569-61af-4779-a468-5e91d50482b3@denx.de>
Date: Mon, 13 May 2024 16:44:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwlwifi: mvm: Ignore NVM write status 0x1000
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Abhishek Naik <abhishek.naik@intel.com>,
 "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 "Berg, Johannes" <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>
References: <20240512184932.25831-1-marex@denx.de>
 <MW5PR11MB5810BC2C41C580237BAD3958A3E22@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <MW5PR11MB5810BC2C41C580237BAD3958A3E22@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 9:26 AM, Korenblit, Miriam Rachel wrote:
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Sunday, 12 May 2024 21:49
>> To: linux-wireless@vger.kernel.org
>> Cc: Marek Vasut <marex@denx.de>; Abhishek Naik <abhishek.naik@intel.com>;
>> Grumbach, Emmanuel <emmanuel.grumbach@intel.com>; Gregory Greenman
>> <gregory.greenman@intel.com>; Berg, Johannes <johannes.berg@intel.com>;
>> Kalle Valo <kvalo@kernel.org>; Korenblit, Miriam Rachel
>> <miriam.rachel.korenblit@intel.com>
>> Subject: [PATCH] iwlwifi: mvm: Ignore NVM write status 0x1000
>>
>> When loading custom NVM file on Wireless-AC 9260 160MHz, REV=0x324
>> 8086:2526 (rev 29) Subsystem: 8086:001c firmware version 46.6b541b68.0 9260-
>> th-b0-jf-b0-46.ucode , the NVM_WRITE_OPCODE return status is 0x1000 for all
>> sections. What does this mean is unknown, however clearing the top 4 bits
>> permits the NVM to be written and the card operates as it should.
>>
>> Hexdump of the iNVM file is below, the iNVM file overrides antenna settings to
>> only use AUX antenna and disables MIMO .
> 
> The custom NVM is meant for internal use only.

But why does NVM loading not work without this patch ?

> To override antenna settings please use the nl80211 command: NL80211_CMD_SET_WIPHY
> You can use the 'iw set antenna' command.

I need to use only the AUX antenna and disable MIMO entirely, the 'iw 
set antenna' didn't work, the custom NVM fragment does work.

But I do need this extra patch to load the NVM fragment.

Is the patch correct ? Why is the 0x1000 returned and why does it have 
to be masked out ?

