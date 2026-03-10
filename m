Return-Path: <linux-wireless+bounces-32810-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPHPD5fQr2mVcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32810-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:04:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0D246E87
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EB8304E715
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236B3ECBD5;
	Tue, 10 Mar 2026 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cyR9kNY5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CD3E959E
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129728; cv=none; b=a7ZyuzzGKVfYqOBCNfHouPocfRL8vUhObFoVFLMmpQtq3HBy5DvAEeN3at7d/FPM3Sq5lU/GzCdm+q+rQj6cF8V33FrHLjsLtz0Mo44U+YtW+HUJNEnA3RPI+tFt8a65IiYOnlAjcIENDR5uZM3n1kdDO3puqpW3twzme3QYaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129728; c=relaxed/simple;
	bh=l7PuFCSe1t0pYdFZxvcxfc6KED/xo6e41UJPBFmA8LE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO5001WhuZRffhF1AJiNzPb6shmPCWBcYGsBDFO2qBulrG0zfMGTmNkPfCvssry+v5JWQt3HUuEU6cIifnZlkxFFBBSpRM2BZF1o0Q9pG4m5IkoFLaVZolIvaqaYb4QXm6Ukk8g8z4MSiejOJXJPFELC97OTbgKaS7IpEOhQkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cyR9kNY5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A81xC722208392, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129719; bh=v6owtRsCeBPjynIxrJ7r6af+rdBdS2aMQI4dJwPTLWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cyR9kNY5v1j5E2f7DVmovYBQ1HShJJplq7l5DtjvuT6BlEKXzQJeSbg7TkQChx+tP
	 vnzdmge62IcNWb2APyMMvQqzXtHVh5MD+EY36IRI7zafV9Ew2zstYQQ2up2iIQZplN
	 3rJ2DmqfZRHis4Ke2XWm5uHK74Cg+tParUY4P+6R+mkx8PXwgFjfUO6OvJhTwIdLce
	 LI4/iAxi3rYDC4NLtC1xmeZFSKL1G3rQ0znAMfWu5W92MtrzumJyLNRhbkFKvz1jLy
	 ZVx4mV5EdaHxiJIaM/SGLcYevjQgrq6KhWELp2uYm1lCmGoqiDPXbWoB+3PboJ5LB/
	 ws3svvMDwKzjw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A81xC722208392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:01:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:01:58 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:01:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/13] wifi: rtw89: mac: finish active TX immediately without waiting for DMAC
Date: Tue, 10 Mar 2026 16:01:34 +0800
Message-ID: <20260310080146.31113-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 9AB0D246E87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32810-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

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
index dc66b1ee851a..ed1ea13bb98d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1173,6 +1173,9 @@ static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MISC_1, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_EN_TX_FINISH_PRD_RESP);
+
 	if (chip->chip_id == RTL8922D) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_BE_CWCNT_PLUS_MODE);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9b605617c3f0..66ed847c9009 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6745,6 +6745,34 @@
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


