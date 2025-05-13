Return-Path: <linux-wireless+bounces-22912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57859AB5536
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBC84A3F51
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFF28CF5F;
	Tue, 13 May 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bhicCeSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA6286439
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140745; cv=none; b=MDjlD+lQsa9gMBNZ95glZF/6HEXD2K9DIFs8qJ3IsisEd1MUwIY93hhCLDSBTdYilHypHv1t0aG1SRdzExFaItR0njtt9q+ONjTjNVWpcUwYipRB337Hn3OAmoDDu/9o/kJQW4RM4BeVXkcb/7JH0L2+TI4vcRvtFsD2nbuB38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140745; c=relaxed/simple;
	bh=eTBefvjCzkUyPkzru3hBKqHAD1XCpvteKf0aI2ap1FQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dw3BD+a1jhikJJeohY9fVXIpzE9+rtYkyKnWtlXjG7zBGjsz22Sl5EsVjseikzYZB1NT7wvSXk6ZWoFZy7piubCf5ZRkSBTrVx+Ikw856faDF408xUU9+JQYmw2eEFe6LhcsYAfAMA1hgVyco79MDQNSuw/qseEsT2wZbjkFPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bhicCeSY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54DCqHhdD071421, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747140738; bh=eTBefvjCzkUyPkzru3hBKqHAD1XCpvteKf0aI2ap1FQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=bhicCeSYcY/w8O1vW6w107gsl3RuGDwwAW1nfsosjKgvOX/TiK0VvNINWQwQqv3ta
	 7fWZNpBPySdDEzhH/4NDBYbDMBnXl4kicmUQIuszVU5FFHJl0HoJl+EAzelBbzmDvC
	 n3PIB857qNVfahx0LoGc26es2Vu//orSRlHlyrZ8sao9oAHXWLXKG4SMPJjwvqk5L3
	 RRRQ8mSdQJWsFlge2/XWPBF7LFYjvvRc3izZsPpt9zvfMmb9+66HALHZivWmkyQKhJ
	 5bEIW7CnVX+dnWvSpluZb5VDIxhxc1DgMY8IiwaKAi2Ajsf/ypcdE6qAaM4YTD4QnI
	 HaF/yf/rOZ1vw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54DCqHhdD071421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 20:52:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 20:52:18 +0800
Received: from [127.0.1.1] (10.22.226.127) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 13 May
 2025 20:52:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips
Date: Tue, 13 May 2025 20:52:03 +0800
Message-ID: <20250513125203.6858-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The scan delay unit of firmware command for WiFi 6 chips is
microsecond, but is wrong set now and lead to abnormal work
for net-detect. Correct the unit to avoid the error.

Fixes: e99dd80c8a18 ("wifi: rtw89: wow: add delay option for net-detect")
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 76350351dfb2..75e5112f519a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5537,7 +5537,7 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
-#define RTW89_SCAN_DELAY_TSF_UNIT 104800
+#define RTW89_SCAN_DELAY_TSF_UNIT 1000000
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *option,
 				 struct rtw89_vif_link *rtwvif_link,
-- 
2.25.1


