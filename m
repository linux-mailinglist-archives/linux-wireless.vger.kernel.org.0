Return-Path: <linux-wireless+bounces-10891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4F946DAA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 10:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA8C1F212BE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B6210F8;
	Sun,  4 Aug 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIP6LrZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C520DC3;
	Sun,  4 Aug 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761793; cv=none; b=cuEQz01Zy0y3AjIZJ1Zu02l1UqjxpbNpEgVBK8mvhv/97l1MIoPISfR8Z4VGJZAEN785nE7mVgx5UR22OsHOLRfTzJcGddFYsXcA1xHX/eaZDs+62rypgV9Pz3UAtRJa18IWWGQTS2g8M5ykSJMCHSAEUgOx4BjVPrKA8BZRMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761793; c=relaxed/simple;
	bh=TcuxIem65Phkch62XaCZHp22eV6yUVsyvPcVzFWSIDE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=pSWd87rn2bmpYqc5BYV7UOPnAo9U1fvsh04lkkZ1LYEtUUp6yJc5RjphQ5gOkfJqza/j2fhfctAeQGt+KpZXwW9x3grN/AgTqwyN5AzfIoBXRto5G6xZQloNuBWbsYTdAOBjrgH/0dFf86a+y1CtLAQeN0j/s56rZHK33jaiPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIP6LrZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E928C4AF0B;
	Sun,  4 Aug 2024 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722761793;
	bh=TcuxIem65Phkch62XaCZHp22eV6yUVsyvPcVzFWSIDE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fIP6LrZKGx1Za4Autle5A6xvf1CdPtEmIVlYzFsb1vwbJq7+qpV4Xio7c/Y1jQEQD
	 OvF6vn3qXirHhtvvPatbqfETwDPLehLobAx/7G0NQD821gpiWwu5zpkVHjlmQXsqau
	 l5G6lT5iLQKW95lFM0BbsZhuODb1R91jBXclgd28hNh94ZvY6r4QhVL874LfAkWjA/
	 KKAVYlWPhDDSIqsC3FVPmM78IeDBn4cVZ24vxE08BoIDA/LfzIweP4eBiGH9eOLJ2w
	 mMgLncFEcn0VnCloUpm1Ria3cCwdP/XzFeNrpfNjgssUw0P6keZBAom4cYsBcY9VQ0
	 5PtQFpF5pXXZQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 1/2] wifi: mwifiex: add host mlme for client mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240704033001.603419-2-yu-hao.lin@nxp.com>
References: <20240704033001.603419-2-yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 briannorris@chromium.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276178982.2804131.7220003471537783365.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 08:56:31 +0000 (UTC)

David Lin <yu-hao.lin@nxp.com> wrote:

> Add host based MLME to enable WPA3 functionalities in client mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

2 patches applied to wireless-next.git, thanks.

36995892c271 wifi: mwifiex: add host mlme for client mode
9588469d0697 wifi: mwifiex: add host mlme for AP mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240704033001.603419-2-yu-hao.lin@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


