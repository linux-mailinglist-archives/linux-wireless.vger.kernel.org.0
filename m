Return-Path: <linux-wireless+bounces-31520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPu3KNMOg2kBhQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 10:18:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CAE3B91
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819A93067794
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59353A1A55;
	Wed,  4 Feb 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvhCnzGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49531B812
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196409; cv=pass; b=jVm9fp+j+5f7gOTX8QF9p8zDPqq0FVuoU4W3beFW1qu8irIw1yJwvRhbIsHYWVp+Cb8gxAow2p33LtJeJ48+q7hRwDSo5Ak505bfe8C/0VguudWY8Jv3D37xBZBC6oOX/5QJncTMKRIklNdo8nIFkQPS37N+EnVAp/WHeID30aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196409; c=relaxed/simple;
	bh=UFKVYR10egLsQ7on2QVWfcS1sXpvOuIiUbF1KAu1+m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gifqPy2F97CxbuQL4Js8vCrLr8+3TpBAmXhWV98dpPqrnBiIOPHdPAdweQkV319mAcK63BEW/eT9zuF8ALlwz2RD0PNJmuP69WlwIb4zdwMbuSL0Iz7e/oUdzophz14GHsq/4uR9qpQ5r5vqCQfF+IDsJUypZbZpd7uteZFbOJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvhCnzGb; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649523de905so966354d50.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 01:13:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770196408; cv=none;
        d=google.com; s=arc-20240605;
        b=Le+I2BiADHYZgsv8ON2y3n3q/NQBh5rKhY9+m+0wt4cv2bbRJ6Ss9Z8bSFK2VhF4zw
         3Ox87cPS80NzymyZYfaZ8evjINF8s6sdEMkoKggtJariR+0oo73mpda7o6VhoDTb+ebb
         1apYeubbpjit++0QdbkeTrVwg7+X/DTUYEmCYNhKQyZnicXoU9ljp2NelbHQ8rB6pLDW
         OV+I5+sq7LD360vhobPwyECLFtH45cenZyRVu/cb9jmJC9LdKoAwyKo6VdN4sZO27GOJ
         q+xJLc7/8CRZvl4veSoAzvOQ+0xoiEt5qrp5+Rjx4+dR8SyXmUG7fqtZPVgF8ucRJEty
         EU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qrs50X9Nw+6YUzyM06BAYQx5LvzLf4bRJO2WNKfUp88=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=eW4+gJNsfPuUYJsXRnIYvyK7hlCPE9rvTKmU8vpcK1mdkecRilpKM85TLZFyAofaax
         2L8TVN1cM3uWXdX5QC6yZIgcINkBoWh1GQmdcsGFf79TLh+oiBT8BSd7vxYWWdO2/r1r
         yX49DIJZ+V5cEa2MU4OjP8JeoUPcVlvw0AqojDuDm92lNQ+ThUsoikJbPi9ZwbEdD4sb
         tMp91uujQyEadvCv97f+crXCfyXFKNdkoK+aE8MTgRZXoOqsqR9o0D12tyzkbg/sOe8d
         FOiLzLTLvs/iEOwqUlcdNR9ssnVrZU/3tCNfxaOXoU2C/iF03yLQFQRbOw4Ohg1AWeck
         5SZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770196408; x=1770801208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrs50X9Nw+6YUzyM06BAYQx5LvzLf4bRJO2WNKfUp88=;
        b=lvhCnzGbWkOksjjX7/W+d9CvHnRqp/yy4NTlA09qrnNI/rD2lEfu/iCr4oNsYZNXhg
         ewwybvOr5Apk6L6YezbLalSRM68+5A4xJrzS/w98AavTJfo7ObBsnqw11vZTlNo4VSED
         4x47IDDu845tEETQJJhAu7KLFCjDdkPG0sJ/m7BksqBHWR7qtIZmVA0VL6U0yNKKT1bQ
         put483Lj8QamJkrU5Lo3foCis/Saddjv0kOk3yPb8x/EYE4Uy5I6/N+NsK+/mt5mL6zd
         fcxWAn0VPgq95AuvwbQDQ12A0DjND5lGlJZV34E7yOK6eXHabOjCGtnssWeqbdpLKsOn
         ZUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196408; x=1770801208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrs50X9Nw+6YUzyM06BAYQx5LvzLf4bRJO2WNKfUp88=;
        b=dlRks6IMsTfMJlQYacOYUacIO1pb60bzHH5QsgjV9EqjsTrDfuTo43XDmanCPEjxBZ
         lXxYCdBgmAmEZsYSsqo6++dV/gxCRPuSb+OnT1AVW5BuqM9KWRxbbuCzjeVm3DJ6N8/I
         HUZBpOQvkRJnt1nRcJ0hfot16HVogCYF+csNILHJLmPYX+Zv1NKzfag5oANCB1Oj/YOX
         1q5OC3lbqFm9t8LykPvbMCHJlMOkgcN03PuKskAybqxVI4zZJFwua1NBqfX7RcWT0jm6
         T0YbKLB6plHzPDrYspcclpA2TdMiox1V0Y19bHyAguzhppc4b2tIYI65uBol5rWj11TB
         rRTA==
