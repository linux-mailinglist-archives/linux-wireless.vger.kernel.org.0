Return-Path: <linux-wireless+bounces-17631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3ABA14A27
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7922E7A3902
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D31F667B;
	Fri, 17 Jan 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vdKZ7SKV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7D1F8675
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098972; cv=none; b=h3ZMt1FSis/f90MUbuDeZpJah889pkjNrQhlbxVmsIwZuYHfOKeRv2bYNFqbj7UFcnfNtpCdAwNmimjS7XIC7Ri3WFFMNPQrNtURzkhFR3ghWdR/eDjqfGbmgM8HDgzXOI6piq6zGfY4pdVoyCc+THXJ0tdW1rQB7xzAl661UFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098972; c=relaxed/simple;
	bh=26nP49G0UnpgUTr71J1h7UXlcUvep4gWDSwOy1a96W0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4a3duxcGb4XyR0FclESRRSxacRL/1jVZ0wBDHUwXYe65z2oP/SNDPnZchcBRkwZCMFOWrFfcQB0vgu1lyVmP2ljVCaTZmfCs/Hj1ilThq9Enr1O4jKeg5SZhRhZZxtzt6+LOXpBpKaPeNeiNWJVtIu2mwTFrdoH4g0sCXA+6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vdKZ7SKV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7TTFq82337976, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098969; bh=26nP49G0UnpgUTr71J1h7UXlcUvep4gWDSwOy1a96W0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vdKZ7SKVoOdA63DSaW8xUpI4DbiqaKtDv5bB4fF8k0A7bMZkgWo5j4bPIoV7ijqXn
	 uMeAl5b10pJaQbNwwOLQHVYBCEyXkhCzEtXnIr+KMxwtaydElfFglgWxSMqrjoT1pH
	 GONMhTaeSWyulsPIP/lYuwMMb7oDP2DVI825gm7qaO9uivDUKIDBiOR6rkSpB2byll
	 TbCko1mQtw5O6OagnW9m6oESmK1hxra6SEJPynwJ9Xb7SQRqKbN7MX4wDu/kWTmD6U
	 2cCNUaf4aLCqgbWFYKC8+Qe6dIHbIZESLHJ1IHCHwVw5GjzGzwP0ElOd8fiIQFWm/a
	 IRyJ2iQ8ZvjJw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7TTFq82337976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: phy: disable CFO track when two PHY are working simultaneously
Date: Fri, 17 Jan 2025 15:28:28 +0800
Message-ID: <20250117072828.16728-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

To have good performance, adjust hardware XTAL to track CFO (carrier
frequency offset). However, there is only one hardware XTAL, so it is not
possible to track on two PHY simultaneously. It also can't track on single
one PHY when two PHY are working, because the adjustment of XTAL will
affect all PHY. Thus, disable CFO track for this case.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a5299295b777..5b0cf8314fb2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4600,7 +4600,7 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 	cfo->dcfo_avg = 0;
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "CFO:total_sta_assoc=%d\n",
 		    rtwdev->total_sta_assoc);
-	if (rtwdev->total_sta_assoc == 0) {
+	if (rtwdev->total_sta_assoc == 0 || rtw89_is_mlo_1_1(rtwdev)) {
 		rtw89_phy_cfo_reset(rtwdev);
 		return;
 	}
-- 
2.25.1


