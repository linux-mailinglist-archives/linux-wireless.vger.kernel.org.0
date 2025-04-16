Return-Path: <linux-wireless+bounces-21596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA95A8B309
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5991F5A1652
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511722DF80;
	Wed, 16 Apr 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EcUOz9l1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555122FE05
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791209; cv=none; b=PNIechGNkQIq8UXYlMIWdGePtZshHKh5hX8ek6fLtPgVP1W9r36BukThio4SsFXnk3hm6c+cpKGpglsBZt2VAp4HKWriFkmByaxodZRIjqr/pVjlXFIhhXA1qgTsqEMmIIlW/N+e+sNBLV/5W27Lld3fQUFh1y9Yv7Tcaxy0Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791209; c=relaxed/simple;
	bh=5WnhDchFQeIMrIyFrr/y2nJArm9CdgFD4U/rkenDEIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOMxBFFnd3wNvzG3y72ShiyjHS1BSP+k0gZmxL5btPc+OdBfUlRpAM0lRw0SczWDd1LWlsoozObRhZnGHRj0O6LTqDH20li65KRjnz1iX10RJEx1Lx+3T/xzxFozu7UR/L0gi/fSnmAavrgqaodo5VGw7PVu5GEpI40owiz9gZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EcUOz9l1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8DJVo82935257, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744791199; bh=5WnhDchFQeIMrIyFrr/y2nJArm9CdgFD4U/rkenDEIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EcUOz9l1Hkv5wLNqVg+9TDpx7/G5F4D2skiTCBlKrwJWGtKxHIIHhWZPySvzW2w3t
	 QP58okzgf3QzfAhjyO07jpbND0ANUHWErTYE3X7iIX9hXwRHwlMOXesuDVA/liB0/l
	 1IrOPhu7paEHLziHvBVkMmMXcjqySIYajB5STXemEjQxizqgZI3z+7yc8SKf11neug
	 uR0/kNVoTYNKI9hXJqA+jdlDRCikJBKKlMLNJRc1XOThw2TZCBbVnsbI6nnmtKbjTR
	 +L3A/O6sD7o4JJoKdfeiX2kb4QmDdzT6Yfh5kC8EwMdAWqXHVH6MdOxqrqNIcRWKCK
	 hLReoFwfrvfGA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8DJVo82935257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:13:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:13:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 16:13:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/4] wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
Date: Wed, 16 Apr 2025 16:12:39 +0800
Message-ID: <20250416081241.36138-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250416081241.36138-1-pkshih@realtek.com>
References: <20250416081241.36138-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

An incorrect Voltage Controlled Oscillator (VCO) setting
may cause Synthesizer (SYN) unlock, which may lead to a
failure in the TX authentication request.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index c4c93f836a2f..1659ea64ade1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -77,11 +77,6 @@ void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 					     RR_CFGCH_BAND0 | RR_CFGCH_CH);
 			rf_reg[path][i] |= u32_encode_bits(central_ch, RR_CFGCH_CH);
 
-			if (band == RTW89_BAND_2G)
-				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x0);
-			else
-				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x1);
-
 			switch (band) {
 			case RTW89_BAND_2G:
 			default:
-- 
2.25.1


