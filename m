Return-Path: <linux-wireless+bounces-20596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB62A69EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C8818958E2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9661E1EB1BA;
	Thu, 20 Mar 2025 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v8URVldj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B251EC014
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441265; cv=none; b=AkzBDK1YlnCwUPNGSvjAJi6vvy87GCzjmUwSRfQDTqIDh+RSAAaQl+G67jjYynxs7uBNbQiZbCbjAbAKqF2jhFWhemzC+uIOpiQc7VGijlq2KpP+DGqAYR0pNPAxW2tglv5xrO5EPTeuehSjRTtyYsI8ct74lci+h9f5yC/Av4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441265; c=relaxed/simple;
	bh=KVICGFxfR5zvRKUM5EMfU+J/DNXUawszkpdo5HQEfjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CghiHuWWjAEygVD2jbicbiBpMlH/5ax1k2rzlB0DsHlTaQ4cnzcE/rGWExEbM6z8QtFeH2+MLqPCPBXJ6BYJQb2x57wXhoO6JgM+5/v6ErFKm8LicB/r0fd47zefRI6ahAs0tzhQ67SevHndnUv9X4BdedhtckKrmMiHcNp7nhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v8URVldj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3ReiD61750900, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441260; bh=KVICGFxfR5zvRKUM5EMfU+J/DNXUawszkpdo5HQEfjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=v8URVldjedPWi2LiZHLapbMmaW7gYilS+qMNE7cMpHAgY7Q7waeSLYYpcGbfrW+O9
	 4LG/F68les22UO8ef7RXySELQbbeJhEu9orONqfMbn5XMNKgV+ZJeIjCYmhFSu+flc
	 4ZpWNuCNDbwmBIu219t/pnlE0UXlTsmqlLzIJmnbMok6EwkzMc5+xfHD2DM/IkuPUp
	 1Oy1bTFisTPeLTg2BXnoDg6kWcwqlUFYAnn2zFOTszGIKIHC4La0/Rc8d1dwfMDTDy
	 amuubAEzYpl4upeQ2gHKHo3S4DrY+AaV+VP6HGwfYs1Y53IgcGcuj8UDQ5jRdQ4+kc
	 25I5wFhUsYfHg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3ReiD61750900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: fix typo of "access" in rtw89_sar_info description
Date: Thu, 20 Mar 2025 11:27:01 +0800
Message-ID: <20250320032712.20284-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The "acces" should be "access".
So, fix it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4be05d6cad18..8e9697679aaa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4631,7 +4631,7 @@ struct rtw89_sar_cfg_common {
 };
 
 struct rtw89_sar_info {
-	/* used to decide how to acces SAR cfg union */
+	/* used to decide how to access SAR cfg union */
 	enum rtw89_sar_sources src;
 
 	/* reserved for different knids of SAR cfg struct.
-- 
2.25.1


