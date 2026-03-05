Return-Path: <linux-wireless+bounces-32496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFVUE08HqWlW0QAAu9opvQ
	(envelope-from <linux-wireless+bounces-32496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 05:32:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1620AD35
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 05:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8F00303EDB1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 04:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456B286D5E;
	Thu,  5 Mar 2026 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh0nR9b7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AED26F46E
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685080; cv=none; b=a6cuKWxFbX6dGrdq3S7UgMCY3UZjlEmDlFGysiGT1UeJ9hieepUqaOkkoQV2NlsOZOPMPSD9+hTC8bpMNDo6lbSgdyPwuCSIRtcpgJZeeWeq5Nmhg0Os31D9Fm1NAY5kEYd51OYUy3WKRIxTH91ED2Mx0prjH0d+UM3bh1prlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685080; c=relaxed/simple;
	bh=yNEpdJcmJufkTDu6X7Pw8XWppI3dgWWr9K0+Wv0zTRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1TBN31BE4mHscOeAPdebXgzBgB4oRrWkQHRhHfuu1mAoHG669h3y9PNzfcEDpWsODX2aJJ6uDixfY27Wb3rrz9WsoYj1ikZPSuXqjIqa+ZY2Sjo7iNTcQKndnvzZ1ZU0CJuYPg1z8w8SPFEcE3W27OGeaBhy2JKewIIA01fxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh0nR9b7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4078C19422
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 04:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772685079;
	bh=yNEpdJcmJufkTDu6X7Pw8XWppI3dgWWr9K0+Wv0zTRk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=lh0nR9b7wgEjdaiYR7sIjF3I6GPGAgV+nq6Ee8HJfy0hqPAn+E3kdQnDRIxm6OlU7
	 BPV4aPQY0Zz8MjrEGH7n2akUQY0sNO1nbHqC1rxQc2/3Zuqf6ZNwSsmSXS6QPTF9g7
	 dmi4In2wrpvPdbBb9AD+8U5+apb1pWp88fvzi4CoUrAWgMsi/h9mR3r7+S63u4lUAS
	 /pNF2PTeADCo4PMlQ3Zw0AoptKaPRO18CNiFrY0kPwDgFxUz8Oj+ye52IJOizas9SB
	 hgJAHmUb+g2zHRmoNaH6CxF731L4jhy23WbwktTqiwA8oxGV+/ocMVOeNHBr/c4Liu
	 Wcmt92GS6CnrQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3870778358aso92695331fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 20:31:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa83ByxOuv+ELA8jSK6vYvR8lpJT3Ac/V3Lo9lQfVWxxyg1EIXKI7YrAOPnrdCFA2HmFLHOoO9ClfZ1GsffQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GrQHFs5bmRjSAlBt7pJw03eyUlinw+NHH1pPRiUFFsVUF55i
	fJWDSq3wSic/4EqNS0l/lxeIPrx3gVX0p+mfBFZRQIOEGjCDwk6qEka10ffE3+Q3apILdJnjKuF
	k9wa1kXpiruPeE/fSyKPVfzgWLYdYpo8=
X-Received: by 2002:a2e:6e09:0:b0:385:c21f:37f4 with SMTP id
 38308e7fff4ca-38a2c589ae6mr22495211fa.16.1772685078135; Wed, 04 Mar 2026
 20:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADqxL9qYq_+8dPgXj5i_HjkpTOZwiAawsa90tNbA4Q87ZhCrSA@mail.gmail.com>
 <CAGb2v6617V-jLnLrBYEZfSiv-2c8QsN2HMCmQbaXdm9NVwGGEA@mail.gmail.com> <19cbc39a90e.1cd9982953056.6486968654066866605@nic.gov.in>
In-Reply-To: <19cbc39a90e.1cd9982953056.6486968654066866605@nic.gov.in>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 5 Mar 2026 13:31:05 +0900
X-Gmail-Original-Message-ID: <CAGb2v6406826bWiKEQ0jf0TSPL9xtNx+i=_YCRJNnUjUftF0_w@mail.gmail.com>
X-Gm-Features: AaiRm50lnl5hk4qTMp7ARUwZ_DzyD4Qnd_nNciZJbW4lAGV4zvXGd5mJPPzYMio
Message-ID: <CAGb2v6406826bWiKEQ0jf0TSPL9xtNx+i=_YCRJNnUjUftF0_w@mail.gmail.com>
Subject: Re: wireless-regdb: Update IN regulatory domain for lower 6 GHz
 (5925-6425 MHz)
To: Gaurav Kansal <gaurav.kansal@nic.gov.in>
Cc: Degrader Snehil <degradersnehil@gmail.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	wireless-regdb <wireless-regdb@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4AD1620AD35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32496-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:email,dot.gov.in:url,nic.gov.in:email]
X-Rspamd-Action: no action

Hi,

On Thu, Mar 5, 2026 at 1:28=E2=80=AFPM Gaurav Kansal <gaurav.kansal@nic.gov=
.in> wrote:
>
> Hi ChenYu,
>
> Didn't the information is already merged as per my last patch submission?

