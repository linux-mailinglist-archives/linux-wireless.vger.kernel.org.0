Return-Path: <linux-wireless+bounces-38077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XLmYO+XHPGrRrwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87E6C2F35
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="nufw4R7/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38077-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38077-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97401302B82F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351C27707;
	Thu, 25 Jun 2026 06:16:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBC2DB7A3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:16:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368218; cv=none; b=XLvVOek6yawuZJiIfD7+d5lJwlAzRZO4ZUT0GmdHjnfhmYsQuu76GzK01aaG8/VRaiLIAqmXscrMibcVH23ziwcAvpl9wwnniWzfIo+//ywZ7nLFtoo+51BNyCtEWDF+CKCCHnblF9DSVGzyrdzv0LxkbLMV/7cdROx4z+VnlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368218; c=relaxed/simple;
	bh=YH9xAMTtFyHGkH8I+TSj3bcyOnoIM9RN8DiZil+oq8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqcCR++sbXdXXb4rOKvMWDR8DDcNQwokOKe9M7ZMjA69Ez+6Ad7bbkXpnwoC8GNdjInFfcQsltCt3zMAQM7/LopfVUGhxYI2pc2fSUlN+SO0Mb8cVNI78Pv5gap3AuI6/lnyT2ViCZwYI+1LGtH2gPRkNOaEUOOwM7LZjZ8bcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nufw4R7/; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6GsswE584339, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368214; bh=Zp8iZC+Bdt0HfFJA6C4Iygfx1kaCSXzK7Nec/82X/uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nufw4R7/C0JyVKUEW1c9W8kNr1fgL9sC9ixy8PZJpTBlGUzUK/Kq/pPLsu5xQwoSt
	 hufdbYdom52atzuAnJFaA4HYAdFobpnVmV1r3aAlwgmJRX7C/ruJzz6AS/4Mz0VmEd
	 n1MJsTDsyn8IscRFqBbnTmg2JhktPPKS4CMenoQ29x8vCxNwnMA+f9mIw3UlVUKAEG
	 5/GMBtI8d3Cb/oBudFme1FXFoppjnD4GtG4yxFeU7ZGKec0yUvvd49zfOAjtQ4Rqfp
	 AbfeXjXfGSLsXV7AJ+HE48HXWfnobEDnTGTT77H+1Lj2tseGs4+OfPQy6+1BvTv+db
	 0591qDCu13fgQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6GsswE584339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:16:54 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:16:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:16:54 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:16:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/10] wifi: rtw89: drop packet offload entry on H2C addition failure to avoid scan issue
Date: Thu, 25 Jun 2026 14:15:39 +0800
Message-ID: <20260625061545.44808-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625061545.44808-1-pkshih@realtek.com>
References: <20260625061545.44808-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38077-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:timlee@realtek.com,m:dian_syuan0116@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F87E6C2F35

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

A special case is when C2H done ack has been completed, but the
corresponding packet offload response has not actually been received,
which causes the add packet offload to fail. In this state, firmware
treats the entry as added, so subsequent add requests for the same id
are rejected as duplicates. To recover from this, send a delete packet
offload H2C command to roll back the normal state. It has been tested and
verified to have no functional side effect.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d6a594b75ab2..342f95d41c02 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6443,8 +6443,8 @@ int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
 	return 0;
 }
 
-int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
-				 struct sk_buff *skb_ofld)
+static int __rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
+					  struct sk_buff *skb_ofld)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct sk_buff *skb;
@@ -6486,13 +6486,33 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 		rtw89_debug(rtwdev, RTW89_DBG_FW,
 			    "failed to add pkt ofld: id %d, ret %d\n",
 			    alloc_id, ret);
+		/*
+		 * Firmware may consider that it has added this entry
+		 * successfully even though the H2C return timeout.
+		 * Send a delete H2C command to drop it, and thus the
+		 * next add on the same id won't be rejected as duplicate.
+		 */
+		rtw89_fw_h2c_del_pkt_offload(rtwdev, alloc_id);
 		rtw89_core_release_bit_map(rtwdev->pkt_offload, alloc_id);
-		return ret;
+
+		return -EAGAIN;
 	}
 
 	return 0;
 }
 
+int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
+				 struct sk_buff *skb_ofld)
+{
+	int ret;
+
+	ret = __rtw89_fw_h2c_add_pkt_offload(rtwdev, id, skb_ofld);
+	if (ret == -EAGAIN)
+		ret = __rtw89_fw_h2c_add_pkt_offload(rtwdev, id, skb_ofld);
+
+	return ret;
+}
+
 static
 int rtw89_fw_h2c_scan_list_offload_ax(struct rtw89_dev *rtwdev, int ch_num,
 				      struct list_head *chan_list)
-- 
2.25.1


