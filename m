Return-Path: <linux-wireless+bounces-15637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130429D7378
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DA16638B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24E1DFE22;
	Sun, 24 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXk7o4D3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80061DF75B;
	Sun, 24 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456063; cv=none; b=nWM1hMFwePYzLNkLlyc9eXMNt2bljFLpS19TZE0jqYO1BsC25Dkgq3fXcfogOvRInejRUbGGWpwris0b/HUB2QA0pITEoBRtC0jCIc+j67jQ20iV1P703aVGhg+Qgks2v9NdJVZKQ9L2GOq8j763KM6/sFh8JyNidTOY2gUQ3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456063; c=relaxed/simple;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX/0ufXpU7JTpjbfF8HhK+13VW/hg35CZ1+fcI1x1eUAB9FU7b68r6rBEUsXUd2+gDipEX3swv1d6DvbblSy2QjooQCHOaCP/EKn8G+9G6Mcr832UtWrm9DG/5/vzoLS0gCkit6poRZyvGytuxC6/CORBAgvSBnh5tV0JCbvc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXk7o4D3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B438C4CED1;
	Sun, 24 Nov 2024 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456063;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXk7o4D33LGCNz1xwBfGKlng1F0Ryv7RJpfArfOghczcI1O9uvKUjlKfPl2i2A9Id
	 p0CRJWdLlg7m/qmp2xgpRZia/N9sd38atG6odlc6ngHatOt2JDcB5h8HiJYREm9TUf
	 FJ7sxUYABFiNkx6cFkKpiq1IjREy9rEjMaY7z5uD5+WtaVj152LA38UTmH00JBU33Q
	 mpNJLtvUM79j2CbUJBtFwgQytKUMVL2eDSxlTUYbPzOxnLD5aTko43Xu8Hb15kgbdm
	 JlG4aBG+GB8lJoZvcfCYGutrc/TRazCX9EPYEU8/ua0+MTWE9/4qOMC1uj5P7js7hz
	 TxEMWntlac5zg==
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
Subject: [PATCH AUTOSEL 6.6 27/61] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:45:02 -0500
Message-ID: <20241124134637.3346391-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 35a6a7b1047a3..f583e0f3932b8 100644
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


