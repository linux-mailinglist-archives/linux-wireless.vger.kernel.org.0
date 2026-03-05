Return-Path: <linux-wireless+bounces-32495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOxBKOL6qGnVzwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 04:39:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598920A9B7
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 04:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60AE3301A9FD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F978244685;
	Thu,  5 Mar 2026 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOSuunSr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1E189B84
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681951; cv=none; b=sP5d7XNP5ghNiLHx3ZlN2ruddz7KAdD6rHpK/EOy9TEJhlkxLJ9hC1V5JOqF1zt/LV7QCbD1aaM1BHkuZM2TwYqc8w5UktNTF8CwRnBbDantQ6dbX1fh7zDm14m6mm+/TTinvAWVQyMhrTuz9gmxb/vMi+hSBV6MEoY67Gm5D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681951; c=relaxed/simple;
	bh=K9Y3P2l9TGZyZ1AWdrty/1zqX7Q+Q62uOy6h7VnEE/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0mfOJLiZ/5a7wZfPJRT3SpXNqQzI2SDeQZ+CtAqie2ZmxYOXi2ZkpLUl93RcgrIuQCs4x6WgkipCc0n8yqOYnDH//AZAB52DwuBQEcm7cSAQXV0J+yRKKw1Vgq8/Ezy9X5GbPt59USpk+VMwkdhKBtFZqmLP7knRiP0SDrJaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOSuunSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD229C19422
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 03:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772681950;
	bh=K9Y3P2l9TGZyZ1AWdrty/1zqX7Q+Q62uOy6h7VnEE/Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=XOSuunSrQToLKMzTk8oqlGVi4chWVVp796WmLHn7TxxcY613+GRcxx8WCusO6a8WT
	 f8Fq5w5jFDc/co1dVk5xGgaGtTNcxnYcdOtZzhKnQUoLA2dcfBmPOQaEP1Jl8udCYu
	 KuIavCSVvs3qPtEsKXKuOjmk7B/nrjQjv0+yKQSpOvo90/q+TWQ57/7Di865mfIKZY
	 R3FEuYtk/iCnV2Y+s8N6zDJO7k7tvyA+AqrOVL82aMqm5hKsRj5f2yhEdFAYySmYvA
	 Jh5F9pgAIznxL3+GmK0ZzFyR0kcMAVZk9vZGbsyU4/pF8OYWtuMm7bcDERYCdIXLoo
	 vV31xnNEGxWUA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-389f9895c81so70813711fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 19:39:10 -0800 (PST)
X-Gm-Message-State: AOJu0YyK7ZYvln0HmpBqZMdcj3jnP96Aj323fC6bsSxj+tHVhC1UgUNO
	BYfaciahfIsz5hGcYEVdIv288aJvj1HsUu3badq5YK0YbMS9ivHNErcqGsZUihBRlSSKGqvCLFf
	iy8cSfl+wAMQw5KY73mejg3iRUjUDdZI=
X-Received: by 2002:a05:651c:385:b0:385:f547:1842 with SMTP id
 38308e7fff4ca-38a2c7caea1mr23560181fa.30.1772681949020; Wed, 04 Mar 2026
 19:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADqxL9qYq_+8dPgXj5i_HjkpTOZwiAawsa90tNbA4Q87ZhCrSA@mail.gmail.com>
In-Reply-To: <CADqxL9qYq_+8dPgXj5i_HjkpTOZwiAawsa90tNbA4Q87ZhCrSA@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 5 Mar 2026 12:38:56 +0900
X-Gmail-Original-Message-ID: <CAGb2v6617V-jLnLrBYEZfSiv-2c8QsN2HMCmQbaXdm9NVwGGEA@mail.gmail.com>
X-Gm-Features: AaiRm53Z72uBQMmccTne6AOUMGnX_LhdT571coFKm9Dnmt3RXvf28VtWQ6Kelmg
Message-ID: <CAGb2v6617V-jLnLrBYEZfSiv-2c8QsN2HMCmQbaXdm9NVwGGEA@mail.gmail.com>
Subject: Re: wireless-regdb: Update IN regulatory domain for lower 6 GHz
 (5925-6425 MHz)
