Return-Path: <linux-wireless+bounces-38682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRclBoKxS2p/YgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:45:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD47116DB
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:45:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lZHiTB46;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38682-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38682-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E531345491C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E25370AC7;
	Mon,  6 Jul 2026 12:10:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB844424646
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 12:10:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339855; cv=pass; b=GpoaXLMBvwNbVU0or9xGHGYG29wS3e1IsHGxUXKP/L0vIewTV30pKT+OVaDzpkyPTUuQ0xj1nNor9qgiKrEj6BGKnJ9MNGbKdf96ApKaN2SY9NvCAfdtPDPAEOkyFGRHgcwr9ELmCHp80i5LMsXyoulVN6OOoIg6QftoZOZMG+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339855; c=relaxed/simple;
	bh=kdP8qqexFRchBr2fmOuIRPAt3lwX+HOpdmoD2eFQKWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCrM46LzVdp1KeNuYEV8/T8vZA5R3VOGMB6UgrGguc0ThyBRN4NKAnVgMfuSuFh6iZ/kPhRn9/2kmZonSlCsoCqvtSgePgt+LWb40VBNUxy4ia/8O7Pzd8+AHML+EKaFETSKfm3zdvjHLDhP8WU3QwbACCQQmvfvkf/3W8vJp/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZHiTB46; arc=pass smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7ff05e5d009so33582007b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783339853; cv=none;
        d=google.com; s=arc-20260327;
        b=CIbPS9RhVFs+nG9SrqmfmCjSbVOSm7wXrgmaZM3hWukktDmAKzvKdfON4Powhmjnwd
         Ak9mOnsuP09EImOZoU1WCXTwmB2fT3+KjYSeR3mi/e73o6X3olaIgUgVfOiiEAZ5mIGe
         eweWuqvT2tM7FYcVylzjC6FH26btPyRZh04IkdK/8fKcpVvCdf0kzwEq2Gnk9uABH/WJ
         was7bPnFbbTHTmB+hXPi5Wr0/4l3btZHNagwFSrfeMMb1SWCdKMdNDQktiLgm/DRs+47
         ApJQFCcRKPJSMgOdpkAT20SGHDZs6symsq1hCAtz9/WcgsT0uUhGIimRbvoubLL5e3Mr
         hyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kdP8qqexFRchBr2fmOuIRPAt3lwX+HOpdmoD2eFQKWM=;
        fh=gosypC5zA2rbq2qIIZgLbffsNTzYItMoXUG5Ppcg/x4=;
        b=LYqIAUGCICuSQcQq/VXIIeBxA/Q/K9ap3ZWx1KU0lP2qyZgOu1xZZGvyHXZtjAxvGB
         lRgxIMBZOSiLJXI2lrzMhfAnKASSE2eL59q/M7SsYdnc0uE0V87P7zfBSwIvKTTSS37Z
         qjYverwBMOtCBGoeaXN0eep/Gvf3gSX93GEy/qxLwTgpWrG3Ud/qSokABeusQUT/HEJS
         Hi4yEnjLiFylFe9SuF9NHHA7LLTyhfGO25zCLMNLqWxN1q8FirW5MzR9Jb0rA7ehIYe6
         gpvnQMeJANffjXcO5nPvm70XY4MDX1hZG4cujYu0+TljD7oUfgiHpy8vDfBALFk2T/Sn
         wyjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783339853; x=1783944653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kdP8qqexFRchBr2fmOuIRPAt3lwX+HOpdmoD2eFQKWM=;
        b=lZHiTB46qgnHOxXgnNMLlOCmgM0kjKKP3sOa58zL+UZvgG9RM0Gist/qt3AMgmJvTQ
         AoomUmf+NosrPzqtBGeStVAvuKKhff2pZle2kcorqRcFKnKxE/qVUD379ZVj1NpQQvLj
         lvu5xErYP6UUoSXZ1/bX1m7FTb7pFis5Xb4C/bcP3quq2XP7p9kry17hPkRomUML1mDZ
         fNzRvrSSy8nceO9t9o59MAFhoGmDm5S14fH7pQul+lhvkWqtz4f3zuJ83TB+19PlOkZr
         /G5ZJ1XonPgSKm3BD0y5O823qgRtzSO5JOd3vnlWsnvVTpBYTqaXu8YUMnH/chvJ606n
         RuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783339853; x=1783944653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdP8qqexFRchBr2fmOuIRPAt3lwX+HOpdmoD2eFQKWM=;
        b=IqRK3e9OvqjR4eA+AIrDA3tgp+J4HrzECx/o89FxpIQHaNF3HiRrqPtAIDKEHIdH3H
         pnmDRzZzOBeQ4hT+HJi1/FQ1s3gx0V2TFcQt4Q8TELzUstlAgA0cl4VrSBrxoxyeQo6q
         w/TfPoIpuHSoD4Yvnrmxgz1yxyn4L4GaE8HgXq26qW/W/hezp6XwG1vxfAaUEE/ZgFJ1
         WH4LNI2Q6NWuxYDbmNvHuUOmilLk8g04s84CtgiiFG4d8580HQMAPU8tbCF/mwIjCCX/
         O4H0je21Gy0DeZWdDwyFG0CEOJ04r6WCMnB9PG3dzjVivVD/QJ7bfLKGG4UOiLGOIqAT
         Jyaw==
