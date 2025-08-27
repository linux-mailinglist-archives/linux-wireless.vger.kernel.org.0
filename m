Return-Path: <linux-wireless+bounces-26698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B806B381F0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CC7AFAE0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E7302753;
	Wed, 27 Aug 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="JrLM7P64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD483002B1;
	Wed, 27 Aug 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296406; cv=none; b=bz1YGeAaEjGVKSYtGp5nT1kiVVzTZrTX0PwctD3yN08ykChGkCXvEQM/zBrSm8J7gtvF0aDQgs2CRrXMssq61Y0CBBTq926kfelp/nDxwMbKhiukwVgKEwCY+zy+q/gPNyNr4cXmUBqUIVn+ym5NYI1TwrrJiClDKqAUsFI1SgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296406; c=relaxed/simple;
	bh=vqZZIw5/ur/jIhQWs/3Gokj0Zn0OQYByDQGXFndhH3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbgRLAEPo18FOQaAtGRQnLX4WBtgfpsiO043ek7gtJhNsEZ/6GH7PBZPoK5p1O3jomHBQu5yLp8wox4JEPl0UWbTIiO9rLrhztrQwaj+a6GT+1Tk+4zfRaFwArGZrepP+ybSZ4WCS60Td2gVYLGgVsWWb3XJd5bWGbWTrQ+Rc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=JrLM7P64; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id CE9AD406C3E2;
	Wed, 27 Aug 2025 12:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CE9AD406C3E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756296401;
	bh=tQlyuqDvMaR9vp6QaKLqCqx+jLri4M8w72th86oy/gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrLM7P64VgNKcZcC4cEnsp9RpLGDsez78nzt4CVfdinKjBCSIdVPzn92keA8aFaLK
	 yV//ffIb0PUmu4/TGOEoMpvOu3cbeNOneZiuSdjI4eZb2IIHs11akrsdOK+kVGEs+b
	 /A0h54ky2cHmmEF7EsDI1yBVGEEcSBYHXTF2YknI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v2 4/4] wifi: rtw89: avoid circular locking dependency in ser_state_run()
Date: Wed, 27 Aug 2025 15:05:17 +0300
Message-ID: <20250827120603.723548-5-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827120603.723548-1-pchelkin@ispras.ru>
References: <20250827120603.723548-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep gives a splat [1] when ser_hdl_work item is executed.  It is
scheduled at mac80211 workqueue via ieee80211_queue_work() and takes a
wiphy lock inside.  However, this workqueue can be flushed when e.g.
closing the interface and wiphy lock is already taken in that case.

Choosing wiphy_work_queue() for SER is likely not suitable.  Back on to
the global workqueue.

[1]:

 WARNING: possible circular locking dependency detected
 6.17.0-rc2 #17 Not tainted
 ------------------------------------------------------
 kworker/u32:1/61 is trying to acquire lock:
 ffff88811bc00768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ser_state_run+0x5e/0x180 [rtw89_core]

 but task is already holding lock:
 ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}:
        process_one_work+0x7c6/0x1450
        worker_thread+0x49e/0xd00
        kthread+0x313/0x640
        ret_from_fork+0x221/0x300
        ret_from_fork_asm+0x1a/0x30

 -> #1 ((wq_completion)phy0){+.+.}-{0:0}:
        touch_wq_lockdep_map+0x8e/0x180
        __flush_workqueue+0x129/0x10d0
        ieee80211_stop_device+0xa8/0x110
        ieee80211_do_stop+0x14ce/0x2880
        ieee80211_stop+0x13a/0x2c0
        __dev_close_many+0x18f/0x510
        __dev_change_flags+0x25f/0x670
        netif_change_flags+0x7b/0x160
        do_setlink.isra.0+0x1640/0x35d0
        rtnl_newlink+0xd8c/0x1d30
        rtnetlink_rcv_msg+0x700/0xb80
        netlink_rcv_skb+0x11d/0x350
        netlink_unicast+0x49a/0x7a0
        netlink_sendmsg+0x759/0xc20
        ____sys_sendmsg+0x812/0xa00
        ___sys_sendmsg+0xf7/0x180
        __sys_sendmsg+0x11f/0x1b0
        do_syscall_64+0xbb/0x360
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
        __lock_acquire+0x124c/0x1d20
        lock_acquire+0x154/0x2e0
        __mutex_lock+0x17b/0x12f0
        ser_state_run+0x5e/0x180 [rtw89_core]
        rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
        process_one_work+0x82d/0x1450
        worker_thread+0x49e/0xd00
        kthread+0x313/0x640
        ret_from_fork+0x221/0x300
        ret_from_fork_asm+0x1a/0x30

 other info that might help us debug this:

 Chain exists of:
   &rdev->wiphy.mtx --> (wq_completion)phy0 --> (work_completion)(&ser->ser_hdl_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&ser->ser_hdl_work));
                                lock((wq_completion)phy0);
                                lock((work_completion)(&ser->ser_hdl_work));
   lock(&rdev->wiphy.mtx);

  *** DEADLOCK ***

 2 locks held by kworker/u32:1/61:
  #0: ffff888103835148 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0xefa/0x1450
  #1: ffffc9000048fd30 ((work_completion)(&ser->ser_hdl_work)){+.+.}-{0:0}, at: process_one_work+0x7b5/0x1450

 stack backtrace:
 CPU: 0 UID: 0 PID: 61 Comm: kworker/u32:1 Not tainted 6.17.0-rc2 #17 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523-14.fc42 05/23/2025
 Workqueue: phy0 rtw89_ser_hdl_work [rtw89_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5d/0x80
  print_circular_bug.cold+0x178/0x1be
  check_noncircular+0x14c/0x170
  __lock_acquire+0x124c/0x1d20
  lock_acquire+0x154/0x2e0
  __mutex_lock+0x17b/0x12f0
  ser_state_run+0x5e/0x180 [rtw89_core]
  rtw89_ser_hdl_work+0x119/0x220 [rtw89_core]
  process_one_work+0x82d/0x1450
  worker_thread+0x49e/0xd00
  kthread+0x313/0x640
  ret_from_fork+0x221/0x300
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Found by Linux Verification Center (linuxtesting.org).

Fixes: ebfc9199df05 ("wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/ser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index bb39fdbcba0d..6c0a13a854f6 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -205,7 +205,6 @@ static void rtw89_ser_hdl_work(struct work_struct *work)
 
 static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 {
-	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
 	struct ser_msg *msg = NULL;
 
 	if (test_bit(RTW89_SER_DRV_STOP_RUN, ser->flags))
@@ -221,7 +220,7 @@ static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 	list_add(&msg->list, &ser->msg_q);
 	spin_unlock_irq(&ser->msg_q_lock);
 
-	ieee80211_queue_work(rtwdev->hw, &ser->ser_hdl_work);
+	schedule_work(&ser->ser_hdl_work);
 	return 0;
 }
 
-- 
2.50.1


