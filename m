Return-Path: <linux-wireless+bounces-36862-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLRKCo/1E2puHwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36862-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 09:09:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD95C6EFA
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 09:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6C7301AD3F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FE3BB66B;
	Mon, 25 May 2026 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qXUSmc9W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F433BB139
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692886; cv=none; b=szXkqDNFeJevxsPhwOpFjN9QMm1k34x09cZS1nvreP5TaCaxn6udnzIwIQEbFD+uavvEb1Rg6Kcw7Vdl88P1jUpvhGpWdrQ76TtIWEpb0yNjgjr4Sv/bwDg1DCWbpzM+lodXdLi2ROJk7h7PdTmwklOGBwMwApWodOsHqA2ETAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692886; c=relaxed/simple;
	bh=ZfVuOMm/RgCSW8s9Dt8YCTfL9fsCKMOy/IrZFFIDSu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwzi8pjsLGYzmQVl6WXwFA+I5rzPRir8SkSHJkOVi2UE1gX/9jHxSofmUVCkYbxwLIhHs8rCTyNGYPb3UtGbgIccrC5ABde5pD7xEaJ0d9fICLWkeYqg84mL/mNoo5pNqjscAidHTHXfE60FpMOZtVy5cC7w1O63lxRJj6qQfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qXUSmc9W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P782ZS0875911, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779692882; bh=+lEUGWpZV3NeA94582sfASPOQqWG+n0tf/t5Yoyn95w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qXUSmc9WI9EPoXI5DLXLAxQbY/9XCni2CBwE0TbcQSkvtXzmVKK6fWe9DsB/EaOPf
	 YDzzb0FxePnl3ZB79To30EUtn+vBT8tGYEre/iurelfd3qCQPusBZCNXUx9i74jUOy
	 FQqhAAuXs+8JC09VOsbYk5A4rCTDisqPNjVti7jTQh6SeizliBBZYuJxRHvufpu5Kx
	 sShIWQQSXfs+mQV7gkqPXt0jM55v5NnBCZs8gf79ZdREy6Bp22Z3LUCK7oF4yDFpU3
	 LMufjqi88c/dXn2a+NOevJDzdSnIMxDtK/dc009SyKUwFyjCikZZuTMAk/wc4gctrx
	 7gtM9TfiRPQrQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P782ZS0875911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 15:08:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 15:08:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 15:08:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 15:08:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: fw: support scan offload v2 for WiFi 7 chips
Date: Mon, 25 May 2026 15:07:35 +0800
Message-ID: <20260525070735.27659-3-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-36862-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 81CD95C6EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The format of scan offload v2 is to extend fields to consider channel
noise as a factor to adjust dwell time of certain channels. Leave empty
for now to ignore this factor.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 9 +++++++--
 drivers/net/wireless/realtek/rtw89/fw.h   | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 27d9a916d58c..8461c3913bcd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4908,6 +4908,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_BEACON_FILTER,
 	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V0,
+	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V1,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY,
 			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ecfae90e280b..ed5827cb3732 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -933,6 +933,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 92, 0, TX_HISTORY_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 108, 0, SIM_SER_L0L1_BY_HALT_H2C),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 109, 1, SCAN_OFFLOAD_BE_V1),
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 0, 0, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 75, 2, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 75, 2, BEACON_FILTER),
@@ -946,6 +947,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 104, 0, TX_HISTORY_V1),
 	__CFG_FW_FEAT(RTL8922D, ge, 0, 35, 108, 0, SIM_SER_L0L1_BY_HALT_H2C),
+	__CFG_FW_FEAT(RTL8922D, lt, 0, 35, 109, 1, SCAN_OFFLOAD_BE_V1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -6831,7 +6833,10 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
-	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V1, &rtwdev->fw)) {
+		cfg_len = offsetofend(typeof(*h2c), w9);
+		scan_offload_ver = 1;
+	} else if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
 		cfg_len = offsetofend(typeof(*h2c), w8);
 		scan_offload_ver = 0;
 	}
@@ -6910,7 +6915,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	if (scan_offload_ver == 0)
 		goto flex_member;
 
-	h2c->w9 = le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
+	h2c->w9 = le32_encode_bits(cfg_len / sizeof(h2c->w0),
 				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
 		  le32_encode_bits(sizeof(*macc_role) / sizeof(macc_role->w0),
 				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_MACC) |
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cde8fd34723b..d9e1f27699ed 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3063,6 +3063,8 @@ struct rtw89_h2c_scanofld_be {
 	__le32 w7;
 	__le32 w8;
 	__le32 w9; /* Added after SCAN_OFFLOAD_BE_V1 */
+	__le32 w10; /* Added after SCAN_OFFLOAD_BE_V2 */
+	__le32 w11; /* Added after SCAN_OFFLOAD_BE_V2 */
 	/* struct rtw89_h2c_scanofld_be_macc_role (flexible number) */
 	/* struct rtw89_h2c_scanofld_be_opch (flexible number) */
 } __packed;
-- 
2.25.1


