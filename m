Return-Path: <linux-wireless+bounces-11166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D923594CB20
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601F0B24A05
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E50170A02;
	Fri,  9 Aug 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BiLwxwjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5D1741C6
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188053; cv=none; b=IcfckinEfAcKJcMZCiivhCDHA/J1exnsHjE7SBbFAUGrRKFgJPZitCOsH3CyNE2fMkM64axLFHDBEl8xZq/G4vG8C9E344OaQUXAbfRBNYgKaZv14k8O+78rhHhpZ6rBnzeMXgPsfl9xMwma8wmus+KyMFLAlpaRsSgdOOy/shY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188053; c=relaxed/simple;
	bh=sDG24SJ40I5C8fQz+tzHTCyrKO9fHhcYDxCF5rhRTdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZorFLXB4IuWrgCb7nNl7LShqefIu/pNkiEzYoY9jszimu/qT56Kcrqd8qd2q8xuq7r+7aW9OF8OPe1zpmYsadoFrNaLjuw741mMYD+QOxMO0MupcgwPTQK95Mg0qRSNx3TSZ/0Vf0fmRJMe7Bm1/r9WfaO0IyWu51U5r/33LPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BiLwxwjK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797KndsE514067, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188049; bh=sDG24SJ40I5C8fQz+tzHTCyrKO9fHhcYDxCF5rhRTdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BiLwxwjKrk9Uo1720lLiLTqomyU2h6qm2owRVyZ0ngow6Z3XGsYUpmqJbtdGv5lCf
	 PHgYHe/x2JJ5tNkQRRXd28R+ZjJbwDVjtNaAdvu02Df6Ii9DllAiRFk9NiPIN5R25w
	 +FowjO5bz+GTnvXlXo5PX6WbQ/09hoqaRrUm6qpC4u8OKDu3nbKGVlBqCxEFSFW6gG
	 Stv9LVAklkhqM2WBDBYFHPR/0a04xf03l7vDHe01RdUsGhGZG9KLxsSQBRf/y5KsPY
	 V7DBZRTrwqgdjP7FfxjtUkJ/MIKbIqfN613blBX/pCpTO2ShwMD8/FgF82h/o+nzrW
	 0krdqq5f2mzTg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797KndsE514067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 3/6] wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
Date: Fri, 9 Aug 2024 15:20:09 +0800
Message-ID: <20240809072012.84152-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
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

The handler of firmware C2H event RTW89_MAC_C2H_FUNC_READ_WOW_CAM isn't
implemented, but driver expects number of handlers is
NUM_OF_RTW89_MAC_C2H_FUNC_WOW causing out-of-bounds access. Fix it by
removing ID.

Addresses-Coverity-ID: 1598775 ("Out-of-bounds read")

Fixes: ff53fce5c78b ("wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9d3be36ffb6e..67c2a4507124 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -421,7 +421,6 @@ enum rtw89_mac_c2h_mrc_func {
 
 enum rtw89_mac_c2h_wow_func {
 	RTW89_MAC_C2H_FUNC_AOAC_REPORT,
-	RTW89_MAC_C2H_FUNC_READ_WOW_CAM,
 
 	NUM_OF_RTW89_MAC_C2H_FUNC_WOW,
 };
-- 
2.25.1


