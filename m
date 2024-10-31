Return-Path: <linux-wireless+bounces-14791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D59B7F72
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 16:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818F51C235B1
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A51A286D;
	Thu, 31 Oct 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KekujGEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12413AA5F;
	Thu, 31 Oct 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390269; cv=none; b=rq8/1298RsptZSQgykfd/UKDquKUnWqjuVDKv5baWsB8pe1kPJbFWcvGdPKKwR9CnUtRnD2xX2Yfm7JzRQn53ENyUjM7rB19wJRsIrvBLCppM3feQ912ZIH+MBvIg55D7Hjqnv2wx4+WBadG8kVW7XN0V9DOrdoo+Ah+PK1j0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390269; c=relaxed/simple;
	bh=Bdy/W+WJwywtZb0g+ERgxY7Nzc7gW9/k4nPsAb43oAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2rYRCUiL1orScsf20ukM23uTQ6EBZiHGKI9Ec0+vp8KDyBqs3uc74/kES1MXM0dhNx6YgkJD1lHuVWhcMG0qbxgpXCj2BHZjbCA/aacW/XKKiGenzmJGv7OEqI+zcCvJaF67es5zlE5BjNxQQrnjWgwHJADyIowHWCxY+LFkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KekujGEX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=th6G0fEyoOFS+Otf2yPw97DjiY2mX5pgf7XrHARRmzY=; b=KekujGEXXdz//Zd4FJmxYDxXCF
	IlkOWbnl6cmgP4E8zS8gW903vhg1o0uHkVduOgf1xaCKHMbNFP736uJ/dIN9bv7hrj9ImjZqio6T4
	vRd5ELso+mxNLG+Pm0MERmAyDFWCkEuDSwFmU+6SHjKFPUayYt/YPsAuis+4U8oP2fzpwiaCJUxPV
	/I45WEIWaryk/OUfGyLNNWwpQhP1S7V+fKAvfcC46BeghoB9QJnlnlnZqspPlo2Sx3T/6006sg+kk
	fcQC/quxfAABgvZ1NEii9GxNX7fiJ/3n0XSMiOifYPKHZeR+vojxjsjlxHDSy8ITH2jTyIC8uVPQ0
	6I8DhhnQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6XYI-000547-GQ; Thu, 31 Oct 2024 16:57:39 +0100
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
Subject: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Date: Thu, 31 Oct 2024 12:55:27 -0300
Message-ID: <20241031155731.1253259-1-gpiccoli@igalia.com>
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
got reponsiveness in the reproducer, while seems reasonable to believe
that there's no sane USB device implementation in the field requiring this
amount of retries at every I/O read in order to properly work. Based on
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
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V3:
- Switch variable declaration to reverse xmas tree order
(thanks Ping-Ke Shih for the suggestion).

V2:
- Restrict the change to USB device only (thanks Ping-Ke Shih).
- Tested in 2 USB devices by Bitterblue Smith - thanks a lot!

V1: https://lore.kernel.org/lkml/20241025150226.896613-1-gpiccoli@igalia.com/


 drivers/net/wireless/realtek/rtlwifi/efuse.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
index 82cf5fb5175f..0ff553f650f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
+++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
@@ -162,9 +162,19 @@ void efuse_write_1byte(struct ieee80211_hw *hw, u16 address, u8 value)
 void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	u16 retry, max_attempts;
 	u32 value32;
 	u8 readbyte;
-	u16 retry;
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


