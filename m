Return-Path: <linux-wireless+bounces-32518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDfbNeB8qWkg8gAAu9opvQ
	(envelope-from <linux-wireless+bounces-32518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 13:53:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4921226C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 13:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAF63300B196
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF32989B0;
	Thu,  5 Mar 2026 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="iFVGS4rz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3F2405EB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715228; cv=none; b=JbRz4ag/jyLwBE6C37gAU7eVPZukwQyaYtDM1xkwfz+dgz2utlO5roGd+jyHU7xGqyrlQmMBUARlnoZ9F2bsTrHD8lmLINjViIjgXRpReBXZqM/1ft7MuwZGZUHhvkdHNbkweefuWUrtMvTOh4kSu7OWyQj18EXNOTgnw5gnEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715228; c=relaxed/simple;
	bh=NFGrH9ICNuVDBqQI7uJ38Ysv1W2/fB8WdA/RcGq+o4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS5Nyi7Q8N0AVA1wrcw7UWfisXWOKoiOauiiDLLAjRun7lSROuIkwT03JJBFgVifkGpCQClbsd59UOehOwJ8GRwh0jvIpYOua1B6P6B+FDicQoSlTKSCiyNcI4THhmTDt3PsPIfuQako6s0vK4HAqBdPMRumB02Ow/iDEwDromU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=iFVGS4rz; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:740e:0:640:bd25:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 4D77D823E0;
	Thu, 05 Mar 2026 15:46:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GkoOk8DGGuQ0-8HIWslk2;
	Thu, 05 Mar 2026 15:46:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1772714778; bh=E+cxzkSZ3M+R2V/9tQMeQCEUMvs0PpleX3r3RBKDl/Y=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=iFVGS4rzjVrUnrJHeSxCWAcrpFVN6fJQs/Lp/9RRWr5HNeYgLt21eZYTXhlWYxxdU
	 25Mms++x7xhOxEK3b4czNsyHzYtcZYmnjJldj3pAxiiaKuM7MZkvUzqPyi3Kd/ePTO
	 G3AJVsAKcXIr3ZIby9DBdFqYlXkJJdDGOnidMayY=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <facd539e-916f-4511-bc25-61c79433aed7@0upti.me>
Date: Thu, 5 Mar 2026 15:46:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, tiwai@suse.de
Cc: ath11k@lists.infradead.org, jeff.johnson@oss.qualcomm.com,
 linux-wireless@vger.kernel.org, mpearson-lenovo@squebb.ca
References: <875xaypnkz.wl-tiwai@suse.de>
 <b410fa3f-0241-4805-afb0-efb950e04bd2@0upti.me>
 <09b6b13b-2b88-49b2-b865-f70996708c01@oss.qualcomm.com>
 <c63b4cc0-3157-432c-a83b-c638e8c8d665@oss.qualcomm.com>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <c63b4cc0-3157-432c-a83b-c638e8c8d665@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7AC4921226C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0upti.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[0upti.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[0upti.me:+];
	TAGGED_FROM(0.00)[bounces-32518-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@0upti.me,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On 2026-01-12 05:37, Baochen Qiang wrote:
> 
> 
> On 1/12/2026 10:35 AM, Baochen Qiang wrote:
>>
>>
>> On 1/11/2026 6:47 PM, Ilya K wrote:
>>> Hey folks,
>>>
>>> Sorry for bumping an old-ish thread, but I've had the same issue on a T13 Gen3 machine as well (model 21CG), and there seems to be no better solution in sight.
>>>
>>> Also, here's another instance of what I'm pretty sure is the same issue: https://lore.kernel.org/ath11k/6268b094-5a40-40d8-8461-9c9b0f9e1ae3@oss.qualcomm.com/T/#t
>>>
>>> Can this get landed at least as a temporary workaround? Also, should I submit the 21CG quirk as a separate patch?
>>
>> I had an off list discussion with Takashi, and based on the logs collected I don't think
>> this is not a suspend/resume issue, or even this is not a STA side issue.
> 
> my bad:
> 
> s/this is not/this is/
> 
>>
>> Before we conclude whether your issue is the same or not, can you please describe your
>> issue in detail? specifically is it an unexpected wakeup or is it reconnection failure
>> after a normal wakeup?
>>
> 

I've had a bit of an off list conversation with Baochen about this a while ago, but I just saw https://lore.kernel.org/ath11k/20260214212452.782265-38-sashal@kernel.org/T/#u landed, and I still haven't had time to get more data on the affected machine, but it has been rock solid with the quirk added locally, across updated and different APs. Maybe it makes sense to add the quirk at least for the time being? I'll try to get some debug time in the coming weeks, but free time is hard to come by lately :(

