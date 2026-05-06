Return-Path: <linux-wireless+bounces-36022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KmOC+49+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C74DAC2C
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B04B3008C24
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497832BF5A;
	Wed,  6 May 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="T7g69RZ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A923F1645
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073066; cv=none; b=D9hrwj6UCBflF1zLss71G68VbwfjTR/ipqxvtp+t9eqVteXboXuklB1gF3xT89JIY2IiGs0uzwt1R90jqeh8WA+htgIgd7Ql/Ginangma3FrdeMsTA/lOl1bxWnLo3JSpQKqzDb5P63iNDFzPV5uxkeN12JFoXuZ/B0GwKBLtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073066; c=relaxed/simple;
	bh=FOZy5+YOwVl1Tk6tJWv17Zgl9QrHyp6jSi9Iz+iQ+i0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL2g7fDEV6NZNKoHsGOOBLWKSlCr6UpCTnFP3WzQ2YxdBmqFXjoR3/nv+2t+NZaDMKIU6R69fO0xIGqOlZMNVTx50ZmwUK+l73StD3A6J+ThmCndZRjnZIjgTwC5+nvHB0rcJmMdsl6+ttCwdpKFg4vZekxhSL2yRtpUSLxQUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=T7g69RZ9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DB4NY01987184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073064; bh=BS7cS5CQFGIZc/WrXfx8y4icWeUjXNJmyQRXvOZB/RE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=T7g69RZ9Shyr5A542N6Gk9eoZRARdFdLVjo9lcD6kyHGiy1cOLdpgi/IdVfMbYpaE
	 F8jubxdWg9KljdrCjZnPXAgYW9kcJPqLi6rM72fEjAUZStDiPGOM2ioPqBF+yz2DDb
	 Bg0+mZFYNkozhnukFRhEkbqsCkSlaLq6MLWysfz/zp2zT6ESD9N//4bGjaUbHz7Bte
	 Obd+QUlnBZfxZ60DRSg+b1hdIfp4TyKF9A2mhExObENd75rSDmrxI3Bremu4s2na5m
	 6MsV74y8dBlZSYzOe8Fi9vBLry8lsABDY3Pg8IyxT+4O9G3ymFxO9/EMKJSxGUCIsY
	 cdCYu2mZPFpSQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DB4NY01987184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:11:04 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:11:03 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:11:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 12/14] wifi: rtw89: phy: skip trailing 8-byte zeros of PHY status IE for RTL8922D
Date: Wed, 6 May 2026 21:09:58 +0800
Message-ID: <20260506131000.1706298-13-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: C05C74DAC2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36022-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hardware reports a list of PHY status IE. In monitor mode, IE-09 of
PHY status is enabled, and the report contains trailing 8-byte zeros,
causing failed to parse and drop all IE information.

The 8 zeros are recognize as IE type 0, but length of type 0 must be
not 8 (reference to rtw89_phy_gen_def::physt_ie_len[0]).
Check and skip them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7e1182a49942..fddb0c822c28 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2275,6 +2275,13 @@ static int rtw89_core_rx_parse_phy_sts(struct rtw89_dev *rtwdev,
 	while (pos < end) {
 		const struct rtw89_phy_sts_iehdr *iehdr = pos;
 
+		/*
+		 * RTL8922D might reports 8 bytes zeros at end if IE09 presents.
+		 * Check and ignore the zeros.
+		 */
+		if (unlikely(phy_ppdu->ie09 && end - pos == 8 && iehdr->w0 == 0))
+			break;
+
 		ie_len = rtw89_core_get_phy_status_ie_len(rtwdev, iehdr);
 		pos += ie_len;
 		if (pos > end || ie_len == 0) {
-- 
2.25.1


