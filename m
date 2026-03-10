Return-Path: <linux-wireless+bounces-32817-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAASCtfQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32817-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F6246EDB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EBC33139E2F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD03ECBD2;
	Tue, 10 Mar 2026 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BurH3gtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5733ECBE0
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129760; cv=none; b=Amvl6PEvus3c3qsE5OD/o87CpKHexob/mFEhln882z/XSiB38uKCHzL3fN/KK2k7TM+s0fL1V5J+BiVpItgT4drVtfaDIoPZSZSuZkPvm1L6umQXjo6RGkK01uxZPLklGGLVGRfRW6HEX/v0Fgo6ohI1GjZNsm0UWYMiyX8sKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129760; c=relaxed/simple;
	bh=RiL1iL6mOitApXFOjPjC94/P+1gGFoF6e7cKfym8aS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgGIipmvWmuRLEsO7cXPFJ9zfAgyrYSZeZpH1iJerGH/E0H2h8RBeTE6oUxcscM63KbXJWm0wGFMCqzptO4NfA2g8IyeaxhbKDeLyCfbfgHi7FwuUeEIz6IBJwJXJO0d9GMXvazMVTBZQzNcda7l6xwKqHoYjIxbkQMii5zdCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BurH3gtv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82bp062210636, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129757; bh=02nTLklizkkQwOp509eEvqS/bWoorXDcv4Fu77KniBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BurH3gtvEx1g9fybYEUZw3eKqlBabYsfiEYfgEiQBNf5MW1T8q2tqKqH9DvYU116A
	 9KX8s4T0UmRelvtZBsKShyzOrd1M92Fhf+BCLGb8dJ5sfm+EEKzVuXsEc9augbW4qE
	 tQBJLEVFFAW12Jhn0jWOmtDALHu8Sm/uVBL9eA5P7CGF1UjEY8HGFQye3ENlWp3Vsv
	 EgMCe1BX00AZm+aAuDoY0NOjW9I1mKZAJiOTSORUN/MqayO5r1WikqsU+xuEbBtBln
	 lIBdniIkpcOii2ZeVXa56hyQzEb/XfeAdS19EcJXzMeOhV9MRdgmOKCung1eOYlvk5
	 MNcgFeNtd/zog==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82bp062210636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:37 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Mar 2026 16:02:36 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/13] wifi: rtw89: chan: recalc MLO DBCC mode based on current entity mode
Date: Tue, 10 Mar 2026 16:01:41 +0800
Message-ID: <20260310080146.31113-9-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 800F6246EDB
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
	TAGGED_FROM(0.00)[bounces-32817-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Since MLD vif can do MLSR switch, it may not always run on HW band 0.
But when preparing MCC for MLD + P2P, P2P vif needs to use HW band 0
to handle connection, i.e. uses of HW bands may be different by vif.

The current major role/vif can be indicated through entity mode. So,
based on it, recalculate MLO DBCC mode to change use of HW band.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 61 +++++++++++++++--------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index def9e4f3af59..ceb399fc2b94 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -381,6 +381,23 @@ static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
 	rtw89_swap_chanctx(rtwdev, rtwvif_link->chanctx_idx, cur->chanctx_idx);
 }
 
+static u8 rtw89_entity_role_get_index(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_entity_mode mode;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	switch (mode) {
+	default:
+		WARN(1, "Invalid ent mode: %d\n", mode);
+		fallthrough;
+	case RTW89_ENTITY_MODE_SCC_OR_SMLD:
+	case RTW89_ENTITY_MODE_MCC:
+		return 0;
+	case RTW89_ENTITY_MODE_MCC_PREPARE:
+		return 1;
+	}
+}
+
 const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 					       const char *caller_message,
 					       u8 link_index, bool nullchk)
@@ -388,7 +405,6 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	enum rtw89_chanctx_idx chanctx_idx;
-	enum rtw89_entity_mode mode;
 	u8 role_index;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
@@ -399,19 +415,7 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 		goto dflt;
 	}
 
-	mode = rtw89_get_entity_mode(rtwdev);
-	switch (mode) {
-	case RTW89_ENTITY_MODE_SCC_OR_SMLD:
-	case RTW89_ENTITY_MODE_MCC:
-		role_index = 0;
-		break;
-	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		role_index = 1;
-		break;
-	default:
-		WARN(1, "Invalid ent mode: %d\n", mode);
-		goto dflt;
-	}
+	role_index = rtw89_entity_role_get_index(rtwdev);
 
 	chanctx_idx = mgnt->chanctx_tbl[role_index][link_index];
 	if (chanctx_idx == RTW89_CHANCTX_IDLE)
@@ -479,10 +483,28 @@ rtw89_entity_sel_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
 	}
 }
 
-static
-void rtw89_entity_recalc_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
+static void rtw89_entity_recalc_mlo_dbcc_mode(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
 	enum rtw89_mlo_dbcc_mode mode;
+	struct rtw89_vif *role;
+	u8 active_hws = 0;
+	u8 ridx;
+
+	ridx = rtw89_entity_role_get_index(rtwdev);
+	role = mgnt->active_roles[ridx];
+	if (role) {
+		struct rtw89_vif_link *link;
+		int i;
+
+		for (i = 0; i < role->links_inst_valid_num; i++) {
+			link = rtw89_vif_get_link_inst(role, i);
+			if (!link || !link->chanctx_assigned)
+				continue;
+
+			active_hws |= BIT(i);
+		}
+	}
 
 	mode = rtw89_entity_sel_mlo_dbcc_mode(rtwdev, active_hws);
 	rtwdev->mlo_dbcc_mode = mode;
@@ -496,7 +518,6 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_vif_link *link;
 	struct rtw89_vif *role;
-	u8 active_hws = 0;
 	u8 pos = 0;
 	int i, j;
 
@@ -545,13 +566,10 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 				continue;
 
 			mgnt->chanctx_tbl[pos][i] = link->chanctx_idx;
-			active_hws |= BIT(i);
 		}
 
 		mgnt->active_roles[pos++] = role;
 	}
-
-	rtw89_entity_recalc_mlo_dbcc_mode(rtwdev, active_hws);
 }
 
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
@@ -621,6 +639,9 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		return rtw89_get_entity_mode(rtwdev);
 
 	rtw89_set_entity_mode(rtwdev, mode);
+
+	rtw89_entity_recalc_mlo_dbcc_mode(rtwdev);
+
 	return mode;
 }
 
-- 
2.25.1


