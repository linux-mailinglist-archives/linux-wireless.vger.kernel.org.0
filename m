Return-Path: <linux-wireless+bounces-31327-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEXYC3Npe2lEEgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31327-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:06:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C9B0AE9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96937300D357
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B53806A8;
	Thu, 29 Jan 2026 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzgzp+l7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AA3081D2
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695591; cv=pass; b=K8SexsVhfT06IRqgOdUTDT52iehpSVUbfaEOoEptxzkqNIaHSGbM6ePYmo4/VqiyzYSk4uBsxyiupanFNV2A0habjAdZ/FVhBPCrtDKw8B+Kjd+P/aIFPrfi2MMAHLXVYOohW0m31aMcWEzQZYPtvtlnvq8M8cw+pc55VyGeOs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695591; c=relaxed/simple;
	bh=OYBgHyNokWWDYIFiut4ACHNoNBQrkQkp6vdiTPUBN04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0XLq3J2/sREf5ewxltkqc4BX/Nx9oqZ38h7w2nZ08tsaQSlfQe97N9Jcr9oeRuoWgXPoH0d1FTsusz+ECCnWF1kldoy52jZ3HWnDqXh/LqXcWCku6GLz7Eex2EkJjMoe2iYm4b4G2nJl/JGFYrFvnberSXHos8pfqJQYY57ViE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzgzp+l7; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so622796a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 06:06:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769695589; cv=none;
        d=google.com; s=arc-20240605;
        b=Rvy4yvu3Zm6AdAjxM02tcoFy3zDKvXdSWUoMa6HZm8YuF0dfkzyhwu0bXGR5xjvYmi
         7mCPgZ+VLepypptUaMd/uh2WVEi1qC2dd/31IKCs4o/xxt1ZPcUVpdhMRHoAh062CkQ9
         qqHfOS94D3C35SEWKXCgUk+UnJ9Bs1yzXVy5iiL5TqnRp9ksmHpIoejEqYmwIBgCpuNK
         kMqj3dCzOxWVsWHcsyRAKG3wJkI3BuUlARQPRZfzwF8KGAzHrI4ufTCYjQE4IkmFra7n
         G5xjlCCi/s+StqKI1cF4F7eUqowt+PPsL71Aeyk1FRzAC+TD/SzU7U+7AqDfkBSKfEGo
         rskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RcLENt0AH5rhLcl7Jm2sgoJkBXC9N8ulrINMcIPia5k=;
        fh=9ncy+lnpn11saNTI5ILrhqTLZtWYnGuBHk11j1tMrLM=;
        b=cDlMnVW7WSxtfyogqWYYdvWLUIXmJ1Cd0fwp9ST4Voa8GSF896ri9oLWgsdMAIXWuL
         DUuc/3snqdgMnxjqAIgyRcj+BNY3fQYJ2xQ80rHlaBGGvzDuPgPmvIM83saOTeASA5tU
         KqFclosrvpep6+k6CTb4bRlKN8QSYEcaUhD/0qkJMYuD2LseeSs4K4zp/ZG15J1MLuMy
         m66QouffhLKBSh4uNt/F0/fb4q7Q7CZakuUFD9bTYdRAUWCUdjOF/BKoiUkiLFElRx5g
         ZjlOVrW1jv1RRMrm9rLheDbDOj326qwXtFXYMgoTUsf+Uwhh/1IBqnTms5s4u5P23gIn
         Hbug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769695589; x=1770300389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcLENt0AH5rhLcl7Jm2sgoJkBXC9N8ulrINMcIPia5k=;
        b=Rzgzp+l7rXIFkb3+wWzO6nO0jUhfdqyvvCMgNOdhGUpY3oZSSsg3ceuZ7nLPWhbThC
         ZHiStSWIx5VfAI9wM0jroTTg2NKJAi6Jr/I2bIIYf7XQ/p36Mt5aVj7h8UPS0dRVhaYg
         Mn490Vw7/xqsHvSdCVHmJ05020rnulEnIFymZrNNoiwS9jU9g450nVBH0aS54OltG3bi
         t0VseVoWovneZQ4u0q51yhhFxbEGpFQSX0zaFOyg5KUqANEw0WJYkkUt7g0sbE/UTkWN
         y3fxLpUMEZJ1YjyX1/8/5ZBAUhn6XAFmqE/oQZ9EvoJ0LqiVBAdcA7Nw940OK5oZTbbi
         arrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769695589; x=1770300389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcLENt0AH5rhLcl7Jm2sgoJkBXC9N8ulrINMcIPia5k=;
        b=uOjads3rSdJbZ0BqTk7dyp89UgEeWh1wO8ixfGYQEHZDjJ9PPPSWXm4lV+8E7o6dzl
         biDdpS9ivFh+Apebextuuwo8Tx6WyIdZUC0HJSIxbD237KQTcms3a85scyHjl2BIDvK0
         GmO99EWK7FbxqxfuMdV7Yv5pG8eBRId4aZB5yVvfxHvSWy2SYS5clRla96D2YQRKOvXp
         QjInfqO+IIe8w0y8g0+1iBphP0booLfZ7SWhQMRizjS+1soTy87DV8y6E1Pgxfuw6pTU
         ggtYpGFux5klxwNVEXj8z1unThrwbVfezgeGTW98oFa+kihLMcKHbFbvT8hkUGtWmpPx
         Tkag==
