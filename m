Return-Path: <linux-wireless+bounces-22544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3864FAAA7C1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0FA168AB4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863433F720;
	Mon,  5 May 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge22sTKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1333EF89;
	Mon,  5 May 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484671; cv=none; b=M54uHkp/tSHK8tgD72NW+X2tRUnY1cEXkXLs5R4REWXpDVMiZ3Iq+70UPrPK/r7oHwPavtqfB0zW/v5eL/Avq3cZxMrJJ3yXnrf7DS6vvgoROZNrroODBoTou1gmTiZ+xEE4PfsI3FjWuP17BpZidEK9E7DSKxi5rg+XK/1sPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484671; c=relaxed/simple;
	bh=lqhKCAY77koNv/uMHWNWMDW2vBWWPyKqPu5DipKfz/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjxZ9lsj5pQ6m5scLym8x9DXUurj/IbxXbnNOwbi7jyLAErHkmdXVzcxa8H2tnAwP6N4S6qZDKuf0epXa8KXgzC3Nr6NKVGPz8w8LpreaJM1MX2baRhCAmr4Hhd6ab8iybbSMAUqjtQMeQqQZmZgQBGPNvlwHyNSrLaJifM9cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge22sTKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3405C4CEEF;
	Mon,  5 May 2025 22:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484670;
	bh=lqhKCAY77koNv/uMHWNWMDW2vBWWPyKqPu5DipKfz/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ge22sTKQbMTDnxYMnaZtpFQqhLfts82fHg2Z5oCB31rbIHPQIaLeVf+s74Ion+VBN
	 uaXRS9bNgfgmgTUfH3kMdNXsISc3E3ZhZfX//Zogh1JwVyyaI4I+HIEJ3u1aQ6E4pY
	 2DjQJedY7XwJfmTvwFQ2GaOmT8tdhPI2OpwkMwXaeXUpTFw6BtxXqDiBQhRFikx4l0
	 +Yen+sETZ6SgmkgrE+k0fUnIxRhlWoni5aUh4snj4m32NhAyQp2lpmGAySdzdM2V54
	 V+ADmx/B94F2GbTBXl5t2hY2jpmDthuEECvlg4bQZhEh4cwWBAFwogaFRSECR44/4+
	 ZEN3+8t8qQMWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 598/642] wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
Date: Mon,  5 May 2025 18:13:34 -0400
Message-Id: <20250505221419.2672473-598-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 6788a666000d600bd8f2e9f991cad9cc805e7f01 ]

End offset for the monitor destination ring descriptor is defined as
16 bits, while the firmware definition specifies only 12 bits.
The remaining bits (bit 12 to bit 15) are reserved and may contain
junk values, leading to invalid information retrieval. Fix this issue
by updating the correct genmask values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Link: https://patch.msgid.link/20241223060132.3506372-8-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 7b0403d245e59..a102d27e5785f 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2968,7 +2968,7 @@ struct hal_mon_buf_ring {
 
 #define HAL_MON_DEST_COOKIE_BUF_ID      GENMASK(17, 0)
 
-#define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(15, 0)
+#define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(11, 0)
 #define HAL_MON_DEST_INFO0_FLUSH_DETECTED	BIT(16)
 #define HAL_MON_DEST_INFO0_END_OF_PPDU		BIT(17)
 #define HAL_MON_DEST_INFO0_INITIATOR		BIT(18)
-- 
2.39.5