X-Gm-Message-State: AOJu0Yzun7oRxpKmcYfYOwl+3NFvEb7D39WgYKb34hXTVuYi577y0OAU
	VannDG2hlPANdiRLSDK5cAQ7znmXN4gZv5kzDsf70dX5AvJVXQjCjXLDbOpWMkYWZtnQIdRIRAs
	j7O2Y/uo/phsUqVF6zBAA1cm0C+zckoA=
X-Gm-Gg: AfdE7clLPO+AYqHTjg1oethDZ3gCwhHx8z3V7dbeWmhy90Vr+bCccBWGy9TPSNkHreD
	0V44JH4XuOCyxY5mw5NUypfc+43TvtN3vBXPDy3iDkeRuD+3fUycJZ+3VjAijWzTI9BYakCHVXr
	ekWU1v9DKzlAdVhifCivCmzF8xTaIJsrrHyfUobwMd0i8F9QQ2LOe0QVvQPsIw3/mpyF1PN3q+T
	7t6kqZW1XaZR3AQFhOkfACZlZ8Go5zuen3Vq/wudg0ETzxjdQ26zhI+QTtVU8Ihth/49aZaNuw=
X-Received: by 2002:a05:690c:c14:b0:80e:7c4f:7df5 with SMTP id
 00721157ae682-81736d5e2c5mr113702367b3.6.1783339852607; Mon, 06 Jul 2026
 05:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619162419.3874564-1-zzzccc427@gmail.com> <ab97c01b73b96bf36527007e19743d3bb5a07634.camel@sipsolutions.net>
In-Reply-To: <ab97c01b73b96bf36527007e19743d3bb5a07634.camel@sipsolutions.net>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 6 Jul 2026 20:10:40 +0800
X-Gm-Features: AVVi8Cf--9zVTaoHlnwpC1dd5b6EamTdDkgHdkmUU-5AjH1I4iGStxJAQut-MLM
Message-ID: <CAFRLqsXZYTC-AZr76+Dgj8THPqpz50-g3rH+zCg+HvD9G4QUdw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211_hwsim: remove radios from rhashtable
 before freeing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38682-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69AD47116DB

Hi Johannes,

> How does the init even fail? I think this is fairly contrived,
> especially in a test tool. The whole thing is maybe worth a cleanup, but
> the whole scary commit message is nonsense.
>
> johannes

Thanks for your review.

The init failure I had in mind is a late one after radios have already
been created and inserted into hwsim_radios_rht, for example in the
monitor netdev setup after the radio loop. My local validation used
fault injection at dev_alloc_name() plus a bounded debug delay to make
that unwind window observable.

That means the test shows the cleanup ordering issue, but it is indeed
contrived, especially for mac80211_hwsim. The changelog I sent made this
sound much scarier than it should have, and including the long KASAN
report was not helpful.

The actual change I wanted is just the small consistency cleanup:
mac80211_hwsim_free() should remove data->rht before freeing the radio,
like the other radio removal paths already do.

Best regards,
Cen Zhang

