Return-Path: <linux-wireless+bounces-36708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB4GIJSsDWqP1QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:44:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94A58E09E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DE63079C6E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488B33D9696;
	Wed, 20 May 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JL+AZjjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4723DFC60
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280728; cv=none; b=UnacPyqDhmFkMYvlYkOwFdvek16MegnXOdl114A4UtV6UiQ8+noH+XG10sqrJ6oj84CBS5Kq0BgkeGhZs5vTRPTiKJ2Pip018vSVXHNGMXbPd8jXrpfvsANiSxKtJBT4yX6XRw5y+FtrBu1o8kbin1+WwGqcWVThMiWx9X4oXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280728; c=relaxed/simple;
	bh=wtDFp8J8LH9XMfv+CKsJbHcHIwzUdMX3IqhM2Rz7FlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJaOilMuF+dIuMQEL0h+Av2k+3mDEMLr7CTSVMClapg6dZeHZIs7a8x2Ro0QQDE0UJ3UIwa2SYjC0bJ5zB0Z8BUaSmsB2axPzVmIAJzzR622BGEVIB9ah8xnwyJrp0bz5DcBOIAdgi+v7UyQtQATTjb4okm2RJxpIIt6Oe1mBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JL+AZjjN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCci1fB095568, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280724; bh=BpRSv6JNisXGNwIhfdFn88KK5xzR/upVt0P64+reSIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JL+AZjjNWS6kED/bY3/OvPo4SKCij28Dc8Ax2aB4E4xblvefwDzM3PiA/i8x/Mk3q
	 b5WwYFHPQgUdeDuXH2WdpdS8wlGo1goNJuBs5zsrpLTm2HP0AguBOId1V9SdUMjaVE
	 rZyjVg8qn99onjLPgvmAMWWH5NZdNuhtAbpBMsvlI3cOQBYwsef9nr28r2pWBrmYeN
	 QJb0WerFvthZS9Fr62ZQJU0o59jLbz0GUnqP9ZP4YpEXzS2bJKHO6a0Md1aw9kkozo
	 b0zfGRumXFj/vIU+t/Lyu1Lt9P3XkE0a/bvJlrwWyF31gKnUQ+KYJ6S4B+S+SkxLoK
	 CNG6Z2MxT5WgQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCci1fB095568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:44 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:44 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:38:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/7] wifi: rtw89: fw: load TX compensation element by RFE type
Date: Wed, 20 May 2026 20:38:20 +0800
Message-ID: <20260520123823.1792954-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36708-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A94A58E09E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Originally driver uses TX compensation element by AID, and now tables are
by RFE type. Add the logic accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 6 ++++++
 drivers/net/wireless/realtek/rtw89/fw.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5d0b3ba9a358..47649079d7b5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1423,12 +1423,18 @@ int rtw89_build_tx_comp_from_elm(struct rtw89_dev *rtwdev,
 				 const union rtw89_fw_element_arg arg)
 {
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 rfe_type;
 	u16 aid;
 
 	aid = le16_to_cpu(elm->aid);
+	rfe_type = elm->u.tx_comp.rfe_type;
+
 	if (aid && aid != hal->aid)
 		return 1; /* ignore if aid not matched */
+	else if (rfe_type && rfe_type != efuse->rfe_type)
+		return 1; /* ignore if rfe_type not matched */
 	else if (elm_info->tx_comp)
 		return 1; /* ignore if an element is existing */
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cde8fd34723b..20721d5209aa 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4548,6 +4548,11 @@ struct rtw89_fw_element_hdr {
 			u8 rsvd[4];
 			u8 rules_and_msgs[];
 		} __packed diag_mac;
+		struct {
+			u8 rfe_type;
+			u8 priv[7];
+			u8 contents[];
+		} __packed tx_comp;
 		struct __rtw89_fw_txpwr_element txpwr;
 		struct __rtw89_fw_regd_element regd;
 	} __packed u;
-- 
2.25.1


