Return-Path: <linux-wireless+bounces-38700-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +tVwN1PmS2qZcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38700-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 19:30:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F1713E27
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 19:30:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=flAYvVla;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38700-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38700-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51C5302DB7F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685F3845A4;
	Mon,  6 Jul 2026 15:18:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FF38423D
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 15:18:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351112; cv=pass; b=bEfLBvdBQ9d+b83LAiQZ6C5w03tKhHw6+rhD6IcTkbYox6Jf8mjc56CPaPctqVvtowBvr2FV4/xeXfX39/74BQFrQjFvZUcBH0kRX+uCCmrUCXvGu3I8xXGGPwEj5ZkQYRnXqH0C0znkWHSyELaFir52gOIQtWDkBNI1fNl0ub0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351112; c=relaxed/simple;
	bh=jC3bJQ27Bxo9y3XtplPl0oMijbYh3kJm3IX2ll+z5B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiulGkvD1DaJyhMsFCHN1PjGvmUT0KxI6RmV/YFg+AX5WQRR12PMwABvAOqXIw+b8g5xmvJ15EPbUayEJNYGOUEMrr1oq+wzZMmSDM38felccY5Fgqeq0xxLCm8rpjEDU5thjqF3UY/qjUQYZLwgP9SbsJsibx2KakN22Cle3gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flAYvVla; arc=pass smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80bd5b5b3afso22551297b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783351110; cv=none;
        d=google.com; s=arc-20260327;
        b=dODLRfS4b68Nu6oP4Y9hdkfMdRdq9T3rH6tLYjy4gQIIH/11N1WQuOaEf/KgqtLipg
         CxXegJ215OP0r7G7Axj/edoESbrKfUf/3Ekx/C0ITPZhffU8nMxfBVRTNUXv0JhnZNRZ
         TX/jbxfDQVZ85Ikpkes3ME8cznksA0bL2UQ9j1KeD1yQc/AnE7rMVq/xwsdfPfVEDRpd
         R3RxvvE+i4uxBY7yyQm19nGeS7J1wgbcvPGfxCbyc6mWZ6AMiJsjlNEjszF/UucGVYg5
         nV4M81PLL6A1lbJgHIJGrJTzDl1tbLxput5MaWju2dYqrWJeUQeAhyETkxkWR36LoAAU
         PlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jC3bJQ27Bxo9y3XtplPl0oMijbYh3kJm3IX2ll+z5B8=;
        fh=gosypC5zA2rbq2qIIZgLbffsNTzYItMoXUG5Ppcg/x4=;
        b=NWudwD3UqlzhHoFNayJRbUmk/ilF0vy3nGxRrzU9xBwf3KtbwU3DMkplpKTQGfY9EV
         Usj1+gRH7f7xgtA67sg2gY8oxF3FHxpjbxQ6FZvaZoJ+x5WM99QsoldAe3DMXuozx7g7
         zjMWKNlJPFhPC09rtHVe/4kinuzlk1gu+ISju6v7YnmBnspLFT0X6btyS6fOH2CgeRSG
         4Gkzfm+hbZjv/4Uj9W6Rfqa5IWYC5sKZfs1vPGyh94cwBiARGrF5GBczJIuqpN9JBqHG
         ZlDxSiFQLi1UzeKEbt67t8sy+NealT9z3J1zhQ4dvb6Okv1E5jeVgEn4pEMAABOzp0vK
         cvPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351110; x=1783955910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jC3bJQ27Bxo9y3XtplPl0oMijbYh3kJm3IX2ll+z5B8=;
        b=flAYvVla072b2t47N8sXY/5BBxma3qq7Ft6EIrsszVSoioNwK5G8z5iZr2dfqBoEnu
         YC9seSvn8eMnJAHb2+gqGY4BgMbTtRMzS8LCvKZLA5Eu9U0V7TfyXbdf2g6dHrfojZMK
         EIFy9M0lE5hTmBY5YO7h2KNyQyiyxq+qwDU/XRTGXDqYjnKjUNX9S3Qll6S0609ZEMt2
         Hf5+DPogP1Zade5o49IFfpcNmJLL48b3PyNM2tYgJVgxO36rj++TdzNX7Q9HeFW53IMD
         h70U0hOyhmcbGqIQxq6eMidOSt59soa+GOpmqW7SKK95MvckawHgN68fQJN2R3+6c005
         mSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351110; x=1783955910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jC3bJQ27Bxo9y3XtplPl0oMijbYh3kJm3IX2ll+z5B8=;
        b=Pj5tvYrDJSpVntC8vSbjtqY+Fqiz6sP5PudAL/K4b7UKp7c9gH0oYJj/3eLDIt325D
         wavrhv6ev3mtxjScIg2ZZPWYEqjsmMZCsZCfacFeRehLxNpuCs93nRGk0QPdN95rWD8x
         9+Nq/uz8l6c6XNdFNWQMR4MO2xgNkV0oXQpKmTL5e0ccNdlj0MV9LssWDGukiEUH3gkT
         lFc/7Dzb5R3zreruV4tFoxon1FgMRCxZBGjB7hpyOXTNkbQV24Vni1P4Mv0A6KXDp02l
         D2eXODVqtAYm/4DkCuixTn0IGoS9YMXa7fBy+XCTfErXgvbaUKhhkKmKHNQtHB82s2WM
         qpWw==
