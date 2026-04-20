Return-Path: <linux-wireless+bounces-35006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFPwF6qg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0164426981
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 540D230160F9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD822BDC0F;
	Mon, 20 Apr 2026 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dgz83wmd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597152FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656541; cv=none; b=Xu5OL7rANcVbfpcKDMjECwcbCjCqriAcz0PmMq8rAbOmG5JTuP3GjrnipcK2VV/vZGBeVxheHYVNhexJ1sBCCb7ECJ64H97313mskA1yCCYb5PVXaMMG+ZYrxhEuFN4eYP9rfsCZf6KGmmQD1KsWHvUzj0UbjF9CIr8WxdsWkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656541; c=relaxed/simple;
	bh=h31i/180N5rkFKhgXpWPuqSRh8kXcr6CW1t4OmErdsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smMPlYVQj6m1ePmDIYDFF6wqsbrrzr/uZj9CwNOQZGN1YE9xh2LYBtYoI+3vYKoErMDdiJBlGFygn4YQYI0z/McpR9ddk/q8woZm6lSJ0lLTJK2F3kwbBe1EqrtOH6GgmIlHceu6tFNdLlg7975ZifvWMVXZZcIPMjWT0Swu1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dgz83wmd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3gHDn9427781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656538; bh=JyE90+38G5rC13wSAY/HX5lG5RjhrtLXzDROrQc3XRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dgz83wmd40Z8TPA/8P9l415RU1z265xQptYA5kTAhKy56MxjNFN/aGE4Es60aTCmP
	 jsEHFXNgFWQ/E4Wx0nCPCXYncRuEuQlwE6QPkjE8YIOnqxufl2mx05aKQXaseGu0+c
	 MoZzY9MiIYQJWzDmzL8cHXjEF9f1GHVrnmQLXHSbkaAxJsyJJ7rNBIX4/E2zynRjcg
	 KjGK22peyS9l0QTb66+V9dUiz0H9ClFWgm6XI+xBUVbpJqTGcfkOEDtIeEnbiL4Q5j
	 kIXUAS+zbFN1XpN165/DfycdxLw0sXN2g94O0C39dM+zC48f5agvITV55vi30WLneB
	 ePmNfdFEsXXlg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3gHDn9427781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 13/16] wifi: rtw89: check scan C2H event recv ack instead of C2H event done ack
Date: Mon, 20 Apr 2026 11:40:48 +0800
Message-ID: <20260420034051.17666-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-35006-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F0164426981
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chih-Kang Chang <gary.chang@realtek.com>

The original flow checks the scan offload C2H event done ack to increase
the scan sequence. However, the scan offload response C2H event may be
received earlier than the scan offload C2H event done ack, which causes
these C2H event to be dropped by rtw89_fw_c2h_purge_obsoleted_scan_events()
check because the scan sequence of the scan offload response C2H event
is less than the scan offload C2H event done ack. Therefore, checking
the scan offload C2H event recv ack instead of C2H event done ack to fix
this issue.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6ad411149c3e..af2e5b67f4d5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5415,10 +5415,30 @@ rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len
 	u8 h2c_class = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_CLASS);
 	u8 h2c_func = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_FUNC);
 	u8 h2c_seq = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_H2C_SEQ);
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
 		    "C2H rev ack recv, cat: %d, class: %d, func: %d, seq : %d\n",
 		    h2c_cat, h2c_class, h2c_func, h2c_seq);
+
+	if (h2c_cat != H2C_CAT_MAC)
+		return;
+
+	switch (h2c_class) {
+	default:
+		return;
+	case H2C_CL_MAC_FW_OFLD:
+		switch (h2c_func) {
+		default:
+			return;
+		case H2C_FUNC_SCANOFLD:
+		case H2C_FUNC_SCANOFLD_BE:
+			scan_info->seq++;
+			break;
+		}
+
+		return;
+	}
 }
 
 static void
@@ -5426,7 +5446,6 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 {
 	/* N.B. This will run in interrupt context. */
 	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
-	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw89_wait_info *ps_wait = &rtwdev->mac.ps_wait;
 	const struct rtw89_c2h_done_ack *c2h =
 		(const struct rtw89_c2h_done_ack *)skb_c2h->data;
@@ -5469,11 +5488,9 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
 		case H2C_FUNC_SCANOFLD:
-			scan_info->seq++;
 			cond = RTW89_SCANOFLD_WAIT_COND_START;
 			break;
 		case H2C_FUNC_SCANOFLD_BE:
-			scan_info->seq++;
 			cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
 			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
-- 
2.25.1


