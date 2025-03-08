Return-Path: <linux-wireless+bounces-20020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64043A577C5
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 03:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902DD7A4141
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 02:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551A15E5C2;
	Sat,  8 Mar 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="B1izPtRE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469C1537A7
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402746; cv=none; b=mA8BeURGXqNa98i9nqz8dHsRBWF7NKyEDgJPxzVlUGbopEmAH82fL/nR93LBRwyzdT9VElr9DdfDjuT/qmiDk8HjJ1x/6g8lrdPXLtTlPJFv3ZrW+7/XjqlZTYVolBji6vrrKBIcRspN5srpYkuPsoifcSoj+vik0loNCHt3Pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402746; c=relaxed/simple;
	bh=KlscHF1V32oXHlsggN+lOtvZH7LLUhOzmbx+k8U5Pq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0uqPj3VFvooN6gbhdHVAstyc9x7eITXXslYbC4H/zJEfAC+zad9UdF+E/iUGXIuUw0p8O5cu6sLb8i2oUYs0mPCSfZYSBON1jTO+5WvqJTo/HbK2yexEpvIlmwXIBCrUJRAM8+jGRPNTtBZpZ4dXiEOYX4N3W6YmHK3Iqe78eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=B1izPtRE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5282wu8N32568079, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741402736; bh=KlscHF1V32oXHlsggN+lOtvZH7LLUhOzmbx+k8U5Pq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=B1izPtRE5ECHZRCvJBAqGBjvoGe7ERAkVNhs9YGI4tMJ9+qJK4jvCtWBu25CaZxPY
	 3C2SXrMAUjGuTpDaPdoJXe5Ni4e9bpR/GiTRs8k3RHLgahMMst9JG+AmfgRIzB0eed
	 GMjX0SzWyjm5WXyOkANzdmq4iJpH9c7jufgOh2dOsGMn04vNvCwF4NPRbFkFYswW2Q
	 CJrV3p/Ogl9vvbNTiRc7Gr9V+59ucKwQMOD1cVdT/465aFoPmS0OGLwYSYH4vN2pd9
	 8tWNyYRjlvkkEjxpthaQSBcxsf1ylykxB2goCTJ/NWG9WA1UpVwY5cqcQsF045k9Dg
	 qknQ/lbhV+/uw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5282wu8N32568079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 8 Mar 2025 10:58:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Mar 2025 10:58:54 +0800
Received: from [127.0.1.1] (172.16.23.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 8 Mar
 2025 10:58:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 2/4] wifi: rtw89: coex: Fix coexistence report not show as expected
Date: Sat, 8 Mar 2025 10:58:30 +0800
Message-ID: <20250308025832.10400-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250308025832.10400-1-pkshih@realtek.com>
References: <20250308025832.10400-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

This report will feedback some basic information from firmware(PTA counter,
report counter, mailbox counter etc). And the report version need to match
driver & firmware both side. The original logic break the switch case logic
before driver update the report version. It made the report can not be
parsed correctly. Delete the break at the version 7 and 8.
Add logic to count C2H event report.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f1a811c8713d..94445c1d64d1 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1380,11 +1380,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxbtcrpt == 8) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v8;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v8);
-			break;
 		} else if (ver->fcxbtcrpt == 7) {
 			pfinfo = &pfwinfo->rpt_ctrl.finfo.v7;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_ctrl.finfo.v7);
-			break;
 		} else {
 			goto err;
 		}
@@ -8108,6 +8106,7 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		return;
 
 	func = rtw89_btc_c2h_get_index_by_ver(rtwdev, func);
+	pfwinfo->cnt_c2h++;
 
 	switch (func) {
 	case BTF_EVNT_BUF_OVERFLOW:
-- 
2.25.1


