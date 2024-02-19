Return-Path: <linux-wireless+bounces-3767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251E4859E3F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6138B1C20917
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E364C9D;
	Mon, 19 Feb 2024 08:31:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4B290F
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331496; cv=none; b=tYuq7EafCPu8U9GqrCWaCVioY0xu+6gi/xvpOZX/hECKoWnTnPlbhvOLUgSv7E0z2sij5ZugnsBLKPlUJalwgYhd6we0gAwMurGXPoguEhCNUIcMSKZK7f5HNYpyi3YkFJrGH2nc/ToT5ABHIHXncmOsoT4gVgVMG12JQAh040w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331496; c=relaxed/simple;
	bh=6YJo3vY7sR9KVepC+/QzjuOXqZnI+ndLzNftPfZhc+k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hre0FRv93riFAYDOlYr2pfeNNROVQqj6q9zNCrSUHJY/5oDSE4vq+HDuI/eTN0tPdN/oOEpa63S3wVfjw4PQLKIfa8DHUG+7nOcitW7CsWqSgvXJddI/rFf9tQB5RuUavJXISa+i5n4rmGZWi2kehka4BBN60/IUdd9OTaOXynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-TQ-N6wFWNjiohJYLmNCQTA-1; Mon,
 19 Feb 2024 03:31:32 -0500
X-MC-Unique: TQ-N6wFWNjiohJYLmNCQTA-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id DEAB781060209;
	Mon, 19 Feb 2024 00:31:30 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 55yEjyZBTHiC; Mon, 19 Feb 2024 00:31:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id BF8E881060208;
	Mon, 19 Feb 2024 00:31:30 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA;
	Mon, 19 Feb 2024 00:31:30 -0800 (PST)
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
To: Kalle Valo <kvalo@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, linux-wireless@vger.kernel.org,
 martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
 <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
 <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
 <b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
 <878r3hc6hy.fsf@kernel.org> <42772df2-32b3-2b37-045d-b528a752bef7@mbari.org>
 <874je4dfoy.fsf@kernel.org>
From: Brent Roman <brent@mbari.org>
Organization: MBARI
Message-ID: <7808bb52-3677-c5dd-3a4d-8664a6195d47@mbari.org>
Date: Mon, 19 Feb 2024 00:31:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <874je4dfoy.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


Kalle Valo wrote:
> Brent Roman <brent@mbari.org> writes:
>
>> Yes, that's all true.=C2=A0 However... Random MAC address assignment ten=
ds
>> to cause devices to be assigned a different IP address on each reboot.
>> This often doesn't play nicely with port forwarding.
> Sure, I wasn't claiming that using random addresses is the perfect
> solution. But you could also set a fixed random address from user space
> (hopefully that works with rtw88).
>
>> It's difficult to "prove" the RK3308 cpu serial numbers are unique,
>> but they should be and the few I've tested have been.
> Please take into account that rtw88 driver can be used with all sort of
> different CPUs, not just RK3308. This is why I pointed this out.
>
> (please don't top post)
>
The script that replaces the driver's random MAC is in Armbian's User Space=
,
which is unique for each supported board.=C2=A0 So, the CPU is known.

- brent


