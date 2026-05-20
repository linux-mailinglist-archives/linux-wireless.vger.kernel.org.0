Return-Path: <linux-wireless+bounces-36687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN5JBKlqDWq+xAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 10:02:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA629589502
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 909993027C71
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB136BCCC;
	Wed, 20 May 2026 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUk6DGpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20793537CD
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264164; cv=pass; b=lP8gi+jX9zssGN4utVZFKrTCLa/Cp0sYrSOYOJM78fRYLxRIcgrDGztiEe3BX1VWhAOqCBTijUxK712Jt7moQcQQXKOgj4v8kJv3TAFbhX8NAxeWbkG2qdMmwK5SZJykkJaGz9dwy5HLyZnW/DK7lLL7lhH2Pn40YH0Fc+4Izbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264164; c=relaxed/simple;
	bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puN42V0fcDbfM/Xma5ebJHYbxIS7mJTmyDN2qFL/ZumVRXTIP+RkZIT3xQzGGim/rUiYmOLKwi44ouymE+EKkpYrT3vnrwQqhYFPALLZ9ybH58t1ylw7XeXC5pxfPSFHsNearfR0z/K0WNEzHDasu6znbq3SiHAZGHoHfF4Z5v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUk6DGpA; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479eb8bcacbso3061733b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 01:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779264161; cv=none;
        d=google.com; s=arc-20240605;
        b=E/CCVrSeuU+zhIKmGC16aKtkqh0SuWFsW6K7seHAikrE++xw3tVcOcQQZFC0QOTJnC
         UTQp9TzehzPWYOIuJucK179oaRv49oXF3OgBA1RArmko+a3CzObv2m02h6wIBJ8S/pmZ
         AKTXw1IOWMY0LJfsBy9zj4Gl3bUl01HPPfnEK1Ah2P2UvBdCKb1BniPDfaGHtDjaRDIb
         cb1KLnggO9a4objk53n/OTQxdivOYJkiUQwPo9eoF+jsvugFa+70GltiBXeKRq+mEz29
         2G5o8FBbTPuGM4bTxsPqDLLcoTcCRBnRvH8xIfK7Cry1xQ43lVYq6TumgP4qtt/sAIt5
         hSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        fh=ndYoOvyh2g7LQKDogIQk/ncfJ8TeI5jyQ3Eso+daqDc=;
        b=PPTiUTrhMaNd6oQYgaXvSvhS9UokffmVPJKZLvXHu/E/pkVAQZJTS6R+i/mg5OnY4J
         ZD9lP7lPESOy1boGgxBWo/Z8SVaC8wpX2LF1e0Mt9nGNz0zclBVXhd9FxsNZvuSs7+hR
         Ex2Q5p2FHUIiunwCZpsPgFfnGdi0CvJ2mynsHV9HzKuEpQRVdXdHhln98epkAwh9jpS4
         1aKxaRGN+6ipwwvW+W+oQWD4yo7HF6IzZd1hICGfkse2eUPQVFS6pkYUjAyHLrjZLe9D
         WLYF7NVGXuD7Gd0F0Eh1hMq/WNvK9PARxN5hpPXyCzrqAOh9i4pkLBJ48DT6qTuPfxC+
         gSpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264161; x=1779868961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        b=mUk6DGpA1Ue03dWnFJ4DWPhYDmO5VoToee+2uXT06ymRm9FFByjpUeIMlMFnRa+ZL1
         LV+/dG5AD0mAnkq0XitHp0F4euLbVl+KS0u2KCo/y9dtuCfPESFlTVNLNlKUzhg/NI5r
         HeRduZtz0sjHUT6O2Al2Q/1e8jyqzcLLSuro78lFD1sOLZac7IDEHZjHu9Yel7qLZtKz
         Mij7ue6uar/OJjYk8GAstk1rFIEqWh/nxUKCKNkXg8OVrLwIX8RQokldTp4m0LmrQ6ju
         1FqjsInPYO94iHi9ljny6mGPybnX+0UVlz77To0GLNh8duePgc1cF3CQxsHGfc6PN7MW
         225g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264161; x=1779868961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/a4gL1PZz1slytsd4o4d8lYxRZ0OcTJf4YPwN0h7pk=;
        b=PvRNjc9qTWHj+5+4CoBDPxLbJJ9V0qRmQfxfm6v5JpdetadHFoqXkbaikUbTD5RpE3
         bDaYD+zd4+3bd3f0/s+SOInPvR1kalkEDJB8qEmrv9nQ0V7D1WNpWBolsHs45vxXC+vE
         4LkQ1I0qAMgE36rupLVLsXlsP9x8Aq6Kfa1VXeUVOt4Ko5c8tEcacTJsiFjq20VQbwnw
         42d6fJPDhPI1vGwrXNJ+qHfILu3sk4p2Ccmkhfa4cuZjX25Ac7E2oxZfsegoB/bvSPKZ
         /TzJx7Pj6Rs+CQnWe+UerlE6YoPP5MaJPQs7UBRg/3iZlWyIyLD8c89eD+i8HLHRWzzk
         jBCg==
