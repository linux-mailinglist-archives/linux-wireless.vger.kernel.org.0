Return-Path: <linux-wireless+bounces-39078-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJkdCltSVmpo3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39078-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:14:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C1756497
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RPLv8QsF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39078-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39078-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5190B3024C82
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50004483BD;
	Tue, 14 Jul 2026 15:13:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EB47ECF0
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 15:13:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042038; cv=pass; b=Loz1Kdk4h+RmANurksJ0HGvx94EdcOoc/lmXaR/tZNHOjF328n+0VgOnaO0DLvVwc350p03N1OfHgDhru9Nu7DeeHMsG4XC7Rb3frUsSrasBoNj36qR4d887k67fuymr742bisO4sA1roX7MZsYW5OO9v+ZybCITbzoZRp6OsoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042038; c=relaxed/simple;
	bh=UgoS0j4K78MlIyl1+UAw3ILDHgBghJ5jb/4dajKUK1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9cBNnV9LRUtdZAFC4QZvZNKxIBX2p5mAxXDY0ZvorSpaAnmYAttI1TdNeiVkq5UJC7ki3v2yg69hWz+iBfdPAvbia8FXM4Ki1YhQl5x/XDXMFgQR5rmtBBDicoVghOgWda69LMoMw+ISxnsa0J3YFrSWdG+nv6bPvLOWrdnJ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPLv8QsF; arc=pass smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad68425a7so6415905ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 08:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784042037; cv=none;
        d=google.com; s=arc-20260327;
        b=qWyXR/dwWbkd/QTgGgxoVk6SUq39GvCyayltLMBHUH74sD0uqDGq37c1Il0z/GdEbo
         yh8z5vsnLLdQPm2fFtE9tkX+4GmAw5EMV8/SEzKnmi6a8q3Dl8Jb81ABQnqF4W5wWOrT
         2Uw/JM4f5MpwZ+U2ii/rRwVdFj+6J44a3/fDcUXwCPmcyaHGqtDGc1KhhtCjCgPfM/3E
         8JSLO565rBcZiIh7IlGHSdfPYdgHd9aE1DIty0VJPdavanieckU92d1H8TecTugHGyk6
         B3nYZym0lQ4BTcUzw5J5shJShCxPCPjRh6WOB8iIUbmonqTsvWY5NOYxqizvw09WxjPH
         fSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vK5QmwsUTvO+w3mfeVvzuue37ffn3bjmkO1DFTx2Qa4=;
        fh=k1GXrmuolDxEN40ZxVAeDMeBQISXEr9ydmD9mjIqrNk=;
        b=seVzqJvISCQnhR5MQcZgeHLq27YMhn/LBG6kYpc1wLkAXMzIei4FH49neXm7L8uDsp
         qvZzGntOBpHTn6HyWFullASwDLziDNVi6M+q3juJ49YH48Y5r8oA2QboUs0/PEfXy0Pd
         f4JTPY5cUnT4L01dy8aAJwo8n8NMIEzfhNEhErcM+sjSdTykszrBTWjwGwAZEP1aSJYo
         xFHPSwzcdn0hjQN31pcVye2xBj1aGwYsjnbMLcoMTIaEmbrIsP4vS2HPhGMhZHp4rc5L
         VtHogaii3YK4DJpJlNPPC8TiqFfj2EbrZw2MfJn5kYD6URSHIsGM85sGbObUmFXfvlyO
         XrpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042037; x=1784646837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK5QmwsUTvO+w3mfeVvzuue37ffn3bjmkO1DFTx2Qa4=;
        b=RPLv8QsFgv4QJCH0cTEnkpPfhxePWDma6kqbHLCZRYGJJQGHSW5C6ntzU0Cyf1k42k
         aAM5rRInImd6VrsBoYCdYFjH5u3wUNdfZaCUXzHODmzy4koGlcCB5NLEz9g9wR1lldf+
         N/Hk0B7eFq5xdcHx+VedqqZ/N85AYQwzPHs6vC+Dtkn6oWhXCf96I4nw+L2YqtjjeFx3
         nrUHO6UtdwOcfK9aSsfHuOTVS6lYp7c18fE+gULFhVp8/Im5iW/eh1atpQrhnQ27tfae
         0dEOSPMVof9ciNJdZe6IAb6p1I2kKlQtY6DYrdcqV7vYBvIPejVuedOw1sHrha5mQiDl
         vFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042037; x=1784646837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK5QmwsUTvO+w3mfeVvzuue37ffn3bjmkO1DFTx2Qa4=;
        b=NLL51hurxAK1Pdoan2d8fv5X9jdfk8GKhS/StY1tlyaTn4bHu7z2QTIMtN7tl1P1Js
         P1vg3K2j1Amw3k9tANy34O1UOj9HnS49sO7nhvOeRjCvMRafScA11KX1hEuSXU37XuY/
         xr+DB3KZfEksJ5UkgdDSfF0VL84udw3fZ1V8nFb8K3+FmqlRbOc7weaU4aJoRKgrIes3
         jIZ4Y6kyuYW6I7+iz8XDkvqPuNxXF86o3PDMS/bLB+K3mA13bmhvcgO3ma23jFUx+oZp
         um/BKKtQ0o6YPOl/AXDqa7Jvz+whp/jK2xYvH0DojeIclkxv5XMXMbHjeGjjhKOa3DHC
         DJVA==
