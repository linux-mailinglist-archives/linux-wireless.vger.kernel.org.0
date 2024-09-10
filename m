Return-Path: <linux-wireless+bounces-12724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2F9728C0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 07:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D3F283B87
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0B1448D9;
	Tue, 10 Sep 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoBtbvk8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1912E48;
	Tue, 10 Sep 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944636; cv=none; b=G7qm7SVNPjTmjMnZ5Z7oGZe6J3UicOgREal2eOcVtZhMVqviraxhGTF+Eci2ucg7jLPxL6fmduzP/6t6IzlQSkEpTob+CWUDWkg88OeBmZ9WAF6JYTLFBUAHmGKNOybC/OMcWJ3ngEEDYB+N8KXZ9QzHVol0hoaGoYrjQmA1gEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944636; c=relaxed/simple;
	bh=FEaZZgdZJCOzrE+nRM4bN4CV4desynSkX2pCPEkbKXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V5XhWBo1/CaVULzQi+XC7SDIRGFVm7POtRYTeo6ZFK1dm5ITQpWZbIQfc1nCQoLTW6vInDr+bvAahdmLqSUIzn2r0ptMxDtjvy0N0Bm11BIRYbfJDUQZ++mNnJBWYlHrpd0Z87oP4i2qgsP1juuZPOP0D2oIR6nQ3vm3zN0TQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoBtbvk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CED8C4CEC3;
	Tue, 10 Sep 2024 05:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725944635;
	bh=FEaZZgdZJCOzrE+nRM4bN4CV4desynSkX2pCPEkbKXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OoBtbvk89bw+TekOGfXaT36/SJN8TVW5DCxDbAwnG/UsBSCxrDMWhtmPuve7iausu
	 q9pyp3PyZ6XNnvrKM7Jlt/OmqABwH3Zu/f6t6AizMgXWDdg9OnzssnZ3GpnMovMc3v
	 N7nggr7+X19FH4zj25eGTB2pa+HTR0U5h0ssUsywVWJhBA/DqzhFrgzOWnPV4LDqbT
	 mazYYa4B3T/uXouq0p2NNGpcTKVRo0shzJV0jHvfqyKcB70rdVfM767Rqm+bmZc65S
	 ZKpptIHlTsMdY4pM6R0PLVkzPJZYAbEY0Lyy3tF1rYRh5e5Mkck6BrHTdO63h8w7AU
	 uR+ahDk34lpGQ==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Ajay.Kathat@microchip.com,  linux-wireless@vger.kernel.org,
  davem@davemloft.net,  alexis.lothore@bootlin.com,
  claudiu.beznea@tuxon.dev,  conor+dt@kernel.org,  edumazet@google.com,
  kuba@kernel.org,  krzk+dt@kernel.org,  pabeni@redhat.com,
  robh@kernel.org,  devicetree@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
References: <20240829004510.178016-1-marex@denx.de>
	<20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
	<7205210d-8bf8-41ba-9462-38e619027a45@microchip.com>
	<87le00g2dw.fsf@kernel.org>
	<898e5736-9d9f-46ae-ba56-952b0cce9183@microchip.com>
	<29644c36-41ab-46b5-b758-b79f5d668912@denx.de>
Date: Tue, 10 Sep 2024 08:03:51 +0300
In-Reply-To: <29644c36-41ab-46b5-b758-b79f5d668912@denx.de> (Marek Vasut's
	message of "Tue, 10 Sep 2024 00:02:08 +0200")
Message-ID: <87o74waymg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Vasut <marex@denx.de> writes:

> On 9/9/24 11:11 PM, Ajay.Kathat@microchip.com wrote:
>
> [...]
>
>>>> Does it make sense to add a module parameter for device type(wilc1000 or
>>>> wilc3000) to address device-specific featurization.
>>>
>>> We don't do hacks like that in upstream, it's expected that the driver
>>> does this all automatically.
>>
>> Marek has already submitted the patch to delay calling
>> wiphy_register() so it
>> should work at run time for both the devices.
>> I'm just curious to know for which scenario the module parameters should be
>> used. Can it be used for enabling or disabling any feature, configuring any
>> parameters, instead of complete device-specific featurization.
>
> Module parameters are applicable for tunables which cannot be
> otherwise configured at runtime. Runtime configuration is always
> preferable. For the wilc, I don't think there is anything which has to
> be a module parameter, maybe firmware filename could be it.

Nowadays module parameters are frowned upon, apparently some subsystems
have even banned adding new module parameters. In wireless we have been
more lax and have allowed new module parameters in some cases with good
justification, but it's still rare.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

