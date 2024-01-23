Return-Path: <linux-wireless+bounces-2384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DEF839037
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9457F1C220A5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9565EE8E;
	Tue, 23 Jan 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dbpF5Prp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB65EE7A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016549; cv=none; b=ptqIyk6N6j1D8cFxjDMYud5baa4nQ977E7YYlRG8ohV7nG0gyHSZKzMT64WrLZO01fzdGplNDMfRae0TixKqM4I7MLQVXja7to1xqREk0n6c8P1qgqAZY7Q7C0N/o8xIupmRxs031KCLJH1RZAstHkI3fKr/cff72IlDBN5p3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016549; c=relaxed/simple;
	bh=aRprRsaKm+6bL4cHA5AVgIDHtgJcw4rhweyfdYHwWnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiJPuY0cqRaGAgKQlKfrC2TlkyoGu5Rh8TQLvspCx8jfAPK2DKfiHRS49nPKL+SuYTKw+OsJV1wUutGr6eispIk7/A6pAsWAVFAguuIgi8Dc+1SwgBjW+ZbZvqoVEjbCRzw6nK4zNDHC2voC3vmRpBb0qngTHBtZxxaElR49EW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dbpF5Prp; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C66652001E;
	Tue, 23 Jan 2024 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706016544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+uv+WVM/vyfO+RdLduP5YofATgf2JXS3q7MdQs9b/I=;
	b=dbpF5PrpEcqfz26ls7JAmoo0IcXUEkaDHUfbdNn5Eml618cYxfUpGe2h/K7cdKamGfwH+b
	0HbmoKgFQWmNfpoNDZVfpl5jno4KsTgi2MxTxZ/0FjYxERm+ZL8A/3daiEzDQ6DjrnrDyk
	LebkdUPl4yhFgZ6FIDp1/DiRxJ7msLLkbtB/faAzIrBeTXemkJ8wQsYu3ZkkNB5Abscbrv
	cRccgkz2OZTS+8cCPlZJxpnFmfQK9GpU+nHIFBAtxjVHVOGj9uQXacPjDgGjWDgoSQgByV
	3aDAF5PTYspG4Fd++4OZpu5KgEH2J8ATUyF1sDn+b2T28uvxTo84REunKN4VUg==
Message-ID: <8146bec7-55dd-45ec-8439-068cb8426045@bootlin.com>
Date: Tue, 23 Jan 2024 14:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: David Mosberger-Tang <davidm@egauge.net>, linux-wireless@vger.kernel.org,
 Ajay.Kathat@microchip.com
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
 <8734uo2ts1.fsf@kernel.org>
 <94d08fd2-ce43-4085-a6f6-d91981853393@bootlin.com>
 <87y1cg19z7.fsf@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87y1cg19z7.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/23/24 13:59, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
> 
>> On 1/23/24 12:06, Kalle Valo wrote:
>>> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
>>>
>>>> On 1/22/24 23:03, David Mosberger-Tang wrote:
>>>>> Previously, the driver created a net device (typically wlan0) as soon
>>>>> as the module was loaded.  This commit changes the driver to follow
>>>>> normal Linux convention of creating the net device only when bus
>>>>> probing detects a supported chip.
>>>>
>>>> I would gladly help review/test the patch, but please give us some time between
>>>> versions to take a look (even if you can mention if you found issues yourself).
>>>> Also, each version should be a separate thread, bearing the new version in the
>>>> "Subject" line.
>>>> Additionally (to answer your cover letter), the patches must target the wireless
>>>> branches (likely wireless-testing), not linux-next
>>>> (https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)
>>>
>>> Actually wireless-next is preferred for the baseline (unless it's a fix
>>> going to -rc releases):
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/
>>
>> Oh, ok, thanks for the correction, I may have misinterpreted the wiki then
> 
> Ah, we should update that page. That page was written before we had
> common wireless and wireless-next trees.
> 
> I don't know Johannes thoughts on this but my recommendation for
> baseline:
> 
> * use wireless tree for important fixes going to -rc releases
> 
> * for other patches use either driver specific tree (eg. iwlwifi, mt76,
>   ath) or wireless-next (if no driver specific tree available)
> 
> * for automated testing etc. use wireless-testing as it's a merge of
>   wireless and wireless-next and contains all latest code

Thanks for the details. I'll wait a bit in case Johannes or anyone else wants to
add anything, then I can take care of updating the corresponding page

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


