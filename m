Return-Path: <linux-wireless+bounces-39009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aitOG9HdVWpUugAAu9opvQ
	(envelope-from <linux-wireless+bounces-39009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:57:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC690751B14
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 08:57:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ai9r5IGu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39009-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39009-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933E6302713F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 06:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8EE3DBD5E;
	Tue, 14 Jul 2026 06:57:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09C2F8E94
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 06:57:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012238; cv=pass; b=n4hirNl9TPkFEE6tr+WdWdlqriK5yfljeLPuCJmhtGnj7GxOb/Fh2pt7j0fGv5EQhnTKUmfYJ1qwgHxWvLoI4bGMS7Zh++lQtFr5BUMEQqi6sVT91qsm7w2eaaUiElVvBtS/Q6YuHMlRWKad69xMzH0mYByT8omAzV8AIdmSHKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012238; c=relaxed/simple;
	bh=sYhPPrA+LEyGe10v/9S9iujhzySyqoZg304AA5V99f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3ZoA9YTx3LkT2ucpyiBXtQKJ9xe5+EkGCIs8kd1YOiXzQuS8+yQmuPVdquc+Gug6LE7ztVuQROUjU90XKNwMsgFp6qnMoxdmrUpjcu3lJyLxjt57q+VDyK6jgN3cxJBMKP8iuahPG6QaqdPmwF/lijS8cjbVBwygvmZ5klvp7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai9r5IGu; arc=pass smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698b89e300eso720581a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 23:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784012235; cv=none;
        d=google.com; s=arc-20260327;
        b=MntGZduGMx1LytI1MczY2PNjMh1QS3nplQj/mD/UieyP+y7l+EPPXUFG5SIPa9t9l4
         bWAOjijZZqvjirMD4POCo9uLT5mzQbLMPDmYVhDfkhLF+ZVsBDH4EaoZtQgE0dpSN2rG
         IRUrekJ4zXef3/Y7Y6BmefAmK6Ryn2AfgR3hdGibj+cl/TtYG4OCYyO+M/dZ12csUiPv
         HFUEbYRlwk4AuPru7iu2uIjYeX0TdUj2L8Snm5qqSvt/fuK+//QSIQTJHjecPmY7S9so
         mowGD8a2NdxjHHxkqLaj1CxbMq+pxVq6KDREbDrvrHW4ca2duaYwJ4eyEYmXUrwHI83s
         wHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TWuc1W6rlFvxt2fRtmEwf0XG9lnKi5ioowfRSdvC5p4=;
        fh=yEQvfiJfVXiDUrYgkmtI6kPrlCmbcjy2pkqrGAGd4mY=;
        b=hoKfc0yRyEB0GSdDg8rcsWsZm8Kbp3w9gngmsFBlZzaNS2oDPB6t+MuXkkdPhXTnyx
         97Bqy6Hm2BMO/gr2Txjj9j8qTf+F9Erao+s3UANniq2v8yxYgLLtqkcnct2FaFQpi9B9
         Hw9l5d2iUD8B8BKmgDXGvyarHV04tLFjSa9K2aaOwx5sx71zaM6P0VFKt7KopxWQE6gg
         BcUwFqx4+6HsWxfL1ZFqaHiHwVyH+KdJvJuF6Z8Mk0LRyvxrHnfRXuR7FM76Nv2P6cOh
         YSgMvliNzdLy51GVG9q9+T9nyQDWJ41uBLTlyfLtIXmmEBf3m+CJ2F+SaccCv08m/c1A
         P80A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784012235; x=1784617035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TWuc1W6rlFvxt2fRtmEwf0XG9lnKi5ioowfRSdvC5p4=;
        b=ai9r5IGucWaGVxdus0ZZW2XYwEyGJCKtdTJXWrSWvNAXNiEHEn8o8mElvbJfm0vD++
         WrdfK9iEUs6LaEwA90iPmUGtyK9LWSEJFOTZzlIMLr2ORJ6kPcCjPfgNW5I9rEXN/ITy
         fnco0P00e1++XC4Spi9c7HJZTeGgTCXy2aDhsRi2Mb0DG70HVN9X3Yt7yGk7UXXi+h97
         qmEmAsG7VndZ/4Kb4PwLQTXNPWM87/wNSjXIUpMbcylYfS+A7+Nh3UPi3nj3HqJZjcxO
         lsA2bWVAvLzfnN533eYp1SyhV3UMBBEX33t9dZEcCThJLP2CQfC69ncbRBI0DM/Hzpzk
         V8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784012235; x=1784617035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWuc1W6rlFvxt2fRtmEwf0XG9lnKi5ioowfRSdvC5p4=;
        b=kM0tcbAPhfI34OX9JXYAcX+W6OQ4nxJt37IxECBV4+4EKjqGscj3kCovme+FRUeVnM
         xBDJF4vcX45JsrWkiR30hU49yQJZxl9UiYGYqBwOF7Ub2L2JJC7pBao76qtnVmYPILeh
         K8x+3XAOy/2VXWgrAEukBXMAJT11qp4iqLLaoVdzbOAZz18NC40ZzadpdgC8FxKTG3QO
         wi1HtOSt/6VEa/c98Ch+HKTt+cLUaJgSSDFVRJHdo23e+x/VCN+XV7Nf2gl/6iyApryl
         tEyhu8oByZd/RO+fmQjLfp/chIGeWAT3LDjuvtuh8q9yBm5O8klfF3ZoZ4vSYWgU6Igh
         Colg==
X-Gm-Message-State: AOJu0YzMlNf1e4I3ZPnRLYaekNrGn+jchMCMaAlFrZBlBxnoELqrgJ9S
	PnvqfDhn+8bxBnOSl5LQvxFe+wWa1RPwOK9P1+noD4aC2dZ4y4fZ6a1MI6FWAE0mRAcsOrSl/Gy
	u2mrf3ri/48Mq5ElWwfHgkF1AreLx5S2OU8blPR8=
X-Gm-Gg: AfdE7cmsoci81VejsQoUUE3mHQEetPe32k1T1FDPZ06TF2sN8x2XPjnu6Zf+bQkYrmP
	sCgbl2VihD+OXsx5MCpzmq55V4DfrZiD0ksfZGmOM3yWx+lAcC/KdmT0m7Ilk2R9JfW2ABrO45y
	OwMmZH2Sqb9oWzNKoL0yZuCcAJ/uKYG7zfah3uIjLjVQtrY3pTU9shg4bdp6MLIYKPZYEaag4do
	uh+r1Jfobroh6ro4vWJqg89nrqecQVhKbF6lucWWP9QKOjxIkdaoK/1BDJc/zXud2X7wq+lCz/a
	FucgJPNLnNBaRjbbiEuq6Ikzcdsf3DJb0xunpEtcguUiSBHh6vs1yR2GXDPjQx20o+xOSeo=
X-Received: by 2002:a05:6402:a50f:20b0:69c:799d:125d with SMTP id
 4fb4d7f45d1cf-69c799d174emr1419094a12.8.1784012235125; Mon, 13 Jul 2026
 23:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709122315.11400-1-bogdan.nicolae@gmail.com> <99c2c345-c594-46e1-b48a-de7f6e52e1c6@broadcom.com>
In-Reply-To: <99c2c345-c594-46e1-b48a-de7f6e52e1c6@broadcom.com>
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Date: Tue, 14 Jul 2026 01:56:47 -0500
X-Gm-Features: AUfX_mwK4Gri8h9h1CHY-X_flEhORWH-Kdw7WVbunTKwsx3Kedyrp4QrSRTfomo
Message-ID: <CA+ORkNTNytDi56RJbWHoFXLR2mSAgosz4UxHPgEvCBojmaFOdw@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	Bogdan Nicolae <bogdan.nicolae@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:bogdan.nicolae@acm.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39009-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bogdannicolae@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC690751B14

Hi Arend,

The code already sets *cookie=3D0 in the beginning, which according to
my understanding tells the driver it does not require async tracking
upstream. This is correct, because the function calls
wait_for_completion_timeout, so mgmt tx completes by the time we exit
the function and doesn't need to be tracked upstream. However, while
we are waiting for mgmt tx to finish, the firmware may generate
non-matching completion events captured by notify_mgmt_tx_status.
That's why setting a non-zero packed_id (sent to and returned by
firmware as part of a completion event) and checking against
vif->mgmt_tx_id is important.

