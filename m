Return-Path: <linux-wireless+bounces-20626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E6A6B372
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 04:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FF67A2B53
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C8182D7;
	Fri, 21 Mar 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hNxyWZVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73D3C00
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742528883; cv=none; b=hYeFgNacjUfW6hoWK4/jswxc8+VdemfAaAg3dflPPEBnzrEiHcrAhb5RqpSE765WrxJnP1QMF5ngl23+lVSc3KNmkta1sjidRwbBIJRWDyFBhYWT9DqaBbuY5pPrMK+kzEWwflLi7o8r9zRxt8paN/2Yt9C0rhOS/MlPCKf4tVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742528883; c=relaxed/simple;
	bh=RbFw19XiTYprLLWHVx6PXzUpRbaR0qoZz3EAM00uj0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JqnLhPyCIhIw/1GHnrSxeEtIMlLVri2fe21aC/ngATJ22YK4g6drHzkf2K8sDBS78J6k/ZZ4i1IUhvcKxE7rWAtmrf+0xSG57LNL28xTSrqvqr4NicqGgfd2C+/Bnz+zT987YpbUBY/kukWIGJBXQqaYMwcVXROiNPpbh6GDyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hNxyWZVP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52L3lsDY33713437, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742528874; bh=RbFw19XiTYprLLWHVx6PXzUpRbaR0qoZz3EAM00uj0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hNxyWZVPTXftmPpFHod5YJ/lmquUngu3Iip9yQ04mmE2vE7pR/8S4TvM5jLnh+bEU
	 goAhvCzAR2wL9BlS91a5IyJDCJRrxSjd2sVjTGlMcKccWO9VB3qzJFr1lLC5VPJmwO
	 Duz2iB2n/ZT/yeMLsJ3mvgqSsyO1sAaGAqG0DjCl4AWXAuB6BALflmNPai1DILKNGw
	 6nXLTouW94AQ/P3n/nvqHhpQeTgFUy6y1/w6NxD/Ac+rEo7brI07a5dyj1r+OIqVgP
	 yZrJWZyLpQ9QSuFlsU5ns1IRRAM8jEFrLKiXHgxAZpqduiLE5ov2ZLArJUvy9ZSQbz
	 1w5hYptQQVhew==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52L3lsDY33713437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 11:47:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Mar 2025 11:47:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Mar
 2025 11:47:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next] wifi: rtw89: set 2TX for 1SS rate by default
Date: Fri, 21 Mar 2025 11:47:36 +0800
Message-ID: <20250321034736.6269-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

To improve performance in range, for 1SS rate, transmit the same signal
on 2 antenna, which is called 2TX.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8643b17866f8..c7172334f895 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3065,8 +3065,8 @@ static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 		ntx_path = RF_A;
 		map_b = 0;
 	} else {
-		ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
-		map_b = hal->antenna_tx == RF_AB ? 1 : 0;
+		ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_AB;
+		map_b = ntx_path == RF_AB ? 1 : 0;
 	}
 
 	SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
-- 
2.25.1


