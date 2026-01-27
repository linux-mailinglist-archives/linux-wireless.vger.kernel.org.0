Return-Path: <linux-wireless+bounces-31198-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAwsOWI5eGmmowEAu9opvQ
	(envelope-from <linux-wireless+bounces-31198-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:04:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026C8FC93
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4514A300B443
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A93191D8;
	Tue, 27 Jan 2026 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddpipc3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186903191AC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486688; cv=pass; b=WcEqQfiGXSbOzSgxshrHdFxlZkPIyMX7ZIJkfVlaQnAA8dsR96T//i6J1hKA/kkkKRjwC2Got9m4ZXsR0TzB1odemnkKYl0EGOUBSaa30Y4Npoev9qVrF3kXJotk1Oy29NIy5TtS3UJvM3QWImvglODwCxUt1+a6o4Vqn2Sx9bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486688; c=relaxed/simple;
	bh=VINbCF2HXdEABxAxhSqVvLNP3F/sSc/MoKoEGXH77is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovza+mfPK9ve834kUDntrEYKns6bY4sT20iA6noi+CSUaApwceWK/hbB8fRiPMFqyjq84eyows02aV996NEPxn/H8H0KydCQsVIaZIg5+UaRG4x8GMVEyejhjVGyqqkIxrsXaltyc8vC66qIA0G0BVIqRg6S11To0/BnXOlb9pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddpipc3x; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07fac8aa1so38721615ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 20:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769486686; cv=none;
        d=google.com; s=arc-20240605;
        b=PaGxQNBHDwkfpozJ9u/Bi9doTITBazZB24TwWaPax7kuNW5Ue9MHkk5CvMW9httWAo
         MIUrYpOv2oWC1yeo0VGIGRdny30bdDQPTsSa9ZNXzLIXAWoJo5sFgJ4m/LMdznst3Z/p
         AMRG0agFAFSt9zUxplLp4Dr3rB+o4pZYfIsNSDFTOfTYNADTFxlybVcRvtmGmyypTDPb
         X1nFM7aUyXPcDX5r7spuA1neg+9TqcvvrWqqRlA7ojmoJvRNH6UOu63ook7lx/3sWSpW
         PGVOWbHgtbW+t8tB9e9SHbukwTVQtUMjCsL71CQ3MIJYdRhON0EDlJA+6x6tjMquEB1T
         tOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NlII7TAXZebUu1p/KKdfJCc4A2tlDtBUvsS8b+u0co=;
        fh=EaNd6h/7/C2cBcLFTM2t3MApuZ8nKo89XT+AxbLP7kU=;
        b=STnhtFpZuNb+Bm9f1AgAvoIOL30sg6xGXHh4iKfRbHTMDNrkgBTYqEMcDmsJDrPpQJ
         OWptfeiOLJxwuN9tj8q7ssu8UCUYCW07V5A6uuVA/QmRp54HR+OlsG68JnvjFfKSnK/w
         Da76fdnOTRJ8JsuUGtCzOHugiGxFLgMQwYDQJ+YF4zwI3YkXw8ZjdlulT8MYipLozUm0
         IwF0giEJd5h0ftjUocdIW1plop9KOL0XySplFw906PVSdF7/zaucyhZKppD3k80IoW8r
         D/Lh7oGd0m90Qh7MZNKs/O5cmTy5Pztrn0BXPzVWDyKzNBVgHxy6HMnNlb47QVStMPTM
         Bp2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769486686; x=1770091486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NlII7TAXZebUu1p/KKdfJCc4A2tlDtBUvsS8b+u0co=;
        b=Ddpipc3xeN3DmlPPXz3QZMgenmsg6n1o+86WWaWFhAhmZ0f8SnBmAFQDCSoEacBNDn
         hc9UpTqj0wLRVL6fLKaZCFPAHXJpDY4dJu8Jf8Z32dJvbD81U0bPSr/JM3bGv6IEh2/V
         b2g+DfAR3wmYhCMH9IOtIePJHtcrwdD2IHlzE+pBEl1dZEX2jDbAgZa4Z42yJJ6YcnZi
         lb3quvSLYOYppmHfvKbtCOOqnzdo0A7oZhKw1XRXGvMZssQPKayK5TXjVOugC99wpLUl
         sxk2OOd4oYsoKZfko2QfcuZceLNJ/ruRFVG6wjbw5OqpEn+ha/f+SIU1zLUVW/QDj8Ix
         ac5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769486686; x=1770091486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NlII7TAXZebUu1p/KKdfJCc4A2tlDtBUvsS8b+u0co=;
        b=QNGep0WzKqsbj5O6K7vybbDm6dGEzj59u9AMwKoldRZPgsKfdoH+KFT9t2WKivG1KY
         wqFvKFJHe/Qxoai4Rv9sg+DPGq+fviAZDcPN4q8PgcEtBwvMvQN9MF4zvuCWxrXdis4P
         479eU26twnYhItTBrGUmleJsHl8ZeA43fa/lsiPMTgoJvrxpPpR0zuzG7XwuVW/aMCjO
         VcuuwEysHnBHsbU7U7JCunMdekQHUO7RiGjI5sypRSgQaGrs/YhzdfDDYGyR53Wt9Rrj
         x/iuAd3Mh5glG+GtS341QZXQacH92Ja0qDXqfUA2g5tahFGGDOTcLJ7yIrC+bkeONeTZ
         4etQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa4fBP7FDw3AcziH9xFJa2b0QdmADu5hAECyBN/B/qxI8yPCYkm4mBMQEi0ZlUi+3m6cF6mFKxlNpA4X6QuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jo/sOAnMgqGWbTnhz3FpiFKFB9sNn6uWF7SYw6rRR0PBiH1T
	MgwbesfSLOy/RLOuLXrXcDouLfsyN5JD4cuwRfl9taY1N0CTkTfSvtSnlbz4u8nWTkQQvstsNUC
	hcPFz74CScu7DmgKSKUvxDdPhSdfacDM=
X-Gm-Gg: AZuq6aIya9CJ+o1yw/8gyIICMBI4tgb62wticmqBgz0YcZQub+lxuZt2A8Hf2Hc7C/D
	r5HyAwllrlCwdydkVfl1ncLAdGXzhquLrl/zXv5oBNGVKlfGpysLZjXmqkEAa8cKwK2oZws6yEl
	I1TnBrsQWiDTj35HwgFT48ohA9I5UfKKs1/29/lyITl5dZxG1u2dYTKe7e1N25C0mT7+pIP9h0j
	OfPsFlJHqLE4bO79cipqukbw4/dhIFV+15WbCXp79g3bTxMyv5P9BfxrbCgA8d/IpHfiOBlVQce
	5Qv6La3/fgSSii7MVecOGbo7j8Zy
X-Received: by 2002:a17:902:da82:b0:2a1:3e15:380e with SMTP id
 d9443c01a7336-2a870dc88aemr4512735ad.34.1769486686171; Mon, 26 Jan 2026
 20:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-2-bjsaikiran@gmail.com>
 <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com>
In-Reply-To: <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Tue, 27 Jan 2026 09:34:34 +0530
X-Gm-Features: AZwV_Qh_KtUjPrbR6pKqraFjqNXJOMwM-O9Veq8b69C6AaKOjsHboDih_EcVer0
Message-ID: <CAAFDt1sgAC6bHOVtELmcQVx=L1dTXDsQFtO+N3R_C2C35VOxhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] wifi: ath12k: Remove frequency range filtering for
 single-phy devices
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31198-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8026C8FC93
X-Rspamd-Action: no action

