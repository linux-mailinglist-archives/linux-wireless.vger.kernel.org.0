Return-Path: <linux-wireless+bounces-30391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409CCF6957
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83B3030F1C6B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29023B63C;
	Tue,  6 Jan 2026 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Jb7lCmFj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD698145B3E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669034; cv=none; b=gcXLA/szlBqZOvqXiOC0tTtI7RSXAVc4Tsb7L1kCIsxZa7I46hwMU23bLHl0hjRcwPIpGSIeyHSk0V91U2mESHSYiwM8Z9juzF04E08jqeKAxXASzBGD6o+WTbzY5LuIVgr6KdqTH0Qn46NTjL75hdUR5fKySSxfh5Vt8nAXLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669034; c=relaxed/simple;
	bh=MJzc5PJL9HME0zXQT5y9cF3qkIKdYdAa8QLGvPzBHLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfeQDSH8284IkKm5WwJWLFRZSYjX20IDg4rPAT/3P4pco6NovPBCFYwSfS4Tdf9pRH7QiVdQvosf4qbqlab7sywQX0ltlZ4NwJ955aGVMav5C6Y4loUa9sd1vh+b8DhYY3uuUXIXLe7kz7m5RinuMUXYYNEqff2yQzzo8/VqTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Jb7lCmFj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6063ARPJ04169376, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767669027; bh=XTGlWEBwWM2NFajN4g5jraxPz4tBIchKNHu6/Xi68rI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Jb7lCmFjqFtAqe4CeQVu2LzGP3bPbnwsI1HGlODrydft3rJAg7oKZB4xBqAjlTQaN
	 tvhri9RkdCwr0+xAk5oWJiHM13FSQWD1CGN5ccBI8YsQ7vjtJBLzWhHp+qeMnAIfYt
	 9AmCM9DocVbwToYyLAJYEs+c6LmAw5t4RB7YqS8SK2A96vex0ZJ2H6LIEInz9tb3Q/
	 UDtjm7eNUUpyKvkF5l83anlTMr14HynHfRpv32Urx6P0fpngHH2dsm1WliGN6VO9ND
	 hHi0zBvIzh9/2k02IJYHI9texVG2gFqxjoyMcwseMCGiOwPRewN4dyHKavABSJnypE
	 +2sDM4wOvrrSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6063ARPJ04169376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:10:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:27 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:27 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:10:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 10/10] wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips only
Date: Tue, 6 Jan 2026 11:09:11 +0800
Message-ID: <20260106030911.15528-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106030911.15528-1-pkshih@realtek.com>
References: <20260106030911.15528-1-pkshih@realtek.com>
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


