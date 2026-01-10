Return-Path: <linux-wireless+bounces-30620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D12D0CD16
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 03:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1104630158F7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC22A1CF;
	Sat, 10 Jan 2026 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jhlbBQdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D966BB5B
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011654; cv=none; b=icqnydW2LO4jzDHH43ucrIvhArSWGsUAdtFKTHzOR0P2ErEhdX3bqLrV9dA0AATo5DmFhYA/uhFePmFOIwPMVNfBzyMeQmmh+vorf6DygZViEqxwhC8b7Cf8MrjslInciKW/eNU6na9I8sbUFaanfRV22PBAGiLwISScx9grSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011654; c=relaxed/simple;
	bh=9nRFI6oADFR7a36U7k5guCgpICq49Edn18y0jzVy358=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AR/0k/wReFH6bdz7HANE6c9jGCZ2ELKV7zfIAqiWlxxzJq/siUsQAME77QhgdU9/qyFynLTXoGtKtUtIowSwTENDufM1G7A5ft2t3T8DZqdEJdDA16WAfdYbdv8DvDIJbmtCWszJfW1RpUphFURw2NsHeRn59fYH3YWav3C4G2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jhlbBQdi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60A2KpVX2241740, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768011651; bh=4sZxNWmzVsAirQZdP9AmrDXnFPgGMemHICiylwHYTWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jhlbBQdi0oJK8bWCgcrB8BIMcq6lbdH01X67FC++N1983eDTu+iLRGNqSJTEmtSJm
	 FkGch7lOP5eJRhDZyEWOMYgdyWveSGwGZQra0UXYeTwgzzOTutoYHjEmhYm6dojaCA
	 6xYHft3ocDUCYJvavkqBP+0fBxSkOciBpHtjqXVNuY/eHxoD/lsT1DBBSkCAH1FNaA
	 DaCEcPatky5j0ZsSCk6ruEJB/ngQ7UdS+UoCqw2lnc2NX6UjribO53E530UBk6P3bs
	 UyWHO/OEZ97n9hd1XdSHLtruRtFquowq8GPV7xxS7O/xJp1whmycv5/CW7EGxuo/R+
	 p2hI3PUhlgy9w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60A2KpVX2241740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 10:20:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 10 Jan 2026 10:20:51 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 10 Jan 2026 10:20:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 6/8] wifi: rtw89: mac: correct page number for CSI response
Date: Sat, 10 Jan 2026 10:20:17 +0800
Message-ID: <20260110022019.2254969-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260110022019.2254969-1-pkshih@realtek.com>
References: <20260110022019.2254969-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For beamforming procedure, hardware reserve memory page for CSI response.
The unit of register is (value - 1), so add one accordingly as expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0b29f43b38bd..aaa7a7f5354d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1315,7 +1315,7 @@ static int resp_pktctl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RESP_CSI_RESERVED_PAGE, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_START_PAGE_MASK, qt_cfg.pktid);
-	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num);
+	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num + 1);
 
 	return 0;
 }
-- 
2.25.1


