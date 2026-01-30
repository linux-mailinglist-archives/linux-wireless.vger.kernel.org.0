Return-Path: <linux-wireless+bounces-31354-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LS3DLVefGkYMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31354-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:33:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B1B7F27
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3018130125E2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99C0311597;
	Fri, 30 Jan 2026 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8EBGR1Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D430B51F
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758386; cv=pass; b=Y3QyZH6Mjw3fKRKu6iFipq854niI0n18h98FKgb26GncFAY7gsmfFCMk/2E7zdrINO53A96aRlcyORDVxItZSlgSBN6XldwcBZsMcnL6M5otF5IqBqBdgoKOOouI4reAStk+oFY8oTn9Q4ftA7Rqk0NYd805mcM1t2Svs7nHFKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758386; c=relaxed/simple;
	bh=yFgAon7QLCCu9X/iTY5yA6NUtmKLoyNdrdJLAOWK2r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRhxBQyaqIyKKIlgSytp/AQd6Z2O0furYkYpq0AcRRtraCo5LWG/0H0n3PjwUu7hwmyVHBTLC+UmuEgZB+7ma2Ro/uFIWlAuc7/WwCNR9Rv1NApryrzZ2BCS3pApAOB2/YkjVcEQI2o0/u2dNv5cx3h9xxznxGkjyjpT+Yn3Xkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8EBGR1Q; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c47ee987401so749974a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 23:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769758384; cv=none;
        d=google.com; s=arc-20240605;
        b=Hatj/jbs+ndzzolZ2VehC5xQ5JH7heIIAwozTmnorFnG/NBZ6cjRUC9OOZNB+D33X7
         LbVIPxwO3BJko5Sv7PRmjt4tqgb1n+fzjMW3hKAgjQ8zFFgn71f0LyY5Yy2Yw5uVnGrG
         pmSf4qbaUNFtpZY1E/AnnoV55DOKXfy/uro4sHydSIJQ033GKrIDXOFQuckkxT21llQ9
         WLDMsmHF+T1dAVSw2Ex6PNCCi7iUwCrsueEwhSGUuqTCjASq6XW3LnbSLTK8vFDuRBJI
         WeaYfXYzx1dfvS3XFxvtm5iU6YYhWJBuLNQop3T+8I4GoFDv2L0SVnY1+x4TuBjpiMcC
         F+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZgo4czabFDecvZ1XJQzu+KiEWSV57OKqOvlHlgmzmE=;
        fh=lhd3sX5Zu/SvXig70sL+Tkp/afrkgJ/V1B9vAYe0lV8=;
        b=cdm/Ex+kMw0LTI/vaiq2wpOxKZsR4Uu9CROe+lNLUv9zOMNgORLtFZvRTskWTkQD5r
         QyWcDrZABVL2HCy9/adflAoQIhA72ZCgdTm3bmLuNuJUMrlHhQZgo52g94bftignMRR6
         6k7A6gHg8J/rW3wqDvD4cUmCs7thhbLixJ45UXyQd5xvom1fB+JW/OCY28ZFgbM3Axwt
         EmU81iZR3wexk9iC9tmDeJpb8l7WUQCAnYBCLAznaKfgaK2ecyRyk93IVsoDRtkrEg+u
         s5dqmsZqugvXyldY30g/hioFhtK73hEhRIfPHxT5ZwTUQoNmObsdIAH+SoiiJxQcPJF/
         MkwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769758384; x=1770363184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZgo4czabFDecvZ1XJQzu+KiEWSV57OKqOvlHlgmzmE=;
        b=X8EBGR1Q3xa4I7zIbAmxVkWsWfkg17gRtsti69gaimf4EhcKsgjBqhrFflBfcIWLNh
         n5cTfYf64gQ1ly7mMfIgJAynRYRBhRbIPP0Pao4rYOsbsFW6xIyFvJY3tXvc7QBSdosP
         HSOmHHBXmEO0sxwmKduVVvrGf7HYLiCZmRdyZDJvHY81oeKjiTwNA0/62AOneVmIvMFl
         AHF8VxjIv4ubxpAkwqepKoTen5igTJMFWmNH8asbQzJzS8EIN6oef/r5ezUHNrzqCZv/
         M4vlvBh10BQs2z4/6UVz0KRR2wyWUH/SOLWo9elN+DENTfFYcZWuRXUaYEBcb9PO3SFt
         cGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758384; x=1770363184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZgo4czabFDecvZ1XJQzu+KiEWSV57OKqOvlHlgmzmE=;
        b=UbhVfWjZLuN52zGDwD6KDZgB0YmnDppPxRZwxHHWTaDQHI2v67BFU+gRQ7u6vtFSTv
         8D2y+wnFfUAtuOyN3kwv/lNXFukgFyTxXRAkCmaQ6mVp2PLb57H4wzODCD6Gy1+vG0j6
         idyHheVwQIL2OhpYKYB2vr0uekc/GhowcVrUCzwEZqkKncyr3zwFj+swdqdcB36E744k
         tEqN3nRKgHKkrHjh1JHUlsVfuYux7uksJEK2l0n9jZFUcAm2koBPtwR8K6xeV0pQbpI6
         edNMb8WzXXx2L9sJ0PObr7kachjzVo/a6UoGzGWRtwvLNFTQGOSi4Xg0r2gBD3j2V4FB
         gFzw==
