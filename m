Return-Path: <linux-wireless+bounces-36438-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBcSBg5yBmqyjwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36438-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:08:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005B54842C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F237303EF57
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB4A346FC3;
	Fri, 15 May 2026 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1MwaPxK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2E2FD68B
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807306; cv=pass; b=mbDx9YPPJlLHP7v69I6i0Hb5MaUcdQaHWovhXvovUuRzKdMoA+P60/41SRQctVqnIbnBv0/54ANeEkf5+0lJTNARWea1cR74jgqrwDmHLbkbb02hUY2zcJkZ0yhVzBAabIs9Dtaqz578RxxuM34yVLkptSityiXSrPdMu9Bpd2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807306; c=relaxed/simple;
	bh=Tjy+wLAt76/SgLvXzCA18dCPcMxTTSJKx0uzseG+k/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZa6+zbxlznouU953g6x/D2mTLT/UVNjgE7e6MUdseCoumSsWscHT8fivT3swof4sabr/ZhRhdR/Kv8UmXoM8SC9fuGvnY7gQoicmzAfW2SJvVmW5wSElLjtocvx6UyvwVwWzPZDUe0Ok8rvI3e9cMVTcqlCxbqmsIz5RJWc60k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1MwaPxK; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd689829eso7669162a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 18:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778807304; cv=none;
        d=google.com; s=arc-20240605;
        b=WXV1e1eEvehmPKRQSviivCh4bzu8qMT/WUirXSQlv6qNdRqz0k2rtI5PF2flxmOi8D
         jnuwDJvFAQy22fKSd/S+6u1d1h8bK4prXfHC0j8/Mi90VfrOXVVX5gXOKfu6tuVxQw0a
         XHhjwb5NQY2QHI9+RvGM1a35+pjsXROvUUScsw1ORbNKEU23q/DplXViAB1uFo5+Mu81
         1ruaR+YnL4DLa9cRMvRL9SfmfGq1TkTCXUcWDZca2mea9FtTxV6fMELFNHDO2btMNB3C
         ZTTsgrATQ9Kc3ac912laqFUpCPw/ZAtzllBBfWTMwtGM+kQpvHtA2YFNOZzf2RuzR+8y
         XdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        fh=GtlxNgPtFq8U+yhKqoyZquRae9D1z6htTbkdAEJgrYY=;
        b=LXWtFS0x1oz6n6/7cHIqnFwnJJ/tzRugX0LloJoqp5cg+rB/fqjQIsXucgrauL0Dnz
         Kgh7pjimmpWsuiIoboQ311dnlI2AWYjFNAFu/CeojvdTzyYPyhM3Hce2TidHXJBJaORF
         ZDSS+e786X6NvEVmeQQuQjciSB0ex+dbfPzrhaUUJzCVs/URnvsZckG7Bwc7EZIAzl32
         pPafOq3jTwQC4fFeWSCdvwvoCGCRCa7O2n14il+9BZuOtFmqfiWhb6fbbk/KKNMkiGCE
         VToFjzCrt+8LLQbZTL8tOfV6BxLIi9LuEj+4PRXcP2bAND4hZLlsCMAYNGzRmvgxy1sy
         seBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778807304; x=1779412104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        b=i1MwaPxKlJBj6YnS33rrgrCoAF74MxK+bSVTgeZN5u86Iqj+xrX0paCiEVEqmSBk19
         uT1MRbVCdWh95NSkLnJS6lkPbDwBMZFSrfuguUrvJASsjkd+jDSCT/0WPaefPDXgZ9NQ
         oqJxyiNqaYwmoPKHH8o95KlkGklmKHLfGokGEukZFZRu9ik+0+lY2HKrvfigWhz/HvGl
         8qWzQXPYQ+IFjjTCT0Dx0v4tMRbnO2OlXZUcepqMfmjB+1zPnU7A3hzpsS6TbWPsYQIo
         QEA9KIAuZcz69lzZpEXsy2gF4Vk2EcPDZGxrY4EXS6/9kTb+Twit2qyvyrrmZ5FBSpJ8
         rv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778807304; x=1779412104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        b=jU3b+pVAdsvSpceEpVKJHADzBRlUHmr/FdSklXxMtKv7glItUWwr10d64tFEvjGFTD
         ncgo6R5Dy1sVto6KoX1bFc9Jh2RM8SlNNilZYXd5umKBE47jtJbEgziGTgKx8MPaH2Uq
         EEo7xwTvE6BTbf8ZaRZ/qOJfTMiXpD5U2oBsVSqsIDpkVTK76bZg1OCJUCbVLR6EVUR4
         cc/KkfI/BQtIdRG41F8HXGgFMHbkPMV3FIbLOhjBQKytrepsITgEWrWT9MyRHBuD5+nk
         Tp7iQ4QUYY6EqZjGZdzGwaPy48e6c/tAxcI5LG20SbJ1GQqkoJnC3p2OWeFGjA0Wu2jt
         cqzA==
X-Forwarded-Encrypted: i=1; AFNElJ+/xv4fWVOmQH9dWakkCwRaag6Y0ZP6RPZLCVCQ46IjpkVpnRhDWm34UbIvcD0VO1S/EVb/Hz00maE/Gd0cqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyyDPOv7+ANK9jZnUsLX7c5iZmzVJk5DJEE3uFBplyUO6KnC/
	sL47bVLFUFvZ/gMpWPfXZFBXNn0smWciZym1r/ZUKoQbYUrEv4FJIMSkk24Geu3qC9wyU1rSN/V
	WfgoZNlgx2O6dP23HzlbzGJDxMm0pdfCi3mkeqhM=
