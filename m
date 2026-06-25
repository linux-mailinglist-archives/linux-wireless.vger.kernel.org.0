Return-Path: <linux-wireless+bounces-38080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1GUIFvbHPGrarwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C11A26C2F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 08:17:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=BexKKU1k;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38080-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38080-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DE9530309A4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441D72E7367;
	Thu, 25 Jun 2026 06:17:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9A2DB7A3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 06:17:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368237; cv=none; b=CMRXc8VI6e9mMUF+j7M799SMD4aWLoaHLCkWCKSghUhOQ84wTwQxHECYRWOYpE0l9XjzLUrfwmVUXfVL9T10PzBUl0S47pSTeamN2vaBiPnQXFnTGS/lhg60Ve31YGDQE+V128MeIiufUVsgTQmwbcz57n/umjrY1CtGNpJQxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368237; c=relaxed/simple;
	bh=0R7v/QpeqJDLhcUuiQQ5KNipxpWDi6pe1YhIxxlVf9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6hkTIef8lDkt9uNqOXQxdmCJD2kuYJaSG+wyOjcurvRqwsVtsKo5kX+Zb2GXWxLOd22Yf4SYXV69ND0YXVggxmRLeRzTGUgJoPXqvEtu68Bs8QK/fLy5PMkb/EsvRieD3RKWXZUKpLI9hcw5qY22IeUJWcK2YEjhzEBEL78+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BexKKU1k; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65P6HDLS0584462, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782368233; bh=nbrwoc8VDFhf7pRvM4ujbjByOcbF/mYqQVa5CPakxTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BexKKU1kUo2Tc30tHxJITwdeYzmZp7eqcFnXT2wdQAo4a/4KbRXblxbxfXVJQ0tUl
	 XHQ1nTNiloie/xNyBA0YKgclSalviN3jv14JAtapYZSBsRWlVrv4zSbdVsvqMSsXN6
	 lUzRuXneCPiwneaCXd8mKUokLItbrIZa3+wEorzt4B1AlonJlYtvt+pa29PFiUCxKw
	 JegOrXBpNlHwtSR6d/4ehJofFssR7jsvPhEkTdxeGQN2EuNnTpsjOnd7jlPqFv/hc7
	 1a/2y7Nf0qB7Eykvzf1z9gOaJveAvuP8e9qiZpkToOMHSXMUOsG/tWrtLexq0j++mq
	 Fu2/Lz1dYfLoQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65P6HDLS0584462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:17:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 25 Jun 2026 14:17:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Jun 2026 14:17:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
	<dian_syuan0116@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/10] wifi: rtw89: fw: fix link ID filling for LPS MLO common info
Date: Thu, 25 Jun 2026 14:15:42 +0800
Message-ID: <20260625061545.44808-8-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38080-lists,linux-wireless=lfdr.de];
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
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C11A26C2F4F

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The link ID field in H2C command of LPS MLO common info is incorrectly
filled with the PHY index. Fix it with the target link ID.

Fixes: 20380a039ddd ("wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/fw.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 342f95d41c02..4f5995f2cb13 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3439,7 +3439,7 @@ int rtw89_fw_h2c_lps_ml_cmn_info_v1(struct rtw89_dev *rtwdev,
 	h2c->rfe_type = efuse->rfe_type;
 	h2c->rssi_main = U8_MAX;
 
-	memset(h2c->link_id, 0xfe, RTW89_BB_PS_LINK_BUF_MAX);
+	memset(h2c->link_id, RTW89_BB_PS_LINK_ID_SKIP, RTW89_BB_PS_LINK_BUF_MAX);
 
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
 		u8 phy_idx = rtwvif_link->phy_idx;
@@ -3447,7 +3447,7 @@ int rtw89_fw_h2c_lps_ml_cmn_info_v1(struct rtw89_dev *rtwdev,
 		bb = rtw89_get_bb_ctx(rtwdev, phy_idx);
 		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 
-		h2c->link_id[phy_idx] = phy_idx;
+		h2c->link_id[phy_idx] = link_id;
 		h2c->central_ch[phy_idx] = chan->channel;
 		h2c->pri_ch[phy_idx] = chan->primary_channel;
 		h2c->band[phy_idx] = chan->band_type;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 20721d5209aa..5873301fc472 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2053,6 +2053,8 @@ enum rtw89_bb_link_rx_gain_table_type {
 	RTW89_BB_PS_LINK_RX_GAIN_TAB_MAX,
 };
 
+#define RTW89_BB_PS_LINK_ID_SKIP 0xfe
+
 enum rtw89_bb_ps_link_buf_id {
 	RTW89_BB_PS_LINK_BUF_0 = 0x00,
 	RTW89_BB_PS_LINK_BUF_1 = 0x01,
-- 
2.25.1


