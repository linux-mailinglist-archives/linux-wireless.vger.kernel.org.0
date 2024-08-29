Return-Path: <linux-wireless+bounces-12222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDBE9654AD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2177283968
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4A28DD0;
	Fri, 30 Aug 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UBljODCt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485732206E
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981202; cv=none; b=W7bpRlHe3Fwr/D0/m5Nb/G2VKTg1OQ7eDMBg1W5xDuXlS57EZGHcOBAgYqbyb4i3FtgQPeATS7ZlFlsx3VJo5FpiV+IkDRJbryO7zu2W6u8WkKPmYmma8Lsle7kK0pKEVmkkpBJHLBFyRlJt+YaQwJFstVHEMW/MQRlqxtf033c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981202; c=relaxed/simple;
	bh=jQzodvY/Yoj8iH8rXPtwlvVMW7gAQA9N7fKgKL3EEo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ1MpuIF3MUveyJROnSaesi83yZrtpj9KzKA67ls/9xYy8A/6YlydCc15N/lJ9qEV4qp7jToIaAQ1w9bE+94TzPtXyhpRUQ8/MMniR6JyYAcBQ2wUpoO1A0KcGEcKPQ/XmZUSWoY295NsHMul8PyCVikrl77mG5uQeQHRnTOxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UBljODCt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 028E1886CC;
	Fri, 30 Aug 2024 03:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724981198;
	bh=nYuQYQ+zZDHIDzW3EQnhfgQmIbcoUTz/b0dgJudnvxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UBljODCtoU548beP9XSsVvkOYn/+N+uq3K8DCRieU2L9iuwm/10AorcWKHOe+wtoy
	 4rKwG+BRf5XxLNrDy7OPf2Doyy5+hMcLdzR7sXS7rAUE7pILQMZtke/y8BrIcqw8XZ
	 Q7kQOtES3Prbe7qe/AHwMj3adhq59im9lsLI1uoC4n/gtd0qeklsa1n+pj9AglP5ZL
	 OhGbNn372pEcY9+b4dyQXtkcINPb6D8/hOm9v7lol1rG/qdWqxAIIQCKUTaOB1xImV
	 oKZKJOFflu1cuqJ96BAlBdbr60mPS+cLFwPBvMftWoE6DqVjsmcaasKFgKZBduV4lG
	 +XiLZHxTfCZvg==
Message-ID: <5ba25a08-dc7f-4eb6-8982-e7a246178ba0@denx.de>
Date: Fri, 30 Aug 2024 00:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
 linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev
References: <20240821183823.163268-1-marex@denx.de>
 <a9e673b1-43f3-4341-a035-3e1265b8a544@bootlin.com>
 <60a52cac-964e-40d6-aa96-7bbf34d9c4ac@denx.de>
 <63266019-bbf0-4f26-9700-e0303a892b2b@bootlin.com>
 <0518770b-8975-4681-a32e-e82f540d9a73@microchip.com>
 <5229bc7c-564d-4195-a6ff-579dbe5c3a49@denx.de>
 <ae40b138-77ad-4044-9448-784be6964195@microchip.com>
 <12b79e2b-08ca-4ba0-8abb-6f1d0be65b3c@denx.de> <874j73e1dp.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <874j73e1dp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/29/24 6:32 PM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>> Since this driver does not reload the firmware into the card on
>> resume, the card has to be kept powered on during suspend/resume
>> cycle. The card can NOT be powered off during suspend/resume cycle,
>> otherwise the firmware is lost.
>>
>> Without this flag, the card may be powered off during suspend/resume
>> cycle. It possibly does not happen on the Atmel controller, but it
>> does on the STM32MP15xx ARM MMCI one.
>>
>> Now, since the card does consume about the same amount of power
>> whether it is powered OFF or whether it is powered ON but suspended, I
>> opt for the later option -- keep the card powered ON, suspend it, and
>> that's what this patch does. This also allows us to support WoWlan
>> then.
> 
> Are you also taking into account hibernation? During hibernation the
> device will be powered off. I can't remember the details right now but
> wanted to mention this.

I don't think I am. Isn't hibernation actually a full shutdown, so the 
hardware does get reinitialized ?

