Return-Path: <linux-wireless+bounces-9268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57190FC70
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68D61C20DE8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0A38385;
	Thu, 20 Jun 2024 05:58:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440512744C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863136; cv=none; b=IL/LqeXnw2gtlr2Kqyx/CmZhjrZ9JaeakkF52uW2ieM5dkNq63S0ML4AsQtR9YdmuvVRGO2tm9Lr3nbsyvNr48kJNwscE363lmZZ/GNh4AYPuj/ZDCPRh28OWctVgiWqADhYTHBLfY6G602Y2TfjWVC/qg2+wGIjKeQWgiamx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863136; c=relaxed/simple;
	bh=s6umNJebEpr0Rf8EMj9Tfn8YS4R9hT1JOg3AqSFDHQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcsF2E28osMnTbSNYKYAQw4Cv5JmvRbk/1UgObWYTdNGbuvVhhUZiGm7yFdo0AiLFJQtt/eiOHn5NZ9UrvYA7FTnIjjdfg9REa1EnZw0PrSEIOpB/CwXtmphV8YapeyJE9tGzO8CbMM9HBnOR+KIkM6CDSadYC1n0r6hj7Bhmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5wqk472577675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5wqk472577675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 4/7] wifi: rtw89: wow: fix GTK offload H2C skbuff issue
Date: Thu, 20 Jun 2024 13:58:22 +0800
Message-ID: <20240620055825.17592-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chih-Kang Chang <gary.chang@realtek.com>

We mistakenly put skb too large and that may exceed skb->end.
Therefore, we fix it.

skbuff: skb_over_panic: text:ffffffffc09e9a9d len:416 put:204 head:ffff8fba=
04eca780 data:ffff8fba04eca7e0 tail:0x200 end:0x140 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:192!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 4747 Comm: kworker/u4:44 Tainted: G           O       6.6.30-02=
659-gc18865c4dfbd #1 86547039b47e46935493f615ee31d0b2d711d35e
Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.262.0 03/18/2021
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:skb_panic+0x5d/0x60
Code: c6 63 8b 8f bb 4c 0f 45 f6 48 c7 c7 4d 89 8b bb 48 89 ce 44 89 d1 41 =
56 53 41 53 ff b0 c8 00 00 00 e8 27 5f 23 00 48 83 c4 20 <0f> 0b 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44
RSP: 0018:ffffaa700144bad0 EFLAGS: 00010282
RAX: 0000000000000089 RBX: 0000000000000140 RCX: 14432c5aad26c900
RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
RBP: ffffaa700144bae0 R08: 0000000000000000 R09: ffffaa700144b920
R10: 00000000ffffdfff R11: ffffffffbc28fbc0 R12: ffff8fba4e57a010
R13: 0000000000000000 R14: ffffffffbb8f8b63 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8fba7bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007999c4ad1000 CR3: 000000015503a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ? __die_body+0x1f/0x70
 ? die+0x3d/0x60
 ? do_trap+0xa4/0x110
 ? skb_panic+0x5d/0x60
 ? do_error_trap+0x6d/0x90
 ? skb_panic+0x5d/0x60
 ? handle_invalid_op+0x30/0x40
 ? skb_panic+0x5d/0x60
 ? exc_invalid_op+0x3c/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? skb_panic+0x5d/0x60
 skb_put+0x49/0x50
 rtw89_fw_h2c_wow_gtk_ofld+0xbd/0x220 [rtw89_core 778b32de31cd1f14df2d6721a=
e99ba8a83636fa5]
 rtw89_wow_resume+0x31f/0x540 [rtw89_core 778b32de31cd1f14df2d6721ae99ba8a8=
3636fa5]
 rtw89_ops_resume+0x2b/0xa0 [rtw89_core 778b32de31cd1f14df2d6721ae99ba8a836=
36fa5]
 ieee80211_reconfig+0x84/0x13e0 [mac80211 818a894e3b77da6298269c59ed7cdff06=
5a4ed52]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 1a793119e2aeb157c4ca4091ff8e1d9ae=
233b59d]
 ? dev_printk_emit+0x51/0x70
 ? _dev_info+0x6e/0x90
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 1a793119e2aeb157c4ca4091ff8e1d9ae=
233b59d]
 wiphy_resume+0x89/0x180 [cfg80211 1a793119e2aeb157c4ca4091ff8e1d9ae233b59d]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 1a793119e2aeb157c4ca4091ff8e1d9ae=
233b59d]
 dpm_run_callback+0x3c/0x140
 device_resume+0x1f9/0x3c0
 ? __pfx_dpm_watchdog_handler+0x10/0x10
 async_resume+0x1d/0x30
 async_run_entry_fn+0x29/0xd0
 process_scheduled_works+0x1d8/0x3d0
 worker_thread+0x1fc/0x2f0
 kthread+0xed/0x110
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x38/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
Modules linked in: ccm 8021q r8153_ecm cdc_ether usbnet r8152 mii dm_integr=
ity async_xor xor async_tx lz4 lz4_compress zstd zstd_compress zram zsmallo=
c uinput rfcomm cmac algif_hash rtw89_8922ae(O) algif_skcipher rtw89_8922a(=
O) af_alg rtw89_pci(O) rtw89_core(O) btusb(O) snd_soc_sst_bxt_da7219_max983=
57a btbcm(O) snd_soc_hdac_hdmi btintel(O) snd_soc_intel_hda_dsp_common snd_=
sof_probes btrtl(O) btmtk(O) snd_hda_codec_hdmi snd_soc_dmic uvcvideo video=
buf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 videobuf2_common snd_sof_p=
ci_intel_apl snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda so=
undwire_intel soundwire_generic_allocation snd_sof_intel_hda_mlink soundwir=
e_cadence snd_sof_pci snd_sof_xtensa_dsp mac80211 snd_soc_acpi_intel_match =
snd_soc_acpi snd_sof snd_sof_utils soundwire_bus snd_soc_max98357a snd_soc_=
avs snd_soc_hda_codec snd_hda_ext_core snd_intel_dspcfg snd_intel_sdw_acpi =
snd_soc_da7219 snd_hda_codec snd_hwdep snd_hda_core veth ip6table_nat xt_MA=
SQUERADE xt_cgroup fuse bluetooth ecdh_generic
 cfg80211 ecc
gsmi: Log Shutdown Reason 0x03
---[ end trace 0000000000000000 ]---

Fixes: ed9a3c0d4dd9 ("wifi: rtw89: wow: construct EAPoL packet for GTK reke=
y offload")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless=
/realtek/rtw89/fw.c
index a907d381ac77..e3fc9f168ae5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6767,10 +6767,8 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwd=
ev,
 	skb_put(skb, len);
 	h2c =3D (struct rtw89_h2c_wow_gtk_ofld *)skb->data;
=20
-	if (!enable) {
-		skb_put_zero(skb, sizeof(*gtk_info));
+	if (!enable)
 		goto hdr;
-	}
=20
 	ret =3D rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
 					   RTW89_PKT_OFLD_TYPE_EAPOL_KEY,
--=20
2.25.1


