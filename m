Return-Path: <linux-wireless+bounces-29851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3FCC9B40
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D1C3051EAF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 22:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CE311C13;
	Wed, 17 Dec 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="UMMHGDKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01A2ED860;
	Wed, 17 Dec 2025 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010395; cv=none; b=EyQdxy0bcvhWkcnNIH5apPoEFyMd8SYig2hW8sjamYeg31OP7CMMzTuiTRKE/VBqI8V2LjZGkTPB9d9utj88l0f3acylWZBFf7cA6F3ztH/4huaW+cNztMq/mFLTfcgMmgQjiy+uSaX0bf5ysqOwcPnF0G1SBWP6nfRSBFIM3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010395; c=relaxed/simple;
	bh=RF0p7ViyrufOFNlFS5uKp06FGHIWxDLylpIw0ubumXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPNWo+GlojXOkvtk+4MgOyIrvE1RvNnGjCRxLazXIb+1/lzTmsAHqvZhrr4KykAlNB3HkIoknoelEAny6C7qm4g/Zmb8xkDnCroKa8Ol60aw/GdlIoPl6Ux4qiX0iuC6iEWbLPFniEdYBI3ojaMeU0EF72BHeBLN5iDuLzp9fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=UMMHGDKx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766010384; x=1766615184; i=spasswolf@web.de;
	bh=FdIDGnLdInZs3EAQj5Cac1NPy8HAJp7MV1NeTSFIY1A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UMMHGDKxFLNuWqeelGRbWjAsfkwn+ow2xg/DB8MWrbKjkmQlk/8nVy7N0nfDMffe
	 CvhZjL/TNxYRsC99mjXFX5aCFQ6U1Fkyl14Uxk1P9cSfRIflQD+gOlO2Xb6Kka4lH
	 jrOLfBhrc/DRj7usDrFsOIWduaIpKt5IeDTJN+Ad6hTIA9TAODvK3ZjJZ5LG1c+Kq
	 kTKUyiRLl6yUY+H6JP3MBYPF/vDHBp8wmdAevpqB+RAb+vqBHCUL1ch3Ku4ijNNnd
	 Blu+K1Ow/7Bdo9aplcFTZFXUbJcrPfuzFTnAxZsdNoAI0FV+YnxeLG54C7UNEev3m
	 mGaemBWJYJOycFFLkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MNOQy-1vKWbF4BUA-00YQVk; Wed, 17 Dec 2025 23:26:24 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: [PATCH] wifi: mt76: connac: fix out of bounds read in mt76_connac2_load_patch()
Date: Wed, 17 Dec 2025 23:26:20 +0100
Message-ID: <20251217222622.8161-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hXJjnfa21WvwBilRTrqjIT7H19MAZcnup10hZEFCEEZW8sPGXEI
 Sj6Uctar1nyvJV56PoCCE/TmOaq23uMGh/160eCHO8y2EVIpPNoRb3SwUk2mbjSxBFi9/Mm
 K5wSYdxxjOWU3o970rqhgZ45EsjCSh9ZzExwhJHI9V2rLRl4Kxdyn5IaQoq5aTGiMh8aGY8
 2GegYaquvlz1awPsvOPkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FYrGrZ9neLs=;nyCHnjSmxq+Ft/Lcs0NESTNkmAO
 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

As sizeof(hdr->build_date) is 16 we reading 17 bytes (sizeof(build_date))
result in the following error:

[    T378] ------------[ cut here ]------------
[    T378] strnlen: detected buffer overflow: 17 byte read of buffer size =
16
[    T378] WARNING: lib/string_helpers.c:1036 at __fortify_report+0x3e/0x5=
0, CPU#15: kworker/15:1/378
[...]
[    T378]  mt76_connac2_load_patch.cold+0x2a/0x313 [mt76_connac_lib]
[    T378]  mt792x_load_firmware+0x31/0x140 [mt792x_lib]

Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea99167765b0..aca3d7870dce 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3125,7 +3125,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, co=
nst char *fw_name)
 	}