To: Degrader Snehil <degradersnehil@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	wireless-regdb <wireless-regdb@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4598920A9B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32495-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,intel.com:url,dot.gov.in:url]
X-Rspamd-Action: no action

Hi,

On Thu, Mar 5, 2026 at 3:16=E2=80=AFAM Degrader Snehil <degradersnehil@gmai=
l.com> wrote:
>
> Hi,
>
> I would like to request an update to the IN (India) regulatory domain in =
wireless-regdb to add the newly permitted lower 6 GHz band (5925=E2=80=9364=
25 MHz).

Thank you for the information. Would you like to provide a patch?
If not, I can write up a patch and tag you as the reporter.

> The Government of India has officially opened this band for licence-exemp=
t use via Gazette Notification G.S.R. 47(E), dated January 20, 2026, publis=
hed January 21, 2026, issued by the Ministry of Communications under the In=
dian Telegraph Act, 1885 and the Indian Wireless Telegraphy Act, 1933.
>
> Gazette details:
>   Title   : Use of Low Power and Very Low Power Wireless Access System
>             including Radio Local Area Network in Lower 6 GHz Band
>             (Exemption from Licensing Requirement) Rules, 2026
>   File No : 24-04/2025-UBB
>   Gazette : No. 47, CG-DL-E-21012026-269488
>   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communicatio=
ns
>   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f69079=
34d17d0015ab5.pdf
> The Gazette defines two device classes for 5925=E2=80=936425 MHz:
>
>   1. Low power indoor
>      - Max EIRP         : 30 dBm
>      - Max PSD          : 11 dBm/MHz
>      - Max bandwidth    : 320 MHz
>      - Restriction      : Indoor use only (Rule 5)
>
>   2. Very low power outdoor
>      - Max EIRP         : 14 dBm
>      - Max PSD          : 1 dBm/MHz
>      - Max bandwidth    : 320 MHz
>      - Restriction      : None
>
> Additional operational restrictions per Rule 5 of the Gazette:
>   - Band is prohibited on oil platforms
>   - Indoor use prohibited on land vehicles, boats and aircraft below 10,0=
00 ft
>   - Communication with and control of drones/UAS is prohibited
>   - Contention-based protocol is mandatory for all devices (Rule 4)
>
> Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MHz (Ru=
le 6)
>
> Proposed addition to the existing country IN entry in db.txt:
>
>   country IN:
>           (2402 - 2482 @ 40), (30)
>           (5150 - 5250 @ 80), (30)
>           (5250 - 5350 @ 80), (24), DFS
>           (5470 - 5725 @ 160), (24), DFS
>           (5725 - 5875 @ 80), (30)
>           (5925 - 6425 @ 320), (30), NO-OUTDOOR   # low power indoor
>           (5925 - 6425 @ 320), (14)               # very low power outdoo=
r
>
> Note: Since both device classes share the same frequency range but have d=
ifferent EIRP limits and indoor/outdoor restrictions, I have represented th=
em as two separate lines. Please advise if a different encoding is more app=
ropriate.

Unfortunately we currently only support one rule per band. I'm inclined
to add the VLP one so outdoor usage is allowed.

> I have attached the official Gazette notification PDF as supporting evide=
nce.
>
> Intel has also submitted a related update (Intel=C2=AE Wireless Wi-Fi Dri=
vers 24.20.2) for this band for India. I am not certain whether that patch =
covers wireless-regdb (db.txt) or only their iwlwifi driver internals, so I=
 am submitting this request for wireless-regdb independently to ensure the =
authoritative database is updated.

AFAIK Intel manages regulatory requirements in their firmware, so it is
unrelated to the database we maintain.

> Intel's Regulatory Domain Info was found in Release notes of their  Intel=
=C2=AE Wireless Wi-Fi Drivers 24.20.2 available at page 2 of https://downlo=
admirror.intel.com/914148/ReleaseNotes_WiFi_24.20.2.pdf.
> Please let me know if any further information is needed.

The information you provided is very detailed. Thanks!


ChenYu

