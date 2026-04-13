Return-Path: <linux-wireless+bounces-34688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBN/AICr3GlfVAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:38:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AE3E9358
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E39E3008A57
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB5D399352;
	Mon, 13 Apr 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2LWzUrw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51582264A9
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069492; cv=none; b=Xi9oIX32GdOBarqPRcr203ykKSVTSd4MgNMVMCfm4NeCjvYp9PEVNBKqawqDcmgpuMZKDbEix77DC5rg4zsoU0qfugEez+BaWtsfomWCV1AUoCC9SsqBfRDPqeYgsVGreMoEbN1cZRoYJd3BITKG/mrE8vaUEM2Z9pAzJkxHmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069492; c=relaxed/simple;
	bh=Ypv1sStll/7zXzM+H0oKxjcekFCiaikICyUhXYEtjJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1iVX8jIxUoxWa6/Y+cWipxnbkNxv3ApQkBum4CRc7A7KxlIfScOLtEgiU6rshKMcv0J1RwHoBo5HCM5H8oun8ygeIH9od+5ZtzK4lpA2RQDI5qDPEnpDlBAIlMYbomI+8aVGbjOygO/YCQwF9EGIqrqdtjA8j2i4E92gArSskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2LWzUrw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a29e6110so45079915e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776069489; x=1776674289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7zWQv6f5Kd001LwzZiHvzQamGOXU+AsETKL2/hMJf8=;
        b=f2LWzUrw1ts5MrHl7UcbY9e573jH3uXIho04OamnoWaYjRLNL5k3umvElfFujSTqHF
         vwUCvVuNatoqUyvbxJsB2FZg6rmSzueIPQVv3T+Tn4mfj4ajKIqQh4aDDE2TMDoQcdap
         nXYk00seRA4Zfs8ZbwbW+rMKaFiF19SS/PNDn0OxNIKpcW3kM75Czj20O/pa//hxjIfA
         pGrjaLER+fEQf297dtM6Njuhz+tf6VwjCpVLH3nYec4DwME6npx4m4pnvfkVWja+3EBU
         PL+1ScNkHY9No2QdR1GX2goeUGJ8xiVGXZ4F8OzdA83N7FERkE/VydoECEJ9FooW7X/Q
         Dbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069489; x=1776674289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7zWQv6f5Kd001LwzZiHvzQamGOXU+AsETKL2/hMJf8=;
        b=RdSjAUDPjhq376RtG5lyba6G/3hWsPG1HkI9/d5yj9cQ1Ug0jpo54l8zCiYWZp1fnq
         WHFv6LQocIz+ppCXDdB27vWHaYOExrabR12NBmlxhYaNLuZpZ22kh+ywWttDBsCXuUXw
         zeFkfsJRLNQ2SwJMa/nbBjOFZSRgbAFw3ouvUZxcRAqN1HPkmVAg3oIzAPQXIq932Saq
         jfffArH/DEgNYBYzs5hBWdpFpMAdafD9PpNgninRLAUrSB+g3S45RttcBYDWbE8hDp06
         sLL/IAXXdF3FB939M04IR0gsScaEtRzUH4RMyaKHO4sxndrRy8MTUuYIVKX2Giz7TFtP
         6iGw==
X-Gm-Message-State: AOJu0YzFkPNuoK90k8aUAMn1dDgmxOXecvUlhzFfgLFuIl4nmiFeVUdx
	OeJVom1hZMp2AhoPnK0XWEaWDzPom4SN1SAkbj/x/hNtHsOHYVbdCimD
X-Gm-Gg: AeBDiet3ErgyiyHvzBz5dmUnP1Fjy/J7RTK1E15rvFFwEOcDyaXKDkl1RtQhtNxDi7O
	p9iJ1PxmI/fPAGQDDGUr++mqSmkB1ixg1vGLLUtAYZMbQJR01Q373gbGAHA2R9yMeoFGVJr/eC4
	a3YgoTCQTNdGpGgrIeMqzsg0b7jyxPXhNeXOi9tjV1Oo3EjdSfhoGxS6f4LO/FHLNf/AfnlgmqY
	R9+mHAablQvF+uXD0y9AN2/MAKUd1UOsfE7CrxgNQCTj7nyZzqnr3FHQjHW2NhxhuFZFAXyLsdG
	HsM900FlTT/zO7JcIHSrlBbFaeucqWowPVImBg5L3+TjuQkxdagoI0NAvbHkQy1lZr7o27ZXayj
	c2e8EQBvVuA8LsiLuqqgpWbcCsJKSnd++pu6MgFs3mW7myIah5Q9+2CmebnpNINpiX9ObvZtS2R
	MG+ekm1QCb1KfLlZc0A9Cobx+8wvP0jguv1/Q+geR+yJhR7KFvUBOhs0Lh
