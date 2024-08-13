Return-Path: <linux-wireless+bounces-11362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B15950ABC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998A5B217D2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3419EEAB;
	Tue, 13 Aug 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XllG348N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863551CA9F
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567729; cv=none; b=DEQ2cpRlaGiwF4IVAqqVWQ7eorj6uIMyjiu5DDb2Bk7d54KIR42FP9HHoQ22G6xla/UZu9X8hgOS8PGuJKmMX2zB0XVGfr1yfCRG2cASa+RXs1XtRhf30Xj262Zs3BcuLVDvi19buIBjnGgTTapBIn7IeudaEIwygrgSXYjK6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567729; c=relaxed/simple;
	bh=AbyZZV8OemEO6yQWBbj90k325MRdx2HrxlcMri6YGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbsMm3AyKz+k3cXSicP/63396lNkmC9O+vIMcCCwnI+LNH0s4OS4Wn72TPkoYBqFVEknz7D6M5mwpLCmfM0CUXha5ABzgT8Bdw3lebn90fm9L5AMoarazHaVEXUQzBgBfBsyuNfCGI/1CZZGG5uPcCG64A6X2zoz/ImUTqhuG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XllG348N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc6ee64512so42078535ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723567728; x=1724172528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1B3Gf2ESIqFOuwatjJBDFN+ZmaA9cH3bs2DrpeTPuZQ=;
        b=XllG348NuaTu/X87n6jTIxZq70C5aISv91H7hAhFrpQo8n0k7iHgQY2ikxQGQUn6Dy
         rUhjJO3Pfx8f1jNV5iMZjbRgCtFf7Vj2MpF5u5fG5mtUao5nkJOiX5IxUqWfKcsoY64G
         X20ZoLOyC8qnhRVyzbqmPswAZZl9xe/FzffzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567728; x=1724172528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3Gf2ESIqFOuwatjJBDFN+ZmaA9cH3bs2DrpeTPuZQ=;
        b=QUaeGujlYS6aKQWPrdpcHoWWcoiLeJVoG6PIhmK3IUzMJDZRspx7sKTWPI2UoC68Z6
         WKPG7OdS6IU1vUjoobmCOAo2dyAqb/7OOnNn/cqhoHqoMFGAdJBqYcX/6h5iZ9r4bY98
         p8EYk61WF7ws00lirNF9VNjv6VNeGROxXDDdGPZa/v5X3LG2fTrMZEggYK+XsT7BiCul
         72M7xlKiGmPHAOYvLPILRFXMGUngeEwty0nuWvjNmdXlIcB8FwYQv3ky8gB1lBA6rNki
         kMeGacuxFGxMgkEvqfwqd4T2tYCNF1WB+MhMeMBKDlatPMij3dPeLkJq70KnKTETzU2R
         agrA==
X-Forwarded-Encrypted: i=1; AJvYcCWQpE/SweDU1FSZkSws7Fiw5I3mzkulcrdHp+ZoKhXNXXF2iI0LmlKtpqBg5Favipvgp5A9AwNDBzFf+ghcEccl8IM0goF7nxAJ6Tn0LP8=
X-Gm-Message-State: AOJu0Ywh1gC9mB4qo70I4LajhYO3ZEGao7yUMqqsj1iHdWzzWZ9M1lEx
	IYSYB8GewitgxAeMXl5AK+r2ggTMyEUnhnhBEavJPagmvMWdfpUA75GppJVa7w==
X-Google-Smtp-Source: AGHT+IEj0wPMiW8kmdwXC1HxDPUfbMhHQQB3MyjLItlZspVvqa8S7vnINZrGuQzEF1UyzVq2TpavBA==
X-Received: by 2002:a17:903:32c2:b0:1fc:6ebf:9092 with SMTP id d9443c01a7336-201d64e85e5mr1012705ad.57.1723567727726;
        Tue, 13 Aug 2024 09:48:47 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:45ad:979d:1377:77f0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201cd1a9389sm15752865ad.135.2024.08.13.09.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:48:47 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:48:46 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] wifi: mwifiex: keep mwifiex_cfg80211_ops constant
Message-ID: <ZruOblIWV7_aogyu@google.com>
References: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>

On Fri, Aug 09, 2024 at 11:51:48AM +0200, Sascha Hauer wrote:
> With host_mlme support being added mwifiex_cfg80211_ops is no longer
> constant, but supplemented with the host_mlme related ops when host_mlme
> support is enabled. This doesn't work with multiple adapters when only
> few of then have host_mlme support. Duplicate mwifiex_cfg80211_ops
> before using it and keep the original constant.
> 
> While at it mark mwifiex_cfg80211_ops const to prevent people from
> changing it again during runtime.
> 
> Fixes: 36995892c271c ("wifi: mwifiex: add host mlme for client mode")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

