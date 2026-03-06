Return-Path: <linux-wireless+bounces-32651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA63OX0gq2mPaAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 19:44:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59699226CF2
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C429303FDDC
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFB36F42A;
	Fri,  6 Mar 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="POk2b+zb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432E145355
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822540; cv=none; b=FUVClfO7DEDcLDGza+YXoJKGRiP/Ytt/QAVnZtO6muh/Hg3B82Q4X0iIKJAgfWvj9CRCRri65I1eOtXOiC2Qd6z4mnClMJW2FnGN46MAV8tUgIkpsbT8H0me/zri2YfphoZV+6wp8mdA+7wLkC3uEBhF3+hOTzkLUCLxSq2bTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822540; c=relaxed/simple;
	bh=4Xo24DLLTxujZE0JO3Fg25pxhxfxAirys6sqCmo2ANw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a3BA6EbnXwZl3RMgIIcO9VsX8TFUCKaoL8NoZR+Dlq4ErGE+jGPjtoMAarXRl7CHzRF2ba0OXC7iop8JqrNySd4Yri8EWTV80ogSCyffXdMe5mC0wEnoaRTM8rSwd/oKY8Stftl8N+AX5OSEzBTB9CNdJEihKyKo2eLHO0jkOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=POk2b+zb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mNLuGNU5CAJLyDAGvDhnpWO3JfvXP9Briqz8QOYvIgM=; b=POk2b+zbRIKrQJWEfnnHF6r2AQ
	EwOwMaHuLdnEM3ShPxRFqNIzs+48oBbuhZKB7GxRgo3EDzB/+ZS5e4eo0PKPfnhIOPJJt7D2c5eo/
	omlxxEFQu4LZaG6J1YYXjpP1/+Wf81ZlwXMsgrZd9RpM6S85Lh9BU7khoOuqs2J42pH55/V2DdaL0
	wgKr/tyLXLVI/MMA/LaYJsXMJD0QUe5fW3cOfqPyy5+8W11Px/16iPq7d5XDnTE9bSJ3GES/CJWYr
	VRhuJJ8lNxMfDI+eNt94v7B7+mnNDRIFUEDJAVg/Wp/sTGCwUkHbIEBO3fVIUD1ZFS1javAiVq65E
	Ze/ZXU5g==;
Received: from 179-125-79-229-dinamico.pombonet.net.br ([179.125.79.229] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vya7j-00ASZd-JM; Fri, 06 Mar 2026 19:42:07 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 06 Mar 2026 15:41:44 -0300
Subject: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
X-B4-Tracking: v=1; b=H4sIAOgfq2kC/x2MQQqAIBAAvyJ7TjA3pPpKRIhttRAWGhVIf886D
 sNMgkiBKUIrEgQ6OfLmM5SFALdYP5PkMTNopY1CZWQ4rroePudpLVFJtIjk0DS6aiBne6CJ73/
 Z9c/zApKrBsliAAAA
X-Change-ID: 20260306-rtw88_channel130-3a33ec369249
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, 
 Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: linux-wireless@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 59699226CF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32651-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.566];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Though 114 and 130 are not usual channels, they are found in the wild with
setups using 5350MHz as the center frequency of a 80MHz setup.

rtw88 supports that, but issues a WARNING because it cannot find the TX
power limit for those channels.

Fix this by using the lower TX power limit from adjacent 40MHz channels.

After that change, there is no WARNING and the 80MHz bandwidth is still
used.

