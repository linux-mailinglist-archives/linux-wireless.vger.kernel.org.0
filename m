Return-Path: <linux-wireless+bounces-19471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE1A4590B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FB83A3B72
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5F258CF6;
	Wed, 26 Feb 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="c26cDVHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0222424E
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560060; cv=none; b=Tft0oRxJiyOZlBKm90UdVfTeXFtfP75x8LEhKY1i6cn3OQ7XK2p4cL6rhsZqRgphuovAjPkmKFW17JZuIm1mep+CAnqdBPTF2+T5hzIOVmAS7tu4lQHjZmxMToFB82IBHmcSe3d7y+uOh0lp7Yd6U/GrM6yXYMSXfxy3fvGAo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560060; c=relaxed/simple;
	bh=/bni9OqkCLhtrTCQB+texeL48CXrT8Yx+kVsCgT6E9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6RNLFujOiCaB5j5vTy02TYpeND1SWXCKuM2FQOYOkDFirTTaObq7ykRf8Xh0SD7s8gVGTcS2CythZh0mJX9zYAKGcVef1WeT302IYMnsP7WLeiPA1tEfRHfYGY2Opu7o37Dn/Vq/jOGAKeplioWZtd/Eb9Cw9NecLTCphs8Aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=c26cDVHl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q8sFKe93439545, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740560056; bh=/bni9OqkCLhtrTCQB+texeL48CXrT8Yx+kVsCgT6E9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=c26cDVHlXLmKORpwhit76TADZqgEw69pUEmCbMHW/26Dd7PXQ4B+vEz+oUQxIGMpq
	 WhqplDn9OVyE/nmT5uj2wV+qz1xXVZlHpheDml65p9WpKaNkha+rKIF+ImpY4PV6d/
	 5NLlIiJq70G5qSyxOHIgEe5BekY0VWRhLvVa82f0xcLhYicKa4UEq0CwafN8M6PNmw
	 YEupTaiS4j0xbdoWKwf+ejg/h/fy8ioeKfDSPeA6CFq8D+wjBjwe+l6CDbr3lfLGUL
	 7kWc0qmsXyK35h819MQooYoLQyE5gr5OJ4OBjIa/OpBs3PsGN9JFIjKNyGYNuMZJre
	 PgpF2xaf8vUPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q8sFKe93439545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 16:54:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Feb
 2025 16:54:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next 2/3] wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1
Date: Wed, 26 Feb 2025 16:53:14 +0800
Message-ID: <20250226085315.263982-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226085315.263982-1-pkshih@realtek.com>
References: <20250226085315.263982-1-pkshih@realtek.com>
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


