Return-Path: <linux-wireless+bounces-12714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B309724E0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949F928560F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782501898E1;
	Mon,  9 Sep 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="T/EMmWsy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522120DC4;
	Mon,  9 Sep 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919334; cv=none; b=l97mmg8dxpd8R431qnS7s3MViFHb5HmH6n09NZ+xHzxtzrhFbknFwNMNS9pd7bYTPYNtbmDNSU/MNTs/tJfV8tRKBMLoAjajvWjebvZriMlTBqpgu1Rocq7arGbf1ygqPdBDwN3fzfjGyLzSN+/dfpraidynffCrsx7fT3NMgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919334; c=relaxed/simple;
	bh=lYe0rkgDtNI/jidOEoLsGYoSEBJ5bkP3iMRt2gTBbhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAHgeUq0ghnv2D09tbS/1TveM6JU8OKoh+qN8VG2KwJox1SaOE/olLXBlDG97Iauthlj4ZvhwMYPSHvxAQWjMS54PYk1To3JMnR00gsRZpVaakNocmjSBFI1k9gKayXYplBfCWqBhmH+puW7q8mJ3t22RxGnS2UKvQi0rntXEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=T/EMmWsy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5804F889CD;
	Tue, 10 Sep 2024 00:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725919330;
	bh=VkV/85NfsMuF4xAjgFPcrSD/zAtFj55s0fBB60UNJPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T/EMmWsynmIAniaAax3Ts4ckj3WGIo3W74CW+ygL4+jbdBbxF/5WCyajRoAXwsU0g
	 4xBON9dsRX6hNfeaE9Q8pwJ2EzHv2R+rMtm9sBSIQmO5fASAK7e9VjGH7Ryk5pAAwA
	 2lpKaWLJsrOirglnL+cguURyn3Dt9WuYSMJy51tKh4c+C8dYb84Qmp0ibnV2G5Lop9
	 1h3nFmU5glRC33r/3FJi6VgNvuokCPxDmXGUzObxJa+1Kh6qrF+WZjXAvt+9XVpm+D
	 0/lcOLALKjgr2huvXV9Y6PTjGQMGp9xRDdwV983d/RexK6KWDikaq1Sptr3RNLXyRy
	 8jM+QbMVuRO3A==
Message-ID: <29644c36-41ab-46b5-b758-b79f5d668912@denx.de>
Date: Tue, 10 Sep 2024 00:02:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
To: Ajay.Kathat@microchip.com, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, davem@davemloft.net,
 alexis.lothore@bootlin.com, claudiu.beznea@tuxon.dev, conor+dt@kernel.org,
 edumazet@google.com, kuba@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240829004510.178016-1-marex@denx.de>
 <20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
 <7205210d-8bf8-41ba-9462-38e619027a45@microchip.com>
 <87le00g2dw.fsf@kernel.org>
 <898e5736-9d9f-46ae-ba56-952b0cce9183@microchip.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <898e5736-9d9f-46ae-ba56-952b0cce9183@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/9/24 11:11 PM, Ajay.Kathat@microchip.com wrote:

[...]

>>> Does it make sense to add a module parameter for device type(wilc1000 or
>>> wilc3000) to address device-specific featurization.
>>
>> We don't do hacks like that in upstream, it's expected that the driver
>> does this all automatically.
> 
> Marek has already submitted the patch to delay calling wiphy_register() so it
> should work at run time for both the devices.
> I'm just curious to know for which scenario the module parameters should be
> used. Can it be used for enabling or disabling any feature, configuring any
> parameters, instead of complete device-specific featurization.
Module parameters are applicable for tunables which cannot be otherwise 
configured at runtime. Runtime configuration is always preferable. For 
the wilc, I don't think there is anything which has to be a module 
parameter, maybe firmware filename could be it.