X-Gm-Message-State: AOJu0YxoJdbqNDpJUuNzPyrraeodSBVjpFSXxhfqwXSuX93NP2QSsj8T
	nngSYiirLO72tOjm2HAhb8vK+ohVuQrKNkG7YP/CuJBavVLr+7Or+CpDSNMOnePNtJM5kTQYZFc
	wIP0NaXZGFGmEfW/A1chi2G5iwna04F87W7S7nkcwcg==
X-Gm-Gg: AfdE7cmEDW/dljJQ8TIAh8r7QeSCOScIb2tVf7cXhjpnz8syJYKAJyMtvuQ4MV6okD1
	dQ9vxjN0HFt/WoGYtAlLiN1vJwZ+mF02f96e91YU5krsABsFo4FU1qwF7C7OviKGNjIa0/XgP6N
	Dq1v2jS8rYSc2MimLcihtclmLGaSfmXm9JoNWomNefp+2/tqtS5kG4Wgg0vV/LcyDd2aVc5bUsf
	J8y65CEO+hAaRxRp0iIKZ0v8E53tH+bCwVTIsZsGO2BRxwh3TxjedF6Z412iSRuAxYb7qKH5gg=
X-Received: by 2002:a05:690c:600d:b0:80d:78bd:7a33 with SMTP id
 00721157ae682-81be26662c7mr6118797b3.41.1783351110315; Mon, 06 Jul 2026
 08:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619162500.3876325-1-zzzccc427@gmail.com> <4fc7e89b3203e9bc8843c848268519d34585a038.camel@sipsolutions.net>
 <CAFRLqsXDDO=fzwwe5eNEkS=qUjf9=2X=NrX+LcZ+TNkMN+fF5Q@mail.gmail.com> <a2dd36c58cb228693428c5a5abe3e14ef6376e7c.camel@sipsolutions.net>
In-Reply-To: <a2dd36c58cb228693428c5a5abe3e14ef6376e7c.camel@sipsolutions.net>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 6 Jul 2026 23:18:18 +0800
X-Gm-Features: AVVi8CeMV-9EfV0BxVK95n3YFJOgoQSwAfF5eLPOySFC_1thNpUU4XICs5fFeFc
Message-ID: <CAFRLqsUppSE4=2nQmANrghfyo0w2r_spt2E-=+KwX=rgqeRLBA@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: serialize socket owner release with netdev teardown
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
	TAGGED_FROM(0.00)[bounces-38700-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 429F1713E27

Hi Johannes,

> Sounds like maybe it should just be a wiphy work so we don't have to
> worry about the locking at all?

Yes, that makes sense. I reworked it and will send v2.

Best regards,
Cen Zhang

