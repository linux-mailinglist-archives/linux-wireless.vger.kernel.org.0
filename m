Return-Path: <linux-wireless+bounces-34370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMGLKknD02mqlgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 16:29:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B443A40F1
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C8A3011BD9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FF3803EB;
	Mon,  6 Apr 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdGYgMut"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610833806A4
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485738; cv=pass; b=ggkwkRRisr4x06VS8QUrmgeW9iAkd3sab8kexTkOolN5UUCM9pJXtQGdkIRbHHRT6FXGmpakvy1cDk1Spn+ULW071KjcKswOXj2k24S9JJQ4PSfO9wHLKxWflrEQsdHW9hOn2BzdOovI9oKjJcYitMH7ngzJhxsN9UtdaqOyAbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485738; c=relaxed/simple;
	bh=RN4e1YhDSg992awiDit4aQ/vN6UYLHpPa8oGR6pnBZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2KuvoaDp2QdfqbMn/c6ajdEh/wHGdZj3fbOrNFqpjwVl0l81owMsveBW/yb6dmxYWQaaKmHx6ZqiNwBR+HmHQTV8rEZxtzKIASQkX6hiUfvLG3OREbObmpTp48fdCLO5cLH4zGNOUnKCklruO7DktxpU3HC4HGXnIUYXNBONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdGYgMut; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-662efd1bdd4so2338704eaf.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 07:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485736; cv=none;
        d=google.com; s=arc-20240605;
        b=H4CCYS6fAGHmfeQGFCzTVgjxUbWhkV/NhFaiHK70Vps7PG9vEmhWo1F28UPYR+7eKD
         BuMHhkxhC6RjFYhKeUxPHxBBmV8YjvLmrG5jA3YujA4YjWpnlkN6hmssNrKznDxnp77p
         eHJFtz2YErwNSnBKnOAoB0gvtbPJpRfDl+kK2zVxRl/tUcWSzsBFs0x5ETf56V0p4ItD
         iDQDVFfOM4JK3wzXqbkFn1JSqOs4T0LqiHyHUJP5BpiutcwZAxRKXi/mm4Dw3x64fUs8
         ZRQIEV7rNg2uRZcWEgaBbjSDKENUQZDnes2MHNfQxYJ4LH0R++MIiMaCOROy+N044EJ2
         pWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        fh=a59jIrqyBMH9AIpg2bchqY/3lfoPiGuFblbrG8ka25c=;
        b=HGEhj5KftdqpCPpxxUoliAZSX5FliIORcaysSpp5smo/nxHp/yFC6kX6qv+CgRyaQl
         W3kBXXAzJDXZOO6JFf4aXH3AMoHIKabzTWZ0IVMsZx+Z5qwmoJL3W6oeqkAPWGX+wEkl
         lZj9VxF8oXTUtWr1bwgyn+y15zIEqZmwKqkZdaL9nLAaNO+H98zpYneib3U03HiccUjI
         SQS/9Vvjdv/C4ohTZtMKtOMEINvGU5o4UDDK5I70QNCN//MVXFkHLrwBCFeWsAu74D2n
         4ycUtEcfCL/GCMbW2OH8hTvQ4UApP9F6NoZShYerCetymnzxSNg0Y+gf4wgZQbs3pPmL
         4Bbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775485736; x=1776090536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=XdGYgMutbu3g/mpl/gEpiXrNbPBDV+odsxZL3o8drZUGowzubMADFDSWIXewhj8sHn
         TzV7wY9DGFtzPMZBWkSShrjaDJ/PVYjJRAgXbf/EfCPXJE9BWekaR0/4xoS752TmjwHh
         i3gIgkN3ebcqUw53Cnptdd0imdbSFVFGjZiSNPxZQinfJFxklQEYB9zAAcZwTHh5/L2k
         gzATHJysj74KzKE6lXqI5o9ljoAZaRTfhYkfR+fhohpow5uoUp5OpATFZdp5HVzFFtql
         vr9ECIupiSBNvXPvvOcp3MVtHNMgmRv3cYGFhBItr3vzSj1n5CB6kp7fi8hgmPEHW1Kp
         uTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485736; x=1776090536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=fyMqVU6SNJW5cXdzKbHRmcx4uugdvWS4R+ul2TjhpwcshEgp9kkkIcgk0kIOSkEXuR
         THCkEqr3T++WeAR1RYgwx12gyQ0EIhobLmXorkTkXgvjenATgIAK18bQcH866Nq0fsS8
         JygKaGIlWVsnLWlJ6NMg9TGMlkCUfYHKPy4QaffutoMoRAF+CPdOqQDLxvLV8s4GUkC9
         4UNP6GzlJWQ6hfEeGa+koUre/d1uRoj54E41L2G8rHoEK4JDuNUSR/cade/yWOjXrvuf
         F3iRqW4bSpSCim7VSiNn8v3M/pP7KQVX6Gy4/ORzT4EUe9nMbQazCSDzVu8j8EPiIt9b
         0sVg==
