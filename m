Return-Path: <linux-wireless+bounces-32462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMPmFn0bqGmYoAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:46:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6D1FF389
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D45307E84C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDA735CB70;
	Wed,  4 Mar 2026 11:40:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D593451AE
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624449; cv=none; b=R6gv/hLi7By9aZ25Pjax9/RgF0zFtTflqOBZXv+YYR6FerBul9Fer+zYyEn673qJ9PDVZ6GiEWit2MzFrRx6oaF1NyCSKQJb17I42onnEdZubsz7orLx1MgbEc8O1sekuIyX+wFxvVFvEd0beH+37l0oHtN3JhwNF0BtVvcE3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624449; c=relaxed/simple;
	bh=BXcX3/PnydA2zj4sDH3Ns9vFVj/R4se1MyWd2+D6Krc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6nsLn9ZB8TmFricKgrqA1ZFlyBzqVxods3O55VxyFwisYZFQ+N3ZJvH3/uDjsFY8KRSdtUjdmFZSmsxO2MYBTg3Sv4nMz43RUp2xe5enXu7uVrACU9w38IKySIrnJTt3gX8hxLtpWv2pQd+aaYkMk/aIcpJincFXgSFaRAk760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 433664C2C37D6E;
	Wed, 04 Mar 2026 12:40:23 +0100 (CET)
Message-ID: <e1a7dc91-e1c3-42e5-afd8-1e8dc4ff23c6@molgen.mpg.de>
Date: Wed, 4 Mar 2026 12:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
 <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
 <2c722676-98c6-4162-96cb-9bea06672153@molgen.mpg.de>
 <badaf39e-6ab7-4be7-944a-cfc9d6757db2@oss.qualcomm.com>
 <e71b2039-0478-4775-b221-753dc25647d5@molgen.mpg.de>
 <80231e1b-fc6f-488f-97f7-92e792954022@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <80231e1b-fc6f-488f-97f7-92e792954022@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BAF6D1FF389
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32462-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,molgen.mpg.de:mid]
X-Rspamd-Action: no action


Dear Baochen,


Thank you for your quick reply.


Am 04.03.26 um 02:47 schrieb Baochen Qiang:
> On 3/4/2026 4:01 AM, Paul Menzel wrote:
>> Am 11.02.26 um 06:43 schrieb Baochen Qiang:
>>> On 2/10/2026 6:31 AM, Paul Menzel wrote:
>>>> Am 09.02.26 um 03:44 schrieb Baochen Qiang:
>>>>> On 2/7/2026 1:55 PM, Paul Menzel wrote:
>>>>>> Am 19.01.26 um 17:41 schrieb Paul Menzel:
>>>>>>
>>>>>>> Since January 10th, I have started seeing the warning below in
>>>>>>> my Linux logs, that reach back to September 24th, 2025:
>>>>>>>
>>>>>>>         [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>>>>>>         [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
[…]

>>> I managed to reproduce this issue locally. Will submit a patch
>>> fixing it.
>>
>> Sorry for being impatient, but as Linux 7.0-rc2 was tagged, were
>> you able to come up with a patch, or should the commit be reverted
>> for now to have more time to analyze this?
> 
> The patch is under internal review now, will submit once it is
> approved.
Awesome. I am looking forward to it. It’d be great, if you Cc’ed me on 
the patch.


Kind regards,

Paul