X-Forwarded-Encrypted: i=1; AJvYcCVJh2vg5g48RVwyil/0kcGWp8r32RJw4AuDa5K7mKXRTuBNSGt28gAUhdXTbp7kRXaQrfWX1k29BsgQC0N1wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwizNH2v9w96F5XsJ8qGLnefHry+A+mgfYEO4TvAGETDQYSztZj
	whr1LXNCzc36wEg7Ht/In4fpdVaEYytoEbofMo8CpCe8ybgCd3UJFySnhYy/zYioz1hWWvmvbqm
	DtIfXImGCeaIqvLq+wHmewDx59Yt+GKBhMzox
X-Gm-Gg: AZuq6aKQsZEOc83oa9pAyP9c9o2NguyJZfh6CcEX55rTUmcsrg4mPlqUEw5oOkaA1zR
	7t+tj7s3XkVxTOu970AMYdD+dTmzfnsvKdUP8MzloBSV6XhSifqgDsN9osKvf9iQJ9WUP6PcBQe
	vZd2HqekD8maXj2SiU+FgzP8gUlxdjzoCp1Igm9piE6UE6ng0kC5qkqS/Q2j6tXsLfX2b/vkRnt
	pDLVVl3Zn1Y89ESDQWTxzcyxLflC7wod3989nzhDK5KazyHedAPA/4tRNlgqOMEgO1aRONjk+5D
	34ti7YY9xn/f3gNYEl6AY/WhQuzg
X-Received: by 2002:a17:90b:2dcc:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-35429ac7edfmr4608897a91.11.1769758384312; Thu, 29 Jan 2026
 23:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com> <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
 <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com> <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
 <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com>
