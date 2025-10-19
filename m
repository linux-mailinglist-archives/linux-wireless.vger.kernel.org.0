Return-Path: <linux-wireless+bounces-28087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA608BEEA27
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B7264E5300
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8EA2773E3;
	Sun, 19 Oct 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="peBtpR6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FE1EB9E1
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760892233; cv=none; b=bDki2REWE4+T1Sug6m/OlMFURVtPTiR7xRadQTWWXo88U7+QGDcRWsxNmI8P7zwTptLCEl7BnBZAVY5hMXBPlQ36G6W/CO7iyZ+ztvJ10BlSb5vTFNTfwgnrQs57zLXrw8TDbzP89+qPGk6538UwRpS7qAD+YDumY+OZq36LalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760892233; c=relaxed/simple;
	bh=Ro1YHj71Bkuf/nE/LbNAkCTP4T2EXj+lPa+kjEPza0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=giDe7M1wifG1DkXHRLLywiVGR5KzWBAak/fdy+pH5cdKvNoxwH9x2nTadBUc1cuhXPsWOAWhy5DLx3Q5tohQZ2rmXXGU3ozvlzQMBc61tW+a2dJSuXkTqJP9ffwLhu4SA59AyxeBqDhUThek6sEMBfiTiMKxr0+kWGbxUooUxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=peBtpR6E; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22663 invoked from network); 19 Oct 2025 18:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1760892228; bh=KgVBVUJXxuJNfAai+w6JVOE/OpKRFqXAijpu2MBRy4Y=;
          h=Subject:To:From;
          b=peBtpR6E7ZW4mYxBVRYav6r8j8zPXBkmZ6KC1fyEaTN5k9iEEE5NYcPaLBSnYDgdM
           4nCFA/00CFZ0/FTv/Dve5kuipwf7Ftzqs3olf5JTEZPF2e6jjIlaahChWh/DEU6hel
           Thdeu/RtlqnD5qj5YiPsOaWMnicvLR6onNpj2q9RfXdNgRKsOstz762DDwpserWGCq
           XJ0vddbs9T3Ib9+qXyJH8Z/iVRitMnGRM5hTmV7r33h1LLq+VzKUkg3FlUNdoN2cQ4
           JoeSdxXoeAJNqFD51dnlJ4rR0/fxEZS6pkPVOOLWjc7P/Fd8FNQRXbfa3UGSDuhhwE
           LLo5pcgxGo81A==
Received: from 83.24.149.147.ipv4.supernova.orange.pl (HELO [192.168.1.10]) (olek2@wp.pl@[83.24.149.147])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <greearb@candelatech.com>; 19 Oct 2025 18:43:48 +0200
Message-ID: <5a529d81-fb4e-4e7a-a132-3b76d26c3696@wp.pl>
Date: Sun, 19 Oct 2025 18:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
To: Ben Greear <greearb@candelatech.com>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com, rosenp@gmail.com,
 luoxueqin@kylinos.cn, chad@monroe.io, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251019155316.3537185-1-olek2@wp.pl>
 <fa7befd5-b2c7-4277-ad57-a1577216ba83@candelatech.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <fa7befd5-b2c7-4277-ad57-a1577216ba83@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 93b31ec6953bcf946e080ba9f5d8865d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [IcDR]                               

Hi Ben,

On 10/19/25 18:26, Ben Greear wrote:
> On 10/19/25 08:51, Aleksander Jan Bajkowski wrote:
>> Supports IPv4 and IPv6 TCP + UDP
>>
>> In various tests between MT7986 and Intel BE200, I observed a 
>> performance
>> boost ranging from 2 to 12%, with an average of 5.5%.
>>
>> I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
>> MT7922, MT7925, and MT799x are untouched for now and still have
>> checksumming disabled.
>
> At least with  7996, tcp csum only worked on the first few vdevs
> created in our testing, so we had to add logic to disable that flag
> on subsequent vdevs.
>
> Have you tried creating a bunch of station and/or vap vdevs to see if
> all of them can still transmit TCP traffic?
>
>
Thanks for the useful information. On all tested devices, I had a single
AP configured per device. I will try to create several APs for each device.

I also have a router with MT7996. A quick test shows that checksum
offload doesn't work on this router. MT7996 is visible in the system
as a single DBDC device. I have 3 APs configured there. Each on a
separate band (2.4/5/6 GHz).

Best regards,
Aleksander


