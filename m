Return-Path: <linux-wireless+bounces-20379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7EA60FE8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 12:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE0882B16
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6A1F03DA;
	Fri, 14 Mar 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="AOGRSY3B";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="WrUOydwH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FF1FDE35
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951553; cv=none; b=aZHzBmtOgZ2d9KMj7VAn6KTs/OOPWVMEyFtnzOvZJ9q+xCrbc1Yfe35pyfEcROHf/at7+NU4+O/k+hg8XfQVgQeQYS2fHxyvukzUHySvpIFQrQ5Af61gHlEXzkTkPclf7v9yEyX42Mt1HBYVgs8v16reffiKUtw6psMXrwgf2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951553; c=relaxed/simple;
	bh=+GCDnhCVENB9ccgHWdz5sHs7o66RfWThuEhyb96qY28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBuqeeLubJAFq+Rh/MUrTxvgn7fUyNRzKa0JTXMYALTuhlz//ucku07hyPv695w15yr92ObZcAwHba7n2hIwaEPgm/p10/ae2zxdKbkIDVy/GL0AkNP8pFxHtz7/CuwHx/LkYRCyA/ZzZi8ynVdfJUKgHkbwE4PUDSLPkh1cbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=AOGRSY3B; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=WrUOydwH; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1741950642; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=k83jL6abdzplA61er+1290FaFsq0kTkbedeZU7FpSSU=;
 b=AOGRSY3BUn1ynkDEtnkQTXsBuYk9lQdWSA1x7hSnPzV/tQEB2OfKGxZK1GdUtDcXcSJcB
 60AZhnmJnAvq5COPjeEK+wLsmVV6OlokHJJwqU/8jnS7TAHOM9N6hdiXT8gAti16YwXQzrP
 1WXqTKlNyJVQyREAYyqVxradJSCZRIioWSxUluvaWP9tsQJPK1VAH76BQXlFo5BYQ10Dmyt
 T+BZE2cTFUpZHuGrJ9FVcJ3hY1HOGTth28y8iXvyMnc3mgE5RGEIzrHp8Q27buppvIUGlse
 fFmVNXqp7KHQkRSuTjomer5n7nKA8H5pq8Hkt0p6eNwQ4mLk7senpLx4pXjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1741950642; h=from : subject
 : to : message-id : date;
 bh=k83jL6abdzplA61er+1290FaFsq0kTkbedeZU7FpSSU=;
 b=WrUOydwHdjqGY7esG2sdL8SnBwi/q9N/APBGdTacYSjBJSW/2wz2sCpPW3GLhu/IVEH/A
 GtmuXfWgoIcGfAsJjNbl7kqdBug/R4kCnXzPxIxupiI98DFb4acw7ShITv+a6h/h5OMC1FV
 9okcMPa1ML/V0jf9hs1VPHft41nMZ4u712KcPtkZHvRNlufKSpcHpSSrQLasnkpMHwWa5iH
 J5spItXKqHC3rBJdqdwOWuFemGW4zGbtMrCsYD8NN3z+WCAq0ECu8UTeXovWwajDWthyWv1
 GMrX8KcMFaRVEiERxt3VWyKHlaTYMjQGF96mZsrUiKQDYuBfq6DS63rBJthg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tt2vx-4o5NDgroSBC-sFj8;
	Fri, 14 Mar 2025 11:10:33 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in ieee80211_tx_h_select_key()
Date: Fri, 14 Mar 2025 12:04:24 +0100
Message-Id: <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1741950009.git.repk@triplefau.lt>
References: <cover.1741950009.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616slWdbAx55O
X-smtpcorp-track: -fTu9t52FSAS.4DvCyr1jahd8.6frMrA3JjZR

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

Update SKB control block key even when key is NULL to avoid that.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..79c217c2f801 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
 		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
 		return TX_DROP;
+	} else {
+		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
+		 * could have been called to update key info after its removal
+		 * (e.g. by ieee80211_tx_dequeue()).
+		 */
+		info->control.hw_key = NULL;
 	}
 
 	return TX_CONTINUE;
-- 
2.40.0


