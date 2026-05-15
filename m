Return-Path: <linux-wireless+bounces-36442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHLrNux6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55627548869
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 572F23060086
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3594336EDE;
	Fri, 15 May 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AJutRLuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B22C08AB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809500; cv=none; b=tdgM/M3jeBq7aI43DBm3Y+tI8+wZ/zyUS1Lth1S9Tt2SXveXU4JhGwglaPCqYgtgexDNdSn40QAAtYzUM6ywtLelOCZdzhL9Nm/IsWsskYP09+zAsYALz2wGpqoukDc2jwfCCgvYn9AHFgPr63ibKnbt0FUozEHMckryOWild/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809500; c=relaxed/simple;
	bh=36Wmx7E3cBjQ9Y13w2n6R1hp4c43nlvU7k9Q13Uw7yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry553P0Uew2iC6FBmLRXwg6hpbWJu09qXxHhdHV+8ECX/e+BzWXrTkz55o+hzaURYxtFx2vti8pf1P3X0sx+kKGsTxUz4xu4oXOpc6vBkueZgaKOA+U2ekVvFjTmKxw1oDEc1/5kBzvEtN6kgIVEgqStnXkaGodYNSGeNK9YAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AJutRLuQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1ivJxB2587096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809497; bh=Jwmvc3nUelzO+ngeFl9DPgG9YTTRH4amos6bALtmtXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AJutRLuQvj1qlqCyBbBMWRUXgFe+ZPk6WTRHfuI8GbUtGFBBXHb2kYTNyek5RRRhP
	 pwNOZzRgLLGSIg+DeV0qmSRGioJZ5YNpTCG6xKckzRdf3cAjLp661AfdyqhT3YoaV1
	 22lEF1Cy0klH950izfKj7znQWfOk95juurwtnMnUFqbNRmd6Ss/kBJvQiWocv2QQG5
	 jf0RfLBD0hkj8YT+4YPCT753yTNS1LCFraCM1YtbHP16Ep+k6D8YYWvcGU9LteHQ7O
	 wSdZdZGhOO4NkppvBDH3selH+ueQAb+1Dok7lEEgQSp5hL1VUuJE2pQapyoqXKr4/S
	 BG/tAFVHvP5qQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1ivJxB2587096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:44:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:44:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:44:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/13] wifi: rtw89: fw: dump status of H2C command and C2H event for SER
Date: Fri, 15 May 2026 09:44:23 +0800
Message-ID: <20260515014433.16168-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 55627548869
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36442-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When SER (system error recovery) happens, there may be some handshake
between FW and SW, e.g. SER Level 1. These handshake are based on H2C
commands and C2H events. Dump the status of them to enhance SER debug.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c5a598a507f4..29d8d13d11fe 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8293,6 +8293,12 @@ void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev)
 	rtw89_info(rtwdev, "FW MISC = 0x%x\n", rtw89_read32(rtwdev, R_AX_UDM3));
 	rtw89_info(rtwdev, "R_AX_HALT_C2H = 0x%x\n",
 		   rtw89_read32(rtwdev, R_AX_HALT_C2H));
+	rtw89_info(rtwdev, "R_AX_HALT_C2H_CTRL = 0x%x\n",
+		   rtw89_read32(rtwdev, R_AX_HALT_C2H_CTRL));
+	rtw89_info(rtwdev, "R_AX_HALT_H2C = 0x%x\n",
+		   rtw89_read32(rtwdev, R_AX_HALT_H2C));
+	rtw89_info(rtwdev, "R_AX_HALT_H2C_CTRL = 0x%x\n",
+		   rtw89_read32(rtwdev, R_AX_HALT_H2C_CTRL));
 	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO = 0x%x\n",
 		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
 
-- 
2.25.1


