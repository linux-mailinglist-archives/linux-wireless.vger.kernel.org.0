Return-Path: <linux-wireless+bounces-14147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8D9A24EB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1DF28B695
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1F1DD0CE;
	Thu, 17 Oct 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g51dj++1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1E1DAC8E
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175007; cv=none; b=rAneobxa2BVaNhBjTYHsaohA+xFiYMTm3DooL3ysCVr5dw0J4J86ZdQ4cofNNmlT3y45+VM9o0jJYupyU2Q8va0JJgVRftUm304SsqyywLUdI4DWGHFSLJCA6H3SW55VpfhWRY7Vmm0RPlDwszxjMdj62e5k23pIV0dM33afuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175007; c=relaxed/simple;
	bh=ysYslYge6baX8carhRbOFXI8O0kLTSjU1WwpKjC4XZY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rI2JmjfDc1w0oF7pnsPBIQ8DfDrbGjjMcOK/TAVtwhPSwN3K/nSeE1HGchiaOKJ74rPFrgcR6ZNCt7eOi5r0roye6M8SDrxwDPUeIEV6B+Q0+PHwhgMEkDSvzfZg4e9N/QKsZvA7OEEAZc7t0CNd3E3QDqlLIw0usSNyPo1Q9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g51dj++1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203F1C4CEC3;
	Thu, 17 Oct 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175006;
	bh=ysYslYge6baX8carhRbOFXI8O0kLTSjU1WwpKjC4XZY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=g51dj++1r7631ji5FX9+PXHZTEYzgNgg6ExQRkGtGW4/TqYn5hfUyhboNiNBVFFHk
	 0Qywm3mWzdFCm01F6X+XDAH83CNYzCxb9so4yDVpSxXGlC3r7BlIFoDiX4g+WY7LVd
	 7OSMQHQxJnyie0WlKQ5zQjuH8GkF3PbYxy+9mU5HscJ1/+I+doMKRLze3Dd+qCxyhL
	 uKUje2qimDKXlz/Iz0I9Lr5aGP78kXS4jjw275cMcWr5NmHpjbwOwjmaCenq6jLtCs
	 AXFt25q+m5aYaI3VmlyByqUXD1a3VosYRQmHKcebAsxnvyGOG+RN2Xtx965t8xhS5e
	 6s4PfWoLEJLlg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on
 specific PCI hosts
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240924021633.19861-1-pkshih@realtek.com>
References: <20240924021633.19861-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>, <mweissenbach@ignaz.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172917500404.799221.12487566142641949140.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 14:23:25 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The early chips including RTL8852A, RTL8851B, RTL8852B and RTL8852BT have
> interoperability problems of 36-bit DMA with some PCI hosts. Rollback
> to 32-bit DMA by default, and only enable 36-bit DMA for tested platforms.
> 
> Since all Intel platforms we have can work correctly, add the vendor ID to
> white list. Otherwise, list vendor/device ID of bridge we have tested.
> 
> Fixes: 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> Reported-by: Marcel Weißenbach <mweissenbach@ignaz.org>
> Closes: https://lore.kernel.org/linux-wireless/20240918073237.Horde.VLueh0_KaiDw-9asEEcdM84@ignaz.org/T/#m07c5694df1acb173a42e1a0bab7ac22bd231a2b8
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Marcel Weißenbach <mweissenbach@ignaz.org>

Patch applied to wireless.git, thanks.

aa70ff0945fe wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240924021633.19861-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


