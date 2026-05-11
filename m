Return-Path: <linux-wireless+bounces-36205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMonD3N/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:04:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F3508D47
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F0663035835
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B8310651;
	Mon, 11 May 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aeoRiWEm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5619E839
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482965; cv=none; b=I0oaao4285+nnM6LqkpCbPW59ROuruWVVYzTRkQCjVWg1NuOF8qfjwjjmk89vNW81xGo8auKLdsMUinn+lSPizsXJ2+lhqZnAo8FDgvGwa9rRZcPQZ8puUusprhtMCdDjtAMoM/7qH1Csl5jUCTJxQfqjmRy9dyOboZb46Y0VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482965; c=relaxed/simple;
	bh=5zVBi78q0HdUplIDkLVHBuWvRBysU2ID1w53jntHT/s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erwNNGXAWQuY5Or1mlBZYQwW6PPqLtuCv9JXGlWXLB9wfUrDAEiaY9O3d/O9ZWP/LFVP3td6FpFjVy3rhR0xzNNCggh9fUSCGKdchgBDciuJM6GopQd/lPRq48zDQlnrTD3TcV9hjlfY/GdbkanqitC5Fg0JabRQuQMowMQHyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aeoRiWEm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B72fSdA2540569, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482961; bh=7iUJHu9kVaa1oZhHMcVqJ9n4ypLV2U7+wdH8ntos+MQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aeoRiWEml89MODw4TReEat8tewrbbomjlbnohR7CwtqT5p+z+zQOkf7UKM7i08P9B
	 sP6SE2YIG7hvkm6uAWVNrc9mIWP9smafDariIjB/rFC5aBKLrd61lV837RKJdmf2k5
	 kM3tI/0xsQNiYJ2zjsnkWJJj12w6a+Y8G1AS/qVlH4RhldJU3ZhBvoYVADmdPzXTJk
	 3DVnsGFckCUIxnaM3MrBBbVwOiwBZ52L9h+Gcy2ujGCSbFSh/q7U0EF2mIaVfzF1q3
	 0MhfU7y9aaYG6p8UszxAh3zoA8yiRZ3pOU6P8PWJtimw8nj5kv3fuUyQts+UW+pSHD
	 7BOz/5Z8hVyjQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B72fSdA2540569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:02:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:02:41 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:02:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: phy: change order to align register order
Date: Mon, 11 May 2026 15:01:46 +0800
Message-ID: <20260511070148.25257-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511070148.25257-1-pkshih@realtek.com>
References: <20260511070148.25257-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: B65F3508D47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36205-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Change the order to align what vendor driver does.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index f8e25167b44d..23ed170f6d38 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -587,8 +587,8 @@ static void rtw89_phy_bb_wrap_force_cr_init(struct rtw89_dev *rtwdev,
 
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FORCE_LMT, mac_idx);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_LMT_ON, 0);
-	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, mac_idx);
-	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RATE_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RATE_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_FORCE_PWR_BY_RATE_EN, 0);
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_OFST_RULMT, mac_idx);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ENON, 0);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ON, 0);
@@ -596,8 +596,8 @@ static void rtw89_phy_bb_wrap_force_cr_init(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_MACID_ALL, 0);
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_COEX_CTRL, mac_idx);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_COEX_ON, 0);
-	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RATE_CTRL, mac_idx);
-	rtw89_write32_mask(rtwdev, addr, B_BE_FORCE_PWR_BY_RATE_EN, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RATE_ON, 0);
 }
 
 static void rtw89_phy_bb_wrap_ftm_init(struct rtw89_dev *rtwdev,
-- 
2.25.1


