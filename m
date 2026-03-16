Return-Path: <linux-wireless+bounces-33302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCuhDD8buGlYZAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:01:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F129BE9F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 16:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0389B301E7FE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0DC38E5D6;
	Mon, 16 Mar 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWhGNddg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2732B989
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673143; cv=none; b=r6Dktxmy89ozGNYOX0vjzseMKzlW4q8x4jzqkMyk45EqthWHb8jsdZgsYZF4pZth7W1PHgF70UDfIgV2Tar/+GuT1J5kyerlh8GClryRiKDi0WiI7ccaIUPOkocg6rPlx+Fo6S32kFWuCLYICh1OMiuqXzHd/xmyDdPlLHpafSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673143; c=relaxed/simple;
	bh=wJYyqcB6Eyw+/EhnPhvbw/Bj0ziOpl+uCsmKsvGSW0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1vTepa3+hNb5awcsoexqREisg4KOrxVs+02yBWB4clGSFi2t93X03f7flCir/if5I5OJ5U8lR/DWWZ2qHJti+UI5aWthKmZogzV7vBjxc1IJqiB5nHzz2fuZ9/XksTUR6rRjiobEpzXBn03ADtZdDZL+2gUBlnQ799ezM9bPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWhGNddg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd7a75c680so553744485a.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673141; x=1774277941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlEzqxK2YEl3SXEgkPbUbfs0P9bQP+Yj8HFphhFYGSg=;
        b=UWhGNddgvoXFtbdV1LHjvfm18s9HgsK51c1SvP3dInAtOLKV/8dxuvGYEAsSD4+e1I
         xRt+hRWh+tXuOtrMacx5seiHzIeSitJbatMevfG/guN9VqMVvnfjrcEGk318HCOhtyLP
         9eeDMCQWF3diB9l45QFuE7C08MPLm3nwFpyrUgvrhAHhNmdr13DmuBDm0rBG9rHofMwz
         dkAP9wrV5DsjkC0mPrylffcSDu+qtZ6cGJi22XRtkCQNQZmg8acAHWmiiorqKDWsEYZR
         Sm+R0k3kHYjNzzTqO0ixPvdkJvfCWRTkdn+yL/gRgDcEilTBdbuuBSiJqe1iWWBjsHLT
         kJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673141; x=1774277941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlEzqxK2YEl3SXEgkPbUbfs0P9bQP+Yj8HFphhFYGSg=;
        b=BdsNS4QzjoTUu+i0m0vv0XwUURfZNMGXuVTRPLMjQz+QvN2/Zldtu9MYx+qegmI01T
         8Pi4QsWDJVQlCrLefSJztV4dy3T2GJY3Lta0wkpjgpPc0xoeEMDnpNgHt7pMpBOs8v+n
         DIEdBs4hvSDVr2pOcPi0BgdIBD3Hv2yNaI1dAlvt01IGCrR4VuUSB7oAfQQf9gxAJ6Ca
         FnBSKp/SmyOVojaEWpfSN8JADbM2gFUDEuyH40FnfsME1W8IVlo8bJCAhua0lr1vQjHv
         7wbc6RpEUS5AgmP0r6Zg0IeVLzJubCHZI05z7gshr0vY3k7yx3AP3wcUTs/C4gu5kZSY
         lhbg==
X-Forwarded-Encrypted: i=1; AJvYcCVjffs9gR/mZyYa5XfWK8lPLh+Pm4StAffxMZ1r/GM4z13v49cI4+XrfsDAr5PE2HqDActq+l2o4krJ2hYo6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5756ZP3nwvRLbkjuwmauggW5gzMHRdCUQuyaMdzb6Vv/xf1y
	G6VENHVkje6xdbhq3dSsb5fOEre8k/OlnQ4h6I8Pojf88BHsjNR94pBz