Hi Baochen,

I checked the logs again.

The issue seems to be coming from how
[ath12k_regd_update()](drivers/net/wireless/ath/ath12k/reg.c) handles
frequency range updates for this device. WCN7850 is a single-phy
device (single [ar](drivers/net/wireless/ath/ath12k/mac.c) that
supports both 2.4GHz and 5GHz/6GHz.

In ath12k_regd_update():

1. It updates the range for 2GHz capabilities (sets range to ~2.4GHz).
2. It then attempts to update for 5GHz capabilities.
3. Because `ar->supports_6ghz` is true, it uses the 6GHz path logic.
4. However, `ab->reg_freq_6ghz` appears to be uninitialized/invalid at
this stage (possibly due to regulatory init timing or country code
issues, On Lenovo Yoga Slim 7x, SMBIOS does not seem to provide a
valid country code. The driver attempts to set an invalid country code
which the firmware rejects. This inturn triggers this issue. Fixing
SMBIOS parsing/defaults is a separate, complex issue that varies by
vendor.), causing the 5GHz range update to be skipped or invalid.

[ 11.699027] ath12k_pci 0004:01:00.0: Failed to set the requested
Country regulatory setting
[ 31.111995] ath12k_pci 0004:01:00.0: Failed to set the requested
Country regulatory setting

As a result, `ar->freq_range` remains effectively set for only the 2.4GHz b=
and.

When ath12k_reg_update_chan_list() runs:

It compares 5GHz channels (e.g., 5180 MHz) against a
[freq_range](drivers/net/wireless/ath/ath12k/reg.c) that only covers
2.4GHz.
Result: `center_freq > end_freq` is TRUE -> Channel is filtered out.

The filtering logic added in acc152f9be20 works for split-phy topology
where each host ar covers a specific range. For WCN7850, where a
single host ar covers disjoint bands (2.4G + 5G), [freq_range] but
[freq_range](drivers/net/wireless/ath/ath12k/reg.c) (start/end) cannot
represent multiple disjoint bands at the same time.

Removing this driver-level filter allows the firmware (which knows the
true capabilities) to handle the channel list correctly.

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 8:52=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/26/2026 5:52 PM, Saikiran wrote:
> > The frequency range filtering added in commit acc152f9be20 was designed
> > for split-phy devices where multiple radios with overlapping frequency
> > ranges within the same band are combined into a single wiphy. Each radi=
o
> > in such setups handles only a subset of channels within a band (e.g., t=
wo
> > 5GHz radios covering 5GHz-low and 5GHz-high separately).
> >
> > However, this filtering breaks single-phy devices like WCN7850 that use
> > a single radio to handle both 2.4GHz and 5GHz bands. On these devices,
>
> To be accurate, WCN7850 still gets two phys in hardware, it is just in ho=
st that we treat
> it as single.
>
> > the freq_range is set to cover the entire supported spectrum, but the
>
> exactly
>
> > filtering logic incorrectly restricts channels, causing 5GHz to become
> > completely unusable.
>
> how? what are the actual values of freq_range when you hit the issue and =
how are they
> calculated?
>
> >
> > The issue manifests as:
> > - All 5GHz channels filtered out during channel list updates
> > - No 5GHz SSIDs visible in scans
> > - Only 2.4GHz networks functional
> >
> > Remove the frequency range filtering entirely and rely on the firmware
> > to handle frequency restrictions based on actual hardware capabilities.
> > This approach works correctly for both split-phy and single-phy devices=
,
> > as the firmware has complete knowledge of what the hardware supports.
> >
> > Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-phy =
devices in single-wiphy")
> > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x=
)
> > Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wirele=
ss/ath/ath12k/reg.c
> > index 7898f6981e5a..48c362a86524 100644
> > --- a/drivers/net/wireless/ath/ath12k/reg.c
> > +++ b/drivers/net/wireless/ath/ath12k/reg.c
> > @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar,=
 bool wait)
> >                       if (bands[band]->channels[i].flags &
> >                           IEEE80211_CHAN_DISABLED)
> >                               continue;
> > -                     /* Skip Channels that are not in current radio's =
range */
> > -                     if (bands[band]->channels[i].center_freq <
> > -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> > -                         bands[band]->channels[i].center_freq >
> > -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> > -                             continue;
> >
> >                       num_channels++;
> >               }
> > @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar,=
 bool wait)
> >                       if (channel->flags & IEEE80211_CHAN_DISABLED)
> >                               continue;
> >
> > -                     /* Skip Channels that are not in current radio's =
range */
> > -                     if (bands[band]->channels[i].center_freq <
> > -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> > -                         bands[band]->channels[i].center_freq >
> > -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> > -                             continue;
> > -
> >                       /* TODO: Set to true/false based on some conditio=
n? */
> >                       ch->allow_ht =3D true;
> >                       ch->allow_vht =3D true;
>

