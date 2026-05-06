Return-Path: <linux-wireless+bounces-36021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG35Hug9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D224DAC1D
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E3630082A1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9E3EF65D;
	Wed,  6 May 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FBjxhKbI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD932BF5A
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073061; cv=none; b=Vmn0bb5rGyc8289+m8ggcg9jesu1uh5R5JdoytfwfhyG9en6iAinn7OazkMf2vzmbM++MPqpw5FTce690kjMFOqAXBzBI3JU/GpLzZrfmeQM3MBPuhD7jdGdzWD7z+vDQlD5nIKV3sIDd7NMiqcW2QQQLrjlOYqHaMgFeFWsqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073061; c=relaxed/simple;
	bh=vBsYG4W5vaAzsSbUsyeskV0DXPeOCW/kLlpmeJXjc6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNs5oT7zhJGib50DBMIJqBr/Xz2E4MM6ShQ32Z/v0xV6ezC1lyI+45yq4iDtYMtYTAnwkstahXgTHhD3rgm+OOniTpyQdJnwMalOk3IwoGRVREqpir/cjKv39zIEVRuyq8q6c/Iv008oF+kV5a2g12JDRRhGBBeP1kue16xymGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FBjxhKbI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAwNK21987161, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073059; bh=OLI5a0kwu3+ssS4oZLdlq4Kru8qqvuP3o4c6gHXeS0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FBjxhKbIoTcHMGYae4eIKo6IRdFNarkJpGayT5o/yh7eBkBoApesH9maPIQFQ0RiM
	 kfqaGV4iWImkTOhqDvkuhHCN2qK+brQHER5rS1mxBuaAGhYAvH7134L/1OOdTv7a5a
	 IE2cWVnx01Ul9C1KcwCDo+JCQm7RLh4DVLve1irntwuKLeBbH1O7yc2Ywe6iZbiB+P
	 6ZU+mdhbChEGR2GFEwKgFcX8K1V5V7U7KKwWlCr6UAxRK4oJ+bq1mSM8gZbzl7m2+5
	 j2afBVidUldWXFMn8ZymTP9dwxBRXPptLGXvRrjIijcLWes63l+/eQi2R+kr1u/I2b
	 wUX308qOYv6Ow==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAwNK21987161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:59 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:58 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 11/14] wifi: rtw89: phy: check length before parsing PHY status IE
Date: Wed, 6 May 2026 21:09:57 +0800
Message-ID: <20260506131000.1706298-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: F1D224DAC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36021-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hardware might report PHY status IE with unexpected length, and parser
might access out of range. Check the length ahead.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7fa479ce52e2..7e1182a49942 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2276,7 +2276,6 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 		const struct rtw89_phy_sts_iehdr *iehdr = pos;
 
 		ie_len = rtw89_core_get_phy_status_ie_len(rtwdev, iehdr);
-		rtw89_core_process_phy_status_ie(rtwdev, iehdr, phy_ppdu);
 		pos += ie_len;
 		if (pos > end || ie_len == 0) {
 			/* clear pointers to prevent accessing out of IE */
@@ -2285,8 +2284,11 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "phy status parse failed\n");
+
 			return -EINVAL;
 		}
+
+		rtw89_core_process_phy_status_ie(rtwdev, iehdr, phy_ppdu);
 	}
 
 	rtw89_chip_convert_rpl_to_rssi(rtwdev, phy_ppdu);
-- 
2.25.1


