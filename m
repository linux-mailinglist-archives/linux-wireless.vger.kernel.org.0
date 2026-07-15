Return-Path: <linux-wireless+bounces-39146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czBmE5KGV2oUWQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:09:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43975E7CC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b="EJRNuAX/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39146-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39146-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980B931BC8C7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FB42046E;
	Wed, 15 Jul 2026 13:02:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368D420462
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 13:02:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120559; cv=none; b=mzjtn0ZRmUx2vr2gn60/Jn/Y4fxGAar/vh524mEuoIm9QpSJ3QKyZThe3QoV1LBTZ9G15lHBEhNrumkz9OgOznkSeEGyTVKQjumT5ySLGbquIR+Egv+KhZU54YaC2eT5DkAOxcAfUCyFTjZkOA8HRj+JdlLxkxoZaga5pzC4u5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120559; c=relaxed/simple;
	bh=Z0d1G8GrvD2+2VzGAcV1LS9mEP1NUU/Brga8ddE23aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMqewxhI7SVjJgWFvlXARqrMWyaeuAVOf3TFQ9fGWiDVeTF/u+lGcUiHPTOxOgk+fLRVAzTsJOUkPK2RmHPUfPv/j2T2fjEO4LmLJj/+cQdJvps5IAVXxj7mtMoyZ6Mrb+Of001DV92IUpp1Ebo8kbrEZK5PCQ7frfqVav1Y9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJRNuAX/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A431F00A3A
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120557;
	bh=2GU5mNOJ6dY84gWEImx+k/RkgTiLhJWQYHqbIZUDsCo=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc;
	b=EJRNuAX/TvysSyBxgLj9fTtx3Xz82aY4a2l67hNXJdikqzn5cvggBgMaxV7M8sdka
	 wpfMzJLAECeuPrU3wagRQ8G6qbX+DNibI5QZ0nzqI/eL8Fup8eMQlcYoWtmO5UEGa6
	 2OtNey6u+03FRi6Yw7viAhbqXLDIJZ48jJvn6iBLu8Pydtq9njHVLCAlcFx/iNzYJF
	 al1c/8Jhzih7wiYL3SuIP5DBQqLVxiWxDxD58VXqgAZH3rRM/huHGRxSh56+pDJJYs
	 vyU9JxR284xTxbtZ47+vCflVYcHUQnwyrAmctzhMPgS+cGaOphweeTUYdBfLpDDHWd
	 vU+P2/XTq7rvQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e9d8f3289so29460987b3.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:02:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RosdGkYRe6LnMEy2WicKt8jiYYnCRafsoNa6KBvhDWnUr4z0WAKKWtdVaJ1yEprZz90A/aaLRXWEp6hO3diDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GCxsHo/r41RSrTxhnQVqC+Gu//EJ305HGVvR4hglxv4SNeCz
	lfoCb63yHPyh8pDWE12w5wUplKejg5RqiJtX/ZC5BqrUZgPgsfpyQ+8toHA47n3ckNWln8R/y4B
	6NRzKZgfXEGAUgiGXN/0g0wgFrzHJUVU=
X-Received: by 2002:a05:690c:e298:20b0:81e:d792:a019 with SMTP id
 00721157ae682-81ed792a286mr5323857b3.6.1784120556647; Wed, 15 Jul 2026
 06:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707044618.2476204-1-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260707044618.2476204-1-lachlan.hodges@morsemicro.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 15 Jul 2026 09:02:24 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7sOz2Uzt0NjK1HJgu0RCgHcipESYe1ksoz5T-tfaRWRQ@mail.gmail.com>
X-Gm-Features: AUfX_mzrnba4QNsYMuyxLUbL0qxzweafuSo019AecYFN_v9Yv1FeCKtI08euFWE
Message-ID: <CA+5PVA7sOz2Uzt0NjK1HJgu0RCgHcipESYe1ksoz5T-tfaRWRQ@mail.gmail.com>
Subject: Re: [PATCH] morsemicro: add firmware for mm8108 support
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-39146-lists,linux-wireless=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jwboyer@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:linux-firmware@kernel.org,m:linux-wireless@vger.kernel.org,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jwboyer@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D43975E7CC
X-Rspamd-Action: no action

On Tue, Jul 7, 2026 at 12:47=E2=80=AFAM Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add firmware and board files for the mm8108 chipset to be used
> with the mm81x Wi-Fi driver.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
>  LICENSES/LICENCE.morsemicro                 | 125 ++++++++++++++++++++

This is problematic and we can't accept this firmware under this
license.  Please see LICENSE-CRITERIA.md in the repo.  More comments
below.

josh

