Return-Path: <linux-wireless+bounces-24251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF8ADECFC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675E53B3262
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50A145FE0;
	Wed, 18 Jun 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ic1q443g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED932556E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250862; cv=none; b=dt2fgfICkUtB7O/SrQ+e/8nDvUIWJA4NlNqQAmuAQBoeNVZ/pvCqGkyfB3OMzGrZfdb5Lk9OB8vzHIAlGlBCMKyJyKOosK4dqhvUoNjKC3xPpPQsr7j9u0WaXHZvlqHafvcDPcXyjBFQiNsV52zat/9R4WjqybJNC5qWHJgFH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250862; c=relaxed/simple;
	bh=oVhMMkm4Mw9VQyg4hgDbQkJ5FUr3Dz0Rb10zyDzbEhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp8jk0oHKPm1Ivl+SYuHkV6SmS2OApbli6uPlp0/j1XObN4BR8o5r9ZPsrxORskP26ieT1btD17pE1RN5oj1DPxrzMfuGrQzKQZnxc3GXE3e7Kqp0Fy2n5AP66lZB3ehk76meiSaQXpMcLKDpySkhzDSiklm/FXB4juqWYUquQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ic1q443g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClc8mB4151177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250858; bh=/iR8sYjZ8V53I+rXLivILD3GuuSKQWm67TxpCIKva2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ic1q443gA3xTPm4R3rBFUURLOVIcGujB7UiTeElg/cFjNwjLIUiw6brmO0oHBGT7+
	 lE9yxP3UnmX9Oda1ginv5O+jag+SUxO9j+i/D4RzU9hH9aMczV234eEVak3NQjEjo+
	 nft+O4+0EQDNns1CGETpVDA3vgO3t2zm5ON45BrctEFuBmZGAyC/FVNjTyZEU+kE1/
	 VCpvJ2R5AHm7kcDQgxdOeIFtdj9QzpNu079ezRNz1W/WFh3sPObU9c1xkQDXDFKKP6
	 Ks4hO+MOGPVHkjPxrtAXL5ikqFnOV3GwVnAus1O10RR/E+Vx0P/1DhMipuuiPB+aO3
	 mKRpv3/SJCaTQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClc8mB4151177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 20:47:45 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/6] wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band
Date: Wed, 18 Jun 2025 20:46:47 +0800
Message-ID: <20250618124649.11436-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618124649.11436-1-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

With a quite rare chance, RX report might be problematic to make SW think
a packet is received on 6 GHz band even if the chip does not support 6 GHz
band actually. Since SW won't initialize stuffs for unsupported bands, NULL
dereference will happen then in the sequence, rtw89_vif_rx_stats_iter() ->
rtw89_core_cancel_6ghz_probe_tx(). So, add a check to avoid it.

The following is a crash log for this case.

 BUG: kernel NULL pointer dereference, address: 0000000000000032
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 1907 Comm: irq/131-rtw89_p Tainted: G     U             6.6.56-05896-g89f5fb0eb30b #1 (HASH:1400 4)
 Hardware name: Google Telith/Telith, BIOS Google_Telith.15217.747.0 11/12/2024
 RIP: 0010:rtw89_vif_rx_stats_iter+0xd2/0x310 [rtw89_core]
 Code: 4c 89 7d c8 48 89 55 c0 49 8d 44 24 02 48 89 45 b8 45 31 ff eb 11
 41 c6 45 3a 01 41 b7 01 4d 8b 6d 00 4d 39 f5 74 42 8b 43 10 <41> 33 45
 32 0f b7 4b 14 66 41 33 4d 36 0f b7 c9 09 c1 74 d8 4d 85
 RSP: 0018:ffff9f3080138ca0 EFLAGS: 00010246
 RAX: 00000000b8bf5770 RBX: ffff91b5e8c639c0 RCX: 0000000000000011
 RDX: ffff91b582de1be8 RSI: 0000000000000000 RDI: ffff91b5e8c639e6
 RBP: ffff9f3080138d00 R08: 0000000000000000 R09: 0000000000000000
 R10: ffff91b59de70000 R11: ffffffffc069be50 R12: ffff91b5e8c639e4
 R13: 0000000000000000 R14: ffff91b5828020b8 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff91b8efa40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000032 CR3: 00000002bf838000 CR4: 0000000000750ee0
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? __die_body+0x68/0xb0
  ? page_fault_oops+0x379/0x3e0
  ? exc_page_fault+0x4f/0xa0
  ? asm_exc_page_fault+0x22/0x30
  ? __pfx_rtw89_vif_rx_stats_iter+0x10/0x10 [rtw89_core (HASH:1400 5)]
  ? rtw89_vif_rx_stats_iter+0xd2/0x310 [rtw89_core (HASH:1400 5)]
  __iterate_interfaces+0x59/0x110 [mac80211 (HASH:1400 6)]
  ? __pfx_rtw89_vif_rx_stats_iter+0x10/0x10 [rtw89_core (HASH:1400 5)]
  ? __pfx_rtw89_vif_rx_stats_iter+0x10/0x10 [rtw89_core (HASH:1400 5)]
  ieee80211_iterate_active_interfaces_atomic+0x36/0x50 [mac80211 (HASH:1400 6)]
  rtw89_core_rx_to_mac80211+0xfd/0x1b0 [rtw89_core (HASH:1400 5)]
  rtw89_core_rx+0x43a/0x980 [rtw89_core (HASH:1400 5)]

Fixes: c6aa9a9c4725 ("wifi: rtw89: add RNR support for 6 GHz scan")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d0d2ca31b376..0babf5472195 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2161,6 +2161,11 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 	if (rx_status->band != NL80211_BAND_6GHZ)
 		return;
 
+	if (unlikely(!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "invalid rx on unsupported 6 GHz\n");
+		return;
+	}
+
 	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, ies, skb->len);
 
 	list_for_each_entry(info, &pkt_list[NL80211_BAND_6GHZ], list) {
-- 
2.25.1


