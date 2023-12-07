Return-Path: <linux-wireless+bounces-552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C93808D55
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DF71C208D2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC575446DF;
	Thu,  7 Dec 2023 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHxt1QUP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A53309C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0BCC433C7;
	Thu,  7 Dec 2023 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701966159;
	bh=VjWwRkjZ6GJHs8Z7i1gVP0UMhrOhgBJ4v5WpJGII6XU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FHxt1QUPVb5U5ZzmDV8H6YdIE+vRlTfUyTa4igy0tNPdXAFCjpZDfq5OxgMr0uLD8
	 y8vwNYWC2KOqojpfbjCbK57NszXlsMxYQEzD4b1TJM9uvzxcYLoNZbe40SJfVcbJIe
	 DaS5DvZgjqnuFvPFwuNLr34+96vPQ5LpPE0wXuJQw9W5r14Xu0hbaFLlximjb/9pJG
	 X0zgw67MR4GHYVoHXIm5LEQxcxUTgcmSiwZR4xy0MyWTzgbnmQOAjXOsJsvc/fww4q
	 VCP07HkiNk/jQgZYjNpRDtGMPB6rSV0LgJbSw642wcb0FfNeSD4v7tlUSDypK7Wmh2
	 p+3LXQpqyzm7w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: 8922a: configure CRASH_TRIGGER FW
 feature
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231204080751.15354-2-pkshih@realtek.com>
References: <20231204080751.15354-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170196615642.2897000.18123917834588986269.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 16:22:37 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> RTL8922A FW supports CRASH_TRIGGER feature from v0.34.30.0.
> After it, debugfs fw_crash can accept type 1 on RTL8922A to
> trigger firmware crash and verify L2 recovery.
> 
> Besides, RTL8922A sync address offset of reserved payload engine.
> And, SER (system error recovery) tweaks conversion from WCPU address
> to indirect access address for RTL8922A. The new conversion works
> for all supported chips.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

c5ece8d84303 wifi: rtw89: 8922a: configure CRASH_TRIGGER FW feature
2a68a27cd27a wifi: rtw89: fw: extend program counter dump for Wi-Fi 7 chip
eeb8cbb58b82 wifi: rtw89: 8922a: add SER IMR tables
6f8d36552bab wifi: rtw89: 8922a: dump MAC registers when SER occurs
db7fac15eaf0 wifi: rtw89: mac: refine SER setting during WiFi CPU power on

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231204080751.15354-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