It looks like I requested some changes, and you agreed to send an update,
but I never got it.

ChenYu

> Regards,
> Gaurav Kansal
>
>
>
>
> From: Chen-Yu Tsai <wens@kernel.org>
> To: "Degrader Snehil"<degradersnehil@gmail.com>
> Cc: <linux-wireless@vger.kernel.org>, "wireless-regdb"<wireless-regdb@lis=
ts.infradead.org>
> Date: Thu, 05 Mar 2026 09:08:56 +0530
> Subject: Re: wireless-regdb: Update IN regulatory domain for lower 6 GHz =
(5925-6425 MHz)
>
>  > Hi,
>  >
>  > On Thu, Mar 5, 2026 at 3:16=E2=80=AFAM Degrader Snehil <degradersnehil=
@gmail.com> wrote:
>  > >
>  > > Hi,
>  > >
>  > > I would like to request an update to the IN (India) regulatory domai=
n in wireless-regdb to add the newly permitted lower 6 GHz band (5925=E2=80=
=936425 MHz).
>  >
>  > Thank you for the information. Would you like to provide a patch?
>  > If not, I can write up a patch and tag you as the reporter.
>  >
>  > > The Government of India has officially opened this band for licence-=
exempt use via Gazette Notification G.S.R. 47(E), dated January 20, 2026, p=
ublished January 21, 2026, issued by the Ministry of Communications under t=
he Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy Act, 1933.
>  > >
>  > > Gazette details:
>  > >   Title   : Use of Low Power and Very Low Power Wireless Access Syst=
em
>  > >             including Radio Local Area Network in Lower 6 GHz Band
>  > >             (Exemption from Licensing Requirement) Rules, 2026
>  > >   File No : 24-04/2025-UBB
>  > >   Gazette : No. 47, CG-DL-E-21012026-269488
>  > >   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communi=
cations
>  > >   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f=
6907934d17d0015ab5.pdf
>  > > The Gazette defines two device classes for 5925=E2=80=936425 MHz:
>  > >
>  > >   1. Low power indoor
>  > >      - Max EIRP         : 30 dBm
>  > >      - Max PSD          : 11 dBm/MHz
>  > >      - Max bandwidth    : 320 MHz
>  > >      - Restriction      : Indoor use only (Rule 5)
>  > >
>  > >   2. Very low power outdoor
>  > >      - Max EIRP         : 14 dBm
>  > >      - Max PSD          : 1 dBm/MHz
>  > >      - Max bandwidth    : 320 MHz
>  > >      - Restriction      : None
>  > >
>  > > Additional operational restrictions per Rule 5 of the Gazette:
>  > >   - Band is prohibited on oil platforms
>  > >   - Indoor use prohibited on land vehicles, boats and aircraft below=
 10,000 ft
>  > >   - Communication with and control of drones/UAS is prohibited
>  > >   - Contention-based protocol is mandatory for all devices (Rule 4)
>  > >
>  > > Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MH=
z (Rule 6)
>  > >
>  > > Proposed addition to the existing country IN entry in db.txt:
>  > >
>  > >   country IN:
>  > >           (2402 - 2482 @ 40), (30)
>  > >           (5150 - 5250 @ 80), (30)
>  > >           (5250 - 5350 @ 80), (24), DFS
>  > >           (5470 - 5725 @ 160), (24), DFS
>  > >           (5725 - 5875 @ 80), (30)
>  > >           (5925 - 6425 @ 320), (30), NO-OUTDOOR   # low power indoor
>  > >           (5925 - 6425 @ 320), (14)               # very low power o=
utdoor
>  > >
>  > > Note: Since both device classes share the same frequency range but h=
ave different EIRP limits and indoor/outdoor restrictions, I have represent=
ed them as two separate lines. Please advise if a different encoding is mor=
e appropriate.
>  >
>  > Unfortunately we currently only support one rule per band. I'm incline=
d
>  > to add the VLP one so outdoor usage is allowed.
>  >
>  > > I have attached the official Gazette notification PDF as supporting =
evidence.
>  > >
>  > > Intel has also submitted a related update (Intel=C2=AE Wireless Wi-F=
i Drivers 24.20.2) for this band for India. I am not certain whether that p=
atch covers wireless-regdb (db.txt) or only their iwlwifi driver internals,=
 so I am submitting this request for wireless-regdb independently to ensure=
 the authoritative database is updated.
>  >
>  > AFAIK Intel manages regulatory requirements in their firmware, so it i=
s
>  > unrelated to the database we maintain.
>  >
>  > > Intel's Regulatory Domain Info was found in Release notes of their  =
Intel=C2=AE Wireless Wi-Fi Drivers 24.20.2 available at page 2 of https://d=
ownloadmirror.intel.com/914148/ReleaseNotes_WiFi_24.20.2.pdf.
>  > > Please let me know if any further information is needed.
>  >
>  > The information you provided is very detailed. Thanks!
>  >
>  >
>  > ChenYu
>  >
>  >
>
>

