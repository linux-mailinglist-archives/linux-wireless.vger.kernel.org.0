Return-Path: <linux-wireless+bounces-13149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532298581B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380AC1C22F8F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96519176FA5;
	Wed, 25 Sep 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiVJfisW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85B175D50;
	Wed, 25 Sep 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264208; cv=none; b=UhvPXQfyiHSXUXjszqEsXVjqsYLV3F/0VVUiw7CbKjMgyFvf0BPP+3cmBnbOByisevja1KBxsomKSS7Is/t+5nw6qvVeetFF3Op98FhV4S50Je18mndiTodVdZtATEJJX78BxBhUtnaMxptez1d60llFCs0w+QekcL71Gd2nZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264208; c=relaxed/simple;
	bh=o/fBxVrjL1XWHMOP+dpqM/VmoHE6ti9CXX2Wp9k2pNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlAakNBt2L7rKIvgRNKl+5dN4lRHnEXadAa97pO1ggxO2F7ckWsM2IpzkJZc8ePImWSUukxR/8KX7X+scoiueyfn5AXmGALPKMhzCSnRzOJkP1hm22vmqr8ZFwTxlNvuds33TqINfG0VS34RovSu3P2UGoUX9NBtqShLTZDVs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiVJfisW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FA7C4CECE;
	Wed, 25 Sep 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264208;
	bh=o/fBxVrjL1XWHMOP+dpqM/VmoHE6ti9CXX2Wp9k2pNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiVJfisWQRlS2XMLrzBEt3BP6HzkqU45tLzNWmKXXY1GPYiTfCTBTTCRV3rblxysf
	 qtfswUqT9Dv9gPB2uWHQ8GuFO61TSU6YQKU3jjfpwd8hgaOoEoR+OVDfGgFOa49X2I
	 L83y9U0FNdHHqQA0YsYbwi09e5JCpe0BtZHW/W4CmcAkGWWHWULMcEtKT52nVg6Sje
	 MHVIJPf7/jMxqmEUj966pCg3TH+U6NRWME89cccHq6VdX5zMVqkg9rtmDIw638ClFp
	 RZRLXem6mPE7WgveqPvmoUAqwA+g+mZyLwtHnjH57++FZHT69AdUdsRlG0xQkScq/c
	 3xAw9VcB3CTfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	terrelln@fb.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 003/244] wifi: rtw89: avoid to add interface to list twice when SER
Date: Wed, 25 Sep 2024 07:23:44 -0400
Message-ID: <20240925113641.1297102-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 7dd5d2514a8ea58f12096e888b0bd050d7eae20a ]

If SER L2 occurs during the WoWLAN resume flow, the add interface flow
is triggered by ieee80211_reconfig(). However, due to
rtw89_wow_resume() return failure, it will cause the add interface flow
to be executed again, resulting in a double add list and causing a kernel
panic. Therefore, we have added a check to prevent double adding of the
list.

