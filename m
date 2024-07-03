Return-Path: <linux-wireless+bounces-9929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DB926230
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C121F21A24
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A317084B;
	Wed,  3 Jul 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4JW+mEh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA33CF73;
	Wed,  3 Jul 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014605; cv=none; b=ISUbD1Ies+S7vY1EZQiGa2KMRloCYccmDbNgbwlP0+39QBDUIIAgy52dXCmvibKf74mdl3kDzFcmssa1pn/n+ewTzl8/rfDO9/U9ufsB2zJQgf7tBOBtBW5zqxRKIHC3F8e/meJW4k8RJSSViLMWypDqVDI/8jJsb+lWDfj5p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014605; c=relaxed/simple;
	bh=TYYrulL72xGPd06hOb7IJr0N/E4cRIN0SurAKhyIFws=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=KD6B9UldyKrOMpih+wRZcV3DnhVLKkeH47V73jyftbXrKFQQ6l9UOliM+Vduk22DjlyPkeUvf8eo/B05egKL0TRhzADIi9tJKKT5HBVCVkidMs4v4JG75KNM+WWjrYoYrFvKlIcgor2F4FO8GWhbIHXNQlxFKCbE16tC2axuRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4JW+mEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A84C3277B;
	Wed,  3 Jul 2024 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014604;
	bh=TYYrulL72xGPd06hOb7IJr0N/E4cRIN0SurAKhyIFws=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f4JW+mEh1o4xwRKF3EububZchS8cA7pxn/e6cLmXdaU9rYrDZ5pKULsdL+JoYsjJY
	 4IQPAo+mJTpdbbFOaxlaoA9+MtP/qKThar2Igqy/936seBj/1rsre9Cl2MB5Y5a3uO
	 aaSKCdH2HIEy5p1eHD2cF+Z+9ZL4aeOzyX0msMcE80nfYeCe94Uz61WQgk3AsG7AJW
	 5yrBbLKSTe+VnxU2E9J4xy8WvSpcqs/4eUdup7ZI9wZc1FT3WJN/jWFJzgS0IohNgM
	 zd/guBvUKpPnxXVARKa9SpStsABPK8N3OvQutf+Bq6evnmxfSCRWa+xIEMPDjqB/99
	 aaZCQfTXx4O7w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wireless] wifi: wilc1000: fix ies_len type in connect path
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com>
References: <20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, Jozef Hopko <jozef.hopko@altana.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172001460150.3313435.9699200902279507680.kvalo@kernel.org>
Date: Wed,  3 Jul 2024 13:50:03 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Jozef Hopko <jozef.hopko@altana.com>
> 
> Commit 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
> made sure that the IEs data was manipulated under the relevant RCU section.
> Unfortunately, while doing so, the commit brought a faulty implicit cast
> from int to u8 on the ies_len variable, making the parsing fail to be
> performed correctly if the IEs block is larger than 255 bytes. This failure
> can be observed with Access Points appending a lot of IEs TLVs in their
> beacon frames (reproduced with a Pixel phone acting as an Access Point,
> which brough 273 bytes of IE data in my testing environment).
> 
> Fix IEs parsing by removing this undesired implicit cast.
> 
> Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
> Signed-off-by: Jozef Hopko <jozef.hopko@altana.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless.git, thanks.

39ab8fff6230 wifi: wilc1000: fix ies_len type in connect path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


