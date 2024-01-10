Return-Path: <linux-wireless+bounces-1666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C61829CCA
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B16286971
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B6495CD;
	Wed, 10 Jan 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECPMx0/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017943DBB3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37B8C433F1;
	Wed, 10 Jan 2024 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898159;
	bh=gAxagzFtZBr3NNmkExdcRuabcdCgu9FppekKDExz3is=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ECPMx0/xR2ghk41EnGtWmawuxNlOcugBUk4QXVOu3NIclRTZjYRj80+pGHzq3aRw2
	 5WarRQL8ODwABB0TFDwLHMpM/ueA6KMWnpGQGESPbITko8IiENvKTduSXfIpJhB4T9
	 gEVQL7oigjygkSItH/BHlZvq+yv8cnI8aUFM0F3RZIpilLn2zK/DtBt66A+cL3htFu
	 Xm1Tus0Q0YBj0rgh632yOwcZMQK/g3FaMB31zs3fLwt0TNFncpCAPtZkNKagfNAl3C
	 FV0hVceEeC7uJf7Whn9Tu2Ve62qFB+CG94Zg+cagH68qwzkcXDZeyreb7FJz/dJmF/
	 xW/wVdMsvzfPg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: pci: use DBI function for
 8852AE/8852BE/8851BE
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240103012346.6822-1-pkshih@realtek.com>
References: <20240103012346.6822-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489815643.471554.12112699687800189077.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:49:18 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Sometimes driver can't use kernel API pci_read/write_config_byte
> to access the PCI config space of above address 0x100 due to
> the negotiated PCI setting. 8852AE/8852BE/8851BE provide another
> way called DBI function, which belongs to WiFi mac and could
> access all PCI config space for this case.
> 
> Link: https://lore.kernel.org/linux-wireless/79fe81b7db7148b9a7da2353c16d70fb@realtek.com/T/#t
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9496d62f3877 wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240103012346.6822-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


