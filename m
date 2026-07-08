Return-Path: <linux-wireless+bounces-38774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VokqE1i+TWrM9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-38774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:04:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A081721493
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 05:04:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ou/WqvSv";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38774-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38774-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4DC3018D51
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69F211A28;
	Wed,  8 Jul 2026 03:04:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087026ADC
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 03:04:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479893; cv=pass; b=KViobiOxxBb+qDH+CJhMW81JI8Fl29oEIyd0lfGlKVyDLT/KAAJGxiq4cefWkSJ+FcZU0kg2kFp0mZIPwp7gUVT6aIQ5KST1PO6U9/kudQs6LFnc7JE5fWWHvvoEdKJeED5q28AEdrg8Vs4bnVMzw2cF+4xzb5T/G7aq6gNsBiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479893; c=relaxed/simple;
	bh=l+AdX33UqeUbma/kfyrdkzC+yuiEWDNZ7P1RqnY8Rng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyJHMdlh1b+0WRjoq+eKoxm64Gp8IeMw1AEdtko2ug6dereWLM4Y/aqdymxG/X0tUNc70yFCytjgtQDeo9/Feiu8QNtg3sK6q8FZ/i+ucWCB6em09miTF6Exb3JAY/1/aRZImehpKK6cZM/Kcq0uYceSWW4sagbLg2DnEzzwSOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ou/WqvSv; arc=pass smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so2707527b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 20:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783479891; cv=none;
        d=google.com; s=arc-20260327;
        b=FCVGpWoJFZSqsWcr5Np2K27jqJS+Rb3ODGTUl09U0WOVG8L+i90CBIu0ps1xqONVJW
         pQjLeVQFAqlQ4gm86XzT3qhLSvJ9DselM2PreRtZoc2fJ/U3bdCHIlUFaiLwPQHegaA/
         yyzsb3Sazh2jbfsLQXQuTEKX9iH6npwEc6BGctZFK37fWSb5UlmW/Corn6jAETIN8su6
         p9fFvealdRkOe6JyZexd5yRzJHN5jhRfvgvpUP3SUQuD3bWtHiTCRASWwWSIhYET6F2+
         4XDIBkaEIdJksxyOwLRJ2uBXYwZdMfbVDzlwOMSNwZEokZUnUtVFHRquII3R3kPXRivp
         o3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l+AdX33UqeUbma/kfyrdkzC+yuiEWDNZ7P1RqnY8Rng=;
        fh=RtLzaBrgYYwdOAn9F8B3tIaqjL1bPqusYQdtlSMe2UI=;
        b=YwohG8CsWG9PuV1Vv9Dgb31ha+yZjnp/CXCFs2CdbpPNAWBDfzAjN3Li8IbSNvWtU7
         v5SbDei42YWrv9VCuFqQOWKuxIZ2GNRk+bhk0g17S+3MtLBZdxTvJD7ffCxTW8tAubvg
         0fvAil2zsIwChxJAr8evDWk0kCJUvm34V05JKGP8AEzPKvQu3BKfhEdAZgis7ciSH7fq
         L0f7NtRzUL+Nt8CbHOpPndts6I6NkD7UoRbPnLc+nA4Yv3R4V4dZNgHhSL1c71yEbo90
         DY+Kmcg7YRPA2LWBpepOqP/XSkeshCInAAjmwBoMqsYvTmRjEfOfS7u0fVWgFIzD9Db1
         vnYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479891; x=1784084691; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+AdX33UqeUbma/kfyrdkzC+yuiEWDNZ7P1RqnY8Rng=;
        b=ou/WqvSvTjKW4E9U+a47OQ0b9THGKs2Vm+FTL5A1/mu8Ood26obFtyiHzEDwOShxG6
         CGRBlr7nkHO09cKyIjv3ShozIpWInAS7RE8gXTh+4wMD9gHlnO4RQdf6JQ6jFi1H/Ae5
         pB20ZZgoxE8FxaIvDys292WXZMkVCqclYAQQ1SyeqKaqYLiRjIQDZR69zLYvlwbhDAxx
         dUh3mZMz+Xp+h3QYQVVJeDqzVM6SxJVfwiGQPLm6IoIkhjbKp5/xWv9no6Y2/8FsdEbM
         WQWWN1FONWLQ0UHYsRRAwIjbwWipJmo5o385m2qy33Ukydg16/ibL1M8EWunrLGPLrh0
         vJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479891; x=1784084691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l+AdX33UqeUbma/kfyrdkzC+yuiEWDNZ7P1RqnY8Rng=;
        b=MTUiO1OOy0R2P2vZtkbKWT562Z6vQBKk/CAamn7NfOhB539SbV12UI0IREJ4tQMRh9
         MqqIulKjTQv4XJEz2cjZeouPzs44fRy1GmvfNx35gjF8hVtr/wOs2c0h8Bt0Xs0mCPrA
         7Kh+ZFJVKOmgIb2sYGNyTviD2OLavsAjSO5KIayzofNwCcfIItJ03QGbZnXZ5T9Rbwio
         fdgJMyYKb+LrluorkTH/dCxFaf4JyVoWL5yurDwNIooBWV7CefIwyyOIariH+A+UrlXJ
         DuwMG/0v1nMiDECOjRNaXQg/rVOpxR2txCaT1hkrZ/2yiri3S6CqZdP0sBoOJAn0GTMQ
         FpWg==
