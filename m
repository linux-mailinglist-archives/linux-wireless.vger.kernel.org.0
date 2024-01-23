Return-Path: <linux-wireless+bounces-2382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADFE838EB0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEEFB220CB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A55DF2B;
	Tue, 23 Jan 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tk2Xofj/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789385DF00
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013886; cv=none; b=DzPW6Rf4u4eEZjD42MqWGbY3CxF6/AcA1vFAgSJxXhfDm6LU2Fe4APldO0FzvzDunPDyYiEyT+N6iCndHmcpGyWuLtLxgqfG8T9cNPRn0BstXcoBzbMnbeHEQAXxADuBTGFK50j2IZp79YCUC+xdSnskcoCU1VH/neLRlcSuo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013886; c=relaxed/simple;
	bh=twhPUWYfAeuj72N0d4N6QmqaEsJb1HHmoyVPlowyCV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfQdF2NSkU6Is7r6U3mF15fA5JI8evV8yucolR1uQhZX1k/F1DnJH+PDVsRi+r/e1xsRirNAGdBRMdL/nls+S1wNiJlkH5wfvtXl1Ng27MNHG+qAB7ZNmkyi2LCX3MpvEHJEovvfI75q52EFT30qKO+UTlSJo2CA5tmLbeN8jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tk2Xofj/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A98B1BF206;
	Tue, 23 Jan 2024 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706013881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXgtzgHJszrribK9Bp8ewROhv9PejeDdoclh8iL34o8=;
	b=Tk2Xofj/44gGWVPl1+sizl6Md2j9386E4HLVKJ9wHI3yXjPfhoaAYcEuPwwHZ3VAfK1IJB
	sKR5ZnTSyvBLTzazC4xKZRcHw66K1QYNXJ+wbUf9x0dFnQChVNjskpf20zk3YFR2G1oxMA
	JI/oj7ntZ6Qctw4gyDbNaqg+pHVZuEtHg5+tbeWUZXxRt07y2GvAoZoAxk2oAZymHHArtJ
	EXBv1RAOF09NOuGGFd3BQ94jfxtU3JnijaTsCCzT24oa9yJ3UOp39AbZU1lfVk3WD67qAT
	LalSUmvx03AZfuADnk5xyy+GP2h0seoEGs8iHoVAJhcUpVGE9gHeFAj3ofZg/Q==
Message-ID: <94d08fd2-ce43-4085-a6f6-d91981853393@bootlin.com>
Date: Tue, 23 Jan 2024 13:44:40 +0100
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
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <8734uo2ts1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/23/24 12:06, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
> 
>> On 1/22/24 23:03, David Mosberger-Tang wrote:
>>> Previously, the driver created a net device (typically wlan0) as soon
>>> as the module was loaded.  This commit changes the driver to follow
>>> normal Linux convention of creating the net device only when bus
>>> probing detects a supported chip.
>>
>> I would gladly help review/test the patch, but please give us some time between
>> versions to take a look (even if you can mention if you found issues yourself).
>> Also, each version should be a separate thread, bearing the new version in the
>> "Subject" line.
>> Additionally (to answer your cover letter), the patches must target the wireless
>> branches (likely wireless-testing), not linux-next
>> (https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)
> 
> Actually wireless-next is preferred for the baseline (unless it's a fix
> going to -rc releases):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

Oh, ok, thanks for the correction, I may have misinterpreted the wiki then

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