list_add double add: new=ffff99d6992e2010, prev=ffff99d6992e2010, next=ffff99d695302628.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:37!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 9 Comm: kworker/0:1 Tainted: G        W  O       6.6.30-02659-gc18865c4dfbd #1 770df2933251a0e3c888ba69d1053a817a6376a7
Hardware name: HP Grunt/Grunt, BIOS Google_Grunt.11031.169.0 06/24/2021
Workqueue: events_freezable ieee80211_restart_work [mac80211]
RIP: 0010:__list_add_valid_or_report+0x5e/0xb0
Code: c7 74 18 48 39 ce 74 13 b0 01 59 5a 5e 5f 41 58 41 59 41 5a 5d e9 e2 d6 03 00 cc 48 c7 c7 8d 4f 17 83 48 89 c2 e8 02 c0 00 00 <0f> 0b 48 c7 c7 aa 8c 1c 83 e8 f4 bf 00 00 0f 0b 48 c7 c7 c8 bc 12
RSP: 0018:ffffa91b8007bc50 EFLAGS: 00010246
RAX: 0000000000000058 RBX: ffff99d6992e0900 RCX: a014d76c70ef3900
RDX: ffffa91b8007bae8 RSI: 00000000ffffdfff RDI: 0000000000000001
RBP: ffffa91b8007bc88 R08: 0000000000000000 R09: ffffa91b8007bae0
R10: 00000000ffffdfff R11: ffffffff83a79800 R12: ffff99d695302060
R13: ffff99d695300900 R14: ffff99d6992e1be0 R15: ffff99d6992e2010
FS:  0000000000000000(0000) GS:ffff99d6aac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000078fbdba43480 CR3: 000000010e464000 CR4: 00000000001506f0
Call Trace:
 <TASK>
 ? __die_body+0x1f/0x70
 ? die+0x3d/0x60
 ? do_trap+0xa4/0x110
 ? __list_add_valid_or_report+0x5e/0xb0
 ? do_error_trap+0x6d/0x90
 ? __list_add_valid_or_report+0x5e/0xb0
 ? handle_invalid_op+0x30/0x40
 ? __list_add_valid_or_report+0x5e/0xb0
 ? exc_invalid_op+0x3c/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __list_add_valid_or_report+0x5e/0xb0
 rtw89_ops_add_interface+0x309/0x310 [rtw89_core 7c32b1ee6854761c0321027c8a58c5160e41f48f]
 drv_add_interface+0x5c/0x130 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 ieee80211_reconfig+0x241/0x13d0 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 ? finish_wait+0x3e/0x90
 ? synchronize_rcu_expedited+0x174/0x260
 ? sync_rcu_exp_done_unlocked+0x50/0x50
 ? wake_bit_function+0x40/0x40
 ieee80211_restart_work+0xf0/0x140 [mac80211 83e989e6e616bd5b4b8a2b0a9f9352a2c385a3bc]
 process_scheduled_works+0x1e5/0x480
 worker_thread+0xea/0x1e0
 kthread+0xdb/0x110
 ? move_linked_works+0x90/0x90
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork+0x3b/0x50
 ? kthread_associate_blkcg+0xa0/0xa0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: dm_integrity async_xor xor async_tx lz4 lz4_compress zstd zstd_compress zram zsmalloc rfcomm cmac uinput algif_hash algif_skcipher af_alg btusb btrtl iio_trig_hrtimer industrialio_sw_trigger btmtk industrialio_configfs btbcm btintel uvcvideo videobuf2_vmalloc iio_trig_sysfs videobuf2_memops videobuf2_v4l2 videobuf2_common uvc snd_hda_codec_hdmi veth snd_hda_intel snd_intel_dspcfg acpi_als snd_hda_codec industrialio_triggered_buffer kfifo_buf snd_hwdep industrialio i2c_piix4 snd_hda_core designware_i2s ip6table_nat snd_soc_max98357a xt_MASQUERADE xt_cgroup snd_soc_acp_rt5682_mach fuse rtw89_8922ae(O) rtw89_8922a(O) rtw89_pci(O) rtw89_core(O) 8021q mac80211(O) bluetooth ecdh_generic ecc cfg80211 r8152 mii joydev
gsmi: Log Shutdown Reason 0x03
---[ end trace 0000000000000000 ]---

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240731070506.46100-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/util.h     | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1508693032cb2..de3e7e4c6e76b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -126,7 +126,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->rtwdev = rtwdev;
 	rtwvif->roc.state = RTW89_ROC_IDLE;
 	rtwvif->offchan = false;
-	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+
 	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
 	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
 	rtw89_leave_ps_mode(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index e82e7df052d88..e669544cafd3f 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -16,6 +16,24 @@
 #define rtw89_for_each_rtwvif(rtwdev, rtwvif)				       \
 	list_for_each_entry(rtwvif, &(rtwdev)->rtwvifs_list, list)
 
+/* Before adding rtwvif to list, we need to check if it already exist, beacase
+ * in some case such as SER L2 happen during WoWLAN flow, calling reconfig
+ * twice cause the list to be added twice.
+ */
+static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *new)
+{
+	struct rtw89_vif *rtwvif;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif == new)
+			return true;
+
+	return false;
+}
+
 /* The result of negative dividend and positive divisor is undefined, but it
  * should be one case of round-down or round-up. So, make it round-down if the
  * result is round-up.
-- 
2.43.0


