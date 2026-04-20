Return-Path: <linux-wireless+bounces-35100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIFpDNKQ5mlWyQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 22:47:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED6433CC8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873A4300E5E3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB4349B0D;
	Mon, 20 Apr 2026 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs1FErZj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924602D7D3A
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718029; cv=pass; b=mB6t10oD+o9bRs2qO/ZMNLnWBSFmaXnCDiKYWJWQVi2XL7/V/GofQ6W+lhWudstxhgEkxwvv7v6M31P0QTw6Y2JffOVuTiBddY7dSv1uPTfX3zhZ+B/Psh8yeQB8S3OJ403BHyaWG7LR2YkUvZLPGsQ/1MZw208FEyamNH6rP6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718029; c=relaxed/simple;
	bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNUMQNMj8J3uEVK2wLmvoZ5Dx1bWw83CtuIGV90ATJZqvSPv7rbnnIkKimwZECTSNOlXu59agN8sh1coJ+rWOK/GZ70YbuyDiKFmiJYVjnM0AvXIy44uid6e4Wr6028xnlae+RqLkAlaHNQYw2bQRmd1gN1bwWDvqKjqg2uIBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs1FErZj; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64eaf8aa893so2832386d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 13:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718027; cv=none;
        d=google.com; s=arc-20240605;
        b=GBXvUe3ij966SbLQifh0Morx980A9ZLD5fgkayr9HUc7TePYG4krWZQm21lAyvwsmf
         8tnY7fRkh34UJpgLSofE7DOV+V7WxpiNGu6Fija1DcUn1juzaXU7UVoh7+z72H8oELGt
         AoL8YA/P/E+L5gY2StagTIA43FUSJt/5fAjRYCkPK+vCI9ojengVqYqyHKvSWK5vv/NQ
         79cD8hafZA8fRRaPCAo2463eQLsGmNw25k1eDA35AnDyv11c7BKdcc+HidozXm2O/Fz9
         OPmahV+XOsOx1ep3Zbupvp4fm00j0Bc94O0IXErE6sq6SGnreaSmVds9YalDfK+9IuEE
         bxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        fh=rMhNNTtWEqDGxCF1m61G/J6QMBnKr5VAjSFlbpaQcdc=;
        b=JrM9JGSQUJUCwMFvgBe/17Ekx+DchST+JqksF5zjKX6JscpGlFeVc5KEWEI06NcSBK
         /yqsUFNtJ0yv5q06xMVn8Aw04ZmgDbOHKjbOOrcBemBxKxtCvXiN9EnQ/73cXA0dsnE5
         bBf8m6LKhtdgDUTxTzFbnKQdriOmVY7AtnJwsYEBVS8xwYwr7A8519mdLUjcC/PbC0tj
         1EqLVesJTUbhPIlOb723p1EB22lj8xEnul1goat3JAdvqKJ5WKWOSk/H6ZIBf8MGYSyp
         Wa1KOIrc1JmGds9rBn2CAXxZRfAdOJaCzXUnMM1oDk76LJi7LoKby9jgUsPEru0WVw2q
         PjPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718027; x=1777322827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=Rs1FErZjhllYj/zWS4WVS43ZHxW9+hPweM3fZm6XZprQfpZvSS4ZhNIM/j5VWF+GdQ
         B32kwXRa7FEj3O6Qyr84XDy3aocB3R3biyi4PKKft+LzMmeMnjn7wVX2FB9fLUB9si8h
         xKytzAaILhu4xym3bq46IHUcKIhmURBMjhHBcB/JX6KSqf2KYV3j8cigqWDLWljrc+ja
         PfdOiKi0s5NPgj/kMOqXyZFngFKFNKCagwnEnp8B7lez5dwLcueSPOqGbIazDovNqWv9
         lCjafUpjzczZXeJY32PnT0ci9+KLLu5H0jxOKW5aYblCR7yRJvBy8hmfyO6PLDHRKO4a
         yzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718027; x=1777322827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQ381gyFls4AWTGtbPx+Abo8y02DoEXmdw8t9bbWC4w=;
        b=NkjiexfmI1iUZhQSlVV/mVKQeqSaN3YLvphBcyWWLicOQGUcp17kKqNsYW7ojDtWIE
         PVAsXf4J84Dp7s1wxMY0hYwvTcdIGJsuXJbOWxAf/QHb39b2b34/6fbSB1F4opSgbRGv
         gKfi4rBbdzn0TGa7g3XnYgpTDgTpQT9h87Ug6OTzv3M6cgbxkCEmQWdETB8L1K0Q6/Z7
         HbgUCiIGEz4EuqrqFagy/7hx2I+av+B642lJ+V/JxGPirtOuz2rObzSRwXUjN00tsESp
         jwd0HC6Mg1PxwX3wwdpx1bk/NClG0WCpqG3/9zm+MKp9Drn/r635/krj6UqJx4XAFzkd
         CmDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8icNLpKQ2vxSI4nJW8Pdt/fEBOcRkHuiB08jzG8K+vnjM5LBHCZDeVo6cWVESt/I/9ueVrLbQnnMQjd9e/uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynrhknN30bCenqJ3TENSXc0obxiy91Rx/q+K0FWM8eKqHzHC3G
	gQLHiyD95OW+VavMrBmuCxMIWLQBRuNK0Ubk3DtHV4hdjIuj1QfDk54I67tQPP3Uwxuq5WkUJcQ
	ludfr0bofu0lPFizNN31PqEHQfxPcBJg02CYervk8og==
