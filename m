Return-Path: <linux-wireless+bounces-2268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA304832E37
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73338288202
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685C55C27;
	Fri, 19 Jan 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSxfQraL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366E5577D
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685551; cv=none; b=AfEksk4EmukL8Dzjo2TwmE4006OV52KS+3388FuiarZZVLxgFk7nSAPyPcbUgCsWSbgxwy/iJxHmgnRSLOw9Ja1dE6gcnbIfN5e9/3CKI5urccuVToTQ3a0SmkRAk6lJVTJtOTahJERur7m/i1ceK4jIAgbdVGvnXV/Kv2LViTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685551; c=relaxed/simple;
	bh=excGy2Kit/0jLlf0w3oCZQpLAtXLvjOTw65Aohq6PRM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GZp7l3JPO1CC5PISS9ak8fjNg67+jaWAv+KBCLyw/cPxym2SYc8BwMcbmyMoYO4SuzdxiFky15y994NlfJ8fkRWYd8kZUYeihPHHy0t+BGUMjMwET12qaCQEw8T6vi++zSEKjTVz/BO5JsNj/7yb6/ry4f6KdasUNDC6nn5xwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSxfQraL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D35FC433F1;
	Fri, 19 Jan 2024 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685551;
	bh=excGy2Kit/0jLlf0w3oCZQpLAtXLvjOTw65Aohq6PRM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mSxfQraLn9wC/0dhMCo8GqB5ENSa6A5958PUJCpbJuTAlfz5PJmDlxlykf9OPBWXx
	 At+dcktYyZId1jNABvxEHQYtBfBse5sjx6fWU1DaoTyvoQUzAX5PoqNBEtLd4HYxhO
	 W+F6PJ6izClQyb+kLBo7W3LSj1HoAJdvKznJm+T4VWnt7PMNLhqg9FNgX6GbMR3e3n
	 WbbPBDloM0wEQKnEINPBpXMbmy+c08We6E22DX9MsEAgilKhzj5rW3zaUQRy377Jpp
	 ot4JuF/j4XpmF3R139o3+xPNxGqe0NTJfML2eT7vukLBORf9LF5VCkIrNyc3gSNKKt
	 TE0RiE8ro9C+g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240118090413.130989-2-pkshih@realtek.com>
References: <20240118090413.130989-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568554797.3153793.8904120631448751736.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:32:30 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> WiFi 7 chips can operate in various MLO applications, such as 1 link (2SS)
> and 2 links (1SS + 1SS), and we should configure different PHY mode for
> each of them.
> 
> For example,
>  - MLO_2_PLUS_0_1RF is 1 link with 2SS rate, and enable one RF component.
>  - MLO_1_PLUS_1_1RF is 2 links with 1SS rate for each, and enable one RF
>    component that can support two paths.
> 
> By default, we set the mode to legacy MLO_DBCC_NOT_SUPPORT (don't support
> MLO and DBCC yet), and later we will introduce logic to change the mode.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply:

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw89/rtw8922a.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtw89: 8922a: add TX power related ops
Patch failed at 0001 wifi: rtw89: 8922a: add TX power related ops

6 patches set to Changes Requested.

13522603 [v2,1/6] wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
13522604 [v2,2/6] wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
13522605 [v2,3/6] wifi: rtw89: 8922a: add chip_ops related to BB init
13522606 [v2,4/6] wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR and EDCCA
13522607 [v2,5/6] wifi: rtw89: 8922a: add TX power related ops
13522608 [v2,6/6] wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to control TX/RX

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240118090413.130989-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


