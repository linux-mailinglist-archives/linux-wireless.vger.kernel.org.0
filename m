Return-Path: <linux-wireless+bounces-36393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB7SI5PABGoeNgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:18:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B881538C78
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB6B3011EAD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E233A71B3;
	Wed, 13 May 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6ktoFi5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D953A6EE4;
	Wed, 13 May 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696334; cv=none; b=DTkafzuWEJvPvN1yCPHY7y9y3VwFGdpMtSdJygIRQ++s/Zp5YRzVyEaa8WNrbVQzhtV/6FIz/kcfNXkGVCRBZhsiT+gMtrKTVma5pPMqFFRjr6FqqR5YZhOcrXpGKcnC5TFQBQbqOgo/j6M+LnzBFUBdslccAgZFv61DeyZcsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696334; c=relaxed/simple;
	bh=ALdOjMYx3zUh+YoRWLmVw1CO+5mMkgr3lup21x2wmP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X68KQqw0/UQBylp3ykw0LL+ZcZy5u6ar+t9/2oFZMMZiIPvkFpS21RyeIxVdS43XFOgaym7GXU6aeo7msyDrZyK9Y+OhNXRzi/8wC3m4eljiMUIZ4vF9+iqPPwefmFj1E6HpIYCRwD1iKgKB4TQaiQxo7Kd5mtv+DLhibNp8KF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6ktoFi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E67C19425;
	Wed, 13 May 2026 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778696334;
	bh=ALdOjMYx3zUh+YoRWLmVw1CO+5mMkgr3lup21x2wmP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T6ktoFi5HwjQi416akOmoP3EuPXRz16yfZcNaiSiKRLS5xTIeGG+JOXFnxTcjE3Yi
	 YB88cUZFV06/No1YhPTmuwecbNDLBJfA5y99HoCv8ow9T6c6uXlKPxjI0+1tWkBX1R
	 NXJtpW2f2FQguobAMDtAxD7e65J9sxxAZCPctn9VuZGSwpLUrwAcDGn9epBhgcHdGQ
	 1cmfkm6fcKdRLuLrZEM34HVrvnI9/49rt0WOCrVxGb/xdtU+uib0G3/yKZ8sPMiUfA
	 Nha+5COm7ZmSUwaIwPmcYZohh+fwdZh6PFybYQKkII2nyHsyP2k0m7pZAsimzCA55D
	 96XZ5lwuHJ8sQ==
Message-ID: <a51ba34d-92db-46a5-a87d-15cea72af833@kernel.org>
Date: Wed, 13 May 2026 20:18:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
To: "Bhatt, Avinash" <avinash.bhatt@intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Guetta, Kobi" <kobi.guetta@intel.com>,
 "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
 <20260505-crouching-albatross-of-beauty-a5ac6b@quoll>
 <BL1PR11MB5954BCE96853D1F299E4DEACE0392@BL1PR11MB5954.namprd11.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <BL1PR11MB5954BCE96853D1F299E4DEACE0392@BL1PR11MB5954.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B881538C78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36393-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On 12/05/2026 12:07, Bhatt, Avinash wrote:
> Hi Krzysztof,
> 
> Thank you for the review. Please find our response inline below.
> 
> On Mon, May 04, 2026 at 12:53:24PM +0300, Krzysztof Kozlowski wrote:
>> Please provide link to any upstream DTS user of this binding, either
>> complete or work in progress.
> 
> We have OEM partners waiting for this binding layout to be finalized
> before they proceed with their DTS work. Our intent is to have the
> schema reviewed and accepted by the DT maintainers first — sharing a
> binding that may still undergo structural changes with OEMs would create
> unnecessary churn on their side.
> 
> OEM partners are targeting platforms that depend on this binding. They
> are waiting for the schema to be finalized before proceeding with their
> DTS work, and whether they upstream that DTS is ultimately their
> decision.
> 
> If a DTS user is strictly required for the binding to be merged, we
> understand and accept that requirement — however, since OEM upstreaming
> is outside our control, we would greatly appreciate an early indication
> of whether the schema direction is acceptable before we distribute it
> further. Any feedback or provisional acceptance at this stage would be
> very helpful.
> 
> We are actively addressing all the review comments from v2 and plan to
> send v3 shortly.
> 
> Best Regards,
> Avinash
> 
> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org> 
> Sent: 05 May 2026 14:50
> To: Bhatt, Avinash <avinash.bhatt@intel.com>
> Cc: devicetree@vger.kernel.org; linux-wireless@vger.kernel.org; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; johannes@sipsolutions.net; Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>; linux-kernel@vger.kernel.org; Guetta, Kobi <kobi.guetta@intel.com>; Grumbach, Emmanuel <emmanuel.grumbach@intel.com>
> Subject: Re: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware integration information
> 
> On Mon, May 04, 2026 at 12:53:24PM +0300, Avinash Bhatt wrote:
>> Add Device Tree support for Intel Wi-Fi hardware integration 
>> information on platforms that do not provide UEFI variables or ACPI methods.
>>
>> Patch 1/3 adds the DT binding schema for the Intel iwlwifi compatible 
>> node. Patches 2/3 and 3/3 add the driver infrastructure and integrate 
>> DT as the lowest-priority fallback after UEFI and ACPI.
> 
> Please provide link to any upstream DTS user of this binding, either complete or work in progress.
> 
> Best regards,
> Krzysztof

Do not top post.

If you are not willing to post DTS, then you are not helping us to
understand the completeness of this binding and hardware description.
IOW, the bigger picture is missing, so IMO I would remove most of the
properties.

Best regards,
Krzysztof

