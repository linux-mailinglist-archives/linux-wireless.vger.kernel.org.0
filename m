Return-Path: <linux-wireless+bounces-33446-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LvAJYdgu2lujQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33446-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:33:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 391622C502D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 03:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C13E3015D82
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 02:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC233B6D0;
	Thu, 19 Mar 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMnYCvcL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB523B632
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887618; cv=pass; b=pK9WDoXNyylQWCz2VpzDdI5FcsRyIhGva/Ge0JvFwn5A6VYw4wPT6+6I3vpoFpKardQn2rHkwkxlvzKZPiHNo+CMgUcr0pUqNJL3NoSWL/u9AwTCJCL4sXQlfQUQjx33D0og+Hn5cvNZTQGpLOkRfMzGbdmxCNQ06xtJLrFDuiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887618; c=relaxed/simple;
	bh=sjMDUmVRsr5o8iCRKGYLI95lRocNOM3pXGQgbsUJz98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqR3dMxYRcAOLHMF8qQ3SikdFlR2nLA68EsEI1sF5W7IBWKAkG68tjiEzbY9xwDZ5gtx/XTBkPXala8xqSk9Aa11qgWj/25Hv5SHkML9LJvYzEqsFqwGySHdXcdjthuwrjFMYd4piZotIPaSSsbbT0mxY5Ji2H85Cl3FcSb8oJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMnYCvcL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97e6e48b24so71795266b.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 19:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773887615; cv=none;
        d=google.com; s=arc-20240605;
        b=k0QVcY9SOQHWL8zePHNKfWULyKWLJr/nONJjxpkRdvyvtAaB1AEVUmJS9SLy5itnqT
         0HkLFOr7LnfI/CSiXx22HaBSGwqgvrDbcPZOBUqOnsVu7dTguKyqqm+HeelQ/g3sAg1S
         x4XMGTE3NlUYXmT5gVNfH5tNXfuF3tGgRrch6Ed/09rO1UHmnvGATFGudRnsVAM4XQQx
         25bbKLVZD60Q6HPdZU1vAH/KckJYxItm2VKd5Y/Asnf1IpthEkqZza8vzUH0+w+u7TPz
         ws9cJGFhVCMEzmglQ7vIChT72+enJTK9BIOGDRTwi2HKdgCHIt5kryISnGKDVHwbFU6B
         khvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywOJcWTqxF6hWy/WoRxYC1tt5klL89T7P0xRBUxLoiQ=;
        fh=EEqq1nyX5noIwz+ZeuRwJY5LeYNGO0SH4elp/69PwDE=;
        b=ChkRShJQO8xYllTiapkfpc/SQkJaqn0Cc83FWadfxwWPskNk6joUYqA34b/NRY7WF3
         M6eMjsaCa8lYAj3r2wJMjxtcFDds/r8Giw2wzq6/Y8D11hFCZg6ej0EaHm4h/cH9o8t5
         HYHOSJZujgoJ7BvacoCOPdXvEBYEAW8e451+ja0bP/OL/cwBFLh78ZGYyEGcpj7a4J3Q
         /tso42tSdJRJOBoWaWrsTv53Zlhmw7+SwAzionZBJ7UAmSyAgBl8jyOdfV/6QD8WKtrF
         F56gPbnK5ixnDgMakoRue5ZaL2XrWZQ+7f/rAL8sASP3CXLI+f1HaY8Ea+AaiAgdXgqb
         F0VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773887615; x=1774492415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywOJcWTqxF6hWy/WoRxYC1tt5klL89T7P0xRBUxLoiQ=;
        b=DMnYCvcLHmhZeUlK+4Gdlw+xCr+V2sTYif9VfTBe7ZoSQggpdP0rFvmoQoGoFiJ5Yi
         s12GrprUKXWo73ORKJIvNq2wE6Qi4Wxt6nM/oRpfSfRTx1bFrkEpUvBsCQ4mpxwa1QyM
         J5jFAz7BEQd7QVFGgNaiQ2Hsj/OL3ffAjbZPOdwhjOLmz5oRw/nsIrJNYo2B4O7S02v6
         cGGh5HAtpQ4Cq5HEQbk1VkPjHptGmdmd9L3FzY6s286tNJzXHhHyKqC0dIbLxi9/TzVO
         JY/stDyeSiUkG36A2Bw46jYyYqppvKRpO/5B57naGU/wdq1tIWKsT2NjJXbQy3aUK17h
         L15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773887615; x=1774492415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ywOJcWTqxF6hWy/WoRxYC1tt5klL89T7P0xRBUxLoiQ=;
        b=sKctMYuOp/jrCF4GhPbAgOXMcgGjcE+r3IQZgtGz9YMQqsvv9157NMfuHZOEKzaUT+
         jatSs12ip8NdhjtzRtdcS8cdrEeQL1jjcJLtXkzu9bewU88LNScQITuuY6TPcs2M6bOY
         G0i6FthgladjS3z7bLElcd7yMY4YzSFSojCWbG8Ihxl1LSYWztfttDkhqAaBOSNZ1lGE
         41XyhIwYF7h2lije91z5mxgWK6ZzrIgVN7TNw+QW4caomhMo0gz00Bc5fRKclRqJ9tms
         h/Y/aojSXI0umdrWtpq9Ygo+9YYqe8RQ9jTbaxtqs8BrOaobQ5ZE1lKY6exIxFCIUKZi
         MD4w==
