Return-Path: <linux-wireless+bounces-701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3580EFF6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE10281B7D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB37541A;
	Tue, 12 Dec 2023 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cweehXGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073975403
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B92C433C8;
	Tue, 12 Dec 2023 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702394380;
	bh=pB4Lf+cqNDEa4eBh+9FLesImpaV+xhjAw2rspTO9j94=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cweehXGPGcjhKkJ1b/Swel1ktHwTPAcRsaSRa7SUYeyygXWWRbZppcujgX+vyitbe
	 pY+Rv2bea4eCc/r7rVtCw8r0uKp3k6/byNVn7W6ok+YB9K2H67ROuQWfTsxfC7GYxl
	 Mv5y2uvu9qHRPMvTkuB0fOjvJE/42pAzPalGHxdZ9xirmLc0e6C9beYuYFvep3VYCm
	 yTzH4mj2/VfZy+c1SEV8F6kRtX0P0uNAeT371HFke67RNbadm3wJE2zn1/ul1nL07u
	 lC85QZs5R9gwoOvHQsvJ6cGepuRZdCMgUrMqZ+tTVxa6pUBH5MMznYQUPhi7pcbepr
	 AhyfWE17BgAbg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: fw: load TX power track tables from
 fw_element
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231206124448.10537-2-pkshih@realtek.com>
References: <20231206124448.10537-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239437797.306086.16729667007676555795.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:19:39 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The TX power track tables are used to define compensation power reflected
> to thermal value. Currently, we have 16 (2 * 4 * 2) tables made by
> combinations of
>   {negative/positive thermal value, 2GHz/2GHz-CCK/5GHz/6GHz, path A/B}
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, don't know why.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw89/fw.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtw89: parse and print out RFK log from C2H events
Patch failed at 0001 wifi: rtw89: parse and print out RFK log from C2H events

6 patches set to Changes Requested.

13481758 [1/6] wifi: rtw89: fw: load TX power track tables from fw_element
13481756 [2/6] wifi: rtw89: fw: add version field to BB MCU firmware element
13481757 [3/6] wifi: rtw89: load RFK log format string from firmware file
13481753 [4/6] wifi: rtw89: add C2H event handlers of RFK log and report
13481755 [5/6] wifi: rtw89: parse and print out RFK log from C2H events
13481754 [6/6] wifi: rtw89: phy: print out RFK log with formatted string

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231206124448.10537-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


