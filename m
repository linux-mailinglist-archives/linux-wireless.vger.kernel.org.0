Return-Path: <linux-wireless+bounces-2999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A078A846AC1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F0E1C23F38
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1382182B5;
	Fri,  2 Feb 2024 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.lu header.i=@cock.lu header.b="QYGfEPOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156F182A0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862759; cv=none; b=Epz3pGMfKzjD39ciWOvnRTc+FGlFRSyLzJqjvYfurGc6xhbrew3VHca4r4riDM4AO26REGdyetLZqD1DmN9TrJwbuIj7lBX1K4ut8rN5UF4sW7c+50L/lzM0RMiVK7R4/Oa6/HHM0FcmcUhHKhUdfzUGO7UGDBr6dHoECiRn+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862759; c=relaxed/simple;
	bh=pM2RVMIw2mHnNWwddCygtXBXoVhwHLxocAg/Q8AwK80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=phyesiMI5oYNNIO/sEkMCrPmuTAIVOvIcqlBax5aRgSqcItYoSlnEihicKEk7IIgYWnXQfBLW0Go7UGXok9tbj57B6vh7+0l0J/0ZUlNJ0cfbvnoHqecG5dvdyAf3YfWbB/RMJeH3YPDHmeJTu7oy4gQMI+jZxwnnaCougxTBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cock.lu; spf=pass smtp.mailfrom=cock.lu; dkim=pass (2048-bit key) header.d=cock.lu header.i=@cock.lu header.b=QYGfEPOH; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cock.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.lu
Message-ID: <5efa8769-e206-45fa-a346-def8cb464f4a@cock.lu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.lu; s=mail;
	t=1706862738; bh=pM2RVMIw2mHnNWwddCygtXBXoVhwHLxocAg/Q8AwK80=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=QYGfEPOHtcba3NpAcCHIh0db8bFMUfaQ9kCWquNt9D+cjnrnAvuplpEjMt5YWYh5Q
	 xBZnfg7F9fGsFIiy93idmuPOO6cJGJ0BSp1/r43HDEPEFS1m+R5sx8rNILVU9lm1SV
	 JSWiwJlXP/lPeeZoKmtA7vrfyz//X4HPO/CXMYaNoYi3NiSyR+7KiyYkDx1cirq/XH
	 b7eZk6TsMxIFRGz/sIBGuNO/d0/ESI/xEk+8KJbcfg9uqnqjDM16kJOdDV9HflhESv
	 VZlqFkTL+z4sN7LyWTOA3P2NdwXrcFqjgGUSOo84kQ5WMQIhfOjaSgYnNCQG80p2kV
	 AhnhBTKAaRchw==
Date: Fri, 2 Feb 2024 16:32:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chun Qiu <cqca@cock.lu>
Subject: Re: [PATCH] wifi: rtl8xxxu: Add TP-Link TL-WN823N V2 to the USB ID
 list
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org
References: <20240129053030.16369-1-cqca@cock.lu>
 <04b966d8-835c-4729-810f-65e9922818a9@gmail.com>
In-Reply-To: <04b966d8-835c-4729-810f-65e9922818a9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 23:37, Bitterblue Smith wrote:
> On 29/01/2024 07:30, Chun Qiu wrote:
>> TP-Link TL-WN823N V2 (2357:0135) is based on rtl8192fu and has been
>> tested to work with the rtl8xxxu driver.
>>
> Nice, thanks. Just out of curiosity, does the LED blink?

Yes, the LED blinks during transmission.

> And do you know what RFE type it has? It's in byte 0xca in the
> efuse dump.

The byte 0xca in my efuse dump is 0x05.


