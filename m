Return-Path: <linux-wireless+bounces-19092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F913A39157
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 04:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182D23B1FC3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 03:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFB156C62;
	Tue, 18 Feb 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tUmx8OtJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB915B115;
	Tue, 18 Feb 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849636; cv=none; b=P8UsmzDMAVFCDsWcFnWtZZgMNXA/EwMrepAi5gT4E+78oXzV0Y/Ia14tgFq5fz9U3/Lrbfv6hFNVSoKwm4luOhdNgNLV0U1fYyZc44oMit5/3tX66Oau2H3K9oFmPkWzayM1CNiHJNLniIDHFvICQwkQ34zvlbr4ggst0TnOj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849636; c=relaxed/simple;
	bh=g3CVzc0N4QCovs4cPbDtedwoOVxTlanqyloRgtqqMl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkSWVcZau/cZP1saFx7C6U2pyW9H5zpSSAR2Hc2hnwrwz6AI2a6OsBt9dU1O6JQFn9oD1F49l1LtKa6IkvWdTCsiUX3fXxHXZa8VlXJdcb2Cw2QHstRZnjGqUeWV1QwfiDe9vvCyaECxBI2idc33YosfHlnfRBiV6tqAtm800iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tUmx8OtJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 28945dc6eda911efaae1fd9735fae912-20250218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jYfLsQz2vVDXyMu7G7dGGNxPBYtbHclJtLhy9S100qM=;
	b=tUmx8OtJiCl3XNJi+vKA1IZmEeORwuvrfLhu6uUi96RPPtE2GJ+TRPRe8QdKwD15Y5JZGfnAgx4Z6XdiGtbCRG72k37sZ5J1Rc+pOOak3PridAq+CdhslYg4NJM1OnRA6LP8eWNzq008iiO29LcH8OypTlvnhU5HPre1d+Ecg9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:48e772b0-f9f0-43a1-bfdf-afa85c1c3ad4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:6a007aa3-3e52-4e5b-a515-5e42bbdb1515,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 28945dc6eda911efaae1fd9735fae912-20250218
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2007115265; Tue, 18 Feb 2025 11:33:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 18 Feb 2025 11:33:44 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 18 Feb 2025 11:33:44 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>, <kvalo@kernel.org>,
	<kuba@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Nick Morrow <usbwifi2024@gmail.com>,
	<stable@vger.kernel.org>, Salah Coronya <salah.coronya@gmail.com>
Subject: [net-next, v3] wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
Date: Tue, 18 Feb 2025 11:33:42 +0800
Message-ID: <20250218033343.1999648-1-mingyen.hsieh@mediatek.com>
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

Address a kernel panic caused by a null pointer dereference in the
`mt792x_rx_get_wcid` function. The issue arises because the `deflink` structure
is not properly initialized with the `sta` context. This patch ensures that the
`deflink` structure is correctly linked to the `sta` context, preventing the 
null pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000400
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 UID: 0 PID: 470 Comm: mt76-usb-rx phy Not tainted 6.12.13-gentoo-dist #1
 Hardware name:  /AMD HUDSON-M1, BIOS 4.6.4 11/15/2011
 RIP: 0010:mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
 RSP: 0018:ffffa147c055fd98 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff8e9ecb652000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e9ecb652000
 RBP: 0000000000000685 R08: ffff8e9ec6570000 R09: 0000000000000000
 R10: ffff8e9ecd2ca000 R11: ffff8e9f22a217c0 R12: 0000000038010119
 R13: 0000000080843801 R14: ffff8e9ec6570000 R15: ffff8e9ecb652000
 FS:  0000000000000000(0000) GS:ffff8e9f22a00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000400 CR3: 000000000d2ea000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? page_fault_oops+0x15a/0x2f0
  ? search_module_extables+0x19/0x60
  ? search_bpf_extables+0x5f/0x80
  ? exc_page_fault+0x7e/0x180
  ? asm_exc_page_fault+0x26/0x30
  ? mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
  mt7921_queue_rx_skb+0x1c6/0xaa0 [mt7921_common]
  mt76u_alloc_queues+0x784/0x810 [mt76_usb]
  ? __pfx___mt76_worker_fn+0x10/0x10 [mt76]
  __mt76_worker_fn+0x4f/0x80 [mt76]
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

Reported-by: Nick Morrow <usbwifi2024@gmail.com>
Closes: https://github.com/morrownr/USB-WiFi/issues/577
Cc: stable@vger.kernel.org
Fixes: 90c10286b176 ("wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Salah Coronya <salah.coronya@gmail.com>
---
v2:
  - Change Nick from "Tested-by" to "Reported-by".
v3:
  - Rewrite the commit msg in the imperative mood.
  - Remove the boot time for code trace.
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


