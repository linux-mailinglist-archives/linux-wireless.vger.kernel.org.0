Return-Path: <linux-wireless+bounces-33966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GhwOPcjxWkU7QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:17:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844333516C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE53305BBA5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FF3F788E;
	Thu, 26 Mar 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR6GLlbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A43909AC
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527400; cv=pass; b=q0BzUlBRSxUMwdNf3anYZbBlN7uOntLsV/ylsZk01x0PQKYmWKfJA3JBbdTgeuCRJDhD1OYsz2lqLgTn8maGeBl97v0Jo02FdHOBX3kHnTzGQHaEm2cSBlOj9boCLeuarAnXNtJrEUuh4u1BKu7hPEGHBc275AY3xM+NEaXbK20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527400; c=relaxed/simple;
	bh=PYCc/ATpnym011AgK+0P6Tb2mKVBgUCH0DqbilqhAa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daXdwVq05u+a/RDU+SFBbYg8bYNNQ5lBow2nkih9ikjvlG4ZlrrgUKdwd2EEl31oqgbLIRjPEDY6+u1ij7U9wtBWjNrgWjP+prirKKHHP43dR8xbPkffZd80uC0BpNxZIWj/dOffjoKwWwjCsTeL+7pFLY+WbFmQcTE52BKTPXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR6GLlbV; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-41576c5c01cso601519fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774527398; cv=none;
        d=google.com; s=arc-20240605;
        b=A4tBGFe++4hu+haBl91m9coZtgVsCjYMHaA6vYreAMmN4U4M5U3d/5s+9JjTLsHoC4
         s35vYO0ip7uN1y19+sRuuUT34n4AvaPAzN1PhaDO+gaImpiBvHyADD5XC2zt+3jVmmuL
         Fb0/2F+R1ESHIStqCdxNRqpcwYJB1Xi1VoHOeCmi0IQ4MFcf3FvCYHK5YYrxNg4iAokI
         EwThgmbqh65jmv/YwfGXC9FSED300qTON2lxGETBmbczXQL/lJfhH9y0r75VwRyDrzBn
         57YhYhg3kZckH6yuuiEYsr3M++0pFyunR9dH25x1QoMVgLIlq7Fq2YXi90yWDb6d2n8O
         +gWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        fh=ypBLbd90PqeIY2wLp1PSuC9Q+ffdvd6YSMiD5WPh4H8=;
        b=RSiBY1HDykHFYOCNYAKgOVeY4He0RuyEWlM+PILvKIcE3OqRBap8SbWu5MqcFhjarS
         U7tvxpyrUblDAhlHK9quPBadTFoMi9vLC0gm+tb/2oXxuXDj/pRP7m/eAMS6fDBeV57L
         3BSKZLdH//986Mo0UjYvaudpU0kDgn83wN9ZqPVkAcFQ8XIHRe0sgxtMoWGe1P09x6xb
         kOuaewMvGXeEjTFBHdFxMBZQiWjUoJRLpq8Iq0xWXRu3vFBDTzkm7w+yQTVTZh76Fw9c
         4ciYvcHMBTfe3vH0gaTJHm/mu1DNShKvxLA3jrYBzJkZrSm7x0HQLPxImnozYPL6xgK5
         mKZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527398; x=1775132198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        b=KR6GLlbViajL5EuvlpszLjw6tLDn9VLkSDqyHxqLhNRTY71sO4f1elKua5DyYn9utT
         hB3NhI71bKJ1cxIb7yvBlEaZ4N/4QhS4evitpH13MD/Goe5RmTxVF4Bdlnt96GtBYsnr
         J6IutPJaU/J+QDli6YYw1TpNpWNHT7stygevnIzlLwJ0/IjsS9gxhEn0r/LXOeUmhafo
         XTLOsRw04qOWV6rSrGiP/7LoeFZ/hCHhIK2OzJ/gqZ+MIIAUgs59np33etMzSmZRwyjQ
         LjEgVxlQU7ESHErj0z8nehgJLN2HRU17F71UypGnA6pa/p+1tgnnpPRnEAp2WP+X5gb9
         A6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527398; x=1775132198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        b=RC4WrJDI8etfRMfSjIM3YtEDvKLySZgvVlBXmD9x1rfeTSR/dG8IA6nTxdNKPgglIn
         G7gjG8qu4JShMgg8TxQnYXSBpuq9s+btGTFmiJIW6mXUT7E1iuQQLcAZv6kEXGZTVUCZ
         oueyAlY97unzn08K4sHhEVqg/9WRzQXbJl/fuz9LeV3sHdSXm7Hdi9xmst3AkV6tBrvv
         br8Gxu7VWPYvRF1tbomBjk1RU45UcFDftNkoBIlL5vDTL9PUXJoUqFlVOe5ZI9NBGtZI
         bAQujzbl3n2hQVOfBV6/hgXS0qRwyiNb8vDmgnUrpNmZ9FYNzCPFzYEj944jascVPwDs
         9FXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7RDPqv+4a2IMXI8WALdskGUjSui7P1NfXz9t+VrlPuiXf9/7RoNSEvQSq/GTjDzhm6rGkzNxzgFyzhmvhGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ULaVLEPon8hVbVuTC7twpMgoKr+ImTBPAHNlLG9hNUq2ZiFu
	tGtJH8Zn+hlyT7h8hdQ8I6n96Xu9FQ5pcATEdor85SRXfTvD+AqYZpoGOfrDtS4AHYf9SyRX0c6
	uKHM4Eo/+knorJs4apn3rR+7JnJWhbTtqFJDNKVU=
