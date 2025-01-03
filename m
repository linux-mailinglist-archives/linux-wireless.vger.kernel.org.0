Return-Path: <linux-wireless+bounces-17030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F067A00546
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D61880868
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E71946B9;
	Fri,  3 Jan 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PSCz4Lbx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38F5A79B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890292; cv=none; b=l9onbgQoefcxCwsVpUFy0XnhS2rKpN4yT5yhtHe2bLwUWamBkuOfVttfNP8oFj6GmlQPPouVX9bIj6IZTFdmpHkqbf90H2ODyDKrqc28Xv2ZihR/1v8ZPzPCwe8pg34Wg7GoPvwnBZM8KG/ZfF+CV4IWe9FRC+Xj4JIGVRBS4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890292; c=relaxed/simple;
	bh=JyTn0GwY40j4ZfTkk93Zf8CRWceFNv8WrCpnZaEjUtA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u+DzUmnMLvBnBC3iBP9vorhaZv9EC7nveche3M04LbGTu2NAUoPxjBVw+9KYf/P4auDETunFMSHFWY0jZ1cq6pDpENPtQBAv7d6XIlryz9no0JI8e//FEahtdzq6KVRI6iv6+VVG5LJgfRTOcp3txzi3myHwnum07lFMusw15xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PSCz4Lbx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5037iliE71628696, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735890287; bh=JyTn0GwY40j4ZfTkk93Zf8CRWceFNv8WrCpnZaEjUtA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=PSCz4LbxAxhDXsJyYRoAdithDxA3iGD7zedgw0j7aNN1OiNkS9qJJSGlABJsfqKXX
	 jTn9lwyLDOKsGXff9k9gZJyuzZ3ZRCe+B1TUIsTtuvP4GEeWJDrIlEcxdLu2K1x15g
	 egJkUERFrQUpXUu7a37wdm7Ux9susHdCmA0KCv6ndw8zFNYJ1anAhpipPq9QLMotaW
	 suPstSiZL+bnWzgFFArRelx6nBc+e7Ydcp0PvDZc8TeYrBUreBTY2MtjuDKDljvTbV
	 HnZkNbUqlOvhfyKjye50yG0ISWDzf8pftUNOR6snqE0qWbvjn85YgPoAg1cd91rmZw
	 9egtrayAK2jQw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5037iliE71628696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jan 2025 15:44:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 15:44:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 3 Jan
 2025 15:44:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: mcc: consider time limits not divisible by 1024
Date: Fri, 3 Jan 2025 15:44:12 +0800
Message-ID: <20250103074412.124066-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For each MCC role, time limits, including max_tob_us, max_toa_us, and
mac_dur_us, are calculated if there are NoA attributes. The relation
between these time limits is "max_dur_us = max_tob_us + max_toa_us".
Then, the unit is converted from us to TU. However, originally, each
time limit was divided by 1024 independently. It missed to consider
the cases that max_tob_us or max_toa_us is not divisible by 1024. It
causes the result breaks "max_dur (TU) = max_tob (TU) + max_toa (TU)".
Finally, when MCC calculates pattern parameters based on these kinds
of time limits, it might not perform well.

Fixes: b09df09b55fb ("wifi: rtw89: mcc: initialize start flow")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index fb9449930c40..0d12a36be4a0 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -801,7 +801,7 @@ static void rtw89_mcc_fill_role_limit(struct rtw89_dev *rtwdev,
 
 	mcc_role->limit.max_toa = max_toa_us / 1024;
 	mcc_role->limit.max_tob = max_tob_us / 1024;
-	mcc_role->limit.max_dur = max_dur_us / 1024;
+	mcc_role->limit.max_dur = mcc_role->limit.max_toa + mcc_role->limit.max_tob;
 	mcc_role->limit.enable = true;
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
-- 
2.25.1


