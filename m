Return-Path: <linux-wireless+bounces-14781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD29B7C92
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55F61C20B5D
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2681751;
	Thu, 31 Oct 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEf1FKCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C247156CF;
	Thu, 31 Oct 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384302; cv=none; b=rMSKsUzpOZH2TpiTA9PjRRtp817gsNxxjJwHsecbdnygQDPxS0hgRtzvJ8qijfDsNGExVVNsY+Mrm5rEgpx1IwPEUIQGcXCs+oWbadSgvBV0MbCXuUmKkWfeYWsYgRrWfhsYc8F7VxObM1FJ8H2AwgOVWxWyvXlB4eV62hS9O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384302; c=relaxed/simple;
	bh=7GalZRZr9ww/O3wRh6kTLoYDD/ZpmZuKsl1CnhJIqqo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oYfKqsA/hm4zQggUjG1fS2/hLwA68aCuumMIiKL3qhcVBfqCVxBs7k6q5cIX6PuCDkyoA6HqkzLZlnIeGCTEodll6SN4SLAyiSvHiFu9XDzPGjyUz7azoTCOKk4u94rvSoTPMRoz7wt7AomtVcpAZn0C++Do8NShNdR3DTKHoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEf1FKCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C70C4CEEA;
	Thu, 31 Oct 2024 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384302;
	bh=7GalZRZr9ww/O3wRh6kTLoYDD/ZpmZuKsl1CnhJIqqo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=YEf1FKCA4Y1/Dp2xaYAdv4Yiwzrwe5ERJM8i97nBtVqS8Vn/amN06PXBEw+xq0y9q
	 gecmwUUGyOqpkEmRbKexwQtSsvz46bVxqIqfdlW1WpQK2jiK9l0Jot22eU97T0jN+9
	 m66VUXtnq/172x9EZvjbc89Zeh9VB/ejXlRAStENN2TaXwY1U0FHRgbYUinJ/X55Wf
	 lKs7gi7WTTVT70bE87YgFJX8HIu2OQPuOUm+nuf2qpCBUjPbDneV8oz/E8cOVFQ1jz
	 yo8Q2Kq8p/6xy730/dn/ud1Z6KEL4ez3/1Y+tVEGCbrN38PYv1aIvNTY9X/ju5X71B
	 2WfPL3XHefxng==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] wifi: brcmfmac: release 'root' node in all execution
 paths
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com>
References: <20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Hector Martin <marcan@marcan.st>,
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038429759.539202.17634636965892286169.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:18:19 +0000 (UTC)

Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The fixed patch introduced an additional condition to enter the scope
> where the 'root' device_node is released (!settings->board_type,
> currently 'err'), which avoid decrementing the refcount with a call to
> of_node_put() if that second condition is not satisfied.
> 
> Move the call to of_node_put() to the point where 'root' is no longer
> required to avoid leaking the resource if err is not zero.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7682de8b3351 ("wifi: brcmfmac: of: Fetch Apple properties")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Wireless patches go to wireless trees, not net. But no need to resend because
of this. And I think wireless-next is approriate for this fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


