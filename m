Return-Path: <linux-wireless+bounces-38304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYhDCdZ8QmqW8QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 16:10:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6116DBCAF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 16:10:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l8yJW5N8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38304-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38304-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBC31302EEA9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B132F76D;
	Mon, 29 Jun 2026 13:57:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D733A9DB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 13:57:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741423; cv=pass; b=D5R4Igg6ud4Ldt0wLVzjzFvQQ2OQS674HvB+H+1DjP2YplONkVaRDh+Ixjkd2rwFxlaBCkrJJ3/jCF6hheFY+jGdT1+A9NfsukPPr7k+nk4nkyZlnOnlXWMdrCsA3j+eXg16o1+1oiMJRoBGLQEVg8zfSTYxypNMSQxrPTJAZFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741423; c=relaxed/simple;
	bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFX1cWytCHzSudoONN8KLCYGapq50+giSIUrszv0ONXmz1QQHKQJQ6ICQz1k4TWn+7lQgHeX1bMGxGQ84dLBkYStayr7tfEcFfmchxns168c8SifIlXKWPMXLmyUp7gnhrLAlt13v4aKqVDALVZAv+Xcfti3ATJVzAAKtRpCUgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8yJW5N8; arc=pass smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664b05d408bso2640363d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741420; cv=none;
        d=google.com; s=arc-20260327;
        b=DEVioTCRo194QrPT08Gn98wMVQ1z9VfLzEUWHAMrFEZbfL4ekSKLxKYhrDFJsII1mK
         YtRw69CJ4ogoa7AXGhLReJnjokbuuqTU0EQk5HzPfXTc0VSU/FH/wK4lcU78JajBgKeF
         aPzdkoHiDTf30yJE4t87uphwZYQp9nYrxXorvZ5bvtDf+zeD6QCPygdNt6qzT+rON0My
         pCbmM62rgx3cS2I5BCC9lRNvrcw2/WUMdgguiouQQaChD1nGx3HOTeo68mQILF3Ipz+W
         uLAKN/EY1C8ZDXGZmxldw+Bhs8PXUe4Ub/rz1cwEEkhIEM2NsdqyYR2KRHh1XMXU98X0
         A2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        fh=PYyuKEwrkjmxzFQHFfnxVRG9pp1lOWVNQQwfosviJ74=;
        b=V24n3x3JJXoZrmEx67bxPMabJdW+y6n/AaiijJ2pZJCzwTtnyblR86uqFvMZiL09hm
         MO+/CPF9y/ze7/HPIEsuAJOVeqyFyhDXW2i/HCdNIfwO6ID3QImK1eq3S9juo07Voxvq
         AMPRHuGWlCX+YhKAPyHjwHo3pkhGYLlpxmMh1tswepGE83AD/f/4BLOMHs9v6r9wWjUT
         K4g0PDTISmgJELkT9aYHMusvJBCjGIjzNQ04ZH/XN22Qwvj6zQjkEn9cFRWrjdlxtpKC
         GIFGWe6/aRJGALBautd3Ske5/2L853qaMq/4MjS224bHSVALnVSZQkgdi28O9RBtPZWV
         zIUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741420; x=1783346220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        b=l8yJW5N8Gg3D8cZ3SyZwKpTFu0TpO40X0+ySHGpxKk1qzUP7f5qzNGGPMM3xWaFEZL
         dh1beFJ9QgJa1/hfAdzncMj6HnU/hYRCfHCSDgKzxmxpyoppgjFcPLey3YxRYIM1Cnw0
         2rGyf+mnIMu3hIwzlsBY1zS/6U5ADFYQwnKWLLGPVg0ckcpWryLx/EEJhxRkVO4vJCYE
         e7vC0jqZJy2lGRMiyctgt3heGVQWOMx6aOa8xhQhiUADkg6v13OD7tFZyC7aJSyN8YoH
         glYO6VefkUWq5EY7le+8VqQ71FmtA2URUI/p5SS2w9wtGg6uqHEx4llup1J+iptTqFgd
         FtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741420; x=1783346220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEkdzenJtYzPXYgeH44DLSQlNtqYRLcfGKZngNB+QG4=;
        b=syY5U5FI+tm+l2bFS8UfC6aTUcI0mkYlBxPVlKLBmvos5rbkg+sAV3MuwuOCH1Z1sg
         o05bUHdxjhIe0AoZdZDsVLfpRh1h3gTVMsb5yN0F1LnJfAgKtvczfxQw8IrjPRM+xYlN
         p2D3QoqSgzJMcoSspIndYUztwlSBbJTk+C4TWTEIM0CYZvACKETyOz+uCI0o114kbfLt
         WjRsotBZq1Q+AuAPxEo/SXCDSv7C3c6OkuYtoZ6ESFE0Rt2aJHLU0e/RHm1XZ53anz3s
         bMJ508dScD9wT62aVcUhvGmAAmjHMems4rLuzyDRtU+Sac6n/prMrdP9rZgUl1N5EsF5
         rViA==
