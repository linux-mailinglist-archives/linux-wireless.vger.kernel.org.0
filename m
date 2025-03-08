Return-Path: <linux-wireless+bounces-20021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA3A577C6
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 03:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F401188DDF1
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 02:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21F1537A7;
	Sat,  8 Mar 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OlrbHaIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46351531F0
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402748; cv=none; b=SocI1OiW31BwLDUDLrNeA+5ZqK6ZeJdlKl7gq729o1oeKFcLDVexqTPignZgd3prIJ9kKwCLA332jiEVDl87TqLnvm8ea6lchGdUkCAviVc+ks6oeXguCSHNWdJTPBUfrtZm+nxDCfQHLWOQCn5CMuBZSV8AaMugSNr0CfTOdiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402748; c=relaxed/simple;
	bh=9h2xuyo25FXY/pVvmJwIli+lwCCTVKr1/vY2rF+bcOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd1gaRoJgh5952Zr14FnCpul6se4xhQbJjilXiseAVuh876e2dcF6FO8NaGELlbOboVp7usB4uDglr9ccWgQoYOdcPy6h11wVYR+QyH/txpM+cE/ehjibAHnmJheae0LB4UV7Huu7sK9Cp9nWUxeI4QMAGmPF54v/uhieX/ORzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OlrbHaIY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5282wv1932568407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741402737; bh=9h2xuyo25FXY/pVvmJwIli+lwCCTVKr1/vY2rF+bcOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OlrbHaIYHIU8qnppKLG/BHXSiJrx7OwsF5/NT1t1hvjrNGuBJPOsZVQ1ALAoAMkLA
	 YFweHPc/150MDaNqdx83lZwOT9Fy+pswS/3Perdw+cbEt7MErI97mpNWQukEIe1jDE
	 2Qlu7iBvgJDDlW255MEk9Qosdw7Yc9XJUgdUrYc/IXF8JD/ox0CRBMCiBve2VOW4h1
	 +uI1AITm6cLv5Qx6Noi0sAaj5//T4DoQG2mij8Dl2cIOMzPjsuRe8E1X/sAnkQerT6
	 Dibd3lEocSTbYcjuMNlqh0Gr+Hgm9ncZPLKoZSxTVioaSjyXIvFdIZb5aldThYkJRX
	 Z1XRI1ea+yDaA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5282wv1932568407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 8 Mar 2025 10:58:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Mar 2025 10:58:57 +0800
Received: from [127.0.1.1] (172.16.23.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 8 Mar
 2025 10:58:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 3/4] wifi: rtw89: coex: Add parser for Bluetooth channel map report version 7
Date: Sat, 8 Mar 2025 10:58:31 +0800
Message-ID: <20250308025832.10400-4-pkshih@realtek.com>
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

In order to rearrange the structure member, the format update to version 7.
And to parse the report correctly, add the related logic.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 3 +++
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 94445c1d64d1..659b92b14d88 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1540,6 +1540,9 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		} else if (ver->fcxbtafh == 2) {
 			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v2;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v2);
+		} else if (ver->fcxbtafh == 7) {
+			pfinfo = &pfwinfo->rpt_fbtc_btafh.finfo.v7;
+			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_btafh.finfo.v7);
 		} else {
 			goto err;
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3f62df657e1f..3741e32acc39 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3044,6 +3044,7 @@ struct rtw89_btc_rpt_cmn_info {
 union rtw89_btc_fbtc_btafh_info {
 	struct rtw89_btc_fbtc_btafh v1;
 	struct rtw89_btc_fbtc_btafh_v2 v2;
+	struct rtw89_btc_fbtc_btafh_v7 v7;
 };
 
 struct rtw89_btc_report_ctrl_state {
-- 
2.25.1


