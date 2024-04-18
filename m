Return-Path: <linux-wireless+bounces-6496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16648A9381
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3131C20BC4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB2639FDD;
	Thu, 18 Apr 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4J551ql";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lh9guobA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2530381CC;
	Thu, 18 Apr 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422855; cv=none; b=t8ZYOlqXdhilNPm121JnfiQ3qxVNy5lqVdRiEhssPgi/EYOXAyAh0F5f+DkdMzamWKuEQFzvdR+PMZ7l78ePQhjB01w277bmcJLRu8NIc4xdkknMdnm5W9foCAzZ+CN/PXXbAOowR6qj95j9V12YO5bc4VWCrq5h0pnACob6SPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422855; c=relaxed/simple;
	bh=yYirnyn1Rz0m0IOArDH012oqC2U07n7jEdGYlLv2ll0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvZDSTvDrfOI6U17U+lymPvU8iH5DSegTEpKZ/vtaha2bCgkKfbkpEOJf1kIufys2iZnR0GKgJ+Zeb7338lcFnE6lxMhogLBAUHD/JS2NOM82i9cF/plGWQLEZlR8+mIGmjLngpuU1FivB2epINZZgju15VadHQj3Dgg5f7BApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4J551ql; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lh9guobA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <137a9ecb-d5de-4471-bbc1-32986b735f28@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713422851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/FMRRhZOgYFkdYDsjKnSzxaUyT83xh8rf7YnnW3dWM=;
	b=P4J551qlI/ttMRlrZTJq0KLT1ZvkMp5q6kKHPH9fhzcw1qVvCm42BFT+jwkDumoHmRKsDt
	5zzc+1nbxdHyZwv4PoaH+mBjMidWvBGOxQgeO9ByrfvQ/pN3KPqKjCWhMvKqCBmiSKV6IR
	3LnTMk2a4WhjDXviv4iRHBs88Jrw43i1xGEawhmxGO7KViETc0gZsoVqZuP9qnVldLfUpg
	1awPRGsBcLOUl79KT0DJ1Rp8IcXjgbnLHKbWFo+OeGw75hG6GuvxWZQjXl+pu8h05bJqtz
	8AV8/raIF0F3I4jgyNFHTesPb3DUbtMgqzkIhCpfLDT82isBTCKFUvT+Wb38Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713422851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/FMRRhZOgYFkdYDsjKnSzxaUyT83xh8rf7YnnW3dWM=;
	b=lh9guobAWLFJ2MOcFFwzD4H7YDvL20RZ5ez681MpBmbecxhVPHwrudprxkUoPON128WBbw
	uJ05Zr8VJsxUTKAw==
Date: Thu, 18 Apr 2024 08:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
 <20240417093352.1840632-3-martin.kaistra@linutronix.de>
 <6a1571aadad1486eb83a19437e1d2437@realtek.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <6a1571aadad1486eb83a19437e1d2437@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.04.24 um 02:19 schrieb Ping-Ke Shih:
> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
> 
>>
>> In order to connect to networks which require 802.11w, add the
>> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
>>
>> When a robust management frame is received, rx_dec->swdec is not set,
>> even though the HW did not decrypt it. Extend the check and don't set
>> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
>>
>> Use the security flag in the RX descriptor for this purpose, like it is
>> done in the rtw88 driver.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> 
> I would like to change subject to
> "wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor",
> because the same subject as former patch cause confusing. I can change that
> during committing.
> 
> Others are good to me.
> 

ok, subject change is fine for me.
I just noticed though, that I named the enum "rtw_rx_desc_enc" instead of the 
probably more appropriate "rtl8xxxu_rx_desc_enc". Should I change that?

Martin

