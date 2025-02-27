Return-Path: <linux-wireless+bounces-19541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C45A47EA7
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445207A2FC9
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E022F38E;
	Thu, 27 Feb 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="azbLaBDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1122F38C
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661980; cv=none; b=A1+PCVjO3STIv+2yzoewi5i16xylPGasAuBPmlXHwEFLg94qYGF43TlDxVVPyMuE5Ctn5J1RPW74LKI6kmn97KWtXhICoak63verRFEQHcYkqYgmN6hioiMWPgYMUpPuWMGh/1ExiCQHBEJfGE9q/W60YcX0Gtn+hT3uCf2VcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661980; c=relaxed/simple;
	bh=MMZhUFE1+XtMYgoOLegOV9XNdpPbTTETSrSwEbU8dMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgUpTosYYqySy/gWHDyY8QhasR+0To4Oo9H8zL7YqLOMXvhU/sNHhjuAjdGbKAQKzuwPTdoE/I+5AkB++dO5We5xs9J9blk9RxKClQlqHkaqIjWvdJHcyuZBfW12hom2FIIKbB+oHY+5C32BuNDSg51+9AGws0mehaUWAOWPfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=azbLaBDY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDCs5Y22008957, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740661974; bh=MMZhUFE1+XtMYgoOLegOV9XNdpPbTTETSrSwEbU8dMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=azbLaBDYn4gFMzpLD6QMteCKW0XtFF3dTAAaXF33b9AOcXULdNwF2umKpMSn/CLCJ
	 8FoxjPaxyrHKkYxsQYq5Y20skVO3mt0jgHTqcbUodnBcs31buczDqNL1aTqdpSJRim
	 DsDAVTWgGBj6jl3ok7rz1ytL4Y13H2qytFgaO8ESbL1s2380fjIKlBOL6IgB0u+Twb
	 ed/XRhwy6igD6abtH8ESWIR34i+lmscRmTzotmgYv+GMQqPdvmwDVm7Ttz4ihplm48
	 9d7KSDlCSIeYwPHvnUWiwT4wk25bdSnldGAPWpwiAv7+Bg6b7kZ0tUnAYu2hBIAw5H
	 Yl70wKSGzJKSQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDCs5Y22008957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:12:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:12:54 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:12:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next v2 3/4] wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
Date: Thu, 27 Feb 2025 21:12:27 +0800
Message-ID: <20250227131228.8457-4-pkshih@realtek.com>
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

The format should be "%08x". Fix the mistakes.

Fixes: d60e73e5dd70 ("wifi: rtw89: fw: load TX power track tables from fw_element")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1965a62746c2..15d6bda1fcf0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1099,7 +1099,7 @@ int rtw89_build_txpwr_trk_tbl_from_elm(struct rtw89_dev *rtwdev,
 	bitmap = le32_to_cpu(elm->u.txpwr_trk.bitmap);
 
 	if ((bitmap & needed_bitmap) != needed_bitmap) {
-		rtw89_warn(rtwdev, "needed txpwr trk bitmap %08x but %0x8x\n",
+		rtw89_warn(rtwdev, "needed txpwr trk bitmap %08x but %08x\n",
 			   needed_bitmap, bitmap);
 		return -ENOENT;
 	}
-- 
2.25.1


