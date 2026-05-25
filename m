Return-Path: <linux-wireless+bounces-36861-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCjQCof1E2puHwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36861-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 09:08:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33C55C6EF3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933AF300F9DD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 07:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE963BB137;
	Mon, 25 May 2026 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q+61NvmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D73BA24F
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692885; cv=none; b=XJlsIU+gCyV3/d33U2+8DFk45a8Prq2zchikovVwsQKGIz7aDcZAuNRAm+s3k/kfxzfIdPWh9QuXZe2WISkqbWKyLkXMqS9xPMHACBk5PtuPhhJaqAuMqrXncMGXRsmdRmIEmMSP4PS5+NpgzCML94XVpFrfP0t0zc/sPzWQfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692885; c=relaxed/simple;
	bh=7fywBfpoLhvfAsz1scGRAIRyWJwTCCicEPEGLDPY7rU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwNiH8CmmA/Qlx1hhwZe2VbFvgg7MEJVTZvbHG0Wj+eIs+2dFkbA3bx70ZqV6syAr7G6HP44ZgqCKq/PQ9x61kCTaivgxH8YO/S0NotDHbQ+bjC3LW3rJR/6Tr0/Fv05klDLA8LgrjvxCvVULdH08fPe0S7N9iFkoSpURjs6ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q+61NvmK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P77xdE6875888, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779692879; bh=xKsSMX8RMqW2FE/XbC/4NKdfdoX7XUsyMrW+O5EpfEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q+61NvmKXtxwvOd9YIQYO1SJLBo6WXfQQH5S/B0RvFF0m1xS6zwMcI0W8E3TLi/GX
	 anPos0DKeuP8sa9IotVAhorJg4R1EOA/T1cbNs3mIEf0rYT8lcG8kkS5Wsd0mMtKVc
	 UVdAObWIh9nuoLs/8IpXziVZikB2fbzUx+KiKUMhSqtXxRWBrxFc5UFalNCVQ431Uq
	 6hIuOFNzTO/d52UHGt1lYqxqATGbOnv5UZud34D+U2UMxTCTAEqCnLlR0Tl/fBJgbX
	 QtRnG0Nnb1so4PouPWqkGN7xAODYbxBIK6zW2IadEyUyfKUP+YSDe/z6qUrdWO6bKf
	 WfteIvS2BiZzw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P77xdE6875888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 15:07:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 15:07:57 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 15:07:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 15:07:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 1/2] wifi: rtw89: fw: add first set of firmware features by version for RTL8922D
Date: Mon, 25 May 2026 15:07:34 +0800
Message-ID: <20260525070735.27659-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260525070735.27659-1-pkshih@realtek.com>
References: <20260525070735.27659-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36861-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B33C55C6EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The firmware features including version of command/event format are
maintained by this table, which enables features by firmware version.
Define the first feature set accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index eb5683d64461..ecfae90e280b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -933,6 +933,19 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 92, 0, TX_HISTORY_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 108, 0, SIM_SER_L0L1_BY_HALT_H2C),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 0, 0, 0, MACID_PAUSE_SLEEP),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 75, 2, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 75, 2, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 84, 0, CRASH_TRIGGER_TYPE_1),
+	__CFG_FW_FEAT(RTL8922D, lt, 0, 35, 84, 0, ADDR_CAM_V0),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 87, 0, BEACON_LOSS_COUNT_V1),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 91, 0, RFK_PRE_NOTIFY_MCC_V2),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 91, 4, LPS_ML_INFO_V1),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 93, 0, NOTIFY_AP_INFO),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 104, 0, TX_HISTORY_V1),
+	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 108, 0, SIM_SER_L0L1_BY_HALT_H2C),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
-- 
2.25.1


