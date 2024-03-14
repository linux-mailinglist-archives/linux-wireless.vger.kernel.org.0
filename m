Return-Path: <linux-wireless+bounces-4733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB887B9E4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D442D1C20A85
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403A6BB4E;
	Thu, 14 Mar 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urZlGzlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFB6BB45
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406669; cv=none; b=td7RX5Vm7Cf3OX8ufP3spHPXFOhtJVs29vrLMQwkyKOyLSkUbwIuF2XqMZwL2e18vyWcEVHNAZvsKlqE9gfAAha/ZcQRxC27c6QWcOukIyaFZR2zItDbiMudmF4iFLXVkO/0NKkGY8wXRHEi+HtWlQUSxUls2+W8TL2xMqXDtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406669; c=relaxed/simple;
	bh=vnpigjL/wJa5cfe4TCR5A0cUxuexPURN3oDPGzV8RNc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UZ0C8QWhf7RK1MimpjiUwwuV4wqCAMMza0f0oULWGlOQNvDL/ad6yC4rOLGHI+TssMcDasDmzJ8As6Hx6Limk83tZ43Bd5vII6y7EZ1jSlDwuAev/eDzD/iPjXk21C1UhJuo7tCKjb9s7XofrZXqb3THptx2G36mEj99KZtJKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urZlGzlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D4CC433C7;
	Thu, 14 Mar 2024 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710406669;
	bh=vnpigjL/wJa5cfe4TCR5A0cUxuexPURN3oDPGzV8RNc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=urZlGzlo/v1XwicSVZHGX2ioHFzXxNOE8+Xicav7jGqm2DVhDzOkMSEpNx48DCjrZ
	 nHdAQVUgyx/WpZHqzC5w7njf6wC5dDRiQnotx5sAbrKwtAwvDuZvShj4Mojc609U/w
	 sPu9RLr9izqHieoFvpz3Cga+7bq3S8h+oXWxmVrbKd+BQ0fwxi/bSDgujJ9UeBL0fK
	 gQKnUPOxJmGNo4YglX83XdHMwUCceU0ERxh9eJkXmupyRPB+TyL8MQ7yrmjzRFZCdB
	 EWAxW02HIzdX5nJal/jW5DpS6tJpyoryfbv5Tnv5uY/s09jm4ntFjfvzTluPSoHkOk
	 45u4kaELVz8Hg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: coex: Add WiFi role info format
 version 8
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240312013721.17452-2-pkshih@realtek.com>
References: <20240312013721.17452-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171040666658.2399140.8880384896950680639.kvalo@kernel.org>
Date: Thu, 14 Mar 2024 08:57:48 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> In order to control the hardware band and related protocol control,
> add version 8 format and related logic to control the mechanism.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

4e430ca43032 wifi: rtw89: coex: Add WiFi role info format version 8
bd120fa34f77 wifi: rtw89: coex: Add antenna setting function for RTL8922A
69cf60501642 wifi: rtw89: coex: Add TDMA version 7
a7d6f8d0c6d2 wifi: rtw89: coex: Add TDMA slot parameter setting version 7
89d58c931b59 wifi: rtw89: 8922a: update chip parameter for coex
f95d9045b987 wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240312013721.17452-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


