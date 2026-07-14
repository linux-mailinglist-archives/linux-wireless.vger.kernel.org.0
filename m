Return-Path: <linux-wireless+bounces-39015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FqQhCgLqVWr1vgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:49:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1675210D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=UDZt4lVx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39015-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39015-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06393300C020
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD7735A3A9;
	Tue, 14 Jul 2026 07:49:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C89175A99
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 07:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015357; cv=none; b=j9Gg4UQrht4buCYzXm7XeKStDIM8aoohgv07irF1POoGTWDNqTS298juVIENYWkyLn3/DAYtOZzHxXZwU4RohMiZpnLFx1EJWF2z8QJTjcs78XEb8K8i1D37gkdY/RbAuDwmQSV8Xp+prbdnp0bwWCqAxFxOgxpNnzVG8jeEioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015357; c=relaxed/simple;
	bh=42xbQEGGbMyCwVq7JElAT0PHq1oSqBfhBMuoCFmyx5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mj4pThmRRfHLMKG67BqmWHy3PTjFGwwOBXU5jD+9YDFcbV++1BK9bCXiFvQr4wTxzNdXjjId0gmP0NuWKVr6CsrxjmAEAkHxaOwqCiQILkfDUmSGjZB4jWTaM/Q29xjV5+it+7OrQdmq6wkJvPGMIuPGmNYthb2ekUTdxBENvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UDZt4lVx; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66E7nCRg91962600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784015352; bh=fgUWWQvJ5+ZTWVKtR8C4/sIyBMrAowWG+kDZu4hVc1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=UDZt4lVxWWhiK58V44Os5cE2CUwo5OiR7tgMjLr5j6MrltdfyIIccyNKJMO5PUKWL
	 CHuzeXZwsOfQXlOxayvDZislGpmPwMoVjni4kchqHv/Mn0D8ZTbeq6ANBHRrgYtKFa
	 8LNouYm60Mi5ZE04n09TrsfV+nWK6o4IDz/qsx9sl0f8OfUA6klKGI14TZROi2YDb5
	 qSNwVKMB03aJKVALKPu2L2iQhUfvUVU8CTlVE6uvZoAGqe7KsdiOpbXak1LuMMVhxX
	 u8NVo45QOIbAKsBHBWmeAKAwZ1uEqZPMaySozYgiI7DVRmSNdw7i/tHx4EFDvz93In
	 FsTL0/RGzmbyw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66E7nCRg91962600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 15:49:12 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Jul 2026 15:49:11 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Jul 2026 15:49:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: fw: use MAC source for IO offload delay command
Date: Tue, 14 Jul 2026 15:48:11 +0800
Message-ID: <20260714074811.30124-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:leo.li@realtek.com,m:rtl8821cerfe2@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39015-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:mid,realtek.com:email,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4D1675210D

From: Chia-Yuan Li <leo.li@realtek.com>

The udelay/mdelay helpers set the command source to
RTW89_FW_CMD_OFLD_SRC_OTHER (4), which does not fit the two-bit field
RTW89_H2C_CMD_OFLD_W0_SRC (GENMASK(1, 0)). The le32_encode_bits() masks
it down to 0 (RTW89_FW_CMD_OFLD_SRC_BB), and compiler throws
__field_overflow() error. Fortunately it still works because firmware
ignores the source field for a delay command.

Use RTW89_FW_CMD_OFLD_SRC_MAC as the vendor driver does, and drop the
unused RTW89_FW_CMD_OFLD_SRC_OTHER enumerator.

Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Closes: https://github.com/morrownr/rtw89/issues/111
Fixes: ae3d327515f2 ("wifi: rtw89: add IO offload support via firmware")
Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/fw.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0e7168605850..ab97ab6969f9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -12080,7 +12080,7 @@ static void rtw89_fw_cmd_ofld_write_rf(struct rtw89_dev *rtwdev,
 static void rtw89_fw_cmd_ofld_udelay(struct rtw89_dev *rtwdev, u32 us)
 {
 	struct rtw89_fw_cmd_ofld_arg cmd = {
-		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
+		.src = RTW89_FW_CMD_OFLD_SRC_MAC,
 		.type = RTW89_FW_CMD_OFLD_DELAY,
 		.value = us,
 	};
@@ -12094,7 +12094,7 @@ static void rtw89_fw_cmd_ofld_udelay(struct rtw89_dev *rtwdev, u32 us)
 static void rtw89_fw_cmd_ofld_mdelay(struct rtw89_dev *rtwdev, u32 ms)
 {
 	struct rtw89_fw_cmd_ofld_arg cmd = {
-		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
+		.src = RTW89_FW_CMD_OFLD_SRC_MAC,
 		.type = RTW89_FW_CMD_OFLD_DELAY,
 		.value = ms * 1000,
 	};
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index af126d15a1fb..52e037010f92 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3139,7 +3139,6 @@ enum rtw89_fw_cmd_ofld_arg_src {
 	RTW89_FW_CMD_OFLD_SRC_RF,
 	RTW89_FW_CMD_OFLD_SRC_MAC,
 	RTW89_FW_CMD_OFLD_SRC_RF_DDIE,
-	RTW89_FW_CMD_OFLD_SRC_OTHER,
 };
 
 enum rtw89_fw_cmd_ofld_arg_type {

base-commit: 6c080026ecc17eecb103f8927c64ea73a74bb818
-- 
2.25.1


