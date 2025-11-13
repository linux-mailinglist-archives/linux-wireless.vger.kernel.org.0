Return-Path: <linux-wireless+bounces-28889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C9C557D7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E735C3AF237
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D38253B73;
	Thu, 13 Nov 2025 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pTxJo9pp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FB246333
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002661; cv=none; b=XYJ99htWLhSK8z80aLHpKwNFFr3TAMlEtLIsUcGQQp3rhHgx0KOc0Es4AjXOstAYdXncNMFj7JnqBoyogPBxbb2zrDqKQ17qWatjv6BK5eM+aq/m2uwmuy0ahh8BSNivvTQO+JBzT75YFrUjdEqOLIVKgc4/Z0DZFnrp4WawC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002661; c=relaxed/simple;
	bh=FsBFmnHKez9/Awl0we39wKNnmN47DHiaD8aJ2PHbHN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggRO7WPz7IrZTrrJp+JuOQcuxlrYuwBe9Fo7TCOq34kr2+hl5bPgyWDJcsBDKORTenVYpeO9Z4iedyfc7eVBBZG/7Q4IYctXWtsknmMYG2wCLWtYZhquYuGnzo0ZEZh1KzlMSDhmt7UnGQJxyeuiwUhxYfhVSkxKsuA7sgjI39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pTxJo9pp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD2vbCC32839429, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763002657; bh=vaN2BaNxlIcE3FUcwsK+S7+3vf0Uc/ojuDp7P44EfIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pTxJo9ppvrMeRG4QUBKYoRBhfOsHgSVMSXIpsZBFFgE1JCIAgoiEEje6+dF1VFyxz
	 SfaLH9oTxPz35KfupdEURecgKXFm+nt+XUCYeZOsjhdyMRJkhqXyNNDiLKHSC9wZyU
	 rGwkICyszuVGhLT5t7uQclFEFmARV1VQ6fAUpiii0RttGGWXKwgEo2cQw3+ZXGukNI
	 EgZ/F/1i47p1HaJklmOY0NJMlvYbk5d0fE2kAJVfx20QU2WzE8ZozB7W8d74+4FKOs
	 JIVhVs/jOrIcqpbZntpaRwPjpj/tAoR2YMpdKTR4yWS9IuRcyGyefgevoTg7BE7KPk
	 wfkN6vPamJzfw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD2vbCC32839429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 10:57:37 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 10:57:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 10:57:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH rtw-next 08/14] wifi: rtw89: phy: ignore DCFO if not defined in chip_info
Date: Thu, 13 Nov 2025 10:56:14 +0800
Message-ID: <20251113025620.31086-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113025620.31086-1-pkshih@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For WiFi 7 chips, DCFO (digital carrier frequency offset) feature isn't
supported, so the corresponding registers aren't defined in chip_info.
Check and ignore this feature accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 28e2b15240a7..08eb3fa6b347 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4608,7 +4608,7 @@ static void rtw89_dcfo_comp(struct rtw89_dev *rtwdev, s32 curr_cfo)
 	s32 dcfo_comp_val;
 	int sign;
 
-	if (rtwdev->chip->chip_id == RTL8922A)
+	if (!dcfo_comp)
 		return;
 
 	if (!is_linked) {
-- 
2.25.1


