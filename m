Return-Path: <linux-wireless+bounces-34488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDOgOFU01WnY2gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:44:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457503B1F24
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20826304607D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5E3BC69C;
	Tue,  7 Apr 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="PCJbXyTj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5A270ED7;
	Tue,  7 Apr 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579964; cv=none; b=XekKUELJMkmbw9221vsN41saGtkjHVGTcKTRzPrwZPODaUTL1wwRl71nHV19N7GXn+lLL1R4DX03X/xIoEOA/mwM+ORGlVArlK7snUFhzyfOrxfjH2sP9bnxbim/uXhJG0/6oVM0txaG1Plwjk79150cVSKy6ngk2l0Ym9z8kVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579964; c=relaxed/simple;
	bh=1Ako3F/RuxhBhPwlL/Z6GVmzMFrpFn4MUzUSk5v2tRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHUadTG+ZxsOla8ippWnbNzz+OKg5NaZOTiLb01UT/kncWklU86Wz/HfJCIXrytjHnHIAsu3QSRQn5h2jCP+0iBu6oVzVVxTyHqlysBbW3ibSYAbOg1Li08lbETYJzVgd6bPDn8wXbSosS0VJh13IrnWmP9gNPmF/wNnvNAFFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=PCJbXyTj; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C3B90305F82;
	Tue,  7 Apr 2026 16:31:38 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 852532C00D4;
	Tue,  7 Apr 2026 16:31:29 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5859013C2B0;
	Tue,  7 Apr 2026 09:31:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5859013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1775579484;
	bh=1Ako3F/RuxhBhPwlL/Z6GVmzMFrpFn4MUzUSk5v2tRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PCJbXyTjnDxE20IrBFK2EKZ/c81LDM4pKOHtO3dHp649Av3VyhwfxBOOnea0KP6bn
	 vsxDdeGxbzZV3PTSY2PPyzsZwHbnrbyq9Od6HtnGOlcnNmJbEckCWs5/53SL0KuVRo
	 yX+ViSJ3XwqiM2zYGw+i3k8wklV8IBDawQd1Iz4s=
Message-ID: <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
Date: Tue, 7 Apr 2026 09:31:24 -0700
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
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com>
 <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1775579491-zfUrAYFX0LoG
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1775579491;zfUrAYFX0LoG;<greearb@candelatech.com>;cd1e1c133c9805f1fc8e076cc471adaa
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34488-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 457503B1F24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 09:00, Joshua Klinesmith wrote:
> On 4/7/26 11:25, Ben Greear wrote:
>> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chipset
>> at max.  So while the patch may be correct, it may also not matter in practice
>> and at least may not need to be backported into stable.
> 
> Hi Ben,
> 
> Please accept my apologies. You are correct that the mt7925 is a 2x2
> chipset, so this does not have a practical impact and should not have
> been tagged for stable. I did not read the documentation in its
> entirety before submitting, and that is on me.
> 
> I will be much more careful and diligent with testing and review going forward.
> 
> Thanks for the feedback.
> 
> Joshua

I am more concerned about the trickier patches that you have been posting
that is utilizing work from upstream vendor code.  How much of that is pure
AI driven?  How much testing has been done to see if there are actual stability
or performance improvements when testing actual hardware?

Thanks,
Ben

> On Tue, Apr 7, 2026 at 11:25 AM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 4/6/26 16:47, Joshua Klinesmith wrote:
>>> The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
>>> spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
>>> for the fourth byte, consistent with the other three chains and
>>> with the RCPI3 definitions used elsewhere in the driver
>>> (MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).
>>
>> Hello Joshua,
>>
>> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chipset
>> at max.  So while the patch may be correct, it may also not matter in practice
>> and at least may not need to be backported into stable.  If it is a minor
>> cleanup that doesn't actually matter, that should be described more clearly
>> in the commit message?
>>
>> Some of your patches are touching tricky parts of the code and making
>> subtle comparisons against how the vendor's driver is written.  How well has
>> this been tested and reviewed by a knowledgeable human in general?
>>
>> Thanks,
>> Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



