Return-Path: <linux-wireless+bounces-30159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDACE5C7F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116E530081A8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C12204C36;
	Mon, 29 Dec 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AukcTIUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C7230D35
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977850; cv=none; b=R0iZLuwVLi3tZMQ3iyt/AEI4eEMZfNTm4gVfe+qN230JIejDaSJr3MBU8qanX0FEhCsIuJ2S4eBlfioluGwxp48Ci86RUTvtPgmzD2F+1TlLtHMIpmZ33o93HHa1EpLlx/0ic46V8W3zDJmxLgaA2CqXTskLh4ibUp/3DCoLVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977850; c=relaxed/simple;
	bh=Tc+0YR6TK49pflaIWAzhtXFS29I7DbKVFZQyOL+F/ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKQBSgtBXC9a5iQ/xjzGMrHBglBbIu0v9pgJ06L4g3vy/lJ1V/3zfDN3yz6rqAFkJLX4nV1G1pTnsA06RYnzKsr1b/cFXPG5emU48DeTqk4w4hJawYDkL/7Mb1n+DeYmkdCI4rARzPTclzDPYKoNAb28XzyxB9NMFaEe36dRMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AukcTIUX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3AkRkA283555, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977846; bh=cNA0Vj5FLpUFzLrhzKi5br5VvjH37+SgOkLvMlTwD2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AukcTIUX6vvO5JM5JgEV94w2jQSjWQy4UWKXwUuFFSAEMhGyoxaIqAixtbN4TJ69/
	 Yk+EoL3d8wcYBf3ajrfqhds6fFAOSvByg01XZBNLFeo97x7/taOL3tT5mfdSg8BSsC
	 tSsEABzwNxXnP4N2t5enIWli07troE/s5gcdXiAIiVD/YF3CRTyVY8QYiXpmltNIL7
	 +x+qbBVpgfb9TQiX8R23dL5Jac385kHdeRvWBs/8WiV6gwcHwTHz1m9/TW5799Xd4+
	 wuZ0mRc8f1VfQr9DS5j6c1AuZS4Ub+54+gA3ril/2tSNhgZkFAjXOPF9po8NdokDdZ
	 h7p7gZBxoK6mQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3AkRkA283555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:47 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 12/12] wifi: rtw89: enhance connection stability when triggering beacon loss
Date: Mon, 29 Dec 2025 11:09:26 +0800
Message-ID: <20251229030926.27004-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

If the driver supports ack status reports of TX frames, mac80211 allows it
to detect AP if it's alive and determine whether the client can maintain
the connection by sending null-data. Therefore, refine the flow to let
driver inform mac80211 to enable beacon loss work to track AP's status
upon receiving beacon loss event.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 91854ae9a310..1375ab324a8b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5253,10 +5253,10 @@ rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 			if (start_detect)
 				return;
 
-			ieee80211_connection_loss(vif);
-		} else {
-			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
+			ieee80211_beacon_loss(vif);
 		}
+
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, true);
 		return;
 	case RTW89_BCN_FLTR_NOTIFY:
 		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
-- 
2.25.1


