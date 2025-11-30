Return-Path: <linux-wireless+bounces-29432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A3C95081
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Nov 2025 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B59A4E028F
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Nov 2025 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAF22F16E;
	Sun, 30 Nov 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acsMQfa+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CF23A98E
	for <linux-wireless@vger.kernel.org>; Sun, 30 Nov 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764514236; cv=none; b=R9zaPlDZ2Oa4kgW0izNuI3Pe0EpxeSpPDxeTmwRsOwXO5OgmIJg0UWJHJRpcGhXt1au5s/yFfuE6MHIfKcZi8CtA3VlWO4B4MD+WpFyMMI6qArk6+MlbA37mIsp9wz4bg28Su7kJCiNxvr3bNaQrKvEo9cHpLIfowJSH4+L4O5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764514236; c=relaxed/simple;
	bh=UynDQwBx9FggKBHfj9BeUgQNBvWZU+U9ANZwiiV/tbo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ha7pKNkFOmuXcjHVhY8EcRcPMYcPYXmjGh551t8NWCx5rA/lrAjGg8YfBMz4mmrUgojPpAU/jMwbwBFlaPP994YpENV2a4h3hcnR/MVwPmXqITE+i4xMXtGgJa8DF2S1nyd3X3J8dpBvq97olQ2HP2DaBY8pTD+iL4c45eV4fFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acsMQfa+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e3c3a83so185199f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 30 Nov 2025 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764514233; x=1765119033; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou58zJf3DzAqzV+6QKYSbGgqhgsufNXplkws+o+GGSQ=;
        b=acsMQfa+VAgY2odHKPqru72FnHqsNfC0HOPT/hyYGRII6GZKPHehbidinZbAGPM1CC
         CcOkrXE4HKF54zmOXJMFnUjiJdNq7FFC78tbdFw9Kmu4LC0JUeMZSfgzgTTvZYjhycvA
         VJFpjRdbmQwaucYt9E5bkBfz7f4f5QJiBRjWJSzI87Pq3EklBWTTD73BNAhVDFIUlLyg
         RH+y5djjljXsYLj4T31WidK5beLU7xIBu1fi2tmEAtnLdVOXhnWLB8a2ek/i1ewNOO1O
         rA4bu9ZgdN5fvugrNDE6wSlu6yHtaf6BCoHHUgyDKo8zXwnV63xkQwWgoFzyU6HAKz50
         cSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764514233; x=1765119033;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou58zJf3DzAqzV+6QKYSbGgqhgsufNXplkws+o+GGSQ=;
        b=HOpqWNRHyuzTqjRk7qNaFulYjum1bAxIdi7Zs8DRL5t4M4+QbM5cT9UtxYKXBYE8YP
         MoiYj/D/sJCN0ZhZ1f5JnGcJ2aYxGwk7+aki9D1yPatLQ5VMo2i1SMMdfZOjzmXj0zLh
         G8DTpPlOeACXBH8Hf8nJY3YMIKQuD8SsJD/O+0nAU4koVqOWcew1TLNBvM0ao1J0NpLd
         wRJsC+JUlDflFtR4PfFESdpGEKmd8JG2AHhJUVN8Zz4NyZ2eGtrYe698SyEB0XWlVQqb
         753iU30MpdnYRfaGFM8+U90RrWbntdepKyGFbPKR07gMY713PbIylGVI+C7uYq1Pq7Gq
         gI+A==
X-Gm-Message-State: AOJu0YwlKTSKpoKgU+8edhthHbDSPaVo+yOU+Ma/8oBqVetqezn0antd
	p1y/KznU2CqBDHaCYtfnIWyCvxC/0BWyo6ufPmS6GHSe5oGz3R9xdsSnb1KVSA==
X-Gm-Gg: ASbGnct4Cec7p3e+yauimqZdPbV8hKPhY4QDLkuY7co85FJrKpj6fCbcqFOsTG720oX
	g1XaabIjDECI1AOILmV6yIiD9WZljmcdzmkqkyfo5VeRQS5wG0j9z6JhK5uRF4dQBpACP+MW4dH
	77NhLjO2+5giLijY9DifRbWwL3Q1LEuLFVfmYhJ3NbDVICVzKycldUNlesLNP0yFPJQ1abPTcAq
	BX+MUXrNUvNsADACiQglqOHlLWxzyOa1bs6XvmUjo3Ovzx0FNuVxQKmv2oZJSgAdBaIlyZjAKp9
	cjcLb5NcSFiiC9SFc91FY7szwA9Y4hd9U0CmWVAuCeGv7WWUiTWDtdl/HG+A0CKV+Mremi5Yto4
	OncLSdV8eQ/wDDeVh9nbcw3tfAgF39b0Etu9qUSQtjKgewhA9E7XK3C1WYL0gCiJs9VRfyIH2rb
	kkysP3yHSuIMZl2FutFDwrTFeePlL6zg==
