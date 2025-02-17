Return-Path: <linux-wireless+bounces-19030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2114FA37B3E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA37316CB66
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314B194C78;
	Mon, 17 Feb 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RRz9X27O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22658190679
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772801; cv=none; b=K1lk8qz2WUWSPS2hep43cLvOgel2S+AuOaeu7AE/F8LWk4Ko9uLPgGQozvMBHIVSulLkivkGv4HldQ4Z+9KiHATr/0qbZt5t0gdmW2TpJ3Wo4LA1eW/wdrOl79wWCmcp7duQzNDJfCnxnfOwxg8oSjn+/XMl6BsJjqKzZb8QbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772801; c=relaxed/simple;
	bh=XUvzM3ydbpVA5j5iYwqIQcouYAD8oGmjcwGYABC6Dfk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiEyCv8Jb+PJyUmoaUJPl+yfXd5pXx7llohOT6gn/b4PTXux2KDwkHmNAwwVjL2YhJxB82zqDU5XiSKIfsaDPZ9nDM+Aq3Plqjxs4x9gV0Xg3Aa63pHtSon8twC+IYvIdnGcdYL825j6VyrYj191hOglgRGSU2YD1LtqZBPzTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RRz9X27O; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6DDEW02604323, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739772793; bh=XUvzM3ydbpVA5j5iYwqIQcouYAD8oGmjcwGYABC6Dfk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=RRz9X27OtVPiG74QFDHtl7ru92tHe/h8RoYu73z7j68uA/UXKTPHtjimg5y3YQUJN
	 Bivq5ri+1PKZHZKjNORPB1Spn40TfOC8St/HNBGqzSKHg8dI6TmdUgrd2MtnN81h4z
	 uEWtjm2Gm7MQyM/uqU4JTS5eSs9OnlYPddDSHJfQFjXexOshHw4flpbf3VzQg3M9RK
	 QKHKllOhMot/mh3e6WBhIKevfx0FMVAGbBpn/Kdx6N1FtDe2IE7SWm0HWMX7Wag/2F
	 YuEehHfu11sSQjtwscrXroddPMLBWZzIrjmHeyzh3IHNFTvLKrpj5XbSLq/yjZ9cqc
	 mOGrWh6hdF4JQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6DDEW02604323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:13:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:13:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:13:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH] wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
Date: Mon, 17 Feb 2025 14:12:35 +0800
Message-ID: <20250217061235.32031-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

EHT MU PPDU contains user field of EHT-SIG field with STA-ID that
must match AID subfield in the Associate Response. Add a necessary
setting to prevent these from being inconsistent.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 35b86970db2a..6dbea18355a3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3435,9 +3435,10 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING3 |
 			      CCTLINFO_G7_W5_NOMINAL_PKT_PADDING4);
 
-	h2c->w6 = le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
+	h2c->w6 = le32_encode_bits(vif->cfg.aid, CCTLINFO_G7_W6_AID12_PAID) |
+		  le32_encode_bits(vif->type == NL80211_IFTYPE_STATION ? 1 : 0,
 				   CCTLINFO_G7_W6_ULDL);
-	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_ULDL);
+	h2c->m6 = cpu_to_le32(CCTLINFO_G7_W6_AID12_PAID | CCTLINFO_G7_W6_ULDL);
 
 	if (rtwsta_link) {
 		h2c->w8 = le32_encode_bits(link_sta->he_cap.has_he,
-- 
2.25.1


