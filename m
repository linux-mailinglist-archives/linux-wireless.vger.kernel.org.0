Return-Path: <linux-wireless+bounces-2265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C59832E30
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3D41F22C6F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681655C05;
	Fri, 19 Jan 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3llRGYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4C55E67;
	Fri, 19 Jan 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685433; cv=none; b=ThVWP92/AIgSlag66lzJcSaZQnSQvBTcJvsRf2TbyTI4tNFiOQcX9E5e3Y8vDmcGX3ypXoHP+Zj3aurqSLXMpXXvMofGU3MKJ/3NbUJgOHCsAjlpueXj1wHEFOKnDnqndiUYn4/Be93JhpE2WhFLA+jmFpQqwVjK9vSXRHMmJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685433; c=relaxed/simple;
	bh=VgqbnLFz5iPiKxaAMDABGlr1WINNQw1Q6ApgWHjIOnw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BFL+0kF9inT7UdgEOOWQf4JkUnlxSRKj1kUH5LOsQ7HYhHg93x6mjxu+7n76i19RIN5ITd874vxRGCNDi9BG/xVpY2YHmt2jRYGAiDhLyOQ0slyxye38eSv5Q9vkXs0rIP+xIsh4efUt5NhqvMigEhJJyMY73UQMj3KIeF36olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3llRGYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CE6C433F1;
	Fri, 19 Jan 2024 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705685433;
	bh=VgqbnLFz5iPiKxaAMDABGlr1WINNQw1Q6ApgWHjIOnw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=i3llRGYJe0u6tJJ+J7c1Bn0zqMZ6hlqSEMGwd6Lyvveb4nXfXEwLMY9+g051NSkBc
	 DUWI5Kcb0d54FWLGfMO9pbwKxV30PLjPjvx2bGUcwANpBIlrUuof3J/kFtdigIVGxt
	 iDNZkw4xiVPZ/fX2AgljZ24z/JcrEBqQdTUGHPsMsmra1frZYYJwjcqEsL0NCsKeHW
	 pmmlpr+Y6Uxh9apbbZUnsQSbsmhsoVhwV/viZHN4yXie+U8eMJCnG1qoYtCyA5BWd1
	 L/veHJg2UwBoTX3A7SNI9CjOb2nPTFQ6wg03ihUs5w+57R1TWXlie0AZGsDDEpLr9L
	 mBkbdC5fmGa/Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 1/3] wifi: brcmfmac: Demote vendor-specific
 attach/detach
 messages to info
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240106103835.269149-2-arend.vanspriel@broadcom.com>
References: <20240106103835.269149-2-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Hector Martin <marcan@marcan.st>,
 stable@vger.kernel.org, Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568543007.3153793.3392867392129428991.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:30:32 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> From: Hector Martin <marcan@marcan.st>
> 
> People are getting spooked by brcmfmac errors on their boot console.
> There's no reason for these messages to be errors.
> 
> Cc: stable@vger.kernel.org # 6.2.x
> Fixes: d6a5c562214f ("wifi: brcmfmac: add support for vendor-specific firmware api")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> [arend.vanspriel@broadcom.com: remove attach/detach vendor callbacks]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

3 patches applied to wireless-next.git, thanks.

85da8f71aaa7 wifi: brcmfmac: Demote vendor-specific attach/detach messages to info
b822015a1f57 wifi: brcmfmac: avoid invalid list operation when vendor attach fails
edec42821911 wifi: brcmfmac: allow per-vendor event handling

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240106103835.269149-2-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


