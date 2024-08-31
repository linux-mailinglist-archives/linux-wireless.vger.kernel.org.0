Return-Path: <linux-wireless+bounces-12289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C351F96738D
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 00:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402B8B21CE7
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2024 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70C17DFE4;
	Sat, 31 Aug 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyJKpc3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6416DEAB
	for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2024 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725141992; cv=none; b=IdxJ457qWZvzFMKBCVbFkbKivkEYXGqDgnNeCn/keV9Rj2XgLshDo945FRmpCCRM9GbumUPrVeaX7eMvRbbHjNlosmjcaNJPndnM9Le4PIIx+4jcUYWAjt+HN5rvD7x4n+3BWL0ifS2TZHMa5gTK/FkhXthuIW5AmJpX2p+VypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725141992; c=relaxed/simple;
	bh=URYZSMjzpOd5c2aaN/uOfpoB+mVngU0i5iVxY8dxHFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSWvX4S+dA7VaaIp2iVebQQLSBBmRsz1toJ//SWBuvYSrApwZfBwEVQGyCIwbPTSyt9pwXwReNb1GOaRWptKPTAbusWSrBYxb626X7h1Qka0iEprKzhNMd7PYp6vwg0UVK/DI85Ntqc1Wu+JIAKYSrKW6XisOuLG5p2ig1OUXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyJKpc3C; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a82d1ef62so1711898276.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2024 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725141990; x=1725746790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ulQrbsPKeNSfASqPUtGDS42+PHiB38d6gRplMWFmY0I=;
        b=GyJKpc3CZDkx3JngxVCKiGmc4SZLRNVhzeTKnY8TOyWcl5nbYIxhRCZFB3+9S0sRte
         k9hXMojcdZ2IcQ1JD3L4XN5NZrhpKLiW/XuQbC7RK6RR7FMXJsvT3/T6sr9AAGqCI4+i
         Kpm3dJgV6vnnztw+A4v4Jj/R7MsY9ux503o2XgjAsb5WKoEV6Y9cR3EHoCAQ9iAncEMe
         fL+0cEovzoKTrtFtotXhanVn43asQlbJ+12eNGCZ7ATdBLWZeFX6dcIs8Gz/kcmPMXr4
         NleIuCmzRToRp2lR+AQlsKVc6DOsSU/q8JPh2/Y/7W5qDCKZtUXxE0HHiSR7U8b8kY4z
         r09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725141990; x=1725746790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulQrbsPKeNSfASqPUtGDS42+PHiB38d6gRplMWFmY0I=;
        b=Q8xdU93ISaJENv+AiPI2Kw7ShV5i4niJjmITBTl6rp6NF2Dio8YtrPVt7icAudqkpq
         4pJLL7KJoEJ09mypoEnkm+3NNKxoi5TxHZsafp5DuOl3Hc1dMYlnrF556X5n26dniCpu
         81NlMmSaH5E6h6VFP22O8SnGEAo3YSckPs7rPlkNDqaAPsMoU4p++0Y9Gl3PLCvkb8uE
         LnLqRxdU/hIzeO+9ttU28wVZ7U1TWCQjxzH0Uz8K68TWvUfKyIa1pQaI7JEo/jqZgJ5e
         v1va5KPzNhlkR3L81q6ytaIa5JyI9lEpCOsg/ypTAmc+pG6s+QvScPau5S36FFQ+r6Xj
         fT9w==
X-Forwarded-Encrypted: i=1; AJvYcCVBZd+UMYsU72tPiWIKoWKjcecRqjHDhBbE593tFVJrlGtN2A1pl0gKIHIpXZFNvo2ektiKkNrLnqYhWxdPNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1MyQxtJMuvz0Q5JxrJBzjGIUD9bMzhg+Aiw+fGJ6KGaojAAA
	y1oPUm2bu2fSZHaeOD3NidqxnTDeIV5Rmz3uj6g/M2SQWONDxErh3gLN8shKRW4GIyJh1sW7Qiu
	XApF3OU1kRJQXdkx6AQ6uAv+FeRc=
X-Google-Smtp-Source: AGHT+IGAwrWf7EGVz/bVMNvK8zEl3gIgbALsHsMVb86jJRhMXd1l1F//XDDxFyoceEhPRZCbiodQ7TVpLLRs2XP22EI=
X-Received: by 2002:a05:690c:893:b0:6b1:4eb6:345e with SMTP id
 00721157ae682-6d40e7824cemr79143697b3.26.1725141989899; Sat, 31 Aug 2024
 15:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830073229.21593-1-mingyen.hsieh@mediatek.com>
In-Reply-To: <20240830073229.21593-1-mingyen.hsieh@mediatek.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 1 Sep 2024 00:06:18 +0200
Message-ID: <CAOiHx=kaKhVw8YW1ih7Xjz9T93G5a51hLJ_5J9rqTp2EuYnTOA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: introduce EHT rate support in AQL airtime
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, deren.wu@mediatek.com, 
	Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, Leon.Yen@mediatek.com, 
	Michael.Lo@mediatek.com, Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, 
	robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com, 
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Bo Jiao <Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 30 Aug 2024 at 09:33, Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
>
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>
> Add definitions related to EHT mode and airtime calculation
> according to the 802.11BE_D4.0.
>
> Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
> ---
>  net/mac80211/airtime.c | 352 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 349 insertions(+), 3 deletions(-)
>
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index fdf8b658fede..1fd9bea61379 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c

(snip)

> @@ -55,10 +55,21 @@
>  #define HE_DURATION_S(shift, streams, gi, bps)         \
>         (HE_DURATION(streams, gi, bps) >> shift)
>
> +/* gi in HE/EHT is identical. It matches enum nl80211_eht_gi as well */
> +#define EHT_GI_08 HE_GI_08
> +#define EHT_GI_16 HE_GI_16
> +#define EHT_GI_32 HE_GI_32
> +
> +#define EHT_DURATION(streams, gi, bps)                 \
> +       HE_DURATION(streams, gi, bps)
> +#define EHT_DURATION_S(shift, streams, gi, bps)                \
> +       HE_DURATION_S(shift, streams, gi, bps)
> +
>  #define BW_20                  0
>  #define BW_40                  1
>  #define BW_80                  2
>  #define BW_160                 3
> +#define BW_320                 4
...

> +       EHT_GROUP(16, EHT_GI_32, BW_320),
>  };

You define BW_320 and groups for it, but currently
ieee80211_get_rate_duration() rejects rx_statuses with a bw > 160, so
you will need to allow BW_320 (for EHT only?) as well.

>  static u32
> @@ -443,11 +771,20 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
>                 idx = status->rate_idx;
>                 group = HE_GROUP_IDX(streams, status->he_gi, bw);
>                 break;
> +       case RX_ENC_EHT:
> +               streams = status->nss;
> +               idx = status->rate_idx;
> +               group = EHT_GROUP_IDX(streams, status->eht.gi, bw);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>                 return 0;
>         }
>
> +       if (WARN_ON_ONCE((status->encoding != RX_ENC_EHT && streams > 8) ||
> +                        (status->encoding == RX_ENC_EHT && streams > 16)))
> +               return 0;
> +
>         if (WARN_ON_ONCE((status->encoding != RX_ENC_HE && streams > 4) ||
>                          (status->encoding == RX_ENC_HE && streams > 8)))
>                 return 0;

RX_ENC_EHT with > 4 streams would trigger the existing WARN_ON() and
make this not work. Probably not what you indented.

Best Regards,
Jonas

