Return-Path: <linux-wireless+bounces-2180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B28319FE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EE1B25424
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818724B5D;
	Thu, 18 Jan 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHYZ9gkK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCE241FC
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583217; cv=none; b=mrrycIvLPnhzORznTnJl5K3yQFy71IjIGX9Dr2cGsoLgYicylSRuCphPPHzWQiERJ3yIo8v3jjHTVDn4ZQUdZweLxe9TnBBcVYXHchz8WDdY+BNKRDShDI8ZysBKhWAxQtx12395PpXWYEcj3Gz4LEXJ7sT1Ai4ReDD/CJr2/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583217; c=relaxed/simple;
	bh=+blTKqSBWpW6r7TfXfyfKT3NZkOLFReG37eRdYqyEEY=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=mGIeELk1IYyDMk4gYa4mtM5RP2EIzjOAYn+FnNSH5vtmx0yss1lB1cggypfldkl9u++VMZ5ZI2WdaaVPfXsmsDxJ2AE4HjnQ14iaqcNy8oZwTZYYSzurEJ/KlIXk6BQWguQvdpfwTcpzZKMgEej0dPRBJX/9osn492mnbR6fbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHYZ9gkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F31C433C7;
	Thu, 18 Jan 2024 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583217;
	bh=+blTKqSBWpW6r7TfXfyfKT3NZkOLFReG37eRdYqyEEY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PHYZ9gkKA4rS8bF3MGyeLxdyXC56bcmR/0vHfBT2kFU/bpbj3vEags0ILi6/Vr16u
	 dfOOeTuzPkElUdvi2ev0xpDJf/WaLWL5Smzr1MLE1R1C/zqZPWXPMW3ac9vRUPaT9R
	 3xo5YtqaS7APiuwDrOcKYSUBBT46SncRu/Kc3sHwhrhY1S49tvfDf5pkUK+PHgGqEW
	 8M7lJERpzXmkVAkldArtlWH6WyBgan9B1gh6EYik0q6U5HkUGz9vfpHjLu4eYHAN//
	 zbkrmgK1JcInsBmi9vsVHy+pGfYXRA200nMpXGCykdlrlvNCkvDVoZ1xikFFtRwCcw
	 ZoDP6179LfYPA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-next,v2,2/3] wifi: mwifiex: debugfs: Drop unnecessary
 error check for debugfs_create_dir()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230903030216.1509013-3-ruanjinjie@huawei.com>
References: <20230903030216.1509013-3-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <gregory.greenman@intel.com>, <briannorris@chromium.org>, <nbd@nbd.name>,
 <lorenzo@kernel.org>, <ryder.lee@mediatek.com>, <shayne.chen@mediatek.com>,
 <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <avraham.stern@intel.com>,
 <johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>, <trix@redhat.com>,
 <dmantipov@yandex.ru>, <christophe.jaillet@wanadoo.fr>,
 <yangyang@marvell.com>, <linville@tuxdriver.com>, <rramesh@marvell.com>,
 <akarwar@marvell.com>, <nishants@marvell.com>,
 <linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>,
 Frank Huang <frankh@marvell.com>, Kiran Divekar <dkiran@marvell.com>,
 <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558320955.2924528.12751516138860022016.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:06:51 +0000 (UTC)

Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> debugfs_create_dir() returns ERR_PTR and never return NULL.
> 
> As Russell suggested, this patch removes the error checking for
> debugfs_create_dir(). This is because the DebugFS kernel API is developed
> in a way that the caller can safely ignore the errors that occur during
> the creation of DebugFS nodes. The debugfs APIs have a IS_ERR() judge in
> start_creating() which can handle it gracefully. So these checks are
> unnecessary.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>

Patch applied to wireless-next.git, thanks.

50180c7f8e3d wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230903030216.1509013-3-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


