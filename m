Return-Path: <linux-wireless+bounces-20771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A33DA6DFD7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D315170D38
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B7263F2C;
	Mon, 24 Mar 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="urPNGqkZ";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="JmdGFrB/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D5264609
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834071; cv=none; b=tebOhMkBUE0tbp/NC39Nln9nMQRpqJKlOjc7LvZudLpW8yy+JJC75NjQ0Bw0btWaYjHPkUIDyXnR4hMxzRi1FBAqTR1FQjnXGm+QO7zB2AWC7CQJWc6bO1lAjeldXCPqEM+/6REEw42n3L5Cei8Iy0HiwZCMfHA8QlsPpGHtEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834071; c=relaxed/simple;
	bh=rzhCWchD87I7ztxWtfLe2qG+z3B3I2xgab4DuMfQauE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muP7D6yXXOFrRKqyjANa2XtDrbisp+794dapxIOnTq+rX7P105SqzAHli/tgoH8alwf2Hfi4F3MNqtFXQrndzeoA8X8kX3x29HysvL+BbPzBEKKANxAyQJMd6s98jfWNzpyhqy5MksiUdSEn95KtQUGj0lp8hX/Jgxdr/9+aj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=urPNGqkZ; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=JmdGFrB/; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742834064; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=1NTS6jCiyypS+X7Y3GlJTmuu6rQHp2cIDev00qbGtlg=;
 b=urPNGqkZg8C4YreF8rNtUX57XSrrMCCnxGdxobZBzRTz7JFeQYVlopABKvGju/kgzHqY6
 NrvgpWOIZCUQR9tYMpJOEJkxLB6WFwe7+qdBuoX3lyE8867vrkMFoi5BrafT/JGWE5nxAia
 fV6e7tRfYdsZbCEQilH9N1AZeLTy+LXlZR/59ULApcXfNwnHzoKnreKp7gpWMPONypJOA/3
 uwq34/4t8bOMEWG8BqcE2221b1BB/x1nQrI8arSrfCjD8wijJ2G17JkM2P808PDIY4XbDvK
 HgAxnAWnfYli31mTIg8t+Z5N3Gxr8e6pIj0lZ+z29+UOHTgs++PTn2NQ2aJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742834064; h=from : subject
 : to : message-id : date;
 bh=1NTS6jCiyypS+X7Y3GlJTmuu6rQHp2cIDev00qbGtlg=;
 b=JmdGFrB/9W4a8RtfOU7s9mzPBE/gfo98gIvEvDjy6ZruJ9crhqFlvpEMdA8V6v0Y96XDN
 7QxeydoSX8DigO1q9BtWfVMPRDdmN0MMkwtNDxQIiaHDtnotCPg63rhkBZfU3kvhl9Wbxn6
 A/v/5eL+9vQ65WVT4mJeF2OB6ZRTP83h4ZElWFsIuyGmX987rsNm9NCwcyPcml1xdrmXuBq
 XY6n01FmUQBxhEoOb047xupD268Bx91ymfnCQztaAvSj9Sf56w3b4t3QlO4GMakBAHbNjAz
 y2pW/k6ZwAHwwQ6x0v13tj8fylw+RD1iUYgz2E6t4vGVR8wqu/Yfd4BpEfmQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twkkk-4o5NDgrs07b-lUJC;
	Mon, 24 Mar 2025 16:34:18 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
Date: Mon, 24 Mar 2025 17:28:20 +0100
Message-Id: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1742833382.git.repk@triplefau.lt>
References: <cover.1742833382.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s6QhpvA6O8
X-smtpcorp-track: OvQ5fbPVu4PM.D5hr158FtnhK.cBrepwdM64H

The ieee80211 skb control block key (set when skb was queued) could have
been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
already called ieee80211_tx_h_select_key() to get the current key, but
the latter do not update the key in skb control block in case it is
NULL. Because some drivers actually use this key in their TX callbacks
(e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
below:

  BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
  Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440

  CPU: 3 UID: 0 PID: 1440 Comm: kworker/u16:4 Not tainted 6.13.0-ge128f627f404 #2
  Hardware name: HW (DT)
  Workqueue: bat_events batadv_send_outstanding_bcast_packet
  Call trace:
   show_stack+0x14/0x1c (C)
   dump_stack_lvl+0x58/0x74
   print_report+0x164/0x4c0
   kasan_report+0xac/0xe8
   __asan_report_load4_noabort+0x1c/0x24
   ath11k_mac_op_tx+0x590/0x61c
   ieee80211_handle_wake_tx_queue+0x12c/0x1c8
   ieee80211_queue_skb+0xdcc/0x1b4c
   ieee80211_tx+0x1ec/0x2bc
   ieee80211_xmit+0x224/0x324
   __ieee80211_subif_start_xmit+0x85c/0xcf8
   ieee80211_subif_start_xmit+0xc0/0xec4
   dev_hard_start_xmit+0xf4/0x28c
   __dev_queue_xmit+0x6ac/0x318c
   batadv_send_skb_packet+0x38c/0x4b0
   batadv_send_outstanding_bcast_packet+0x110/0x328
   process_one_work+0x578/0xc10
   worker_thread+0x4bc/0xc7c
   kthread+0x2f8/0x380
   ret_from_fork+0x10/0x20

  Allocated by task 1906:
   kasan_save_stack+0x28/0x4c
   kasan_save_track+0x1c/0x40
   kasan_save_alloc_info+0x3c/0x4c
   __kasan_kmalloc+0xac/0xb0
   __kmalloc_noprof+0x1b4/0x380
   ieee80211_key_alloc+0x3c/0xb64
   ieee80211_add_key+0x1b4/0x71c
   nl80211_new_key+0x2b4/0x5d8
   genl_family_rcv_msg_doit+0x198/0x240
  <...>

  Freed by task 1494:
   kasan_save_stack+0x28/0x4c
   kasan_save_track+0x1c/0x40
   kasan_save_free_info+0x48/0x94
   __kasan_slab_free+0x48/0x60
   kfree+0xc8/0x31c
   kfree_sensitive+0x70/0x80
   ieee80211_key_free_common+0x10c/0x174
   ieee80211_free_keys+0x188/0x46c
   ieee80211_stop_mesh+0x70/0x2cc
   ieee80211_leave_mesh+0x1c/0x60
   cfg80211_leave_mesh+0xe0/0x280
   cfg80211_leave+0x1e0/0x244
  <...>

Reset SKB control block key before calling ieee80211_tx_h_select_key()
to avoid that.

Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..0c6214f12ea3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3893,6 +3893,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.40.0


