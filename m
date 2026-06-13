Return-Path: <linux-wireless+bounces-37762-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0MYFBuaNLWrVhQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37762-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 19:05:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C367F1E4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 19:05:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.s=20251104 header.b=JDZHsXl0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37762-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37762-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nthu.edu.tw (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE294300DF69
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169133DE457;
	Sat, 13 Jun 2026 17:05:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA828640C
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 17:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781370336; cv=none; b=UvqciyCbkGF0iRd1WLo1JbHmAAI51zSKIjBC1UowiIgFqt2oIjh++r/omKGCczWYomQSTTm67IczPuIZOxxcW1qzI9UwqAXah+QGByAHbAW0Ni/R97s64PRp1JwPiptMxX/sjvvC5wNPUZEBfCVuD49SFEQmRxkD+VUcnyADz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781370336; c=relaxed/simple;
	bh=HWm4Z0DHFiHXr8w7o4nMJCL4FVGIiMQAC+8C5Kb9wqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/3AL2yaH1fF9atcLJ0ZkSWfbk713r5lrT8N/gRPIGyJyEtfo0RTJPx/2JdzJl62M2PWIJVzQQryZdfzavTQEWsUoOAGqb2uFQd2ftqV5woyksNEhYEol9JA7A/E9BcgKozy64QJhATyl679HutxmUA3jaYiP0O/SMtWYicD4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gapp.nthu.edu.tw; spf=pass smtp.mailfrom=gapp.nthu.edu.tw; dkim=pass (2048-bit key) header.d=gapp-nthu-edu-tw.20251104.gappssmtp.com header.i=@gapp-nthu-edu-tw.20251104.gappssmtp.com header.b=JDZHsXl0; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304ec41197bso2381301eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20251104.gappssmtp.com; s=20251104; t=1781370328; x=1781975128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KYTT55zb15KaMqIDYI41ucnvcwX1a4IupvFYyKMMVc=;
        b=JDZHsXl0QpBtAQ46OU1laFRlCkIxPw0nrcb6NErigPYjqIB6K/b9axnSb4SJJ+pfhw
         LXa6U2Hfm8gQT2+hgg3BzZiG5QgvKGqOGM6u08xE2x4ttzmzUXXJ/Jka6EAAdy5LcoiL
         8EOG1iLbzTGV1HVo/2GQkKObgRwaxDB3vbQNI1ZF9vv/83YjbNXvZfy+2kDV5CDvS9VM
         9Dg6orVyxa3rG0IQip1nyRQFCvBLNFcixmtMZB+UfsQxEmfAW31uHTXS5R/ZarpHbJOT
         lbEQxmLu77B3A58zjXEQmx2xaIy3/KQoBbKCLUxuAh5nseqBBGa4TJUDDUG5yMspJjWC
         EBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781370328; x=1781975128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KYTT55zb15KaMqIDYI41ucnvcwX1a4IupvFYyKMMVc=;
        b=f/IkodnS4gu5sLbqf/QDvKQgmDq7bmP1yRSwUztkRfqGYqT5HNUOZqk3a3n7Fzyinp
         G9PfFAbhW/89t+tImHlRPbI+El8k1VexrblqD6VKAvCUwv7lhf6JdfQEV3NZTCB6Lu3f
         yJN3ZvG1b1ByJ8fx4xikzV3/d4DzXGlPuXcKarYEMUPaiJXa44x+q6ja/zonR8qt1oNY
         RrckV40rCIQ8mMFb6vuhMoZ1vS+VBVx8WGRHdvjIjY6fDsdHId9gjVV+Mon1qiPCqM0b
         MD3mocMZ70AnGQV5scYSN5e/LXuzEGajk1c7r7wh1aQ2tCbtVsAuon4+VIvg3lx0aqZS
         ODZQ==
X-Gm-Message-State: AOJu0YwVWFl54LCPw8viPEELgme2OIwBiGd2DThEnZ5lbJrZ/1VEv1oB
	ux96mwrofZodn1gfAXd+GtVuF62ujaafG+WeuxGoLed3OnbDctNUVlGTBJrlWMxXp/E=
X-Gm-Gg: Acq92OFJtTgrtOna+r3dOKiadOiDX1na2WAFmxlxj0hlkUzm2+G1JZurRDRqxn7gA+z
	KNDjeygWpxSlA5Bkdi4udIMrox5jnE3FFmbn8Dl3hBii1S9BGyuDsI1yFw9+hwjjFgW69K5mX1F
	4Av1CVuz5TyIOFTIMDmnBPlQ9/0Acm1NJnRi7/a92zVR+75RKQEXumxvqY22S+JL//TsgFupLbb
	TlSyKLmsFXes7TCvVxTRCjvUyE48z8iBGZ4WsmKKyQWaM7C6aaShCorps+yrOzIZAUE6Si8DIga
	u4kFRed7oisHOmm4yNt0ZNA+xAiboZLcZFljHXKJkPMtQFJcZygSTsa06yb2HfGl09swjUCiXd+
	OU5lXSrK/7OtOEuvVZIOYuceJp4xtGNkV/jaBr8LA5TZIQvuB1ym+HBkjEol3IS11wMl4I8j2+p
	3IA2T17vdliUKV33LBqUF9kWxR/T4vSrLU74xSk2fdgZ9iclXiVf7F0enzCjuyOF4JuaDb14DXY
	qFmhWlq6/ir3/WTvo1kbq6ejPoYMUaqyG22DNTSOdab7CcXdw2fDO5V6vJHzYt9
X-Received: by 2002:a05:7300:238b:b0:2f5:3fb3:4a76 with SMTP id 5a478bee46e88-3081ff73b6fmr4353302eec.10.1781370327690;
        Sat, 13 Jun 2026 10:05:27 -0700 (PDT)
Received: from tomato-cultivator-HP-ZBook-15-G6.. (2001-b400-e3f7-a850-a15b-2853-6561-a891.emome-ip6.hinet.net. [2001:b400:e3f7:a850:a15b:2853:6561:a891])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43f69sm7592277eec.20.2026.06.13.10.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:05:27 -0700 (PDT)
From: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Jung Ku <cjku@proton.me>,
	Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
Subject: [PATCH] wifi: realtek: rtw8822c: replace msleep() with fsleep() for DPK delays
Date: Sun, 14 Jun 2026 01:04:34 +0800
Message-ID: <20260613170434.23645-1-ku.loong@gapp.nthu.edu.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gapp-nthu-edu-tw.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nthu.edu.tw : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37762-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[ku.loong@gapp.nthu.edu.tw,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cjku@proton.me,m:ku.loong@gapp.nthu.edu.tw,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gapp-nthu-edu-tw.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ku.loong@gapp.nthu.edu.tw,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gapp-nthu-edu-tw.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D7C367F1E4

Replace msleep() with fsleep(), because msleep() may oversleep
to as much as 20 ms when used for a 10 ms delay.
According to the kernel documentation, fsleep() is more suitable
and aligns better with modern kernel style.

Documentation link: https://docs.kernel.org/timers/delay_sleep_functions.html

Signed-off-by: Chen Jung Ku <ku.loong@gapp.nthu.edu.tw>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 244c8026479c..b84acd4e156c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3405,7 +3405,7 @@ static u8 rtw8822c_dpk_one_shot(struct rtw_dev *rtwdev, u8 path, u8 action)
 		rtw_write32_mask(rtwdev, REG_DPD_CTL0, BIT(12), 0x1);
 		rtw_write32_mask(rtwdev, REG_DPD_CTL0, BIT(12), 0x0);
 		rtw_write32_mask(rtwdev, REG_RXSRAM_CTL, BIT_RPT_SEL, 0x0);
-		msleep(10);
+		fsleep(10000);
 		if (!check_hw_ready(rtwdev, REG_STAT_RPT, BIT(31), 0x1)) {
 			result = 1;
 			rtw_dbg(rtwdev, RTW_DBG_RFK, "[DPK] one-shot over 20ms\n");
@@ -3418,7 +3418,7 @@ static u8 rtw8822c_dpk_one_shot(struct rtw_dev *rtwdev, u8 path, u8 action)
 		dpk_cmd = rtw8822c_dpk_get_cmd(rtwdev, action, path);
 		rtw_write32(rtwdev, REG_NCTL0, dpk_cmd);
 		rtw_write32(rtwdev, REG_NCTL0, dpk_cmd + 1);
-		msleep(10);
+		fsleep(10000);
 		if (!check_hw_ready(rtwdev, 0x2d9c, 0xff, 0x55)) {
 			result = 1;
 			rtw_dbg(rtwdev, RTW_DBG_RFK, "[DPK] one-shot over 20ms\n");
-- 
2.43.0