=20
 	hdr =3D (const void *)fw->data;
-	strscpy(build_date, hdr->build_date, sizeof(build_date));
+	strscpy(build_date, hdr->build_date, sizeof(hdr->build_date));
 	build_date[16] =3D '\0';
 	strim(build_date);
 	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
=2D-=20
2.47.3

In linux-next-20251217 I noticed the following error during boot:

[    T378] ------------[ cut here ]------------
[    T378] strnlen: detected buffer overflow: 17 byte read of buffer size =
16
[    T378] WARNING: lib/string_helpers.c:1036 at __fortify_report+0x3e/0x5=
0, CPU#15: kworker/15:1/378
[    T378] Modules linked in: mt7921e mt7921_common mt792x_lib mt76_connac=
_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics configfs =
efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid drm_client_lib=
 i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_buddy xh=
ci_pci drm_panel_backlight_quirks gpu_sched amdxcp xhci_hcd hid_sensor_hub=
 drm_display_helper mfd_core hid_multitouch hid_generic psmouse usbcore nv=
me drm_kms_helper i2c_hid_acpi amd_sfh i2c_hid hid serio_raw nvme_core cec=
 i2c_piix4 r8169 i2c_smbus usb_common crc16 i2c_designware_platform i2c_de=
signware_core
[    T378] CPU: 15 UID: 0 PID: 378 Comm: kworker/15:1 Not tainted 6.19.0-r=
c1-next-20251217-master #262 PREEMPT_{RT,(full)}=20
[    T378] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EE=
K/MS-158L, BIOS E158LAMS.10F 11/11/2024
[    T378] Workqueue: events mt7921_init_work [mt7921_common]
[    T378] RIP: 0010:__fortify_report+0x3e/0x50
[    T378] Code: 39 c8 48 0f 47 c1 83 e7 01 48 c7 c1 29 ac 54 95 48 8b 34 =
c5 e0 d5 26 95 48 c7 c0 8c 8f 54 95 48 0f 44 c8 48 8d 3d 42 ba c7 00 <67> =
48 0f b9 3a e9 d3 aa a5 ff 0f 1f 84 00 00 00 00 00 f3 0f 1e fa
[    T378] RSP: 0018:ffffb015823a7d18 EFLAGS: 00010246
[    T378] RAX: ffffffff95548f8c RBX: 0000000000000000 RCX: ffffffff95548f=
8c
[    T378] RDX: 0000000000000011 RSI: ffffffff955319d6 RDI: ffffffff959250=
70
[    T378] RBP: ffff8ebf90f22560 R08: 0000000000000010 R09: ffffb01581f8d0=
00
[    T378] R10: ffff8ebf80042700 R11: ffff8ec23a7e5930 R12: 00000000000000=
00
[    T378] R13: ffffb01581f8d000 R14: 0000000000001000 R15: 00000000000000=
00
[    T378] FS:  0000000000000000(0000) GS:ffff8ec2a49de000(0000) knlGS:000=
0000000000000
[    T378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    T378] CR2: 00007f861de85114 CR3: 0000000025222000 CR4: 0000000000750e=
f0
[    T378] PKRU: 55555554
[    T378] Call Trace:
[    T378]  <TASK>
[    T378]  __fortify_panic+0xd/0xf
[    T378]  mt76_connac2_load_patch.cold+0x2a/0x313 [mt76_connac_lib]
[    T378]  mt792x_load_firmware+0x31/0x140 [mt792x_lib]
[    T378]  mt7921_run_firmware+0x27/0x490 [mt7921_common]
[    T378]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T378]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T378]  ? ____mt76_poll_msec+0x70/0xb0 [mt76]
[    T378]  mt7921e_mcu_init+0x47/0x75 [mt7921e]
[    T378]  mt7921_init_work+0x4c/0x190 [mt7921_common]
[    T378]  process_one_work+0x17b/0x290
[    T378]  worker_thread+0x17d/0x2e0
[    T378]  ? bh_worker+0x1c0/0x1c0
[    T378]  kthread+0xe9/0x1e0
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ret_from_fork+0x23e/0x270
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ret_from_fork_asm+0x11/0x20
[    T378]  </TASK>
[    T378] ---[ end trace 0000000000000000 ]---
[    T378] ------------[ cut here ]------------
[    T378] kernel BUG at lib/string_helpers.c:1044!
[    T378] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    T378] CPU: 15 UID: 0 PID: 378 Comm: kworker/15:1 Tainted: G        W =
          6.19.0-rc1-next-20251217-master #262 PREEMPT_{RT,(full)}=20
