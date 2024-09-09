Return-Path: <linux-wireless+bounces-12661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E4971954
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14C91C22772
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4261EA6F;
	Mon,  9 Sep 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ9IyGL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5871DFF0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885015; cv=none; b=THR301jp6Ian0g5VgFG4rvbZpZjXfAiXs1MuaGOxXlRGlPkSEK7BVEv2Oxz2M51hAjH4NEQ7cch6Kk8QhZIXC+Kqxs8Nv1U6I0JkenVo9EIPuEy1aEKB0X6ZmbTPl7WT+PkgoIrpLdcLC7RFQSOr7H3JCWWid8sbsIbtSxrPuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885015; c=relaxed/simple;
	bh=a6KWyIaSAis55fEoMbAUmaar/fAd5K4hoWDZ7vk0/yY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GYPzqAYAB0W5cNekKVAdhIh4heHV8dOSYf8tUp3idq093HIo0iaj26b/u7a9vvn38AOHuhNVGMxrybZBEY6zSl7GDjs6djxs+UKDsmx3xTJRsBW+UKek4gFB+jjfyZ6dy7EkelhYRMLSx491KudYteZYw51Fp1jUDlxGtM5NJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ9IyGL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C5AC4CEC5;
	Mon,  9 Sep 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885015;
	bh=a6KWyIaSAis55fEoMbAUmaar/fAd5K4hoWDZ7vk0/yY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qQ9IyGL40xVJ8vmeIyNEthJAue/cKzAzuUZ6dRGXmNbKI45bG22K8KQBJWqaHrVG8
	 JjiVVR2BmFw6aQ5TUKOcPWknhInfZ+EYJPXkqfir435KTT9bssAqLgWjBWIvJZP88r
	 PVy++c7pNDNoEdRktg+r6B1hYChf+ZkVf1j+vIcyALwGIN7YkBcJS8170zgI7L7VUl
	 oTt9RA4rewPZTezEtUTf0R+ayIB8AUBPeoBlDuyezqjZRuJ/hfGiPfhqdTj/clh5yf
	 hO/rSHAj+d+/V9A7KzERCcZ5rTcRKZ5bWnPJQUSThMoOi3FjYWHkNAvZ4p0qlznsub
	 7/ml10cr65NCA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next 1/2] wifi: wilc1000: Convert using
 devm_clk_get_optional_enabled() in wilc_sdio_probe()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240903110205.4127706-2-lizetao1@huawei.com>
References: <20240903110205.4127706-2-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <lizetao1@huawei.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588501263.2095526.8592334025775231518.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:30:14 +0000 (UTC)

Li Zetao <lizetao1@huawei.com> wrote:

> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
> clk_prepare_enable(), which can make the clk consistent with the device
> life cycle and reduce the risk of unreleased clk resources. Since the
> device framework has automatically released the clk resource, there is
> no need to execute clk_disable_unprepare(clk) on the error path, drop
> the clk_disable_unprepare label, and the original error process can change
> to dispose_irq.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

2 patches applied to wireless-next.git, thanks.

554475248177 wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_sdio_probe()
ff63a5c72782 wifi: wilc1000: Convert using devm_clk_get_optional_enabled() in wilc_bus_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240903110205.4127706-2-lizetao1@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