X-Gm-Message-State: AOJu0YxdnO7sZYmkK+PfEGW5B0BAtqv24UPsWJV/VlvloLjTWT/0S0lz
	ZkZM5CxS5x9uRtUfPAHxfGaf1Mia7fP2U8yT/3OlVqynWXzh7pMjd0LGm9N3VJGsQDeWZ0S0yB0
	Chn4N57PIyQf4qz+se5GgDROyPoUUzIA=
X-Gm-Gg: ATEYQzyg/n30cHVSxPhZh+4qM2zBy8h/EbQ9nYM2nAUXcf45oqo7MUzvQa/kh/91PfL
	R0p+a70kkZ0XEK/ExC5yJwdzkCdl07PVzyOmdlfAAWTj+41iHo1vbQNrSyc0Ia9eJumUXOUqjwd
	Zy8bINJTQI/cE2i78j9a4+RakIU+ycCXOQnKEe49cYMU9EW/H/IyEdlNVfoHmbaVGZ9OokWMeY/
	+FB3dbpAFhgXY/60xS7uhI6yKMF0NaKObUDLj3SA136SLRKW5XT+fYDHjdAtivjs9c30rdLS98S
	8LmENA351vqdL26gmyQ=
X-Received: by 2002:a17:907:72cd:b0:b97:4e42:23e3 with SMTP id
 a640c23a62f3a-b97f498c144mr334147666b.26.1773887615048; Wed, 18 Mar 2026
 19:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318064834.103731-1-pkshih@gmail.com> <CAGb2v65PcZcBYg7qaeFaVH0=1fowOkW+7gL5wWA0wTMBu74JHg@mail.gmail.com>
