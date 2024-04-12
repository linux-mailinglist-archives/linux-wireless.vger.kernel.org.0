Return-Path: <linux-wireless+bounces-6247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D058A2DDE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 13:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE62835BD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AC3FE55;
	Fri, 12 Apr 2024 11:59:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711B55792
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923178; cv=none; b=guVznPmfyq/JeFfERItE5JdSVMELxQsz9jf7m/eem9lZ2pBZFRq8xVCPeWrsnSSfYLuFEkF+sQkJDxTOLtIMjQ1iwn/3sKZKoiaRHVIjg8vjms20/NrbFwZuBjbeVv2tszNFEgRdi989Yi0b9JmcfvLVdAcTYQAHnKSx4qrCGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923178; c=relaxed/simple;
	bh=qlajmsfa/oYqUJr45ILRjLYpxKoI0zmRB529GzeS7tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3Xnm0Lau736ptrGvMNAuRVuIZHwkNj/1TLfkOlQGqrfNgzMiz//SFqcC6bT9kyz2xJSCmcgu2hJOO1Y0RVu2ufvyEQhcaACydVEbdfl6qkBCXB2iNPjcxqhuWdM2jHcRH+nmeSnoSVgMIQDakepghbmLrMbENv9ao93yBfObJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBxYlrD2094295, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBxYlrD2094295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:34 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 5/8] wifi: rtw89: regd: block 6 GHz by policy if not specific country
Date: Fri, 12 Apr 2024 19:57:26 +0800
Message-ID: <20240412115729.8316-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412115729.8316-1-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We allow 6 GHz on target regd if and only if
  1. it is a specific country, i.e. not any world-wide cases
  2. its 6 GHz is not blocked

So, for world-wide cases, their 6 GHz will be blocked now.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index d0857ef60ea6..85a7f902ccf9 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -572,10 +572,8 @@ static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
 	int i;
 
 	index = rtw89_regd_get_index(regd);
-	if (index == RTW89_REGD_MAX_COUNTRY_NUM)
-		return;
-
-	if (!test_bit(index, regulatory->block_6ghz))
+	if (index != RTW89_REGD_MAX_COUNTRY_NUM &&
+	    !test_bit(index, regulatory->block_6ghz))
 		return;
 
 	rtw89_debug(rtwdev, RTW89_DBG_REGD, "%c%c 6 GHz is blocked by policy\n",
-- 
2.25.1


