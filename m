Return-Path: <linux-wireless+bounces-15626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4539D7134
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028AC28200B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072811DCB2D;
	Sun, 24 Nov 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC2pIhT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458B1DC1BD;
	Sun, 24 Nov 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455332; cv=none; b=fMGpBap7+LtcrLZpntZZKOwRZ+wGHIjQQCCpYBUZ+bIMMkx11oz9O5Wo2LuWCwnGke6Tr9KmcjYs7AHM6WVqB5cbvya9Hd5dOrw/cx0ytDW/2HAFTjC8c2zp0SOwXM2n8zpzlHjVyayC3pZ/S7rMQ2B6m1EJuHxhkfdL+KX6Gl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455332; c=relaxed/simple;
	bh=cT67ZgsqpHsmUTPb8nDLtCDwUXSHiXP5xa0vkaVMJyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdO3YtHAN5kXeRVhzh7BZwuCizJAvxqNv2IrMw1d66bhyzgDSFMDSymixnJsqdng34IJ4VImabPU09BFAiTfC8svcfmEhZ8vGQfMQMmAShuNsMNo9I8y45bBhWa+EPtznJo3aVxl/xqZdNHjYoQMAQ42BA9q7NPaumD4V/d6cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC2pIhT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C7C4CECC;
	Sun, 24 Nov 2024 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455332;
	bh=cT67ZgsqpHsmUTPb8nDLtCDwUXSHiXP5xa0vkaVMJyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZC2pIhT2J+RA/q5my8NwqPfZYvj5YyjE5A9a+q7cyLmNw0agZpxr30TCG5Sv5mouE
	 cFUreDjR04XLDuGyVDCvv3G/T4vxGs7mDqdcNXny6ku4Hla+ZsGZQnDnJrLfn7E39J
	 eOYguEej2quD4VTqBbApkNX2+dnZ7tVhGv7j17iLOUU0cLxEfz3ezYdBNyt9MwpwRe
	 hIg2TTR91+LwLeUzpjsM5KtpKiuzGkho94dxz9RvCltuxB3wr4aX2BSXQE1DezDVpS
	 rCuENzXhnGRHqOjqTkalBou2HSz7OlmGfccEiBNijS835r8nXKqNDL0oPF01N30q0O
	 J99LPsXUFt5Nw==
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
Subject: [PATCH AUTOSEL 6.12 047/107] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:29:07 -0500
Message-ID: <20241124133301.3341829-47-sashal@kernel.org>
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


