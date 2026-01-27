Return-Path: <linux-wireless+bounces-31212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIPZF0p/eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:03:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE191713
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9163E305B09B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83263161AD;
	Tue, 27 Jan 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbC8924t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C31F63CD
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504294; cv=pass; b=jGeorPWDt4va5kbYl853wKMNpbMc54LSne2uVzv/F7rVJg8nDdq8/Xc2AQfLRByYoGrRKrVhDBwZoYFSdSBFYe9QoHQANtWOlaM9cXQt3+6B9nIl3Msvhq2TItWTF8aZnnDArSHrRJv/PMspYEXXUjUxA+89Z6adY+TLNLvSays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504294; c=relaxed/simple;
	bh=RMHfXBfPJ+X8bZVELlNyO5L4gv4ir1wtTNkGks1IBW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF4mxL5+9R/ngVTqqPX+MbOftvOVTrFXTBXaWy1CCVFbX9R4KoBecbe3KLV2MXy3y/aWXx/YswcaUikA/O2gpERbR5YYlcg1KOte4OiqL2coOotHzrLZajdecpevPdmbraoOgfY0cuWnEorUtsnfxjG7j1FlpDPgtxz7OxiGEJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbC8924t; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c551edc745eso2121136a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 00:58:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769504292; cv=none;
        d=google.com; s=arc-20240605;
        b=lH57EYUCls0NLwNJAMSisN8M118RmSNvoSMrFd+YQavyojEGGBGPqNpAzD1qVrgc9z
         yHpXec0+9Ddhym4GYcUetOV9QEzdxjSqCio4Fu4n/PzUPpseZsYfXSvmSEtDpGR9dYKV
         qbeESAPbYq+9vwl+l7n70QFxJTgA1B39AAzdjLniBcmQ7bFm70Xo2zc0qt72r0Kw/169
         GUw7kInlWoEgejApVpulIfHS4WEaX21PFTQjeSd/9X0TeGieLbPXabh0Y1pXqMWktP+8
         DL7cWfUVryXYI0BVVwSNZfoL5RE7lXUUJqDZAzA041/x7gQ2rrdYdhr647okDuEQ0ePg
         PmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PU4lUQv1xAbHw1WmtS2XtfNJZJXUJbo4VT1ueuu/oCk=;
        fh=yyB3FrU037Aavi2v1QB170c1h9+OC+BX/NyRc7eKSUs=;
        b=kf3YdvOHh+4iqD0Cv76k6Y005E5GDX0KYxUwdk5JRjDNPKRJ2328qjHGVAUgNHB001
         wN7hxbjdbHEYMZeXTHyas9319YO5JO9a2v/QFSu5q/HO66iaWJ5P448FI2kt+QtvPGfl
         UUcGpSIHavuK+g30UWVCGOETRRE5WljcsJw4EW+J/+GyiCyWCmVqKKAXVfneEgTl2SVg
         FYBcSvJ7NsovR8Lpdh7NyglJ4QV1UFw1xJ1rBIRLKPPFjYm8z/teHP2FS8+sOZCgvJT7
         hmrOq1qqRFKSBBv7SqHz8EhOhSUgdUfFjJu+R2k39LENnp+mK0A6YtNSZJCa8WH7gTgl
         ugnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769504292; x=1770109092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU4lUQv1xAbHw1WmtS2XtfNJZJXUJbo4VT1ueuu/oCk=;
        b=gbC8924tS90/mKNK0xJPObrV0ERWhWyIMNG8bzGZHU2A9uaXxJEKI7VCG3ajY8j0hn
         IkuXWXCChaeQYtxvSOlGOikEiQ5Z4aQmvQkeoP+YYCaSpvVhIFhtmSQvTQ3soytc+hxa
         nREChabOeK7Ls6Mj4Jon/uS7ZdFn+M9K//drN9X8ii7J6BwwCwN6ZVTQ4C7WucCPA02m
         RTpgtega+6CnxXvfiyqXIW/uuVOE5LpdiHzmILyywt5YXQfjLng692N/o2zRKmz/F7Ln
         dVGvNK2P2cQ+DDpWqHIjJDHYEvndtuaMjspuVAEEe0jPxeaCHpM/76j46Y4COe1lMEJ5
         83cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504292; x=1770109092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PU4lUQv1xAbHw1WmtS2XtfNJZJXUJbo4VT1ueuu/oCk=;
        b=k3FqvoZ2e9mRfmMnQsmlZO5Z9BjmhAMyhcpBNt6ebBWoTNt/WGF3UfKHc0idqHAhKt
         zsUwyay2X0uhm/dPa7c/57jH7WNGxdp2TjbOtqO4f6U/u/AkamWdjeqU/ePPZ2DUrKVo
         icMwDaKuLHKNrXqsL+9nHa0pn5leTlH/D6BVIC9ahCL1GZbU03IGkga0Q0PXOxDvPRVD
         KMhSMbmuH8mPCI9oqiAq2E+ChB9wmTJDxsXmSxwCNzXiWFJtKTC6pMMPqnGsq7Byv/Jq
         jGlvyrC2KhEAtjQDKagxf+eSewIDudNxBVDnvgDWXBCNF8uNxkNzXQBGq5oZHCkayDyw
         dwkA==
