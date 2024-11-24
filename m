Return-Path: <linux-wireless+bounces-15641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6A9D73EA
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADDF166410
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0C235047;
	Sun, 24 Nov 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QITkazI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F3235041;
	Sun, 24 Nov 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456236; cv=none; b=m8AG2XNNS3C5kbvzMx9bcplVWBWEG425X9rUFVXJIa1MPrHo4VLg1tGAWtVQctsxmSKBliQ1uCqhyooC+4TMZNQ8OcX3Ka9uGGc4wGKNJhJ2bdYgcvkY/thfXTUyB/pJ7BlAdmqz9Scwg5goAp2osVuCYIVbdHiyM7FNY4QzNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456236; c=relaxed/simple;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOk6ZSWd5yRUq+OcZyUNKv8HxP5yFXZ50qM9nPxWaI7wYhyKSyjTmFKXZxmgmfOgIxCjghjXewUGFbSsPSQGscFw4gdLjjp6NUMA8JOOtGFIjlMn0NnHOflIUmnvd5kBiw8AxQAujRIAyEaAVHHe7UXKmmgiuNreBY4SZzgSz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QITkazI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0FEC4CECC;
	Sun, 24 Nov 2024 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456236;
	bh=DVHzVmHa7ytG/uGuXEIoiTxeNgWGGUK8uwlUxFjOBaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QITkazI+B9C5X9i1opEN2GXGUHgNAiHM6GzxyOBla3sPKXlqRPD/kGZq7HyuxWv/N
	 AeefTuxLO540LqiI+VupxIshOSjQAstYnXnK+wHgzHE/mkWRuMct+gH7zGfBELcJzR
	 Ez1lzIkyL0c9PyrkWQ+GW1+BJ5JyDUQMjMH7cCrxxE66/BF0mPMCdSkVqXUjeuxmbX
	 0Uj9SiX/j2cQpvobcRcYWK1mfwDRuSVhst8Yqd2POU03bYHWYAeNrS3a0gpndSoQZJ
	 bJ9NvrOo5S5AxkE43j3WM9Fbhr4K1CaJbOrTrtRVHapsAgQiak1tLlZkWBES5J3kwE
	 Xi31PVZL1qq7A==
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
Subject: [PATCH AUTOSEL 6.1 23/48] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:48:46 -0500
Message-ID: <20241124134950.3348099-23-sashal@kernel.org>
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


