Return-Path: <linux-wireless+bounces-34723-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID6DJo/D3WmwiwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34723-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:33:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7E3F57E7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365963038AFB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 04:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746B17A2EA;
	Tue, 14 Apr 2026 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAZDZreC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED81CFBA
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141196; cv=pass; b=H1/EiX2ShfqWrMzE6IkXbgJGoCfbNj5od41auGcXk9z07WMp2dIVrDs1zBI08EZ2jKSPZNVnpkv0H5FT1F6gATVw/eXx+uxHM9ZE08wG4iYPAiySTnQiZGJIfjdkryqSQvEldamVG7/dx2xp4m0DyKr/HXpNJEebHG+L1mBYV2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141196; c=relaxed/simple;
	bh=pbrQYtKD4WisaSb7e3qne2MS08FEt+nPAJPan5/zYbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmlZC4fqazI8zgh0PrjC18J11+Emqizwg5NYc9Tkx/OTXkPlCArTxz3VkMLXrrdy3PJhZqPMLt//knuL/+1z0VceVFoGDyiNIKzHStk6Ie7D4a5LCXQVhld2MkgggTiUvnyD9OFlaQ4rvl0sa7uB4l1Ti7YK/8yMF0tEORhVCro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAZDZreC; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651ce2484d5so1783090d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 21:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776141194; cv=none;
        d=google.com; s=arc-20240605;
        b=OhQu2Y8YrxRP5w1u0Vpi+dcqHJSEk4+HA7TTiyQIYL80UEsOgNqQezFrR4s70oOyNU
         cF2RcdueApej3xqLQj87JJNPcpNzdIPwnhRB3AwJEbcqkCqRHNvOn2EM86snJxd2NT29
         FmlSsdDg4ikC4ja3Mn12ivN7bUjlsdjYdUj1VI1Je+Z0PyabTVNRlupL0pqzwLjxye7w
         ak2eMrinnV8pe4mmgG+GQVqjqhbS+gb1HvdJVLrVWC5/FEluVFPVteFiitqrL131n8sG
         lQdZjLVBG4RVRwi/b2vq/BQqpWYQIwEnctzMlFkfHT3yXy8FNeu8UGZhltYjXnlOIhii
         szjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UlB39yOAxOU9hWsXQCANsEkyDuzX3PXexhIik9Tf80k=;
        fh=E0TB4y4LMaoFv6/Nw7x0a0BXVcSkrLpEywfy4qTdIUc=;
        b=jowSK3fUrSzC8QHbaNCKAzE4wuPUhpoaQV6vz1HN3fDqfp4VdZ+B42V7mk4FoSZpm1
         ZwTNub+4XIXzJQxBx21WcHZGO71XiHiHbdj2Akklab0htyMs/sml18lF5X5K/SdJ6SMp
         AuDMc4OhC6PqwxjGAjjvfapajrvnKeVNUh32fw3D79Et+TbfPZjGjPql3c9LlxoJTMe7
         bVvFvSwGlfrhnjJOtRIvh8JK055+M2v6RoG71xEcz4UzAwHQ/0yTfqSIhiWtHWTanP/r
         XVs8L+JpsaPxMhYd/4g/KGHpmcnEO+d/QaCLaGpRqwcmf6VCnuDB7lTqs/NnBcPCT5/E
         9huA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776141194; x=1776745994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlB39yOAxOU9hWsXQCANsEkyDuzX3PXexhIik9Tf80k=;
        b=qAZDZreCI+ZtVTAmFmq9/vSVIz9MOFnA5tsIO1wAQ5INhKf2MN1Fbht+PzsUR/ESGq
         A7CUkuOlNab8pw9v9YOjKz0D6A3RG8XrT89PooRjgs7nOEvmSFobatwtmurNi+wzKlrR
         L9svySRa1qVCRIhgFo90FMIFcGXJGu3LZC5bzKvQSUQXFviobNMpRgusa9/P8hpcN85w
         FXVS/H7Za/TpILLiZgFb80X29vg/rAxyDVd6oNRYX71sMkoWCXr4Ow2VzjaMuZtTI78/
         brHtOGksLG+dIfFyFg4JzWdo84RaCt0mKsE03Qhqw4mfpNmeaeZrhzzfES6THCAHvV5w
         5WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776141194; x=1776745994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlB39yOAxOU9hWsXQCANsEkyDuzX3PXexhIik9Tf80k=;
        b=eo//CfVcoynSwKj+zdEaWKH3MgvKuThZMy1nhOsKUJi60oBHAyQbS1ON+y+dstcZwV
         p1Z6jfqNoF8M3yd9ckuL2vf3l0cXV2pvJ1QjkhCOIjPU57PoYGHAH5APC/wOOhqWlx8f
         6fyWanuCmXxk45OwhxjBSCKi0WyJivMf49NgXetQhDlOgDvXQNcV6wZ7nTvWxNd2DQyJ
         Fyt7WhJlpwBHPLuqgx/vFoWMq9KlEHKh9WkP6xue703f0f1WHW/aBajoqJQOeSQOyvSf
         yY1IPrCebI50SM65eZ2rYbGlvG7cgVaUlbO0sJaM8UsCWvIpiqR18E7sk3E3e1PLCNLt
         W5GA==
