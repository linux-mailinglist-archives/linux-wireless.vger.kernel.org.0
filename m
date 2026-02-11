Return-Path: <linux-wireless+bounces-31725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBMNKvdFjGlxkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:03:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C68122832
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 10:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61CD230038F4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D929B216;
	Wed, 11 Feb 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFvReyfy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600C3328E0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800501; cv=pass; b=Yu/NtqtVXxxuYGRJUNoLyI+fv3JN9rtusmo2QNJR2EUcJDw1iV8yxsgagFG3bEGtUam4XgEFcLnLTB7maQeVqwhjkUqbX5cIJtkzkQRycxPxQ9ecQxgc0Nj0sIUXSolBwzlNe47CGgy2b77gBrHizLdx1y0zucgsH/VST0mEsfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800501; c=relaxed/simple;
	bh=IlqKUyiN0U3VYCZSh5wBhgPjVtteYN5T3q7z1E8Zpjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjZpJCAyneaICjPd9DTxi85ULHFmLvuGE4wANVXkoRMPFq6WMJn52KL4Si3VTqQz9+kKLOnoplWU9ARB8EzilhFk0rHMuiDL96yYv8LezlsNuQnuIzdmGtKzcah/YzLPfItHPox7R/fkJTwGpMmgPI48FF33XSxTDTogOW6DVIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LFvReyfy; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso7070289e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 01:01:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770800498; cv=none;
        d=google.com; s=arc-20240605;
        b=HRmK8IXSEkP0RQ4yM35w69j0IHbewJeZlFpFTO/ikAXakQ3vQGDjJye4CB5GNDp19U
         rgd9/4d8ormC20e9SZmeRpjV9fir5qG1hN2GSSsKKYk+6Degbc4DJNdDlws5xeW8tQLp
         XjIzp3VRZq4vibeZASwp0ftcyHPYHAa0S1FMX6mAYmKCJMq/TzzcpgVQNtWjXJvPwJOC
         cSnZi5wJlPW7nojlgfihsOpD3DioWY107acL67TYTPndwOPekDXIqiprzbh2gSQC+IQk
         E3A+x0B/bGu9EqL+i+VTMBTwf/HDlOzmCe/QbW+nQCvkD6iJSA3DXuU06DdbSy6oDk1L
         F2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlqKUyiN0U3VYCZSh5wBhgPjVtteYN5T3q7z1E8Zpjg=;
        fh=4WTAINr8onBck2obNwadgezla35XKZe0nzvKk1038MM=;
        b=H5F0vR/jXlNEAspKoUHYFhrSfKMOhxgBy74p+TS/2wKfReIMIX8wtrNJbnCb+M72Y2
         HAkyqfwOCCfSn81edJ2FKBYspVgI5eveAx6vZf+i0ePFU9CxbOQn4To/KI0zPjpGrBpd
         bNPRjX6EPc/ht7NPRFj8eMQNFKZSvBkZJk2OhYW+9XlOTTlewOPdDbYDgcmBs+gYVcHP
         OKxnYwkSOsN14oxP98tSCYXotF405n9uvgXb80Q3o16CDqz8wvqgmS24oQFpPgLRGWRu
         rTnzQuoSwjgaPia48KuCE8NN4nxRkQwyOYipJV1MJYuvm9iA/5n/JTGeugFV80u1cwVI
         NGZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770800498; x=1771405298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlqKUyiN0U3VYCZSh5wBhgPjVtteYN5T3q7z1E8Zpjg=;
        b=LFvReyfybb5gXmVd44pWqdRVhjd+HEfNL0yVWph4vnQwsTzsud37yJgjRPy0Ub8600
         0qvANCIQhLp19N3zhImUixJGLzONCSgi1rEf0YrG5oaxlE5cxUS93JZdjE47r0vtIhh6
         Dj2mXFHy97aK4U8a+TS4j3gXzx4usOtERmHy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800498; x=1771405298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlqKUyiN0U3VYCZSh5wBhgPjVtteYN5T3q7z1E8Zpjg=;
        b=HcoiGZm0tlkk0Lrz8FLi9UCN+tGQ34uDclD0M+azPHoatYrTKKKO5QKWgAI8DLY2Cq
         9eqoPk83vQl1zA3CbBF1qoiRTYReYq5OYLlUPhOym+fK5RB9yUiDnQdw8pirsK9fFPob
         o8fsCZPg1eXwiJ8n51a780ADInGslt+w3ccQqc7mDoXOjXD0MLrYITJhm1m5mYqrmkr1
         A08AFXJJpEm2lCLq+G9R0GrEbTsskyFoUwhmXfiT+nCbOZ204yRFi6IzAZq9+l9PjftV
         fB7bl1YpHy4ir35eJrZiFDxZ65WC8DeBrBfp4wxHw0fZFFltUvSvSzZBPRZ58STGeKbK
         MlHw==