>  WHENCE                                      |  14 +++
>  morsemicro/mm81x/v56/bcf_aw_hm677.bin       | Bin 0 -> 2124 bytes
>  morsemicro/mm81x/v56/bcf_mm8108_mf15457.bin | Bin 0 -> 2124 bytes
>  morsemicro/mm81x/v56/mm8108.bin             | Bin 0 -> 479624 bytes
>  5 files changed, 139 insertions(+)
>  create mode 100644 LICENSES/LICENCE.morsemicro
>  create mode 100644 morsemicro/mm81x/v56/bcf_aw_hm677.bin
>  create mode 100644 morsemicro/mm81x/v56/bcf_mm8108_mf15457.bin
>  create mode 100644 morsemicro/mm81x/v56/mm8108.bin
>
> diff --git a/LICENSES/LICENCE.morsemicro b/LICENSES/LICENCE.morsemicro
> new file mode 100644
> index 000000000000..adf90750d1af
> --- /dev/null
> +++ b/LICENSES/LICENCE.morsemicro
> @@ -0,0 +1,125 @@
> +                                  MORSE MICRO
> +                     BINARY DISTRIBUTION LICENSE AGREEMENT
> +
> +1. Parties.
> +This Software License Agreement (SLA) is between Morse Micro Pty. Ltd. a=
nd the
> +user of the Software set forth (=E2=80=9Cyou=E2=80=9D, =E2=80=9Cuser=E2=
=80=9D, =E2=80=9Ccustomer=E2=80=9D), and is effective as
> +of the date of first access or download of the software by you. Morse Mi=
cro is
> +licensing this software to you free of charge upon the condition that yo=
u
> +accept all the terms of this SLA and only use this Software in conjuncti=
on with
> +Morse Micro products. ANY USE, REPRODUCTION, OR DISTRIBUTION OF THE SOFT=
WARE
> +CONSTITUTES YOUR ACCEPTANCE OF THIS AGREEMENT.
> +
> +2. Definitions.
> +"Software" means any binary or source code that you have received from M=
orse
> +Micro or its authorized licensees and/or those portions of such software

A random user downloading the firmware from the linux-firmware
repository will not have received it from Morse Micro directly, nor is
the linux-firmware repo an authorized licensee.

> +produced by Program=E2=80=99s code within the Software, as well as any o=
ther machine
> +readable materials (including, but not limited to, libraries, source fil=
es,
> +header files, and data files), any updates or error corrections provided=
 by
> +Morse Micro, and any user manuals, programming guides and other document=
ation
> +provided to you by Morse Micro under this SLA.
> +
> +3. License and Restrictions.
> +Morse Micro grants you a non-exclusive, non-transferable, limited licens=
e
> +without license fees to:
> +
> +    a. use the software solely with a hardware product that includes one=
 of the
> +    Morse Micro Wi-Fi HaLow chips, including
> +    wireless modules or evaluation kits;
> +
> +    b. to reproduce and distribute the Software complete, unmodified, an=
d as
> +    provided by Morse Micro, solely for use with a hardware product that
> +    includes one of the Morse Micro Wi-Fi HaLow chips, including wireles=
s
> +    modules or evaluation kits.

The distribution restriction here prohibits normal distribution of the
firmware for basically every Linux distributor, where they would
normally include all firmware files on installation media regardless
of the hardware the OS is being installed on.  It also prohibits
normal distribution via git repos, because we have no control on who
downloads the firmware and for what purpose.

> +4. Reservation of Rights.
> +You should distribute Software with a copy of this SLA. Software is
> +copyrighted. Title to Software and all associated intellectual property =
rights
> +is retained by Morse Micro. Except as expressly provided herein, no lice=
nse or
> +right, express or implied, is hereby conveyed or granted to you by Morse=
 Micro.
> +You must retain all copyright notices on all Software, derivative works =
and
> +documentation. The intellectual property and proprietary rights of whate=
ver
> +nature in the Software and derivative works are and will remain the excl=
usive
> +property of Morse Micro or its suppliers. Nothing in this Agreement shou=
ld be
> +construed as transferring any aspects of such rights to you or any third=
 party.
> +Morse Micro and its suppliers reserve any and all rights not expressly g=
ranted
> +in this Agreement. You may not sell, assign, sublicense, lease, or other=
wise
> +transfer any part of this license. You must not:
> +
> +    a. use, license, sell or otherwise distribute the Software except as
> +    provided in this SLA;
> +
> +    b. attempt to modify in any way, reverse engineer, decompile or disa=
ssemble
> +    any portion of the Software;
> +
> +    c. use the Software or other material in violation of any applicable=
 law or
> +    regulation, including but not limited to any regulatory agency.
> +
> +5. Ownership.
> +The Software is licensed and not sold.  Title to and ownership of the So=
ftware,
> +including all intellectual property rights thereto, and any portion ther=
eof
> +remain with Morse Micro or its licensors. You hereby covenant that you w=
ill not
> +assert any claim that the Software created by or for Morse Micro infring=
e any
> +intellectual property right owned or controlled by you.
> +
> +6. Termination.
> +This SLA will terminate immediately without notice from Morse Micro if y=
ou fail
> +to comply with any of its provisions, including the export laws provisio=
ns and
> +Section 10 that may govern the export of the Software from certain
> +jurisdictions, including technical data.

