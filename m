Return-Path: <linux-wireless+bounces-36440-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCD/JcJ6BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36440-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A746B54882E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFEBA30072AB
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C926B764;
	Fri, 15 May 2026 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rv1k70Ur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840B36AB4D
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809490; cv=none; b=YInsxyNvDjOctKrKWzgoF4w533hUGETYVjapA2R2gNQu/szA1/xZlU5TkKWWJfpwK7zOKBmovhiO2tNCTDORL4ptCyxXyG5fGCQ03J8TzMa35waR9XzLqPFmUgjUDJra3DojLpe7iwhPP4vYWXTtUVm7CvCNrb9Z37BlhhFeoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809490; c=relaxed/simple;
	bh=seztKn1+tVx2tbEeEcogQu+hTcNvTXXPlXpq/4xsBiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEMYcBZDFru6+Yhm2jbu+CgmDjQPgHXB/FUPqElFGZg5+uFqQ0suwXM7HAGw0NSnuBEMZOmxhPN0q/wVgZgZMBeLyL3wOv4aA/5rr83pjppW59vBfqLqKeO9qrWw91PHm0SZjjfCymurrNvbZu2FMCYUCsDetNg7fvOEM6dPXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rv1k70Ur; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1ilAZ32587049, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809487; bh=eu4lABWcZI3SojN1+Ez5RXTcM+e5lw3ErDIs0o5Tm3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rv1k70UrfPjQKBC8lVWtf7JXy4eaFsTlATCPZFR5WLyP+wE1dSYmew98H4W8eljAK
	 V8Dm90kQoO0HzUedxxYEutmkOAK+vnFcoM6f5vCQ1mrm2tKl8baQAPuGfa54qDsNu7
	 KTRWm6eaMIU/A5r1LiaBlk1YwcFcHBHw0CpJ9oXHOrgyorAkz41AJCLDYM94w5/AR+
	 Ka4fv/Ac3LlH/TyD0nzIoYcbVqOY+t+5/6MJ7dah+qK81wIgaRX/h14kS+TFsDNMZC
	 ASPQkNwC7g5fr0nPV/6TxwCBXXgNKr2jgnk0FpuvCACPomKh0hzY25w3k6DdW06wL0
	 DdR8dhcc7ZRrg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1ilAZ32587049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:44:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:44:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:44:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/13] wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
Date: Fri, 15 May 2026 09:44:21 +0800
Message-ID: <20260515014433.16168-2-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: A746B54882E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36440-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Wi-Fi 7 has dedicated HW register to count SER L0 simulation, i.e.
manually triggered by users. Show count of it in dbgfs ser_counters.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8ee800c76cfe..e5976b8e7056 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3760,6 +3760,7 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 }
 
 struct rtw89_dbg_ser_counters {
+	unsigned int l0_sim;
 	unsigned int l0;
 	unsigned int l1;
 	unsigned int l0_to_l1;
@@ -3780,6 +3781,7 @@ static void rtw89_dbg_get_ser_counters_be(struct rtw89_dev *rtwdev,
 {
 	const u32 val = rtw89_read32(rtwdev, R_BE_SER_DBG_INFO);
 
+	cnt->l0_sim = rtw89_read8(rtwdev, R_BE_SER_L0_DBG_CNT1 + 3);
 	cnt->l0 = u32_get_bits(val, B_BE_SER_L0_COUNTER_MASK);
 	cnt->l1 = u32_get_bits(val, B_BE_SER_L1_COUNTER_MASK);
 	cnt->l0_to_l1 = u32_get_bits(val, B_BE_SER_L0_PROMOTE_L1_EVENT_MASK);
@@ -3810,6 +3812,10 @@ static ssize_t rtw89_debug_priv_ser_counters_get(struct rtw89_dev *rtwdev,
 	p += scnprintf(p, end - p, "SER L1 SW Count: %u\n", sw_cnt->l1);
 	p += scnprintf(p, end - p, "SER L2 SW Count: %u\n", sw_cnt->l2);
 
+	/* Some chipsets don't have dedicated cnt for SER simulation. */
+	p += scnprintf(p, end - p, "---\n");
+	p += scnprintf(p, end - p, "SER L0 Simulation Count: %d\n", cnt.l0_sim);
+
 	/* Some chipsets won't record SER simulation in HW cnt. */
 	p += scnprintf(p, end - p, "---\n");
 	p += scnprintf(p, end - p, "SER L0 Count: %d\n", cnt.l0);
-- 
2.25.1