X-Google-Smtp-Source: AGHT+IE8lJsoZrIpvsFaQhOLH/aYQ7q6WMDPXD1jjs7xk9SgbvRByH9pSJNyhQn3zvXFlEqPN87c5w==
X-Received: by 2002:a05:6000:2003:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-42cc1d0cfadmr34485576f8f.34.1764514232667;
        Sun, 30 Nov 2025 06:50:32 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d618csm20332699f8f.14.2025.11.30.06.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 06:50:32 -0800 (PST)
Message-ID: <fb9a3444-9319-4aa2-8719-35a6308bf568@gmail.com>
Date: Sun, 30 Nov 2025 16:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: 8822b: Avoid WARNING in
 rtw8822b_config_trx_mode()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

rtw8822b_set_antenna() can be called from userspace when the chip is
powered off. In that case a WARNING is triggered in
rtw8822b_config_trx_mode() because trying to read the RF registers
when the chip is powered off returns an unexpected value.

Call rtw8822b_config_trx_mode() in rtw8822b_set_antenna() only when
the chip is powered on.

------------[ cut here ]------------
write RF mode table fail
WARNING: CPU: 0 PID: 7183 at rtw8822b.c:824 rtw8822b_config_trx_mode.cons=
tprop.0+0x835/0x840 [rtw88_8822b]
Modules linked in: rtw88_8723du(OE) rtw88_8821cu(OE) rtw88_8822bu(OE) rtw=
88_8822cu(OE) rtw88_8821au(OE) rtw88_8812au(OE) rtw88_8814au(OE) rtw88_87=
23d(OE) rtw88_8821c(OE) rtw88_8822b(OE) rtw88_8822c(OE) rtw88_8821a(OE) r=
tw88_8812a(OE) rtw88_8814a(OE) rtw88_88xxa(OE) rtw88_8723x(OE) rtw88_usb(=
OE) rtw88_core(OE) uinput ccm rtl8xxxu(OE) mac80211 libarc4 cfg80211 rfco=
mm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_hash algif=
_skcipher af_alg bnep snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_van=
gogh snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci=
 snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_mat=
ch snd_amd_sdw_acpi intel_rapl_msr soundwire_amd amd_atl uvcvideo soundwi=
re_generic_allocation intel_rapl_common videobuf2_vmalloc soundwire_bus j=
oydev snd_soc_sdca snd_ctl_led uvc snd_hda_codec_alc269 vfat fat snd_hda_=
scodec_component mousedev snd_hda_codec_atihdmi snd_hda_codec_realtek_lib=
 btusb btrtl snd_soc_core snd_hda_codec_generic videobuf2_memops kvm_amd
 btintel snd_compress snd_hda_codec_hdmi ac97_bus btbcm videobuf2_v4l2 po=