X-Forwarded-Encrypted: i=1; AJvYcCX+R7miKe6eg8ksd78v7AwVcrW0Fm9XDgDxDxg9Ci4sqKETEavHfzISX2NiI9CHtibXaVn50gANhsbSW2yglw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkW1MuCRMAlVCjwq9oEOovFADXNE7dn3aNj4+5IvXGxSZuO8V/
	SlaRCeLcOoSeADAps9XpNjEaYEuBbaQOXCP9DRusDUXEycauYXwJC7O3aq/HOcN6Py9Bvagneo8
	XGQ18UdmaBZY8WUHqv9aWxJawYluL72k=
X-Gm-Gg: AZuq6aLfBKosFEpbD2STaWoV1Ylb7DZRq+kLbtHrp9VzYOFecDF7BihDPkrg7AO2Mf/
	Ha5xDApwoaXphIY9rPxpwvqM15hhChRrUFmVth1oZJQSwggg1r3seT8A/YlalHhwQ1SJrDzTY61
	r3eh0D9NI0lKso43TbtYJ9hnLPj4BJ0gyFV4untg3F0y8I+QV/RDOO2rJ6WwjHXYcDZ4NF8b6Ur
	zWUe5dgnDcdkVXJuGBNyi1L0Jf/7dcjIyF1eyisZ4/iMpdUvivzxQYyrbx1Io7zV6rbOyMSlFJk
	sf58eiijwfGPggOKqhNJTC1qj/4AHU1A0oKfO/4=
X-Received: by 2002:a17:903:2ecf:b0:2a0:9402:2175 with SMTP id
 d9443c01a7336-2a870d613b3mr10649075ad.27.1769504292292; Tue, 27 Jan 2026
 00:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-2-bjsaikiran@gmail.com>
 <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com> <CAAFDt1sgAC6bHOVtELmcQVx=L1dTXDsQFtO+N3R_C2C35VOxhA@mail.gmail.com>
 <45061c9a-6f01-4228-9737-0222b4b49059@oss.qualcomm.com>
In-Reply-To: <45061c9a-6f01-4228-9737-0222b4b49059@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Tue, 27 Jan 2026 14:28:01 +0530
X-Gm-Features: AZwV_Qg1RPufYvgrZ0FZi9GiRAuYpA21EVJ3rHbV9_hVbHAErLSOAhFnJSRuvtc
Message-ID: <CAAFDt1sdE3Wpp5CByTZmBk=YnQxFhAwmbC5XpYaqYq0Wdx547A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31212-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BFCE191713
X-Rspamd-Action: no action

Hi Baochen,

1. Here are the MD5 sums from my /lib/firmware/ath12k/WCN7850/hw2.0/
(sourced from linux-firmware 20250901):

2fa9a691f199b25aafce48967d93c85b  amss.bin.zst
7cd6eb50e9a6ad98e658a53033214c9e  board-2.bin.zst
62c117046e52cb78c922635bea177afe  m3.bin.zst
953ba9719c55664a5d91d99b412caee1  Notice.txt.zst

2. Logs: I realized CONFIG_ATH12K_DEBUG was disabled in my recent
build. I am rebuilding the kernel now with the debug mask enabled and
will provide the verbose logs in a follow-up email once tested.

3. Regarding the Frequency Logic: While I gather the logs, I'd like to
highlight that the issue likely persists regardless of the firmware
behavior.

The freq_range filter assumes ar has a single contiguous range (e.g.,
start=3D5150, end=3D5850). For a Single-PHY device like WCN7850 that
supports disjoint bands (2.4GHz + 5GHz), a single start/end pair
cannot correctly represent the capabilities.

If we set it to cover 2.4GHz, it filters 5GHz.

If we set it to cover both (e.g., 2.4GHz to 7GHz), the filter allows
everything and becomes redundant.