[    9.980715] ------------[ cut here ]------------
[    9.980721] invalid arguments, band=1, bw=2, path=0, rate=44, ch=130
[    9.980726] WARNING: drivers/net/wireless/realtek/rtw88/phy.c:2213 at rtw_get_tx_power_params+0x541/0x920 [rtw88_core], CPU#0: iwd/1227
[    9.980755] Modules linked in: ccm algif_aead des3_ede_x86_64 cbc des_generic libdes md4 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg ramoops snd_soc_acp5x_mach nf_tables reed_solomon bnep joydev mousedev snd_acp5x_pcm_dma snd_acp5x_i2s amdgpu snd_sof_amd_acp63 rtw88_8822ce amd_atl snd_sof_amd_vangogh intel_rapl_msr rtw88_8822c snd_sof_amd_acp intel_rapl_common snd_sof_pci rtw88_pci amdxcp snd_sof kvm_amd rtw88_core i2c_algo_bit snd_sof_utils snd_hda_codec_atihdmi hid_multitouch drm_ttm_helper snd_hda_codec_hdmi snd_sof_xtensa_dsp snd_soc_cs35l41_spi kvm ttm mac80211 btusb snd_pci_ps snd_soc_cs35l41 snd_hda_intel snd_soc_acpi_amd_match btrtl drm_exec snd_soc_cs35l41_lib drm_panel_backlight_quirks snd_soc_acpi_amd_sdca_quirks btintel gpu_sched snd_hda_codec snd_soc_wm_adsp libarc4 snd_soc_sdca irqbypass drm_suballoc_
 helper btbcm snd_soc_nau8821 cs_dsp