X-Forwarded-Encrypted: i=1; AJvYcCVawDnp0AnIgADCfbqzR6zpPTECast4ObPtLBFDoBNaJK9CSu+peyn/gaXcO3yotjWIaPNp09JNuKbeh1Uf7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwReJU9Lh1soruSLkTX0XpDGo5oRJaps2i6ocxhwdc/G7S/6q
	MzXyPwtpaulXAGsqKffj2hv/MMImwIX/YXVRZTOFBMumSlWu7Hx1tPAfJEIV73itFn76uplzMjv
	UU4Qv1uvikEWGtNy0NmImmi+gvyWWfmojB7q1xNcV
X-Gm-Gg: AZuq6aLPovARMvgiDjF5Aq3sN6bWpCAg3vJHwEZ6vDvi6L5MTZVZRcpyxqvHpzqFcJ5
	dkpIKN6eHTJRSml+3I8yThjkTE/NFWQ0G8R52PoBKMzh90tw7pfsqjzZ0mFz/jyKBzMFx4WYmtt
	eA4WTgbW1I0J31/IGfNK4I6+ETFZjKJ0SNExtMsYICHiQbuy0Baoh0dGuCGOYgv2oBC/rrRgWtc
	krpXC5kt0bvNLBGBPWQIxasWVz3QUsSJmwgiQoeR/v4zGtFfOdBVfFugSrLz5TuILj9FTTrosd9
	IM8pKRnkGoeoaT+oiq/mwTfxfzaxk3UqdEsp
X-Received: by 2002:a05:6512:12ca:b0:59e:1954:1d3f with SMTP id
 2adb3069b0e04-59e5c3f0c07mr635102e87.44.1770800498017; Wed, 11 Feb 2026
 01:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
 <20260211-miniature-chital-of-plenty-1a71df@quoll> <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
 <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org> <0dceffe2e1344830c12bc1f6516d13c7bb488b99.camel@mediatek.com>
 <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
In-Reply-To: <23561f00-9f3f-4d4d-81ae-aab9958bd797@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 11 Feb 2026 17:01:26 +0800
X-Gm-Features: AZwV_QglW35gBJXxqkqDaU4LG31ARe_Nwoft0XmJRDrq9pj3jspIahr0OV8U4wA
Message-ID: <CAGXv+5EY=8Xta4OdnS9Skjx3Ls3ZnW7oNS38cK1Ch=wL6JJJ0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31725-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenst@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim]
X-Rspamd-Queue-Id: 10C68122832
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:41=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 11/02/2026 09:33, Ryder Lee wrote:
> >>>> Why this cannot be a schema?
> >>>>
> >>>>
> >>> Well, actually, it's already a schema. This is just an expanded
> >>
> >> Where exactly?
> >>
> >
> > How 1T1ss is used across different generations is what my example above
> > was talking about.
>
> Where exactly it is already a schema? Please point me line encoding this.

I think what Krzysztof is asking is why can't you have different compatible
strings for each generation (connac, connac2, connac3), and then have
conditionals in this document to describe in proper DT schema, not text,
the length requirements of each property for each generation.


ChenYu

> >
> >> But if it is, then this patch is redundant. Don't repeat constraints
> >> in
> >> free form text.
> >>
> >
> > Alright then, let=E2=80=99s drop this change. Felix, please ignore this=
 one.
>
>
>
> Best regards,
> Krzysztof
>

