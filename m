Return-Path: <linux-wireless+bounces-6520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175F8A982A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480201C21A11
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59A15D5C1;
	Thu, 18 Apr 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="igujTaLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC415E5B4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438301; cv=none; b=f4tk5keJjgEO2M1XOXycbj21VTh4YtKh5lwK+tr17uztKvXcNnx9UZdekaATPSdshLohpoziYMZibbe0pK6S/OoaUwcpA+ewD8idoEQuYMDYZyx8JSvSrqN0FyCbxIqtiOZmu/nMTDoLX5+82npRFaoYHeyIx2SpN+LvH5qI1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438301; c=relaxed/simple;
	bh=snYU1wzZp99EalLq7wtveDh4IX/M6dRQ5j6Axidgvy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCVwnlOjQ/lgZbHDbVF57nlIySVxzd1fcKU8bGrfLGP2lyUBL7rrQvjsvX3srJrqdRqNe5RNgQpIpYTQdjc+7zokLOJNgtYNoi06VekKLOhqo5gvxDBaKbIX+BwJsV9KwFOT3c2jhkk0PdmfbK0pLO/IxWrbNvcUFOMYgnxtgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=igujTaLu; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D11818B08E;
	Thu, 18 Apr 2024 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1713437719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=rJN5JUSeRoibQ+k1KbrFOlFSc901umqicAwHWthi5v8=;
	b=igujTaLuJjgNh0GoDqpi+qd4wWffZIjfSsl39yGo/mfDqCthpP83IL7WuJyfeg86SCepgG
	90Q8Fm5mLKHyfgzIz6vkiGw4osMpWFE540OsEL5ncFSD9HzekPI8paUXBaUxX7LGynS+0t
	mMRvlbgyNJ+it48Vvnz7RuCjbBnFiNDC5vBjyPnI5O70Sf4lkt8Ab6H1YM7IVCJFlTweLQ
	g1G9ry0djhuD0XrTysKWKB/6LWEHvAcH3yTcTi9WkhliTIP6U7NSS42jOREdAiEytg+y/M
	sZnfOrcf/23gqjD+F48zb+fnHrLiIjD1t/k34fW2oWAR08BbpVUKaJkHGklidg==
Message-ID: <131edbb8-be69-4766-b7af-49ec9232eb3c@lexina.in>
Date: Thu, 18 Apr 2024 13:55:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Gabriel Tisan <gabriel.tisan@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com>
 <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com>
 <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com>
 <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
 <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in>
 <CAD9ZU8C1mf92UH1_k4bB5yTr8yXLX_0CDZHFz+Yh6Z0MQZLs=w@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <CAD9ZU8C1mf92UH1_k4bB5yTr8yXLX_0CDZHFz+Yh6Z0MQZLs=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



18/04/2024 09.58, Gabriel Tisan wrote:
> @ Viacheslav:
> Can you please tell me which repo did you use when your run USB 8821cu
> successfully in AP mode ?
>  From your log bellow it seems that is not the mainline driver rtw88_8821cu.
> 
> On Wed, Jan 17, 2024 at 10:49 AM Viacheslav <adeep@lexina.in> wrote:
>> I have USB RTL8821CU. It works in AP mode:
>>
>> [511809.841083] usb 1-1.4: New USB device found, idVendor=0bda,
>> idProduct=c820, bcdDevice= 2.00
>> [511809.841111] usb 1-1.4: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=3
>> [511809.841118] usb 1-1.4: Product: 802.11ac NIC
>> [511809.841124] usb 1-1.4: Manufacturer: Realtek
>> [511809.841130] usb 1-1.4: SerialNumber: 123456
>> [511809.973789] usbcore: registered new interface driver btusb
>> [511810.432057] usbcore: registered new interface driver rtl8821cu

Damn, I thought the rtw88 driver had been picked up, but now I see that 
it hasn't. I will test again and report back with the results.

