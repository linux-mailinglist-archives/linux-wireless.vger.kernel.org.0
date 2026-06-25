Return-Path: <linux-wireless+bounces-38078-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9azpLuvHPGrVrwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38078-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E306C2F40
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=KkaMI35x;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38078-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38078-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C5B3028C5D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EA2E7367;
	Thu, 25 Jun 2026 06:17:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FFB2DB7A3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:17:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368225; cv=none; b=NeOoHbH58/QX+I2ScuhF/VO9tMCvwqP1TyVlhSEt/DPnrw77VEPGSXrqfdsUf8Wq6/oIZgDbtXdqAyvPz8BcGJW45fs1/rbpKEYNhcZsDk9V/y3APv4VpSu+1BjN7UUBk3ZfcGcWUKC1OIqG6C7UOXsfSXNft8zbyEtnWyuTrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368225; c=relaxed/simple;
	bh=G+XDJGqBYPI91m8JHySUhW+avzoSgRDI73BHKfpCv/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHk3NpfixVITX2C3mZlRcy8x3orbxdi9EsvUq/bHqWtcq05iNMIt3gLkJtzAHBNexwfQhwuXJGk1exRZLigGdCbIzePQ1XKOMTO9hS2M3r5D65mnqtIivr6AhqvUPF9C+8hRXfdlT5CF9EExkezlgAhHFxdxuDo5R/w4vYcKwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KkaMI35x; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6H2GL0584397, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368222; bh=fXd/PhDyqnUD4WQTeOvHWM58NIyNzlljpnzbJBJRpmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KkaMI35xEHVAPdd5IE+Kcx+fnwLs4BfhuxZBF1LqIZEu5g6X8QMTXFr4jS6xdwwaL
	 aB7mV1pln+AQ0NhMOh9lWjd99/4ikwY8fbYEW2GtWYLJf89ofYuFLLFbRpyXL3gv0H
	 lP16dUKGih7sRuwDMTTRtmC5C+SrVddvzaC12beM7m/XbRcb+P8sHXM8ACRhs28l0N
	 OsqhmpfBp4904HWGCLUXqOCeordp6jK9jF/LpEuojalLEAY7GK4hT8BdJ79Rhz5dsX
	 m05ivGVmyTJOARrzmv7jincwAN6M9MwRPgfCqo442JYj4kCB+D+2AoGL1KDbrzN/zC
	 r4NK680boN+RQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6H2GL0584397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:17:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:17:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:16:59 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:16:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/10] wifi: rtw89: disable sniffer mode in RX filter when initialization for Wi-Fi 7 chips
Date: Thu, 25 Jun 2026 14:15:40 +0800
Message-ID: <20260625061545.44808-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625061545.44808-1-pkshih@realtek.com>
References: <20260625061545.44808-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38078-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:timlee@realtek.com,m:dian_syuan0116@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34E306C2F40

From: Chih-Kang Chang <gary.chang@realtek.com>

Sniffer mode is enabled by default in the RX filter on Wi-Fi 7 chips,
which causes all packets to be received regardless of the ADDR_CAM
lookup result. This may result in unexpected packets being received.
Therefore, disable it by default.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index d9c93adb58ee..14f1e30066e9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1333,7 +1333,7 @@ static int rx_fltr_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_FLTR_OPT, mac_idx);
 	val = B_BE_A_BC_CAM_MATCH | B_BE_A_UC_CAM_MATCH | B_BE_A_MC |
-	      B_BE_A_BC | B_BE_A_A1_MATCH | B_BE_SNIFFER_MODE |
+	      B_BE_A_BC | B_BE_A_A1_MATCH |
 	      u32_encode_bits(15, B_BE_UID_FILTER_MASK);
 	rtw89_write32(rtwdev, reg, val);
 	u32p_replace_bits(&rtwdev->hal.rx_fltr, 15, B_BE_UID_FILTER_MASK);
-- 
2.25.1