X-Gm-Gg: ATEYQzwJDXUk/8lbLhciDD//FOIqUQMiTrD6QI4LlnNJX2SkqJ6J7BwhZlMb0qUztRR
	m/ljR+20naK1i5GsVMVtHvuJciKV4MziHileaBzTYIYT8d2/tojXSQc9ZeP9H20Rr2cFg+Etw69
	d3r6m5gh19RdqAR7uQ3TqN6ulwD6J6s0K8sUL/aZ+cRkk6RS1Yqyxmx3tPJWlqN/hg0+KjLCX2Y
	RdvHb7rABWOKIqn7b8DVIi3PGZFA8q4FtrH7w7ZcNRLcgF08fdJGGIF/N/0rI+n2tiW0a0AfKKM
	v7W4YX4=
X-Received: by 2002:a05:6870:458c:b0:417:4c0a:1ff4 with SMTP id
 586e51a60fabf-41ca6d15f6amr4017036fac.10.1774527398240; Thu, 26 Mar 2026
 05:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
 <20260326013719.1662-1-fjhhz1997@gmail.com>
In-Reply-To: <20260326013719.1662-1-fjhhz1997@gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Thu, 26 Mar 2026 13:16:27 +0100
X-Gm-Features: AQROBzC5df8Kx53ffXvlh9wIgTM-6dOUFOdkLJ4dqCoP6Ot6c-qSsWpAuHW8GuQ
Message-ID: <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access
 when deleting the virtual interface
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33966-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliexpress.com:url]
X-Rspamd-Queue-Id: 6844333516C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, in response to the three points:

1. VMware

2. This is the output of the lsusb command: "Bus 004 Device 002: ID
0e8d:7961 MediaTek Inc. Wireless_Device". The adapter is very cheap,
it=E2=80=99s a Fenvi AX1800 (MT7921U), this one:
https://s.click.aliexpress.com/e/_okxhxNl . But as I said, the bug
also happens when using the Alfa AWUS036AXML (MT7921AUN).

3. I=E2=80=99m not sure about this right now. I=E2=80=99d say everything di=
es. I=E2=80=99ll
test that to see if SSH is still available (I don=E2=80=99t think so, but I=
=E2=80=99m
not 100% sure at the moment).

Give me a few days. I=E2=80=99ll test this again over the weekend. I=E2=80=
=99ll also
run a test on bare metal (not in a VM). That said, like me, many
people use VMs for pentesting. So even if it works on bare metal,
which I=E2=80=99ll test this weekend, I think it would still be worth
investigating whether it can be fixed for VMs, since many people,
myself included, use them for work. If it works with other WiFi
adapters, it would be a big drawback if it didn=E2=80=99t work with MediaTe=
k
adapters.

I=E2=80=99ll also reply with a similar message in the thread.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El jue, 26 mar 2026 a las 2:37, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz1997@gma=
il.com>) escribi=C3=B3:
>
> Hi =C3=93scar,
>
> Lucid-Duck spent some time trying to reproduce your crash and wasn't able
> to trigger it. Here's a summary of what was tested:
>
> - Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
>   patch applied
> - MT7921AU USB adapter, passthrough to VM
> - Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuous
>   deauth via aireplay-ng
> - Also tested on bare metal Fedora 6.19.8 with the same adapter
>
> All tests were stable -- no crash, no dmesg errors, load stayed low. The
> deauth frames were confirmed sending for 30+ seconds under the v2 patch
> without issues.
>
> The one variable that couldn't be matched was the VM hypervisor.
> Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
> level (xHCI). If you're using VirtualBox or VMware, the USB passthrough
> path is quite different (userspace proxy), and that could potentially
> explain a total VM freeze that isn't a kernel panic.
>
> Could you please reply to Lucid-Duck directly on GitHub with the
> following information? Here's the link:
> https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4129198757
>
> 1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc.)
> 2. Your exact USB adapter model and ID? (0e8d:7961 covers several
>    MT7921 variants)
> 3. If possible, try SSHing into the VM from the host while the display
>    is frozen -- if SSH still works, the issue is at the hypervisor/displa=
y
>    level, not the kernel.
>
> Thanks,
> =E5=82=85=E7=BB=A7=E6=99=97

