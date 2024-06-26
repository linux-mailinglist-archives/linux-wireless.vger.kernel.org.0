Return-Path: <linux-wireless+bounces-9612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B091861C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2111C221BB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F318A935;
	Wed, 26 Jun 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzJPmUq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98443A92F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416561; cv=none; b=Yqf0T36/GpMP4N4oUPkiCQ55Fey/n0kp4Ul8J8D08OT27hMw+jHNq1Q8Jb/9O15FOZzIYz07rjenwlg4BLhL2Z60AZaA5pWZCsuFRypHSZrLo/D2hNVPv/7ZKhewJ5O5DKYtJ1aDYUDoKBTw6gwJiUl3//VaOTENhk8Wcd3GFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416561; c=relaxed/simple;
	bh=dunIfLY+4WRNsvU6UNanCIkOKgAbPpLCv27myTPXqqw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Abd9AS9jlntw5zl+dvGnCnfgEhCbxCpZxRypXQO56EBZGqLl19ll3HOAugrdDz3ZAFCRa6dP7LOrA+doEAbkpXf1ND6HuorLu3YpHK+BlIu3G1WaHbkUySJoC8j2E8TlgjKrHsk1Ap09mUuQYlfM1lJ1RhU508MrT0K3+xwtWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzJPmUq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270F5C116B1;
	Wed, 26 Jun 2024 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416561;
	bh=dunIfLY+4WRNsvU6UNanCIkOKgAbPpLCv27myTPXqqw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HzJPmUq5yly+7rVr5TFSBN0ug/fF72MijF8hBtZ4AnyFQcy0NMSqeGmxRUtd8QgQ2
	 rjz0Uz2suCHIQvG3nLBIE2EuTIUy2xna3G5Z5jkJIRApsdmHslhU8oHurYB5eoFerI
	 Tb5dTapBaVJ2XQB7ADTOE6vWkbqTSfk5/XKvbAT5aONnvXbIVmivkG+l0O5zof3UGz
	 ZXZE5G3ucQGlVWtgvo4xTY7B9P7ocyz8jyExhOMuaE7D+574X9P76gCfxQy6R9wkXS
	 4D+qQtfsrTqYLYuIVpZfAB6xMD7tvfolk+fbMPORFz1GUNb6O0WVTQ75KSkykun4+k
	 oGWH7GKCzBI2A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix peer metadata parsing
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240624145418.2043461-1-quic_periyasa@quicinc.com>
References: <20240624145418.2043461-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171941655813.1568703.13556661762295389272.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 15:42:39 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the Rx data path only supports parsing peer metadata of version
> zero. However, the QCN9274 platform configures the peer metadata version
> as V1B. When V1B peer metadata is parsed using the version zero logic,
> invalid data is populated, causing valid packets to be dropped. To address
> this issue, refactor the peer metadata version and add the version based
> parsing to populate the data from peer metadata correctly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 287033810990 ("wifi: ath12k: add support for peer meta data version")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1eeafd64c7b4 wifi: ath12k: fix peer metadata parsing

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240624145418.2043461-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


