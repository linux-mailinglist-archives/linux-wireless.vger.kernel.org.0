Return-Path: <linux-wireless+bounces-1116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3981A6DD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FB81C21E97
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6BF482DC;
	Wed, 20 Dec 2023 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv3Z21v/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CEE482DB
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 18:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89449C433C7;
	Wed, 20 Dec 2023 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703096898;
	bh=bAikfmZIyO2RPJ788KNcSvoQgCBjzM+PCJALwuqCLHk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cv3Z21v/mSw6ZO1HZiKv6wjDKdYHqRIoEuFh0r0qY3tNQVyJlwflBpW2S3D9/V3IV
	 IN5YX6CS+GB6bN5Xfgzkm1SvdO6lQ87ToL4fZKLL6mED7128e+dQgcj3lxj1gAoxAN
	 th8+NJsHne1vkHTqBlzC0Ua3V7mXncPuqbU4hFFb6sIz13M4MxCXnY8wpY77PDFhYs
	 eTSC7tSAd1h7UBlpKP/zwyQ45uVlJzlwJ06LBbdrVp4QzYy0ahFemi9CPbU3ROTtyM
	 bXpIz8hJWs/U2hBQdBaKfBtYze1nVW5bNFTQiRYUuaiJY2g0LIbKpcAaSgxlwswOys
	 hHaiSPA/jilEw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] wifi: rtw89: coex: Fix wrong Wi-Fi role info and
 FDDT
 parameter members
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231218061341.51255-2-pkshih@realtek.com>
References: <20231218061341.51255-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170309689549.981918.304961095886409491.kvalo@kernel.org>
Date: Wed, 20 Dec 2023 18:28:17 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The Wi-Fi firmware 29.29.X should use version 2 role info format. FDDT
> mechanism version 5 use the same cell members to judge traffic situation,
> don't need to add another new format.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

acc55d7dd4de wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members
e9ff8a96e3aa wifi: rtw89: coex: Record down Wi-Fi initial mode information
21aa791b4367 wifi: rtw89: coex: Add Pre-AGC control to enhance Wi-Fi RX performance
07912ecb3eb2 wifi: rtw89: coex: Update BTG control related logic
3ac4b57ca12d wifi: rtw89: coex: Still show hardware grant signal info even Wi-Fi is PS
94fb737042c1 wifi: rtw89: coex: Update coexistence policy for Wi-Fi LPS
0c1829dc7a5d wifi: rtw89: coex: Set Bluetooth scan low-priority when Wi-Fi link/scan
221a72f73888 wifi: rtw89: coex: Add Bluetooth RSSI level information
6e5cf39f3107 wifi: rtw89: coex: Update RF parameter control setting logic
c744f523cecb wifi: rtw89: coex: Translate antenna configuration from ID to string
28a197af3fcb wifi: rtw89: coex: To improve Wi-Fi performance while BT is idle

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231218061341.51255-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


