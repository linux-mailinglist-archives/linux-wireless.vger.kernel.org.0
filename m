Return-Path: <linux-wireless+bounces-1831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E882C466
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0252D1F248CB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7217C95;
	Fri, 12 Jan 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGDdqYTQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B917C94
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2C0C433F1;
	Fri, 12 Jan 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079509;
	bh=BWzY77o7dbVvGdkvhM1MNGEbJ7fo4KwhUL+pmMZ3nso=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=EGDdqYTQsY3665vdzFxw/HMjzdf3CfCZrPLE2EFntuttxJoiVPjcQldw9BDJEC7W8
	 85Q8SVbKrpoByUjMVL8vMwDB0MqNjEQ7V46olMAiTN6kkTqCoitRF9w7dLdPcHzQ3C
	 xlinp78qofv3xOyWGI36gnbRTEpocUglAEAMhAY1kO+vBT2ej8vfBFgWYVdsM3adF1
	 IrT8XhbA6WsnM6uIb9svtnezd47aeUEiO7xQXX6ulMkOfveelrpYUn4wI6cujcARuG
	 meqnrVcPpdgQeax+sdVIx2KlQwrLcuPHI+KLkFXwLQ2n5B4stShgLOwbNsDy88dL96
	 9bGtx/uiObqkg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: cleanup few rtlxxx_tx_fill_desc() routines
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240109104735.140550-1-dmantipov@yandex.ru>
References: <20240109104735.140550-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170507950712.1153005.11217968459518546857.kvalo@kernel.org>
Date: Fri, 12 Jan 2024 17:11:48 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove unreachable branches in 'rtl92ce_tx_fill_desc()',
> 'rtl92cu_tx_fill_desc()' and 'rtl8723e_tx_fill_desc()'.
> Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patch applied to wireless-next.git, thanks.

0ac008b6357f wifi: rtlwifi: cleanup few rtlxxx_tx_fill_desc() routines

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240109104735.140550-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


