Return-Path: <linux-wireless+bounces-11361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046C950AB5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F2D1F217EC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E719EEAB;
	Tue, 13 Aug 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k2FR/ycr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B74198E60
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567637; cv=none; b=T5K1UWWLZJTgZsuRy84WecAR6Qpf+RTNEUeZ015AmJMX1hiaJJTrN8W12GjLpT5XTJOIwpEwiUjfcmgPZiJDUjAcRKlNS6mNYSmH8/wHm9niTxMm7LZ7SMQxllB76Pq3hirIvV3HeHEsE6dB8FEn5QGo5/Rgh2zUrRn3pgKM/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567637; c=relaxed/simple;
	bh=/IlpP4Qsf+0X8H5/rIYlw5E1qReGDj4YSxMfZTHsJSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR9i/aFu/XwWXxfFPhQqfJqPQlbCyLDxakbuahwex5h9bMFa8YQxOJ8qBsgudrW7EQMuMTV+4OOf2oEjWJA1lKkwcHJ60lbnBTsQj03Cq76gD5iKKi4SupulFbGfhsaaxSKFOT6pzBMv1AB07/PT381mt3P6QKaDwWKKhZMXqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k2FR/ycr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7126498ad4cso391083b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723567636; x=1724172436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvC+MlViFr2QLEkz+G8a9FJXYljq8MctWXeGbvhtnMw=;
        b=k2FR/ycr0JGf4hpISPmdeFJv+JIliuLPH4VEj35F1VcO+VBcuDp54RXXqbEKW/3xj5
         nLPJCzsI0WXaGJM7IZ1W+xfTygsbZwKEpC4bV+r5s5pBnIwMehwkS2OukjLTxuzUXK96
         vLPYpSx/+pd/X2LXSuq9HBl78sjGSKux4dj4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567636; x=1724172436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvC+MlViFr2QLEkz+G8a9FJXYljq8MctWXeGbvhtnMw=;
        b=noiwX3vy9b9nQURYaYHYhcNFp6Y3hT7NHgEPj4xV9Kx8ySQH92eYza/LwGSWcyWrdX
         U1TgytKPVsHGOy1KQ1mIMRcIvGJp3hAP+JrcwUdUF5Yw0Cf/UxX+qCm8/G26pOiBrQ/s
         adP4o/SxDRRtpMAdxiKma3yaE9S3eIA6L5/04H0/MZFi0LlfhQZmr7zJfl49CknW/Jqe
         3OX8gYp0e4NU5hAhTsamSYROCMg4WC72sH2flNYvHkRmtdACkxka739iwInJPMgwSIlZ
         olCiC4CcR0B98+UkXA1BBNiQLuTQmX2kJiO2t8q87vN1dA0npbuiQxjYvzeG8AHEZcMJ
         vwGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDPmljx25+xQyh7O8U3V8s2hauZfVR4qiYFxrn18jVfjcSTfwhOteAVjEt2W2bonZFtECHI1TJFM9Hv4y4WgrUFg5k8qBPIPnRfvafL00=
X-Gm-Message-State: AOJu0YwJjUdT0iGbDSU8lh/UJSLhHOdaJs+GdUyah4Y4mJj4Jnp83GVl
	dKUPlVOBz+AN/c5nqTZwlogfRIlrBtsfX2BlnhmXaxc3wThxund4frWX21ahiQ==
X-Google-Smtp-Source: AGHT+IEzj9oFteYRB1wBRDBdk9axsnQIDwhuKTpjESDC1PAhH2791kVkrch5zHpbudiwlKniI2eNRQ==
X-Received: by 2002:a05:6a00:982:b0:70d:2796:bce8 with SMTP id d2e1a72fcca58-712673aa50cmr186956b3a.20.1723567635731;
        Tue, 13 Aug 2024 09:47:15 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:45ad:979d:1377:77f0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-710e58b69e4sm5933627b3a.88.2024.08.13.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:47:15 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:47:13 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Message-ID: <ZruOERPfLACNlw7P@google.com>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>

On Fri, Aug 09, 2024 at 10:11:33AM +0200, Sascha Hauer wrote:
> mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> used and modified in driver instances. Duplicate them before using
> them in driver instances so that different driver instances do not
> influence each other.

Ugh, I caught a few problems like this on the first several passes of
review, but I missed a few more. Thanks for the catches.

> This was observed on a board which has one PCIe and one SDIO mwifiex
> adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> the statically allocated struct which is modified in this function.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

