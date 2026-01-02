Return-Path: <linux-wireless+bounces-30277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCBCEDF38
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 988A23000908
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6423126D7;
	Fri,  2 Jan 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bqN1HnVG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA311C17
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337796; cv=none; b=KKFfHXkyUou0YsF8ghaVVubBViczOemNG6x+JTZC76aa3UKL7+OiaSfYQnOnlw2g6BDjO5QNQqTM8cSnPIfmgz4zoSXPqGUphhzbGVFI9+vsPenWwvhQ3DvwUyWPAtT8obWrs5w3LG/VXv4mFlkm+4z7YIjGrYItavn0aTP6mdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337796; c=relaxed/simple;
	bh=MJzc5PJL9HME0zXQT5y9cF3qkIKdYdAa8QLGvPzBHLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYZTQ8VBWizJIYdrJbMZC0vGc3jXOP6+E8+e2Ezd3xvRiTLmZJ63q0+CCRLa7VkSfAZzePkdek0xI6Y+N2hshyeWSnceTVtni8iyJPaoW6dC0MWVCfxC0gDAsiOVqznyHMW5bfpZuWvBDjMgvc6M9yEqYLFlf8ws+QZ1yC8mUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bqN1HnVG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60279q4tA487117, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337792; bh=XTGlWEBwWM2NFajN4g5jraxPz4tBIchKNHu6/Xi68rI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bqN1HnVGWszP6UR3+jqp3o3FUoyWjmb1ShwA1sDETHTs6PXpzGtoPGTczMIQ+1B3Y
	 cNzVDgYqYFpv3UQolAp72GDbo3oKnYH9TJN9exWhwZvovQWlc+e+KXkBUgEcyc3nI0
	 kdh+8thl1D39J3plbPBvhFWg3vtFk9QPdZCWOS3N5X37WfHeQpnXT6XqHCFPw30S24
	 rUQ9aQ0hAe3Gm7fQ31nJyvaAU9kZ19+azJ6w9BDxRfkWsGwQ7Eq/TrAR+hjqajUWNO
	 OU3C2vVWfOW2U/D65zWEf0grlLQnO/mlCrjGeISeCwImxjTgY3WpAVtrejqU03GSVy
	 NBb1fj9v6ixig==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60279q4tA487117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 10/10] wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips only
Date: Fri, 2 Jan 2026 15:08:40 +0800
Message-ID: <20260102070840.62047-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102070840.62047-1-pkshih@realtek.com>
References: <20260102070840.62047-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RACK is to ask firmware send received ACK to driver when a H2C command
is received. This is necessary for WiFi 6 chips only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3624a0b617e4..9fd7ecd34ffd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1503,11 +1503,12 @@ void rtw89_h2c_pkt_set_hdr(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			   u8 type, u8 cat, u8 class, u8 func,
 			   bool rack, bool dack, u32 len)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct fwcmd_hdr *hdr;
 
 	hdr = (struct fwcmd_hdr *)skb_push(skb, 8);
 
-	if (!(rtwdev->fw.h2c_seq % 4))
+	if (chip->chip_gen == RTW89_CHIP_AX && !(rtwdev->fw.h2c_seq % 4))
 		rack = true;
 	hdr->hdr0 = cpu_to_le32(FIELD_PREP(H2C_HDR_DEL_TYPE, type) |
 				FIELD_PREP(H2C_HDR_CAT, cat) |
-- 
2.25.1


