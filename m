Return-Path: <linux-wireless+bounces-19151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE4A3CB6A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 22:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF533A8111
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460325743D;
	Wed, 19 Feb 2025 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="N9G7Ij17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356EF22E019
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000490; cv=none; b=X7iVMiowwSQ2h+B+cr5K5QRAiO060GnL/qkqJzgofjhiUjWTgW+dJpo5mzifkVp3YfAcrt8/DfGAF/VB1ts3z3IdQUaYrMrSe8gGvZ0E/mn1mUT7vzj2tkkd5MoXZqMZZDDPf3wcrACbxnm7nggW63pIMsy5DP9mOXy862aqyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000490; c=relaxed/simple;
	bh=3JalU3tGz2pk5RuHTjKELmx2o9pzjU/qxgXgUtLWllA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbRTS9ySYMMy8i9tmWDWS099BHBLWcMgC+TVs/lOh9tAOtHiCn/F9T0WC8cjsTny/iS/R0RTKSZKrYRRUI5NY+8OOvZaxsyJrZqeI5tsrfzHgwWfmVat0d/uLJ3OrdRN5DdarsIsjqNBrYDyeR6/TC6ut77kQxuPqUxuo8+FVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=N9G7Ij17; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <6586339a-d9c5-4787-95e4-202368341541@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740000475;
	bh=3JalU3tGz2pk5RuHTjKELmx2o9pzjU/qxgXgUtLWllA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N9G7Ij17j9mZfcV8pCN+6bsRg2Gm0wFkC8StRKHxbNf+uLnCLVzF1wuOMdiKQFWhp
	 DunH4DmaZqQKgMBY+7xVGojQ/f6tdDV0hDG/wSvgiFHSySilaaOgOf6q+3+vsHXOPa
	 qQhcTW1Jf+Zeoe1g0euMoVjZvvtfkxKpgOjSZE74=
Date: Wed, 19 Feb 2025 22:27:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Convert mac80211 to TXQs only
To: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, ath10k@lists.infradead.org,
 Remi Pommarel <repk@triplefau.lt>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
 <548270b0-8267-4a94-85ab-597ade0f5082@gmail.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <548270b0-8267-4a94-85ab-597ade0f5082@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.02.25 20:19, James Prestwood wrote:
...
>>
> Trying to get some clarity if this might fix a regression [1] with 
> ath10k where upon roaming the TX queue hangs on flush for ~4-10 seconds. 
> I was hopeful for another set [2] but it looks like this only effected 
> AP mode and with that applied I still notice the behavior.
> 
> In the worse case we see two failures, which add up to about 10 seconds 
> of delays, more often its just the single "failed to flush transmit queue"
> 
> Feb 19 14:15:59 kernel: ath10k_pci 0000:02:00.0: failed to flush sta txq 
> (sta 6a:3a:0e:22:45:08 skip 0 ar-state 1): 0
> Feb 19 14:16:04 kernel: ath10k_pci 0000:02:00.0: failed to flush 
> transmit queue (skip 0 ar-state 1): 0
> 
> Crossing my fingers this set will have some positive effect here
> 

I had a quick look at ath10k driver and the error message you have. The 
patch series here will probably not help with that. From driver 
perspective nothing relevant should be different...


> [1] https://lore.kernel.org/all/ 
> CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
> [2] https://lore.kernel.org/linux-wireless/ 
> cover.1732293922.git.repk@triplefau.lt/
> 
> Thanks,
> 
> James
> 


