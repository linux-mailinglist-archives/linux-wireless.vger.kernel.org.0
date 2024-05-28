Return-Path: <linux-wireless+bounces-8185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678E8D17E6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126B7B25180
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD616B721;
	Tue, 28 May 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aMwtEtLt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F816B722
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890282; cv=none; b=C19G6NB8jnTZDuH8Y4Sm4PKhrG3NxuCe8OVa9bpRd6eE+Xv38m+IpcMuA5lTYUqrLQ7mlgmgVG9+xXJw9DB3nDqHkR0ZC4dXSEERzow7Fj789c9Wu1FGRdwDBkq2fb7AG2oeV6ewVeqRkQvPgY0490FPvKFmrhYs3exMBgT6BWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890282; c=relaxed/simple;
	bh=4RSVAQqVKbMYm3ScntB1ya+FDoBFOTv3T4towJC7Zvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4EtmMvOznNSZE1dKy3Uq76mL/tM4yO5bnAxXLkTeLMqPbc8kP1dQupmSS8Dn2C+6ZX6yTQQBZpt01+NPBedLm2VpgPKFMQeiuJURs4x7dlHJhWKZ+IR6gcUDpq7zRp8YuHKFvTrzbC/Jp7YzWc4/G+hBHmx7LKksbDs5mK+sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aMwtEtLt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EBF920003;
	Tue, 28 May 2024 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716890278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtgXCGO7XzBv6KtEVDn2ev/7LZ5nCFL+0F8bR5Z9YTk=;
	b=aMwtEtLtR3suRAK2pmilZNAxCtexDZ5/hOnwl7Wdwnf+HVxLKpzw9DcOC/foWC2v14oxUj
	N6ltHnv/HLAK6eKLNr2lWXxrhwnteda4U9/vKP65EUjcnnWk8Bn9knfgsRz6U4LYM0EH1/
	2uVAZ/ELkBy8+T/lSUZ6EIw1Bb4xv3qR4tJP3sZ1gBQGgjBq88th7UaEH0nagU9je+TXMg
	BHUxrp8NfRhvLmvPvVi9hxcNfrwozQ/AcvEpEAp72Iw0EuLobZQHaGLEWPXuAEsSIBixVW
	yRkFyiXxxfbFJezEBqvF8d1BCWIL3c3xFLD0B4iNvZHSvL84F1UC29XGChIHZw==
Message-ID: <117ec723-fc35-42de-8e09-9ed25654a15f@bootlin.com>
Date: Tue, 28 May 2024 11:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: wilc1000: convert list management to RCU
To: Kalle Valo <kvalo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-wireless@vger.kernel.org,
 "Ajay.Kathat" <Ajay.Kathat@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
 <0a9c592d-7db3-454e-a83f-901b1865b414@bootlin.com>
 <878qzu8e4k.fsf@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <878qzu8e4k.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Kalle,

On 5/28/24 11:44, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
>> Because of the second point which would bring a not-so-clean fix, and the third
>> one for which I still don't have a proper fix, I am considering to submit a
>> revert for my RCU conversion series, to come back to SRCU. I don´t know if those
>> issues do or do not make SRCU usage more legitimate, but at least I feel like
>> really fixing it need slightly larger rework. I will still search for better
>> options, but if I do not find any, I will submit the revert.
> 
> Thanks for the good summary.Maybe it's easier just to revert the commit
> immediately so that you don't have to waste more time on this?

Yes, I have used already quite some time for this, let's do as you suggest and
opt for the revert directly.

> Especially if Ajay is missing.
> 
> But if would be nice if you could also include a separate patch which
> documents in the code why SRCU is needed. Just to avoid duplicate work
> later :)

Sure, I'll make sure to include this.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


