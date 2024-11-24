Return-Path: <linux-wireless+bounces-15645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E69D7447
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E51672AE
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBAC23D64D;
	Sun, 24 Nov 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cULcok8A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8223D64A;
	Sun, 24 Nov 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456371; cv=none; b=Ms9j55KYV++u5nQ2xLBoNy5SE9vAWQGjlTKNtud0Ytqs0GVAMOaTenmUJ4xMYse/dx94zj3XBy0zTpuG4vdfldl7Y/EirDgNtsIna1ppGjFVc9Jrk4GCCOKZ/LwhZfHgp8AkCa18l6urfa/HK4E5+I4HNCzV+rcyVcoF8PcSwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456371; c=relaxed/simple;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDhlOpHg0EArPZE0IslweOLXFxZ9siMmskeufylIks99SePMMalAQnGJ7chBkWQTS75a5NSfPvMuThyUUCpnht3d45qd4yqHppocPODqeLusEVLLNmery83lI43Py+g/oIdbl7pj4YEadMZDCzBSmIQFR/wHoZLtNyLIAyuNVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cULcok8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D09C4CED1;
	Sun, 24 Nov 2024 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456371;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cULcok8A/1df+iIdKe1BGGkuPwdYbFlBZIiB7oEt7ckYVzbAbyyCmhMkapGOSt9Ss
	 6qzI/ZopnUscTZZe/kPReqOu9me5Kr7eM+2CA0yNszqetrBFdQeIRygUV0oa78xGpf
	 50RECDrblYB67QU5yxHvlVJijFbFx47qjOOsfa/XKXwZxUN5MeZjb3no3D3hqEMNKG
	 IDRkt+0FMPmklPU4m7vqASiuAIJQj4AAF2uPsgDxZyJNWqcK5tw6J4XwuNkXuiHK7e
	 bVeTQp8sPrj+p5gj5Zuing9fGFgGNwwZNXa7PPdcQ8F3Ims4ouxrdbDopNaEq5Qfbp
	 d1XdPd5qfhQlg==
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
Subject: [PATCH AUTOSEL 5.15 17/36] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:51:31 -0500
Message-ID: <20241124135219.3349183-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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