X-Gm-Gg: AeBDiet4plphIo7DIcXRIrwVpSeShDQ4m5dbVfHh6lM4JeTKA87Ok0z/J6KKor1+1MM
	Flu+i5Z69lSVxbD7/HBWRbsUyNl9UqfN1UVRjLQPp4tVT2INKHUZ3fAupBOM3xKfN/6s2Ef2DEh
	c7Sd7peZRaQZl4KdzmMHUpwy5O4SB0rcwGrjd/n2UuDDK9sKuobbr1UagTcSeLj/5tZ4kZKNbCO
	GRyhlOoOw6iJ4URQu3zufCjNigcpyNf7fwrD5PO+hmD9wjQznRIgeNISboFjS7aNWcM37R0pWsB
	Kr5uHFs7k8+BpTFkK/58J06SnqguRQ7i4cjGJ9vDpSFC7k9HEcLwY2RiHhjDmGXeQ/uUumQN+Lk
	ImW7O
X-Received: by 2002:a53:c049:0:20b0:651:ca41:3ce1 with SMTP id
 956f58d0204a3-65310870e0fmr11419676d50.26.1776718027650; Mon, 20 Apr 2026
 13:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
In-Reply-To: <aeaMkfk_1t98e7SU@monoceros>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:46:56 -0400
X-Gm-Features: AQROBzDn0VxgmPSE3vK5sUClFYZviCWKHJM6c6xPINx44xwN2GgHY3fLhlrfQ5s
Message-ID: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35100-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,codasip.com,vger.kernel.org,linuxfoundation.org,sang-engineering.com,holtmann.org,gmail.com,collabora.com,lists.infradead.org,realtek.com,nbd.name,mediatek.com,chromium.org,dolcini.it,linux.intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,baylibre.com:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97ED6433CC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) a=
nd
> > this is used a lot through the kernel. For example it enables the usual
> > practice to store pointers in sdio_driver_id's .driver_data member.
> >
> > This works fine, but involves casting and thus isn't type-safe.
> > Additionally with the CHERI architecture extension there are machines
> > with sizeof(void *) > sizeof(long) for with the traditional approach of
> > storing a pointer in .driver_data doesn't work.
> >
> > By replacing the plain unsigned long .driver_data by an anonymous union=
,
> > most of the casting can be dropped and it yields a working solution for
> > CHERI.
> >
> > All users of struct sdio_driver_id are initialized in a way that is
> > compatible with the new definition, so no adaptions are needed there.
>
> sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
> log and once in the short log. If you consider applying this patch
> please adapt the commit message accordingly.

No problem I can fix them up once applying.

> Many thanks to those who created sashiko.dev!
>
> Best regards
> Uwe

We only received 1-3 of the 6:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520

Or is this on purpose, and we should consider the set complete?

--=20
Luiz Augusto von Dentz

