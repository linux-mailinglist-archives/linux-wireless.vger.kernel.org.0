Return-Path: <linux-wireless+bounces-31165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOTkIs4md2kUcwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:33:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD580857CB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E9823005D35
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49291624C0;
	Mon, 26 Jan 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTIG9onW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C03115B1
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416117; cv=pass; b=VKXd5seWm8fSbEZ7ujf54ewzjMqHtOzg8stsHUYk3euBTvjzO/ZuQ6js6oj3xvk/2alNk/xRqNLfk/VnSJYjP2m9bTM+PfYPGTHsk/cMXgn3NpAN8wX3WfRShBYQ5M/A0OCYdymiS8X9vKwVmhddsvYgLsj9CdfYFd6I3OSd1SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416117; c=relaxed/simple;
	bh=r7fx2BwwrWONMrZG2J6d7tvfNVJ2aYL9BopoEmc+bIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2SDqDO8lYjCczkRth6y62R7NCXOqjtXZD/4wHDuj+L/+AIqzg6AkuKli7t3inU75lZhF5Q7WahxTs0KKZhCxnG5hYs2rvWFDorUyKrBqE2ijQ53RGuBdpHzUgi5tsg9tlPJgziUX4Tff4vuTAjhl9wvewJ7QBabEpvgqG7b4qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTIG9onW; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c634bb5bd8eso675184a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 00:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769416116; cv=none;
        d=google.com; s=arc-20240605;
        b=llrNj29zIcJMMM4FLMmVdXBvtOF7PSSj1W/TznQ+wwq/ajk8rKP8fcy6fTxpKW3MjR
         9gc44XpIUrIVrIy4OvPgDbet56/lmeOlkPfBSXoielFjUW2IIJ8NkAhXgWybLmzhcdz8
         Wf6yxJ2YK9j6Sru5l84fmNfNqKfPHO34s0P1x1nwxnPoI5AlPNi3ctae+n1d6VWykeZQ
         H58NglzMFKhAajhIby5wXZrZCsuPrRyu7AKx6zzryr93LUt6FfK2lEyszHQYs4Oy1GgE
         Tg7zompwDvlhuUQ/KnK0VNmqtntYda6FxLsaOAi3x60EEbeGyEM26dFdZck5f3BSr+9w
         DA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ruwL22SfmrxRUTrjGZVT2uEo930GUbaibVEF86BXitg=;
        fh=8IqWran+IRokyjfa0Fj/u23WsMNyvv5/4Oe8SFLMM1s=;
        b=h5VzdjkPTm7xoJCp4cryZxktRDkB+Qmx1tUaPhhW6xx0wOg5hkys0RLX+GB8rioHR9
         UqExDfBUaqeJbLr1uSLh8t7O2bJvgpGVim7D7CkllhpoyYY62Dz0Az6bXRceP0wZ0sB5
         xYLn6qHojaJaE2o6j5owpHkc8KlLQD6XYmWQfB0eHhupfFLkjBuKKtNTcAdnk0UDDYPT
         idKHzml36T4oxXPyXS6u2cPi4EP/lXMwLxFajXAaXImYYpocq4M3i7fSvLK1fMSIt0wq
         oh3kxotfxQZHaxfcK1YnYnLntFxvfFExZUGkw/tQXvfc73fugNWR28vq5TTNFpWp+zZQ
         U2YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769416116; x=1770020916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruwL22SfmrxRUTrjGZVT2uEo930GUbaibVEF86BXitg=;
        b=cTIG9onWvSWFSO/Dp+woHCyJCiCJyXWL0vCfEO1paiXPNaWPtvpSDNx/l/YiNX40Sw
         NC/3lkXUdVyiQUFDhWqSNpdeChzLugGIOE746OvUJEf0ug3mSO+tB1qnxmXwHkrkhJaR
         0OYBhES1p7h6oXi494rKlGr4DN96xjAXVxUtOmkEBfpBXF4T1DIKGiJoytEYj9ObPfSD
         T1AHrdlgra8uVYlMtPxjF+J+ho3PSIAvJWxnHHdUtgi/dvI/lJmLl3DrThtaxNZhSklW
         7CxMSVwIkg2mtdo2RaszHc8od28KySFQ3WUB7dnjR+/jMTEuX02z21l3MQBNiDxC/NaD
         2rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769416116; x=1770020916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruwL22SfmrxRUTrjGZVT2uEo930GUbaibVEF86BXitg=;
        b=XyRmAz3a7ojfdFqfvoMiU9QMb1pTl0fRBkaOBFwVEcWBE1TDayLBkfKwPfb6v8FfHp
         vXuFcLP6HrvCXGR3eSf5rOjPPJ9kocECx671vDlch6sAUmszvFt56iVkfMum9felkMAU
         yZR/ZHfB38QTICIw1NL/GxcakALbFi9JszL89FpadyVg4V/ggWa6ZanbX+eb1s6ZwNPF
         1lXc1HTNWgAULp2eCC5UzqdSOMJKOc7aYRIaYa9ug7MXoNkO9wliNwFXqDPm0lqTmGJu
         WdaB9VFJwZKeFh0BD0FTtgcLO9QI3I3UIuaGxmZihG9P4i7M8GyxU8Um4rHcRFDQUIZd
         ricA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNBUZAy2Is3ovvp4Dl8Xr7lorW7ctgByQEcmmaYMBz2i4Rvj1zBMkvsWt143qp3jQQgoBAnDU4eopKVdB7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6q3VqY5UhejftRLdSWFewslsNczauWuGMiSvmJwY2Xs3oXozj
	Es/j8UDTfjIDWuV2TwyGLjHwQ5lkExbZ+ZAcczpGXKUvCyVbFlRAKFdEaDGpclwOOa91aZygXi0
	BTXJwdS8barrn75aikoJsVZPlBPzORl8=
