Return-Path: <linux-wireless+bounces-15179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F739C3DFD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CE328340C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13719B3EE;
	Mon, 11 Nov 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiINp8/K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433C19B3D3;
	Mon, 11 Nov 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326945; cv=none; b=BJf4iUgeh1oOuAdsnOwyLs0w63IKTfi1XI58YLic5NDKg7p28Hv+yfsHoFFD3HEBnX87eLnVhs8KS50ZdAIKZnyd0P2PW3j1xN+412r55VR7E7BR13lScJ/4TnR4ZuKH0/RNNTwWYQJl4atFgK6KfiTNTdhotUhHe6QeVsiuOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326945; c=relaxed/simple;
	bh=A+exTM+c4WEHboinnAW9kh9VZ91dw3lFctLT90geLgk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=X2Rjcfpg8B+mhoESKnpbcjuwMyppmrQxcMO19wwKqLuW26iVC8xjI3iicYTxRCkTfxxgKreoAo5RAY1LUBz8jdNidqvVMSAGWfgvhCxRkoWbOXuZXnreFqv8syMcnOFlsJpQ1eDUdfO/NI6y8Dw8kkpPPvrDZb1GU43uzJchuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiINp8/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8277FC4CECF;
	Mon, 11 Nov 2024 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731326945;
	bh=A+exTM+c4WEHboinnAW9kh9VZ91dw3lFctLT90geLgk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=iiINp8/Kc0BLa7lGG+Ox+hgHiTm+WclhaeF3NCjvFX/pTfBqzhv8yA+WwBjqmMrLH
	 fKGM+iarEdfHexU9Oor4ecfAqHtX6y1j3vkC8S/mJC1a+St/1A3Xba6+ifBmsVTCYx
	 qZ55V9La+xTiWIRVkwverlBSTJ0PYfUZdRp161XgkuMbnEGoRC4ksJf2HFHSyhRmld
	 wzswPVwkPq/a4LsnQc764v9qhX2TpgFafQARLhuwnxqON93B0G5evGdHISBqlNhWT/
	 1HyoDJUZqIGL0VbD/WDi23WDDtvfRV05igvEwyni2VEMQRd3YrsWEXajCujn/zZ5Cr
	 MuDU1ZzaHm5Pw==
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
Message-ID: <173132694092.852485.14071383005445209117.kvalo@kernel.org>
Date: Mon, 11 Nov 2024 12:09:02 +0000 (UTC)

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

Patch applied to wireless-next.git, thanks.

2e19a3b590eb wifi: brcmfmac: release 'root' node in all execution paths

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


