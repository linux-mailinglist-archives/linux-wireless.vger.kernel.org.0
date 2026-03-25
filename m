Return-Path: <linux-wireless+bounces-33815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIZKAD2Ow2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:26:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD4320AC0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106503108EF7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23C175A8A;
	Wed, 25 Mar 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c+4oc9wX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBE36492E
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423357; cv=none; b=Btvbb40jxdC5BuJnvvvKqO7giwJJF9mloTyqxrJtvGGMLYZr99DQoBl2v05KIjiIhUmDcChD4E97kVhfjQp3vccAHdrkHMZLKp/QJFrIgprHY2DApj5FbzMdIQjswMhllE0+mhacC4mQCg9d1AaXWubY6c2WEIptueXi94PXeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423357; c=relaxed/simple;
	bh=g8WFM2XYWBli+6roPq7z7hf7s8B+lyJiHIX/SXrF+3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS5IFDK1jDPWtTz2/gHgAJS458smzlwjrRnOnD0YDi0l/YBI1hkdYipcP9x4vMn5ly0FKCaPC84hkFR3R0/ECM8IsZm4cJhmRhjFO8m0ZCinoblhMhQRTgI+0GSuYZKQIegVb9JLL0vaPkQE9NZnXie2TU4+bG72SJ/KfMLtH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c+4oc9wX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7MX6G02939484, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423353; bh=T2ilrPUrsaJeX9yM7vkANMYlfMGz0/+fWQWfktZrDH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=c+4oc9wXZgKGLltxJLjslrp6DuBRTvNOebxA+Gq9MCQcOlvDXKHW3GxLYXL5MaBZF
	 loB84x32wnz7+GPbN7N8vSgG6oEIPzrc5Xf6Uw1ccmklAfjxd/U3667c0QcbmBmCwZ
	 rgD3QOT8A/wU67sFg/djXbHfupfdjUf9ymPTfhUN0ECrD+wt0sqo3trUk9C5pS+prq
	 oq3tYQklmqMOADglbJ7ayVsxeFlV2inybyObPjaicRdejlGX0ppPDBcjkeOkB85e4V
	 +FxhOgRqWaFL1PsyLPjm3m0onfyOKvy66xhUNO7h6jJ6GYL3ldycOyqw302Le1krMe
	 x0SGxNRrV/TRQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7MX6G02939484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:33 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Mar 2026 15:22:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:22:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 6/8] wifi: rtw89: phy: expand PHY page for RTL8922D
Date: Wed, 25 Mar 2026 15:21:28 +0800
Message-ID: <20260325072130.41751-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33815-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8EAD4320AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Huang <echuang@realtek.com>

PHY page range is to define offset from PHY0 to PHY1, and RTL8922D
needs to expand page to 0x2E0.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 08fd24a55d85..929fac1b10d2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -199,7 +199,7 @@ static u32 rtw89_phy0_phy1_offset_be_v1(struct rtw89_dev *rtwdev, u32 addr)
 	    (phy_page >= 0x240 && phy_page <= 0x24f) ||
 	    (phy_page >= 0x260 && phy_page <= 0x26f) ||
 	    (phy_page >= 0x2C0 && phy_page <= 0x2C9) ||
-	    (phy_page >= 0x2E4 && phy_page <= 0x2E8) ||
+	    (phy_page >= 0x2E0 && phy_page <= 0x2E8) ||
 	    phy_page == 0x2EE)
 		ofst = 0x1000;
 	else
-- 
2.25.1


