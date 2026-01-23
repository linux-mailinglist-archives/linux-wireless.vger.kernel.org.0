Return-Path: <linux-wireless+bounces-31101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE1OMOvRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBC6F359
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C55E30156F5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081673559FB;
	Fri, 23 Jan 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rv/+KY2I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9CE2EB859
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132513; cv=none; b=WehkODZwNvxCqrQX7Ot9LbFpcUJf/gCOmDqUSIGRE0sXNvCDK3BKHX9JmItL3mhI2JUt7zu84vX8BAi8TbZqNBiaQto7e1A2NbMjtY482HJSCkr8TdW6FRwRY/qIgv64sRf0+U6P/jvqPBpVLiWfd+p7oFeNzOXQYE+GtZIkPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132513; c=relaxed/simple;
	bh=EB0BpTPe06fqA1BVhMHoRstkP5m19oN7ohLdCKyJVMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNvP+DVQ6IcQjpOvBtfD2gsWF4bVkVddM4qToE3JuEEtoXNhSa6uWF56Q1n500CgiXcG7mjyjOrus3pp8qOtC9Nxwz+rVNDRNtopsD+W4LjT/goSull5j+gSs2wJKgq44r8YnpTexGhm4Alrm14AKDDb2xvXL6+zU1NtXD8FEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rv/+KY2I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1fNIJ12206898, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132483; bh=lulS1dVX1sDYeP9U2fM7MrX+XDjNWw0mYxlH45jW+M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rv/+KY2IZb4SyJ1lw/9Vx/1pf9DbG0kTOATYeQe/RyiTKsPQjRExoB4d9RwGMuzgf
	 f/ssZSGQg64Owe3ClZntDUXf8Ibijdf2+5CSGv0/cOxaIbr2tdEZmuynyfquaPXZ9x
	 RDJABnaNTi9gJkvogwuKJL5tV8qkpoeYFRIoCsqLIbCkekcbROHBhCoS2xqkjjOMAE
	 K+0tkxNdtGkTLGrR0TLr8OmCQYEbz64XmJ8ebl0UlYKICOggm+Z95K0+6bU0G9wrqS
	 k65rL6zxaIhRkNV5vxSxWingcx/RUMJiibxsCmZc63dEUdC84h1wwwjA6xlENOc+4k
	 Zeb90/m3DSXjQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1fNIJ12206898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:41:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:22 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:41:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: get designated link to replace link instance 0
Date: Fri, 23 Jan 2026 09:39:55 +0800
Message-ID: <20260123013957.16418-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31101-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BFBC6F359
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Clean up some places where still to get link instance 0 directly.
Since now MLSR switch is supported, it's not guaranteed to always
run on link instance 0. So, prefer to get designated link in most
cases.

For now, the only exception is MCC (multi-channel concurrency) case.
How to fill content of its H2C command depends on how to choose link
instance, so cannot simply change it as above. Will handle MCC case
separately afterwards.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 8 ++++----
 drivers/net/wireless/realtek/rtw89/fw.c       | 7 ++-----
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index c0af61992226..9b2f6f0a00fd 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -372,8 +372,8 @@ static void rtw89_normalize_link_chanctx(struct rtw89_dev *rtwdev,
 	if (unlikely(!rtwvif_link->chanctx_assigned))
 		return;
 
-	cur = rtw89_vif_get_link_inst(rtwvif, 0);
-	if (!cur || !cur->chanctx_assigned)
+	cur = rtw89_get_designated_link(rtwvif);
+	if (unlikely(!cur) || !cur->chanctx_assigned)
 		return;
 
 	if (cur == rtwvif_link)
@@ -522,8 +522,8 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 	}
 
 	/* To be consistent with legacy behavior, expect the first active role
-	 * which uses RTW89_CHANCTX_0 to put at position 0, and make its first
-	 * link instance take RTW89_CHANCTX_0. (normalizing)
+	 * which uses RTW89_CHANCTX_0 to put at position 0 and its designated
+	 * link take RTW89_CHANCTX_0. (normalizing)
 	 */
 	list_for_each_entry(role, &mgnt->active_list, mgnt_entry) {
 		for (i = 0; i < role->links_inst_valid_num; i++) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9e88fd6d735a..f84726f04669 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -9027,12 +9027,9 @@ static void rtw89_hw_scan_set_extra_op_info(struct rtw89_dev *rtwdev,
 		if (tmp == scan_rtwvif)
 			continue;
 
-		tmp_link = rtw89_vif_get_link_inst(tmp, 0);
-		if (unlikely(!tmp_link)) {
-			rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
-				    "hw scan: no HW-0 link for extra op\n");
+		tmp_link = rtw89_get_designated_link(tmp);
+		if (unlikely(!tmp_link))
 			continue;
-		}
 
 		tmp_chan = rtw89_chan_get(rtwdev, tmp_link->chanctx_idx);
 		*ext = (struct rtw89_hw_scan_extra_op){
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index ba71709a9bc9..315bb0d0759f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1438,9 +1438,9 @@ static void rtw89_ops_channel_switch_beacon(struct ieee80211_hw *hw,
 
 	BUILD_BUG_ON(RTW89_MLD_NON_STA_LINK_NUM != 1);
 
-	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
+	rtwvif_link = rtw89_get_designated_link(rtwvif);
 	if (unlikely(!rtwvif_link)) {
-		rtw89_err(rtwdev, "chsw bcn: find no link on HW-0\n");
+		rtw89_err(rtwdev, "chsw bcn: find no designated link\n");
 		return;
 	}
 
-- 
2.25.1


