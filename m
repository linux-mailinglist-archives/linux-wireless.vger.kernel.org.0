Return-Path: <linux-wireless+bounces-18283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FBA25314
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD0A3A30E9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7B1C462D;
	Mon,  3 Feb 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EIb3QucS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DF1F4723
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567808; cv=none; b=IUhtqPzNknj5/WzN2yAakyYJR/inDN5DkIrcuDSNKk2xU/eQ1dl20vwxgthsMdWP1l9Jip4gX2xY6N1MmHIKwzTo3zx8O7UbKwSyptHZOp6psXgmLBisvPAG+8MJRv6+/PtIpYlTdD1FWbd/rWKnMSPI06GFEYFFFhJey2RByfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567808; c=relaxed/simple;
	bh=EyvjFGm/fyqwDNRUVHVF9IjZ8RH3WbflF1SE/X2R3tQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0veqkpsqWvaXXE322OeQUzd3/O8/J/bmSc6fl/FOWcYjXIher5JWIjskqipH1diNwGbtIqnVlVYu2HjWj8RJkSSa3CoP3ux3/8KDUZFGcnLISJafrnDyL4/l9u7UNLITdDQWY4yK8EcB1w0vIKPkMH8KYfTODrdnCiA2oDS1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EIb3QucS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5137U4Y801321574, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738567805; bh=EyvjFGm/fyqwDNRUVHVF9IjZ8RH3WbflF1SE/X2R3tQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EIb3QucSd+rutkXe6SEmjay8GsCDt+lIyGDh3jOmjFXf8rQOkq/UwC0kUlsnDI4Op
	 bK9qAxwdHeOn4TpFwANKzpgBOcoVHBYsS+rRdp4zm9lqvBffb1G+OVMv96DaHwZJWh
	 CBggeMWOf8cLVzV+XaMwfkcA5InYlCN1tcRj+M3q3WrF30tJCGcrHwlwqKCF3ehZld
	 iAPhMqaEWeURTypL0aBQh54wjm//9PSWig1Nx5hsJ5jaFZc1cQfVB27fbCXakwbWs0
	 ohGOf1NHbvvHKNXYoqmOMrV5jJWgOoVG91GJNg7uJ7qaOgZaSfVhQfp39dtGMuW8++
	 QBEM7RvY6nXPQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5137U4Y801321574
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:30:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 15:30:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 15:30:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: fw: validate multi-firmware header before getting its size
Date: Mon, 3 Feb 2025 15:29:11 +0800
Message-ID: <20250203072911.47313-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203072911.47313-1-pkshih@realtek.com>
References: <20250203072911.47313-1-pkshih@realtek.com>
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

To access firmware elements appended after multi-firmware, add its size
as offset to get start address of firmware elements.

         +-----+-------+------+---------+--------------+ --
         | sig | fw_nr | rsvd | version | reserved     |   \
         +---------------------------------------------+   |
 fw 0    | cv | type | mp | rsvd | shift | size | rsvd |   |
         +---------------------------------------------+   |
 fw 1    | cv | type | mp | rsvd | shift | size | rsvd |   |
         +---------------------------------------------+   |
 fw N-1  |                  ...                        |   |
         +=============================================+   | mfw size
         |               fw 0 content                  |   |
         +=============================================+   |
         |               fw 1 content                  |   |
         +=============================================+   |
         |                  ...                        |   |
         +=============================================+   |
         |               fw N -1 content               |   |
         +=============================================+ --/
         |             fw element TLV X                |
         +=============================================+
         |             fw element TLV Y                |
         +=============================================+
         |             fw element TLV Z                |
         +=============================================+

To avoid Coverity warning when getting mfw size, validate it header ahead.

Addresses-Coverity-ID: 1544385 ("Untrusted array index read")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 68e80e54ab5f..35b86970db2a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -586,12 +586,17 @@ static u32 rtw89_mfw_get_size(struct rtw89_dev *rtwdev)
 		(const struct rtw89_mfw_hdr *)firmware->data;
 	const struct rtw89_mfw_info *mfw_info;
 	u32 size;
+	int ret;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
 		rtw89_warn(rtwdev, "not mfw format\n");
 		return 0;
 	}
 
+	ret = rtw89_mfw_validate_hdr(rtwdev, firmware, mfw_hdr);
+	if (ret)
+		return ret;
+
 	mfw_info = &mfw_hdr->info[mfw_hdr->fw_nr - 1];
 	size = le32_to_cpu(mfw_info->shift) + le32_to_cpu(mfw_info->size);
 
-- 
2.25.1


