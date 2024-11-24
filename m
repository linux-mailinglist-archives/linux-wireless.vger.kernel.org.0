Return-Path: <linux-wireless+bounces-15649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009269D776C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F075B80F48
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FB1FC40F;
	Sun, 24 Nov 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oubKIzGn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A41FC40A;
	Sun, 24 Nov 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456482; cv=none; b=hMXVH2Ni0bPzchD6bF0EscHZWZV9nSgWpMNlWU9Ba68lqBkgBFEwfIAhxJeCbvFiJRMh+Bw/ISgpoX96GGEc3stLUL+F6jdojhUgcmanHTyhpW37mTlpUi7gR+0FftRYG03GNDQT5hF5pVgTlcFC+X5xiIwhwW8Negnx4xrJrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456482; c=relaxed/simple;
	bh=J0/OzEqG6xxt3rooUVqs/pN+HYpXO4JgYh9UmC4K4II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiFTN+bY4d0YDMuyfb5nAy2cVEbtPS6E5/QnzlbhWqAZlhhkxjnayXWUO1CwfpziYXUefcFSqjOwOaz8GcpQ3lWIgO0+Ada/YZIOtlbtXbDdqaD5DCXufDkX9dJlf/6YnWxVUqZnXtxt+vuBMR7SQ2QpyIsOGAtPbPT98rJ7YX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oubKIzGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB31AC4CECC;
	Sun, 24 Nov 2024 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456482;
	bh=J0/OzEqG6xxt3rooUVqs/pN+HYpXO4JgYh9UmC4K4II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oubKIzGnXst8aYszPsx8CHx2b0bN3rAixIcKIwgtyAd2BTFYc+0vTWbAdz/jFK6Xd
	 X0osc7naA7Iuz9E5Ql9gIJhu0xGZIOMEJQWxw9Y8uSkFkpAGpEjT9+lx+iHaHaOloc
	 3bREInHvYMNOCaFj6CpNhFGbiG1HXxs+49WwsCsCIJqWYMrcHvDRv8HQVqE4nuXIqJ
	 pNd5q0VySdYaumZfzECa6tS4iTqtU8J+Y7oCYMkH5L1iiCSimfOHHvTlwm4+fdhYiS
	 +1gJaQg19v81CvIfTqhMepZ7yK15vKqoXad6wcLoFDQFRyAl0veRTnU4gUmM0L+vUm
	 GqJHopbctSHOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	mickflemm@gmail.com,
	mcgrof@kernel.org,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/33] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:53:29 -0500
Message-ID: <20241124135410.3349976-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit f3ced9bb90b0a287a1fa6184d16b0f104a78fa90 ]

Arcadyan made routers with this PCI ID containing an AR2417.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Link: https://patch.msgid.link/20240930180716.139894-3-rosenp@gmail.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath5k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index 0892970a99637..e8f557423ac2d 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -47,6 +47,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
 	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
+	{ PCI_VDEVICE(ATHEROS, 0xff1a) }, /* Arcadyan ARV45XX AR2417 */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.43.0


