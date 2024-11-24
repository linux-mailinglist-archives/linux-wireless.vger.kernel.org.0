Return-Path: <linux-wireless+bounces-15644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947B9D7443
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3F1284A25
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1939D23CBB5;
	Sun, 24 Nov 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHWqIxN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B223CBAF;
	Sun, 24 Nov 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456370; cv=none; b=NANYlMPs5XUu6IEUW8sh5cfUgWSCRRi0XeV1cId8UrJk2EYcccU4SB2G9IyuBiqoQhUu0bTX033HaX3SoGMt9ew46FNaxTZQ9jRNIw+62C1wFN9S9ISvF6Frnv8q13sLwDVcVTob/YboZXSLLQL+lAiZQ/HeKqOndQnTGnumMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456370; c=relaxed/simple;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tq+VxJx2Uo9aIkSbV0Kpz83GzcQEJsEJzqK82mx7wmybHUpcu5HBNY9K/nvhuuPRZk/85Y5d/RJ1Mo0TbVefuZwx2Pw6ZFUFO3hmKk4y6XDrvRmXjbHfcxHr4C0wuByp75MIjUDSlN/M3faMDZi2hOvvGeh3Wm96yeJs5myew8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHWqIxN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65187C4CECC;
	Sun, 24 Nov 2024 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456369;
	bh=OZaDD2viwLOSROgpqkUgak4AxnPmge/qPAoE1YQ7OjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHWqIxN4dv63OpLJiONxA5il0RoqA/2qvj3D/I2oC3yM5/Kvs7wwrKN8FipBDEYlE
	 2qouE0obixbFdpmMuHFA/qvezlHkEL7+jGLpg50YTUqpKdh6BKbf+G7Vfu2CtmHPfr
	 qz2MfElpX0Px0uTDZBaVu0hE57mcfUDM/XG3NiQ1vr3hZ9TSleMJwv5S4dPHYKnj8L
	 KjwhoAAbTSrZLlqjSEdoKfM6vJ3TFHUnTTeK+sD2bs7d5krAfWP9I2RXSl3CRRsNAw
	 vnepvRMo8PfQYvfORwS6WcbR8kffg5WKfK+MjGJ2cezO6lbSSsaxGwIiQaHxUJ1oSu
	 iv4kMgw/PI+/w==
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
Subject: [PATCH AUTOSEL 5.15 16/36] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:51:30 -0500
Message-ID: <20241124135219.3349183-16-sashal@kernel.org>
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


