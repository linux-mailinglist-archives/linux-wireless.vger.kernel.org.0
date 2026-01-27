Return-Path: <linux-wireless+bounces-31208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HjrBY59eGkFqQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:55:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90891575
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13DC83084172
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44F9229B2A;
	Tue, 27 Jan 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ItYVXIMb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371F2FD691
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503900; cv=none; b=bm7qbDrC3TkreZ6LOK8h1qveOq1U2WbJAT8eo9X/vAMvij03jPROHIwpbXVCbhL+rvNn3/WF5ozF4igEU2BcG1xnTXon2b3lytC+ajLQpwp7iXmvLgbT6+imKabLdpQa1R7kXjgy5HlW7znxOnF7fi9HwGNr+KGMQYgb00qw47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503900; c=relaxed/simple;
	bh=QRXjr/nEDOuyspizaqaBNmk8IMzis6mFiGMiFjwAYPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am+1JST9Ln40/TlHQg97gz20CAvkPcZcOx9ncABz0FrD0LzOwTsGSRGHKaeSKBlNi+m2wn5EasZGxcWXwXVU7zLnELLATXPAJXdWfj8L723PhYmpmF/dn2nWMUkezIeO/2OequrGewruc8HnfH3FJEbbot49hbyajytO4dFd5zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ItYVXIMb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60R8pbMJ32655495, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769503897; bh=h8kd8h5E0LggVprFWjFTkqcPsYVQf71I6deqjYQtFOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ItYVXIMboYzSvJsaIBfrZATUfXq/TBjCDIW3odIQ/ao//5S2jyZES4m4jO4r+6kDf
	 uQ1eWG1b8eNMo+60pVYY9hxxem7l8rPZeVIw8jthL+K2pTGwY6iT34kpRxYazcLrSP
	 PZwgu46CWhMX8A/vlO+zI+kCwMZ+0dCzIaBMBkn8JqkOh/BLD0u2vIeWEar+ZXXjsU
	 VxOQAP/SxukcsWmDE2Lrc4fmzInZHG4/779rlQTHxXidk7Bvwq5oekTWUAkG7psUsN
	 18dLvGpEKtaAfSBgXKlEDxncbkh5zxHDQKJAuROV3o7aj1EIXUtz49Nbzy0SLNy+MI
	 ya461ybPdrHMQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60R8pbMJ32655495
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:51:37 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 27 Jan 2026 16:51:37 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 16:51:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/6] wifi: rtw89: wow: disable interrupt before swapping FW for 8922D
Date: Tue, 27 Jan 2026 16:50:33 +0800
Message-ID: <20260127085036.44060-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260127085036.44060-1-pkshih@realtek.com>
References: <20260127085036.44060-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31208-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D90891575
X-Rspamd-Action: no action

From: Chih-Kang Chang <gary.chang@realtek.com>

Except for the 8852A, 8852B, 8851B, 8852BT, all subsequent chips use
HAXIDMA. Therefore, interrupts need to be disabled before swapping
firmware to avoid unexpected SER.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5d3227e2b3e4..b67ceda59e92 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1267,15 +1267,15 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
-	bool disable_intr_for_dlfw = false;
+	bool disable_intr_for_dlfw = true;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta_link *rtwsta_link = NULL;
 	struct rtw89_sta *rtwsta;
 	bool is_conn = true;
 	int ret;
 
-	if (chip_id == RTL8852C || chip_id == RTL8922A)
-		disable_intr_for_dlfw = true;
+	if (chip->chip_gen == RTW89_CHIP_AX && chip_id != RTL8852C)
+		disable_intr_for_dlfw = false;
 
 	wow_sta = ieee80211_find_sta(wow_vif, wow_vif->cfg.ap_addr);
 	if (wow_sta) {
-- 
2.25.1


