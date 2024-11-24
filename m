Return-Path: <linux-wireless+bounces-15657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F169D7521
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE90167FF2
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0C1EB9E6;
	Sun, 24 Nov 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb9Vu2QN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2D1EABAC;
	Sun, 24 Nov 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456653; cv=none; b=JVpelxpafmULsAGlWEFP31bqUHL3B3nKqjb0XO42cNuz3v8ECCI36/fREEkJDZ1eM0w6oO9vbWXNoRT7HEPd1Dx7hlfL2EcZeCqdh2v1hLQglA8dX3PnOGh4nVqZo/P7cbqEbC5qdIsjt01ReBH0sE28j3SQ02Pc92gSh92QaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456653; c=relaxed/simple;
	bh=OjXQeUT86j6QKuAEdC1oE0IZg6ca8uAkpSl5XRepojo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEJlhmn2gAuP/b4GQ2Gml3wpbzzJInvfjgUgYQTJApNb5VzgIeIa+nMP2qLfoG8Qp9hSWCIybN9Mg8EhkOR8U6Y/yD8cZYfWPspmeGQnfubW02tv7SC4iH6oeka803WnM4Vu3KvXZ49hOkmSyQHMaHgRyF211NTBW8Ox8IQELck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb9Vu2QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F50C4CED1;
	Sun, 24 Nov 2024 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456652;
	bh=OjXQeUT86j6QKuAEdC1oE0IZg6ca8uAkpSl5XRepojo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb9Vu2QNKAgUodUdGpOlsDubNRnToC5T6K1e+ltYki8tCnciS/Nd//6BZFmeya99d
	 Y3VwbroZ/2Da4soXEpdDzAYJv9szJvhxLOxpeO/LhTE/JXfnpJlskrSXmXQL4tkeDd
	 C/kce115dtPt/Y1W+q/CCjH4bfoIa+dE3saNkKr6a7fZvFccBZDRfkIaSPVV/0xApo
	 x70OhnXf1Bksp1h/ucC7HcGANqECa0FjxOn7/3RzhdmRABOH+XLb/tPJL6afQW9Wgp
	 vgy7/snU79TpfLYDAS2XPj624HMM7yaH7m5uMTBbNVe985SVETf7GqLqIM0BLjnC4c
	 +YxCVhbb5dFnw==
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
Subject: [PATCH AUTOSEL 4.19 12/21] wifi: ath5k: add PCI ID for Arcadyan devices
Date: Sun, 24 Nov 2024 08:56:45 -0500
Message-ID: <20241124135709.3351371-12-sashal@kernel.org>
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
index 75526d8cc82c4..bce3f67275414 100644
--- a/drivers/net/wireless/ath/ath5k/pci.c
+++ b/drivers/net/wireless/ath/ath5k/pci.c
@@ -48,6 +48,7 @@ static const struct pci_device_id ath5k_pci_id_table[] = {
 	{ PCI_VDEVICE(ATHEROS, 0x001c) }, /* PCI-E cards */
 	{ PCI_VDEVICE(ATHEROS, 0x001d) }, /* 2417 Nala */
 	{ PCI_VDEVICE(ATHEROS, 0xff16) }, /* Gigaset SX76[23] AR241[34]A */
+	{ PCI_VDEVICE(ATHEROS, 0xff1a) }, /* Arcadyan ARV45XX AR2417 */
 	{ PCI_VDEVICE(ATHEROS, 0xff1b) }, /* AR5BXB63 */
 	{ 0 }
 };
-- 
2.43.0