X-Received: by 2002:a05:600c:5306:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488d68c3385mr170053005e9.27.1776069489040;
        Mon, 13 Apr 2026 01:38:09 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67a46bdsm139406055e9.3.2026.04.13.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:38:08 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	maharaja.kennadyrajan@oss.qualcomm.com
Subject: [PATCH ath-next 0/1] thermal read locking problem
Date: Mon, 13 Apr 2026 10:38:06 +0200
Message-ID: <20260413083807.1727905-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34688-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D4AE3E9358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

So I hit a deadlock between ath12k_pci_remove() and reading the hwmon
temperature of the same device. See the stack trace bellow

	[  369.804971] INFO: task sh:7638 blocked for more than 122 seconds.
	[  369.804991]       Not tainted 6.19.0git+ #15
	[  369.805000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[  369.805005] task:sh              state:D stack:0     pid:7638  tgid:7638  ppid:7637   task_flags:0x480100 flags:0x00080800
	[  369.805022] Call Trace:
	[  369.805028]  <TASK>
	[  369.805038]  __schedule+0x45b/0x1780
	[  369.805057]  ? rwsem_mark_wake+0x1a9/0x2c0
	[  369.805076]  ? wake_up_q+0x37/0x90
	[  369.805090]  schedule+0x27/0xd0
	[  369.805102]  kernfs_drain+0xec/0x170
	[  369.805116]  ? __pfx_autoremove_wake_function+0x10/0x10
	[  369.805130]  __kernfs_remove.part.0+0x85/0x220
	[  369.805144]  kernfs_remove+0x61/0x70
	[  369.805157]  __kobject_del+0x2e/0xa0
	[  369.805167]  kobject_del+0x13/0x30
	[  369.805175]  device_del+0x283/0x3d0
	[  369.805185]  ? rtnl_is_locked+0x15/0x20
	[  369.805200]  wiphy_unregister+0x10a/0x3f0 [cfg80211 6168fbe3683cd298138328882cdf9008f30e4673]
	[  369.805417]  ieee80211_unregister_hw+0x10c/0x130 [mac80211 a4ced2a7a5c741afca2c73dab2ee07ceec04d385]
	[  369.805625]  ath12k_mac_hw_unregister+0x71/0x100 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.805746]  ath12k_mac_unregister+0x2e/0x50 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.805895]  ath12k_core_hw_group_stop+0x18/0xa0 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.805972]  ath12k_core_hw_group_cleanup+0x37/0x90 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.806051]  ath12k_pci_remove+0x60/0x110 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.806137]  pci_device_remove+0x4a/0xc0
	[  369.806151]  device_release_driver_internal+0x19e/0x200
	[  369.806165]  unbind_store+0xa4/0xb0
	[  369.806179]  kernfs_fop_write_iter+0x14d/0x200
	[  369.806194]  vfs_write+0x25d/0x480
	[  369.806214]  ksys_write+0x73/0xf0
	[  369.806228]  do_syscall_64+0x11c/0x1610
	[  369.806242]  ? __folio_mod_stat+0x2d/0x90
	[  369.806252]  ? set_ptes.isra.0+0x36/0x80
	[  369.806266]  ? do_anonymous_page+0xfb/0x830
	[  369.806276]  ? __pte_offset_map+0x1b/0x100
	[  369.806291]  ? __handle_mm_fault+0xb46/0xf60
	[  369.806310]  ? count_memcg_events+0xd7/0x190
	[  369.806323]  ? handle_mm_fault+0x1d7/0x2d0
	[  369.806356]  ? do_user_addr_fault+0x21a/0x680
	[  369.806372]  ? exc_page_fault+0x82/0x1d0
	[  369.806385]  ? __irq_exit_rcu+0x4c/0xf0
	[  369.806397]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
	[  369.806408] RIP: 0033:0x7f2d2d5163be
	[  369.806443] RSP: 002b:00007fff2b63ea90 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
	[  369.806455] RAX: ffffffffffffffda RBX: 00007f2d2d66b580 RCX: 00007f2d2d5163be
	[  369.806462] RDX: 000000000000000d RSI: 0000561010670560 RDI: 0000000000000001
	[  369.806469] RBP: 00007fff2b63eaa0 R08: 0000000000000000 R09: 0000000000000000
	[  369.806476] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000d
	[  369.806481] R13: 000000000000000d R14: 0000561010670560 R15: 0000561010670080
	[  369.806496]  </TASK>
	[  369.806502] INFO: task cat:7652 blocked for more than 122 seconds.
	[  369.806512]       Not tainted 6.19.0git+ #15
	[  369.806519] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	[  369.806524] task:cat             state:D stack:0     pid:7652  tgid:7652  ppid:611    task_flags:0x400000 flags:0x00080000
	[  369.806538] Call Trace:
	[  369.806542]  <TASK>
	[  369.806549]  __schedule+0x45b/0x1780
	[  369.806565]  ? page_counter_try_charge+0x90/0x150
	[  369.806580]  ? mod_memcg_lruvec_state+0xc5/0x1f0
	[  369.806594]  schedule+0x27/0xd0
	[  369.806621]  schedule_preempt_disabled+0x15/0x30
	[  369.806634]  __mutex_lock.constprop.0+0x545/0xae0
	[  369.806644]  ? obj_cgroup_charge_account+0x23e/0x420
	[  369.806670]  ath12k_thermal_temp_show+0x2b/0x130 [ath12k 6ccd74c4d10a7837e98e0ec39774107bc2e6daf1]
	[  369.806854]  ? __kvmalloc_node_noprof+0x696/0x720
	[  369.806869]  dev_attr_show+0x1f/0x50
	[  369.806909]  sysfs_kf_seq_show+0xcc/0x120
	[  369.806921]  seq_read_iter+0x128/0x490
	[  369.806947]  ? rw_verify_area+0x56/0x180
	[  369.806959]  vfs_read+0x268/0x390
	[  369.806970]  ? __folio_mod_stat+0x2d/0x90
	[  369.806985]  ksys_read+0x73/0xf0
	[  369.807010]  do_syscall_64+0x11c/0x1610
	[  369.807028]  ? count_memcg_events+0xd7/0x190
	[  369.807041]  ? handle_mm_fault+0x1d7/0x2d0
	[  369.807060]  ? do_user_addr_fault+0x21a/0x680
	[  369.807075]  ? exc_page_fault+0x82/0x1d0
	[  369.807090]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
	[  369.807099] RIP: 0033:0x7f2e4bd6d3be
	[  369.807139] RSP: 002b:00007ffcd412d410 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
	[  369.807149] RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f2e4bd6d3be
	[  369.807156] RDX: 0000000000040000 RSI: 00007f2e4bc96000 RDI: 0000000000000003
	[  369.807162] RBP: 00007ffcd412d420 R08: 0000000000000000 R09: 0000000000000000
	[  369.807167] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcd412d7a8
	[  369.807172] R13: 00007f2e4bc96000 R14: 0000000000040000 R15: 0000000000000000
	[  369.807204]  </TASK>

This can be replicated at will on my side by force unbinding the driver
while reading in a loop:
  - while [ true ]; do cat /sys/class/ieee80211/phy0/hwmon2/temp1_input; done
  - echo 0000:01:00.0 > /sys/bus/pci/drivers/ath12k_wifi7_pci/unbind

I'm not sure if the way of fixing things is the best, but it works around
the deadlock in my tests.

Also as this is just in ath-next for now not sure if I should add a proper
fixes tag ?

Nicolas Escande (1):
  wifi: ath12k: avoid deadlock in thermal read

 drivers/net/wireless/ath/ath12k/thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.53.0