X-Gm-Message-State: AOJu0YwzizFD1PHq0C1OgqOWK6H7e9IWQA70aXKNJE1JkY/3qGkEJ6cc
	OBvtQlaL3258i9lng3WZwF72b/xS9bffMHpNReBMXDCDlrY7ycGHhN0U/+q6ILHuh9tArqZPG+F
	AGAD1n/ox8PvHc+Jr6Q+aXhiAYtJJeJshlsQa/fJ4qmzR
X-Gm-Gg: AfdE7ckyMwvAK4HbHceib4EdlC2UsH1SPloQ5fSdCJyOiVic8xzGgVcxBzt/mIMp/4e
	t4jUqwebiAcbwgCHKGgHby7PJGkaGc350X/N8NujEcwatY40dJzENp25uaUiwwbqTY0l9a4dc5s
	SGbxHyx6Bf2MaCPeRiyJDRO8aleH7cRv+jH3qYDLpg+Kaep725GIBbQVNMESrnsKZoLNU6jblif
	ETkX0mrDg3WQtNPjaAoWByJBiWd7SD5RKJ7xefqfjAXpqyp0DSePGMB2vG2NnSWVBHu+IBNi9o=
X-Received: by 2002:a05:690c:d:b0:80c:37a:b62d with SMTP id
 00721157ae682-81dbe5542abmr5888457b3.44.1783479890669; Tue, 07 Jul 2026
 20:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707134925.106972-1-zzzccc427@gmail.com> <bf10372fba8d1ce8503d01106a7adf2313f48381.camel@sipsolutions.net>
In-Reply-To: <bf10372fba8d1ce8503d01106a7adf2313f48381.camel@sipsolutions.net>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 8 Jul 2026 11:04:38 +0800
X-Gm-Features: AVVi8Cf7AeMp3ljBWqwIHnsCLw8HRXaL4YADrv-OU8jUroef0g04o-GMRV05m-I
Message-ID: <CAFRLqsWDajwDPRVyoSAZuGv_WQvH4D1pjQxsqKm6AY5ru0fkXQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: reinit wiphy work entries on runaway drain
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, baijiaju1990@gmail.com
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
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38774-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A081721493

Hi Johannes,

Thanks for your review and explanation.

> Yeah ... that's not ideal, but also maybe part of the point. IIRC we've
> seen cases where works are accidentally re-initialised and we get into
> infinite loops iterating the list, or so.
>
> So if everything else goes according to plan, your fix is certainly
> correct. If we get some kind of list corruption in the first place, then
> it's potentially going to make it worse.

Fair enough, thanks.

> Maybe at this point it's just worth bumping it to a few tens of thousand
> iterations and doing BUG()? I don't think loop detection is simple here.

I'll respin v2 with a much higher limit and BUG() if it is still hit.

Best regards,
Cen Zhang

