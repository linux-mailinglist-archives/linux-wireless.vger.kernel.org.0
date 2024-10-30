Return-Path: <linux-wireless+bounces-14737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825A9B656B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF88281C71
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CD1EABA4;
	Wed, 30 Oct 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q8bGm43a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402C1EF095;
	Wed, 30 Oct 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297696; cv=none; b=oK+bbTlbw2Md7QEAXCqq9YMqYktLMnR9jMP6VRwR0yuvjPmMxJOypF/E7ACr/AAm1H/nYa8+1y3FuLe5XO91sLnUpKT316dxZlHW1L3GinBmi7hcPJReQO7RDSIVLcUnGWYTOduGHN7pN71a7LLDtAakwkHhIyeiTVdPPPYQEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297696; c=relaxed/simple;
	bh=V7XbNCI+y0Vja1Ya3QUPKHzcNmuePulkbMMVMW94cyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fC50j5Wf28oD4fTDYuSoiv/JObRuE0U3oxXGayujC+xwRnzRjNEwpaRX3yQR8w5VdwfGx9Gq0dUiwTgrXeMcoCBAabWidQwz4nWN/cLXiHyV7Ki2c1aO0+0wQWGMn+NiB/4d1agenz01PtDd2NjtrNDn3g/nvNFOVy352idV99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q8bGm43a; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B4k0iWwm0nLFX+L3oF505AnrUFVobXPrf0f5J1041gc=; b=Q8bGm43a9qpRmka9D8b77c13bD
	QRuvU5Fo8fa8aa2DVTOqX+bodsN9ZOraMdNdPTF2+IVi7799Pb1k+PbjgD+9yFCx+xmS9+9LWZ8sD
	LfZg3JlWnUZU/6TM1cezO1HTVbIF/+gH2FL6LtDkS9PbVw3V0UqQ7Z91AL3uF6lAVUFC/9aUifLhu
	Molspq09PMRqgQWYsowG4recw9+rPikrdeqrvsqG2k/hwb0Bebr8j+GUQ3TFK0cFTw2CpzHSXPcbj
	GJBPHwwF8RbrqXY7uIInMI+2VxtSLaujTt2+FAjWmXyG8qC+hyhYDxbMXUsaUS3z0wNortI4pbPf/
	+PnDCEeA==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t69TC-00H78u-5x; Wed, 30 Oct 2024 15:14:47 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	rtl8821cerfe2@gmail.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	stable@vger.kernel.org,
	syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Subject: [PATCH V2] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Date: Wed, 30 Oct 2024 11:09:52 -0300
Message-ID: <20241030141440.1153887-1-gpiccoli@igalia.com>
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
fix applied (for example, running v6.12-rc5) we face another type of hung
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

We propose hereby to drastically reduce the attempts of doing the I/O reads
in case of failures, restricted to USB devices (given that they're inherently
slower than PCIe ones). By retrying up to 10 times (instead of 10000), we
got responsiveness in the reproducer, while seems reasonable to believe
that there's no sane USB device implementation in the field requiring this
amount of retries (at every I/O read) in order to properly work. Based on
that assumption, it'd be good to have it backported to stable but maybe not
since driver implementation (the 10k number comes from day 0), perhaps up
to 6.x series makes sense.

[0] Commit 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race").

[1] A note about that: this syzkaller report presents multiple reproducers
that differs by the type of emulated USB device. For this specific case,
check the entry from 2024/08/08 06:23 in the list of crashes; the C repro
is available at https://syzkaller.appspot.com/text?tag=ReproC&x=1521fc83980000.

Cc: stable@vger.kernel.org # v6.1+
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2:
- Restrict the change to USB device only (thanks Ping-Ke Shih).
- Tested in 2 USB devices by Bitterblue Smith - thanks a lot!

V1: https://lore.kernel.org/lkml/20241025150226.896613-1-gpiccoli@igalia.com/


 drivers/net/wireless/realtek/rtlwifi/efuse.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 82cf5fb5175f..f741066c06de 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -164,7 +164,17 @@ void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 value32;
 	u8 readbyte;
-	u16 retry;
+	u16 retry, max_attempts;
+
+	/*
+	 * In case of USB devices, transfer speeds are limited, hence
+	 * efuse I/O reads could be (way) slower. So, decrease (a lot)
+	 * the read attempts in case of failures.
+	 */
+	if (rtlpriv->rtlhal.interface == INTF_PCI)
+		max_attempts = 10000;
+	else
+		max_attempts = 10;
 
 	rtl_write_byte(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL] + 1,
 		       (_offset & 0xff));
@@ -178,7 +188,7 @@ void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
 
 	retry = 0;
 	value32 = rtl_read_dword(rtlpriv, rtlpriv->cfg->maps[EFUSE_CTRL]);
-	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < 10000)) {
+	while (!(((value32 >> 24) & 0xff) & 0x80) && (retry < max_attempts)) {
 		value32 = rtl_read_dword(rtlpriv,
 					 rtlpriv->cfg->maps[EFUSE_CTRL]);
 		retry++;
-- 
2.46.2


