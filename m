Return-Path: <linux-wireless+bounces-16926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359209FEBF6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 01:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFA916203E
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720053D64;
	Tue, 31 Dec 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wGX4xDLd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1BC2FB
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735606141; cv=none; b=oLTGL5awGzWznGHQnRQ1To0+hG0EGQTPO+jMZXNLab0K5TGCSi1nBZtnRWDehuBwis5/OySGWLI5Wvi3wwKVFvfLkDHuHmTmS1fmazcEk3IlHCmoejDUESftWw+sNKKpqctX9xTHczSkw2he4k6pkmduX1h7dyJAY+KgeF7jgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735606141; c=relaxed/simple;
	bh=bG+BG8cTAb0oIPODsDlNQkojDrFaiVDB4MGJFMtAU3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKg0Mxhv5Z1/mynqYdouigkK6nrsNGBcxA5siTHyvz1sVOMC5n8j0MMXpW0c+ck6yyUSLE9uU/+0NrN4OZ7WbiKl+16obIDfJBdcr92rrXZha+/PY3y0iCpSKJ9zHvdCM4aCn9t3qEuEi1W0T4Usa+qxFgtNYwX6QZVufb1sLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wGX4xDLd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV0muhL7791453, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735606136; bh=bG+BG8cTAb0oIPODsDlNQkojDrFaiVDB4MGJFMtAU3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wGX4xDLdsah0yw/GMDxxqOs5eOO+VxB+sMVrtR1wj4m60bNZohNTyxGwCKROA9dKT
	 3CYmlkYOpTAhnyw0+02Wl4jtTdk4BY9s8zVxbY8jJQl+qDniopRL7jHrK94WbS13KQ
	 GMNdBDc9Uo2FiyikOAf5f0+9GNHC9uSdG7a/0GwTcMp0cAHAzEC7K6psP1L5ekVHGN
	 X2jpE0nioLSM59I5m4rQXHAnjXmnPw2mmZQU2ukpgOL95m5N/WSEL8H6Keu83Bj6dd
	 He/c7f638H6dHmyt5QAtVUQhbmsrVNgpshoCMSJwDPVAN9bnxEfQ3XFEGRt66FYyQd
	 7x+Lkb3R9kHDQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV0muhL7791453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 08:48:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 08:48:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 31 Dec
 2024 08:48:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/3] wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
Date: Tue, 31 Dec 2024 08:48:09 +0800
Message-ID: <20241231004811.8646-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231004811.8646-1-pkshih@realtek.com>
References: <20241231004811.8646-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

During rtw89_entity_recalc_mgnt_roles(), there is a normalizing process
which will re-order the list if an entry with target pattern is found.
And once one is found, should have aborted the list_for_each_entry. But,
`break` just aborted the inner for-loop. The outer list_for_each_entry
still continues. Normally, only the first entry will match the target
pattern, and the re-ordering will change nothing, so there won't be
soft lockup. However, in some special cases, soft lockup would happen.

Fix it by `goto fill` to break from the list_for_each_entry.

The following is a sample of kernel log for this problem.

watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [wpa_supplicant:2055]
[...]
RIP: 0010:rtw89_entity_recalc ([...] chan.c:392 chan.c:479) rtw89_core
[...]

Fixes: 68ec751b2881 ("wifi: rtw89: chan: manage active interfaces")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index abc78716596d..c06d305519df 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -391,11 +391,12 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 
 				list_del(&role->mgnt_entry);
 				list_add(&role->mgnt_entry, &mgnt->active_list);
-				break;
+				goto fill;
 			}
 		}
 	}
 
+fill:
 	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
 		if (unlikely(pos >= RTW89_MAX_INTERFACE_NUM)) {
 			rtw89_warn(rtwdev,
-- 
2.25.1


