Return-Path: <linux-wireless+bounces-16476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A499F4DCA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA091892F08
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3711F6686;
	Tue, 17 Dec 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOEaR4Ff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327B1F239E;
	Tue, 17 Dec 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445895; cv=none; b=kRqUZ3ZMMo3ruRBHm4chbU1ltMt5Y4JSAxgCXstX9G/H83rRTch35B6iuvZxj+qW1YHLElbiF2g74D1Whm7azGNsoktgyh7OAfwpnToKjWbB0jMbJeUANCQi1AdwsP13jsoXN3W0ZjgXVGk38qzUd2B15Q3c8CLn6+1oxMzaCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445895; c=relaxed/simple;
	bh=fcz6BKWN6S+wVQPiPTq0ycmlj5zAZOM1rRAiuc2cJ6U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KLPHDwAcixCipqvjuw9RsDJGO6DOIXeM61wt7Qv3xLRI6NzzSpw1rHKqaVR7cMFcFe0vnaE9GaO/TU06ccEKBoDjf/3Teg66hfnbkspf0/dDaIiO+Yaz4cvU/QrrInlfm+0117/qhR5q6UaCHhzZb+mJXf7Z7fTRKKf7EUojKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOEaR4Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF82C4CED3;
	Tue, 17 Dec 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445894;
	bh=fcz6BKWN6S+wVQPiPTq0ycmlj5zAZOM1rRAiuc2cJ6U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IOEaR4FfPCKN4CX699zU0srThw9ICy3x+WvV4qd1QY2Li9UkPZ3vDjqxZau009z1A
	 MrqRIxPlyyOF0/HQsQ9k0q891E3wHuVWiji1zvmvlgzd89Og13RTfjcRlOwHEO5WsG
	 suOSxkoSGQgOzA3piib1FjqYu33c4znK4gZR8MQWKS8OcH95/HnsTAnbZGx54eSEwG
	 sfajoc+pV5ujtMz9ehQ+mqB7f2p9P0GGj3tFVLYIiwxPkbA7yAS7W+/8woT9jyBnkj
	 uQOCKTQSPAzwsQMjhwZZiH1HNtUHAFx3fwUQYGA1OaJRW4RThsHrsZY4w/nV5wD6kC
	 zkmDuweEOrZCw==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  kernel
 test robot <lkp@intel.com>,  Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] wifi: cw1200: Fix potential NULL dereference
References: <20241217-cw1200-fix-v1-1-911e6b5823ec@linaro.org>
Date: Tue, 17 Dec 2024 16:31:31 +0200
In-Reply-To: <20241217-cw1200-fix-v1-1-911e6b5823ec@linaro.org> (Linus
	Walleij's message of "Tue, 17 Dec 2024 13:55:48 +0100")
Message-ID: <87jzbymldo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Walleij <linus.walleij@linaro.org> writes:

> A recent refactoring was identified by static analysis to
> cause another potential NULL dereference, fix this!
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411271742.Xa7CNVh1-lkp@intel.com/
> Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

If it's ok for you, I'll add the smatch warning to the commit message:

drivers/net/wireless/st/cw1200/cw1200_spi.c:440 cw1200_spi_disconnect() error: we previously assumed 'self' could be null (see line 433)


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

