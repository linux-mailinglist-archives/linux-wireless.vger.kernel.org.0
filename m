Return-Path: <linux-wireless+bounces-36646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH+YF1gODGqJVAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:16:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A34578D0B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6449302ED78
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8C3BED46;
	Tue, 19 May 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr2z5Nof"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6C3C0A0C
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174912; cv=none; b=HYpJdbH9V5o9u5O+IpXNASRMDVQM2G/pPkjqmldXQeFo/PSZ+HZqcChupCy1LIDtRptzhER+s8YbADB5yL3LrCyXR3xlYWn6BoHGuy/WLPh5ABHgbvEMvIkHFFIjPW7SinDogtqF8hOypu7grSS8g2G08H3ptkjrRiCLjL2up6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174912; c=relaxed/simple;
	bh=e37XJBBu2ZOJo9b97UuDxrWTjD1hFvbR54jEfbTYFVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp0eLwzJGpBQy9KVVnuxnmhb24eSHctBHCQhKx3wubnBAUTfy0Gi4APlo9CDQHjTbsMm0fA8FKuaDOxU/TI6b/9nfcObxaoq7U43+g+xoW25n/mZ83fziv24/LzHqUMt44EExwq87f0sV7ztqpA06s4O53K/OzmEW6bIXJG4tag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr2z5Nof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D207CC4AF09
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779174911;
	bh=e37XJBBu2ZOJo9b97UuDxrWTjD1hFvbR54jEfbTYFVg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=cr2z5Nofp+ku5w4GOvFZx/3HFxB32ye8O7ajX3IMe15DiDvxw9Hf7YeIt0seU7i/p
	 bSSP0sN6PTLEBV7aGvmVK3kBuQq1kJWmSliwock6Uz2T1agijsGtMnRBoarm2o0d02
	 g8JNnYxRP5fuIte06t5wMmbgWa89YzBMm0VfrxNRbWGZnvY5Cl1LW9eldSz4WjGBx4
	 3iru6QI3LXh/wdSK7zlXN/6EbB5SlZJA23UbU0Pi73U5a4/UB98cyhOlcoSdkUuVyp
	 nOLXfyMu6T0d1zAcOfV95XBLMtLTXdiQO4GJm9mYnV/FDei0oZmbkI6D035HCHp0PC
	 CSRyU7kgFnADg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39556b00a85so29489251fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 00:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9vXApKM0BIv5WAIQiA5TjGQrCubK0q2WClWcj+tCWpioHvOURqqVFfg0rOU7sul2mQt37VcWQu7H8mkszWoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8PJEzmbBGBHWllG8L0FklO6mxCpMSTgEDWghGUoT9jSFVrA1
	3i8GoU5DELaMgWXroQFX09v0JEivMj4hpH8mKMqprWkniTTtD6EqlHAgxBPceHojWK1OvtevRUj
	UBuqcQ7xblfEcFyknS+TS6VeoUQYgLws=
X-Received: by 2002:a2e:8812:0:b0:38e:83a6:d4c with SMTP id
 38308e7fff4ca-39561c3628dmr37868651fa.7.1779174910180; Tue, 19 May 2026
 00:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1886262646.6291779.1777997531793.ref@mail.yahoo.com>
 <1886262646.6291779.1777997531793@mail.yahoo.com> <dc91809a60874f87a5e9d67f0c4696e5@badraproject.com>
