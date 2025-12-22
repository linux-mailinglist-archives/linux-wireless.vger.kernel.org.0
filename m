Return-Path: <linux-wireless+bounces-30055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE099CD6DEA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6003016186
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50792D2490;
	Mon, 22 Dec 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VNH9f739"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440F482EB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426750; cv=none; b=WIhwgZfyaDBSfQIFRyLhBH+94cbyRbRYUVrZBJD5MV+x+hZGAIM2MG/yhPK1Z5bF/EBD384ILkNUnkS99bNdzwONQxRmQlgTvYsQv55LsIvdfiR98v71pbU1QSdWyNoRlHm+RAalghl/5nsY8/p2hEvn7b3hU3ymAARLSBAS+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426750; c=relaxed/simple;
	bh=4expMtA3WKWfedlA2vRmFRkjm80HqG75VdZ/O7JhOIY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JkYKym7eRsDTlMzugFV3O97Yd/QkqkSFBB7kyDqxAE93fEZ8MPiwhQWJaje+y54hIwVoUGGY8TjMCdQDEADzFD1TmWBS+kCPIv02BDVmlNlVu6hi1rD2FKHVH5Vl+AgmlZftLrKYnJktTVFMmumN1WltG94EYDHka9kl6YC19ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VNH9f739; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1766426740; x=1766685940;
	bh=ay6xXTFii1p+icO+7nohIqHQs7dMgk+nkWsA97U4Zfc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VNH9f739vztBhMb7jnrfDS066IK5I5749HghCFdaG+MCuAavq2Y8YrwToODxw3uhi
	 Q29dimA79e49sA4ZHSY7FeJZ3FdMZqrPRX0fGSCah2as4spcUbEOrRfLvbhQVxixq6
	 atNGuhIutkp3jguJunfEgkk4coe4RxrC133aGSW671r2YB5A013tm1FUxFBADcFxJO
	 EILVwb9lFM24o4Lqj9/VwjvNxlyJHI98OVgWJ1ECMUrhGGdCAislIiK2jYMnqNrp8c
	 WSyKUll0PypUX9h+9edoxfm5AjU2C63GUqfPCA3PAYo/IuN+gzn8V+O3Xq4oUl+g1x
	 hT9P2TyLsIrrQ==
Date: Mon, 22 Dec 2025 18:05:33 +0000
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH] wifi: mt76: fix buffer overflow bug
Message-ID: <20251222180437.1938-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: cb661200901071ea47144025303f1bc8e90deb0c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Prevents attempting to read an extra byte from the origin string.
Example stacktrace:

------------[ cut here ]------------
strnlen: detected buffer overflow: 17 byte read of buffer size 16
WARNING: lib/string_helpers.c:1036 at __fortify_report+0x2d/0x50, CPU#0: kw=
orker/0:0/9
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.19.0-rc2+ #13 PREEMPT(=
full)
Hardware name: Micro-Star International Co., Ltd. MS-7E24/B650M GAMING PLUS=
 WIFI (MS-7E24), BIOS 1.C2 08/06/2025
Workqueue: events mt7921_init_work
RIP: 0010:__fortify_report+0x3f/0x50
Code: b6 c1 48 c7 c1 93 60 c0 95 48 8b 34 c5 50 9c 2a 95 48 8d 05 03 1f ee =
01 40 f6 c7 01 48 c7 c7 3c 66 c4 95 48 0f 44 cf 48 89 c7 <67> 48 0f b9 3a c=
3 cc cc cc cc cc cc cc cc cc cc cc ba 2f 00 00 00
RSP: 0018:ffff9f370019fcd0 EFLAGS: 00010246
RAX: ffffffff9636a210 RBX: ffff9420525b1ea0 RCX: ffffffff95c4663c
RDX: 0000000000000011 RSI: ffffffff95cf5242 RDI: ffffffff9636a210
RBP: ffff9f370019fd70 R08: 0000000000000010 R09: ffff9f370019fbf1
R10: 0000000000000004 R11: 0000000000000000 R12: ffffffff95bb3ca3
R13: ffff9420525bb101 R14: 0000000000000000 R15: 00000000ffffffea
FS:  0000000000000000(0000) GS:ffff9427c79ae000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff942526a01000 CR3: 00000005e5a2c000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __fortify_panic+0x5/0x10
 mt76_connac2_load_patch+0x34f/0x360
 ? update_load_avg+0x1f1/0x840
 mt792x_load_firmware+0x35/0x150
 mt7921_run_firmware+0x28/0x4c0
 ? _raw_spin_unlock+0x12/0x30
 ? ____mt76_poll_msec+0x53/0xa0
 mt7921e_mcu_init+0xba/0x100
 mt7921_init_work+0x70/0x1c0
 process_scheduled_works+0x1f0/0x420
 worker_thread+0x296/0x370
 ? pr_cont_work+0x1c0/0x1c0
 kthread+0x213/0x240
 ? kthread_blkcg+0x40/0x40
 ret_from_fork+0xfa/0x1c0
 ? kthread_blkcg+0x40/0x40
 ret_from_fork_asm+0x11/0x20
 </TASK>
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1043!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Tainted: G        W           6.19.0=
-rc2+ #13 PREEMPT(full)
Tainted: [W]=3DWARN
Hardware name: Micro-Star International Co., Ltd. MS-7E24/B650M GAMING PLUS=
 WIFI (MS-7E24), BIOS 1.C2 08/06/2025
