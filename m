Return-Path: <linux-wireless+bounces-14541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D819B070B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509691F23468
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B909166F33;
	Fri, 25 Oct 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QlARgUcp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CB1547D4;
	Fri, 25 Oct 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868570; cv=none; b=fyfaWff41ruzLVfukOtpenOu0NJ+6sRhTM+/9O+NdkefZ/jE7f9coE5lu0yg3Jg4ENWSeFTf1CJvpgggDVDHiFp7mvr7ILVmvz9zIRyLPMmydQzGpMYpuCcfCYYwRurmBzPGQLJsTNcsX/0Zcp2qaEocMSsl7WbKqrlYxWvQKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868570; c=relaxed/simple;
	bh=dsgsar/lq9h68px2z+YopEnzb0lo//koWLJldh9k9Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRzuIInv+64MfEpc6WL3KWOnro1wA3zdPA2v7ZHExi3lfHwa8I9LhN6TKs63JOZWgZVDQQY6oQ8yTe+5DuUeWt55aBY2oJ/qWgR/ySwUAWUp+PDjSMdQ5kaVWmz5uVutBJTE8IYVhKlORtqLpzqcd1p00RQHdwZJId4DcVO4JqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QlARgUcp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=heAl94HWGe1G6ctlNlL5CBOHnMpx7UyxiFprcL0faS8=; b=QlARgUcp0ANqFUiEPH5e4JbwbA
	CKcecSxYu6l4YTpsNrZgC+ho/gR++Wo44671B9aeCvZKEBDZ4kGqGSoqaxgLBfk9MKAi1Kkk24HrN
	1Jlcsd2+G8aJwWmEYRcISLWv21emo8ZiVy3MhHizg+fcL7ydx1GHnoF9EY3IllqcjvoWwsEAszztN
	UNtbLE7ICCPeiZfxcdPOjgvW/TMKa/wgvXt1oAovX56RBZtaWRRJU7abWj0Y0AqkUfnO7KL9D/umi
	M6gDMfHETjTACos/Sce2Ox2J5tY5zSSsTVruBGmzKKrCNTEDJni+rzLukkZXIlNw0YzBsH4H5Sdz/
	InQVMl8Q==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t4Lpk-00F4Ps-VV; Fri, 25 Oct 2024 17:02:37 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	stable@vger.kernel.org,
	syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Subject: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read efuse bytes in case of failures
Date: Fri, 25 Oct 2024 12:02:16 -0300
Message-ID: <20241025150226.896613-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a hung task with uevent_show() on stack trace. That
specific issue was addressed by another commit [0], but even with that
fix applied (for example, running v6.12-rc4) we face another type of hung
task that comes from the same reproducer [1]. By investigating that, we
could narrow it to the following path:

(a) Syzkaller emulates a Realtek USB WiFi adapter using raw-gadget and
dummy_hcd infrastructure.

(b) During the probe of rtl8192cu, the driver ends-up performing an efuse
read procedure (which is related to EEPROM load IIUC), and here lies the
issue: the function read_efuse() calls read_efuse_byte() many times, as
loop iterations depending on the efuse size (in our example, 512 in total).

This procedure for reading efuse bytes relies in a loop that performs an
I/O read up to *10k* times in case of failures. We measured the time of
the loop inside read_efuse_byte() alone, and in this reproducer (which
involves the dummy_hcd emulation layer), it takes 15 seconds each. As a
consequence, we have the driver stuck in its probe routine for big time,
exposing a stack trace like below if we attempt to reboot the system, for
example:

task:kworker/0:3 state:D stack:0 pid:662 tgid:662 ppid:2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 __schedule+0xe22/0xeb6
 schedule_timeout+0xe7/0x132
 __wait_for_common+0xb5/0x12e
 usb_start_wait_urb+0xc5/0x1ef
 ? usb_alloc_urb+0x95/0xa4
 usb_control_msg+0xff/0x184
 _usbctrl_vendorreq_sync+0xa0/0x161
 _usb_read_sync+0xb3/0xc5
 read_efuse_byte+0x13c/0x146
 read_efuse+0x351/0x5f0
 efuse_read_all_map+0x42/0x52
 rtl_efuse_shadow_map_update+0x60/0xef
 rtl_get_hwinfo+0x5d/0x1c2
 rtl92cu_read_eeprom_info+0x10a/0x8d5
 ? rtl92c_read_chip_version+0x14f/0x17e
 rtl_usb_probe+0x323/0x851
 usb_probe_interface+0x278/0x34b
 really_probe+0x202/0x4a4
 __driver_probe_device+0x166/0x1b2
 driver_probe_device+0x2f/0xd8
 [...]

We propose hereby to drastically reduce the attempts of doing the I/O read
in case of failures, from 10000 to 10. With that, we got reponsiveness in the
reproducer, while seems reasonable to believe that there's no sane device
implementation in the field requiring this amount of retries at every I/O
read in order to properly work. Based on that assumption it'd be good to
have it backported to stable but maybe not since driver implementation
(the 10k number comes from day 0), perhaps up to 6.x series makes sense.

[0] Commit 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race").

[1] A note about that: this syzkaller report presents multiple reproducers
that differs by the type of emulated USB device. For this specific case,
check the entry from 2024/08/08 06:23 in the list of crashes; the C repro
is available at https://syzkaller.appspot.com/text?tag=ReproC&x=1521fc83980000.

Cc: stable@vger.kernel.org # v6.1+
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 82cf5fb5175f..2f75e376c0f6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -178,7 +178,7 @@ void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
 
 	retry = 0;
 	value32 = rtl_read_dword(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL]);
-	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < 10000)) {
+	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < 10)) {
 		value32 = rtl_read_dword(rtlpriv,
 					 rtlpriv->cfg->maps[EFUSE_CTRL]);
 		retry++;
-- 
2.46.2


