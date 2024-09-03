Return-Path: <linux-wireless+bounces-12369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC610969610
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720CEB23652
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5521D61A3;
	Tue,  3 Sep 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO3adIGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B11865F0;
	Tue,  3 Sep 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349860; cv=none; b=cZEePB1xeW9KnCvGD7vzrM5vpTHtrWz3iulzkBk1GLfxeAAJsxdI5Nobql+B1rAhE45lVoEVm1ZFd7XBwvCdFwWWrfrycmy5PVj/vwp8hsGsiy0t3j6Ngcb6gdQ7SVeA78x4SLsuIF/8DP19jMoLj4prnFwKVPUTDqNfqnsib34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349860; c=relaxed/simple;
	bh=enMEnSyK0jNHPU7yp7IVPrx6oVxfPhkG/5GIYZ4dcKg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IT/JtTwCSAw6BmI8dOo91s2qzN5I5gCbvyDIjhFCKrVP3YWyOy7jv0BzSNoBdQFVwymlmFD000c6SjnPRx4V1806UqyPovfPaRVKIHWLrsz5/DLvIttOv0+wWoraiFhfkOZxImhg1JO8CIk7DdcR3VZoyiVM+HSKVvnwhTow8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO3adIGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74599C4CEC5;
	Tue,  3 Sep 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725349860;
	bh=enMEnSyK0jNHPU7yp7IVPrx6oVxfPhkG/5GIYZ4dcKg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PO3adIGD9QXcaLxsn+UYkxTFEniu9l4gE1ID45KjMX3yLkH5DazB0u1IBB4d8vzLd
	 l/5Fwl56gGpveG03eWt1WQIQ6p0u20PAR8qsqMsWDFDjeWnjFgGB4yB8ZntUoCyOYk
	 i1+EQxTEc6gtNRk1puU0jPx9BWXqfdunZoZ0ergRNWaqwnEHL5xHi1KHsIv+qHZc85
	 omyj9bce8K6nzb1MAWzf5BhEH6LvF2uxfoINz0TUt+DwPYibmNnq3U6fpx8Lbbch+5
	 5irOVssMvG9hSRB0/kkowIxiu22jDabPJAvw/Pw/5ooAs73F4bifl/MVu3exXaWGme
	 Picnt1dGInvMg==
From: Kalle Valo <kvalo@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: nbd@nbd.name,  lorenzo@kernel.org,  ryder.lee@mediatek.com,
  shayne.chen@mediatek.com,  sean.wang@mediatek.com,
  matthias.bgg@gmail.com,  angelogioacchino.delregno@collabora.com,
  mingyen.hsieh@mediatek.com,  deren.wu@mediatek.com,
  ruanjinjie@huawei.com,  greearb@candelatech.com,
  akpm@linux-foundation.org,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  stable@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: mt76: mt7921: Check devm_kasprintf()
 returned value
References: <20240903014455.4144536-1-make24@iscas.ac.cn>
Date: Tue, 03 Sep 2024 10:50:54 +0300
In-Reply-To: <20240903014455.4144536-1-make24@iscas.ac.cn> (Ma Ke's message of
	"Tue, 3 Sep 2024 09:44:55 +0800")
Message-ID: <87wmjtjhup.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ma Ke <make24@iscas.ac.cn> writes:

> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 6ae39b7c7ed4 ("wifi: mt76: mt7921: Support temp sensor")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index ef0c721d26e3..5ab395d9d93e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -52,6 +52,8 @@ static int mt7921_thermal_init(struct mt792x_phy *phy)
>  
>  	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
>  			      wiphy_name(wiphy));
> +	if (!name)
> +		return -ENOMEM;
>  
>  	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
>  						       mt7921_hwmon_groups);

You sent the previous version of this on August 26th:

https://patchwork.kernel.org/project/linux-wireless/patch/20240826095535.2603538-1-make24@iscas.ac.cn/

Please stop spamming like this and understand that maintainers are busy.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