X-Forwarded-Encrypted: i=1; AHgh+RqPfAwlWNzDYjhGkgvme1mFxtAdJkduhf5bsOYr5xk4nzr/FJ47NCKgR+lgOq4Gefc47MgVWWNwaRO9ggC9Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB65sjfYVdPi8V+q88gyXHOzgo7wpAmZ/V3/VZUA7I0d7pbXV6
	IB5dLKyDFoPgqVy80AwGa3iaU8D6dgYFufg5lM29HIlJ5/maDcmM8XfNZIVh13wzn5WeMmjCujj
	D7AFDiwwa8VoY0auyqwF9a+57HMBtv+c=
X-Gm-Gg: AfdE7cmytxdmie3CFlGTLy1QVGxpeEqGdiJuDU2Izc4B13Ls4g18qCL7MoV8tQRMAmQ
	MP6433Z0hDvWBzhhGjPMFs50LLZwL94XV7mkxur9a8uMPLZT+qaTJ0KVGdbe1cSBIM+nhh9e70V
	uqqGHB4Gr3BdIooBVJqfrj5FCiiLWytvyQzhKAqeBd4vfCFUBv4T6JNYJr7BfnPAf6sQ/rF96MW
	HKFbsNW/CrS0HLGaaBpDkNlS9f3UyDY+fXbCHyH115vdab4mQ0rnysa6TjdlqCSfRLdbHx/MbtW
	DojGZB4LuwLmWsL9gsaJficn4F4jXirJ307oKTSTSmfbIdpazqNiCuyLm5rYngeem6sE7Uk=
X-Received: by 2002:a17:902:c40f:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2ce9e59ee7cmr124563185ad.2.1784042036663; Tue, 14 Jul 2026
 08:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709122315.11400-1-bogdan.nicolae@gmail.com>
 <99c2c345-c594-46e1-b48a-de7f6e52e1c6@broadcom.com> <CA+ORkNTNytDi56RJbWHoFXLR2mSAgosz4UxHPgEvCBojmaFOdw@mail.gmail.com>
 <cnztilpxknxuyofx2pfdqissbhqtopwoygzr73ux2qmyasqebv@iesg7d6rvxsw>
In-Reply-To: <cnztilpxknxuyofx2pfdqissbhqtopwoygzr73ux2qmyasqebv@iesg7d6rvxsw>
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Date: Tue, 14 Jul 2026 10:13:27 -0500
X-Gm-Features: AUfX_mxGWHBpBRJQmPI31ArrZDWfrMpuuVcSaRw4MGfRobcdoK48Ob8bRnS2z2c
Message-ID: <CA+ORkNQ40+xO2+aOc302Z9OZ4qcaWXRE7J-xOR51=-k91prdgQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, Bogdan Nicolae <bogdan.nicolae@acm.org>, 
	wlan-kernel-dev-list@infineon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-39078-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gokulkumar.sivakumar@infineon.com,m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:bogdan.nicolae@acm.org,m:wlan-kernel-dev-list@infineon.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,acm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wikipedia.org:url,infineon.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 697C1756497