X-Forwarded-Encrypted: i=1; AFNElJ8bo77Vwh04dErRRGmSNRuH4BhgmpZSY7jytCm835EtkPY1A7ej5NLcPvB7bC6UbyF1UcvfQ0Q35F2kFbAtcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzywR/r0dX8llyQpkR6mxk3JrNNnC4FU/l+/TRsXGQ2T1V4Rnf7
	W2wnV0e2Oxt0ExgCxahy1amyR2t3vh0yQfV0QMJTPIuQ7+pTzcyO+Z7/CIHij5uO9VOo8pf86Nl
	8y+vpqK3zyNU+BxvRX8r4gE3oNLmgkio=
X-Gm-Gg: Acq92OGtTUGARUXoXtIuQjxmtcUzgM3TPOQazbU6kVUzSTqwbeNlXMArWzBkKCkWmht
	bh8rtTfKR0Y55iS265bP1CNwntKpRL8N8ruNzUYJsgG+7j21vqwoXHgiJ3GG8XP60ZAA1Z0q2Js
	SZHfhOByek0uf2cS6mzFK9X1b05sh9eQp8OnPmiX5MejiTVRMc14simOiWQiCx7/6i7Dre1SUfR
	uZV6rL0SodChu9Xx/UmxoCiKTTXolwmCeazPWVmqfgHvWZZxcnaIcsuO2M6awcty/KfEcYdIaRb
	FHYzy4Zl
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id
 5614622812f47-482e57c9a13mr16207337b6e.24.1779264161542; Wed, 20 May 2026
 01:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com> <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
In-Reply-To: <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 10:02:30 +0200
X-Gm-Features: AVHnY4KgIzywot1ftSi28n3qwN3PfKiGgB8NJ8ybz3nZj9W9LlE5FGmH5nqW-RA
Message-ID: <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36687-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: AA629589502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I tested it on 6.18.12

Let me know if you need me to test it again or whatever. I remember
during my testing with the Brite's different patches that is not the
same testing it on 6.18.x than 6.19 . Some stuff changed and the patch
needed to be different. I've added Brite to the thread, he can add
more useful data for you.

Regarding the approach of fixing the bug on the driver side... I've
emailed and contacted by IRC to Lorenzo explaining the problem... but
I got no response. So if we feel yet like this is something that needs
to be fixed from the "driver side"... how to say it softly... we are
f***ed up :) . Maybe the "hack" way dealing with the vif null var is
not bad idea after all as it seems the only way to move forward.

Let me know if somebody needs more testing.

Thanks.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 9:42, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Wed, 2026-05-20 at 08:49 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > Let me know if any testing of a concrete patch is needed when you feel
> > it is completely fixed.
>
> I guess Devin is saying it's fixed, and I'm saying it's the same as mine
> so can't be really fixed unless something else happened in the kernel.
>
> Do you recall which kernel version you tested with? (I don't.) Perhaps
> something else in the kernel changed and it's now OK to make this
> change, but we know it wasn't working when you tested before, and I'd
> rather have it not work than crash.
>
> johannes

