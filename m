Return-Path: <linux-wireless+bounces-13540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EB99128A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A07285740
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CBB14EC77;
	Fri,  4 Oct 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGuwIpkM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB114BF8A
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082574; cv=none; b=pLDHun6tCSZ6uh0+NcRjH1Z5h72FvHDiKHttwnuX2iYJF58BD55+gux/IXmPoL9wSiyyjQaW9uQO7hebhHrRHVSgIRAp6DfiPSjSl2yMDb3TNkldExthRv8rfGtH+W/Kp86qmMvlGbwHsT8VTEFtZE325RKmPoXlRwRw9hIUioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082574; c=relaxed/simple;
	bh=vSVmowQuOxKR6DuGxvZIDGlX/xY6PERh9dFLSMSYa7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3jiN+pX4UNLogI7HGRQNBjhJvZ4nGfrwS0kbLKzY2KPjIfkN3o1AHAZlKVnkPzEQqko+t7QA8dBd4MD9MW5zekklZg3a4gEUyndLRYZcK5kDAcUGdY0IofXzYl4wjnGxvCSe69PzZSg8qIjEn2k1qfit1rhlg+HQDRV1kb5b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aGuwIpkM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b64584fd4so26600395ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2024 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728082572; x=1728687372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/GyTrIjov/Q+/DDFg8zN5CnnVd536FyJYodwBH8Fzo=;
        b=aGuwIpkMcn5q/XeBM8A68GrDLIuSZ6tFTj0BuFAop8+QPnsOtWOmak4qp/lJTudndX
         0ebdZRMmohWvC9GMVg+1dvJaQ5P8Yzi4Lj5fNE4SmOM4smh1nIIPn3PInUHqJvRmPOS0
         +wa4PrjnqG9ZFiIXg4ZnO6Jp7z0c+79aDFqFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728082572; x=1728687372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/GyTrIjov/Q+/DDFg8zN5CnnVd536FyJYodwBH8Fzo=;
        b=m4y303cILiJ2hWqoSMgfLSoY1zm/anXcUQm8GTC6qtECaXWULBaPFwC8zZm6m1zSo7
         NfKvb9LS549+OgC8e9ejaoZbipf45nBzPeybBqDd29M/+9WRZZyCE1AI1bc9t7/GKJdk
         8rk4+X/XwyWhHPt3kp2i5SkAVRTBIq5YLNgbSJN2FJUTkNVA+5gDj678GpJ/7huqiDYH
         3lnvKqYWbdjCOomSMxvibFsTrSPlDL9I5uduy2XVFjeNdZB7r/VF4IJxEC55KsV/ebSF
         ylJvyiSeXoQUJbL50YwPgwdDjEeJ1DWy2GTtRQUI34cdSZFUThhKEbboQDDVb8JIYyiS
         sjkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3bIqi3adf5lr2jwt8qBoq8VTES6NxU0MBtSlSmler5MTMo70Y27Sq4Txi83yGpnR17hXluE1HkVeg/StgmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPPQe59lOt+ku15blgYVUnbnoWXO6x84Ox0Tp1gyMe7Y/74eV
	YItuvG+pGqZfBQOAb+vYR6qK/f5JohCsWZZeceFFUFTGpgHe8oTWJ7JLKDB40A==
X-Google-Smtp-Source: AGHT+IH6icUWoo4zdrKPw2th4xxk94nYEcoQEUxeyVS111ASawmnl79xThXdwoJ/OkAtj0v4Vq37qw==
X-Received: by 2002:a17:903:2452:b0:205:6552:1099 with SMTP id d9443c01a7336-20bfe022cd9mr46260195ad.8.1728082572054;
        Fri, 04 Oct 2024 15:56:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:431c:f73a:93be:1ac2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c138d1568sm3516015ad.75.2024.10.04.15.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 15:56:11 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:56:09 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 01/12] wifi: mwifiex: add missing locking
Message-ID: <ZwByifOXJMO6PX2t@google.com>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
 <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>

On Wed, Sep 18, 2024 at 01:10:26PM +0200, Sascha Hauer wrote:
> cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
> with the wiphy locked, so lock it before calling these functions.
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