X-Forwarded-Encrypted: i=1; AJvYcCW1TUtLkLcul6h1M93Bjt3r4qtNvrksQA/opWD2o868+/zN/FfqO91bAYrDW28utco6O3/dj5Xv7tbm8OqTgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiB8DEwl4FSfH/GI64UDGtQFyBxJODPgNMm1tfawW8qrdSwUb
	HbFH+ZyD3eorQoTelVQfMMBfV/F9nIT+Mi6qcjZkmkhfbVU4zgODzUrRN4m3jzA3pfNyiFCAd8D
	F8rvqdhUYjntJzZ6dgi8/EMjsaff4E5gxrFm7GU0=
X-Gm-Gg: AZuq6aIM2rGZU+Q7N6qRe0xs4MtZodt1CItGF8s1dHqXdjdeprakc7q2OngNySZpiFB
	1QQzCe2shAEZgi3o18npRtR/GCghoOUt+WKyARRVbt4jh5NNC8c7HT8Am1pD5CMS3kFDOkYgk9f
	UA/1eFvKcmKg5STYvNE1vOwG8myT4mlLkiTiOOhdOUD6o2H2j304WK/6oSUWk4oEnoJawUP9nxA
	JtgS4TMWE7yp8rXNBWmN7X7OFMZdPFnQehSW4+MQMvrnAa997XhuEzlmoFod//7jmNNLkbX+kvY
	w6iB3SILrQWFqGTaTPJmUaKtE2DF
X-Received: by 2002:a17:90a:c88c:b0:340:9cf1:54d0 with SMTP id
 98e67ed59e1d1-353fecca19emr8148301a91.1.1769695589142; Thu, 29 Jan 2026
 06:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com> <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com> <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com>
