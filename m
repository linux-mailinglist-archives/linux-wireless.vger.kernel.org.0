Return-Path: <linux-wireless+bounces-20768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89327A6DFD0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224677A3969
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F61263C84;
	Mon, 24 Mar 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRe1lOib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7604263C6D;
	Mon, 24 Mar 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834059; cv=none; b=J/IJqoNV6VhaZxroKdqDguJswXP6rms4zWdpgJq1a2439PpvYFT4ojdEiqf2MDP32Uf+QGGkIZHZxzpQJS0BFDls+8VsRTFM8ES6lcs1Yu7cZqTilZuuElHXlV+cf9y+9c0A3FOvBOwGMToQjy8reml0OXjA0Bd4xOUcRvZc1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834059; c=relaxed/simple;
	bh=zhghpD09jKMVrHYp7hwETzcL/yrDvjo+vnH4ckr+KIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr4uBW0nJ619vkNF6mNBhpL7BPznHL9A+PuzRYyUKJtHy4jNdxXNVQ/QQeGd2RSjud2woJzl9g+CTlwEve/jpuCNOp1gnNp2C/Gbzpv6AnloPDa8FubHh390y+b6LdA/4+mCnNRFrJHu+ohFU0gHZ93bS2eYChR+R2aM9P24rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRe1lOib; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d571ac3d2fso44489485ab.2;
        Mon, 24 Mar 2025 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742834057; x=1743438857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHRttP0M7LtsWECmfjDnfMaaoHCyo79Sve4Di35xTuA=;
        b=RRe1lOib/M1IfUctUP+p5g9DQ8YFhUloEgevccXqc1z/RBRwfdU/7hAdhkNeilBXjH
         q6g8jA3gpRd0atJc2p+p8rUur7jA7J+MMR79ANCYM3ldx4VrawbpUDXMCk4wbY/k0NRp
         R2XWwHqh54Ox0ER5CQ6xrD49KIfUwHSIKhibfiPN6FSFWhngr6wkTIM/Ie/w4UL+G0em
         S3M5mLtkbW4+svO+okrryIU7kshdEnGjiqJQ9lB48+ZdzOR7ryzH1RI2RN3GkM/uE9t4
         /gK6xo+7rDrj1AEXhGcyK0MlCE6UemW8nj2tXRbISQeDWo9vl0HP4Q+xiW3trW/X0BkC
         eAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834057; x=1743438857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHRttP0M7LtsWECmfjDnfMaaoHCyo79Sve4Di35xTuA=;
        b=Uqvcm3rAeqxuTohIBF2XU2uoxaD0oN8Ajuhn1AxLQoXeqFz6K9URdTqVE+a7Ifzp65
         ZWSIomXsYRDBLPjYecIk15gtluN+GHuok9V2vQuiDAjOSKE/kVpU+jhNO1+xBCjnifmB
         iiprVKGMrCfOS2LAu9FWpuD7VHsyR5LbRVDUnhbzbrZrma/9lMVDwrIk3EywmVQbuLab
         8BDHwARCybtaZNgGkA9AAFTDkiXTGbrG4PwHZLzDzfVwzTLbNY8Zt6dl4LSVr4TX7CCY
         dQ1x6d2BiWlISRIHOePiV7L+3TVa+gF3oW9PDE3SQEgqLrfairNPRbmS2ZVpwnqcf7+1
         xNcw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6Q4EIl6lQoR/djTWvLHME5/uBRzuZavJ/Yu9SrWuB3AyeyydSOOGNHFkUGruMJ1Yg7C5CLurikzfitxjNA==@vger.kernel.org, AJvYcCX15nzPN3/zbMwDkpOoHL6psmVsGOb3VlhVr1DHqu5UqisvXhOZkQC6NpW6VyzbexNfiasx1oqd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbb5IImYFUHdtnOVXonzb/mymj6UHM8T0V8pCYnL+oFPk7ODag
	0A8rOwrHPSl4rss4KxctWvYi3+O6E/fU4GuWJA+tQiD7h2BmGq/hGowf6RCAdELlqSI+IccZJ4q
	VRnM41fVgmFfaOGCXGIXkrFsU1kk=
X-Gm-Gg: ASbGnctc/TcHjl2nmNmWasTTDAwSNccgcnSfGYmHYKWocQ01LEME8r4TlnaCpjFCSye
	OIlFH6O+ccwYo+tE9pGRZ8on8ZT/z8JxUtr7FB2OxXjOs0VidscgT4/Jp+srTFyxyPdZQFGNkzv
	nuAg5nuv7uP+hTvOgZMkEVLr6ZyE3zAbIhPwU=
X-Google-Smtp-Source: AGHT+IFejUVyT+nAG2WW3a27wOyop+Cj18uSIl++0wvWyqkXw4lqrDV4gNNwIWhkUkoUIdcEWUE/W8OSqH9cD3mRWgY=
X-Received: by 2002:a05:6e02:3e03:b0:3d3:eeec:8a07 with SMTP id
 e9e14a558f8ab-3d59613e5f2mr149285505ab.6.1742834056618; Mon, 24 Mar 2025
 09:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
 <20250324085340.46864b77@kernel.org>
In-Reply-To: <20250324085340.46864b77@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Mar 2025 00:33:40 +0800
X-Gm-Features: AQ5f1JowzstFiruhFfOWTD24rS5diwoRYCZVLL-7CEY4qh1KB1-Wvsyd79QnnvU
Message-ID: <CAL+tcoALESX7+pJfvOoGSG7adKhsbhSXw2zti7ZNHmOwpSJsUg@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 11:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 13 Mar 2025 13:49:39 +0100 Johannes Berg wrote:
> > Someone mentioned today at netdevconf that we've run out of
>
> Don't recall the mention, but I'd guess maybe Jason Xing during
> his timestamping talk?  Change itself LGTM!

Yes, I did mention it. Sorry for missing this commit.

Considering it's too late for me, I promise I will review tomorrow morning.

Thanks,
Jason

>
> > tx_flags in the skb_shinfo(). Gain one bit back by removing
> > the wifi bit. We should be able to do that because the only
> > userspace application for it (hostapd) doesn't change the
> > setting on the socket, it just uses different sockets, and
> > normally doesn't even use this any more, sending the frames
> > over nl80211 instead.
>