Cheers,
Bogdan

On Sun, Jul 12, 2026 at 5:30=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 09/07/2026 14:23, Bogdan Nicolae wrote:
> > Avoid setting packet_id to cookie, which is always 0. Instead, use an
> > increasing atomic counter. Avoids mismatches of completion events later
> > in brcmf_notify_mgmt_tx_status, where packet_id !=3D vif->mgmt_tx_id is
> > checked.
> >
> > Also, zero out auth_status on initialization. Otherwise, garbage will
> > leak from the stack to the firmware (when bssid is less than 32 bytes
> > and/or when params->pmkid is set). Then, pass the params->pmkid to the
> > firmware (without it, the firmware caches a garbage PMKID on successful
> > authentication and denies a subsequent association request that include=
s
> > the PMKID).
> >
> > Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>
>
> I always get a bit confused when people use different email addresses to
> send and sign-off patches.
>    > ---
> >   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c   | 8 ++++++-=
-
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > index ce09d44fa..cca53ff19 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > @@ -23,6 +23,8 @@
> >   #define MGMT_AUTH_FRAME_DWELL_TIME  4000
> >   #define MGMT_AUTH_FRAME_WAIT_TIME   (MGMT_AUTH_FRAME_DWELL_TIME + 100=
)
> >
> > +static atomic_t brcmf_cyw_mgmt_tx_id =3D ATOMIC_INIT(0);
> > +
> >   static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
> >                                struct cfg80211_crypto_settings *crypto)
> >   {
> > @@ -155,7 +157,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct w=
ireless_dev *wdev,
> >
> >       memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
> >       memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
> > -     mf_params->packet_id =3D cpu_to_le32(*cookie);
> > +     mf_params->packet_id =3D cpu_to_le32(atomic_inc_return(&brcmf_cyw=
_mgmt_tx_id));
>
> As I understand things the cookie value here is an output parameter. The
> driver should assign it:
>
> +       *cookie =3D atomic_inc_return(&brcmf_cyw_mgmt_tx_id);
>         mf_params->packet_id =3D cpu_to_le32(*cookie);
>
> >       memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
> >              le16_to_cpu(mf_params->len));
> >
> Regards,
> Arend