X-Gm-Message-State: AOJu0Yym6n09D/vwtP+XsyD0Z+HbW/UpCFt9WUNruEUi8K9+gHQykl7t
	W0zDqVl36EiIJK0sEhwP1Bjr26oHLgr8DFNLAtBvDC0Drlh+sKAMtYtvrGFQOKMpIjbangvJ6Ey
	OJsW4r8UD1WfTZSj2shu6NfDcuWDnIDs=
X-Gm-Gg: AfdE7ckp+u2DV337qaFiM2avkDD/EJBbLSQsvr0UP5/DEI6VbDZwVH/dnVuL1wVTt0D
	yTRVCLeSQ5Ef+v45tarMr6Z3IEM5J9tRzgUQk5FpXxeok1DAWGgDJId4uZRIuvHz/ZKTSZ/rNii
	XBTv6bBdn3apToV5/bhLWazc6+Qo5N+b5cv6Y7hU6C38bChQdEPIBnJc+HaP2q2sKYZ16mHGGuZ
	pv46Fvxh/lDbHMmMA4onGdzz6tY2QfWAkhe74fAXHioWrCIHFrkNG8NxDQmDJF7qHNqNItA
X-Received: by 2002:a05:690c:48c9:b0:7ef:758c:e7b0 with SMTP id
 00721157ae682-80a69d97421mr155842417b3.1.1782741419762; Mon, 29 Jun 2026
 06:56:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:56:59 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 29 Jun 2026 08:56:59 -0500
In-Reply-To: <87jyrhd6c1.fsf@toke.dk>
References: <20260628001350.20997-1-alhouseenyousef@gmail.com> <87jyrhd6c1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:56:59 -0500
X-Gm-Features: AVVi8CcSuZeFAVGyi5M2iCAaJADLTm7w6GUYQ5N4ro2W-UlR5D107eFuYLkHe-U
Message-ID: <CAMuQ4bVzzsx9SDmoWDWpZrcoWPgRsFYFixnjY-1TGkGiE+Vfsw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath9k: avoid device access after async firmware request
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38304-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,cb7ed9d85261445a0201];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,appspotmail.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E6116DBCAF

Thanks for the pointer. I missed the pending patch; please drop mine.

Thanks,
Yousef

On Mon, 29 Jun 2026 11:49:34 +0200, "Toke H=C3=B8iland-J=C3=B8rgensen"
<toke@toke.dk> wrote:
> Yousef Alhouseen <alhouseenyousef@gmail.com> writes:
>
> > request_firmware_nowait() may invoke the callback before the requesting
> > context resumes. When a firmware lookup fails, the callback starts the
> > next fallback request. That nested request can exhaust the fallback lis=
t,
> > complete fw_done, and let disconnect free hif_dev before the parent req=
uest
> > returns.
> >
> > The parent then dereferences hif_dev only to print a successful-request
> > message. Remove that post-request access so completion cannot leave an
> > older callback using the freed device state.
> >
> > Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw ver=
sions")
> > Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dcb7ed9d85261445a0201
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>
> An identical patch was already submitted and is currently pending:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260605153210.=
20471-1-1020691186@qq.com/
>
> -Toke

