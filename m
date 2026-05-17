Return-Path: <linux-wireless+bounces-36557-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4aCEOEpFCmqcygQAu9opvQ
	(envelope-from <linux-wireless+bounces-36557-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 00:46:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6156434D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 00:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CFDC30087A3
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DD302753;
	Sun, 17 May 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhN56VSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766203009E1
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057991; cv=none; b=URUDPcJ3sNKt75lm9zARaLJrWyrIaKJFnBrI9cl+0G50hxtfjUrR/jU98f0nq8jZgJZrrkNsTLeBAtVOWeb8wGSEFFrCR7aIXZdsv4OIZyJxidIf9XpmvYclmQwhLGCYVVUnoUEDxMWPh4hPonYpdbCug4leDxODoJHou/GHukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057991; c=relaxed/simple;
	bh=6H1Vsu3hcFYqN/1J56hlrnz9lSQww5OPgA0UX662gFw=;
	h=From:Date:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HstMMwA0Jl8p83uCugTUKwEd8OFnVsz+A7Y9eGGzB7fsRJoYvZs3Bom5+V5RmcY7KwSsHu3WjUPwoZRPO8WI1XUkLQffhcecFTQcatIvD3DrWmm7ZgjF1xP0356VU+iQm995ostZmpww5fkuki+F3C9Jf+s2lyJd5XP8Stv3r1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhN56VSA; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so6934647eec.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779057989; x=1779662789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H1Vsu3hcFYqN/1J56hlrnz9lSQww5OPgA0UX662gFw=;
        b=JhN56VSAcNrzz7vVFtQHh6LD+ksXISLTn18Ia3iHt4cILMkpGj5WtHQ5BRgsaH8zWI
         y/AqdI/7RZ1Ehn3aGG1DoB/NXn8/pVIOaYgHovXTAu3+i2N7yPWSPYBzja6aJeYZ6V3m
         PSJiBvP2kx5XODs1c8GoGZ9/sUxG2mCOBMENXg+vAxTFgcCnGqYSI+2DYamOorJeLV2J
         KS4nwqrsJhCC723QSnWv/WBS97uKJrJIVRW/B8AEZhZRFKq5e5vSj2COyKk7o4CEOi6C
         3GG89OZ5eAmndTQYTSVfKWb6e2EWbXJF34446BBgek76Iu8Z5bAD/br4WeVJHEb7YIHo
         /psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779057989; x=1779662789;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:date:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H1Vsu3hcFYqN/1J56hlrnz9lSQww5OPgA0UX662gFw=;
        b=MS6ao3kgUAImj0s9X+tg/PrhGZSJzQrcrdr0Szw5oB2py9FlYvrwLniFjoktrRufo5
         uzeOUnXiZfYTCUYHy3D6TCsGHr0a+N/v0Toq8WY+JN7JoSQEdnOxxAK3NLOm19N+DteZ
         D6/RlnYZnwAAUSHbx4vtN5SxpQ3sfpKhymrMVD27nTHPF9JEpddZIX6iavtSONqQRUBR
         /PaYgFTeUzp74pFtZBe3kfmbzQ4cEN9GUaMh1IW3neJry4t1IQ2YuLQyyEldHQAd5vyD
         300mT7wnIYpbAfuAmzebVWsLAYuV+C3k2ahxViB71xgyFWuT1QTONx6ZqCEvfsO9usQh
         Gz4Q==
X-Gm-Message-State: AOJu0YztniMA9sicIQBLhjtbLyZOOKe2LqXQz7TmyvvOJ4IiAoIpKW5S
	WICb0zgYuNFw7uofSgRvfEReNnkTWWbB8We6zwti/rF99uTkpF8VJVV/WcxksfDuG8o=
X-Gm-Gg: Acq92OHrJmfjsmyb/qbzmZMaFWZQ1jjNiYFFLxgbMQW3hpGqpnZTnWf20ebarVG74Ae
	l0S98Qe07Yqbjr4cPY5F7D5BECl/4LIZ3+54Lg3BLPHqI6IQ45AerQP60A+v7R8LgsYC1bpiS0A
	O17pIAVtD7Ufjhqtyuf28T4mRFCjGL0BOQGw07r5VgZWeTLzCxfAd5DN9DpNj2rSxbQbVEbXy9Y
	sIOa5YWuTLVxxG0JBl8M1Bxo7zc2t9zZCk6ifGTajC0ZMt5zuysCFm9Z70QslOMBxUq84kopKHs
	kGa6MWZM3II6UG+ueOs+3+IUqdEPDW+QzVhsQKLdMVAZgm8C/7GU6Ghl28ADULOKpMHao+rXnMO
	uCmvCRLILHEC/1nIYDBr6qrFdN1DpK5SmF4eWPs/5UdyP+oo4oY+ETGiYKh2ifrXEvi0OfuHbIT
	OzXsY8j1dhY6ZptVk8HZwFzcv2LZ5umT/ki+scSw==
X-Received: by 2002:a05:7300:6429:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-30397c321d6mr6481143eec.0.1779057989443;
        Sun, 17 May 2026 15:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([104.28.195.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30290c4a699sm12727633eec.0.2026.05.17.15.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 15:46:29 -0700 (PDT)
From: Ruslan Isaev <legale.legale@gmail.com>
X-Google-Original-From: Ruslan Isaev <Legale.Legale@gmail.Com>
Date: Mon, 18 May 2026 01:46:19 +0300
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Message-ID: <79943c87-b920-4ef8-a471-61b03792e097@gmail.Com>
In-Reply-To: <agEbiurBZzZv_Yt0@wico-dev.wnam.ru>
References: <agEbiurBZzZv_Yt0@wico-dev.wnam.ru>
Subject: Re: [PATCH] wifi: mt76: disable rx napi before queue cleanup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <79943c87-b920-4ef8-a471-61b03792e097@gmail.Com>
X-Rspamd-Queue-Id: 19E6156434D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36557-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legalelegale@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Gentle ping for review

May 11, 2026 02:58:02 Ruslan Isaev <legale.legale@gmail.com>:

> mt76_dma_cleanup() already disables tx napi before deleting it, but
> it still removes rx napi instances while they can remain enabled on the
> normal device remove path. On mt7915 this triggers a warning.
>=20
> Disable each rx napi instance before netif_napi_del() and page pool
> destruction. This fixes repeated warnings on rmmod mt7915e on
> mt7915e/mt7981b.
>=20
> Signed-off-by: Ruslan Isaev <legale.legale@gmail.com>
> ---
> drivers/net/wireless/mediatek/mt76/dma.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index f8c2fe5f2..12183142f 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -1189,6 +1189,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
> =C2=A0=C2=A0=C2=A0 mt76_for_each_q_rx(dev, i) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mt76_queue *q =3D &dev-=
>q_rx[i];
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 napi_disable(&dev->napi[i]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netif_napi_del(&dev->napi[i]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt76_dma_rx_cleanup(dev, q);
>=20
> --=20
> 2.39.5

