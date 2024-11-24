Return-Path: <linux-wireless+bounces-15656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C289D7615
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 17:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67677C40495
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35724DF96;
	Sun, 24 Nov 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaCOQvDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551124DF89;
	Sun, 24 Nov 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456651; cv=none; b=a09As58NLxOatRLd8OJ68p7tUlg8ONEeF/MQ28KNQQZXzHmrOva0LvMmB/77F65gMAq6sl/ZjA+tbXIJ4YI7h1VrExpEnaPSqqTLLCa4hjZO8f7FhbNvrt4kFKtfnygrRHcqTnhJyMVIAil6lWSzGCr8ehze8CJ22w5H4HQ+YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456651; c=relaxed/simple;
	bh=tUVDIYvl8K0ChACqoOcnOI3OWNH0tMOXTB7i93ZNnAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5T0NX4MuH7SPvIu/fqOo3K7WBcdJnsir56zIx+vvB0ngUVDYdqWAfC7QwjQTGqJTdNTtg6dAoacXS1CsNCcw2JyTs3HRgY42SRIDzK/+8Zm8Mjx0iijhu9mMBC+jqhnd2BtMT96FWjJwTAgV2Enfj4nT7/0BNq9QZzpRS0t8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaCOQvDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB0AC4CECC;
	Sun, 24 Nov 2024 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456651;
	bh=tUVDIYvl8K0ChACqoOcnOI3OWNH0tMOXTB7i93ZNnAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaCOQvDISoA6z7CWo0mqQzlGjLEySWI0wQ2TRU65wuHGCa6lA0KigLqyuObrE5w7z
	 9QzX7npfrVP3qFyH/GGCQ/Ts10guBY4SeeEnm1ISX2TOAjWQoOFRVWOHk2VGBb9QlN
	 7ybaJhZeSQ1gK0ids2rlbbdpX8Sg0AR42OUCVOKAg9oTyFdNfQl9gWZKBKUVnYilo3
	 Xe3P4KDTNl+r19IKPOmOJ6ZBnBAfHC7MjQr2sJ/bKIv5ZxjlRzN90a35Z/p815jyo0
	 Zj2LlWAPVZS2vPIuJnSE1l1rx5E7BbbfWZbpGQIjmZQJUjOiPa4CNqRw4IZEftMBsl
	 Vb0A1X/RCX8sA==
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
Subject: [PATCH AUTOSEL 4.19 11/21] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:56:44 -0500
Message-ID: <20241124135709.3351371-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index c6156cc38940a..75526d8cc82c4 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -47,6 +47,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001b) }, /* 5413 Eagle */
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
+	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.43.0


