Return-Path: <linux-wireless+bounces-15652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59DB9D74DE
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB5287010
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A2248F2D;
	Sun, 24 Nov 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6dODOgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78715248F2A;
	Sun, 24 Nov 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456576; cv=none; b=Q18eNYU175Y6+k2OQL87nW+1MQImdoGe1IXUhLUtwdNHyrc7OvvfucDgALp/ijr7992RwXifXz64h0tQVuZaL+Z2SuIDPm6kzBCzX9977rdrRHr144eQ8TtQDbxV4FY80Pk+91sNES57c4ZAjwVGNYJOqvvfORvSjIiEDHPuwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456576; c=relaxed/simple;
	bh=XPt5bwEzhHstfgtRk4gWbadxbeMnpxIanmB815OBs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1xEs9hjkPFFcQvhFC9UBo3E/IrSJ6BV/oI0etCMvuHK31JlT2azVZETAfBuDZTwAcsc3n3MY/uD7YcLp4Y/z6QzmIgdRm+v+EAXnY0w7pPPo9mCBz77tczs2pLKi8CgRzJwkZ80SMt44nDKMTmEIga8pQRPksuxvYkzFlWGfug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6dODOgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BB3C4CECC;
	Sun, 24 Nov 2024 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456576;
	bh=XPt5bwEzhHstfgtRk4gWbadxbeMnpxIanmB815OBs78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6dODOgRRS2BABdiIEHfKO3+QXReJgkbzdMtmpOjndN2/mIV1i0rPsZHlUkUDs1qM
	 bVraSgj6YVw5ep4E/9cp4hd50c+L+voK+UroR843I30QDIReIO9MzlHqQ8fh63wJA6
	 5DCmNUY8KHG2u5VpMTI2YMk9yXL1Ey/m0eorVrfCUoy0aVj1kmCghkPexLgR5vCINh
	 sm690vaEBQCugYwhMw/LqcACqaZmZqEsyivN5s+rVxd9BroB6YPRB5q0EsG5b+kxnz
	 iM15yxfyIOFjdoL2nb0XD2M6DxZOGQNHKfN4rVR041jvw5Mzpd4N6TFT9VI14gCO4I
	 o8/pt909Okq0Q==
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
Subject: [PATCH AUTOSEL 5.4 14/28] wifi: ath5k: add PCI ID for SX76X
Date: Sun, 24 Nov 2024 08:55:14 -0500
Message-ID: <20241124135549.3350700-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index d5ee32ce9eb3d..b7f62c472b879 100644
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