I will get back to you shortly with the logs to confirm the firmware state.

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 1:11=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/27/2026 12:04 PM, Saikiran B wrote:
> > Hi Baochen,
> >
> > I checked the logs again.
> >
> > The issue seems to be coming from how
> > [ath12k_regd_update()](drivers/net/wireless/ath/ath12k/reg.c) handles
> > frequency range updates for this device. WCN7850 is a single-phy
> > device (single [ar](drivers/net/wireless/ath/ath12k/mac.c) that
> > supports both 2.4GHz and 5GHz/6GHz.
> >
> > In ath12k_regd_update():
> >
> > 1. It updates the range for 2GHz capabilities (sets range to ~2.4GHz).
> > 2. It then attempts to update for 5GHz capabilities.
> > 3. Because `ar->supports_6ghz` is true, it uses the 6GHz path logic.
> > 4. However, `ab->reg_freq_6ghz` appears to be uninitialized/invalid at
>
> Hmm, this seems like a known firmware bug. Are you using the latest board=
-2.bin? please
> share md5sum of your firmware binaries under /lib/firmware/ath12k/WCN7850=
/hw2.0
>
> If you are using the latest, please help collect verbose ath12k dmesg log=
:
>
> modprobe ath12k debug_mask=3D0xffffffff
> modprobe ath12k_wifi7
>
> > this stage (possibly due to regulatory init timing or country code
> > issues, On Lenovo Yoga Slim 7x, SMBIOS does not seem to provide a
> > valid country code. The driver attempts to set an invalid country code
> > which the firmware rejects. This inturn triggers this issue. Fixing
> > SMBIOS parsing/defaults is a separate, complex issue that varies by
> > vendor.), causing the 5GHz range update to be skipped or invalid.
> >
> > [ 11.699027] ath12k_pci 0004:01:00.0: Failed to set the requested
> > Country regulatory setting
> > [ 31.111995] ath12k_pci 0004:01:00.0: Failed to set the requested
> > Country regulatory setting
> >
> > As a result, `ar->freq_range` remains effectively set for only the 2.4G=
Hz band.
> >
> > When ath12k_reg_update_chan_list() runs:
> >
> > It compares 5GHz channels (e.g., 5180 MHz) against a
> > [freq_range](drivers/net/wireless/ath/ath12k/reg.c) that only covers
> > 2.4GHz.
> > Result: `center_freq > end_freq` is TRUE -> Channel is filtered out.
> >
> > The filtering logic added in acc152f9be20 works for split-phy topology
> > where each host ar covers a specific range. For WCN7850, where a
> > single host ar covers disjoint bands (2.4G + 5G), [freq_range] but
> > [freq_range](drivers/net/wireless/ath/ath12k/reg.c) (start/end) cannot
> > represent multiple disjoint bands at the same time.
> >
> > Removing this driver-level filter allows the firmware (which knows the
> > true capabilities) to handle the channel list correctly.
> >
> > Thanks & Regards,
> > Saikiran
> >
> > On Tue, Jan 27, 2026 at 8:52=E2=80=AFAM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 1/26/2026 5:52 PM, Saikiran wrote:
> >>> The frequency range filtering added in commit acc152f9be20 was design=
ed
> >>> for split-phy devices where multiple radios with overlapping frequenc=
y
> >>> ranges within the same band are combined into a single wiphy. Each ra=
dio
> >>> in such setups handles only a subset of channels within a band (e.g.,=
 two
> >>> 5GHz radios covering 5GHz-low and 5GHz-high separately).
> >>>
> >>> However, this filtering breaks single-phy devices like WCN7850 that u=
se
> >>> a single radio to handle both 2.4GHz and 5GHz bands. On these devices=
,
> >>
> >> To be accurate, WCN7850 still gets two phys in hardware, it is just in=
 host that we treat
> >> it as single.
> >>
> >>> the freq_range is set to cover the entire supported spectrum, but the
> >>
> >> exactly
> >>
> >>> filtering logic incorrectly restricts channels, causing 5GHz to becom=
e
> >>> completely unusable.
> >>
> >> how? what are the actual values of freq_range when you hit the issue a=
nd how are they
> >> calculated?
> >>
> >>>
> >>> The issue manifests as:
> >>> - All 5GHz channels filtered out during channel list updates
> >>> - No 5GHz SSIDs visible in scans
> >>> - Only 2.4GHz networks functional
> >>>
> >>> Remove the frequency range filtering entirely and rely on the firmwar=
e
> >>> to handle frequency restrictions based on actual hardware capabilitie=
s.
> >>> This approach works correctly for both split-phy and single-phy devic=
es,
> >>> as the firmware has complete knowledge of what the hardware supports.
> >>>
> >>> Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-ph=
y devices in single-wiphy")
> >>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim =
7x)
> >>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> >>> ---
> >>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
> >>>  1 file changed, 13 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wire=
less/ath/ath12k/reg.c
> >>> index 7898f6981e5a..48c362a86524 100644
> >>> --- a/drivers/net/wireless/ath/ath12k/reg.c
> >>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> >>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *a=
r, bool wait)
> >>>                       if (bands[band]->channels[i].flags &
> >>>                           IEEE80211_CHAN_DISABLED)
> >>>                               continue;
> >>> -                     /* Skip Channels that are not in current radio'=
s range */
> >>> -                     if (bands[band]->channels[i].center_freq <
> >>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> >>> -                         bands[band]->channels[i].center_freq >
> >>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> >>> -                             continue;
> >>>
> >>>                       num_channels++;
> >>>               }
> >>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *a=
r, bool wait)
> >>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
> >>>                               continue;
> >>>
> >>> -                     /* Skip Channels that are not in current radio'=
s range */
> >>> -                     if (bands[band]->channels[i].center_freq <
> >>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> >>> -                         bands[band]->channels[i].center_freq >
> >>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> >>> -                             continue;
> >>> -
> >>>                       /* TODO: Set to true/false based on some condit=
ion? */
> >>>                       ch->allow_ht =3D true;
> >>>                       ch->allow_vht =3D true;
> >>
>

