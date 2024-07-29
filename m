Return-Path: <linux-wireless+bounces-10618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD693F701
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC76928127C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDE148FE1;
	Mon, 29 Jul 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KJqrb5W9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546401E515;
	Mon, 29 Jul 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261007; cv=none; b=BeIHe8aPJBaLqm40J/ceBmb5Xeg9oUnYG5sNrjcpq7zazzpaOqjkpwNGCaqV+E+oRxYb7MFS5tEwbxNd8O/21MONaPTdZT5PB0MvibeHOz0yi0iWdiXdbqXjywXEtX7VWRndf4W8z2mTsyVT3alLy0p7FJ8LekcpGPbknljbF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261007; c=relaxed/simple;
	bh=Y88pXK83406HjjGj/zFnZd3lYT3ci/aeqPXOfD3LW/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGMqmaKLUoEzRjx4q9N1mpxXM1kDXH8XW6OfvE1XnyExuqzj6RGq6Y1ipHsXgrFdP1D+g/gDzviRUghvtye7EpJn9mpp0prvVAVRDmooa8ZkPvrw6hhr8bAdyjMbOL595F+eyesiGKl/xOYCSo/B+9CRTxJ2n0Ysv+BWv1cbN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KJqrb5W9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=HRwq4iryWCGtxaVXelfLfM8LtnioMELn/jHh8pE2A+Q=;
	t=1722261005; x=1722693005; b=KJqrb5W9ka6K3oTEkVn2VUYotoQNWNMKxAWoTe/kakykxLh
	xJzOdAuN5VBM1tG3BpZ+pZ2gNPnZANW581Kjtrt63a055GuCM58P0CPLFr+hz8EeNKxiM6KiBVlJ3
	nGWmkbAdKAT3szmRba46NIKMEvztZ2H+/WKLuqSpeJ4KdBSzgv2kO9EjfLG5iukK5z3j7OLkTCn8R
	I/W6VsFcYG3qxegaYJQGdiKamMI8Zre4HSyCyFk1UwxfXYIMc3oXbnh/sUMCi4AxHR6Bqs6V0cRny
	A+dEbXFmK/tTvXFNuGPesVpQpJRRnAByKglkRUS8yBEgMaKnT2v3Ii9+M4o9CsBw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sYQlC-0000uL-Pn; Mon, 29 Jul 2024 15:49:58 +0200
Message-ID: <c6f93f9d-db6e-40c8-9973-18374af08ab1@leemhuis.info>
Date: Mon, 29 Jul 2024 15:49:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
To: Bert Karwatzki <spasswolf@web.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Mike Lothian <mike@fireburn.co.uk>
References: <20240718234633.12737-1-sean.wang@kernel.org>
 <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
 <81a6dad7119069d446a982d1c7da4fff5726d26b.camel@web.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <81a6dad7119069d446a982d1c7da4fff5726d26b.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722261005;64e50b16;
X-HE-SMSGID: 1sYQlC-0000uL-Pn

On 29.07.24 12:51, Bert Karwatzki wrote:
> Am Mittwoch, dem 24.07.2024 um 11:36 +0200 schrieb Linux regression tracking
> (Thorsten Leemhuis):
>>
>> On 19.07.24 01:46, sean.wang@kernel.org wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> Fix null pointer access in mt792x_mac_link_bss_remove.
>>>
>>> To prevent null pointer access, we should assign the vif to bss_conf in
>>> mt7921_add_interface. This ensures that subsequent operations on the BSS
>>> can properly reference the correct vif.
>>>
>>> [...]
>>>> Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add
>> mt7925_mac_link_bss_remove to remove per-link BSS")
>>> Reported-by: Bert Karwatzki <spasswolf@web.de>
>>> Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca3188c3742c7effd102e.camel@web.de/#b
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>
>> TWIMC, Mike (now CCed) ran into the problem and on bugzilla confirmed
>> that this fixes the problem:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=219084
>> https://lore.kernel.org/all/CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZkZF9pz37Bmh2iw@mail.gmail.com/
> 
> Unfortunately this NULL pointer dereference made it into linux-6.11-rc1.

Thx for letting us known. Seems this happened due to unlucky timing. But
the fix afaics will be part of this weeks -net pull , so it should be
fixed by -rc2 unless something odd happens. Ciao, Thorsten

