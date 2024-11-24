Return-Path: <linux-wireless+bounces-15631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9E9D76A6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0327B2357A
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C81FF608;
	Sun, 24 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XddKBOMd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BE1FF602;
	Sun, 24 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455795; cv=none; b=ofKnl/sNTXPZJ/ztKvPtPtk//JkESrsU5a0SqQ1d4ycI/rpWST8SuU+JaVomxF6lIvz0kgKsvnXsArHN63sov87ZtNuHD9xC+t8eTZ/TfPYRZOx0QSv+C4ZiUEAnKV6Wg62IpdjjTji1rgusySDAc4PvaVD3DPwd2RU31K/+kM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455795; c=relaxed/simple;
	bh=N2DxJvzUNidz+elY9CCWZGSztHwVPDMe5MnXE8+gXbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBc1P4GZsEeltEGobMP3lIHi+RcHfEwS+lklxYvQyacdg6xPDMUx4SyaEt4nvAs82aWIbAr9tQWrKOxXq876Y8fDdiH5f0Aw0u6J8TYJbMeQ/5gHlWEmkm7MRhrI4+4DuzEoXcrBX8dPiBcIhQwlbwaNiRPhMJfKk3M4wh/0Egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XddKBOMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D366FC4CED3;
	Sun, 24 Nov 2024 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455795;
	bh=N2DxJvzUNidz+elY9CCWZGSztHwVPDMe5MnXE8+gXbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XddKBOMdxNfxAx124lGyly7M/ZmUTxC1SJy0wFjTCMZA2sBrAEZOu3hZ4voeGYek0
	 9CtKjcpIQuZFR4x6NMsuQTruMRRK5BDr3vClBaAG1YgIvaQAF09SXoSQdaFmVNnLa/
	 gDeDVuf2FNg7Mk7BS85Nss6+LiEOeoGbN5wpCrQ2+MKgsACb4OyRHAr17t4kc30mua
	 5e+EoYc+cobN+a828XwmVjsoy3fXBKKi+N8S51y5JOc9kHd4g378pRyYh2zARKvPCi
	 QNmBv0X34AJ8+pIQ8suagWsj5LNiTYt81noZL/9N35K2bUSTfqdZpVOR6tsUlmjnxH
	 1bjMrcrGIwJQQ==
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
Subject: [PATCH AUTOSEL 6.11 40/87] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:38:18 -0500
Message-ID: <20241124134102.3344326-40-sashal@kernel.org>
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


