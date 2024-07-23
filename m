Return-Path: <linux-wireless+bounces-10456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FEB93A4B4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E0A1C22305
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D7014D431;
	Tue, 23 Jul 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMx0VAGt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA714A4C9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754616; cv=none; b=drkoKeHLds6OELss3kIIhAW/kVvkmJFcEULg2wPStVxeQWjhjO3cOkhEAN97+YgPMRm/iNlKAsYThbvanHZo68ajUwEWhqhIXKp0+IMlMpYk5JqLASoKl9HvyH0Q75SCrcoSxgMCKhYiUk5NpojukTaxS1pWp85V5UPCd1Ws6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754616; c=relaxed/simple;
	bh=svR8y78lfBq3qZtNe+9eUZ+m77MqcRxgyK9WiUS8rqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q86WL6vYr7W/9P12mtDkyw8ybFxcuYCOe1uYB0xoCDs1vunM9D/F17KvbpaI5zlHGH4X9LxuJYcJga5ki1ImePAHehNayaY4LtVH8mZ7ago6nnZTjkg5h1jvkNH30F5cbszvS1Np0q6FZ2DQRDRSqES7ssXIwgEvr6SUTO1mRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mMx0VAGt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa9ecfb321so7183395ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721754615; x=1722359415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfXh0e5qvlr9V94xYRTDIYHCRmA4p3PKN50LXFEptwo=;
        b=mMx0VAGtqa1uRrKheiCo+sDClgIafBvJNNEmh2Ap+e/I3aI9WbBaNcIk3cbFvUkwGe
         BksSYGTGn6goJzRsv5gyMKnW2HwPfuw9/dEe5wyKugKLjXZ2aZwEslkfpY6wmWMqgP47
         Yu+W8a+yBimBbHHnBg8DSp6Y/vntx0/61twZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754615; x=1722359415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfXh0e5qvlr9V94xYRTDIYHCRmA4p3PKN50LXFEptwo=;
        b=jFG1D0yORrX6pJoS4xOQ5QzmdEMdB9Uj0KLGsNrwQpZBuBojdsDcUyK+BeFsxi78lc
         nNkLkSSAj6jefaFJ89d0NVTpgbf8Be6OmUKrFomolUyTE8BwPCAcnEPo163qSnzu9mB9
         1iVkXVf1hjql9iSMVddyrL7N5KQZ3MGRFSVR8zCmeL8aBwN6f9gTjSF9oOxKjBLCh3BZ
         AXuBKDAnOn7zucS1wceHBf33BoV+FRxo60c0Yn6FDmymdwyNLl7rd1wSKZWsgDQ7AQ9X
         CwmBv7O4KG/gRZnDaFlKC1cbIBAfCYCNlTvtsKddC4I5hucpsHsGjRAmjvLTdmsa4eab
         W9fg==
X-Forwarded-Encrypted: i=1; AJvYcCW2njxT3u/D/3/rdKqlWg6/JSB8e+pE28TNTC9mHqVE/ACvZm1dXv3Jsl03Hh56Srs0d5Cl7M+M2rAs45gQ42d3DQ525d6SMv0pWDAuQZs=
X-Gm-Message-State: AOJu0Yxiu7+QJfYceJtXQK7BA5fPZJPgIA4VKL9Tz2qkj9tUU3Kcuuyq
	RJSYFK3TySVgYSzgdi+5ZDud73sD4tIQfIuQj1YyJpcjoNOtxFb/GOmxNyDhAQ==
X-Google-Smtp-Source: AGHT+IHvniJlM77jc39PhRZdLCQJ2B+vWgh38JfugkBonmrTqOIcCFDNiTRqD6b0b4xRovDi/FP/Kg==
X-Received: by 2002:a17:903:2442:b0:1fd:64ef:da17 with SMTP id d9443c01a7336-1fdb5f6b603mr37015895ad.41.1721754614633;
        Tue, 23 Jul 2024 10:10:14 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3be5:f451:a5db:11b4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cb772c20fbsm10440114a91.10.2024.07.23.10.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:10:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:10:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] wifi: mwifiex: fix key_mgmt setting
Message-ID: <Zp_j9P6jTzMpCqO-@google.com>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
 <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de>

On Tue, Jul 23, 2024 at 09:09:58AM +0200, Sascha Hauer wrote:
> bss_config->key_mgmt specifies the AKM suites that are usable in
> hardware. This variable is set to specific values while iterating
> over the advertised AKM suites. This means the final value of the
> variable depends on the order of the entries in the AKM suites
> array. Instead of setting the variable, just set the relevant bits
> in the key_mgmt bit field to make us independent of the order of
> entries.
> This behaviour is derived from the downstream driver that does the
> same.
> Also, set bss_config->key_mgmt to zero explicitly right before the
> loop. bss_config has been zero allocated by the caller already, but
> do so again to safe the reader from following the code path.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