X-Gm-Message-State: AOJu0YwkssEodiQ4gcigeEZiynxKch2AOfyZjkoFLLGMnlD5Rc9Gm4Uw
	7l0+7y7MwEXjIYWhHRnqTm0ypEJzVdA8EYx5TslWc2fAyCDf4AH7tBLgEmg8BT0M/lSilM7AKcO
	9CpxGvTXWnEf/QKRGQ9DtyWVxn54JUN8=
X-Gm-Gg: AeBDiesxLe+l9R2qZsz45N6UShUz1a7NiD4ivRoFZhote7RHKfZ55CJewIwhAVP2NTc
	ZSMfF/uhO2Gft9EVrilfyhke7jm+iUOkE5Coaayw7Co/Zt3FMnL9iy1bNQt6U1w28JZd19OuqFU
	L83rzqvtcq3d+nkuLDNmZOQyRL3IwihAiEydoosFHVwIaDIp3RI1ngxJ3bYxrDbtKiJjf2fm4I/
	GRYZt4TyO+avjCbIMbc1uc0HtEnjDIV9I47IhA+jWPDbt8P2OoyGbN4D1MT8ps8hfQ3nsKeoB1O
	CdXXHGL70bIushIY/PfUk54zIJu92o/gxjFClGwdKROH5cb4pvREb4b5+wlzTVXw1waz2mhUe41
	aqaJLp6o=
X-Received: by 2002:a05:690e:b81:b0:651:ddd4:f4ec with SMTP id
 956f58d0204a3-651ddd545f0mr2282856d50.61.1776141194034; Mon, 13 Apr 2026
 21:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413100249.28618-1-npetrakopoulos2003@gmail.com> <aa92a81841ec4d1da48916153e07f31d@realtek.com>
In-Reply-To: <aa92a81841ec4d1da48916153e07f31d@realtek.com>
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Date: Tue, 14 Apr 2026 07:33:02 +0300
X-Gm-Features: AQROBzD2_qa54WUwVS6EFussjsY9EJFbToJkYQqZZmDGpJrTXUHGKNrbarBQU7Y
Message-ID: <CAAqNYju+X9+uQwvy51O1ZsUMbgfFCCbujuXN183Vj9pM=OfBcA@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: Add NULL check for chip->edcca_th
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34723-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[npetrakopoulos2003@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: E6F7E3F57E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 5:03=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> > diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wire=
less/realtek/rtw88/fw.c
> > index 48207052e3f8..c4819ef6d54d 100644
> > --- a/drivers/net/wireless/realtek/rtw88/fw.c
> > +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> > @@ -284,6 +284,9 @@ static void rtw_fw_adaptivity_result(struct rtw_dev=
 *rtwdev, u8 *payload,
> >                 result->density, result->igi, result->l2h_th_init, resu=
lt->l2h,
> >                 result->h2l, result->option);
> >
> > +       if (!edcca_th)
> > +               return;> >
> As Bitterblue analysis, this might be a garbage, so I'd return at the ent=
ry
> of this function.
>
> >         rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x=
\n",
> >                 rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_r=
eg.addr,
> >                                 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask)=
,
> > diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wir=
eless/realtek/rtw88/phy.c
> > index e2ac5c6fd500..c10eb28e54ad 100644
> > --- a/drivers/net/wireless/realtek/rtw88/phy.c
> > +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> > @@ -161,6 +161,9 @@ void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u=
8 l2h, u8 h2l)
> >  {
> >         const struct rtw_hw_reg_offset *edcca_th =3D rtwdev->chip->edcc=
a_th;
> >
> > +       if (!edcca_th)
> > +               return;
> > +
>
> The callers of rtw_phy_set_edcca_th() are RTL8822B and RTL8822C, which bo=
th
> define rtwdev->chip->edcca_th. How can edcca_th be NULL?
>
> >         rtw_write32_mask(rtwdev,
> >                          edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
> >                          edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask,
> > --
> > 2.53.0
>
Hello! Thanks for the swift review. It looks like the right call to
move the early return to the entry of the function given that the
values are corrupted. You're also right about rtw_phy_set_edcca_th. I
missed the callers. Upon checking, it's just the chips you mentioned.
I'll drop that for the v2