X-Gm-Gg: Acq92OFJtU5Hy/UBou6Yyq+O05yLmxCKyYfRA+hQonyWvvjN3TgxKnrjH6I8cm9Kzen
	+VNcKUQvCkG/xw4C4jqN/Dxgu+Hq8ui4iiSpf+vAUA3ZcT1X/LVjHh5DlWygjKFRGloM2bXJ47R
	AKTeuzQVbc3Vi09owN2DktUDCpFaMp+HjKt1EVVHlz+mmExPctNNwLYrtNzfGXsZzrDC25nSb2O
	2349XC1mE0qvz+wzuo8z/+0SarEFhsU24EbOHvjYgaAEYoNkoS343qunoeLQho84C5jx1sOEM0f
	dkpKD4mNqOiHInJilrjE7HWaJQtaE38BUspCHlJHbX6l9Gfyng==
X-Received: by 2002:a05:6820:2982:b0:67e:160c:36ba with SMTP id
 006d021491bc7-69c9bfb1664mr1186419eaf.48.1778807304424; Thu, 14 May 2026
 18:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
 <ddd1601d-2eef-4a52-af16-594223449c8c@oss.qualcomm.com>
In-Reply-To: <ddd1601d-2eef-4a52-af16-594223449c8c@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Thu, 14 May 2026 18:08:12 -0700
X-Gm-Features: AVHnY4Lvlc5Ig89TV5C-ke-68Gt-iwIwGCcyok9295LT1kww5dL6ntxLMQaGick
Message-ID: <CAOPSVF3RgoV0e2EGbpy8t36mPKnn95_KWGt4_xSL7B9m6pv_RQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	santiagorr@riseup.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7005B54842C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36438-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 8:16=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/13/2026 9:52 PM, Kyle Farnung via B4 Relay wrote:
> > From: Kyle Farnung <kfarnung@gmail.com>
> >
> > LMAC rings reuse the shared rdp/wrp pointer buffers without going
> > through the normal SRNG hw-init path that zeros non-LMAC ring
> > pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> > stale hp/tp state from the previous firmware instance back to the new
> > one.
> >
> > Clear the shared pointer buffers while keeping the allocations in
> > place so restart still avoids reallocating SRNG DMA memory, but starts
> > with fresh ring-pointer state.
> >
> > Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and r=
e-initialize again")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wV=
cFMc6f-yhmSBcZqQ@mail.gmail.com/
>
> I'm going to change this to a Closes: tag in my pending branch

Thanks, that all makes sense.

I'm still running the fix locally and haven't seen the issue again after 9
suspend/resume cycles.

>
> > Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> > ---
> > This patch is the result of investigating suspend/resume failures on a
> > Lenovo ThinkPad P14s Gen 5 AMD with ath11k.
> >
> > I originally proposed extending the existing ath11k PM quirk for this
> > platform, but after discussion in [1] and bisection the issue appears t=
o
> > be a regression introduced by [2]. There is also a parallel report in [=
3]
> > that appears consistent with the same root cause. This patch keeps the
> > intended no-reallocation behavior from that change, but clears the
> > preserved shared SRNG pointer state so restart begins from a clean stat=
e.
> >
> > Testing so far has been limited to local suspend/resume cycling on the
> > affected system. The issue was originally reproduced on v7.0.4, and the
> > patch was also built and tested on top of ath-current with repeated
> > suspend/resume cycles on a Lenovo ThinkPad P14s Gen 5 AMD.
> >
> > [1] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wVcF=
Mc6f-yhmSBcZqQ@mail.gmail.com/
> > [2] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-i=
nitialize again")
> > [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1132343
> > ---
> >  drivers/net/wireless/ath/ath11k/hal.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wirele=
ss/ath/ath11k/hal.c
> > index e821e5a62c1c0..0c0aeb803018e 100644
> > --- a/drivers/net/wireless/ath/ath11k/hal.c
> > +++ b/drivers/net/wireless/ath/ath11k/hal.c
> > @@ -1387,14 +1387,21 @@ EXPORT_SYMBOL(ath11k_hal_srng_deinit);
> >
> >  void ath11k_hal_srng_clear(struct ath11k_base *ab)
> >  {
> > -     /* No need to memset rdp and wrp memory since each individual
> > -      * segment would get cleared in ath11k_hal_srng_src_hw_init()
> > -      * and ath11k_hal_srng_dst_hw_init().
> > +     /* Preserve the shared pointer buffers, but clear the previous
>
> Since you are touching it I'm going to change this from the obsolete
> networking block comment style to the universal block comment style with
> /* on a line by itself
>
> > +      * firmware instance's hp/tp state before handing them back to FW=
.
> > +      * LMAC rings reuse this shared memory without going through the
> > +      * normal SRNG hw-init path that zeros non-LMAC ring pointers.
> >        */
> >       memset(ab->hal.srng_list, 0,
> >              sizeof(ab->hal.srng_list));
> >       memset(ab->hal.shadow_reg_addr, 0,
> >              sizeof(ab->hal.shadow_reg_addr));
> > +     if (ab->hal.rdp.vaddr)
> > +             memset(ab->hal.rdp.vaddr, 0,
> > +                    sizeof(*ab->hal.rdp.vaddr) * HAL_SRNG_RING_ID_MAX)=
;
> > +     if (ab->hal.wrp.vaddr)
> > +             memset(ab->hal.wrp.vaddr, 0,
> > +                    sizeof(*ab->hal.wrp.vaddr) * HAL_SRNG_NUM_LMAC_RIN=
GS);
> >       ab->hal.avail_blk_resource =3D 0;
> >       ab->hal.current_blk_index =3D 0;
> >       ab->hal.num_shadow_reg_configured =3D 0;
> >
> > ---
> > base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784
> > change-id: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5=
e2
> >
> > Best regards,
>

