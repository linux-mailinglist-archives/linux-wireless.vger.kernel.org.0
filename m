Return-Path: <linux-wireless+bounces-35209-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Es7FwOK6Gk6LgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35209-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:42:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD898443987
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA60300362C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D12ED15F;
	Wed, 22 Apr 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXvC8DKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCE336EDE
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847329; cv=none; b=l3HKLW8VLyS6LTRdTQ1DYlxVmslp7a0q1AlKhpH0bFqBJ/I31MV+iDhJ/GR2moK4K0bctgxVcvONa4uINpAzRLxqsGUb6FiL7WizNE5rNThOhuvctrrSYlw7ODgEwm5ajUeCZLMb7ggFNnOQJdxpQno0eyjSHsOF8O8+kQhXV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847329; c=relaxed/simple;
	bh=gWoeKAVK9W7vVlciLjZBHMdToMYeip3zGK7JNfHnd3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oflz3axSPBIpNnAY0BaRwz7Ls45VM0ZF6NNLZA+ULnUtC6o8Y6bZcAYdq2+b+vAjW+t8ozwxrlFqQE7mZNF3QoXnFyZQzC+nDGI1eh1PLKfXpK9GW/wEDNOvN6JFoeRvf7S6OSGDNqUTkoSMLxHF6lHbFK4POSpL8x2JtN9l304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SXvC8DKW; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-797ab169454so68623567b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 01:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776847327; x=1777452127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QFQoDaEWqT8ApSd3T/yPP9UgkoXGgDXy6M1Q+3Z+F4=;
        b=CT/WRjEXkBQwT5A+O90LjZjPu489gj3SaQs3yugmH1K71iPejyvTd6VMnYCop2lz6O
         ymnTDrFAgdPhN0yoVS6xfS3FXKUQJ2ZZwpUVOGmyEweBt9X4tC7UGK4TyEe4sRUVWgN5
         yirqL9aE2UzbPjCFh4B7TIr4ZM8EYZEjRYIajDe9hQxTd9RTjl8yV9L54LNjNobew6Cw
         uiZW1X5VsJdERW551ao7GSp61skndvEMSq6OygIoQzmMCQ4+3zbbAyStxGHtZIGNPgwd
         TuYkLns/v6zU6atXBwdwULB2E60u6mGsKQCm2okIyAjxyCBEHA0eww3pnBSYP/2UEWt0
         j1fw==
X-Forwarded-Encrypted: i=1; AFNElJ+4w3z5xnpQ6eXIAarMlhhu6DckwZPZ9e8wKoznOGLzVaY7Ziwm5dZSFIWp0lsZLEZLrDXUtG4uGtvCA1IQGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMaexClXk7oCkstgJ50EOC9E0/jHJCte/hZ564bWu7495G8j7
	w44XlAhsgmjt2bMJD375gzcRk9vYdicscf64BFdia2wpypWHk4q5Su1ysRTZYYVkPIcEO9qk8Jt
	dF1S1kjOxN7A0DJl5mjsTADXOg6vdjCNnb/G/BzWxN+SRTWZZJDJeCd2MXcEkprDoS1bnc3+/5c
	Wo3o/uefTFi9Ds8o883iRk/gZ/keQwwXSAwzVDknZOVYo19BFSdleaIsjMA+BpOOZCAxGIg8PnD
	tID6XzeR0ymn8Ozs3N1FpQYX+zJ
X-Gm-Gg: AeBDiesmcWqFsstAN8/Tt7xZxekcPwd28Q2D7IhNOwGQCB0Oy97zHc7q2UtNbcvFOiD
	Qqv6Km9bZirCLvrrQMheeHjSz00Q4yeM5KBFRIRzgBvSjxfR3yMr2M4lTbkJKI49NYXljAfXa7Z
	Y5ix+vyD+APBwYN9KKhUNi5pxUq31shencMIW73pmvChMw6JpfvD1PsjteNl14gxXbOVc20xFLp
	UU/qfAYEUUID7x36TyEHZ0insvM2iTmIg7bZ0mznOta2JKjalFnK5WIHEjwGncB/Pwc8SxfGD6Z
	9S6Zu6D8MCqVM9LCx0O6ej9or/kIWacnTb+8/yyzxe607RYO0kIj1w63SosidW8Z8t0g4JwMMks
	H2kXzSHQ3pvyhDsKhkM8po7sPWmXJ1msv6pR0MZ/ASiHLY4CH8C+U1cp5xdrzklumQljDgArKb8
	nGuW0uoQGlo8XDTMODSYQES816CYwgfnnwyaJDDK36WuBzWWHk72sLWuVNqelE2yjboAUoESE=
