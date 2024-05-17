Return-Path: <linux-wireless+bounces-7771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 812958C823D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33488282D15
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6135F22324;
	Fri, 17 May 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXcinLi/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838222084;
	Fri, 17 May 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932932; cv=none; b=uvzuYys24FnvxiMRJeCMpydMdz6urBT9aOl+f3RdJ7ZgnMLQjSVUmllFYMka3sodaZdbGq3ILT/BIVN9smQ4PK3KJrr1/WYZYbm3mStGZ0G1huo89mJ8e6y+N14zLNF8fSXKiWaPlQ+dEjzEElXM69IC1vMYNaOQN/g8mj9gj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932932; c=relaxed/simple;
	bh=LIfxC3togYpPiQ3NtjjAwb/Tptw4luLeCd3cYBag4Pg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=X2460D0fcbECiY1KTkxVhiFtJAIcmIjyCNfFUOrVsVv/3DT59dExkJGz66+U1X9hQTftl9bK2K1mYgaUDiD1yeTybR7AoiRedglzh2R68akSQ//Up4dybpP/+6EGa0EuCyj6WfRrsfCfo9ZbbvGSKhEi1Bg3Ye4hAYm8K372fmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXcinLi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AEC2BD10;
	Fri, 17 May 2024 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715932931;
	bh=LIfxC3togYpPiQ3NtjjAwb/Tptw4luLeCd3cYBag4Pg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BXcinLi/0Oce3XLR3UFJIvzpohnoGM/S55qXAQ5EuCDwGJw9OZyvZryxXn/K/X1lA
	 YtgqZOZak6DYmqL4LOI4K0xdKK8mPmZ3GMM67RVLrENmtTsVBKoFSDWVNyUYrP/f7t
	 QlJg9jQ/ZB5+cubqybmt07OLHQlZ1FYTERD6pZO1qOi2k+6z4r7wtLT1h9riZn/LTS
	 eMlt9tZxKT7H5MDr4ts2YdPDgbwFV56+jf2WcBT2maPhM8XmgK7Tj1HjVbxi8JJlS+
	 UoKYSLseqWviUsj1b8yTeA3mCZh/uBUJF9cQ7apNCD88G1EV6RiDeGytQaLXFVoQbj
	 MA72/0H47VWJw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/6] wifi: wilc1000: set net device registration as
 last
 step during interface creation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240514-mac_addr_at_probe-v2-1-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-1-afef09f1cd10@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Heiko Thiery <Heiko.Thiery@kontron.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171593292799.3274748.9026063903119888618.kvalo@kernel.org>
Date: Fri, 17 May 2024 08:02:09 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> net device registration is currently done in wilc_netdev_ifc_init but
> other initialization operations are still done after this registration.
> Since net device is assumed to be usable right after registration, it
> should be the very last step of initialization.
> 
> Move netdev registration at the very end of wilc_netdev_ifc_init to let
> this function completely initialize netdevice before registering it.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

6 patches applied to wireless-next.git, thanks.

6fe46d5c0a84 wifi: wilc1000: set net device registration as last step during interface creation
ec99908906e9 wifi: wilc1000: register net device only after bus being fully initialized
5f1191ed386c wifi: wilc1000: set wilc_set_mac_address parameter as const
59cf9277c1fe wifi: wilc1000: add function to read mac address from eFuse
a5d6b1d453a1 wifi: wilc1000: make sdio deinit function really deinit the sdio card
83d9b54ee5d4 wifi: wilc1000: read MAC address from fuse at probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240514-mac_addr_at_probe-v2-1-afef09f1cd10@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


