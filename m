Return-Path: <linux-wireless+bounces-12778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF45497475E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 02:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CD01C24A97
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77528AD5B;
	Wed, 11 Sep 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJx6f/m4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF5B644;
	Wed, 11 Sep 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014479; cv=none; b=NLR6mFvR81z7wbe9GQJjZmFf3YwI4Dq8rUJ2Bxq2ihDz/qrLa5fsq/3PJVB/1N97d2Q2gU9ytLNToYxpctRU2d8P+yW7dHvHy1DT74d3jXdMfpfydjl6kA8tOf79aNEWe2DEz9Y8zFCQhRgnHBoaPh5TiVvu8i2dQYdZ9a7PnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014479; c=relaxed/simple;
	bh=wb6hWZRQtM77iwkbrSTFhPYBWYbIJLnpcJlbNlYBUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY7DWdemOH1zGi+pmpge6dIJsWHcks/S0kfdiP64/GPf8DAVDHxqQGL0rYVWk24GQ9o4uoG8NOITGpZV12gpjOhxBo6sNl6//yqa7T/fD1gSYBREUuSj2z5khfF3pZW/FO2flob7gH+2oDze1JFv/avc/tHp5dxU1jePo4PMaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJx6f/m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5D2C4CEC3;
	Wed, 11 Sep 2024 00:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014477;
	bh=wb6hWZRQtM77iwkbrSTFhPYBWYbIJLnpcJlbNlYBUC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJx6f/m4c+myCVZz7bfmxM9P2B20lWP2CXCFwqkr3CL7D9cRX07VzUxn2BbabZf4d
	 qpleUyhJMqEaAFYUU/81JVbN2rwTw47IPPDNbwHiGwW5yJfJVP3TLGLuWXow1E3bFu
	 XJqZ0yChAkRBUK5Kfe2tNUuXgYkKVsovdDDtc1ILOxzIeGD7iVCvPzvTTbCiDUCXKh
	 cwm76PpLf9h8AA/Yrixbkki/CLE7AkPGeqjXRDT8pyAsx90kh4+IoDlzk/arEiVioq
	 InNaCBUsDMCTJ5NKX70ZbN4L47Ewt+mazWobWuEIV2vBpYtM24t6tPCOXHWy8He8jI
	 O2gx+alHpZqKQ==
Date: Tue, 10 Sep 2024 17:27:57 -0700
From: Kees Cook <kees@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] wifi: cfg80211: fix two more possible UBSAN-detected
 off-by-one errors
Message-ID: <202409101727.2104D50D85@keescook>
References: <20240909090806.1091956-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909090806.1091956-1-dmantipov@yandex.ru>

On Mon, Sep 09, 2024 at 12:08:06PM +0300, Dmitry Antipov wrote:
> Although not reproduced in practice, these two cases may be
> considered by UBSAN as off-by-one errors. So fix them in the
> same way as in commit a26a5107bc52 ("wifi: cfg80211: fix UBSAN
> noise in cfg80211_wext_siwscan()").
> 
> Fixes: 807f8a8c3004 ("cfg80211/nl80211: add support for scheduled scans")
> Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Thanks for finding these!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

