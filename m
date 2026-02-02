Return-Path: <linux-wireless+bounces-31450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFMyEs18gGnE8wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 11:30:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF977CAF6F
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38D183028C12
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC70286415;
	Mon,  2 Feb 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="cwHckWFk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61772359704
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028080; cv=none; b=Vg4+yl8X3pJxJUHo3useLnNyZhxdvpTG+FQ4Yq4letccrUnJsVP6It0ZX9C7+6CtrFFfePBeWK5J+9TgcvIBctO5MXb+Rf/z3vVMa1RdOAW1gCYWpALVXuJp3M481JT7vUT6sLZfbJESW8AcvsYyK1cMTThy2/gBo0VM/c9L8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028080; c=relaxed/simple;
	bh=uXWDgScP9HIYkB0FHhKJEcbowvp+Nwisqc5EHOyZnPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ulgdVymQ7+nqM0JfzXaTjIz2FlqCLCr+8V6CBWi19PrEJarTZyYpSHRiqIMPh/Fnh4ZqUK0apXvZ+SlCKatxxFdkBljecprlcRrX85NuU0Pptt0j8/aQlI8AYfOhGfzPV8AKBLQxMr4LCZvzBKBcNQvjsk4YYjwDBbgSETsQe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=cwHckWFk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806bf03573so20512235e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 02:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1770028075; x=1770632875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMhu6wWazKj9YgoKo3g5O3QImy2vhP++6Ljj/m2mie0=;
        b=cwHckWFkD0kOGnb1nBp1NuM0f5t268r8+VKU8wtK7WBdH31e+VCUxcKN4uBbvbpKBr
         pFaiO55phKqKIDqoYsrCLGq7U7jfAmx5emk4iq5XaImK83C3kt9vZuqHlv8qtz2dc8L6
         JcCYb0bj03dTbvJeDrHC+sg4fi82AXBPQ5ttZBTiGNSMLcIInuIlki1e6728aq7mtFga
         Oq67e0zuEpE8btZ6OFn87oBLGVlLcPAvla4nW1O5IKvmk1kNmw0uTT2bc7zOdtEXOxvS
         dnmX9jydokQZY5OG4ymXOS+JB3VNsyBgWEf5ohpmQjhc4pkp/SZLiti2Yj2cU0joZ8s9
         Qy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028075; x=1770632875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMhu6wWazKj9YgoKo3g5O3QImy2vhP++6Ljj/m2mie0=;
        b=fAqX0y6dupAHlbE5YntY1xKO5gG81pZ1O+aafdPMhE+Np9MjfOSwgh9xybxlTbO6RV
         3c13YrDxiErAM9WqktvjItML97J4n04YX5OKHqj/LmZCUmattPL/BehXVy2/99zcVOI8
         xr0M9+M6VP+djrmY7nAxsUgT0R7vy2RM1nA30U8XPUrdHzrRN0gQ3AUe9LiU+DwelFlL
         ZLpiySfaen5itXYonLd0d4sUkwwdW/opgI78pLDVPJCYA3owroXxRAO2a6oKQb6/tomL
         twOLz6rW0S9WJMEbQPMHt3rydoCg7rOBbXXIO5KUjAOL1QfQiAfkoQc3jwn7OoTUwzD9
         Q9wA==
X-Forwarded-Encrypted: i=1; AJvYcCWZCV0zWo2vO3uSOU1hh+ATIj3NqXSin5EN4+b/4UbdiUEpwzHxP3YJ9P22dntT6wHi2MUSnr17Hy2779HUSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xzSKaqbYx4VmTWO2g0REdQwYIQkW57S2hYKFs65v/6mrdCLG
	cgou+OgwRU6xWfoeBDZYLo3qc1G7N8CYhuQ1zDYonjIZbx0jZFv5w9uorkSZdO8JWeMvK+IxQFA
	X8pcV
X-Gm-Gg: AZuq6aKrsnpeyHnniEBaGXcfbGKsQ6Nk7QfTpT+RVHpwDVhjgBUfL+6jYLzU7Z+y0bF
	1e/Em1kV3LSI344rw0F9NE/I+mmOLSQgJbainVdhjJJ1WJOQ/ZkhMgl40iI/y70+PTCihvo+T53
	nD3KhIFiJI+Kl0OoUwmCNdmbpltGMi8amdxrLnvZOgRNtxDM2fe5JYkaTM21SCNt6vhx0tLFL3t
	A7mrXUcQHm6siCOLoDN61nwPlZs2/Lj0XF4atzj7O8/DihsyDAmqCJ6pDz7DHsjV1n+KdBase7n
	BDe0QOtpbzGymXlUVVhQQN+f0RaaMSgViPJRVsvg/y/dBjHMeSVzDoRpkkWhTpOGWWcVNYGW/4i
	xYwyE8jsHfr3dsC7LD0uNjNu6vU7Wtn05Yjf082gQkl8MMNxv1mNzaWi4mrmpWZmr46qKpGhRxO
	5Ocm9IED5qvXCEjDkyE1qk/kBdzK5G6xk6uWxLeigpsw==
X-Received: by 2002:a05:600c:3b13:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-482db45f1ccmr140161675e9.11.1770028075408;
        Mon, 02 Feb 2026 02:27:55 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm42981333f8f.7.2026.02.02.02.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:27:55 -0800 (PST)
Message-ID: <87aaabdd-1c21-4b18-9650-a3b4c2618538@freebox.fr>
Date: Mon, 2 Feb 2026 11:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 0/3] wifi: initial UHR support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260130154259.265130-5-johannes@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260130154259.265130-5-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31450-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AF977CAF6F
X-Rspamd-Action: no action

On 30/01/2026 16:21, Johannes Berg wrote:
> Should probably just not be trying to do this while I have a fever...
>
> Maybe this one's going to be the last respin despite that.
>
> FWIW, I'm also working on further NPCA support, both rudimentary AP
> (just configuration of the NPCA chandef) and non-AP side. But I'm
> not going to post _that_ until I get through my fever ;-)
>
> johannes
>
Look good to me, but I don't feel I have the sufficient knowledge to 
either the standard or mac80211 to warrant a Reviewed-by or an Ack-by.

Pablo


