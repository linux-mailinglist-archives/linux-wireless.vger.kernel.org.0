Return-Path: <linux-wireless+bounces-31801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD2JNwDCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 134AA133381
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3718F302C16D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF76A2288E3;
	Fri, 13 Feb 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M9Aow5vf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CA1DA62E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963446; cv=none; b=MyI93BHxcL4HmyXpneTbB1nD9HMd4RaoeujE0eJKVuRWfAog2yn4zN4Kuk9B9TeqWjScvjfkAwG47pEPwYTCiXkyaVAcHr1cFxPu8YbmZxIcVxLl8+sic7aPRvvUCgI+9loau/SHfGA3wA1U9nskmd50RssFxRjVZrCDYpIAkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963446; c=relaxed/simple;
	bh=CTNZLNiAkjU1iGdJTLroPiGaLyS6ug92Y7t5RoPL4BQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi0lW1Z4hefjj3z70Uym5nXIbq/LSBULsjadLSvGZxA3hyC6ans89RTFcZdyyv3TMUn+nEbB8GiKHV3fApXM7ZVIAK5mDppCW8QO0hbImNJ3pQmooQZeopF7mFJVPwnR0A+vZYiDeCmPvohAvR1MDZlmsEOw9MnNAu4K6h2FwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M9Aow5vf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HNppC1419653, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963443; bh=N2HqYslaG2TDNDH/Gri8Tfcd9GbJzm52MdWxaLJNMaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=M9Aow5vfJ/sifeMB6DK9o3PvL/pJw1gNAALGr4n+wdnybSP3D1MkEMNzE7ykR1DRC
	 qQjjSZRPaEpvHSgII80hkEoii4/gVXEBIlfJt7uIiR7o99CNO1i+3xxHbwz7he6XSA
	 aD1d0+Pdy0BNioV2KRKUYpYp5fKb6Fd8lLt5KDqm1byXnWhcZZBAkTKbgvHkJZaCr2
	 rkgzyVFmaaDNvHFnFS+WDglZgbhJdUR13Zd5WZ2+FhbIl6t+8yWChG/Z//fEOffv2u
	 pNVTcBe2hAUFYKB0My52kjSPWIzWHU49BcLKFmAFPgSuEChze8WfWpRArbmNYrZ7m3
	 KV3TNF2cYqDBA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HNppC1419653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:23 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/12] wifi: rtw89: 8851b: update supported firmware format to 1
Date: Fri, 13 Feb 2026 14:15:47 +0800
Message-ID: <20260213061552.29997-8-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_FROM(0.00)[bounces-31801-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 134AA133381
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

More data will be included in Firmware file and loaded via FW elements.
Increase RTL8851B FW format to 1 to prevent old driver from failing to
recognize FW with FW elements.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 0ea125ef21fa..a0769cdd2352 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -15,7 +15,7 @@
 #include "txrx.h"
 #include "util.h"
 
-#define RTW8851B_FW_FORMAT_MAX 0
+#define RTW8851B_FW_FORMAT_MAX 1
 #define RTW8851B_FW_BASENAME "rtw89/rtw8851b_fw"
 #define RTW8851B_MODULE_FIRMWARE \
 	RTW89_GEN_MODULE_FWNAME(RTW8851B_FW_BASENAME, RTW8851B_FW_FORMAT_MAX)
-- 
2.25.1


