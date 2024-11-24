Return-Path: <linux-wireless+bounces-15636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69549D7376
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8371B166543
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680251F603E;
	Sun, 24 Nov 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ7HJr/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401811F6039;
	Sun, 24 Nov 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456062; cv=none; b=mlnJuxhzg7cospUqrOFcjN4PZtCPObuflG0rLYYbFVO7nIIyVdgLEifcwEmXc+z5U2fH6r+fovtJBvze+Ks1YXt+/9a1Hd29HYme1s7nah7rf9CeKCPjdisAr8vdfLVNVHEIj4A+8RsVp8+ezBZxPHhBRhoX1AXHHSQvFhf1GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456062; c=relaxed/simple;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmxRRwVN6coowHYM5S9PkN3uNVap4V3cyG0nfKbCbppo3HadKXbR5CDhzgMt7wZv83Vw0tR6Pib0CAPH08+0QrQOVM8iWTq/MNkOVNTUsz0rgKpFXCNMvJiOxLAt4MdxyTsT0F2ud1rnRs013T17cIxK8tAVUQNmW1i5y28DxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ7HJr/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF1C4CECC;
	Sun, 24 Nov 2024 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456061;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJ7HJr/yOHFgYYQQHK4wUdUlOQKqHVsklZrFXGF3AA3hJdqlwsYtXv3RN+RvVPmBG
	 klPNwLy9nWHOZ2z/vpM5SHslhuQkbysBTEtb3DkBRyTSlxuR2cFAPS+yzJTyoglDqP
	 gbK+1td88n1l/eJCAt7IrEGPhGkL6RcKXMxDVezUNXM6dTUHj8ZR4B9wxjbPOCGbJ0
	 7lvumABsXu17KnNCMtowLz+rqE9+as7KnYD7j17nMMGYN2T5J0F0lcHpmtNPaxEW5W
	 ykHFENiEGpjoQn05bI92w3AJUygP6m0+/ZwaS5KjM9SHjqv4QpLTo29/Itcr2IdMBA
	 eA2imTc+e3uYw==
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
Subject: [PATCH AUTOSEL 6.6 26/61] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:45:01 -0500
Message-ID: <20241124134637.3346391-26-sashal@kernel.org>
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


