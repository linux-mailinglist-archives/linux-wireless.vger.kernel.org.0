Return-Path: <linux-wireless+bounces-31805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGjwDBHCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6B13339E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF207304A20F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3912288E3;
	Fri, 13 Feb 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y1yTwQqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8C261393
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963469; cv=none; b=I5lVBJj9MfYhw76W9nxoC3Vh5xNASzf+2YQEjm4BcoVOdIVUwJ7vdzbs9iKuvzo8hvTQF9pltyLrDs+xkJbLxOIwSNe0CAxcp1I27MwqyScPXiSlM8MpgyWrFNXtVGi3HB5A94TlxjGgSV/lrEdb7MD14kyzIMI4O6n2Fv+eJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963469; c=relaxed/simple;
	bh=OV/AqSdrwRV1sgbkkMTICT1se4kcLT4jOxF6HjdlqVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMED/GLPSE7F89B3iH4AWbRLSAHPVjIh0a0GbSgsEUYhXHw0pZaG4vRbSwFq7Nm09hTHvBH3m/CKfMoN9Pe+H6Xov0uVIdKJCOikoV6P2hbIDjTc+2j9eal4jgi8R9fNfDKgZeZFbaFKMgQX7h9LNGyXTukmmditO5YtoEo/PP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y1yTwQqJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6Hj0G21419689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963465; bh=TYI76DM4LQj1SOuvaZv0OchILsSCC1q0VxG4BrV/5ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Y1yTwQqJklOd1OZ+hy1D+lCFlyC6Pa5raKFRCM7Ash/HxTdwvLxw3shb/ea64Fko3
	 1cXd8bvUNEp6nT+fHEvMF3193cDc3MbsqvaCwSAeyFWOzjJvqMs9zIAjb9CNU6dVkd
	 IREjIIOuVfnU8TK34P/nIDS5PKIFGjhzbNgVF3VP8rO7oSsSkt7DDY1xzsbfwYl+PU
	 GbI2e5PGFY02q7sJnAJaj5kV6CezvLq2hAN+FeraxAVfbOIn1RXyBQ1BpL0ZepVO4a
	 u1ph0yAVq3UdVjmXjkKNi6il5T17MaJiigk0RC1yAJC9dAg0TFCs9rOIKmsNc4hqt/
	 EPxMzuC7i9yZQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6Hj0G21419689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:45 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/12] wifi: rtw89: ser: Wi-Fi 7 reset HALT C2H after reading it
Date: Fri, 13 Feb 2026 14:15:51 +0800
Message-ID: <20260213061552.29997-12-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31805-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9EF6B13339E
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When a SER (system error recovery) interrupt happens, driver reads HALT C2H
register to get the error status via MAC. For Wi-Fi 7 chipset, driver needs
to reset HALT C2H register after reading it to make FW aware that.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4d507eccaa00..243cc02ad24e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -814,6 +814,7 @@ static bool rtw89_mac_suppress_log(struct rtw89_dev *rtwdev, u32 err)
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 err, err_scnr;
 	int ret;
 
@@ -836,11 +837,15 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 		err = MAC_AX_ERR_RXI300;
 
 	if (rtw89_mac_suppress_log(rtwdev, err))
-		return err;
+		goto bottom;
 
 	rtw89_fw_st_dbg_dump(rtwdev);
 	mac->dump_err_status(rtwdev, err);
 
+bottom:
+	if (chip->chip_gen != RTW89_CHIP_AX)
+		rtw89_write32(rtwdev, R_AX_HALT_C2H, 0);
+
 	return err;
 }
 EXPORT_SYMBOL(rtw89_mac_get_err_status);
-- 
2.25.1


