Return-Path: <linux-wireless+bounces-12402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6496A682
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F609B21A5C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23E18BC22;
	Tue,  3 Sep 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neI9Bcwt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC23188935
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388229; cv=none; b=mvanPfCdI/Gmm0VFJJGVEG+ZU3hNCA4pDoZKtY4SBnBZxq5rSU19+eoxe9zLjTbVdnhY9ohvWiqODI4haMKXlC32UVVnREYsYRq2e/gES+5vLryPqbQb60vUou/Io+uo/U5JvklFLoTfzpe5Ji+vcoV7xcXwTyjmwzZhLbiSBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388229; c=relaxed/simple;
	bh=75Vy5rNwDeuOmcTDiD2C9ihSyhxBpv8ckqq12FHc59Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=g/8p6p0XATiJqe67ASsRZvrB2hJYes6tRSJ69MJNM9Xag25NtyuZUwtgH3X2KrSeKZhENAuo6f1mqQkefyanBcimFpBwxX2QcLfDUPq7vlb26+ZfoXXwmPeCXCnJ+y+xM3YkSz6ZJyAGuHtg5+pDPdYHOXCZv96+cAvovOpKwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neI9Bcwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E39C4CEC4;
	Tue,  3 Sep 2024 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388228;
	bh=75Vy5rNwDeuOmcTDiD2C9ihSyhxBpv8ckqq12FHc59Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=neI9BcwtPBvMRvkVmFDvS5TF/d2woc5bzegmsTzZVAf+vtBuW1KTu/tOQLFleA6hs
	 ql/Fgi/n6/yR0tGkiIISi3AqyLnkEjQNYbNNcrZhmwoR3y5lfQf1GuZOZclxqli/4G
	 pfNY3fuDPJ7Cw/YQLNhrAUSi2MyjidCmO+qrV/fFeAlyc+78S9mgOcbQIkklWNOXUH
	 NskBNLmPJ04Zg439iWW8RmPBtpAxfSvsZ7WuaAdId23zYap6KFeedIYakGDSvxbtO/
	 TwOTp8F9inEDXS2aRpMWNGJydOUtEtVMDJqLuBIx2h0Kiyu8XrYa3XEFCSUM7Vu9Xt
	 OOjGthPamHrNw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware
 during
 suspend/resume
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240821183639.163187-1-marex@denx.de>
References: <20240821183639.163187-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538822543.1029035.11272187710732129942.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:30:26 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> In case the hardware is not initialized, do not operate it during
> suspend/resume cycle, the hardware is already off so there is no
> reason to access it.
> 
> In fact, wilc_sdio_enable_interrupt() in the resume callback does
> interfere with the same call when initializing the hardware after
> resume and makes such initialization after resume fail. Fix this
> by not operating uninitialized hardware during suspend/resume.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

b0dc7018477e wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240821183639.163187-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