lyval_clmulni btmtk snd_pcm_dmaengine snd_hda_intel videobuf2_common snd_=
rpl_pci_acp6x snd_hda_codec ghash_clmulni_intel snd_acp_pci ee1004 hid_mu=
ltitouch snd_amd_acpi_mach videodev aesni_intel bluetooth snd_acp_legacy_=
common mc snd_hda_core snd_pci_acp6x rapl snd_pci_acp5x snd_intel_dspcfg =
snd_intel_sdw_acpi snd_rn_pci_acp3x snd_hwdep wmi_bmof lenovo_wmi_hotkey_=
utilities sp5100_tco snd_acp_config snd_pcm acpi_cpufreq ideapad_laptop s=
nd_timer i2c_piix4 snd_soc_acpi snd platform_profile k10temp sparse_keyma=
p i2c_smbus ccp soundcore snd_pci_acp3x rfkill i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec nvme gpu_sched serio_raw drm_suballoc=
_helper sdhci_acpi nvme_core drm_panel_backlight_quirks sdhci drm_buddy d=
rm_display_helper video nvme_keyring mmc_core cec nvme_auth wmi
Unloaded tainted modules: rtw88_core(OE):1 rtw88_usb(OE):1 rtw88_88xxa(OE=
):1 rtw88_8723x(OE):1 rtw88_8723d(OE):1 rtw88_8821c(OE):1 rtw88_8822b(OE)=
:1 rtw88_8822c(OE):1 rtw88_8821a(OE):1 rtw88_8812a(OE):1 rtw88_8814a(OE):=
1 rtw88_8723du(OE):1 rtw88_8821cu(OE):1 rtw88_8822bu(OE):1 rtw88_8822cu(O=
E):1 rtw88_8821au(OE):1 rtw88_8812au(OE):1 rtw88_8814au(OE):1 [last unloa=
ded: rtw88_core(OE)]
CPU: 0 UID: 0 PID: 7183 Comm: iw Tainted: G        W  OE       6.17.5-arc=
h1-1 #1 PREEMPT(full)  01c39fc421df2af799dd5e9180b572af860b40c1
Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: LENOVO 82KR/LNVNB161216, BIOS HBCN18WW 08/27/2021
RIP: 0010:rtw8822b_config_trx_mode.constprop.0+0x835/0x840 [rtw88_8822b]
Code: 28 0d 60 c2 e8 2c a6 b8 c1 0f 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5=
e 41 5f c3 cc cc cc cc 48 c7 c7 76 0c 60 c2 e8 0b a6 b8 c1 <0f> 0b eb dd =
0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffd082166d76a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff890b2ee72020 RCX: 0000000000000027
RDX: ffff890b8ec1cfc8 RSI: 0000000000000001 RDI: ffff890b8ec1cfc0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fff7ffff
R10: ffffffff8699d880 R11: ffffd082166d7540 R12: 0000000000000003
R13: 0000000000000003 R14: 0000000000000002 R15: 0000000000000033
FS:  00007efc327b4e80(0000) GS:ffff890c08306000(0000) knlGS:0000000000000=
000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056308da1b720 CR3: 0000000284c25000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 rtw8822b_set_antenna+0x57/0x70 [rtw88_8822b 370206f42e5890d8d5f48eb358b7=
59efa37c422b]
 rtw_ops_set_antenna+0x50/0x80 [rtw88_core 711c8fb4f686162be4625b1d0b8e8c=
6a5ac850fb]
 ieee80211_set_antenna+0x60/0x100 [mac80211 f1845d85d2ecacf3b71867635a050=
ece90486cf3]
 nl80211_set_wiphy+0x384/0xe00 [cfg80211 296485ee85696d2150309a6d21a7fbca=
83d3dbda]
 ? netdev_run_todo+0x63/0x550
 genl_family_rcv_msg_doit+0xfc/0x160
 genl_rcv_msg+0x1aa/0x2b0
 ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21a=
7fbca83d3dbda]
 ? __pfx_nl80211_set_wiphy+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21=
a7fbca83d3dbda]
 ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21=
a7fbca83d3dbda]
 ? __pfx_genl_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x59/0x110
 genl_rcv+0x28/0x40
 netlink_unicast+0x285/0x3c0
 ? __alloc_skb+0xdb/0x1a0
 netlink_sendmsg+0x20d/0x430
 ____sys_sendmsg+0x39f/0x3d0
 ? import_iovec+0x2f/0x40
 ___sys_sendmsg+0x99/0xe0
 ? refill_obj_stock+0x12e/0x240
 __sys_sendmsg+0x8a/0xf0
 do_syscall_64+0x81/0x970
 ? do_syscall_64+0x81/0x970
 ? ksys_read+0x73/0xf0
 ? do_syscall_64+0x81/0x970
 ? count_memcg_events+0xc2/0x190
 ? handle_mm_fault+0x1d7/0x2d0
 ? do_user_addr_fault+0x21a/0x690
 ? exc_page_fault+0x7e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7efc324931ce
Code: 4d 89 d8 e8 64 be 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 8=
3 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 =
39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
RSP: 002b:00007ffd1d10c000 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00005630bd1ee400 RCX: 00007efc324931ce
RDX: 0000000000000000 RSI: 00007ffd1d10c090 RDI: 0000000000000003
RBP: 00007ffd1d10c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00005630bd1ee4d0
R13: 00005630bd1f3680 R14: 00007ffd1d10c090 R15: 0000000000000001
 </TASK>
---[ end trace 0000000000000000 ]---

Link: https://github.com/lwfinger/rtw88/issues/366
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/=
wireless/realtek/rtw88/rtw8822b.c
index 89b6485b229a..4d88cc2f4148 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1005,7 +1005,8 @@ static int rtw8822b_set_antenna(struct rtw_dev *rtw=
dev,
 	hal->antenna_tx =3D antenna_tx;
 	hal->antenna_rx =3D antenna_rx;
=20
-	rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+	if (test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+		rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
=20
 	return 0;
 }
--=20
2.51.1