[    T378] Tainted: [W]=3DWARN
[    T378] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EE=
K/MS-158L, BIOS E158LAMS.10F 11/11/2024
[    T378] Workqueue: events mt7921_init_work [mt7921_common]
[    T378] RIP: 0010:__fortify_panic+0xd/0xf
[    T378] Code: d6 e8 57 e6 fe ff 48 89 df e8 7f 5c 23 00 e9 21 80 48 00 =
66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 40 0f b6 ff e8 53 c1 48 00 <0f> =
0b 48 8b 54 24 08 48 8b 34 24 4c 8d 44 24 1d 4c 89 e9 48 c7 c7
[    T378] RSP: 0018:ffffb015823a7d20 EFLAGS: 00010246
[    T378] RAX: ffffffff95548f8c RBX: 0000000000000000 RCX: ffffffff95548f=
8c
[    T378] RDX: 0000000000000011 RSI: ffffffff955319d6 RDI: ffffffff959250=
70
[    T378] RBP: ffff8ebf90f22560 R08: 0000000000000010 R09: ffffb01581f8d0=
00
[    T378] R10: ffff8ebf80042700 R11: ffff8ec23a7e5930 R12: 00000000000000=
00
[    T378] R13: ffffb01581f8d000 R14: 0000000000001000 R15: 00000000000000=
00
[    T378] FS:  0000000000000000(0000) GS:ffff8ec2a49de000(0000) knlGS:000=
0000000000000
[    T378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    T378] CR2: 00007f861de85114 CR3: 0000000025222000 CR4: 0000000000750e=
f0
[    T378] PKRU: 55555554
[    T378] Call Trace:
[    T378]  <TASK>
[    T378]  mt76_connac2_load_patch.cold+0x2a/0x313 [mt76_connac_lib]
[    T378]  mt792x_load_firmware+0x31/0x140 [mt792x_lib]
[    T378]  mt7921_run_firmware+0x27/0x490 [mt7921_common]
[    T378]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T378]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T378]  ? ____mt76_poll_msec+0x70/0xb0 [mt76]
[    T378]  mt7921e_mcu_init+0x47/0x75 [mt7921e]
[    T378]  mt7921_init_work+0x4c/0x190 [mt7921_common]
[    T378]  process_one_work+0x17b/0x290
[    T378]  worker_thread+0x17d/0x2e0
[    T378]  ? bh_worker+0x1c0/0x1c0
[    T378]  kthread+0xe9/0x1e0
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ret_from_fork+0x23e/0x270
[    T378]  ? kthreads_online_cpu+0x100/0x100
[    T378]  ret_from_fork_asm+0x11/0x20
[    T378]  </TASK>
[    T378] Modules linked in: mt7921e mt7921_common mt792x_lib mt76_connac=
_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics configfs =
efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid drm_client_lib=
 i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_buddy xh=
ci_pci drm_panel_backlight_quirks gpu_sched amdxcp xhci_hcd hid_sensor_hub=
 drm_display_helper mfd_core hid_multitouch hid_generic psmouse usbcore nv=
me drm_kms_helper i2c_hid_acpi amd_sfh i2c_hid hid serio_raw nvme_core cec=
 i2c_piix4 r8169 i2c_smbus usb_common crc16 i2c_designware_platform i2c_de=
signware_core
[    T378] ---[ end trace 0000000000000000 ]---

The result of this is that my wireless card doesn't work. The patch
above fixes the issue.

Bert Karwatzki

