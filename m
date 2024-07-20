Return-Path: <linux-wireless+bounces-10408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38437937EB9
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7688282330
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C107E1;
	Sat, 20 Jul 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RU7QSzGx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F607B64A
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441669; cv=none; b=MEGYPqhiVmZKDQ+cpzCua43HPm/XlVKH+OrgZkZHbeUipemb0v8omw8fcQOL/4l2juz3ZsYwILs4/jQifRm1Asuupl4MGVM/l5yyy/0Ef2ph7HSyAkyw2npX+2dbQUAY8lFTaKAOwXS0G3iZfM4dNw1VNXWKfmjv9aGYWS/k2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441669; c=relaxed/simple;
	bh=tZd4Ko071e4vmW0RhBg4p+Lasx6n/hqcQDLmP32vh8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOWOfO2q59seA5jDdS2jL7eV/RV49caoFqcXiiXGO9+vb93HqlkJ0DmXL/prn6ujH0YH0Lwgc8DOI2hGr0wupE+ufOKYe+6CV4Rjso9neH2kmiN7PMPArrDf+pnalmWq2yjqlQ8uThjo2lyvS5JWaG1wkQAOLciqtoxO3jZjMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RU7QSzGx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K2EPfnC1147843, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441665; bh=tZd4Ko071e4vmW0RhBg4p+Lasx6n/hqcQDLmP32vh8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=RU7QSzGxPTxT11SUqZBbYkrFq/7kWgD7p/mUuayOzO/VopQYAVecp60i7qNYVNxF3
	 YIajhNSZt8f3Y4+Z52ZsA5RSIAMlhYL/dvxaDhFxMaZxP9d6P9h6SQvdGYF8VJhGrS
	 0loBk6W62Bb2kh84qyUbBkrd/J16zSvp9fq8cN/ZFe0TBmSDNyehQ5UGf1ysEaf6La
	 jdQKoEoHBp9Qnoiv0Y2akkak83XJApcbU+dIPfpHWQlGX/02fE1XlAJJE/Rgya9N7E
	 9/T0g2mNfOWBGaTtsAdVfMhlPvaWOCmIds5VvTxJ0ke9Rb/pd0wPraoFCviO+bBv79
	 Ol546Km59e1hg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K2EPfnC1147843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 10:14:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:14:25 +0800
Received: from [127.0.1.1] (172.16.22.168) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jul
 2024 10:14:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 2/7] wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK enable/disable
Date: Sat, 20 Jul 2024 10:13:35 +0800
Message-ID: <20240720021340.12102-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240720021340.12102-1-pkshih@realtek.com>
References: <20240720021340.12102-1-pkshih@realtek.com>
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

clang warns precedence of '?:' and '&'. Even though original logic is
correct, use str_enable_disable() to avoid clang confusing. Another way to
fix is to add parentheses around '&', but I choose former one.

  >> drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c:1827:46: warning:
     operator '?:' has lower precedence than '&'; '&' will be evaluated
     first [-Wbitwise-conditional-parentheses]
    1827 |                     kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407200741.dMG9uvHU-lkp@intel.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3: add by v3
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 0f2a74269b98..e90a036db667 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1824,7 +1824,7 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool o
 			       BIT(24), val);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", path,
-		    kidx, dpk->is_dpk_enable & off_reverse ? "enable" : "disable");
+		    kidx, str_enable_disable(dpk->is_dpk_enable & off_reverse));
 }
 
 static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-- 
2.25.1