In-Reply-To: <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Fri, 30 Jan 2026 13:02:53 +0530
X-Gm-Features: AZwV_QgoX3ZhnV6uNxARW-hGvyPBP_Ug1PE8JRNg14ZhkQcHFssPC9IgiaoYG0o
Message-ID: <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	HAS_FILE_URL(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31354-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[home:url,launchpad.net:url,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 813B1B7F27
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 7:39=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/29/2026 10:06 PM, Saikiran B wrote:
> > On Thu, Jan 29, 2026 at 7:57=E2=80=AFAM Baochen Qiang
> > <baochen.qiang@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 1/27/2026 12:40 PM, Saikiran B wrote:
> >>> I have analyzed the logs and code flow in depth to provide more
> >>> definitive answers for your questions.
> >>>
> >>> The log entries showing the failure are:
> >>> [  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
> >>> [  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for ge=
t fw stats
> >>>
> >>> 1. Why are other stats populated?
> >>> The "failed to pull fw stats: -71" error is not the initial failure
> >>> but a symptom that appears after repeated operations. The leak happen=
s
> >>> during *successful* calls prior to this error.
> >>>
> >>> Code flow proving the leak:
> >>> - ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
> >>> - Firmware responds. ath12k_update_stats_event() parses the response.
> >>> - ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
> >>> 'beacon' stats into ar->fw_stats.vdevs/bcn.
> >>> - ath12k_mac_get_fw_stats() returns 0 (Success).
> >>> - In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
> >>> pdev-specific list is empty (but vdev list is NOT empty).
> >>> - The function exits via `err_fallback` WITHOUT calling ath12k_fw_sta=
ts_reset().
> >>> - Result: The 'vdev' and 'beacon' stats that were spliced into
> >>> ar->fw_stats remain there, leaking memory and accumulating with every
> >>> call.
> >>>
> >>> 2. Exact place where -71 is printed:
> >>> The error "failed to pull fw stats: -71" is printed in
> >>> [ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
> >>> It corresponds to "ret =3D ath12k_wmi_pull_fw_stats()" returning -EPR=
OTO.
> >>> This propagates from
> >>> [ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12=
k/wmi.c),
> >>> when buffer validation checks (like `len < sizeof(*src)`) fail.
> >>>
> >>> Conclusion:
> >>> The fix in my patch (resetting stats when `!pdev`) is critical becaus=
e
> >>> it ensures that the accumulated 'vdev' and 'beacon' stats are freed
> >>> even when the 'pdev' list ends up empty.
> >>>
> >>> Let me know if you need anything else.
> >>
> >> can you please try below to see if it can fix your issue?
> >>
> >> https://lore.kernel.org/r/20260129-ath12k-fw-stats-fixes-v1-0-55d66064=
f4d5@oss.qualcomm.com
> >>
> >>>
> >>> Thanks & Regards,
> >>> Saikiran
> >>>
> >>> On Tue, Jan 27, 2026 at 9:47=E2=80=AFAM Saikiran B <bjsaikiran@gmail.=
com> wrote:
> >>>>
> >>>> Hi Baochen,
> >>>>
> >>>> Regarding your questions:
> >>>>
> >>>> "Are other stats populated?"
> >>>>
> >>>> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means th=
e
> >>>> firmware response was received and valid WMI events were processed.
> >>>> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
> >>>> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
> >>>> "pdev stats" list ends up empty (e.g., due to specific filtering or
> >>>> availability), the firmware should have populated other lists (like
> >>>> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
> >>>> these valid entries leak and accumulate.
> >>>>
> >>>> "Where exactly is -71 (EPROTO) printed?"
> >>>>
> >>>> The log "failed to pull fw stats: -71" is printed in
> >>>> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
> >>>> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
> >>>> where it is returned when buffer validation checks fail (e.g., if (l=
en
> >>>> < sizeof(*src))). This failure suggests that the accumulated state o=
r
> >>>> memory corruption from the leak eventually causes the parser to fail
> >>>> on subsequent events.
> >>>>
> >>>> So, fixing the leak is necessary for correctness regardless of the
> >>>> specific side-effect error code.
> >>>>
> >>>> Thanks & Regards,
> >>>> Saikiran
> >>>>
> >>>> On Tue, Jan 27, 2026 at 8:57=E2=80=AFAM Baochen Qiang
> >>>> <baochen.qiang@oss.qualcomm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 1/26/2026 5:52 PM, Saikiran wrote:
> >>>>>> The commits bd6ec8111e65 and 2977567b244f changed firmware stats h=
andling
> >>>>>> to be caller-driven, requiring explicit ath12k_fw_stats_reset() ca=
lls
> >>>>>> after using ath12k_mac_get_fw_stats().
> >>>>>>
> >>>>>> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() suc=
ceeds
> >>>>>> but the pdev stats list is empty, the function exits without calli=
ng
> >>>>>> ath12k_fw_stats_reset(). Even though the pdev list is empty, the f=
irmware
> >>>>>> may have populated other stats lists (vdevs, beacons, etc.) in the
> >>>>>
> >>>>> 'may' is not enough, we need to be 100% sure whether other stats ar=
e populated. This is
> >>>>> critical for us to find the root cause.
> >>>>>
> >>>>>> ar->fw_stats structure.
> >>>>>>
> >>>>>> Without resetting the stats buffer, this data accumulates across m=
ultiple
> >>>>>> calls, eventually causing the stats buffer to overflow and leading=
 to
> >>>>>> firmware communication failures (error -71/EPROTO) during subseque=
nt
> >>>>>> operations.
> >>>>>>
> >>>>>> The issue manifests during 5GHz scanning which triggers multiple T=
X power
> >>>>>> queries. Symptoms include:
> >>>>>> - "failed to pull fw stats: -71" errors in dmesg
> >>>>>
> >>>>> still, can you please check the logs to see at which exact place is=
 this printed?
> >>>>>
> >>>>>> - 5GHz networks not detected despite hardware support
> >>>>>> - 2.4GHz networks work normally
> >>>>>>
> >>>>>> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty=
,
> >>>>>> ensuring the stats buffer is properly cleaned up even when only pa=
rtial
> >>>>>> stats data is received from firmware.
> >>>>>>
> >>>>>> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset call=
er-driven")
> >>>>>> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> >>>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Sl=
im 7x)
> >>>>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> >>>>>> ---
> >>>>>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
> >>>>>>  1 file changed, 1 insertion(+)
> >>>>>>
> >>>>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/w=
ireless/ath/ath12k/mac.c
> >>>>>> index e0e49f782bf8..6e35c3ee9864 100644
> >>>>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >>>>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >>>>>> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct =
ieee80211_hw *hw,
> >>>>>>                                       struct ath12k_fw_stats_pdev,=
 list);
> >>>>>>       if (!pdev) {
> >>>>>>               spin_unlock_bh(&ar->data_lock);
> >>>>>> +             ath12k_fw_stats_reset(ar);
> >>>>>>               goto err_fallback;
> >>>>>>       }
> >>>>>>
> >>>>>
> >>
> >
> > Hi Baochen,
> >
> > I tried applying your patches on top of v6.19-rc7 (which is the latest
> > mainline release candidate I'm testing on), but I ran into build
> > issues because some of the dependencies seem missing.
> >
> > Specifically:
> > Patch 2 ("wifi: ath12k: fix station lookup failure when disconnecting
> > from AP") uses `ath12k_link_sta_find_by_addr()`, which does not exist
> > in my tree. It seems your patches are based on a different tree
> > (ath-next?) that has newer changes not yet in the mainline.
> >
> > Could you please point me to the specific git repo/branch you are
> > using? I can try to build and test on that baseline to be sure.
>
> My bad. Please try the latest ath tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/
>
> the base commit is ath-202601271544 tag.
>
> >
> > Regarding the firmware stats issue:
> > I verified the firmware files match the latest available (MD5 sums
> > matched), yet the "-71" errors and memory leak persist on my device
> > without fixes.
> >
> > I successfully applied the logic from your Patch 1 manually (since
> > [ath12k_mac_get_target_pdev_id](cci:1://file:///home/saikiran/linux/ker=
nel/x1e/x1e/drivers/net/wireless/ath/ath12k/mac.c:989:0-1008:1)
> > exists), but I haven't fully validated if it alone resolves the leak
> > in all scenarios.
> >
> > However, the fix I proposed in my v2 patch (resetting stats when pdev
> > list is empty) definitely stops the leak mechanism by ensuring cleanup
> > happens even when the firmware returns partial stats (which seems to
> > be the trigger condition).
> >
> > I'll wait for your pointer to the base tree to do a proper test of your=
 series.
> >
> > Thanks & Regards,
> > Saikiran
>

Hi,

I have merged the tag, applied your patches and I can confirm that the
leak has been fixed.

Thanks & Regards,
Saikiran

