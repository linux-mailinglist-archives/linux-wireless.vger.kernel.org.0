Return-Path: <linux-wireless+bounces-293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D7800B2C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621621C20FDE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B682554C;
	Fri,  1 Dec 2023 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViETzjP8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DF2555F
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 12:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD9C433C9;
	Fri,  1 Dec 2023 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434395;
	bh=s7tnhMjKJ6MtT/nzRmY2hyYT7Gaqa1WoLkxKw5vNAXM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ViETzjP8tql1KEYqtn5H5yGxTKA5gJuTLpdkWF3SbTUjFKPAjvgK44AYw6f7dUiMm
	 6piILIpzpM1pz1OGYQ6anCMLWzMS6mI0smn9vWM2c+Y/ys8Fz6KNXChIXR71oGcy1I
	 rqzLnBGKgTG+7qXJl15WqkJl3KN0hSAEpYfHvtIRFeN5LsYS9YHGrkSQ/f0TE5rxj1
	 JKRNvCLLB4vWxyMKC7snBoNPDmjCf3qBJseTg9sw/UruPy6SSVIPSvG6UVMq+nkdxv
	 8stx/t6RI9nO2PwCFSXXScVaM4uOFhPQ5wZ5evByVp3hxkC4X1waZa6xsEssC4icm9
	 ot1CjJDtywy6A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: 8922a: extend and add quota number
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231124071703.132549-2-pkshih@realtek.com>
References: <20231124071703.132549-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143439316.2072551.5249906107460541733.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:39:54 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Define 8922A buffer quota that are used by HCI control flow, payload
> engine, descriptor engine and etc for operation modes, such as SCC (single
> channel concurrence) and download firmware. Since WiFi 7 chips has more
> buffer classifications, add fields and struct according to design.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

fdb3bb0af259 wifi: rtw89: 8922a: extend and add quota number
cecf1643145a wifi: rtw89: mac: add to get DLE reserved quota
aabe741e2d18 wifi: rtw89: add reserved size as factor of DLE used size
2706cb25028d wifi: rtw89: refine element naming used by queue empty check
27ea6be913f4 wifi: rtw89: mac: check queue empty according to chip gen
0d16d8fbffb3 wifi: rtw89: mac: move code related to hardware engine to individual functions
39e9b5691921 wifi: rtw89: mac: use pointer to access functions of hardware engine and quota
1dd1dc262afa wifi: rtw89: mac: functions to configure hardware engine and quota for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231124071703.132549-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


