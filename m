Return-Path: <linux-wireless+bounces-14638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68659B4AEE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C91F2256F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6851DE3A3;
	Tue, 29 Oct 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KuJ2nzu4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8760BA50;
	Tue, 29 Oct 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208688; cv=none; b=QJB9D06TMM+v2bA7rNr2qAWQhP8asaYcYzTpTRIh6cYXyHSvYG2W9nWc4Xuzo8+QkEi3h9jTWztz/qPzXffaUjNM+WAnCHb60upd6NFs9BbqzGezuI23kKAmIOszuovlwlsIYt6CyD3MxL2QjTRvWg3oX7H8X071aAa+Xn33NJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208688; c=relaxed/simple;
	bh=aBVVqmvX2q6TLOJtT6v450+4pITOiqq51LKyLf4ITWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6mzbj5/fVtiz1L1rDYaQhfa4AOab0TMCABywYhys7TzV+RfhfsgLdaenmTzo/r94mJjTTby0dDpl8J5Frua3+/btHV3YRVVdgFo3BDS5tx6DoCZxYy8fM9ijIiColUeUvdlhZLXbeKB+xHYdAx67gN31U25zcfJBeMF79b2E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KuJ2nzu4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w9BvO4zqQrLuMM1dLzDp1apkUOIJQVYn/hdQ4WU1VIA=; b=KuJ2nzu4yCcIVqv5uraxciH2gd
	P96Ap1OWW1GNrQ4xzi8vQT1YYN/zpgBoW9G3wqXPeSMg1BZ/V+XWf8CFstn0fq2lFJP+La0lGMhvk
	gDJzlk5O6uNEsMKcUotUF0N+I1Og4iSEJllaKdI5AiLb99EWT/71K/XhNcQQBQQP82w9EVlKvuxC8
	OLAndkIzSZmFnw3avgHvzv2fo3YHLbWHYM29anK0F7F8eVvRbxJ/WjxTYVN5Dos7KfQeWhb0ZUFAI
	bQEJ4U00JhJ+aivTU9Lt2UJpmScJeXKkWyG5ENJbFqOVXcZDrX+3h4Xb8qjyJj8rGteUHSnNi9c5C
	7XsEc9sg==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5mJZ-00Gdat-K2; Tue, 29 Oct 2024 14:31:17 +0100
Message-ID: <d6e01e56-51e7-cbb2-024a-c7db86dc70fb@igalia.com>
Date: Tue, 29 Oct 2024 10:31:08 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
 <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
 <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 10:20, Bitterblue Smith wrote:
> On 29/10/2024 02:50, Ping-Ke Shih wrote:
>>>
>>> But can you help me on finding a USB adapter that runs this path? If you
>>> know a commodity model that uses this specific driver, could you point
>>> me so I can buy one for testing?
>>>
>>
>> I don't know that. Maybe, Bitterblue Smith (Cc'd) can share how/where he got
>> USB adapters. 
>>
>>
> 
> I got them from Aliexpress. Both listings are gone now, but I still
> see others:
> 
> https://www.aliexpress.com/item/1005007655660231.html
> https://www.aliexpress.com/item/1005007688991958.html
> 
> Mine was only 6 USD in March 2023. I don't know why this obsolete
> product got so expensive.
> 
> For RTL8192DU only modules are available:
> 
> https://www.aliexpress.com/item/4000191417711.html
> https://www.aliexpress.com/item/1005007343563100.html
> 
> Someone gave me this link (I didn't buy):
> https://www.amazon.com/Netis-Wireless-Raspberry-Windows-RTL8188CUS/dp/B008O2AL0K
> 
> Note that the Netis WF2120 can have newer chips inside which will
> not use this driver.
> 

Thanks a bunch for the info and links, much appreciated! I can try to
grab one for testing, but let me ask also: would you be willing to test
that for me, Bitterblue? If so, I can resubmit today with the PCI check.

If not possible, no worries, I can buy one.
Cheers,


Guilherme

