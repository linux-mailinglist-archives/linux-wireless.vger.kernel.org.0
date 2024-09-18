Return-Path: <linux-wireless+bounces-12935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22A97B894
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B192B210A8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B386481AB;
	Wed, 18 Sep 2024 07:32:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from IgnazServer.ignaz.org (IgnazServer.ignaz.org [37.252.120.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E59273DC;
	Wed, 18 Sep 2024 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.252.120.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644768; cv=none; b=JZZ+vQJgctLoEyMyOnDGBL6OiI/JO8QBxM3mS4v+vPcbycec8LvUwujnnoger+qqd7JToB8/LPq4jbzEwkQ9W17HBD5oTMxCqpWEdFVzeyEJM3TQxVQ6R0PM9oKXpmZH9zO573938MlxRHVoY1Z+EDzAZpgzYAaPZ9+v+d5eGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644768; c=relaxed/simple;
	bh=CR11bOxKhVYIH7UYtKrY4JU3oySaM9UVFwyhDOyz7Mw=;
	h=From:To:Cc:Subject:References:In-Reply-To:Message-ID:Date:
	 Content-Type:MIME-Version; b=QAjZKvTi6C5OhQ8bJLn/1ACG98ZERMnKCphKKswRf1CuQNDcGPJbYFfxUhXE2MkGYr437Fcoj7a1sT/uF1gw9OyEhJtlLELy9FxlfZKau6pE6Nlycd7bb5iC6WQdGSNfqlwa55mzkDPkJHfykHpT8d4CONPL4d3hA0IfQz5njP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org; spf=pass smtp.mailfrom=ignaz.org; arc=none smtp.client-ip=37.252.120.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ignaz.org
Received: from ignaz.org (localhost.localdomain [127.0.0.1])
	by IgnazServer.ignaz.org (IgnazServer) with ESMTPSA id 0709541088;
	Wed, 18 Sep 2024 09:32:38 +0200 (CEST)
From: Marcel =?utf-8?b?V2Vpw59lbmJhY2g=?= <mweissenbach@ignaz.org>
To: stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Cc: regressions@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
References: <f755bbeb5bbb479f9142bf223e71102c@realtek.com>
In-Reply-To: <f755bbeb5bbb479f9142bf223e71102c@realtek.com>
Message-ID: <20240918073237.Horde.VLueh0_KaiDw-9asEEcdM84@ignaz.org>
User-Agent: Horde Application Framework 5
Date: Wed, 18 Sep 2024 07:32:37 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting ret to -1 did the job, wifi works again as expected.
 
Here is the output of dmidecode
https://ignaz.org/nextcloud/index.php/s/tZdjYYdyeWpHPH4
 
Thanks a lot
 
"Ping-Ke Shih" pkshih@realtek.com – 2024年9月18日 15:02
> Marcel Weißenbach <mweissenbach@ignaz.org> wrote:
> > 
> > Hi there,
> > 
> > i upgraded my Archlinux testing setup from 6.10.9 to 6.11 and noticed that my wifi is no longer working.
> 
> Checking the commits between 6.10.9 and 6.11, I feel the cause is
> 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> 
> Seemingly there is 36-bit PCI DMA interoperability on RTL8852BE.
> Could you please try below to comment out the function? 
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
> index 02afeb3acce4..039fc329c6f7 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -3061,7 +3061,7 @@ static int rtw89_pci_setup_mapping(struct rtw89_dev *rtwdev,
> goto err;
> }
> 
> - ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> + ret = -1;//dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> if (!ret) {
> rtwpci->enable_dac = true;
> rtw89_pci_cfg_dac(rtwdev);
> 
> 
> If this helps, please provide your DMI info by 'sudo dmidecode'. I will build
> a quirk table for it since I don't know what the exact settings affect this.
> 
>

