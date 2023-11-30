Return-Path: <linux-wireless+bounces-254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2704C7FFB15
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570A11C20BFC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639041757;
	Thu, 30 Nov 2023 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj0Onlom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EF5FEED
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B13C433C7;
	Thu, 30 Nov 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701372024;
	bh=jDsGxSX4nAbsyxY05fW6w1LqGOBjEF6kDcyanSEDewQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Bj0OnlomJE3niPZEf5F2T116wRC+pt20K64Hh/jcjfmSQdC8m9bUlRyQc/F9Q5Gv1
	 oc/Uxoa9wMDQtl5bahK26nIyGIs1ULU7M5H8nAqq/7Z2rzrSmjIWGkTnaHlGlFGEOh
	 WfPGTzNgwPEOkmv2i5cg+n/+FgbVo8q5bs6R6W/hCuBZFdAeA9J0Ul/bH/9XsPArmJ
	 IHT3FeBHqwUU7gsMbt6dFQTjBqXMrqgxKyl96xokXTHimy7Hf85BC5Nv4buI0gRgfB
	 bXQby2YGHpbks9/d2wCg5PA+/0SzQghYNnkuaUlDOx8xK7XwypYcb/JKmHK7cOCzr4
	 jbnHp+6P8E4jw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: debug: remove wrapper of rtw_dbg()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231122061429.34487-1-pkshih@realtek.com>
References: <20231122061429.34487-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137202170.1963309.15204459932422293851.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:20:23 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Remove unnecessary wrapper of rtw_dbg(), and just call it directly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

1da420601284 wifi: rtw88: debug: remove wrapper of rtw_dbg()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231122061429.34487-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


