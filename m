Return-Path: <linux-wireless+bounces-12342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414BB968C47
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18D9283BF9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E411AB6DB;
	Mon,  2 Sep 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZYQXRGG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976C1AB6D3;
	Mon,  2 Sep 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295141; cv=none; b=qQcM1CVsYr+GWKBhMj9g1cXAzThuf01HPmoiEwYpIJ6vkfR4+SBVfyYnfnIblFIS7OZNoMtFl9LieXqp2Fi79isLOzn3sadKWCYVQGBzSCswZda/uYCgaDIdGUgRC9O41LykxW9aTu9TwsRUTtTlUY0qnX42fpbPlRzDF4bB9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295141; c=relaxed/simple;
	bh=THOWirjnif2PCoJgyUp+GH1dq/VbXAjyaMqmMGMYEYY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nXzmapzJNKWS4G2eIBsL49uBM/65+/UQk0Hdj7XzckeK9m5GnD9vgAdVrzr0wdO93fo6uTtQp0Dlc4H9y7SeWq0UkoGJhFagleeeM8NN1hWT8sJFuUAWfgdUrTaonWmaE2jUpdeVRuiiISJhCKEh3w6Gh143DfpgVuc68fxwerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZYQXRGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0BFC4CEC2;
	Mon,  2 Sep 2024 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725295141;
	bh=THOWirjnif2PCoJgyUp+GH1dq/VbXAjyaMqmMGMYEYY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LZYQXRGGQMR4i8GrOz6Nvk9Mte2YR2JtOQ1HrrFs5dAU8NvnvkHkaLwCyexWjYdts
	 ubDoH6lTtoo3lJ3OMooT1HxkdZbjY2OsIB0QGT+ktHIytZ698mxNnQSS8fPTDY28G0
	 5iLvTPev/gqdUwsbixADfRCPPrbNp+3GDl8hm+nImdtoSaWa86BcbY+6Ei0RES8iLl
	 AOAwElrHsMcPFBvhvaafng1q0jE4Zz3SNXjQ9ZSUpJjLV86fRRbNj1QLcKXHOUcSMx
	 k95sFsMmx4WARbzCI8l80Ur743CDSkT9rtMZLfnPR3DkVwewHV8LU00ZRabUpGsRS/
	 frSCIn8VVw79Q==
From: Kalle Valo <kvalo@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: <florian.fainelli@broadcom.com>,  <andrew@lunn.ch>,
  <olteanv@gmail.com>,  <davem@davemloft.net>,  <edumazet@google.com>,
  <kuba@kernel.org>,  <pabeni@redhat.com>,  <wens@csie.org>,
  <jernej.skrabec@gmail.com>,  <samuel@sholland.org>,  <heiko@sntech.de>,
  <yisen.zhuang@huawei.com>,  <salil.mehta@huawei.com>,
  <hauke@hauke-m.de>,  <alexandre.torgue@foss.st.com>,
  <joabreu@synopsys.com>,  <mcoquelin.stm32@gmail.com>,
  <wellslutw@gmail.com>,  <radhey.shyam.pandey@amd.com>,
  <michal.simek@amd.com>,  <ajay.kathat@microchip.com>,
  <claudiu.beznea@tuxon.dev>,  <u.kleine-koenig@pengutronix.de>,
  <jacky_chou@aspeedtech.com>,  <netdev@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-sunxi@lists.linux.dev>,
  <linux-rockchip@lists.infradead.org>,
  <linux-stm32@st-md-mailman.stormreply.com>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next 11/12] wifi: wilc1000: Convert using
 devm_clk_get_optional_enabled() in wilc_sdio_probe()
References: <20240831021334.1907921-1-lizetao1@huawei.com>
	<20240831021334.1907921-12-lizetao1@huawei.com>
Date: Mon, 02 Sep 2024 19:38:53 +0300
In-Reply-To: <20240831021334.1907921-12-lizetao1@huawei.com> (Li Zetao's
	message of "Sat, 31 Aug 2024 10:13:33 +0800")
Message-ID: <87a5gqko2q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Zetao <lizetao1@huawei.com> writes:

> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
> clk_prepare_enable(), which can make the clk consistent with the device
> life cycle and reduce the risk of unreleased clk resources. Since the
> device framework has automatically released the clk resource, there is
> no need to execute clk_disable_unprepare(clk) on the error path, drop
> the clk_disable_unprepare label, and the original error process can change
> to dispose_irq.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/sdio.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

wifi patches (patches 11 and 12) go via wireless-next, please submit
those separately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

