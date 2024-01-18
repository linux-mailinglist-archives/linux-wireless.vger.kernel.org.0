Return-Path: <linux-wireless+bounces-2171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C694C83186F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92573285B64
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC6A241E9;
	Thu, 18 Jan 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czYhUdp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716A241E6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577269; cv=none; b=Y5VwYkELT6c0J6lSJ7VzaxXSTTx/Tsbeikl0VWopwj5F/fL9h32wnPo9fGUgRMZb1ybuXOhLZZ0GTRjEA61z6MaEntc9KbEY0EFhUUZgqKETak35v+AFTV19fk4gbsHxo2zZXfaKHafit8FaY226XoFVG6djlyY6UXmt1ieC+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577269; c=relaxed/simple;
	bh=7FIs+TjXKnt5a3ThLNrp1veujLm+GW2sAhmpr1l3B7I=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=uSP+iKL9O77v8tjDBSdE+PZJA1qy9PUg6/Yblz6/rafWYspKAhBxLtS9PfizIGfr/7eYa5Cb3u/DWJGQAwv6+f1k5x0n8N8ZEjep+b3UglKbTnBEOPu3PYImv+9j+g3ZPWKmSU5prsi+f2Cjc2OdiG3uav5vFTX52Z192GWFMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czYhUdp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD3FC433F1;
	Thu, 18 Jan 2024 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705577268;
	bh=7FIs+TjXKnt5a3ThLNrp1veujLm+GW2sAhmpr1l3B7I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=czYhUdp5Jmb1qKtg6H25xOQ/wpuYPSB/O4sSpcMsdsje72+/QlD8hkhAYowFhc6c3
	 Ikik40RzRPnWYdGvA/cx8roCYVHp8pXXNHIcyZoEhmUQHAAvL2hI50IfMpYnfQQ+nR
	 EED9Bo6E7fjGQh13PuIiY6pFBjBLewWAPW0y4UCb/KZx89sN9uoMiHjYvXTTV3vkkf
	 m2fxapJTStL0rfQDzsG0uHdyaZja7rsJPBj3exoNFsQ4gUrUFYE2Km4Im/U8x5nqDR
	 2twzhnE7HgcvVWwBmqFUvoosDWiW2SWBZ5d9eHmKdRA8fZO6YlcT5/zH1IC4rdgL4R
	 odz1FtEymRO5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: always check the value returned by
 brcmf_chip_add_core()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230821112337.160974-1-dmantipov@yandex.ru>
References: <20230821112337.160974-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Franky Lin <franky.lin@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557726552.2924528.1111973793443376429.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:27:47 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'brcmf_chip_recognition()', always check the value returned by
> 'brcmf_chip_add_core()' with 'IS_ERR()' and return convenient
> 'PTR_ERR()' in case of error.
> 
> Fixes: cb7cf7be9eba ("brcmfmac: make chip related functions host interface independent")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This should be tested on a real device.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230821112337.160974-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


