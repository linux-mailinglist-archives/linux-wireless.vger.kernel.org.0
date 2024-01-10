Return-Path: <linux-wireless+bounces-1674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F029829CEB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B36128127D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3354BA85;
	Wed, 10 Jan 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns6YjtcU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515354BA80
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D8AC433C7;
	Wed, 10 Jan 2024 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898549;
	bh=zk0pp87oBz7+VsnqQfuleDO3N+dplUi06CFqKXcmvYA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ns6YjtcU2ez8mfqSmEhFjoSBHGQdgZDuqw5Z2w+w2wJsDoyBJAyRDQWrzYcFOISne
	 HCAlutoOh6rGjBBptkY67FHSfgZAxIEMTrWlsi5eL2AzeSNZ2g9vSyY1Ncd/OxLS4Z
	 TMZBpQNBkpqjzB2DdE8Ov6qRmVmpv4jdixtpwZGI7xx0ehF3H/xtcTkyWMXqxFXkGQ
	 lMBwPwkGiss1V/5UtLSiKfrITp0x13UeL+ZLJ4oXEFjMWsyRktd1mUxwmhFGeKUJtS
	 Ldez5GyEOTsBjZTgeNk6xxwYanXNYotlDNvaSN9IRGYxyVYTEXiahKkEgo3uSrXdL/
	 ffBxp3DTfIICg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix off by one initial RTS rate
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <761e6836-6cd6-4930-91b6-0446834655c5@gmail.com>
References: <761e6836-6cd6-4930-91b6-0446834655c5@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489854669.471554.16245324804512530901.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:55:48 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtl8xxxu_set_basic_rates() sets the wrong initial RTS rate. It sets the
> next higher rate than the one it should set, e.g. 36M instead of 24M.
> 
> The while loop was supposed to find the index of the most significant
> bit which is 1, but it was copied incorrectly from the vendor driver.
> Use __fls() instead.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

80850ca041f2 wifi: rtl8xxxu: Fix off by one initial RTS rate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/761e6836-6cd6-4930-91b6-0446834655c5@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


