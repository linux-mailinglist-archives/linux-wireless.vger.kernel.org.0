Return-Path: <linux-wireless+bounces-10822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C1944F06
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A082825CB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702721A3BDA;
	Thu,  1 Aug 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmdiopqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEA13B7B3;
	Thu,  1 Aug 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525735; cv=none; b=fJteRfObxbMIJNY8/tNRtivFDdi8AG1sx+oeXQaOt/dVGfn98RDIidWsNzBcGqt921lan4+kacOwrRPlxLDcLKMqjcgSv5gDEGiZpo/2mPah7V2YkRfhQcdie0mUFPhF5KEBWNaDOO1MWCB1SXlxMzFrSxe9AHt3vLLNdUA2rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525735; c=relaxed/simple;
	bh=Qn9YJ7trcFj6yg58ewscujUP/3VbD9mTF4ZHn5lRbKI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VjiQQZv2VPSgc/4ntPNVl7pwlHt1zvGyG5207TZessQ0m4Lkk8eNxH4BfLhD99svBiWK3ISx/I5nrteN1GxLFmJySyB4iVd6Frbw7tn59AzlIU9xi7WohVEMyfrtdg1CXQXkzK5353Q5OcZ+IOY4RU50R8xz6lmsc7ZIAn0r4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmdiopqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80225C32786;
	Thu,  1 Aug 2024 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722525734;
	bh=Qn9YJ7trcFj6yg58ewscujUP/3VbD9mTF4ZHn5lRbKI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YmdiopqKIbZOBr43euRj6vpXulqD/A4Pu79AAHXmJxhVodjFp3KPpN9IffjSfcmD4
	 0For1ae3Wb/9tJq3Mreuh1cWe/6A4Te4xGSCfQdchJIMqAPLAoRv2yghx9HmNzRGya
	 4tuPfqcn1s751x7hiUuMEKmXgmw3L0AhQR8R1gbI9/qrg+vrUe2/EnkiOCdL2EWZ6I
	 hatZZK9TwfrM772xjr67voIaA92YMYxMzfym02bpW4VEHcKO+dfEq+L8Gn+XaxZbnZ
	 v+o6CQJx/Ru/Ys6GtkgMudLumVKX8pHxl1YhKJomT+Dgq5R3I0tz5zYjmy1hhDO0zW
	 HpgByY/sX1aCw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <kernel@quicinc.com>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit
 path for WCN7850
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
	<c26af1cb-747a-462d-8e13-af948bbb8171@quicinc.com>
	<df00b06a-d33b-4df8-8f44-2b7f659cb2f9@quicinc.com>
	<1aad7e68-c2d4-4b77-b526-5580860d7e3e@quicinc.com>
Date: Thu, 01 Aug 2024 18:22:11 +0300
In-Reply-To: <1aad7e68-c2d4-4b77-b526-5580860d7e3e@quicinc.com> (Baochen
	Qiang's message of "Mon, 22 Jul 2024 15:02:43 +0800")
Message-ID: <871q388dzw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 7/22/2024 2:54 PM, Baochen Qiang wrote:
>> 
>> 
>> On 7/19/2024 10:10 PM, Jeff Johnson wrote:
>>> On 7/14/2024 7:38 PM, Baochen Qiang wrote:
>>>> In transmit path, it is likely that the iova is not aligned to PCIe TLP
>>>> max payload size, which is 128 for WCN7850. Normally in such cases hardware
>>>> is expected to split the packet into several parts in a manner such that
>>>> they, other than the first one, have aligned iova. However due to hardware
>>>> limitations, WCN7850 does not behave like that properly with some specific
>>>> unaligned iova in transmit path. This easily results in target hang in a
>>>> KPI transmit test: packet send/receive failure, WMI command send timeout
>>>> etc. Also fatal error seen in PCIe level:
>>>>
>>>> 	...
>>>> 	Capabilities: ...
>>>> 		...
>>>> 		DevSta: ... FatalErr+ ...
>>>> 		...
>>>> 	...
>>>>
>>>> Work around this by manually moving/reallocating payload buffer such that
>>>> we can map it to a 128 bytes aligned iova. The moving requires sufficient
>>>> head room or tail room in skb: for the former we can do ourselves a favor
>>>> by asking some extra bytes when registering with mac80211, while for the
>>>> latter we can do nothing.
>>>>
>>>> Moving/reallocating buffer consumes additional CPU cycles, but the good news
>>>> is that an aligned iova increases PCIe efficiency. In my tests on some X86
>>>> platforms the KPI results are almost consistent.
>>>>
>>>> Since this is seen only with WCN7850, add a new hardware parameter to
>>>> differentiate from others.
>>>
>>> I asked for expert opinion on this patch and received the following response.
>>> Baochen, can you take a look at this suggestion?
>>>
>>>> Aligning headers is sometimes done, but it appears the driver
>>>> doesn't support scatter gather? I think the author may want to advertise
>> right, ath12k does not support SG currently.
>> 
>>>> scatter and linearize manually in the driver, to a correct offset.
>> is there an existing skb API or API combinations which can do that
>> for me? I checked __skb_linearize() and it does not take an 'offset'
>> argument.
>
> or do I need to implement it myself from a very low level basis? like
> (if required) allocating skb structure, allocating/aligning payload
> buffer, copying/freeing paged frag/frag list, etc..

I don't know __skb_linearize() well enough to really comment here. I'm
leaning towards we just take this patch to ath-current for v6.11 and, if
needed, optimise it later. Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

