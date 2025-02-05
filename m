Return-Path: <linux-wireless+bounces-18484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86691A28159
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F392163B02
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1734545;
	Wed,  5 Feb 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rz58JNtX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF213E91
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719203; cv=none; b=E/eNbZN/8fkVhUAjIQ0xK4zN/BbdKE4+sBpp3+v97zit9D+A9jS8j8lNZNOcqUy+gy7sHJuLOOWguN2iw15QixDdjd8vujWZfTKP2y4N8R6lol20RKNOA/ljF7kHcbKh5ZIyDaN4OXGKGXz0SVvKey6O2Gyu3I1KQXV/nHyrAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719203; c=relaxed/simple;
	bh=OamDtNA5+YG4uHeaW5h9Oa/DBkdeUy2pBdSuEkTgdKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fr8utrzPlrWoatQ9k0lozEbubK1OfmyQvKXxO2B5LL1TSqVDNFDlVq156NUHgKHIZShkJXAGOFX94tadKPLPE8Vfeg+MXD65XRKqVfEUPJ0qlBjI5kuSh9s/14LHwMoVYuV9b/S5N8TibRlJSsTv3NuFXY1W7tJL7Kp0eCoPN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rz58JNtX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5151XIl74761261, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738719198; bh=OamDtNA5+YG4uHeaW5h9Oa/DBkdeUy2pBdSuEkTgdKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rz58JNtXJggUtnOhpsu2HN//zkqqVd9n6cArED7GJO48z5EBrL4kEspOAHnKBI2PQ
	 cbDrb9SwsevPYdRf87lL/Ftg71A8bNtszKl62fDEiwp1Ea4Q0Mi68nhvwpnA+my7XH
	 oEgV46argxetfwBNRERHHHn7DTVvkVilVl3U5V14mIFrIf4B4IC0ycWE4vcbwY9ZPi
	 ohMuYhnbHolrNpXwT3sdMI5eMchH3erZJm8apdmOrWQ4mlyC1vWojkyOkYcKnAplRm
	 ZkAfPw3jKKpOFwN0J2yM30huiROvFRGgG17HqFYgD76PE5CTxc5QSw+zU+/9C63oEd
	 OAgt4RyoVtcFQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5151XIl74761261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 09:33:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 09:33:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 5 Feb
 2025 09:33:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/3] wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3
Date: Wed, 5 Feb 2025 09:32:33 +0800
Message-ID: <20250205013233.10945-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205013233.10945-1-pkshih@realtek.com>
References: <20250205013233.10945-1-pkshih@realtek.com>
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

Refine the TWS Bluetooth related coexistence mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 28d29fa17316..858ff0cd1a23 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -10,7 +10,7 @@
 #include "ps.h"
 #include "reg.h"
 
-#define RTW89_COEX_VERSION 0x07000213
+#define RTW89_COEX_VERSION 0x07000313
 #define FCXDEF_STEP 50 /* MUST <= FCXMAX_STEP and match with wl fw*/
 #define BTC_E2G_LIMIT_DEF 80
 
-- 
2.25.1


