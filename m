Return-Path: <linux-wireless+bounces-8566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FE8FD187
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 17:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014F4283EA3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A173D548;
	Wed,  5 Jun 2024 15:23:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4F1863F;
	Wed,  5 Jun 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600993; cv=none; b=YaKaPIbcHihlAUcVdmq3HpfTROo708LUd3lm5VZmLVhFkdlSjl9gMUhV9SKy7nUmK6nFp3f7gbNIttxHf044CtqhK5Pv75K+C5ZffCpLffzG4Q1wbgjJcFcowA05/8mXa16RUn88iH4Xm7crgNHTVZcgxTvNMjEViGwG93lv1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600993; c=relaxed/simple;
	bh=VPZkswdUi9IbeyGy87RvCLEp3+GYq472ghuyHCjHZVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3QMEk0rHJgthnAhXDFEd9ByQtU0S9zgniUeQ5xCA4xGjdywaGYWOmKFYvpk9O5cCObEMU1rDgK8RLT8h9B7uZQaqeGK45ne3/IB2VWYj+I8Ah64eDNfvCC1yjG8TT8DBpkpCG+cQTHzL0Vd+5Qrff/zycnpuNhINz4T6FzpCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Kenton Groombridge <concord@gentoo.org>
To: johannes@sipsolutions.net
Cc: concord@gentoo.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v3] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Wed,  5 Jun 2024 11:22:18 -0400
Message-ID: <20240605152218.236061-1-concord@gentoo.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964252] ------------[ cut here ]------------
[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[   83.964260] CPU: 0 PID: 1695 Comm: iwd Tainted: G           O    T 6.8.9-gentoo-hardened1 #1
[   83.964262] Hardware name: System76 Pangolin/Pangolin, BIOS ARB928_V00.01_T0025ASY1_ms 04/20/2023
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964284]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964287]  ? cfg80211_scan+0x149/0x250
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[   83.964301]  ? __cfi_nl80211_trigger_scan+0x10/0x10
[   83.964302]  ? __cfi_nl80211_post_doit+0x10/0x10
[   83.964304]  ? __cfi_nl80211_pre_doit+0x10/0x10
[   83.964307]  ? __cfi_genl_rcv_msg+0x10/0x10
[   83.964309]  netlink_rcv_skb+0x102/0x130
[   83.964312]  genl_rcv+0x23/0x40
[   83.964314]  netlink_unicast+0x23b/0x340
[   83.964316]  netlink_sendmsg+0x3a9/0x450
[   83.964319]  __sys_sendto+0x3ae/0x3c0
[   83.964324]  __x64_sys_sendto+0x21/0x40
[   83.964326]  do_syscall_64+0x90/0x150
[   83.964329]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964331]  ? syscall_exit_work+0xc2/0xf0
[   83.964333]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964335]  ? syscall_exit_to_user_mode+0x74/0xa0
[   83.964337]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964339]  ? do_syscall_64+0x9c/0x150
[   83.964340]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964342]  ? syscall_exit_to_user_mode+0x74/0xa0
[   83.964344]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964346]  ? do_syscall_64+0x9c/0x150
[   83.964347]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964349]  ? do_syscall_64+0x9c/0x150
[   83.964351]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964353]  ? syscall_exit_work+0xc2/0xf0
[   83.964354]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964356]  ? syscall_exit_to_user_mode+0x74/0xa0
[   83.964358]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964359]  ? do_syscall_64+0x9c/0x150
[   83.964361]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964362]  ? do_user_addr_fault+0x488/0x620
[   83.964366]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964367]  ? srso_alias_return_thunk+0x5/0xfbef5
[   83.964369]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
[   83.964372] RIP: 0033:0x6200808578d7
[   83.964374] Code: 00 00 90 f3 0f 1e fa 41 56 55 41 89 ce 48 83 ec 28 80 3d 7b f7 0d 00 00 74 29 45 31 c9 45 31 c0 41 89 ca b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 48 83 c4 28 5d 41 5e c3 66 0f 1f 84 00 00
[   83.964375] RSP: 002b:0000730c4e821530 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   83.964378] RAX: ffffffffffffffda RBX: 000006dbc456c570 RCX: 00006200808578d7
[   83.964379] RDX: 000000000000005c RSI: 000006dbc45884f0 RDI: 0000000000000004
[   83.964381] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[   83.964382] R10: 0000000000000000 R11: 0000000000000246 R12: 000006dbc456c480
[   83.964383] R13: 000006dbc456c450 R14: 0000000000000000 R15: 000006dbc456c610
[   83.964386]  </TASK>
[   83.964386] ---[ end trace ]---

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

v3:
- Fix incorrect channel copying
v2:
- Drop changes in cfg80211 as requested by Johannes

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 73850312580f..56beed61d2b7 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -358,7 +358,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -368,34 +369,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.45.2