X-Gm-Gg: AZuq6aLrNGmip+93lkAeElTecry30w7CH2QFBvgGjULMzVmEUC6UKYWe5dcHMq+iFkw
	xQ2f3sTkmnJQYZQRgc07n0TJeGK9msDcgD6XYX2pvqtvOYRRicXa6WzDqMn+PKyppuwVDIeBCbp
	gcyrEMjkxMv3ROrrcT7aGnMC3RX7Bbbh+jTW867LfxGMde71NL9Kl8zN7LwNxygr6o7b8eOngsk
	1ZiApPwN+2cQ5/zv+gHZnTdAyO0L/HbTONQymeVoPF4aURFVCGCbuvKIeuCOFr8W+SV5UKK71TE
	UVB7hrF5+OSnF/I/A3kIcDTlNv1T
X-Received: by 2002:a17:90b:1c01:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-353c41885abmr3255851a91.27.1769416115449; Mon, 26 Jan 2026
 00:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123155750.6007-1-bjsaikiran@gmail.com> <20260123155750.6007-5-bjsaikiran@gmail.com>
 <ec1a3721-a17c-47dc-85d3-0e0b97004c2c@oss.qualcomm.com> <CAAFDt1syi0jLvrho4mnvwsv8HtraT78wP8tCLFHRw3oiTq2E5w@mail.gmail.com>
 <ad7a2168-58d8-4afa-8744-84a34a63cd09@oss.qualcomm.com> <CAAFDt1v-CBHPTMHQB2B9o3X547agCj77RF9tpp_sgUAPkUaYSw@mail.gmail.com>
In-Reply-To: <CAAFDt1v-CBHPTMHQB2B9o3X547agCj77RF9tpp_sgUAPkUaYSw@mail.gmail.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Mon, 26 Jan 2026 13:58:24 +0530
X-Gm-Features: AZwV_QguPEtYHp3uC-OUaC0C2KVuNA5vvGUniFry68WwZ_WU_sC8ylxoTS_bfJM
Message-ID: <CAAFDt1t8tEd_oH_MLdsr9wgDC82Ae_QSD2kgYA8VwGE0Yia8LA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath12k: Remove broken frequency range filtering
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31165-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD580857CB
X-Rspamd-Action: no action

Hi,

After further testing, I've found that the issue is simpler than I
initially thought.

The Real Problem:

The frequency range filtering was added in commit acc152f9be20 for
"split-phy devices" (devices with separate 2.4GHz and 5GHz radios).
However, WCN7850 is a single-phy device that handles both bands on one
radio.

When the filter runs on WCN7850, it incorrectly restricts channels
because the freq_range is set for only one band at a time, causing the
other bands to be filtered out entirely.

Testing Results:
I tested two approaches:

1. Adding a conditional check (skip filter if freq_range.end_freq =3D=3D
0) - This did NOT fix the issue
2. Removing the filter entirely - This DOES fix the issue, 5GHz works perfe=
ctly

Conclusion:
The frequency range filtering is fundamentally incompatible with
single-phy devices like WCN7850. The firmware already handles
frequency restrictions based on hardware capabilities, so this
driver-level filtering is unnecessary and breaks single-phy devices.

I'll send a V2 that removes the filtering entirely, with an updated
commit message explaining it's designed for split-phy devices and
breaks single-phy devices, If that's ok.

Thanks & Regards,
Saikiran