X-Forwarded-Encrypted: i=1; AJvYcCVsLi37Mp4cF/PA/C1RhF1jJ8HgKLG/Ycm/HqGRR8VH5punOOTUfcqk9v+MHOYrGcenFIXH/TYasloqDKGOZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTCwtt2bXM0+pZemUoDIK8Xs2dnsRYiry3XXo1EM9aM9t5/A+
	n/5FBpWQdByx70nhpQkextkMPFIZL/4zLAlpyhXkYf8sYDYrag08TxhZ4bZzV9O+r52J4FSbT7X
	WNR1ArVw7HjQuBM1hqnE7T9bVyg+mJUc=
X-Gm-Gg: AeBDievaiI/BpqBGDB/IJsplwda4Os4BAgMDZDeBcR2eK0NgHsR1HGNgb/ZxgbhkBYN
	6bs8RcmOXaBwdYQXh0blN0yjGBFY7zdBlYANexXyHqOM1RNdyAf7cYI9xL1eTPTBN/ne8uQdoEI
	/IR4H8KNZ9psLLquOhW/bSf+wv2yTftCr9cXffghcaRQQJ9PEqLt2LGryMK1XN5S5YWXg1MZzp3
	8lnYObyepIBqemXMEi7ZuF2Z6MgwLfJhDIA9wK/S50hbKMMOpCj20KJjWmOcLlEMXMj9O+5X2tL
	+W9b9VbOd+pM3Itvli/+Wpqzn74Zeq56peb15Q==
X-Received: by 2002:a05:6820:8318:b0:683:6dbf:c6d4 with SMTP id
 006d021491bc7-6836dbfcb7bmr3030718eaf.22.1775485736189; Mon, 06 Apr 2026
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com> <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
In-Reply-To: <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 6 Apr 2026 15:28:42 +0100
X-Gm-Features: AQROBzCw7pv9Q_nhcb2cp7aOThL8Ubn1v1x8P2vXHbgAOxV1wipCcpu51-53q2E
Message-ID: <CA+XhMqxNzaXZRd0co=_gaJsN4zS9L_4OVqhC174EPxA-pzEUgA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev, dev@openvswitch.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34370-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48B443A40F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mathieu yes this is indeed a valid point, will address is for next
time. Cheers

On Mon, 6 Apr 2026 at 15:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 05/04/2026 17:48, David Carlier wrote:
> > Use the typed random integer helpers instead of
> > get_random_bytes() when filling a single integer variable.
> > The helpers return the value directly, require no pointer
> > or size argument, and better express intent.
>
> Regarding the modifications in net/mptcp, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org> # net/mptcp
>
> > Skipped sites writing into __be16 fields (netdevsim) where
> > a direct assignment would trigger sparse endianness warnings.
>
> Note that the AI reviews are mentioning that auth->client_challenge from
> net/ceph/auth_x.c is declared as __le64, and it might then also cause
> sparse warnings:
>
>   https://sashiko.dev/#/patchset/20260405154816.4774-1-devnexen%40gmail.com
>
>
> It looks like they are right:
>
>   $ make C=1 net/ceph/auth_x.o
>   net/ceph/auth_x.c:574:40: warning: incorrect type in assignment (different base types)
>   net/ceph/auth_x.c:574:40:    expected restricted __le64 [usertype] client_challenge
>   net/ceph/auth_x.c:574:40:    got unsigned long long
>
>
> Note that the Netdev CI currently doesn't check sparse warnings:
>
>   https://github.com/linux-netdev/nipa/issues/76
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