X-Received: by 2002:a05:690c:698b:b0:7b4:e6dd:e9cb with SMTP id 00721157ae682-7b9ecfb121amr221062567b3.33.1776847327489;
        Wed, 22 Apr 2026 01:42:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b9ee9a8194sm10744387b3.19.2026.04.22.01.42.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:42:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b0312bb1dcso121792326d6.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776847327; x=1777452127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QFQoDaEWqT8ApSd3T/yPP9UgkoXGgDXy6M1Q+3Z+F4=;
        b=SXvC8DKWoxbBR3yEIOga3oj2ftxb8++HWmvKaPmDKhad4N2ZLqM+xz2cJ+xSKRcZ/J
         NcwZkj2KcDMadAgyGCNhjIpNCI/hCVMkLRwf6Vr3puUtTD/hy9BR0b3aWNiD75HqsSJi
         3ucVWD9Uq5IbNZzPyJeOBCNVCGpZU1J+jlLL8=
X-Forwarded-Encrypted: i=1; AFNElJ8nB/0Uh7ysCjtKiKPpXB4+UInvzJ6gTF+6wGzDGXxUunBAlHgd91PQwI2SV/v3xLLgYd8L63xnW+AB7eVd5w==@vger.kernel.org
X-Received: by 2002:ac8:5851:0:b0:50e:fcbc:6b7e with SMTP id d75a77b69052e-50efcbc6e9dmr135631961cf.29.1776847326749;
        Wed, 22 Apr 2026 01:42:06 -0700 (PDT)
X-Received: by 2002:ac8:5851:0:b0:50e:fcbc:6b7e with SMTP id d75a77b69052e-50efcbc6e9dmr135631701cf.29.1776847326249;
        Wed, 22 Apr 2026 01:42:06 -0700 (PDT)
Received: from [10.176.2.190] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae6133dsm121556606d6.25.2026.04.22.01.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:42:05 -0700 (PDT)
Message-ID: <1a3eafb8-f0a3-4da3-bf73-13e8e1a67045@broadcom.com>
Date: Wed, 22 Apr 2026 10:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
To: Johannes Berg <johannes@sipsolutions.net>,
 Michael Bommarito <michael.bommarito@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>, linux-kernel@vger.kernel.org
References: <20260421224552.4044147-1-michael.bommarito@gmail.com>
 <e4b3f365a32b633babcd4cefde3fc32460e07e0d.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <e4b3f365a32b633babcd4cefde3fc32460e07e0d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35209-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD898443987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 22/04/2026 08:23, Johannes Berg wrote:
> On Tue, 2026-04-21 at 18:45 -0400, Michael Bommarito wrote:
>>
>> Both ops were introduced without a .flags gate, so the generic
>> netlink layer dispatches them to an unprivileged caller instead
>> of rejecting with -EPERM at the permission check.  Every other
>> connection-state op in the adjacent block (CONNECT, ASSOCIATE,
>> AUTHENTICATE, SET_KEY, ...) carries GENL_UNS_ADMIN_PERM; SET_PMK
>> / DEL_PMK were introduced without the flag in 2017 and left
>> unchanged by later refactors.  Johannes checked the original
>> Intel submission history and confirmed there is no admin check
>> in any prior revision either, so this seems likely to be a
>> simple oversight rather than an intentional carve-out.
> 
> FWIW, this submission did originally come from Avi, but we no longer
> have a driver using it (it was never upstream anyway), so that now the
> only affected driver is brcmfmac, AFAICT (other non-upstream drivers I
> wouldn't know, of course.)
> 
> Arend, it does seem like the right thing to do here, but I wanted to
> confirm with you and thus asked Michael to CC you, what do you think?

I agree. I saw the patch earlier this morning and acked the patch just now.

Regards,
Arend