X-Gm-Message-State: AOJu0YwryOcpdPiQsPbAwm0+O3TQcB1voG45l0aRvwBRwEdlQmP++ohU
	Y18EiiZ0qtgea/Z5XvzXUVUvb/x+UbnaPn/02enwXp6qOukH8Rb4yrse6JPv5e7CJtsmIDmeeAk
	wwr+9aGf/5WDDJvJcpo9vG+6lA/RM2rs=
X-Gm-Gg: AZuq6aKSUgZXO1BJCZzWqaoG10u4XpVseczay9pa5wwRS7ryQLu/f4OlhOqrNMlnnOv
	W1Xa8+VOW4gbCAMC8EB7RiXZU0e1uS1KAeUAYKE3DzBfXy8DJKpnoAjS3s6OjUCY7mZRW0Y/sqc
	eYJAMJe4xIrMzd7UVCcds+590xSOsEKcjxtpR70mUFACCxwocwzu/um4WGzYMeagfE6LMLL0iit
	KFaq2GDa0n4Lgx/pVzarxDUvESeAyYPDbXAwxBYQSrezXDLHNv1acVv2/6heNBWoKkSZA==
X-Received: by 2002:a53:b494:0:b0:644:7479:4b1d with SMTP id
 956f58d0204a3-649dbdc058emr1376931d50.8.1770196408571; Wed, 04 Feb 2026
 01:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com> <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
In-Reply-To: <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 4 Feb 2026 17:13:18 +0800
X-Gm-Features: AZwV_Qjk0JX3GkvOusGoKjPQOcE8SSfgZTG3ZNd_P8w5CHXZekfm5TVjCNXCOhc
Message-ID: <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-31520-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: D47CAE3B91
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 4:36=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Wed, 2026-02-04 at 16:18 +0800, Sun Jian wrote:
> > band is derived from nla_type() of a nested netlink attribute, which is=
Agreed =E2=80=94 in general the enum underlying type can be signed.
> > a masked u16 value and therefore cannot be negative. Drop the dead
> > "band < 0" checks and keep the upper bound validation.
>
> I've seen this before, but I'm not really convinced it is entirely
> correct. C says:
>
>    All enumerations have an underlying type. The underlying type can be
>    explicitly specified using an enum type specifier and is its fixed
>    underlying type. If it is not explicitly specified, the underlying
>    type is the enumeration=E2=80=99s compatible type, which is either cha=
r or a
>    standard or extended signed or unsigned integer type.
>

Agreed =E2=80=94 in general the enum underlying type can be signed.

> It would thus _seem_ to be possible for an enum to generally be a signed
> type, and therefore a 'signed short', and therefore an nla_type() that's
> a u16 could end up with a negative value...

The key detail here is that band isn't assigned the raw __u16
nla->nla_type, but nla_type().

And nla_type() is effectively:
nla->nla_type & NLA_TYPE_MASK

and NLA_TYPE_MASK clears the two high flag bits:
NLA_F_NESTED (1 << 15)
NLA_F_NET_BYTEORDER (1 << 14)

So the result is restricted to the low 14 bits, i.e. 0..0x3fff.

With that restriction, even if enum nl80211_band ended up with a signed
16-bit underlying type, the sign bit (bit 15) can never be set by
nla_type(), so the value cannot become negative.

>
> Am I wrong?

I think the "enum may be signed" concern is valid in general, but for
this particular assignment the masking guarantees the value is always in
a non-negative range.

Thanks,
Sun Jian

