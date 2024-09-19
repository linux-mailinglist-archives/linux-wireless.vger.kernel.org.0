Return-Path: <linux-wireless+bounces-13004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D020997C5A2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D703B22908
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8789198A37;
	Thu, 19 Sep 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PSWB2yjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E7198A3D
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733590; cv=none; b=akHgw7INlosHVbO8cWhZm5zmG/RbxC7/z2MWmL9xSxIUWMpq5vi2FWg9K9EzRJlxgW1nvgenK3K9eHaPgxW/RPWdOByeo7AqbaCSAIaHmuOT0oyRrFYjbdzaH8H5aposJ/l2EV6Mtr1rxSvVdtRgXI6ZrHKlQZ1uJFPIbtKt48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733590; c=relaxed/simple;
	bh=lhycrOmEH2H0deQli2bOlLvIlv6YvU9UePVflL49kkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXVuEe46Ng3/RuHYsXRqeXDHUpdq2UfcDYqsAdXjkIyOiMVwC5OGy01l/8AB5H6hfFbF8Ijz5SfA+qTD7wcZVhGuH14a1+mSkpLnALTC8wwTslApca7mzvCwe1OuvBmCCZS2y/abAIhYiwvi1wVZUKZepm2iRKGKu4Cwqz8XyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PSWB2yjw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J8D6Pq83453223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726733586; bh=lhycrOmEH2H0deQli2bOlLvIlv6YvU9UePVflL49kkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PSWB2yjwQ0mO5G7VMUFcRJbCDtCcM+uUvZ88c0X89WbGmCdD+SjpeR4SMyoG3XyxG
	 dJg+O+EJttnogCUlsJ1218T0ACH00aFPjH1/ydZSP/w4R3f7yRF02YahflYmL/ukl6
	 8VQhIULmBPE2XaU+DvSrFmSbimq/gh9GGm/ph5QqhkezUMLDJFCg/4DJJ+wdJhY4jV
	 LGtUnNNv5IBP3t7i8YV3K5LMoWKkKFyelthdoqv5ODRz5UO4zVaMxiEukQnfBK4v7g
	 zwzNFCyz8zColAfXYJxjRo3yZOabIIyO2xarQPJp6KaIHPeQg77YfhXXZk3PuJxnyb
	 7rcEzML3q4rVw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J8D6Pq83453223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 16:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:13:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Sep
 2024 16:13:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: coex: initialize local .dbcc_2g_phy in _set_btg_ctrl()
Date: Thu, 19 Sep 2024 16:12:15 +0800
Message-ID: <20240919081216.28505-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919081216.28505-1-pkshih@realtek.com>
References: <20240919081216.28505-1-pkshih@realtek.com>
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

For the case of DBCC enabled and fwrole version 0, the local variable
wl_rinfo.dbcc_2g_phy might not be set by following for-loop, leading
uninitialized variable before using.

Addresses-Coverity-ID: 1586724 ("Uninitialized scalar variable")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3b3fd451e445..6da1193422fb 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4855,6 +4855,8 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 
 	if (rtwdev->dbcc_en) {
 		if (ver->fwlrole == 0) {
+			wl_rinfo.dbcc_2g_phy = RTW89_PHY_MAX;
+
 			for (i = 0; i < RTW89_PHY_MAX; i++) {
 				if (wl_dinfo->real_band[i] == RTW89_BAND_2G)
 					wl_rinfo.dbcc_2g_phy = i;
-- 
2.25.1


