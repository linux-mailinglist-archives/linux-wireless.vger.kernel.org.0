Return-Path: <linux-wireless+bounces-16081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19F9E9B23
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6791671F0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5131369B4;
	Mon,  9 Dec 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwQ8DmwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C51B424E;
	Mon,  9 Dec 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759995; cv=none; b=VK2brN4+OICBAnxM9QACEHSSG9CrlgzCMkTg0eUJeIXvi/tUSO7zsuJalZJAeiWFHq8uZqpeIz6jGzHXsDI8HvRdZlgpn6g4TdApbfSLSQi1yy3v0i5Af1TEYpuRdeta2e3Ya3qa4uq5U+8cmg4lWr1OVzkiHOf3yU+q4Il65fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759995; c=relaxed/simple;
	bh=LoZo1phuINHNiQheLhQrouah0Yc+DWfVMV7KgGTEWWY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=g5lu07Uu+FCnyfTr5IiQAomDwZ1CNnWlvDiduck7vZvbSlHxpCgTAC1NKfaCMjJYTuDMiQLKW6SP1va+2fRTtyrpeOnl62eW8H9fiAVeneFDu0Llt0SUp4Kn8KDz4rZXhurhPxslcgBBiuwjV7Yx+XaYG1KgDzBLdcmk6kFFhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwQ8DmwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE19C4CED1;
	Mon,  9 Dec 2024 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759995;
	bh=LoZo1phuINHNiQheLhQrouah0Yc+DWfVMV7KgGTEWWY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NwQ8DmwB/kmWKVfSDKodaWSN7HPeGfP/c79tBzPPG3l2F55LGe4dj76LaRg4WA2ec
	 QTuADTBO8sJMqm5fKaeJ6zugorPhQ5RwkO6fzfSWnscN6mVS2Y3hmXvRUdxslpCULL
	 UZ6nedB1YW/DY6N5e89UjshZwTkLvqBL9MUYQWL+b+EmyMdUwOpjrh/CikF7aDAnw6
	 vbVhEuBurYqkC2pE9TWx3/lC9Dm70FlsCsu47DZpe1LfJHebVqM0qa5mPS7SCOi2eM
	 BsBosT88YyZg15fpEuPE6gmO23pi1d7MsWoMS1W6LbXjZI2q7eW7Wqp8+b8lQ+Grsa
	 RsUeqqtp35xWw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from
 10s to 5s
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241127105709.4014302-1-treapking@chromium.org>
References: <20241127105709.4014302-1-treapking@chromium.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 Pin-yen Lin <treapking@chromium.org>, Doug Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173375999181.157598.15598577464504869106.kvalo@kernel.org>
Date: Mon,  9 Dec 2024 15:59:53 +0000 (UTC)

Pin-yen Lin <treapking@chromium.org> wrote:

> In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> wait_event_interruptible") it was noted that sometimes we seemed
> to miss the signal that our host sleep settings took effect. A
> 10 second timeout was added to the code to make sure we didn't
> hang forever waiting. It appears that this problem still exists
> and we hit the timeout sometimes for Chromebooks in the field.
> 
> Recently on ChromeOS we've started setting the DPM watchdog
> to trip if full system suspend takes over 10 seconds. Given
> the timeout in the original patch, obviously we're hitting
> the DPM watchdog before mwifiex gets a chance to timeout.
> 
> While we could increase the DPM watchdog in ChromeOS to avoid
> this problem, it's probably better to simply decrease the
> timeout. Any time we're waiting several seconds for the
> firmware to respond it's likely that the firmware won't ever
> respond. With that in mind, decrease the timeout in mwifiex
> from 10 seconds to 5 seconds.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

f143cece43dd wifi: mwifiex: decrease timeout waiting for host sleep from 10s to 5s

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241127105709.4014302-1-treapking@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