Workqueue: events mt7921_init_work
RIP: 0010:__fortify_panic+0x5/0x10
Code: 1d 00 00 00 48 89 df 48 c7 c6 72 68 c8 95 5b 41 5e 41 5f e9 dd c2 4a =
00 cc cc cc cc cc cc cc cc cc cc cc cc cc e8 bb b3 87 00 <0f> 0b cc cc cc c=
c cc cc cc cc cc 0f 1f 44 00 00 55 48 89 e5 41 56
RSP: 0018:ffff9f370019fcd8 EFLAGS: 00010246
RAX: ffffffff9636a210 RBX: ffff9420525b1ea0 RCX: ffffffff95c4663c
RDX: 0000000000000011 RSI: ffffffff95cf5242 RDI: ffffffff9636a210
RBP: ffff9f370019fd70 R08: 0000000000000010 R09: ffff9f370019fbf1
R10: 0000000000000004 R11: 0000000000000000 R12: ffffffff95bb3ca3
R13: ffff9420525bb101 R14: 0000000000000000 R15: 00000000ffffffea
FS:  0000000000000000(0000) GS:ffff9427c79ae000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff942526a01000 CR3: 00000005e5a2c000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 mt76_connac2_load_patch+0x34f/0x360
 ? update_load_avg+0x1f1/0x840
 mt792x_load_firmware+0x35/0x150
 mt7921_run_firmware+0x28/0x4c0
 ? _raw_spin_unlock+0x12/0x30
 ? ____mt76_poll_msec+0x53/0xa0
 mt7921e_mcu_init+0xba/0x100
 mt7921_init_work+0x70/0x1c0
 process_scheduled_works+0x1f0/0x420
 worker_thread+0x296/0x370
 ? pr_cont_work+0x1c0/0x1c0
 kthread+0x213/0x240
 ? kthread_blkcg+0x40/0x40
 ret_from_fork+0xfa/0x1c0
 ? kthread_blkcg+0x40/0x40
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__fortify_panic+0x5/0x10
Code: 1d 00 00 00 48 89 df 48 c7 c6 72 68 c8 95 5b 41 5e 41 5f e9 dd c2 4a =
00 cc cc cc cc cc cc cc cc cc cc cc cc cc e8 bb b3 87 00 <0f> 0b cc cc cc c=
c cc cc cc cc cc 0f 1f 44 00 00 55 48 89 e5 41 56
RSP: 0018:ffff9f370019fcd8 EFLAGS: 00010246
RAX: ffffffff9636a210 RBX: ffff9420525b1ea0 RCX: ffffffff95c4663c
RDX: 0000000000000011 RSI: ffffffff95cf5242 RDI: ffffffff9636a210
RBP: ffff9f370019fd70 R08: 0000000000000010 R09: ffff9f370019fbf1
R10: 0000000000000004 R11: 0000000000000000 R12: ffffffff95bb3ca3
R13: ffff9420525bb101 R14: 0000000000000000 R15: 00000000ffffffea
FS:  0000000000000000(0000) GS:ffff9427c79ae000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff942526a01000 CR3: 00000005e5a2c000 CR4: 0000000000750ef0
PKRU: 55555554

Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers=
/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ea99167765b0c..b735b3671fab5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3101,7 +3101,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, con=
st char *fw_name)
 =09int i, ret, sem, max_len =3D mt76_is_sdio(dev) ? 2048 : 4096;
 =09const struct mt76_connac2_patch_hdr *hdr;
 =09const struct firmware *fw =3D NULL;
-=09char build_date[17];
+=09char build_date[sizeof(hdr->build_date) + 1];
=20
 =09sem =3D mt76_connac_mcu_patch_sem_ctrl(dev, true);
 =09switch (sem) {
@@ -3125,8 +3125,8 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, con=
st char *fw_name)
 =09}
=20
 =09hdr =3D (const void *)fw->data;
-=09strscpy(build_date, hdr->build_date, sizeof(build_date));
-=09build_date[16] =3D '\0';
+=09strscpy(build_date, hdr->build_date, sizeof(hdr->build_date));
+=09build_date[sizeof(hdr->build_date)] =3D '\0';
 =09strim(build_date);
 =09dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
 =09=09 be32_to_cpu(hdr->hw_sw_ver), build_date);
--=20
2.52.0



