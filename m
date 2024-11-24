Return-Path: <linux-wireless+bounces-15640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CCF9D74E7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31C0B23737
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9A1F832B;
	Sun, 24 Nov 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTVA9r5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F041F8324;
	Sun, 24 Nov 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456234; cv=none; b=AEwlAk9V1nPljvf9QbZRdcxSzaEzFfNJSbnaFGA/YCA80R71Q4IusXP0NC1JN2fkzw6DAiKuDL5t7xP7BEaAVWF5wB28KAtBEcyHIje3lhbiKdWzILN/2knHValCeW1Bn/9EeZ/TYlP6hHsoyBPsXBe+Tz9vrVh6zuzpf+HNCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456234; c=relaxed/simple;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9G8egwEsqcvtxzjq0mUUVQDMQikevuEHO8zk1241WdXXGebH2lhJ3WDBOHMdo/YSQF31ac25An5WoYvLpo7d6QCYf/Nx9pmQ1yShHyCKZUN/63ZMoWEzMCMcTWfOKxo79BI9coKwhlrsCRxo+LAkYG5Gxndz8LLXwxV1kfL9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTVA9r5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F560C4CECC;
	Sun, 24 Nov 2024 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456234;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTVA9r5DdYUZX1/BWaBTERowVvkiCEep+HNkxy/tYg4gUD+AJjxzDBVMVB3pbPDZ4
	 iwloJrkEus2uToSiaSdkRESVe5tCJHuqzcPvqc/d9cNVRAR2/AbnioW16ziX7XhN5i
	 YEH/ssP6ySybj7OjDzwW8atImTG4rCZg6qdcpcsOhy9NMK3vHjVc9l45AoIcoMqe9x
	 D64s+9FlJUE/hCZLsQ7rIQ90WrJbQ/mL69wN1diNFcysIhN3T1EvURzqYvKV0n1zt8
	 5W2wiAHbrY1pbYZAahUZrJEj4hhUKEg6HXhv7mqJRS/LC2Co2RbcScAzdxDp5slGoY
	 EsAZPnxB329/g==
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
Subject: [PATCH AUTOSEL 6.1 22/48] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:48:45 -0500
Message-ID: <20241124134950.3348099-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 86b8cb975b1ac..35a6a7b1047a3 100644
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