X-Gm-Gg: ATEYQzw/6XXwtImty3X9OJdnUYil+A8Fb+97VdqPLWNFfbWy7AkJkzT/TuImJ4sJ+pN
	1p+woNdQL9QOKh5Mua1p/H13EZXR0YyA0BJtXTA4yljxAlPj58Oxwl/ceUSI09g7Jhdzv9V9xDc
	/+ghAnd7MZBmvLSmRcg+rrElIVgfnE80YvNv92r9rjkKMhCMWfhWQa8bW0hiHpRrblhm7OCmSdu
	7lcRy7YofqqPqigpUHq1qox7zRZcsSM0C/F4kvxjQ+4dGoppUZtgRB+lAY6/Zkk7ZiRtCqWAuz7
	h+VXEdWmkIlHYuX0EsBasmx/f6M24bnd9C1sfcJDQXBjpTN/jBn1MhKE4hXmSjz5rLWgqv+6P60
	lDQP2GEwUk34S7L3FsN8NsFz7YiO0N1O88T377f08AjeYtggsEUslSSYnDYruHc+1B0RZZBvPjB
	M/Cyx4QvFmUX8AcoTQl+FrFdFTLq8jEwyYwr4sPeHiUTigWOWhdRRK4QgL0A==
X-Received: by 2002:a05:620a:2913:b0:8cd:94f9:1bbb with SMTP id af79cd13be357-8cdaa870dcamr2022355085a.29.1773673141041;
        Mon, 16 Mar 2026 07:59:01 -0700 (PDT)
Received: from [10.100.120.215] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100b8sm1232308185a.29.2026.03.16.07.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:58:59 -0700 (PDT)
Message-ID: <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Date: Mon, 16 Mar 2026 07:58:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
 <20240815171935.GO3468552@ziepe.ca>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240815171935.GO3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33302-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 831F129BE9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 8/15/24 10:19 AM, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:
>
>>> This is probably the only way to approach this, trap and emulate the
>>> places in the device that program additional interrupt sources and do
>>> a full MSI-like flow to set them up in the kernel.
>> Your last sentence here seems to agree with this approach, but
>> everything else suggests disapproval, so I don't know where you're
>> going here.
> Trapping and emulating is fine.
>
> My concern is really only about skipping SET_IRQ.
>
> That works because of the assumption that the IMS sources are going to
> re-use addr/data pairs setup in the MSI CAP.
>
> That assumption is frail, and won't work at all under the proper IMS
> support Linux now has.
>
> I really don't want to go down the road and have someone tell Thomas
> he can't convert the Linux driver to use irq_domain IMS because it
> will break this stuff here.
>
>> I have no specs for this device, nor any involvement from the device
>> vendor, so the idea of creating a vfio-pci variant driver to setup an
>> irq_domain and augment a device specific SET_IRQs ioctls not only sounds
>> tremendously more complicated (host and VMM), it's simply not possible
>> with the knowledge we have at hand.
> It seems like you have reverse engineered alot of the necessary
> information though??
>
> Maybe there is a more generic approach than a variant driver. If you
> wanted to use IMS from userspace generically you could imagine some
> kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
> needed irq_domains and pass the addr/data pair back to userspace?
>
>> I observe that the device configures MSI vectors and then writes that
>> same vector address/data elsewhere into the device.  Whether the device
>> can trigger those vectors based only on the MSI capability programming
>> and a secondary source piggybacks on those vectors or if this is just a
>> hack by Qualcomm to use an MSI capability to acquire some vectors which
>> are exclusively used by the secondary hardware, I have no idea.
> Well at least that should be testable - but it seems crazy if the
> device has registers for an addr/data pair and then somehow doesn't
> use the values that get put in them??
>
> Copying from the MSI is almost certainly a SW hack because IMS support
> has never really existed in an OS until now. I think your guess for
> why it is like this is pretty good.
>
>> I do not believe that introducing a vfio device feature that disables
>> virtualization of the MSI address/data _only_ at the vfio interface
>> (not to a QEMU VM) provides some implicit support of this device
>> behavior.  These values are already available to a privileged user in
>> the host and the same is available for an MSI-X use case by directly
>> reading the MSI-X vector table.
> To be clear, I'm not really worried about showing the data to
> userspace.
>
> Userspace just shouldn't be using it to implement an IMS technique!
>
> Jason

I see this thread went stale. Wondering if there was ever a final 
conclusion if this could get fixed for ath11k or not. I tried again on a 
recent kernel, 6.17, and see the same behavior.

Thanks,

James