In-Reply-To: <dc91809a60874f87a5e9d67f0c4696e5@badraproject.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 19 May 2026 15:14:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mCBP8KiMF3nRTix_zYDhsb_o4KNj-7-enB0+ULvh0_A@mail.gmail.com>
X-Gm-Features: AVHnY4LZNdH-hLJyed2ewHsAuE9f5bxzyNY9_0GWdZxDjJDt6NAxN0w5acgcI6A
Message-ID: <CAGb2v66mCBP8KiMF3nRTix_zYDhsb_o4KNj-7-enB0+ULvh0_A@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: add regulatory rules for Iraq (IQ)
To: Mohammed.Al-Obaidi@badraproject.com, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	mnewiraq2000@gmail.com, mnew_iraq@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,yahoo.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-36646-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,cmc.iq:url];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_WP_URI(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Queue-Id: B7A34578D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, May 16, 2026 at 3:43=E2=80=AFPM <Mohammed.Al-Obaidi@badraproject.co=
m> wrote:
>
> Kind reminder, any update on the subject?

Please send the patch directly to the mailing list, not as an attachment.
Otherwise there is no way to review the patch on the mailing list.

`git send-email` should do that for you.

About the commit message:

The section "Notes on the encoding chosen below" is really not needed,
unless something is not a direct translation from text to the standard
rules for wireless-regdb, or if other materials were referenced.

So talking about "Indoor" encoded as "NO-OUTDOOR" is redundant. Mentioning
DFS is also not needed, since it is obvious from the table you provided.
AUTO-BW for 5150-5350 MHz is also quite standard.

Things that are worth mentioning:

1. TPC requirements in the regulation and what was done to make the rule
   compliant (as we don't support TPC)
2. Choice between indoor-only and indoor+outdoor rules when both exist
   but with different requirements (database and Linux support only one
   rule per band)
3. unique 5.8 GHz figure as you gave


Also:

* 5725-5875 MHz uses the higher of the two stated EIRP figures
  (4000 mW for 20 MHz channels) since wireless-regdb expresses a
  per-band ceiling, not a per-channel-width ceiling.

This is slightly wrong. wireless-regdb expresses a ceiling that makes
devices compliant with all regulations in all configurations. So if
there is a power spectral density that allows the maximum EIRP at
a wider channel, but a reduced EIRP at 20 MHz, we will use the reduced
number.

As for 10 MHz, I don't think it is supported, so we don't really consider
that case. I could be wrong though.

Johannes, could you shed some light on 10 MHz channel width support?


Thanks
ChenYu

> Mohammed
>
> From: Mohammed Abdalla [mailto:mnew_iraq@yahoo.com]
> Sent: Tuesday, May 5, 2026 7:12 PM
> To: wireless-regdb@lists.infradead.org; linux-wireless@vger.kernel.org
> Cc: Mohammed Abdullah Ali Al-Obaidi <Mohammed.Al-Obaidi@badraproject.com>
> Subject: [PATCH] wireless-regdb: add regulatory rules for Iraq (IQ)
>
> ## 1. Why this patch exists
>
> Iraq is currently absent from `wireless-regdb/db.txt`. As a
> consequence, every OpenWrt and Linux device set to `country=3DIQ`
> falls back to the world domain (`00`), which marks most of the
> 5 GHz spectrum as `no IR` and limits 2.4 GHz EIRP to 20 dBm. A
> public OpenWrt forum thread on the Archer AX23 in Iraq concluded
> with the maintainers' standard answer:
>
> > *"IQ is the correct code for the place; once an engineer shares
> > the local radio laws with regdb maintainers it will be added."*
>
> This patch is that contribution.
>
> ## 2. The primary source
>
> The Iraqi Communications and Media Commission (CMC), the national
> regulator, has issued a numerical regulation specifically governing
> unlicensed Wi-Fi, SRD, and UWB devices:
>
> - **Title:** Regulation on short-range radio communication devices
>   (SRD) and devices using ultra-broadband (UWB) technology
> - **Issuer:** Republic of Iraq, CMC, Telecommunications Regulatory
>   Department, International Relations Section
> - **Decree:** Council of Commissioners decision No. 122/q-2025
> - **In force from:** 2025-09-22
> - **Edition:** First edition, 2025; 26 pages
> - **Direct PDF:**
>   <https://cmc.iq/wp-content/uploads/2025/09/Regulation-on-short-range-ra=
dio-communication-devices-SRD-and-devices-using-ultra-broadband-UWB-technol=
ogy.pdf>
>
> Article 4-1-13 of that regulation, titled "Wireless Access Systems
> (WAS)", contains a full numerical table for every Wi-Fi band. This
> patch reproduces that table directly. Nothing in the proposed
> `country IQ:` block is inferred or extrapolated.
>
> ## 3. The Article 4-1-13 table, verbatim
>
> | Band | Use | Max EIRP | Required mitigations | Cited standard |
> |---|---|---|---|---|
> | 2400 =E2=80=93 2483.5 MHz | Indoor and outdoor | 100 mW | LBT and DAA |=
 EN 300 328, ERC/REC 70-03 |
> | 5150 =E2=80=93 5250 MHz | Indoor | 200 mW | =E2=80=94 | EN 301 893, ITU=
 Res. 229 (Rev. WRC-19) |
> | 5250 =E2=80=93 5350 MHz | Indoor | 200 mW | =E2=80=94 (DFS implied via =
EN 301 893) | EN 301 893 |
> | 5470 =E2=80=93 5725 MHz | Indoor | 1000 mW | DFS and TPC (stated explic=
itly) | EN 301 893 |
> | 5725 =E2=80=93 5875 MHz | Indoor and outdoor | 2000 mW (10 MHz ch) / 40=
00 mW (20 MHz ch) | =E2=80=94 | EN 302 502 |
> | 5945 =E2=80=93 6425 MHz | Indoor | 200 mW | =E2=80=94 | EN 303 687, ECC=
 Report 75 |
> | 57000 =E2=80=93 66000 MHz | Indoor | 10000 mW | LBT and DAA | EN 302 56=
7 |
>
> The proposed `country IQ:` block encodes this table line for line.
>
> ## 4. The Iraqi regulation also defines its own glossary terms
>
> For the avoidance of doubt, the regulation's Annex A explicitly
> defines `Wi-Fi` as *"802.11 Local Area Networking in 2.4 and 5 GHz
> ISM bands"*. So when the maintainers ask whether this regulation
> in fact covers Wi-Fi, the answer from the regulator is yes,
> in writing, in the regulation itself.
>
> The same annex defines DFS, TPC, LBT, DAA, EIRP and AFA in the
> exact wireless-regdb sense.
>
> ## 5. Encoding choices and where they came from
>
> A few wireless-regdb encoding details require explanation, because
> they are interpretations of the regulation's wording rather than
> direct copies of numerical limits:
>
> 1. **NO-OUTDOOR on 5150=E2=80=935725 MHz.** The regulation labels these
>    rows simply as "Indoor". The wireless-regdb idiom for that is
>    the `NO-OUTDOOR` flag.
>
> 2. **No NO-OUTDOOR on 5725=E2=80=935875 MHz.** The regulation explicitly
>    labels this row "Indoor and outdoor".
>
> 3. **DFS on 5250=E2=80=935350 MHz.** The regulation's own column for this
>    row is empty for mitigations, but the cited standard
>    (EN 301 893) requires DFS in this sub-band, and the corresponding
>    row for 5470=E2=80=935725 in the same table does state DFS+TPC. Readin=
g
>    the regulation as a whole, DFS for 5250=E2=80=935350 is required by th=
e
>    incorporated standard.
>
> 4. **Single EIRP figure for 5725=E2=80=935875 MHz.** The regulation gives
>    two figures (2000 mW for 10 MHz channels, 4000 mW for 20 MHz
>    channels). The wireless-regdb format expresses one ceiling per
>    band; the 4000 mW figure is used because it is the higher value
>    that the regulation explicitly permits.
>
> 5. **6 GHz channel width set to 80 MHz.** The regulation does not
>    explicitly distinguish standard-power from low-power indoor
>    (LPI) operation, nor does it mention AFC. The conservative
>    choice is to encode the 6 GHz block at 80 MHz (the widest
>    non-AFC option in current practice) and leave a follow-up patch
>    for a wider channelisation once CMC clarifies AFC requirements.
>
> 6. **AUTO-BW on the 5 GHz RLAN rows.** Standard practice for
>    EN 301 893=E2=80=93compliant entries; no AUTO-BW is set on the 6 GHz
>    row pending the AFC question above.
>
> If the maintainers prefer a different encoding for any of these
> six points, please push back; the underlying regulatory text is
> clear and any of these can be re-encoded without changing what is
> actually permitted under Iraqi law.
>
> ## 6. The 5.8 GHz figure looks unusually high =E2=80=94 it is intentional
>
> `(5725 - 5875 @ 80), (4000 mW)` with no NO-OUTDOOR is not a typo.
> This is what Iraq's own regulation states for this sub-band, citing
> EN 302 502. It is the BFWA value, not the Non-Specific SRD value.
> This choice puts Iraq at the high end of the regional spectrum
> policy for the 5.8 GHz band. It is included verbatim because the
> purpose of wireless-regdb is to reflect what each country's
> regulator actually permits.
>
> ## 7. What is not in the patch
>
> - **5850=E2=80=935925 MHz ITS / V2X bands.** Article 4-1-8 of the same
>   regulation covers ITS at 5855=E2=80=935925 MHz with 2 W EIRP, but this
>   is a non-Wi-Fi RLAN application and is outside the scope of
>   what wireless-regdb usually encodes for `country` blocks.
>
> - **All non-Wi-Fi SRD bands.** The regulation also covers RFID,
>   inductive applications, alarms, model control, automotive radar,
>   level probing radar, hearing aids, active medical implants, and
>   the full UWB regime (Articles 4-2-1 through 4-2-6). None of these
>   is a wireless-regdb concern.
>
> - **6 GHz beyond 6425 MHz.** The Iraqi regulation only addresses
>   5945=E2=80=936425 MHz at 6 GHz; the 6425=E2=80=937125 MHz upper portion=
 is not
>   covered, and the patch therefore does not include it.
>
> ## 8. Submission checklist
>
> - [ ] Verify the patch applies cleanly against the current
>       `wireless-regdb` master; the IQ block must be inserted in
>       alphabetical order, between `IN` and `IR`.
> - [ ] Build `regulatory.db` locally and confirm with
>       `regdbdump regulatory.db | grep -A8 'country IQ'` that the
>       output matches the proposed table exactly.
> - [ ] Post the cover letter and patch on the OpenWrt forum thread
>       (231380) for community review by Iraqi engineers before
>       sending upstream.
> - [ ] Send to `linux-wireless@vger.kernel.org` with cc to
>       `wireless-regdb@lists.infradead.org`.
>
> ## 9. A note on responsibility
>
> The numerical content of this patch is taken verbatim from a public
> Iraqi government regulation. The encoding choices listed in =C2=A75 are
> the patch author's, and they are reversible.
>
> Author: Mohammed Abdullah Ali Al-Obaidi (mnew_iraq@yahoo.com),
> OpenWrt forum handle `mnewiraq`. Any objection to the encoding
> choices should be raised to that author or in the upstream review
> thread, not to the CMC.
>
>
> CONFIDENTIALITY. This communication is intended exclusively for use by th=
e addressee and may contain confidential and/or privileged information. If =
you receive this communication unintentionally please inform the sender by =
reply immediately and permanently delete it from your system; you should no=
t copy this communication or disclose its contents to anyone.

