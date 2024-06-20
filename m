Return-Path: <linux-wireless+bounces-9327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D9911082
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3390428425B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041B1B583C;
	Thu, 20 Jun 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcIls2yS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604C1B47AF
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906728; cv=none; b=P+q1qPipKXe8WVVVfOtQBMTPEZBONFX7jt/GJ9QFXp8/+j9ARnDQarQ3mOIhq9QjXES7AjvaiSqFlyMGiLpYOoDNNaE8fM5ZGC9vrkN0eK+CFlWBktmIrifK14QVXm8K8jCFzdq50v3DQLdbIYSyNlTqLkTi6fvqzVdVZT246Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906728; c=relaxed/simple;
	bh=/UyRgHfm+sZS+tI1rHL6/bgIgJ35C5s0UbiOdadK2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/fztP1pBHhdBjxj129xoD1x9estRutlTjaXNb5nbkiiwVsPuaFkaVzU7/L3EcwP+5kXNSy1C/Tfuouj41uPDya3FBXjeyp4wnnrjnVt35jA3S17vY7fOirek1xwTxG5TT3uEh5u6MyvG884K8I2DlkL34Ej8QqTE6R+FxClt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcIls2yS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7061365d2f3so947964b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718906726; x=1719511526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyAepGt8zwC+Uy9TBQ5kec4y0GaIIr8mJzAf1XxO3g8=;
        b=FcIls2ySv07eS1sSqfmhMVLmlXp5q0AYvXBwL8v77Yg1azs+IY8RlYm8fCdMJSwi33
         3+m5JNJsbqDIoYfSlUkVtnevOawIXqOmMsRx8hmaGrh7uorRG14ckY6ZJb1PcL3LMf5/
         ABRIwxfI/s9zmELcHNfQIqmVb7H/CwRTRkW0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906726; x=1719511526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyAepGt8zwC+Uy9TBQ5kec4y0GaIIr8mJzAf1XxO3g8=;
        b=GmJRgm7RYpxhj/ZfOM/l6uWRwg7k1x0hp4x6Mm9SRnFlm9Ie9Hl5CdeC1Kuag8f8ui
         avHubmZ1Xmna1f2bmoDAds/ywqeh2XKRx9qhr0XXcUMTTm2E0O+wZurBR6gPX7OxElQN
         yzsQQ322pk0BDcEmyFk9SQJTD/PIYOn1jeNFX0CP+3zifyvBM8aJSL/NzySUJQoBoVK0
         Sk291XfQYZwfTt0rIfifch80THl4rJ8U8Xo5Rm1cZxxuAo6f3j67cLy8Lvd/tObhqc+N
         g6cVotTQRoQEih4b1s1KiyzG0MeIPBbz1CRLIHMjtPV7K+/1L+okpYAsZiP+0rp1UkHT
         nFkA==
X-Gm-Message-State: AOJu0YwYGynhjeuPC6aOCBlw9zji98fcvyXo4fSykXxAxUkChaEjJcK4
	28Wchqfgn+FYq0O6ghkJEeeWq0HalZTwQ1CcoDsZL27V0h6e4bivjBQ88MeX1xUwRgGni5+v7KU
	=
X-Google-Smtp-Source: AGHT+IFtxCTApS5PLIaX0tBJ9IiKUk5qiPoyB9ue7cA9nZarmfct92p63kyAz41a4pryyVQqjS1i0g==
X-Received: by 2002:aa7:8b50:0:b0:705:972a:53f with SMTP id d2e1a72fcca58-70629c5bcf1mr6759832b3a.18.1718906725954;
        Thu, 20 Jun 2024 11:05:25 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3c9c:a224:3ec6:17d2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-705ccb6bf4fsm12605308b3a.169.2024.06.20.11.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:05:25 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:05:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <ZnRvZMQJUr4APwUU@google.com>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530130156.1651174-1-s.hauer@pengutronix.de>

Hi Sascha,

On Thu, May 30, 2024 at 03:01:56PM +0200, Sascha Hauer wrote:
> The maximum number of AKM suites will be set to two if not specified by
> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> specify up to ten AKM suites in the akm_suites array.
> 
> Without only the first two AKM suites will be used, further ones are
> ignored.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Current wpa_supplicant/hostapd only put a maximum of two into the
> akm_suites array as well, a patch changing this can be found here:
> http://lists.infradead.org/pipermail/hostap/2024-May/042720.html

Thanks for the patches and research.

Possibly dumb question: what's unique about mwifiex here? Everything you
describe above sounds applicable to all drivers, IIUC, and I don't see
any other driver that touches max_num_akm_suites.

Brian

