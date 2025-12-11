Return-Path: <linux-wireless+bounces-29680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96BCB76B2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 277C4300106A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA72C3256;
	Thu, 11 Dec 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNkUhi0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154301FF1B5
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496853; cv=none; b=j6LAGqkIj4+Cw1qZSRI2YtnPx6Cs41QvvJ5/RW19iZ7roEwEI86eI60BzKn7AVXtSzQeo7hzjSw4IExqZwf138lS1RVUDNoJA49limnvqI3UYe0kTqAAb+Q1eNA6Ln8iCXraoyLW7e2k6HmJFsf5Pk4HFyk3Cf7l80zdTWu8w4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496853; c=relaxed/simple;
	bh=bje5S2tO81LcR3oEMnuyNXK8MCzYbRCVPpr/63ZWRy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4A/Ig7I5rUZUw2oKTX67H39QQa553P7iNnCdNOyUxIg7zZHvYj+wMB4bpwDzrnESHM1i4dWKSt8IUBeMoIi5t51gPkQJQDPdUN+A1SDmDxBS4rcSiF0jWdk+FeDgJDek3JtfPh0H7wPO7k8feMO+Bb5cUGVQzpH2tXFon8Mres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNkUhi0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F0C19425
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 23:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765496852;
	bh=bje5S2tO81LcR3oEMnuyNXK8MCzYbRCVPpr/63ZWRy4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SNkUhi0vsFDkEFIDfZxCrKAjqVeRqvOyZSo6pxD6CVg4rMq9qSAIbjSxD/ITtWyaM
	 EnJL3KBqMXuSrWqNE0bMN9U/+DOL8qiD+UbrOQArKHhgFEtCUKkAJX3roHiqkPHEpN
	 TEjdNMHc0bp0xqBPZuWzfYMxBeeD3UDoYcX8ZJZ0b+mfH9IKqQERdsJHLRW+XB2z+B
	 6iQAfzob7H0O5MBgwxrH65b6FRP/vlx3DQ+2R+G2zfFhmfKMArhF8Wyr2Hdawq3mAs
	 FSdoRFpsuyJwX4YiJQcQkdL7XAvsYra4dii4cDafnR5MpMSAnVnw+6pqQSUQUK5St4
	 RAQ6O/vZs+/AA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59431f57bf6so737775e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 15:47:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhPJAiQW26T+HpdmkZBoMHZBZj2h+3RSMR+8IXRu2qyekxXl6QsHjyMJ0g6UbPqRfUTtC5CKWqY49T7/CNvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YbygPyaCNUGrm5Hnn/2q5LSimZC8LP0fBjsARkFJVHvEhpqE
	+xcbFfOtq3FwAmwYu676fy92ZmuNCU4G7UpHLECYkNlbgGJx2vem+AeA3CUK6aJ/uH0UEPD7o4j
	KCSu22kgbmPZPfAV4lpOeA8vJQ4mkpWU=
X-Google-Smtp-Source: AGHT+IG+tynJrEuFVmI9CGQVNWs1wGZ9mj2gwDEXwVEvTcf/I9XnBHIRwne+P0Qk/JsMpdmNrWEUtWaXp3jTSpSY9bs=
X-Received: by 2002:a05:6512:3da8:b0:598:853e:72fa with SMTP id
 2adb3069b0e04-598faa996cemr6981e87.52.1765496850964; Thu, 11 Dec 2025
 15:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5960fbced0beaf33c30203f7f8fb91d0899c87b.1764228973.git.quan.zhou@mediatek.com>
In-Reply-To: <d5960fbced0beaf33c30203f7f8fb91d0899c87b.1764228973.git.quan.zhou@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 11 Dec 2025 17:47:19 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrvD+Go=StCU=iU4KERyXfK5VB_xvonHNFkGxDyy7p6mg@mail.gmail.com>
X-Gm-Features: AQt7F2rPOclLMuFQPaVaug5PVxJnxqf4ihQeSo3tetqH5UXKLK7pgKOl-k9a8rM
Message-ID: <CAGp9LzrvD+Go=StCU=iU4KERyXfK5VB_xvonHNFkGxDyy7p6mg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
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

On Thu, Nov 27, 2025 at 1:55=E2=80=AFAM Quan Zhou <quan.zhou@mediatek.com> =
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
> v2: modify to avoid weakening atomicity
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mac.c
> index 871b67101976..5e5b1df78633 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -881,8 +881,10 @@ static void mt7925_tx_check_aggr(struct ieee80211_st=
a *sta, struct sk_buff *skb,
>         else
>                 mlink =3D &msta->deflink;
>
> -       if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
> -               ieee80211_start_tx_ba_session(sta, tid, 0);
> +       if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state)) {
> +               if (ieee80211_start_tx_ba_session(sta, tid, 0))
> +                       clear_bit(tid, &mlink->wcid.ampdu_state);
> +       }
>  }
>

Reviewed-by: Sean Wang <sean.wang@mediatek.com>

>  static bool
> --
> 2.45.2
>
>

