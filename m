Return-Path: <linux-wireless+bounces-34490-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMzEKPo/1Wk73gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34490-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 19:33:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD433B2633
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 19:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59A0308F059
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A05344D8D;
	Tue,  7 Apr 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="TNND+m6l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CA33ADB5;
	Tue,  7 Apr 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583075; cv=none; b=UbZUMA2L4dH9mCaplrYvySJ14GuLWp4HMBUKhmzFlOc6FO/sPoZgir3bxCRuyUgNIDasn+FLVdvfI6U7diP8iHJUDet8nwaHKxArCGRs4YYB8RH1xep0kPT4zuhmmcY+CCjz4PD/8LMwIoKcD3rvBWNtsa5Zj5ymhsXWk51/bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583075; c=relaxed/simple;
	bh=uYGXrROU4X8csqVd6RltyvUGkSocVHoIvd/scjuPBn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsvNZHHew0Ui5zdyAkxmBsuYCZEiMpJdVh+KDUxTmDgjB+LKMExEv1jLHgZHP57SPZNRiJBtmCEUF7yqiGGbsejtY0KU/Hu8fpFii8UX9piaCyvU3vhWHKSJKK9JhLulO5NEh9oh2xAM2N0Bp/aFwW0Fz163+WNZNutIMuHR+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=TNND+m6l; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4BD00180084;
	Tue,  7 Apr 2026 17:31:07 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2BD6313C2B0;
	Tue,  7 Apr 2026 10:31:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2BD6313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1775583065;
	bh=uYGXrROU4X8csqVd6RltyvUGkSocVHoIvd/scjuPBn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TNND+m6lrbMgpiQVWTYgIcMMzNWJFCmBgDAo6Q5X5+SPSU0TpxMzL5QXhpIBic+zh
	 x14Nbq6h5QiulOsAlDH7YGy4J+WK31rBui1anb4SjvIssqAEuvUsjMBMYGe1HHA1tB
	 IyaU0eG3Gl6xCSorEs04myw2lFeZZM4C3GfcANJ4=
Message-ID: <5e197844-804e-51d7-a1de-e9e7686bad0a@candelatech.com>
Date: Tue, 7 Apr 2026 10:31:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
Content-Language: en-US
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com>
 <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
 <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
 <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1775583072-8JS1m76odQoM
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1775583072;8JS1m76odQoM;<greearb@candelatech.com>;cd1e1c133c9805f1fc8e076cc471adaa
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34490-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:mid,candelatech.com:email,candelatech.com:url]
X-Rspamd-Queue-Id: 0AD433B2633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 09:58, Joshua Klinesmith wrote:
> On 4/7/26 12:31, Ben Greear wrote:
>> I am more concerned about the trickier patches that you have been posting
>> that is utilizing work from upstream vendor code.  How much of that is pure
>> AI driven?  How much testing has been done to see if there are actual stability
>> or performance improvements when testing actual hardware?
> 
> Hi Ben,
> 
> To be straightforward: my workflow involves pulling GitHub issues into
> AI prompts along with firmware analysis tooling to identify potential
> fixes. I have an MT6000 available, but I have not been doing thorough
> on-hardware testing before submitting. That is a gap I need to close.
> 
> I will hold off on submitting further patches to the mt76 driver until
> I have a proper test workflow in place and can verify changes on real
> hardware.
> 
> I appreciate you raising this directly.

Please be sure to add note about using AI to patch submissions,
and link to original bug reports you are trying to fix.

Possibly some of this is useful, but you need to do significant tests
with real hardware if you are proposing non-trivial changes.

If you are referencing publicly available upstream driver source, then
be clear about that and provide links.  'Reverse Engineering' could mean a lot of things,
some of which is grey area for patch submission.  If you talked some AI bot
into finding non public source, or if it can actually generate useful c code out of
vendor binaries, then I am not sure how legit that is to even post.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



