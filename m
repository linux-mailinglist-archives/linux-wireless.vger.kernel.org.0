Return-Path: <linux-wireless+bounces-38074-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7BFLEQnIPGrmrwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38074-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A76C2F6F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=UWoq4wpn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38074-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38074-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4462D3036D79
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859B627707;
	Thu, 25 Jun 2026 06:16:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834E2DB7A3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:16:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368201; cv=none; b=Da8dpiu+++jxbDjez7DflMkDMTDswRbmP8tQ26b82a3SwSfxY9v7dLEsKs/uEtZS7VnQpQhsWrzvtPu5KYxX0ykvve1mWU5X3Fam17hgEUXhsVKeSXfNr42kX+xIWunEWUUGYMDifFaLbRRBAGRaqysAOTVCv7NIB02NqFxdz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368201; c=relaxed/simple;
	bh=uCVC5X0OsOHjzsz3JGnLqlopksxc7RBb4lRi081Lqgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOBQpC3O2aeVSu2NrI5eAj9i/fYXnHB3n28cCSh5lboV+4DSCGAIbuSCYl0hsnvVtxoLiSToEfsihzRK6q+nd7ivvuQxfXdjfElmy1n8FZvjPuqUDD180DfIrGJEuJYJ6num5dMGwd4++KYnhTqqljkZzI5N13ZfKZPO05zrow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UWoq4wpn; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6GbbT6584278, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368197; bh=zQa5N/a7hJygwzxK9DSHByeP2KTz3ckM0HVm8aToFVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UWoq4wpnMh1/MXP8Qy7M6+jNcJKKnpbFmiTpS89Lg5qKOy9MzKU54jq+rEUJL/JM+
	 QKaJ679fkyNGB4TbjnQp8IcfS7B+AED4nc5GO4kg9J6jM7APSOW5yfhMlnKKBtlTBX
	 jhZCZhbDxvJHBcEslx2w1JLMkLrW1qMB6xX92yo4RrS5e+rHvgt9heSJe4lHgCNEs4
	 wE3DVLhG8yiSLGF2k7GWysnzFV7XpYVITN8ktIg/BgWEhsucwivLo72QJcFjhO4jX5
	 GFusEIucMfvB95GvwHdm+xD9udN2UrkFM0XqE84zOBP1FM1MHBIIJpP3mkf2pZqNSD
	 jknzRo1egLusg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6GbbT6584278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:16:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:16:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:16:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:16:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/10] wifi: rtw89: mac: finish active TX immediately without waiting for DMAC
Date: Thu, 25 Jun 2026 14:15:36 +0800
Message-ID: <20260625061545.44808-2-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38074-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D04A76C2F6F

Currently active TX only finishes after ensuring PCIE and DMAC become idle.
However, the waiting time might be long. Since the packet is already
transmitted over the air, update the registers to finish active TX
immediately, regardless of the PCIE/DMAC status.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c |  3 +++
 drivers/net/wireless/realtek/rtw89/reg.h    | 28 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f24c119b99f1..70e6c9d21986 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1196,6 +1196,9 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	rtw89_io_pack(rtwdev);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MISC_1, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_EN_TX_FINISH_PRD_RESP);
+
 	if (chip->chip_id == RTL8922D) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_BE_CWCNT_PLUS_MODE);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 086ef77ebb9f..bf1c6cb0ae9c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6858,6 +6858,34 @@
 #define B_BE_MUEDCA_EN_MASK GENMASK(1, 0)
 #define B_BE_MUEDCA_EN_0 BIT(0)
 
+#define R_BE_MISC_1 0x1037C
+#define R_BE_MISC_1_C1 0x1437C
+#define B_BE_PPS_REMAIN_TIME_MODE BIT(31)
+#define B_BE_PPS_IDLE_SORT_EN BIT(30)
+#define B_BE_SR_TXOP_USE_SR_PERIOD_EN BIT(29)
+#define B_BE_SCH_CCA_PIFS_CLK_GATING_DIS BIT(28)
+#define B_BE_SR_TXOP_EN BIT(27)
+#define B_BE_SCH_ABORT_CNT_SIFS_EN BIT(26)
+#define B_BE_SCH_ABORT_CNT_TB_EN BIT(25)
+#define B_BE_SCH_ABORT_CNT_CTN_EN BIT(24)
+#define B_BE_SR_CCA_PER20_BITMAP_EN BIT(23)
+#define B_BE_SR_CCA_S80_EN BIT(22)
+#define B_BE_SR_CCA_S40_EN BIT(21)
+#define B_BE_SR_CCA_S20_EN BIT(20)
+#define B_BE_EN_TX_FINISH_PRD_RESP BIT(18)
+#define B_BE_RESP_TX_ABORT_NON_IDLE BIT(17)
+#define B_BE_RESP_TX_ABORT_QUICK_EN BIT(16)
+#define B_BE_PREBKF_CHK_LINK_BUSY BIT(15)
+#define B_BE_SCH_MSD_PRD_RST_EDCA_EN BIT(14)
+#define B_BE_LINK_BUSY_RST_EDCA_EN_MASK GENMASK(13, 12)
+#define B_BE_RX_TSFT_SYNC_BYPASS_FCS BIT(11)
+#define B_BE_RX_TSFT_DIFF_THD_MASK GENMASK(10, 8)
+#define B_BE_CAL_TBTT_OV_EN BIT(5)
+#define B_BE_SUBBCN_MS_CNT_MODE BIT(3)
+#define B_BE_CAL_ALWAYS_EN BIT(2)
+#define B_BE_SIFS_TIMER_AUTO_RST_EN BIT(1)
+#define B_BE_CHK_HAS_SIFS_TX_ABORT BIT(0)
+
 #define R_BE_CTN_DRV_TXEN 0x10398
 #define R_BE_CTN_DRV_TXEN_C1 0x14398
 #define B_BE_CTN_TXEN_TWT_3 BIT(17)
-- 
2.25.1