[    9.980895]  snd_hwdep ghash_clmulni_intel drm_buddy btmtk spd5118 snd_pci_acp6x aesni_intel cfg80211 snd_soc_core snd_hda_core drm_display_helper atkbd rapl snd_pci_acp5x libps2 snd_intel_dspcfg bluetooth snd_compress snd_acp_config hid_steam snd_intel_sdw_acpi cdc_acm hid_generic vivaldi_fmap wdat_wdt snd_pcm pcspkr tpm_crb rfkill snd_soc_acpi snd_timer ccp cec video sp5100_tco ltrf216a wmi opt3001 tpm_tis i2c_hid_acpi snd i2c_hid industrialio tpm_tis_core soundcore 8250_dw k10temp i2c_piix4 i2c_smbus mac_hid pkcs8_key_parser ntsync hid_playstation led_class_multicolor hid_nintendo ff_memless i2c_dev crypto_user loop dm_mod nfnetlink zram tpm libaescfb overlay ext4 crc16 mbcache jbd2 vfat fat usbhid btrfs libblake2b xor raid6_pq sdhci_pci nvme serio_raw sdhci_uhs2 sdhci nvme_core cqhci nvme_keyring mmc_core i8042 nvme_auth hkdf serio spi_amd
[    9.981052] CPU: 0 UID: 0 PID: 1227 Comm: iwd Not tainted 6.19.0-08324-gf4457a734418 #15 PREEMPT(full)  d98827284d7dd170a54c85b32d8344cb5d6741ce
[    9.981058] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0133 08/05/2024
[    9.981062] RIP: 0010:rtw_get_tx_power_params+0x553/0x920 [rtw88_core]
[    9.981079] Code: 5e 41 5f e9 6f 79 b2 e6 44 8b 5c 24 24 44 88 14 24 48 8d 3d 8f 72 40 00 44 8b 44 24 1c 8b 4c 24 18 89 f2 45 0f b6 cb 44 89 fe <67> 48 0f b9 3a 48 8b 43 38 44 0f b6 14 24 0f b6 68 45 41 88 6e 02
[    9.981083] RSP: 0018:ffffd0cd418f2f10 EFLAGS: 00010246
[    9.981087] RAX: 0000000000000031 RBX: ffff8f3b1ad72060 RCX: 0000000000000000
[    9.981090] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffffffffc13b41d0
[    9.981093] RBP: 00000000000000fa R08: 000000000000002c R09: 0000000000000082
[    9.981096] R10: 0000000000000004 R11: 0000000000000082 R12: 000000000000002c
[    9.981099] R13: 0000000000000000 R14: ffffd0cd418f2f8b R15: 0000000000000001
[    9.981102] FS:  00007f10c85edb80(0000) GS:ffff8f3e85c8f000(0000) knlGS:0000000000000000
[    9.981105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.981108] CR2: 00007f8f50200270 CR3: 00000001244cc000 CR4: 0000000000350ef0
[    9.981111] Call Trace:
[    9.981116]  <TASK>
[    9.981125]  rtw_phy_get_tx_power_index+0x43/0x180 [rtw88_core da6d95ee8f8ea7f3fd6d7370ca8f98e1f6d9c5c7]
[    9.981147]  rtw_phy_set_tx_power_level+0xdc/0x140 [rtw88_core da6d95ee8f8ea7f3fd6d7370ca8f98e1f6d9c5c7]
[    9.981168]  rtw_set_channel+0xb7/0x130 [rtw88_core da6d95ee8f8ea7f3fd6d7370ca8f98e1f6d9c5c7]
[    9.981188]  rtw_ops_config+0x81/0xc0 [rtw88_core da6d95ee8f8ea7f3fd6d7370ca8f98e1f6d9c5c7]
[    9.981207]  drv_config+0x2b/0xd0 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981276]  ieee80211_add_chanctx+0x57/0x130 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981352]  ieee80211_new_chanctx+0x33/0xc0 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981432]  _ieee80211_link_use_channel+0x2da/0x360 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981550]  ieee80211_prep_channel+0x2ef/0x550 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981686]  ieee80211_prep_connection+0x20a/0x500 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981807]  ieee80211_mgd_auth+0x2c5/0x4f0 [mac80211 bbf26b8ca8c7853f2522289e0ff504e0b8b8a571]
[    9.981904]  ? srso_return_thunk+0x5/0x5f
[    9.981912]  ? srso_return_thunk+0x5/0x5f
[    9.981917]  ? __cfg80211_get_bss+0x1e9/0x2d0 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.981986]  cfg80211_mlme_auth+0xb7/0x1b0 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982052]  cfg80211_conn_do_work+0x449/0x490 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982147]  cfg80211_connect+0x3ac/0x7a0 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982209]  nl80211_connect+0x624/0x8a0 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982269]  ? srso_return_thunk+0x5/0x5f
[    9.982274]  ? _copy_to_iter+0x8d/0x5f0
[    9.982295]  genl_family_rcv_msg_doit+0x103/0x160
[    9.982309]  genl_rcv_msg+0x1b5/0x2c0
[    9.982315]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982372]  ? __pfx_nl80211_connect+0x10/0x10 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982426]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211 6f7b2df30576ef94720b632aca066e9e39311de2]
[    9.982482]  ? __pfx_genl_rcv_msg+0x10/0x10
[    9.982488]  netlink_rcv_skb+0x52/0x100
[    9.982499]  genl_rcv+0x28/0x40
[    9.982504]  netlink_unicast+0x28a/0x3e0
[    9.982511]  netlink_sendmsg+0x228/0x480
[    9.982520]  __sys_sendto+0x1f1/0x200
[    9.982535]  __x64_sys_sendto+0x24/0x30
[    9.982539]  do_syscall_64+0x11b/0x7e0
[    9.982546]  ? srso_return_thunk+0x5/0x5f
[    9.982550]  ? do_syscall_64+0x11b/0x7e0
[    9.982556]  ? srso_return_thunk+0x5/0x5f
[    9.982560]  ? __sys_sendmsg+0x88/0xf0
[    9.982564]  ? __seccomp_filter+0x42/0x5d0
[    9.982574]  ? srso_return_thunk+0x5/0x5f
[    9.982578]  ? do_syscall_64+0x11b/0x7e0
[    9.982585]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    9.982591] RIP: 0033:0x7f10c8681006
[    9.982596] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[    9.982599] RSP: 002b:00007ffdebfc83a0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[    9.982605] RAX: ffffffffffffffda RBX: 00005596e451b8f0 RCX: 00007f10c8681006
[    9.982608] RDX: 0000000000000068 RSI: 00005596e453cc80 RDI: 0000000000000004
[    9.982611] RBP: 00007ffdebfc83c0 R08: 0000000000000000 R09: 0000000000000000
[    9.982613] R10: 0000000000000000 R11: 0000000000000202 R12: 00005596e453cc80
[    9.982616] R13: 00005596e453d040 R14: 0000000000000001 R15: 0000000000000000
[    9.982626]  </TASK>
[    9.982629] ---[ end trace 0000000000000000 ]---

