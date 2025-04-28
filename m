Return-Path: <linux-wireless+bounces-22131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B53A9EEFE
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C623A65D3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041E263F4B;
	Mon, 28 Apr 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ao5HYdPS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE4262FF9
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839544; cv=none; b=jDUDC9paN5d0aVUHHCq0JjHzdwru9iVEZizqnKbpcgvhdMZ9K9MBu6M5JYax3cY6nlYOleOVIB13CmFXom4+tf0/cvymPF5plCsSPWJwbF1fit4dts505pfpY2neR+hKR1aq5sJz0a9inhkiTRu2HZSJYMM8OFjoTi0wttMN9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839544; c=relaxed/simple;
	bh=TCppW+FJLCYBWyH1G94Hs+37vxlVqLpe7tlX9MRwiug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/QaMWDlZ8oVJP9076dIlXJRulYbUU5WRUpHT2Cq9QW7HZaQJgEbGF4cd6zkDWVQvlm1210XqKyPXxx1FBxN3r0RmIyz56d8I+7q7RA8/OjgNYcpEnl56+bjksvMrjNoEWKuIV+Cwg3ZoOo5KIfnltP7iQ16ASlHCmIM37qn5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ao5HYdPS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPetH62101187, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839540; bh=TCppW+FJLCYBWyH1G94Hs+37vxlVqLpe7tlX9MRwiug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ao5HYdPSU5bb0dwa68Nm0HzPiMh5dPgtrxvaY8LIGyqNvgVDFMza9j+x+eQfqZl7r
	 PaPQclw1RG6XYvITjbBipTJTcbndryVdeCOICgIlZmPXlBwzwlGFMviOYHHD3WIe3n
	 822RJpAZdztgEAIgxZClBjLSZNIDiESRbmzoWBoyGXTrImx5ePEaKDXqk5hPl1ZTRF
	 SqdEZn56wWbaUNZ7FCgBBf7MBbWyQwR+Cq48UbDhbArbiDqFs9N2lLOhwMU4Rmv4/l
	 thAeryl8cTq8aHddVv/wqAqjM1BRNF7bjy5TOzJGcvzUSiphAXFHrQ/ZMRBIPX5dH1
	 go/VQmq5YUa/g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPetH62101187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:40 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/10] wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
Date: Mon, 28 Apr 2025 19:24:47 +0800
Message-ID: <20250428112456.13165-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428112456.13165-1-pkshih@realtek.com>
References: <20250428112456.13165-1-pkshih@realtek.com>
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

The RX DCK in firmware could retry 3 times if calibration value is not
stable. Roughly each calibration can be done within 16 ms, so expect
16 * 4 (with additional 16 ms) will be enough. More, in coming MLO, it
will do calibration on two path, so multiply 2.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index cc595cae53f5..2ff847eb76fd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2071,7 +2071,8 @@ static void __rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev,
 	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
 
 	rtw89_phy_rfk_dack_and_wait(rtwdev, phy_idx, chan, 58);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, phy_idx, chan, false, 32);
+	if (!test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+		rtw89_phy_rfk_rxdck_and_wait(rtwdev, phy_idx, chan, false, 128);
 }
 
 static void rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev)
-- 
2.25.1