This is effectively either unenforceable after including it in the
linux-firmware repo, or prohibitive enough that we can't include it at
all.

> +7. Disclaimer and Limitation of Liability.
> +THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. MORSE MIC=
RO
> +FURTHER DISCLAIMS ALL WARRANTIES, EXPRESS AND IMPLIED, INCLUDING WITHOUT
> +LIMITATION, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PAR=
TICULAR
> +PURPOSE OR NON-INFRINGEMENT. IN NO EVENT SHALL MORSE MICRO BE LIABLE FOR=
 ANY
> +INDIRECT, INCIDENTAL, SPECIAL, PUNITIVE OR CONSEQUENTIAL DAMAGES, OR DAM=
AGES
> +FOR LOSS OF PROFITS, REVENUE, DATA OR DATA USE, INCURRED BY YOU OR ANY T=
HIRD
> +PARTY, WHETHER IN AN ACTION IN CONTRACT OR TORT, EVEN IF MORSE MICRO HAS=
 BEEN
> +ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. THE SOFTWARE IS NOT INTENDED=
 FOR
> +USE IN ENVIRONMENTS OR APPLICATIONS WHERE EXTRAORDINARILY HIGH LEVELS OF
> +QUALITY, RELIABILITY, AND FAILURE TOLERANCE ARE DEMANDED, AND/OR WHERE A
> +MALFUNCTION OR FAILURE COULD LEAD TO SIGNIFICANT HARM TO LIFE, HEALTH,
> +PROPERTY, OR RESULT IN SEVERE SOCIETAL REPERCUSSIONS ("CRITICAL APPLICAT=
IONS").
> +CRITICAL APPLICATIONS ENCOMPASS, BUT ARE NOT LIMITED TO, EQUIPMENT UTILI=
ZED IN
> +NUCLEAR FACILITIES, AVIATION AND SPACE EQUIPMENT, MEDICAL DEVICES, AUTOM=
OTIVE,
> +TRAIN, MARINE, AND OTHER TRANSPORTATION EQUIPMENT, DEVICES INVOLVED IN
> +CONTROLLING COMBUSTION OR EXPLOSIONS, SAFETY DEVICES, ELEVATORS AND ESCA=
LATORS,
> +DEVICES ASSOCIATED WITH ELECTRIC POWER, AND EQUIPMENT USED IN FINANCE-RE=
LATED
> +FIELDS.
> +
> +8. Survival.
> +Sections 4, 5, 6, 7 and 10 will survive termination or expiration of thi=
s SLA.
> +
> +9. Privacy.
> +Some features of the Software, if activated, may transmit a limited amou=
nt of
> +data to Morse Micro (or its service provider) about the status of the sy=
stem
> +before a crash event. Morse Micro does not associate the data with perso=
nally
> +identifiable information.
> +
> +10. Export Laws.
> +YOU UNDERSTAND AND AGREE THAT THE SOFTWARE IS SUBJECT TO ALL APPLICABLE =
EXPORT-
> +RELATED LAWS AND REGULATIONS AND THAT YOU MAY NOT EXPORT, RE-EXPORT OR T=
RANSFER
> +THE SOFTWARE OR ANY DIRECT PRODUCT OF THE SOFTWARE EXCEPT AS PERMITTED U=
NDER
> +THOSE LAWS. WITHOUT LIMITING THE FOREGOING, EXPORT, RE-EXPORT, OR TRANSF=
ER OF
> +THE SOFTWARE TO CUBA, IRAN, NORTH KOREA, SUDAN, AND SYRIA IS PROHIBITED.
> +
> +11. Governing Law.
> +The laws of New South Wales, Australia, govern all matters arising out o=
f or
> +relating to this SLA without giving effect to any conflict of law princi=
ples.
> +If any provision of this SLA is held to be unenforceable, this SLA will =
remain
> +in effect with the provision omitted, unless omission would frustrate th=
e
> +intent of the parties, in which case this Agreement will immediately ter=
minate.
> +
> +12. Entire Agreement.
> +This Agreement constitutes the entire agreement between the parties and
> +supersedes all prior and contemporaneous agreements, proposals or
> +representations, written or oral, concerning its subject matter. No
> +modification, amendment, or waiver of any provision of this Agreement wi=
ll be
> +effective unless in writing and either signed or accepted electronically=
 by the
> +party against whom the modification, amendment or waiver is to be assert=
ed. A
> +waiver of any breach under this Agreement does not constitute a waiver o=
f any
> +other breach or future breach.
> +
> +
> +MORSE MICRO
>

