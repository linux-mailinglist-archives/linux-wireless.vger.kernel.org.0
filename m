Return-Path: <linux-wireless+bounces-15648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF89D7497
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5251670CC
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A0243430;
	Sun, 24 Nov 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL1mTUKd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BC24342C;
	Sun, 24 Nov 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456480; cv=none; b=bOXp1Z9d3SH/aaYbGjtu0ncXMu2E2m1kD5RypR5304jdbsVOruxP6lRMBIgv4qKZpvXuiQTFLw2jt8H0xVRUg/UPWMyax39uzEGNiVwIWBhOD0+gwO3RvABAMz+/xd8KCcVs9B6C8e/lQWDMeKJo227IzwTwzZyhC4eWT2ao6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456480; c=relaxed/simple;
	bh=VDWbWPYnZevwl1tFnZkeoeS9AUJNgXiN5/KSHDHVtTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE8exKnRV62Sf6gNAMxeOshdt7T1iquNshqUsg8jZ0sQz4TVRfRaT/JCMGNvgndq+AgKz8V+X4V0jWnjXnaEVD+bL7VHCZ9DENT4R2mgRBmaqQ8XljqETqZlhYO1N9OQXrmF6IFFvMg/KnMgkqXjiRvfT1l+vWTPYCGj94BySkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL1mTUKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FA2C4CED3;
	Sun, 24 Nov 2024 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456480;
	bh=VDWbWPYnZevwl1tFnZkeoeS9AUJNgXiN5/KSHDHVtTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TL1mTUKd/gTndOPDKjQ/ijBjlaM/Dx+sxl2B2dfJscLYxSK9nAMohk1WrnJCuCAIj
	 OfcdBrPkZdIShWhKFk4KpSHZbybQqiJGJ3Ftrl67jio9516cwypvs3oUw6u4uh1jBY
	 myrH0NYDG/GDBVUSH73wiVsAjsag6AAO5s25sW/baDu0ysFt9+6OlHO7e9x/ZGvt2Y
	 8IExyqzEx7nWlvQAHm2FR5tLyihUZGIYivQc/V5Peh3ueMK+abXZ9YifXu6xajvVSS
	 hD6TPc03P+qlgKuY0YNqq49RnRqnLb+NGeQnnihr0m8F6WDI8IqXwwInVVSfoZZNMK
	 p0emzKtgFOc1w==
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
Subject: [PATCH AUTOSEL 5.10 16/33] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:53:28 -0500
Message-ID: <20241124135410.3349976-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 43b4ae86e5fb2..0892970a99637 100644
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


