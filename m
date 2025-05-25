Return-Path: <linux-wireless+bounces-23375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B749AC3293
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 08:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A0D177C7C
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE511CA0;
	Sun, 25 May 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iCdUV0BB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85228F6C;
	Sun, 25 May 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748153510; cv=none; b=SzPdvmOUUFj4f9LKNb+FFosTDCyfrgur5WjW3pCMbuCEKMJ0SI0jUbViyY0ES4ouJHgxb4Z/3P5ZMxDknT5+xOLTDF1s9rUCzfdZTt5ogYptqaHf3RgfjR9wttZCbliSMgJLPK1kCH/pC2eXgPkx8X+tpeH6IPKiXofzwKLdwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748153510; c=relaxed/simple;
	bh=X174vY2Xy2RURor/0hed6ok5tcoOrHGOBMFbX/Sp+uQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4nNf6DpgJPKSJwgg4t+yd7SNZHuoVg+Fyz9hYYmxlGTK35R//a9ekHK6A6fvms/5jFQALJulRPYAFZ0s2/qQeGpTXdevsN288sIvjr702OZlkHz2WIBn4QKBiQ13M9ypEFTVTgvymYHJN7go91BeG94Qi4GbGiVj1mw9akCG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iCdUV0BB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2106af10392f11f082f7f7ac98dee637-20250525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0Gn7NNWLkMHAAhjbJ1ZphNA+xGZ5+S0qvLEgv0+Xp9Y=;
	b=iCdUV0BBQ7e3iSUNMUJ0n/qxrnZSDeTxI03nk5TTnB67o490ly/jpSKjNOwQQO/KgFdsZNnkF//TJpbS5I884W5gNZKBLEfnUY/BOcSeDodupV08POrpUknDpPs1tWy1nQ7Kj0iMVtKotamO4Q/yR7k2HuYUvqnDN444PcByKEI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:db8a56cb-e5dc-44ea-a19a-37a7cffe4659,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8378f157-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2106af10392f11f082f7f7ac98dee637-20250525
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1259638594; Sun, 25 May 2025 14:11:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 25 May 2025 14:11:28 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 25 May 2025 14:11:39 +0800
From: Deren Wu <Deren.Wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Allan Wang <allan.wang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Ryder Lee
	<ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()
Date: Sun, 25 May 2025 14:11:21 +0800
Message-ID: <35aedbffa050e98939264300407a52ba4e236d52.1748149855.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Deren Wu <deren.wu@mediatek.com>

Add a NULL check for msta->vif before accessing its members to prevent
a kernel panic in AP mode deployment. This also fix the issue reported
in [1].

The crash occurs when this function is triggered before the station is
fully initialized. The call trace shows a page fault at
mt7925_sta_set_decap_offload() due to accessing resources when msta->vif
is NULL.

Fix this by adding an early return if msta->vif is NULL and also check
wcid.sta is ready. This ensures we only proceed with decap offload
configuration when the station's state is properly initialized.

[14739.655703] Unable to handle kernel paging request at virtual address ffffffffffffffa0
[14739.811820] CPU: 0 UID: 0 PID: 895854 Comm: hostapd Tainted: G
[14739.821394] Tainted: [C]=CRAP, [O]=OOT_MODULE
[14739.825746] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
[14739.831577] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[14739.838538] pc : mt7925_sta_set_decap_offload+0xc0/0x1b8 [mt7925_common]
[14739.845271] lr : mt7925_sta_set_decap_offload+0x58/0x1b8 [mt7925_common]
[14739.851985] sp : ffffffc085efb500
[14739.855295] x29: ffffffc085efb500 x28: 0000000000000000 x27: ffffff807803a158
[14739.862436] x26: ffffff8041ececb8 x25: 0000000000000001 x24: 0000000000000001
[14739.869577] x23: 0000000000000001 x22: 0000000000000008 x21: ffffff8041ecea88
[14739.876715] x20: ffffff8041c19ca0 x19: ffffff8078031fe0 x18: 0000000000000000
[14739.883853] x17: 0000000000000000 x16: ffffffe2aeac1110 x15: 000000559da48080
[14739.890991] x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000000
[14739.898130] x11: 0a10020001008e88 x10: 0000000000001a50 x9 : ffffffe26457bfa0
[14739.905269] x8 : ffffff8042013bb0 x7 : ffffff807fb6cbf8 x6 : dead000000000100
[14739.912407] x5 : dead000000000122 x4 : ffffff80780326c8 x3 : 0000000000000000
[14739.919546] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8041ececb8
[14739.926686] Call trace:
[14739.929130]  mt7925_sta_set_decap_offload+0xc0/0x1b8 [mt7925_common]
[14739.935505]  ieee80211_check_fast_rx+0x19c/0x510 [mac80211]
[14739.941344]  _sta_info_move_state+0xe4/0x510 [mac80211]
[14739.946860]  sta_info_move_state+0x1c/0x30 [mac80211]
[14739.952116]  sta_apply_auth_flags.constprop.0+0x90/0x1b0 [mac80211]
[14739.958708]  sta_apply_parameters+0x234/0x5e0 [mac80211]
[14739.964332]  ieee80211_add_station+0xdc/0x190 [mac80211]
[14739.969950]  nl80211_new_station+0x46c/0x670 [cfg80211]
[14739.975516]  genl_family_rcv_msg_doit+0xdc/0x150
[14739.980158]  genl_rcv_msg+0x218/0x298
[14739.983830]  netlink_rcv_skb+0x64/0x138
[14739.987670]  genl_rcv+0x40/0x60
[14739.990816]  netlink_unicast+0x314/0x380
[14739.994742]  netlink_sendmsg+0x198/0x3f0
[14739.998664]  __sock_sendmsg+0x64/0xc0
[14740.002324]  ____sys_sendmsg+0x260/0x298
[14740.006242]  ___sys_sendmsg+0xb4/0x110

Cc: stable@vger.kernel.org
Link: https://github.com/morrownr/USB-WiFi/issues/603 [1]
Fixes: b859ad65309a ("wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 94b0099dcd41..320011fc3073 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1603,6 +1603,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 	unsigned long valid = mvif->valid_links;
 	u8 i;
 
+	if (!msta->vif)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	valid = ieee80211_vif_is_mld(vif) ? mvif->valid_links : BIT(0);
@@ -1617,6 +1620,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 		else
 			clear_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
 
+		if (!mlink->wcid.sta)
+			continue;
+
 		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, i);
 	}
 
-- 
2.18.0


