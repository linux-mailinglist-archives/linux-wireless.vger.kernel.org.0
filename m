Return-Path: <linux-wireless+bounces-19540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87541A47EA5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425F1188D6DA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACF21ABBE;
	Thu, 27 Feb 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wiPCOQ2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117522F38C
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661976; cv=none; b=Cn9UqfxsIkfAoQobTRp8rJ1mK0UVaGvHHAlpr8Yblv6qDAWKPk/7hXE6l/S9v30I80DtAfAyY4zEBgVV2zySNvKpRwDtuuIrSKMzUXbFN75hGNTiTD2cUs40fcB37JU2k8ht0JW+2Jt6OE7/90GC5zCCLr1wxqfPuGFit34eDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661976; c=relaxed/simple;
	bh=GKu7FpmwQLAZIh0bUUEbvaheSJGXBQ9F3RJkXGAVEis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAodSwN/zr4kMWWIjZ1xhk550EL9GEf33XTfzMRLb1hGz3fJPBUutxI4N44nlqlg5bgtBqlBrIoq2PewkHLSRyvlcbFt/7lDSGJ7qOSPn9TUZgavFT8uxnt3dRneCWe5P20tW3Zz99NpyV/umJI9MikhsB3qmS8RrdPEkG0UXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wiPCOQ2K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDCov362008953, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740661970; bh=GKu7FpmwQLAZIh0bUUEbvaheSJGXBQ9F3RJkXGAVEis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wiPCOQ2K3lXjoexqJ9C6veKRfrcMFtFSZDjG63wcskcHEhRL6wDwoQmnkg/VEz/DX
	 KvW/JBkcRQyQ9T8SLX6MiR2cpaRT0aMjajTmrOQNedNtm6t9bRUQ62pjAedaNcBV29
	 0c3AbwGlQtrDoZjq5lbsIQv2rL6mul9DLtf/HcpIzL8yg1cxXc0XFluw+nA4d4FlCa
	 hnCYdtSrp1hJS/CJbFPqZoWrz17cCk8bfmCN/I9NIKWzBKm1uW1g+szxoJ0cB/LGE3
	 +jjbfFURxOTCXyNhrNXiNlzlZutz/2Q/epJqrmBubVGau2YeUbCv9ksIeoaYwLogux
	 wNb+hrnfxrXMw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDCov362008953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:12:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:12:51 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:12:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next v2 2/4] wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1
Date: Thu, 27 Feb 2025 21:12:26 +0800
Message-ID: <20250227131228.8457-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227131228.8457-1-pkshih@realtek.com>
References: <20250227131228.8457-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Add new fields band and port ID to make chips operating on the band and
port ID other than 0, so that multiple vif(s) can be working at the
same time.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3e4a3200358a..1965a62746c2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3934,7 +3934,10 @@ int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 		  le32_encode_bits(self_role, RTW89_H2C_ROLE_MAINTAIN_W0_SELF_ROLE) |
 		  le32_encode_bits(upd_mode, RTW89_H2C_ROLE_MAINTAIN_W0_UPD_MODE) |
 		  le32_encode_bits(rtwvif_link->wifi_role,
-				   RTW89_H2C_ROLE_MAINTAIN_W0_WIFI_ROLE);
+				   RTW89_H2C_ROLE_MAINTAIN_W0_WIFI_ROLE) |
+		  le32_encode_bits(rtwvif_link->mac_idx,
+				   RTW89_H2C_ROLE_MAINTAIN_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_ROLE_MAINTAIN_W0_PORT);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_MEDIA_RPT,
-- 
2.25.1


