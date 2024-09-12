Return-Path: <linux-wireless+bounces-12805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF278975ED3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 04:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E1A2858A7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF62AF10;
	Thu, 12 Sep 2024 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z2nvhT1t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91777626CB
	for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107426; cv=none; b=j28kQ2u8zGIV5/p2UM7iWrHD0dkIQ72IAwf29XMIzyaY7L/EyQLA4Z5q5ZlYwY3HGAnP+Cbtgxjxn4byTjgncBfS2hfOTiTooKXMWPHjHCoCjGOXixVLuHx5rcqmlWKr3B40qS7Pel8Z3WdWomVqlN6c2VPyk+sxys+/qFRNZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107426; c=relaxed/simple;
	bh=RwAhOL+bmdRAdXfJOJBohkAoWpgIEG4DWCf5UAVpgyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNtjZxy9ncQNECI3MaV24kjsI7xQBiABH2SVyoSAbdHLJ8HXrOh1qYhSj8p1a/79fJwuvCs47IYhDrNAlTvgOo3Sna/G1dGV9bvBQzTgQ6XLrwmTqMjuNzeZtBrHUj7l61MxqWT1uYyGy82AtMaz8mehMLLtOJRjT3gyccMEP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z2nvhT1t; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48C2GrVdA511981, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726107413; bh=RwAhOL+bmdRAdXfJOJBohkAoWpgIEG4DWCf5UAVpgyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Z2nvhT1trVS3ZpMvUESDOBtEGTjQDf2Os+mr/H4sx19eFo396JhZynmjm37mKV29s
	 TcW3DDC7w7TCPAR53U9Jkkuf3zIZBgtdGHCE3E/zlQYj5QEJR6TXHeTTTFpxSAKewp
	 KzIlgADtdtFgn6OFDvmlji5PjeERdlIE5ruUupVALVGsicbXDUdHISIO9Pzr2oxhDV
	 nOxwWhknCJtX4Uvu3I7JEseqoeyDU09ErxMw7Vcg31GCTo5VXOkzANkAnVLXqU966i
	 7xhe5v5nmsvRpg99Ymuz3xjHqTQnG9w+QaRfwA3LBTTqQxZRJFncmYSXKlFcAo7N5E
	 BemOAVychG/KQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48C2GrVdA511981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 10:16:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 10:16:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Sep
 2024 10:16:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: coex: add debug message of link counts on 2/5GHz bands for wl_info v7
Date: Thu, 12 Sep 2024 10:16:26 +0800
Message-ID: <20240912021626.10494-1-pkshih@realtek.com>
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

The counts will be used by MLO, and it is ongoing to add the code, so add
debug message in todo part to avoid warnings reported by clang:

coex.c:6323:23: warning:
	 variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
 6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, ...
      |                              ^
coex.c:6323:35: warning:
	 variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
 6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, ...
      |                                          ^

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index df51b29142aa..8d27374db83c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6445,6 +6445,8 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 
 	/* todo DBCC related event */
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC] wl_info phy_now=%d\n", phy_now);
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC] rlink cnt_2g=%d cnt_5g=%d\n", cnt_2g, cnt_5g);
 
 	if (wl_rinfo->dbcc_en != rtwdev->dbcc_en) {
 		wl_rinfo->dbcc_chg = 1;
-- 
2.25.1