On Mon, Jan 26, 2026 at 12:33=E2=80=AFPM Saikiran B <bjsaikiran@gmail.com> =
wrote:
>
> Hi Baochen,
>
> Sure.
>
> The Scenario:
> The ath12k_reg_update_chan_list() function filters channels based on ar->=
freq_range. However, this function can be triggered via a regulatory notifi=
er while ar->freq_range is temporarily uninitialized (zeroed).
>
> The Execution Flow:
>
> - Reset: ath12k_regd_update() starts and resets ar->freq_range to 0 (to p=
repare for recalculation).
>
> - Trigger: ath12k_regd_update() calls regulatory_set_wiphy_regd(), which =
triggers the regulatory notifier to other subsystems.
>
> - Race: The notifier callback executes ath12k_reg_update_chan_list().
>
> - Failure: ath12k_reg_update_chan_list() sees ar->freq_range.end_freq =3D=
=3D 0. The filter check (center_freq > end_freq) becomes true for all chann=
els.
>
> - Result: All 5GHz channels are erroneously filtered out.
>
> - Observation: On the Lenovo Yoga Slim 7x, this hits consistently during =
boot and resume. The notifier fires before the driver has finished repopula=
ting the frequency range in ath12k_mac_update_freq_range().
>
> - Proposed Fix: Since we cannot control the notifier timing, I proposed m=
odifying the filter to skip the check if the range is invalid in my previou=
s mail.
>
> Thanks & Regards,
> Saikiran
>
> On Mon, Jan 26, 2026 at 12:22=E2=80=AFPM Baochen Qiang <baochen.qiang@oss=
.qualcomm.com> wrote:
>>
>>
>>
>> On 1/26/2026 2:35 PM, Saikiran B wrote:
>> > Hi Baochen,
>> >
>> > Thanks for the review.
>> >
>> > regarding ath12k_mac_update_freq_range(): You are correct that this
>> > function eventually updates the frequency range.
>> >
>> > However, on the WCN7850 (Lenovo Yoga Slim 7x), there is a race conditi=
on
>> > during boot/resume. ath12k_reg_update_chan_list() is being executed *b=
efore*
>> > ath12k_regd_update() has finished populating ar->freq_range.
>>
>> could you please elaborate on the race?
>>
>> >
>> > At that specific moment, ar->freq_range.end_freq is still 0. The check=
: if
>> > (center_freq > KHZ_TO_MHZ(ar->freq_range.end_freq)) evaluates to true =
for
>> > all channels, causing the driver to silently drop every 5GHz channel f=
rom
>> > the scan list.
>> >
>> > If I cannot remove this filter entirely, would you accept a V2 that sk=
ips
>> > the filtering if the range is uninitialized?
>> >
>> > Example:
>> >
>> > /* Skip check if regulatory range hasn't been populated yet */if
>> > (ar->freq_range.end_freq !=3D 0 &&
>> >     (center_freq < KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>> >      center_freq > KHZ_TO_MHZ(ar->freq_range.end_freq)))
>> >         continue;
>> >
>> > Without this change (or something similar), 5GHz is completely unusabl=
e on
>> > this platform.
>> >
>> > Thanks & Regards,
>> > Jaya saikiran
>> >
>> > On Mon, Jan 26, 2026 at 11:15=E2=80=AFAM Baochen Qiang <
>> > baochen.qiang@oss.qualcomm.com> wrote:
>> >
>> >>
>> >>
>> >> On 1/23/2026 11:57 PM, Saikiran wrote:
>> >>> Between kernel 6.16 and 6.17, ath12k added frequency range filtering=
 in
>> >>> ath12k_reg_update_chan_list() that filters channels based on
>> >>> ar->freq_range.start_freq and ar->freq_range.end_freq.
>> >>>
>> >>> However, these values are reset to 0 in ath12k_regd_update(), causin=
g
>> >>
>> >> Yes, it is reset at the first, but it get re-calculated later. See
>> >> ath12k_mac_update_freq_range() called in ath12k_regd_update().
>> >>
>> >>> the filter to skip ALL channels:
>> >>>     if (channel_freq < 0 || channel_freq > 0)  // Always true when
>> >> end_freq=3D0
>> >>>         continue;  // All channels skipped
>> >>>
>> >>> This results in no channel list sent to firmware, causing 5 GHz Wi-F=
i
>> >>> to stop working.
>> >>>
>> >>> Fix by removing the broken frequency range filtering. The firmware
>> >>> itself handles frequency range restrictions based on hardware
>> >> capabilities.
>> >>>
>> >>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim=
 7x)
>> >>>
>> >>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>> >>> ---
>> >>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>> >>>  1 file changed, 13 deletions(-)
>> >>>
>> >>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c
>> >> b/drivers/net/wireless/ath/ath12k/reg.c
>> >>> index 2dfcef013277..2d9adc74ac6e 100644
>> >>> --- a/drivers/net/wireless/ath/ath12k/reg.c
>> >>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
>> >>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *=
ar,
>> >> bool wait)
>> >>>                       if (bands[band]->channels[i].flags &
>> >>>                           IEEE80211_CHAN_DISABLED)
>> >>>                               continue;
>> >>> -                     /* Skip Channels that are not in current radio=
's
>> >> range */
>> >>> -                     if (bands[band]->channels[i].center_freq <
>> >>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>> >>> -                         bands[band]->channels[i].center_freq >
>> >>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>> >>> -                             continue;
>> >>>
>> >>>                       num_channels++;
>> >>>               }
>> >>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *=
ar,
>> >> bool wait)
>> >>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
>> >>>                               continue;
>> >>>
>> >>> -                     /* Skip Channels that are not in current radio=
's
>> >> range */
>> >>> -                     if (bands[band]->channels[i].center_freq <
>> >>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>> >>> -                         bands[band]->channels[i].center_freq >
>> >>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>> >>> -                             continue;
>> >>> -
>> >>>                       /* TODO: Set to true/false based on some
>> >> condition? */
>> >>>                       ch->allow_ht =3D true;
>> >>>                       ch->allow_vht =3D true;
>> >>
>> >>
>> >
>>

