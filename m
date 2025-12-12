Return-Path: <linux-wireless+bounces-29699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39304CB7BC2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C7B301274B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9026A1B9;
	Fri, 12 Dec 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ptoi+035"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC925F7BF
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509293; cv=none; b=D43AlOdS0ym5CDnmU7F/R2u4hgneWhvcCUWNzPaU1p49zvvXZ4XOl1wfFLOY7hGZRWSfAHVO8BqrJhEJ/bYGpZWnzNL1/coVhdFOiGgo8jk5hOmCcYWnYSQOUls3Jqvw/yq3DcnUZxZxFoQHTD5lCkPSve8BcD9q099QH9rK7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509293; c=relaxed/simple;
	bh=ZFYgiUbHjpNL4WLUrs4b8dW5cOWN4JmRvEQQBms63+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2p17BI0RD9u3I3nqY9YqgxggJbLuc3HRV5t/ZNkHa6GjtdKzS554APozGJWjgRVwMKE0s30c9ymoW/5AcSSSH4eXT5g5MGWr7V3Jp6clmtHue1MMLMoWdIJXHeqlE4nehGwIAFGwYK1t2zE4+c0aNV4ndUoVB6mPua3H85zlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ptoi+035; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3EnPH23508894, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509289; bh=5qbRA4TrIVMF1KLVn9mYImR7myN7WzuD4JpUcVeECeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ptoi+035HcoNW6BgAhOsuOTusv4CftuD04aNoyEmvQAdRGbwHmgD0AL0ON6nrQdTj
	 3v9RFgSHQUntMgHQNZZL+TQOJefijowONKH23U8DaziU6aPfWe1wpXGSSFfWY6/p7O
	 wxPM+FMNWLhEaDBEVC0OPhPDne05eZdm8bD9jb7MZ2VPGo3Bp2Bm4hlThdcggi1gLk
	 rG5t8+9c/c0b69F+X7F8UV7q+fJX3oOpN/LcBPyq2Gt11a3WxhX7yqv03Lt19E3bVs
	 M/Hkv9eKAfr0tqDx/bAMMc+rn1AvaRjB2ZPEnOKjJVeU5Pq88Y0xRnH1m02E5ieUR1
	 Kwvb5xt/JYTiw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3EnPH23508894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:14:49 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 11:14:42 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 11:14:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:14:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling value of XTAL SI
Date: Fri, 12 Dec 2025 11:13:01 +0800
Message-ID: <20251212031303.19882-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

XTAL SI is an indirect serial interface to access registers in another
hardware domain. When BT driver initializes UART interface, firmware might
rarely control XTAL SI at the same time causing access racing.

Current is to adjust initialization flow to avoid the racing. To make
the racing visible if it still presents, add a message to address this.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 11 ++++++++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index cf36be167162..066c99f3e53a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7023,6 +7023,11 @@ int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
 		return ret;
 	}
 
+	if (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset ||
+	    u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK) != val)
+		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
+			   offset, val, val32);
+
 	return 0;
 }
 
@@ -7046,7 +7051,11 @@ int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 		return ret;
 	}
 
-	*val = rtw89_read8(rtwdev, R_AX_WLAN_XTAL_SI_CTRL + 1);
+	if (u32_get_bits(val32, B_AX_WL_XTAL_SI_ADDR_MASK) != offset)
+		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
+			   offset, val32);
+
+	*val = u32_get_bits(val32, B_AX_WL_XTAL_SI_DATA_MASK);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 2bc329c13443..d75c55cc34b8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -396,6 +396,11 @@ int rtw89_mac_write_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 m
 		return ret;
 	}
 
+	if (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset ||
+	    u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK) != val)
+		rtw89_warn(rtwdev, "xtal si write: offset=%x val=%x poll=%x\n",
+			   offset, val, val32);
+
 	return 0;
 }
 
@@ -420,7 +425,11 @@ int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 		return ret;
 	}
 
-	*val = rtw89_read8(rtwdev, R_BE_WLAN_XTAL_SI_CTRL + 1);
+	if (u32_get_bits(val32, B_BE_WL_XTAL_SI_ADDR_MASK) != offset)
+		rtw89_warn(rtwdev, "xtal si read: offset=%x poll=%x\n",
+			   offset, val32);
+
+	*val = u32_get_bits(val32, B_BE_WL_XTAL_SI_DATA_MASK);
 
 	return 0;
 }
-- 
2.25.1


