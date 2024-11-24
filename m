Return-Path: <linux-wireless+bounces-15632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E89D732C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E304B2666B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CD1D5144;
	Sun, 24 Nov 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ33UIQp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E811FF7AC;
	Sun, 24 Nov 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455796; cv=none; b=Q3kP5++XXlukLmZDDQDieYmX6YXey/ORDtsZBMjprWKKcSXkJ/0tEyHYVwfjgPjeqpzDHM/ZNjK6XxG0xQDRPOdyk6gGqSGZWA7n++3rJg08BgPZxtB7DHuUUhbLViiEKjROCX7gYGxnaCbQKYS1C0hLG/EdJDABxbY6Pdp4bOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455796; c=relaxed/simple;
	bh=cT67ZgsqpHsmUTPb8nDLtCDwUXSHiXP5xa0vkaVMJyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro95nGa6Xb/ePRH1dM4dv/Szn8n9HHocEaZnXbo7KUJi8b91DGlKcc6NC2xZtR5uHY8lwQnyYnvOMau6CYwl8Py8JHT0Ko2zQdWGJT95Dne8IYtb2rgeQ4F/GsY91AeECG1a938P6OdpVkrqvVHPmUYCpjtBTRPD3Gt6EzKaOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ33UIQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A599C4CED1;
	Sun, 24 Nov 2024 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455796;
	bh=cT67ZgsqpHsmUTPb8nDLtCDwUXSHiXP5xa0vkaVMJyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJ33UIQpsRzg0yWJhaV1B3SdL02rLYJVbQCYxIS8/KljC/zXFPN98IGZS7l9r2C6+
	 lqA/0aOi93geA3NWjZasRaFdGPmYYF+JotXIm/hf4OYNzO8DaMPGREpbTuWG0lrXPG
	 eEnROcNVeq+RVOc/iLD1ul74ePChjR1QUZgLkar0eEpSylsdx0U7wePcPV+dzRSTOR
	 mhX2eCUL6RepiH9I5E4DXTM3YwrIiGwy51qoQ+b6lotKGy4XccZ7lRUgdhQ4hfHmoZ
	 gTR+DkJmjfPMO3fMMC5d+zXNA1twZM4hEILWNCrTCqzrZgMKrHs82bNG2lE28dICDe
	 aVA4VPwAjAgTA==
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
Subject: [PATCH AUTOSEL 6.11 41/87] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:38:19 -0500
Message-ID: <20241124134102.3344326-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index b3137f60e8791..f5ca2fe0d0749 100644
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


