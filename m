Return-Path: <linux-wireless+bounces-31798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO+xLuzBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0713336C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B66A130429B5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3724CEEA;
	Fri, 13 Feb 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sFvowsdV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601525487B
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963431; cv=none; b=R+2zaDXnpR2aEEBbpjaPjOxn0BIUqZBKIzIkQy77zh2GFow+E7vD2vcSYfgjYZH4x24ci9d8H0mddrDB3kyJO6XiISeJyepPNb1fxRiHWaqdxnedhWkxBe8lH8EoQjS3F4eWO7R8QIm9KsMSveqmbu857WvnyrF3SOm08Vd4Z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963431; c=relaxed/simple;
	bh=izSIl0k4zUXdnhswU+ZDBSGiuoHeZYl29RTPuYHCJmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6YnhSpXKV6yqbj8tNqEA3Pzt/fn0JKLPrSUJVYM1gNJKdKlzL4+VzqIkOE+QnRcvLwHTo3rDijEkUlJz8XAe+MbLwKA73Z33S472PMLP+n+jFAcN7U5AYo39Hv+1QfQAlmZeoH1Hts778Sn/c4UJTRTttBEOmgxPCNAuXsacHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sFvowsdV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6H79u81418932, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963427; bh=1NNGd7Gm0q1m+TXxy4GNUCZZfF9PmcsffypKI+0Trj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sFvowsdVVI0vLR81JXyTfWQBLLrgxgwrvc+VpC87NZXXzTuSli6hDgPgIp0Pk33sN
	 Eni2pnhq/HE3sm9vIV6gXDvVaA9VE8Y7be2BunoMm3keQZU10DnEDerx/YqzJa6zHV
	 9gCsi9ZydwMArF0g82k5bo2+fYD+iPigp49oOgnlHklX1BCwNKXSULBiOWja+pwY5k
	 jgLcEE9mkaNwS9ecMX+yGETTFQ0LvUa/1fTFPiTpkZmo9dxiwK7ODFOr1AnI3bx2mJ
	 llnAiAMv3c6wVj4aSjtWi111rXS0EQoty+0wyIgem7GpFN66bPVEV1XQcQYRlThqXL
	 d349EjzbvalYg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6H79u81418932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:07 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/12] wifi: rtw89: 8852b: update supported firmware format to 2
Date: Fri, 13 Feb 2026 14:15:44 +0800
Message-ID: <20260213061552.29997-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_FROM(0.00)[bounces-31798-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 2EB0713336C
X-Rspamd-Action: no action

After firmware version 0.29.29.15, more data are included in firmware
file. Increase format to 2 to prevent old driver failed to load the new
firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b687ddaa839e..f4fb5f76298c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -13,7 +13,7 @@
 #include "rtw8852b_table.h"
 #include "txrx.h"
 
-#define RTW8852B_FW_FORMAT_MAX 1
+#define RTW8852B_FW_FORMAT_MAX 2
 #define RTW8852B_FW_BASENAME "rtw89/rtw8852b_fw"
 #define RTW8852B_MODULE_FIRMWARE \
 	RTW89_GEN_MODULE_FWNAME(RTW8852B_FW_BASENAME, RTW8852B_FW_FORMAT_MAX)
-- 
2.25.1


