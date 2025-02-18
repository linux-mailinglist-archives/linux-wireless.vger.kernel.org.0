Return-Path: <linux-wireless+bounces-19087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43383A390F4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 03:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD9B3B18EE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9A813BC35;
	Tue, 18 Feb 2025 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qkuublAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F423DE;
	Tue, 18 Feb 2025 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846951; cv=none; b=qOXFCl22sdmi2LU2/t5YGS1buHddagANPWb7vRzBRryo+oYmf8wdvJNwlCThiS3zcFEwmVHGPf/NmR5PoqrjvArz1raXjhj2Jy9W2z7Vv96IO0wbd9MSC+6SIsPUtlG7Ym/4IPmBxPnKpzIX8w305UkSK816N3WFA80n4AUHacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846951; c=relaxed/simple;
	bh=Cz3lmRlek5MdcyXO6MWyF8brss8zw8yovwC4LD3M93E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AdREfAqWXhF4Y87ElJRM5nCgBMDEpScFSLVsIokhgKVlgETabGEKrPudjb5pPc7sjzV9XUb3iw9Rag72Lw/OkbLhmxOujFFMGpctNaLmcxsQFMO9LFECCiXlX4nYeyLiRc5KWUu1q5O9lo408cfKRDjn9kTxqLDtgntrXFizo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qkuublAU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e5a79182eda211ef8eb9c36241bbb6fb-20250218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aCzG46ILYUUUlCOyoDZDIiRQ3h9GZVMZK3na7VCPOX0=;
	b=qkuublAUfF6Fwjr/3lf8ag2tr6Wbp6y/+Nc6ClQXWxnmHX3sqd88NTJg3MsgqMoIOBj12LQKLVTIOkxyR0HZKxdAVdQFXESnV+mfDCBk4+xX8kUYPRekY3B/TZOcjKTeTXGFb7f2iY1TVk7yw3yjKlgDRTAwu6J3iOvPaCXwLC4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a57083eb-534d-4f66-beff-e964f26b5487,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:eb05a4c6-e2f2-45f6-b8aa-31e67885facd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1|19,IP:
	nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e5a79182eda211ef8eb9c36241bbb6fb-20250218
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1726155891; Tue, 18 Feb 2025 10:48:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 18 Feb 2025 10:48:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 18 Feb 2025 10:48:55 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>, <kvalo@kernel.org>,
	<kuba@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Salah Coronya <salah.coronya@gmail.com>,
	<stable@vger.kernel.org>, Nick Morrow <usbwifi2024@gmail.com>
Subject: [net-next] wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
Date: Tue, 18 Feb 2025 10:48:49 +0800
Message-ID: <20250218024849.1993192-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

This patch addresses a kernel panic caused by a null pointer dereference in the
`mt792x_rx_get_wcid` function. The issue arises because the `deflink` structure
is not properly initialized with the `sta` context. This patch ensures that the
`deflink` structure is correctly linked to the `sta` context, preventing the
null pointer dereference.

[   32.098574] BUG: kernel NULL pointer dereference, address: 0000000000000400
[   32.098620] #PF: supervisor read access in kernel mode
[   32.098634] #PF: error_code(0x0000) - not-present page
[   32.098647] PGD 0 P4D 0
[   32.098665] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   32.098683] CPU: 0 UID: 0 PID: 470 Comm: mt76-usb-rx phy Not tainted 6.12.13-gentoo-dist #1
[   32.098703] Hardware name:  /AMD HUDSON-M1, BIOS 4.6.4 11/15/2011
[   32.098717] RIP: 0010:mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
[   32.098776] RSP: 0018:ffffa147c055fd98 EFLAGS: 00010202
[   32.098792] RAX: 0000000000000000 RBX: ffff8e9ecb652000 RCX: 0000000000000000
[   32.098806] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e9ecb652000
[   32.098819] RBP: 0000000000000685 R08: ffff8e9ec6570000 R09: 0000000000000000
[   32.098832] R10: ffff8e9ecd2ca000 R11: ffff8e9f22a217c0 R12: 0000000038010119
[   32.098845] R13: 0000000080843801 R14: ffff8e9ec6570000 R15: ffff8e9ecb652000
[   32.098860] FS:  0000000000000000(0000) GS:ffff8e9f22a00000(0000) knlGS:0000000000000000
[   32.098876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.098889] CR2: 0000000000000400 CR3: 000000000d2ea000 CR4: 00000000000006f0
[   32.098903] Call Trace:
[   32.098918]  <TASK>
[   32.098932]  ? __die_body.cold+0x19/0x27
[   32.098955]  ? page_fault_oops+0x15a/0x2f0
[   32.098975]  ? search_module_extables+0x19/0x60
[   32.098995]  ? search_bpf_extables+0x5f/0x80
[   32.099012]  ? exc_page_fault+0x7e/0x180
[   32.099030]  ? asm_exc_page_fault+0x26/0x30
[   32.099054]  ? mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
[   32.099084]  mt7921_queue_rx_skb+0x1c6/0xaa0 [mt7921_common]
[   32.099114]  mt76u_alloc_queues+0x784/0x810 [mt76_usb]
[   32.099140]  ? __pfx___mt76_worker_fn+0x10/0x10 [mt76]
[   32.099172]  __mt76_worker_fn+0x4f/0x80 [mt76]
[   32.099203]  kthread+0xd2/0x100
[   32.099221]  ? __pfx_kthread+0x10/0x10
[   32.099237]  ret_from_fork+0x34/0x50
[   32.099254]  ? __pfx_kthread+0x10/0x10
[   32.099269]  ret_from_fork_asm+0x1a/0x30
[   32.099290]  </TASK>
[   32.099719] ---[ end trace 0000000000000000 ]---

Reported-by: Salah Coronya <salah.coronya@gmail.com>
Closes: https://github.com/morrownr/USB-WiFi/issues/577
Cc: stable@vger.kernel.org
Fixes: 90c10286b176 ("wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Nick Morrow <usbwifi2024@gmail.com>
Tested-by: Salah Coronya <salah.coronya@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff..78b77a54d195 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -811,6 +811,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->deflink.last_txs = jiffies;
+	msta->deflink.sta = msta;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
-- 
2.45.2


