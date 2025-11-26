Return-Path: <linux-wireless+bounces-29363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118AFC8B293
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 998BD3578BC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC2207A38;
	Wed, 26 Nov 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmoze9Mi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F120458A
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177336; cv=none; b=BkdqUEZdjrGpsP3w2TtGoa3UvHqiMOagQT2MeDiNNnU+qFE0icRWD6/gVomvlClm81TsLAe41LW7Ty9zqJbLyp6dLIJs6ND4OE882Wrz34SKvoJcxO/+8GZCILmpkAOiM9+dZFTL9NthBCXIM6MRPg0A8GiFycuv9cks+8tzOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177336; c=relaxed/simple;
	bh=6SHs66WoWGtjQH3L9Iq2Mny6L7Qlns6ivX9++VOuwbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtiBf2jMnO41Qs0PtuCFHB1aZemo9GwQ73qV8JClcXh+qOjCBt7qGOnqdKkycAU63ZpnUXx5iYVvTpdKapKgzgbExTCQqwCNuui72zze7YfOL6LSmQrj6db50AifucVLUIyD0YDl9OarSnixzVIfqFY1+CZmj0KavqAlUYiAg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmoze9Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD1C116C6
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177336;
	bh=6SHs66WoWGtjQH3L9Iq2Mny6L7Qlns6ivX9++VOuwbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wmoze9Mi0Vnp7inKtGSe7+8xdZVkSjmcxN7co9xZwh1frBeWLcoh5QnNVTxibFa0M
	 lmSweWooHBs2h653K8u18HiHm49MnWwsFed/45XvHsTjbpFJpKF4vxcNhSkrIs76vS
	 Y8PeFB44mzZP99XC5OKoF4o669mWR3ZNBs8kSeBO6S0zUh0zydJmOaMq2ONh0yyZxO
	 dhwj1VH9wSfmpGZwP2pFGiaBjr04Hnxe88vaz0w9ZAkDWWPd0JBmeriSBKj4ug+NRG
	 6Et/GhlVIBSrfh+iavRmNd9e4/sdh6pUFGR7H7Mkz4FnHV6cJogtsbS1dHncHFhxeE
	 xHxBIj5UDUbtQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378e8d10494so227371fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 09:15:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/jSECOUW8HbDsehpM2fy8cpJ3duq/CH/fPD1Sc2xc7Q1qUWPU/hZvAVdHdxjzC6t1J6GpaaW076sdSj8cig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4sBkUi5fTK6p+x2fS21C+180Cr0hEZTFmS2quWyS6kuXPRuCs
	6JF0on1Rhkws66Qf4DxkAvpiqrGjqbfpJb5j8N6rZyowiJsFrGL6qXlPtr9vYuAtCOrNxdMEywI
	QbRBNL/zZEHZ2guK/wwD9GrYaSV7G9i4=
X-Google-Smtp-Source: AGHT+IHrrmzPVAFgQsvrRntuuZ9ayKDwDD7s4AL9NeupFWgcsn821aySl20O7AgRZrwewB+5f3lrU1vBbbvI8Usz7N0=
X-Received: by 2002:a2e:9654:0:b0:37b:9b58:dcf7 with SMTP id
 38308e7fff4ca-37cd9202938mr51693681fa.23.1764177334607; Wed, 26 Nov 2025
 09:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bf6a29cfa16e31e5c2fc2956a294dd8ed97ebd26.1764138361.git.quan.zhou@mediatek.com>
In-Reply-To: <bf6a29cfa16e31e5c2fc2956a294dd8ed97ebd26.1764138361.git.quan.zhou@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 26 Nov 2025 11:15:22 -0600
X-Gmail-Original-Message-ID: <CAGp9LzqH+xoxF_9LxtQ5WFrqRLob7Xv=M2BmETbW0950OuJpXg@mail.gmail.com>
X-Gm-Features: AWmQ_bmLzOYeG7nxvWUli-MEBvOI5aoCbnBKmP5FcgziO0TVq1L7Jx7AHGKwGu8
Message-ID: <CAGp9LzqH+xoxF_9LxtQ5WFrqRLob7Xv=M2BmETbW0950OuJpXg@mail.gmail.com>
Subject: Re: [patch] wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, 
	KM Lin <km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, 
	Shengxi Xu <shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, 
	CH Yeh <ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, 
	linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Quan

On Wed, Nov 26, 2025 at 1:04=E2=80=AFAM Quan Zhou <quan.zhou@mediatek.com> =
wrote:
>
> Previously, the AMPDU state bit for a given TID was set before attempting
> to start a BA session, which could result in the AMPDU state being marked
> active even if ieee80211_start_tx_ba_session() failed. This patch changes
> the logic to only set the AMPDU state bit after successfully starting a B=
A
> session, ensuring proper synchronization between AMPDU state and BA sessi=
on
> status.
>
> This fixes potential issues with aggregation state tracking and improves
> compatibility with mac80211 BA session management.
>
> Fixes: 44eb173bdd4f ("wifi: mt76: mt7925: add link handling in mt7925_txw=
i_free")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mac.c
> index 871b67101976..80f1d738ec22 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -881,8 +881,9 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta=
 *sta, struct sk_buff *skb,
>         else
>                 mlink =3D &msta->deflink;
>
> -       if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
> -               ieee80211_start_tx_ba_session(sta, tid, 0);
> +       if (!test_bit(tid, &mlink->wcid.ampdu_state) &&
> +           !ieee80211_start_tx_ba_session(sta, tid, 0))
> +               set_bit(tid, &mlink->wcid.ampdu_state);
>  }

It is a nice catch. The change works today but switching from
test_and_set_bit() to a separate test_bit() + set_bit() weakens the
atomicity that this state transition was originally designed to have.
It might not break right now, but it creates a subtle trap. Future
code may assume the transition is atomic and accidentally reenter BA
start path which can lead to hard to debug regression.
To keep the logic solid and aligned with the current design, the safer
approach is to use atomic acquire with a rollback.

if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state)) {
    if (ieee80211_start_tx_ba_session(sta, tid, 0))
        clear_bit(tid, &mlink->wcid.ampdu_state);
}

This keeps semantics clear and avoids future maintenance landmines.

>
>  static bool
> --
> 2.45.2
>
>