On Tue, Jul 14, 2026 at 8:03=E2=80=AFAM Gokul Sivakumar
<gokulkumar.sivakumar@infineon.com> wrote:
>
> On 07/14, Bogdan Nicolae wrote:
> > Hi Arend,
> >
> > The code already sets *cookie=3D0 in the beginning, which according to
> > my understanding tells the driver it does not require async tracking
> > upstream. This is correct, because the function calls
> > wait_for_completion_timeout, so mgmt tx completes by the time we exit
> > the function and doesn't need to be tracked upstream. However, while
> > we are waiting for mgmt tx to finish, the firmware may generate
> > non-matching completion events captured by notify_mgmt_tx_status.
> > That's why setting a non-zero packed_id (sent to and returned by
> > firmware as part of a completion event) and checking against
> > vif->mgmt_tx_id is important.
>
> Avoid top-posting. Need to use interleaved style.
> https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>
> > Cheers,
> > Bogdan
> >
> > On Sun, Jul 12, 2026 at 5:30=E2=80=AFPM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> > >
> > > On 09/07/2026 14:23, Bogdan Nicolae wrote:
> > > > Avoid setting packet_id to cookie, which is always 0. Instead, use =
an
> > > > increasing atomic counter. Avoids mismatches of completion events l=
ater
> > > > in brcmf_notify_mgmt_tx_status, where packet_id !=3D vif->mgmt_tx_i=
d is
> > > > checked.
> > > >
> > > > Also, zero out auth_status on initialization. Otherwise, garbage wi=
ll
> > > > leak from the stack to the firmware (when bssid is less than 32 byt=
es
>
> BSSID will always be less than 32, you must have meant to say "ssid" here
> instead of "bssid". Also the auth_req_status struct does not have any "bs=
sid"
> member, it only has an "ssid" struct member. Need to fix in commit messag=
e.

Fixed

> > > > and/or when params->pmkid is set). Then, pass the params->pmkid to =
the
> > > > firmware (without it, the firmware caches a garbage PMKID on succes=
sful
> > > > authentication and denies a subsequent association request that inc=
ludes
> > > > the PMKID).
> > > >
> > > > Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>
> > >
> > > I always get a bit confused when people use different email addresses=
 to
> > > send and sign-off patches.
> > >    > ---
> > > >   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c   | 8 +++=
+++--
> > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/c=
ore.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > > > index ce09d44fa..cca53ff19 100644
> > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > > > @@ -23,6 +23,8 @@
> > > >   #define MGMT_AUTH_FRAME_DWELL_TIME  4000
> > > >   #define MGMT_AUTH_FRAME_WAIT_TIME   (MGMT_AUTH_FRAME_DWELL_TIME +=
 100)
> > > >
> > > > +static atomic_t brcmf_cyw_mgmt_tx_id =3D ATOMIC_INIT(0);
> > > > +
> > > >   static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
> > > >                                struct cfg80211_crypto_settings *cry=
pto)
> > > >   {
> > > > @@ -155,7 +157,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, stru=
ct wireless_dev *wdev,
> > > >
> > > >       memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
> > > >       memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
> > > > -     mf_params->packet_id =3D cpu_to_le32(*cookie);
> > > > +     mf_params->packet_id =3D cpu_to_le32(atomic_inc_return(&brcmf=
_cyw_mgmt_tx_id));
> > >
> > > As I understand things the cookie value here is an output parameter. =
The
> > > driver should assign it:
> > >
> > > +       *cookie =3D atomic_inc_return(&brcmf_cyw_mgmt_tx_id);
> > >         mf_params->packet_id =3D cpu_to_le32(*cookie);
>
> Agree with Arend's suggestion here. It is not correct to leave *cookie =
=3D 0 as it
> is and only assign a different packet_id while sending requst to firmware=
, because
> in that case the driver will not return the real cookie for this TX to cf=
g80211.
> Driver should assign the generated ID to *cookie and then copy that into =
packet_id.

Fixed

>
>
> Gokul
>
> > > >       memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
> > > >              le16_to_cpu(mf_params->len));
> > > >
> > > Regards,
> > > Arend

Regards,
Bogdan

