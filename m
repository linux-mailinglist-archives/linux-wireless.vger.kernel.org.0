Return-Path: <linux-wireless+bounces-31199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGXLGHI8eGnsowEAu9opvQ
	(envelope-from <linux-wireless+bounces-31199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:17:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36C8FD4E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 05:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D923019B8B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946F2F83B7;
	Tue, 27 Jan 2026 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKuQMR24"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E2244692
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487471; cv=pass; b=O3BroRr7ZDXnP+4rzMFmtn6ADrHsC2F/yX7lASoRo+yAvsF6/ZNLHHQ6jSxSNac2fMzW6QcGNsDIHd//Ns7SkP1SYbrwHZHHiDn+IV3r9CwM82G42g8jsAZZNUN1LbWr3z0N6ewxtnBon2nU3eYof4VXWMsXsv+E+lLIECcuBI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487471; c=relaxed/simple;
	bh=y/yz93T80aY9kalhuIheYayWmyTnMyPpsoeaWZgocsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSCbH9YTCHT6wDEAk2Teu5aqdFGfcwW8brKsrg3My2/YDn9hQpTHbd2nFAzPxfSPWWr33fHU35zasdGRtDyDQYiUSGwfAloa6WDKSa/3WTnwskOQciX/Vc8ZGctOI2NYbQuD280hxmA6unF96op/6hY1v2lsPMmEuwuPqncqCjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKuQMR24; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35338b3dd31so2467852a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 20:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769487469; cv=none;
        d=google.com; s=arc-20240605;
        b=Szp5ImMNE+hkJnY0oceUrtVt1VCPFo3OEQiJAkIuSpjiJG4dPGvUxQs9Ds+ajNauy8
         5euMm+KsSDoeN6Jt3+QEgXJjmyJ2I/y0wbRy0Oytk6kB8kMJ8wAwJCy0alxTYbTYPd7R
         I0ZD+pAPX4dEGjo7Plpk3OoibAGmb1U23YzodFN6XJyrKHgF9tGYhED8GdvkuXgoo9X+
         j91no9Jzssy+5BuuVhjBXCixaF0C69S3PUMS9CymUwyAarsxZVugctAQiBU1YQigvJz3
         tsUlbETraHwq2r9qNtxwfvDC2YyDnc4zyiTLknijufUwUtcDKjgG6Lm6o+/L5l4bBTEL
         Be9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prkzLPO3vlrT/dESXtDqaOD9/sG0dfRjFFIi+7EgQzY=;
        fh=O/j8ylcGlV6RLsq9/a1LU3yB1CbPm01JX29hiWR+EsQ=;
        b=Et8IlTJR3p7w8Lq2Xp8PgwLa3LR3NSwXskURQa3TVm7Cahp8J7vlf+S6NVHvFHCQa3
         g/soPhigZpc6Yv3jePpi3NFYrHpaheKlV1Q9T1M7Y1hPoloCANZHtm1TiouZyms9T/FH
         +H0MgCehADusyUiG1itBYV1neanauK+3szJ7Doaj42KKrXzHMkTL4oMNnIrSYUgBipqH
         jfRDdKg8v5B+qA0FAPEjwukUYjWAbkInP8uD+xF8cCH9+GRneaXdBSf7h0zLVngTvgDF
         AxUwfjAD6A49BwnoeTlBoNk/jpwTs5oHPmbcFm7TDtZ3s/qql5VpsWu7DmXO0PoXSW9M
         UwhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769487469; x=1770092269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prkzLPO3vlrT/dESXtDqaOD9/sG0dfRjFFIi+7EgQzY=;
        b=bKuQMR24JSG+nL9Xf8qj29tQS+WKi4UdLV33V2NZc02iPaJyt/gEKDzSZyVXPvs2gm
         X3ELajH+aS9fzxo+Iywlj2m4f5y7mBs3PyjYNVhENJ+mOsIEgQJg2HKwyv2lLSELYLWT
         A/56+m8JwKZtGS8BqnEa82zYAqO65pWt+lY6X0GBMbz43gLkvg0vyUbbryoLgb+b7vL6
         Yby0iHDyfrTS8t5H7tLp+7Yj5x4Py4e1iXE94oClN5kxoBlFqLCH9IDrYoLfGkyByDEd
         OE16q9lLzy0Ldiv+5tVXH7gW/xVgNQsdvQlh10QoOGdlwzfojEiKeE3UYF/heb08t3VM
         wLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487469; x=1770092269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prkzLPO3vlrT/dESXtDqaOD9/sG0dfRjFFIi+7EgQzY=;
        b=guLbBV63tsUA7BV5BdAv+6i/Lg7w8bHX4BC7pzbj+Ja+s8kRQr1tnLeR/RimhesGk3
         971fyL5kORPB+3FmqTGv2ozUeuB6+erZqWFlUwoFohmpbx9XqWhAOtqL9ufpJGE+PeX5
         i2h81kTkEVWzbFFGqu/FXZxfHJ3Nz8jIu/lDnqNZvjiDFCjKKveCb+wzLozTlLzTXCq9
         mM2PLE2U9za9T65lzQvzkzbWoBwTnAnBob6itxCNVgp5u/QmPxZn8iB5NYR+pmKR+Bj6
         FTCldkbIsHHPYXgQp0YBpW0yc4z5AlzGL6JGnrnRDVPjnDslHARKpjHt1nULXj0oZUrB
         uUiw==
X-Forwarded-Encrypted: i=1; AJvYcCWbtmzUK/FsgtKPPZR7ODqL4D/7C8uAOp15L89uZQYfLujWHWiDoM/BeepGdzqRzkj7tZjcG8jEoDgFq0uIQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1slWYI68aJJ6U4jDgQABCjstYGGiEs+CzySuelxJWfnWJjeC
	sSU3Q/NuajCwchS2aFJB5pkDFA5SMoqL2+sac1r4PzoEkPPMRZ/KYceFVEndHGGs1BRtboZTWQU
	V94LNofBhGy6ul9FOkNvaDTmSsz1GCjaT+FUioQ9QkQ==
X-Gm-Gg: AZuq6aL692MAI9MQcqvgU6skS8CqFbMo/fWNOwC8S25SZQ9Q0glLAfb4rhHkkPsMN4A
	3BUE/AK7k6M5ClGdLycKa6oDe9caYPmT7+Xk4JQ2YUauZFqpQ2O5ViPs3zrq+k5AgkcYEco9H3y
	heKu087Pv+RFKBS10M139yiY6EDqfvTGnqGI7czN2K9DTdt4VBWBPBVJUgn32h8EH1DnbjO3xOo
	7CYSMqPYTK/vXAFQsTbMzU8H4RiVZZJ0/NzBWjpAHU0pI5H7htkLtWNdH+vhv+3UAiphlE7h5rz
	VT6jniDn++FfyewCtxgAzaiu0+pT
X-Received: by 2002:a17:90b:1c06:b0:353:2e1:95f4 with SMTP id
 98e67ed59e1d1-353fecdb296mr599117a91.13.1769487469512; Mon, 26 Jan 2026
 20:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
In-Reply-To: <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Tue, 27 Jan 2026 09:47:38 +0530
X-Gm-Features: AZwV_QhRmen6yNQ1sOp5rPyvCiQFJUICIruHxRD0677ZcMCrRdjd4gNxIEeQPJU
Message-ID: <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31199-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE36C8FD4E
X-Rspamd-Action: no action

Hi Baochen,

Regarding your questions:

"Are other stats populated?"

Yes. When ath12k_mac_get_fw_stats() returns success (0), it means the
firmware response was received and valid WMI events were processed.
The firmware response to WMI_REQUEST_PDEV_STAT typically includes
multiple stats TLVs (vdev stats, beacon stats, etc.). Even if the
"pdev stats" list ends up empty (e.g., due to specific filtering or
availability), the firmware should have populated other lists (like
vdevs or beacons) in the ar->fw_stats structure. If we don't reset,
these valid entries leak and accumulate.

"Where exactly is -71 (EPROTO) printed?"

The log "failed to pull fw stats: -71" is printed in
ath12k_update_stats_event() (wmi.c line 8500 in my tree). This error
code (-EPROTO) propagates from ath12k_wmi_tlv_fw_stats_data_parse(),
where it is returned when buffer validation checks fail (e.g., if (len
< sizeof(*src))). This failure suggests that the accumulated state or
memory corruption from the leak eventually causes the parser to fail
on subsequent events.

So, fixing the leak is necessary for correctness regardless of the
specific side-effect error code.

Thanks & Regards,
Saikiran

On Tue, Jan 27, 2026 at 8:57=E2=80=AFAM Baochen Qiang
<baochen.qiang@oss.qualcomm.com> wrote:
>
>
>
> On 1/26/2026 5:52 PM, Saikiran wrote:
> > The commits bd6ec8111e65 and 2977567b244f changed firmware stats handli=
ng
> > to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
> > after using ath12k_mac_get_fw_stats().
> >
> > In ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats() succeeds
> > but the pdev stats list is empty, the function exits without calling
> > ath12k_fw_stats_reset(). Even though the pdev list is empty, the firmwa=
re
> > may have populated other stats lists (vdevs, beacons, etc.) in the
>
> 'may' is not enough, we need to be 100% sure whether other stats are popu=
lated. This is
> critical for us to find the root cause.
>
> > ar->fw_stats structure.
> >
> > Without resetting the stats buffer, this data accumulates across multip=
le
> > calls, eventually causing the stats buffer to overflow and leading to
> > firmware communication failures (error -71/EPROTO) during subsequent
> > operations.
> >
> > The issue manifests during 5GHz scanning which triggers multiple TX pow=
er
> > queries. Symptoms include:
> > - "failed to pull fw stats: -71" errors in dmesg
>
> still, can you please check the logs to see at which exact place is this =
printed?
>
> > - 5GHz networks not detected despite hardware support
> > - 2.4GHz networks work normally
> >
> > Fix by calling ath12k_fw_stats_reset() when the pdev list is empty,
> > ensuring the stats buffer is properly cleaned up even when only partial
> > stats data is received from firmware.
> >
> > Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-dr=
iven")
> > Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> > Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x=
)
> > Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath12k/mac.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wirele=
ss/ath/ath12k/mac.c
> > index e0e49f782bf8..6e35c3ee9864 100644
> > --- a/drivers/net/wireless/ath/ath12k/mac.c
> > +++ b/drivers/net/wireless/ath/ath12k/mac.c
> > @@ -5169,6 +5169,7 @@ static int ath12k_mac_op_get_txpower(struct ieee8=
0211_hw *hw,
> >                                       struct ath12k_fw_stats_pdev, list=
);
> >       if (!pdev) {
> >               spin_unlock_bh(&ar->data_lock);
> > +             ath12k_fw_stats_reset(ar);
> >               goto err_fallback;
> >       }
> >
>