Fixes: fa6dfe6bff24 ("rtw88: resolve order of tx power setting routines")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtw88/main.h |  2 +-
 drivers/net/wireless/realtek/rtw88/phy.c  | 36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1ab70214ce36eb1785a6f642b83cc30748d9ec18..652120f7397f5a58ec2e7364fdf4e52f7340e63a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -47,7 +47,7 @@ extern bool rtw_edcca_enabled;
 extern const struct ieee80211_ops rtw_ops;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
-#define RTW_MAX_CHANNEL_NUM_5G 49
+#define RTW_MAX_CHANNEL_NUM_5G 51
 
 struct rtw_dev;
 struct rtw_debugfs;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e2ac5c6fd5002996534e061b6f45dfdd65728525..af9f7f3550890469f9dd58aa7aad8ec30ad596cf 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1602,7 +1602,9 @@ static const u8 rtw_channel_idx_5g[RTW_MAX_CHANNEL_NUM_5G] = {
 	36,  38,  40,  42,  44,  46,  48, /* Band 1 */
 	52,  54,  56,  58,  60,  62,  64, /* Band 2 */
 	100, 102, 104, 106, 108, 110, 112, /* Band 3 */
+	114, /* Compute from adjacent center frequencies */
 	116, 118, 120, 122, 124, 126, 128, /* Band 3 */
+	130, /* Compute from adjacent center frequencies */
 	132, 134, 136, 138, 140, 142, 144, /* Band 3 */
 	149, 151, 153, 155, 157, 159, 161, /* Band 4 */
 	165, 167, 169, 171, 173, 175, 177}; /* Band 4 */
@@ -1732,6 +1734,38 @@ static void rtw_xref_txpwr_lmt(struct rtw_dev *rtwdev)
 		rtw_xref_txpwr_lmt_by_bw(rtwdev, regd);
 }
 
+static void
+__cfg_txpwr_lmt_extra_channels(struct rtw_hal *hal, u8 regd, u8 bw, u8 rs)
+{
+	u8 channels[] = { 114, 130 };
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(channels); i++) {
+		int idx, upper_idx, lower_idx;
+		int upper_limit, lower_limit;
+
+		idx = rtw_channel_to_idx(PHY_BAND_5G, channels[i]);
+		upper_idx = rtw_channel_to_idx(PHY_BAND_5G, channels[i] + 4);
+		lower_idx = rtw_channel_to_idx(PHY_BAND_5G, channels[i] - 4);
+		if (idx < 0 || upper_idx < 0 || lower_idx < 0)
+			WARN(1, "invalid channel index when computing TX power limit for extra channels");
+		upper_limit = hal->tx_pwr_limit_5g[regd][bw][rs][upper_idx];
+		lower_limit = hal->tx_pwr_limit_5g[regd][bw][rs][lower_idx];
+		hal->tx_pwr_limit_5g[regd][bw][rs][idx] = min(lower_limit, upper_limit);
+	}
+}
+
+static void
+rtw_cfg_twpwr_lmt_extra_channels(struct rtw_dev *rtwdev, u8 regd)
+{
+	u8 bw, rs;
+
+	for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
+			__cfg_txpwr_lmt_extra_channels(&rtwdev->hal, regd,
+						       bw, rs);
+}
+
 static void
 __cfg_txpwr_lmt_by_alt(struct rtw_hal *hal, u8 regd, u8 regd_alt, u8 bw, u8 rs)
 {
@@ -1773,6 +1807,8 @@ void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
 	}
 
 	for (i = 0; i < RTW_REGD_MAX; i++) {
+		rtw_cfg_twpwr_lmt_extra_channels(rtwdev, i);
+
 		if (i == RTW_REGD_WW)
 			continue;
 

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260306-rtw88_channel130-3a33ec369249

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


