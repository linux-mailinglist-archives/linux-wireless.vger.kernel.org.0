Return-Path: <linux-wireless+bounces-84-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051A7F95CB
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 23:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A03B20A39
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04C14A9C;
	Sun, 26 Nov 2023 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFVwuBD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11CC12E58
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 22:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C8C433C8;
	Sun, 26 Nov 2023 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701037596;
	bh=WYWHeUOvyvzljTzqy0dHZNjOtP4h9rbjEwP36PpU3qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFVwuBD+/k7MMP+f0hM6mEmyn9+uXqakr0oLim/czrNpsPLNUal1bRwVX2Mn/KB/L
	 S/5DhaEjz3X7iZQ7T6AUaFFbjjkDQbHHnpqPp+bx7td/3ZiKhDxiMxJtvh1z7mG5FW
	 q9SnfiTB0L5mk1pZDvufkehsnuQdmGsO2KpaQKJRCCPj4tVOP4WYxrEpMFeTTOCSJ5
	 FtIQ1dwZHh/0uKJASBMEPW0GHK1whKjiHYSz3pt6GX11CUpD2I6xPECpu/p2Jr9bOJ
	 +vv9oIZYguLSUQvBQ9sj1ylaQvC1mDNk/CtbXxXH3xek7ZhiWlT72I/fmPxiL7nMsm
	 dastMCp0EamLQ==
Date: Sun, 26 Nov 2023 14:26:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: cristian_ci <cristian_ci@protonmail.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>, "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <20231126142634.3a100e2c@kernel.org>
In-Reply-To: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
References: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 13:03:45 +0000 cristian_ci wrote:
> I'm not the only one to have experienced this bug. I've been
> suggested to report that to kernel mailing list by linux support
> channels.
> 
> I've tested this bug against upstream 6.6.2 kernel tarball from the
> latest stable branch [1].
> 
> To solve this issue. I've also tried to patch mt7601u driver
> disabling mcu calibration. Which doesn't seem a wise idea because
> apparently it fixes probing but also hangs completely the machine
> after some seconds (so, it needs a hard/forced shutdown).

Does it work with the vendor driver? The upstream driver is just 
a rewrite of the vendor driver, I don't know much about the device
internals.

Maybe Lorenzo or Felix have some ideas.