In-Reply-To: <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Thu, 29 Jan 2026 19:36:17 +0530
X-Gm-Features: AZwV_QhHbNenSWHu850YbkxhJb3eHlb_ZpOB6u7ptj-ZZOVmyFVj8PtOT56zULg
Message-ID: <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31327-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,launchpad.net:url]
X-Rspamd-Queue-Id: D97C9B0AE9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 7:57=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/27/2026 12:40 PM, Saikiran B wrote:
> > I have analyzed the logs and code flow in depth to provide more
> > definitive answers for your questions.
> >
> > The log entries showing the failure are:
> > [  563.574076] ath12k_pci 0004:01:00.0: failed to pull fw stats: -71
> > [  564.575896] ath12k_pci 0004:01:00.0: time out while waiting for get =
fw stats
> >
> > 1. Why are other stats populated?
> > The "failed to pull fw stats: -71" error is not the initial failure
> > but a symptom that appears after repeated operations. The leak happens
> > during *successful* calls prior to this error.
> >
> > Code flow proving the leak:
> > - ath12k_mac_get_fw_stats() sends WMI_REQUEST_PDEV_STAT.
> > - Firmware responds. ath12k_update_stats_event() parses the response.
> > - ath12k_wmi_fw_stats_process() is called, which splices 'vdevs' and
> > 'beacon' stats into ar->fw_stats.vdevs/bcn.
> > - ath12k_mac_get_fw_stats() returns 0 (Success).
> > - In ath12k_mac_op_get_txpower(), the check `if (!pdev)` fails if the
> > pdev-specific list is empty (but vdev list is NOT empty).
> > - The function exits via `err_fallback` WITHOUT calling ath12k_fw_stats=
_reset().
> > - Result: The 'vdev' and 'beacon' stats that were spliced into
> > ar->fw_stats remain there, leaking memory and accumulating with every
> > call.
> >
> > 2. Exact place where -71 is printed:
> > The error "failed to pull fw stats: -71" is printed in
> > [ath12k_update_stats_event()](drivers/net/wireless/ath/ath12k/wmi.c).
> > It corresponds to "ret =3D ath12k_wmi_pull_fw_stats()" returning -EPROT=
O.
> > This propagates from
> > [ath12k_wmi_tlv_fw_stats_data_parse()](drivers/net/wireless/ath/ath12k/=
wmi.c),
> > when buffer validation checks (like `len < sizeof(*src)`) fail.
> >
> > Conclusion:
> > The fix in my patch (resetting stats when `!pdev`) is critical because
> > it ensures that the accumulated 'vdev' and 'beacon' stats are freed
> > even when the 'pdev' list ends up empty.
> >
> > Let me know if you need anything else.
>
> can you please try below to see if it can fix your issue?
>
> https://lore.kernel.org/r/20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d=
5@oss.qualcomm.com
>
> >
> > Thanks & Regards,
> > Saikiran
> >
> > On Tue, Jan 27, 2026 at 9:47=E2=80=AFAM Saikiran B <bjsaikiran@gmail.co=
m> wrote:
> >>
> >> Hi Baochen,
> >>
> >> Regarding your questions:
> >>
> >> "Are other stats populated?"
> >>
> >> Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
> >> firmware response was received and valid WMI events were processed.
> >> The firmware response to WMI_REQUEST_PDEV_STAT typically includes
> >> multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
> >> "pdev stats" list ends up empty (e.g., due to specific filtering or
> >> availability), the firmware should have populated other lists (like
> >> vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
> >> these valid entries leak and accumulate.
> >>
> >> "Where exactly is -71 (EPROTO) printed?"
> >>
> >> The log "failed to pull fw stats: -71" is printed in
> >> ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
> >> code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
> >> where it is returned when buffer validation checks fail (e.g., if (len
> >> < sizeof(*src))). This failure suggests that the accumulated state or
> >> memory corruption from the leak eventually causes the parser to fail
> >> on subsequent events.
> >>
> >> So, fixing the leak is necessary for correctness regardless of the
> >> specific side-effect error code.
> >>
> >> Thanks & Regards,
> >> Saikiran
> >>
> >> On Tue, Jan 27, 2026 at 8:57=E2=80=AFAM Baochen Qiang
> >> <baochen.qiang@oss.qualcomm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 1/26/2026 5:52 PM, Saikiran wrote:
> >>>> The commits bd6ec8111e65 and 2977567b244f changed firmware stats han=
dling
> >>>> to be caller-driven, requiring explicit ath12k_fw_stats_reset() call=
s
> >>>> after using ath12k_mac_get_fw_stats().
> >>>>
> >>>> In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succe=
eds
> >>>> but the pdev stats list is empty, the function exits without calling
> >>>> ath12k_fw_stats_reset(). Even though the pdev list is empty, the fir=
mware
> >>>> may have populated other stats lists (vdevs, beacons, etc.) in the
> >>>
> >>> 'may' is not enough, we need to be 100% sure whether other stats are =
populated. This is
> >>> critical for us to find the root cause.
> >>>
> >>>> ar->fw_stats structure.
> >>>>
> >>>> Without resetting the stats buffer, this data accumulates across mul=
tiple
> >>>> calls, eventually causing the stats buffer to overflow and leading t=
o
> >>>> firmware communication failures (error -71/EPROTO) during subsequent
> >>>> operations.
> >>>>
> >>>> The issue manifests during 5GHz scanning which triggers multiple TX =
power
> >>>> queries. Symptoms include:
> >>>> - "failed to pull fw stats: -71" errors in dmesg
> >>>
> >>> still, can you please check the logs to see at which exact place is t=
his printed?
> >>>
> >>>> - 5GHz networks not detected despite hardware support
> >>>> - 2.4GHz networks work normally
> >>>>
> >>>> Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
> >>>> ensuring the stats buffer is properly cleaned up even when only part=
ial
> >>>> stats data is received from firmware.
> >>>>
> >>>> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller=
-driven")
> >>>> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> >>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim=
 7x)
> >>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> >>>> ---
> >>>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wir=
eless/ath/ath12k/mac.c
> >>>> index e0e49f782bf8..6e35c3ee9864 100644
> >>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >>>> @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ie=
ee80211_hw *hw,
> >>>>                                       struct ath12k_fw_stats_pdev, l=
ist);
> >>>>       if (!pdev) {
> >>>>               spin_unlock_bh(&ar->data_lock);
> >>>> +             ath12k_fw_stats_reset(ar);
> >>>>               goto err_fallback;
> >>>>       }
> >>>>
> >>>
>

Hi Baochen,

I tried applying your patches on top of v6.19-rc7 (which is the latest
mainline release candidate I'm testing on), but I ran into build
issues because some of the dependencies seem missing.

Specifically:
Patch 2 ("wifi: ath12k: fix station lookup failure when disconnecting
from AP") uses `ath12k_link_sta_find_by_addr()`, which does not exist
in my tree. It seems your patches are based on a different tree
(ath-next?) that has newer changes not yet in the mainline.

Could you please point me to the specific git repo/branch you are
using? I can try to build and test on that baseline to be sure.

Regarding the firmware stats issue:
I verified the firmware files match the latest available (MD5 sums
matched), yet the "-71" errors and memory leak persist on my device
without fixes.

I successfully applied the logic from your Patch 1 manually (since
[ath12k_mac_get_target_pdev_id](cci:1://file:///home/saikiran/linux/kernel/=
x1e/x1e/drivers/net/wireless/ath/ath12k/mac.c:989:0-1008:1)
exists), but I haven't fully validated if it alone resolves the leak
in all scenarios.

However, the fix I proposed in my v2 patch (resetting stats when pdev
list is empty) definitely stops the leak mechanism by ensuring cleanup
happens even when the firmware returns partial stats (which seems to
be the trigger condition).

I'll wait for your pointer to the base tree to do a proper test of your ser=
ies.

Thanks & Regards,
Saikiran

