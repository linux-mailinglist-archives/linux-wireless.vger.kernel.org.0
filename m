Return-Path: <linux-wireless+bounces-30548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A7D03F43
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E197C30429B0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8C4BD5D4;
	Thu,  8 Jan 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GlCj23dK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2C483801
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873826; cv=none; b=JZnqu5/vNC6xWBA6T24EwXDwooO6pC7m/em2Y88hSmDEVgu0M3rKzu38ZA81vKMgcdlaR4+WhFyWsVOx9mQALf4K5SKnz6a3J0Y4jnfWLvwAl7wz5swv4/wIUO/z2NaVVXuxEfhwsPx/oFxxY7wxCpfkPcdBNo6aV7r03pWVMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873826; c=relaxed/simple;
	bh=KdwxGTPgogO4uLPCVqHJfISCT0pEIsnMHPpS0E2LMFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGnIBcRg1bMsy5exC7aQB7TUGHIN8yX3dxYe6K+DfP6Pd1ZJipC50DGnVgpvWI9Zdh8qh4pJ1zD2VlWS+uSk1XApgsNPItKJbDT6SKlnvFP1RlAlF8c4pjcHVxPlYKag0fa48T9D94XpMvjSjiYFMdQr/ka7024CGufx5l2f82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GlCj23dK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3fgA6969975, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873821; bh=MfNqHynJMfWvt0X5IuhjmlHLw6aMMOSZgXZwGT5ntXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GlCj23dKQBnujJx0S6SJ7P/V2rpEDaVhf2KlIzXZmhcTD10hUxplwYbROZzqV2FI3
	 mSWcu0friXPmGLkwvlGJUqzfealYPxxe4JqIu+KlSe2cxtF7p6/WuEjUt0fmBTgWhI
	 o6DMKFZHVtywL1j6Arx29pgNEImU3lUoPBTGXBqFEyciXEz1rD2VG3kNeddIiryRX/
	 uUoH+mUUrCk7tpdJ4OxsWCqK1eG5VbilKLmf/clLb+ztgwomJs+n7WOrWWBDmvHvn9
	 Zvj/HdxoRP79VTvK407hDKqznPNNDi+Y2yiAefWuZbRD9B1yy3ydnPDadWi7EAZJWm
	 oe/Ixn648OWgQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3fgA6969975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:41 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:41 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 04/13] wifi: rtw89: mac: remove unnecessary return from rtw89_fwdl_secure_idmem_share_mode()
Date: Thu, 8 Jan 2026 20:03:11 +0800
Message-ID: <20260108120320.2217402-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The return type of rtw89_fwdl_secure_idmem_share_mode() is void, so no need
a return.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f2882ed23419..b569f721a6f9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1625,7 +1625,7 @@ void rtw89_fwdl_secure_idmem_share_mode(struct rtw89_dev *rtwdev, u8 mode)
 	if (!mac->fwdl_secure_idmem_share_mode)
 		return;
 
-	return mac->fwdl_secure_idmem_share_mode(rtwdev, mode);
+	mac->fwdl_secure_idmem_share_mode(rtwdev, mode);
 }
 
 static inline
-- 
2.25.1


