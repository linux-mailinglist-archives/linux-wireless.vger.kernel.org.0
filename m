Return-Path: <linux-wireless+bounces-11709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71797958D91
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 19:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BE61F21451
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E841A7048;
	Tue, 20 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7dfw2U5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90654195985;
	Tue, 20 Aug 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175762; cv=none; b=O0k6Igl4a7fGw7/lY2revgLcKGeDk+KmdnWiPqvPNvBpopVQeITrhxdO2oNTM5qZdRzca2GW3GNwOJVvfpsWm05gpa6slvXuMKoLF3clXgSGYKRoBdVYh0o4Cpc/oNJCDzOFwobSkjPWqE+LZB78ZU2aiLDEDQhZ58WQq0xQ2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175762; c=relaxed/simple;
	bh=kRc8TDwgNgxYTHTbusur//r527eCmFsN8vdqOg42e6Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Rc8Q8FnmPN+wwHQ9SFOQIT7u0Dck03oVWIIW0LbBpVyuS4E/5sag9TGRciMVImJ/9yz7jL0ScSrGwEwKfqADX2S13WbLV40AcuP30oPIdP3li2l/jH/o2yfeg2QTnQcS+yMrLi4T3a0s6/SuSg/Ln9ZI5PiQP6kSOBAI8El7LFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7dfw2U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F04C4AF0B;
	Tue, 20 Aug 2024 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724175762;
	bh=kRc8TDwgNgxYTHTbusur//r527eCmFsN8vdqOg42e6Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=F7dfw2U5hfK9i6/Qwm9JmbMtZjCGU8doxrw5GBmEr1of+PYs/rqV1mPoqI9g3PYdv
	 E/VJfv0OgiQsuc3I5jU7E8chqTPS+pDJ+sbW14qUpag6tM0+aNlq9aYetdEqarkX3y
	 eMmEWtunTJmwgBrh1xu3pEBI0pynlzh+HvHHdMnGyNhZPuoAYdz7DzmjLs7sZuAaq+
	 mOswRzuzV1pMlPybv3qJgYNo6r7N46LouFuqLgN8f2OqDakNc+eg4EQY/CsMFK97p+
	 Jwda7rGJnYJWxTE4OUGXvbi55twbANNvVQQBBwzJKcbr89mYSVHwKjr83V+Y8+j6QH
	 q3vtgGeuN/Y8A==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH 00/31] wifi: mwifiex: cleanup driver
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
Date: Tue, 20 Aug 2024 20:42:38 +0300
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
	(Sascha Hauer's message of "Tue, 20 Aug 2024 13:55:25 +0200")
Message-ID: <87o75nw0oh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This series has a bunch of cleanup and bugfix patches for the mwifiex
> driver.
>

[...]

> ---
> Sascha Hauer (31):

BTW 30 patches is a lot to review. A good rule of thumb is to have max
12 patches per patchset, maybe a bit more if the patches are small.
Splitting this into two patchsets would make it a lot more pleasent for
the reviewers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