In-Reply-To: <CAGb2v65PcZcBYg7qaeFaVH0=1fowOkW+7gL5wWA0wTMBu74JHg@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Thu, 19 Mar 2026 10:33:23 +0800
X-Gm-Features: AaiRm53Jsgd5CG5Igb5Bep8Tw9tlR0uxe4njpKvJkFg9TEXi34KjjXMtkzNrT9E
Message-ID: <CAHrRpunyjQteOdA7SbuAzzrkOxP8rwS7OXkmcWC6LDh948y-jA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Add regulatory info for CEPT countries
 FO, GI, IM, SM and VA listed by WiFi Alliance
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-33446-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 391622C502D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Wed, Mar 18, 2026 at 2:48=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > In commit 5a8ced5ad313 ("wireless-regdb: Update regulatory info for CEP=
T
> > countries for 6GHz listed by WiFi Alliance"), the following are skipped=
 as
> > they do not have corresponding entries in the database yet.
> >
> >      - Faroe Islands (FO)
> >      - Gibraltar (GI)
> >      - Isle of Man (IM)
> >      - San Marino (SM)
> >      - Holy See (Vatican City State) (VA)
>
> Confirmed the list. Also checked against another source [1].
>
> [1] https://help.ui.com/hc/en-us/articles/8691786444567-Regions-Supportin=
g-6-GHz
>
> > Look up the CEPT decisions [2], and add entries along with decisions [3=
],
> > [4] and [5] for 2/5/6 GHz regulations.
> >
> > The 2 GHz band by ECC Decision (11)05 [3], which the adoption of ERC
> > Recommendation 70-03 [6], the regulations and the frequency bands to be
> > used for Short Range Devices (SRDs) are included in specific annexes to
>
> The 2 GHz band is now governed by ERC Recommendation 70-03 [6] with the
> withdrawal of ERC Decision ERC/DEC/(01)07 by ECC Decision (11)05 [3].

will update by v2.

>
> > this Recommendation. By ERC Recommendation 70-03 annex 3 (WIDEBAND DATA
> > TRANSMISSION SYSTEMS):
> >
> >  * 2400-2483.5 MHz
> >    - 100 mW
>
> Looks correct.
>
> ERC Recommendation 70-03 annex 3 also includes the 60GHz range (57-71 GHz=
).
> Can you check that? We would need some other source of information like
> the WiFi Alliance page to verify that the countries have adopted the
> decision. I don't think the CEPT decisions are directly binding.
>
> The end of the document also has a table of the implementation status
> of some bands in some countries. It is obvious the table is not complete.

For 60GHz, it looks like EU implementation deadline on 1 January 2020 [1], =
but
CEPT countries aren't all EU. I only found ECC Report 288 [2] [3], but it i=
sn't
decision (so it must not have a implementation deadline). I think we can't =
fill
60GHz entries for now.

[1] https://eur-lex.europa.eu/eli/dec_impl/2019/1345/oj/eng
[2] https://docdb.cept.org/document/8213
[3] https://docdb.cept.org/download/1365

>
> > The 5 GHz band by ECC Decision (04)08 [4]:
> >
> >  * 5150-5250 MHz
> >    - 200 mW
> >    - Indoor use
> >  * 5250-5350 MHz
> >    - 200 mW (due to TPC required, -3dBm, 100 mW is adopted)
> >    - DFS, TPC
> >    - Indoor use
> >  * 5470-5725 MHz
> >    - 1 W (due to TPC required, -3dBm, 500 mW is adopted)
> >    - DFS, TPC
> >    - Indoor and outdoor use
> >
> > The 6 GHz band by ECC Decision (20)01 [5]:
> >
> >  * LPI devices (adopted)
> >    - 5945-6425 MHz
> >    - Restricted to indoor use only
> >    - Maximum mean e.i.r.p.: 23 dBm
> >    - Maximum mean e.i.r.p. density: 10 dBm/MHz
> >  * VLP devices
> >    - 5945-6425 MHz
> >    - Indoors and outdoors
> >    - Maximum mean e.i.r.p.: 14 dBm
> >    - Maximum mean e.i.r.p. density: 1 dBm/MHz
>
> Looks correct.
>
> > [1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> > [2] https://docdb.cept.org/document/category/ECC_Decisions?status=3DACT=
IVE
> > [3] https://docdb.cept.org/download/1535
> > [4] https://docdb.cept.org/download/4501
> > [5] https://docdb.cept.org/download/4685
> > [6] https://docdb.cept.org/download/3700
>
> This doesn't seem to be the latest version. The online version is here:
>
>     https://docdb.cept.org/document/845
>
> and shows the latest revision was published on Feb 13, 2026.

will update to https://docdb.cept.org/download/4916 by v2.

>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  db.txt | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/db.txt b/db.txt
> > index d54ef78e0da8..e2afb145ede5 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -731,6 +731,13 @@ country FM: DFS-FCC
> >         (5490 - 5730 @ 160), (24), DFS
> >         (5735 - 5835 @ 80), (30)
> >
> > +country FO: DFS-ETSI
> > +       (2402 - 2483.5 @ 40), (100 mW)
>
> This should start at 2400 for all the newly added countries.

Oops. Sorry for the mistakes.

>
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS
> > +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> > +
> >  # FR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN =
301 893)
> >  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300=
 440)
> >  #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN=
/TXT/?uri=3DCELEX:02005D0513-20070213
> > @@ -801,6 +808,13 @@ country GH: DFS-FCC
> >         (5490 - 5730 @ 160), (24), DFS
> >         (5735 - 5835 @ 80), (30)
> >
> > +country GI: DFS-ETSI
> > +       (2402 - 2483.5 @ 40), (100 mW)
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS
> > +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> > +
> >  country GL: DFS-ETSI
> >         (2402 - 2482 @ 40), (20)
> >         (5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=3DETSI
> > @@ -976,6 +990,13 @@ country IL: DFS-ETSI
> >         (5725 - 5875 @ 80), (25 mW), AUTO-BW
> >         (5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
> >
> > +country IM: DFS-ETSI
> > +       (2402 - 2483.5 @ 40), (100 mW)
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS
> > +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> > +
> >  # Source:
> >  # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-=
gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> >  # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-10=
48e-dated-22102018
> > @@ -1855,6 +1876,13 @@ country SK: DFS-ETSI
> >         # 60 GHz band channels 1-4 (ETSI EN 302 567)
> >         (57000 - 66000 @ 2160), (40)
> >
> > +country SM: DFS-ETSI
> > +       (2402 - 2483.5 @ 40), (100 mW)
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS
> > +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> > +
> >  # Source:
> >  # Regulation N=C2=B0 2004-005 ART/DG/DRC/D.R=C3=A9g
> >  country SN: DFS-FCC
> > @@ -2072,6 +2100,13 @@ country UZ: DFS-ETSI
> >         (5170 - 5250 @ 80), (20), AUTO-BW
> >         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> >
> > +country VA: DFS-ETSI
> > +       (2402 - 2483.5 @ 40), (100 mW)
> > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS
> > +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> > +
> >  # Source:
> >  # http://www.ntrc.vc/regulations/Jun_2006_Spectrum_Managment_Regulatio=
ns.pdf
> >  country VC: DFS-ETSI
> > --
> > 2.25.1
> >

