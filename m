Return-Path: <linux-wireless+bounces-31244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NomGuMMeWnyugEAu9opvQ
	(envelope-from <linux-wireless+bounces-31244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 20:07:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C595999F5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 20:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70FD300C038
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A42882D3;
	Tue, 27 Jan 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBsstr4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FD324B1E
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540800; cv=pass; b=u7mIj7XPw9nXIPNZGxpQORMVjzhmhpowZRVlcgirS/G+6ir4ewCbSeQ+jXsPk0ZpJJMBaJhVz7wzg7IesUk7vaqruPS3HxwBHh1Bqtz/Cp0EsKXt5w5sL8oDW0/t0eBTZ5e3y8H0Eek9Vhja6wU+s/1ne5ZvGDom07lWq+8+CC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540800; c=relaxed/simple;
	bh=HQI8RxiwHTg0dPUGeVu15A07H/HH04JEywTtMo6qWlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5DINnI6jSd0UaQMl4tu7m60oUZG/s/W1CGEKPMxz8N2e3pYkimlNLTCV6rOc/QvvQOBMJbxAsF2v8BAFBMP3B4IYNE1BtTeYqMjyCIRh7gcciV8CmDwNAPvDEeULfkz90pw0t/WG6igflYmug0WpkNM5nthn+UZ+R5ildSJXd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBsstr4g; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so2708369a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 11:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540798; cv=none;
        d=google.com; s=arc-20240605;
        b=FSgLluxC9gd8fWFx1Y0e0OR1SQz915kDSHCna2HpOMYMOeIA8VQrb4dDiUTlfVTf2i
         T0L4W/eZ5rADtSx4GUsmh9H7gnWxjYN1ZX5TkfXFygWuLNvtryz6GbG9ZdAvM6esNeBl
         HrH13j44Fnm5ev5MCJS7WeWp9w4sSfe72+PQqw1S043Z/9oLYlpBPh0nQ/V+nIPEWUvj
         sYskNynrQnUE97R8r/k41NklE6HSZ8NU2SUD9EF7l9xioFP7CIyQ6OCpCQWDc+huSAeb
         /Va55dzQHCTVfgMGxEcdPswKpnL0RpxWhUD9VWPeBeBZ2b5MYRpGZpjdetw3aYNZxVwZ
         3TLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqDCeOy0NkR8KWr9clGAa5Q3eibWQC5JmdYQ/nRh0CI=;
        fh=cTMrsqLs5487tYq/HBCzKh4AW2OWOkR2cf3u23wtcD4=;
        b=ZCyJEGMVz8XvSEX/j0KejPQl0C93iSvDXyO6jtfibR6d6kQioEFTd7/UhNS6JVyO73
         BigNtP0QreZGFsf8fHVOMU7JOzgR0SzVWJVWNPiXPckjDTD1udMN1RwRxsXZX/5BitXH
         jYeKawbQbst87Z3vK99r9uq7lBNruDXb5CbT4smNvCNxbgwr2u2vufTM1A41s8co8Xvh
         d5ooP72urjwhJvxIjxFHjfoP3/XhmAN1w/GGY75jtI4MhoEVMWqnYn5862jzST7a8pKg
         hNxwRrfWKVcCNBosgs4VsQRH2LJt4rDzJbxZfT7TfEgh5V3f8hhh68FRco3zHQg+eI7E
         rw5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769540798; x=1770145598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqDCeOy0NkR8KWr9clGAa5Q3eibWQC5JmdYQ/nRh0CI=;
        b=aBsstr4g2f80qOST4MeG676Kr9uDuY0N/x8dPB+lk/2YDURy2Rzfsz8jMBpa4TKPsF
         z85hg2B9YJmToiNzru8YnwmWPOIX+7hckqcF5Mw4z5Cn3+STPlV9QS9Itla0putrmGJu
         P41NO7nA7tefGYHSORxix3GF7u05LdWAyWIRhIJXg6fHNFNucp/er5hO11We6VUAaKW3
         j8arzQyqi61aPCyvrcB8WVXjwQJapH/9yN7xLPiqVzdQm+l7M5rrv3AkTUHXIxfQNRO1
         FP7zJ+ivGCf2HUHD9rb7+kGeXw4TlJSinAWt9cH93TvzdgEvycm2wYywm1WjFte2GT/y
         NXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769540798; x=1770145598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqDCeOy0NkR8KWr9clGAa5Q3eibWQC5JmdYQ/nRh0CI=;
        b=TgA5FbQJr9jKEFTV/Ublm8NeHzwaXF39yDhOVa/Kt7E7VmEsft9Kkc2pSryEBCikk4
         zOlbyrEXTAdo2pYr5y2m6mFjbAGZmwr2j5waedXi3PzWcPc0tvM3GASsU2fDgcMznTKy
         0gjxcMekVKKR8LnpInSgrowgp4wOKAYDXSRShhJR0tqP+OxA5r2umE16bU16reb+Sxly
         FbzSBF6XGp8dHwyTSsomKkKeBUiiOGUZFSdwDz+ehA2ZnaMtWOiDx2MDnKEO/pVy2NnR
         LtUvaiP/AHkGdNn64I6O8M2FjXAkiBIw3jIqg7Vqz24/PBCZpu9LRlYL4ntE4U48d3AT
         su1A==
X-Forwarded-Encrypted: i=1; AJvYcCV0JEzulmWrtLFyLZFs9f/0bwGVnNEayvq0lRl1NVR3340GYtqqPR3bT4ZLzvERmQy6zKJYH9PcJL1vRwKFGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTrGeIZg4Dq+cEll2JPA9Z1fHKuf+ofbq/fISczbtschGSrHc
	zI77GU9384QfCjhJ+gkHr3DGbftFkvKd+hOPZ0SDTv6X3wX8s5O8Vy//0kJDszNv4LHtxFk6lb7
	7pW87DKCYK1OnX/J1QEOVdfYZ5M0/gdc=
X-Gm-Gg: AZuq6aJDOMKGqLTtxPrn6yaP82GL9ISfwiNm3+xwKQxlp9pI6rZk6a+TBm7fJA/Ns3/
	MkL9TH8pS8FOlZBoZ4+nfiobtECwJ9MDSTFxXli0V+IiodtUtropbQmmBlcLmkflvMNQAj081uN
	CkOs5afS8A3qWdj90/vkiYmq13PdbGZt0OHhZEo0k1suuqib+19mR3hRd/mT+Bhv3Z31w3qg4wf
	cBTo69vyiCzp8Q/0AOVtbqwbnlFLcanwg5VZqjI9hs8cZ5mvP763dn7oOs5dOnT3l9lABLEsXpH
	z2UWoUxLBxTf2x8Lx6KmOUVsXLPZ
X-Received: by 2002:a17:90b:2dc9:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-353fecc66admr2376922a91.3.1769540797687; Tue, 27 Jan 2026
 11:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-2-bjsaikiran@gmail.com>
 <776ae681-9db7-4051-abe1-07530f87d485@oss.qualcomm.com> <CAAFDt1sgAC6bHOVtELmcQVx=L1dTXDsQFtO+N3R_C2C35VOxhA@mail.gmail.com>
 <45061c9a-6f01-4228-9737-0222b4b49059@oss.qualcomm.com> <CAAFDt1sdE3Wpp5CByTZmBk=YnQxFhAwmbC5XpYaqYq0Wdx547A@mail.gmail.com>
 <d6910fe4-cd35-4696-9a0e-13904f512ff8@oss.qualcomm.com>
In-Reply-To: <d6910fe4-cd35-4696-9a0e-13904f512ff8@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Wed, 28 Jan 2026 00:36:26 +0530
X-Gm-Features: AZwV_Qi8BrT4oM6IqRmCL7ONqWn7IQnL7uODuK0OsfolsKAkjFt-2szuNycaB4U
Message-ID: <CAAFDt1suLtUxPh2EwvZqTQgiysK93gH=sXXWcYE+0d1pnpVxpA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31244-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 9C595999F5
X-Rspamd-Action: no action

Hi Baochen,

You were absolutely right.

I manually updated board-2.bin to the latest upstream version (MD5:
74878...), and 5GHz is now working perfectly without any driver
changes.

It seems the linux-firmware package provided by my distro was just old
enough to miss that specific fix.

Next Steps:

I will drop the "Remove frequency range filtering" patch (Patch 1/2)
since the correct firmware resolves the root cause.

Regarding the "Firmware stats leak" (Patch 2/2): I am currently
testing the new firmware without this patch to see if the -71 errors
persist. If the driver still leaks memory on error paths, I will send
this as a standalone patch.

Thanks for pointing out the firmware mismatch!

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 3:52=E2=80=AFPM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/27/2026 4:58 PM, Saikiran B wrote:
> > Hi Baochen,
> >
> > 1. Here are the MD5 sums from my /lib/firmware/ath12k/WCN7850/hw2.0/
> > (sourced from linux-firmware 20250901):
>
> this is a bit old. Please try the latest board-2.bin from linux-firmware =
repo:
>
>
> commit 1d588f106ceea113c4c650b43d948da5746e704c
> Author: Jeff Johnson <jjohnson@qti.qualcomm.com>
> Date:   Thu Sep 18 11:03:58 2025 -0700
>
>     ath12k: WCN7850 hw2.0: update board-2.bin
>
>     Signed-off-by: Jeff Johnson <jjohnson@qti.qualcomm.com>
>
>
> $ md5sum board-2.bin
> 74878eeb4ea01b8ea6bd19b57c99d702  board-2.bin
>
>
> >
> > 2fa9a691f199b25aafce48967d93c85b  amss.bin.zst
> > 7cd6eb50e9a6ad98e658a53033214c9e  board-2.bin.zst
> > 62c117046e52cb78c922635bea177afe  m3.bin.zst
> > 953ba9719c55664a5d91d99b412caee1  Notice.txt.zst
> >
> > 2. Logs: I realized CONFIG_ATH12K_DEBUG was disabled in my recent
> > build. I am rebuilding the kernel now with the debug mask enabled and
> > will provide the verbose logs in a follow-up email once tested.
> >
> > 3. Regarding the Frequency Logic: While I gather the logs, I'd like to
> > highlight that the issue likely persists regardless of the firmware
> > behavior.
> >
> > The freq_range filter assumes ar has a single contiguous range (e.g.,
> > start=3D5150, end=3D5850). For a Single-PHY device like WCN7850 that
> > supports disjoint bands (2.4GHz + 5GHz), a single start/end pair
> > cannot correctly represent the capabilities.
> >
> > If we set it to cover 2.4GHz, it filters 5GHz.
> >
> > If we set it to cover both (e.g., 2.4GHz to 7GHz), the filter allows
> > everything and becomes redundant.
> >
> > I will get back to you shortly with the logs to confirm the firmware st=
ate.
> >
> > Thanks & Regards,
> > Saikiran
> >
> > On Tue, Jan 27, 2026 at 1:11=E2=80=AFPM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 1/27/2026 12:04 PM, Saikiran B wrote:
> >>> Hi Baochen,
> >>>
> >>> I checked the logs again.
> >>>
> >>> The issue seems to be coming from how
> >>> [ath12k_regd_update()](drivers/net/wireless/ath/ath12k/reg.c) handles
> >>> frequency range updates for this device. WCN7850 is a single-phy
> >>> device (single [ar](drivers/net/wireless/ath/ath12k/mac.c) that
> >>> supports both 2.4GHz and 5GHz/6GHz.
> >>>
> >>> In ath12k_regd_update():
> >>>
> >>> 1. It updates the range for 2GHz capabilities (sets range to ~2.4GHz)=
.
> >>> 2. It then attempts to update for 5GHz capabilities.
> >>> 3. Because `ar->supports_6ghz` is true, it uses the 6GHz path logic.
> >>> 4. However, `ab->reg_freq_6ghz` appears to be uninitialized/invalid a=
t
> >>
> >> Hmm, this seems like a known firmware bug. Are you using the latest bo=
ard-2.bin? please
> >> share md5sum of your firmware binaries under /lib/firmware/ath12k/WCN7=
850/hw2.0
> >>
> >> If you are using the latest, please help collect verbose ath12k dmesg =
log:
> >>
> >> modprobe ath12k debug_mask=3D0xffffffff
> >> modprobe ath12k_wifi7
> >>
> >>> this stage (possibly due to regulatory init timing or country code
> >>> issues, On Lenovo Yoga Slim 7x, SMBIOS does not seem to provide a
> >>> valid country code. The driver attempts to set an invalid country cod=
e
> >>> which the firmware rejects. This inturn triggers this issue. Fixing
> >>> SMBIOS parsing/defaults is a separate, complex issue that varies by
> >>> vendor.), causing the 5GHz range update to be skipped or invalid.
> >>>
> >>> [ 11.699027] ath12k_pci 0004:01:00.0: Failed to set the requested
> >>> Country regulatory setting
> >>> [ 31.111995] ath12k_pci 0004:01:00.0: Failed to set the requested
> >>> Country regulatory setting
> >>>
> >>> As a result, `ar->freq_range` remains effectively set for only the 2.=
4GHz band.
> >>>
> >>> When ath12k_reg_update_chan_list() runs:
> >>>
> >>> It compares 5GHz channels (e.g., 5180 MHz) against a
> >>> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) that only covers
> >>> 2.4GHz.
> >>> Result: `center_freq > end_freq` is TRUE -> Channel is filtered out.
> >>>
> >>> The filtering logic added in acc152f9be20 works for split-phy topolog=
y
> >>> where each host ar covers a specific range. For WCN7850, where a
> >>> single host ar covers disjoint bands (2.4G + 5G), [freq_range] but
> >>> [freq_range](drivers/net/wireless/ath/ath12k/reg.c) (start/end) canno=
t
> >>> represent multiple disjoint bands at the same time.
> >>>
> >>> Removing this driver-level filter allows the firmware (which knows th=
e
> >>> true capabilities) to handle the channel list correctly.
> >>>
> >>> Thanks & Regards,
> >>> Saikiran
> >>>
> >>> On Tue, Jan 27, 2026 at 8:52=E2=80=AFAM Baochen Qiang
> >>> <baochen.qiang@oss.qualcomm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/26/2026 5:52 PM, Saikiran wrote:
> >>>>> The frequency range filtering added in commit acc152f9be20 was desi=
gned
> >>>>> for split-phy devices where multiple radios with overlapping freque=
ncy
> >>>>> ranges within the same band are combined into a single wiphy. Each =
radio
> >>>>> in such setups handles only a subset of channels within a band (e.g=
., two
> >>>>> 5GHz radios covering 5GHz-low and 5GHz-high separately).
> >>>>>
> >>>>> However, this filtering breaks single-phy devices like WCN7850 that=
 use
> >>>>> a single radio to handle both 2.4GHz and 5GHz bands. On these devic=
es,
> >>>>
> >>>> To be accurate, WCN7850 still gets two phys in hardware, it is just =
in host that we treat
> >>>> it as single.
> >>>>
> >>>>> the freq_range is set to cover the entire supported spectrum, but t=
he
> >>>>
> >>>> exactly
> >>>>
> >>>>> filtering logic incorrectly restricts channels, causing 5GHz to bec=
ome
> >>>>> completely unusable.
> >>>>
> >>>> how? what are the actual values of freq_range when you hit the issue=
 and how are they
> >>>> calculated?
> >>>>
> >>>>>
> >>>>> The issue manifests as:
> >>>>> - All 5GHz channels filtered out during channel list updates
> >>>>> - No 5GHz SSIDs visible in scans
> >>>>> - Only 2.4GHz networks functional
> >>>>>
> >>>>> Remove the frequency range filtering entirely and rely on the firmw=
are
> >>>>> to handle frequency restrictions based on actual hardware capabilit=
ies.
> >>>>> This approach works correctly for both split-phy and single-phy dev=
ices,
> >>>>> as the firmware has complete knowledge of what the hardware support=
s.
> >>>>>
> >>>>> Fixes: acc152f9be20 ("wifi: ath12k: combine channel list for split-=
phy devices in single-wiphy")
> >>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Sli=
m 7x)
> >>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> >>>>> ---
> >>>>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
> >>>>>  1 file changed, 13 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wi=
reless/ath/ath12k/reg.c
> >>>>> index 7898f6981e5a..48c362a86524 100644
> >>>>> --- a/drivers/net/wireless/ath/ath12k/reg.c
> >>>>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> >>>>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k =
*ar, bool wait)
> >>>>>                       if (bands[band]->channels[i].flags &
> >>>>>                           IEEE80211_CHAN_DISABLED)
> >>>>>                               continue;
> >>>>> -                     /* Skip Channels that are not in current radi=
o's range */
> >>>>> -                     if (bands[band]->channels[i].center_freq <
> >>>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> >>>>> -                         bands[band]->channels[i].center_freq >
> >>>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> >>>>> -                             continue;
> >>>>>
> >>>>>                       num_channels++;
> >>>>>               }
> >>>>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k =
*ar, bool wait)
> >>>>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
> >>>>>                               continue;
> >>>>>
> >>>>> -                     /* Skip Channels that are not in current radi=
o's range */
> >>>>> -                     if (bands[band]->channels[i].center_freq <
> >>>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> >>>>> -                         bands[band]->channels[i].center_freq >
> >>>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
> >>>>> -                             continue;
> >>>>> -
> >>>>>                       /* TODO: Set to true/false based on some cond=
ition? */
> >>>>>                       ch->allow_ht =3D true;
> >>>>>                       ch->allow_vht =3D true;
> >>>>
> >>
>

