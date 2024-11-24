Return-Path: <linux-wireless+bounces-15625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383079D7131
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD4163906
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609901D90DD;
	Sun, 24 Nov 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCEORYhu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D711D90AE;
	Sun, 24 Nov 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455331; cv=none; b=VKLF2s6IqTojzy+p4bi68Zp8JldUV776F+/kXmaUMRe4EXJlibmdh5iMKYvX/A+bwvzbIXgL288HXzzB5G0ueQpVw78ep0qXt6mMuPgAItXEPAn9tGlLcVG9+Zzdhojv4w9NzfDjYrlJampnw6oF7oz76BOTcGc8HcpZpOXXOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455331; c=relaxed/simple;
	bh=N2DxJvzUNidz+elY9CCWZGSztHwVPDMe5MnXE8+gXbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPYhe9UgLxEf8XJtU8cfoVXqtO/ncrong22L5et6VFtGNg6j5wjR04sKKRFXQoHZBQi7mfbuXmK69LEGBnURjLADDzPq2um+LiiNOfwRvabwamEO8xEcz8YPNaYK9yfy8tBYlpVJKDJ+qxyddyvMDoyqBbCJzss1LdNU7TYomDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCEORYhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D92C4CED1;
	Sun, 24 Nov 2024 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455331;
	bh=N2DxJvzUNidz+elY9CCWZGSztHwVPDMe5MnXE8+gXbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCEORYhu3kyp/0qiQFL2DCR1/DfJXRK1EQeQx810dMaDJBhJDZcczbqDCdIqNAdw0
	 XLBzMks/tVfRxNSd0J6wpDqjxKhZVeGa1GPnnNQgYkWS6gKJjswGf7xJ9HVBC1HzHc
	 v9h9Sex31cSphx3x4GaZQNS3sugj9kKtS74qOKlNJH48VELBRpT6mFxiAZMAOljQ/J
	 5eY4N0UfvCRGkmvnpNOsy8zifEzWt62KCJiVgqx0Xvb/XuxozrqISv19Zvde5w3y/H
	 xnTS07D7GVbIlk68rEm4r0uxqXJEQJxwLrVDOkfLoy4TpPUuX6mys8rGp2jJ0ksI4H
	 XHSeC9ZJc2FRg==
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
Subject: [PATCH AUTOSEL 6.12 046/107] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:29:06 -0500
Message-ID: <20241124133301.3341829-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit da0474012402d4729b98799d71a54c35dc5c5de3 ]

This is in two devices made by Gigaset, SX762 and SX763.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Link: https://patch.msgid.link/20240930180716.139894-2-rosenp@gmail.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath5k/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath5k/pci.c b/drivers/net/wireless/ath/ath5k/pci.c
index b51fce5ae2602..b3137f60e8791 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -46,6 +46,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001b) }, /* 5413 Eagle */
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
+	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.43.0


