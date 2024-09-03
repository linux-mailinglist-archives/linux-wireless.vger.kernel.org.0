Return-Path: <linux-wireless+bounces-12403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F596A691
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242D71F24AE6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87081917CD;
	Tue,  3 Sep 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJr2Hou4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40BE1917C8
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388271; cv=none; b=oBtD3LIMiRACrsYJBCTrPOBLZsQh90Tq9i/CadDTm3e66oQElgNhBQMMO+jyNtlLq0fZ6Pt2ZiDhw77Z5/EGfjduk8ThFTBFQBLkT++yEwH0XWkxx2He4PUZh07CNn093ijBSMHfr0mP2F4Wg018qebBIi8bqIuXOLAQhyrqNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388271; c=relaxed/simple;
	bh=N9YEb8TB8fmWgBH6JBK4OmgxvqEtTUPPSue2kicF8h4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MEvGQg16PT8y6Y9m4HJLsHTltQU28wnh18cRa+jc0tOXDrHoC4/P6CeyLdHS0pIxkrbYiLX1uzvjVfFlG6I7KrKQhlyn42KtQySJ7Z2xsaZvI+lBpJz9LRdRIvv2J9m6oKI+iAlkUu09WMXkvu/GdGv5mz92xEa7am2lMDbE4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJr2Hou4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D300C4CEC4;
	Tue,  3 Sep 2024 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388271;
	bh=N9YEb8TB8fmWgBH6JBK4OmgxvqEtTUPPSue2kicF8h4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MJr2Hou4qRNHBvDHL1iUa1j3RNWUoi5F1MER3MmlqqL9e7WJ7ytxRcCaoOTCQvmGu
	 Xbo6kSmNxSSF3afKX6Twg4QhxDyR8Q4meNCNIMAVwlZ4xdD83vCOxlXTc41GIiFZvi
	 527qxGQUexs5X+JVczdaX7xwfLnrDmqyjDYrj+wvZxd2GE2zFoaRg839VmrWA1t2xZ
	 5li45AEy3D5ZrQJSowRTBfUdfNUfV3PbXkEe3HNfmyBkKHgvB71lwr9wn9meHrUskS
	 Nfh5Izn9EImFgFk58PK0o7j19DJJepqTZ2wRnFVn+/b88E/wuAfsy/jo5g0OwPs44I
	 uOm/j2TZRiWew==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wilc1000: Re-enable RTC clock on resume
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240821183717.163235-1-marex@denx.de>
References: <20240821183717.163235-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538826800.1029035.9364345182481936321.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:31:09 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> The wilc_sdio_suspend() does clk_disable_unprepare() on rtc_clk clock,
> make sure wilc_sdio_resume() does matching clk_prepare_enable(), else
> any suspend/resume cycle leads to clock disable/enable imbalance. Fix
> the imbalance.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

0c896eceb5f3 wifi: wilc1000: Re-enable RTC clock on resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240821183717.163235-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


