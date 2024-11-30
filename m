Return-Path: <linux-wireless+bounces-15808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91E9DF229
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2024 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7957161AC9
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49EE1A2574;
	Sat, 30 Nov 2024 17:11:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2968468;
	Sat, 30 Nov 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986689; cv=none; b=MeGkVf1Wlv+lqdb3RyeVedjWxLtZCLM0xrjYiH2OYGaQ+I6idJ+O776p6ZQV/gy7Aj1AyKCTnK0NZwuQt8ZMjaABQz/gtRDWJfehir/sKqG50WCIvYJT1iCgnC61MTk+LN96O5VexC0rckscO9d9aI44IOtXFkadzS9hpEOwBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986689; c=relaxed/simple;
	bh=Dso1V0rhy/zLY7zeRFRdzfAdFp+fu8jhZhMvQReLTk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULSLIVEuKPIen9uOYayOFl+u0k7VwNGDToAxnnHZlOtAhYKXenfv/CcD/7cwuBywMbfSFpkkBZfdgovImMiDS06A7KnddRHxSmdtkyV6wc1ENBLHXyfJ5HvqDGiaxrHc9HEl8gF0A2uKOojqkAZH3j3eN/8dfuXucJv0nEzc4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost (unknown [10.193.223.147])
	by mail-app3 (Coremail) with SMTP id cC_KCgA3o8DrRUtnvL8pAQ--.36275S2;
	Sun, 01 Dec 2024 01:05:47 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>,
	Cengiz Can <cengiz.can@canonical.com>
Subject: [PATCH net] wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one
Date: Sun,  1 Dec 2024 01:05:26 +0800
Message-Id: <20241130170526.96698-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgA3o8DrRUtnvL8pAQ--.36275S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kJry3ZrWrJr1fKFy3urg_yoW5ZrW8pF
	WkGryxJF1UK34vqFWfGF48GFyxXFs8Zr1UCw4xtr1fCFnYqry8GryjgFsxXrnxuF1qyayf
	Z3WDJF4avw15J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/

Since the netlink attribute range validation provides inclusive
checking, the *max* of attribute NL80211_ATTR_MLO_LINK_ID should be
IEEE80211_MLD_MAX_NUM_LINKS - 1 otherwise causing an off-by-one.

One crash stack for demonstration:
==================================================================
BUG: KASAN: wild-memory-access in ieee80211_tx_control_port+0x3b6/0xca0 net/mac80211/tx.c:5939
Read of size 6 at addr 001102080000000c by task fuzzer.386/9508

CPU: 1 PID: 9508 Comm: syz.1.386 Not tainted 6.1.70 #2
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x177/0x231 lib/dump_stack.c:106
 print_report+0xe0/0x750 mm/kasan/report.c:398
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 kasan_check_range+0x287/0x290 mm/kasan/generic.c:189
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 ieee80211_tx_control_port+0x3b6/0xca0 net/mac80211/tx.c:5939
 rdev_tx_control_port net/wireless/rdev-ops.h:761 [inline]
 nl80211_tx_control_port+0x7b3/0xc40 net/wireless/nl80211.c:15453
 genl_family_rcv_msg_doit+0x22e/0x320 net/netlink/genetlink.c:756
 genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
 genl_rcv_msg+0x539/0x740 net/netlink/genetlink.c:850
 netlink_rcv_skb+0x1de/0x420 net/netlink/af_netlink.c:2508
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
 netlink_unicast_kernel net/netlink/af_netlink.c:1326 [inline]
 netlink_unicast+0x74b/0x8c0 net/netlink/af_netlink.c:1352
 netlink_sendmsg+0x882/0xb90 net/netlink/af_netlink.c:1874
 sock_sendmsg_nosec net/socket.c:716 [inline]
 __sock_sendmsg net/socket.c:728 [inline]
 ____sys_sendmsg+0x5cc/0x8f0 net/socket.c:2499
 ___sys_sendmsg+0x21c/0x290 net/socket.c:2553
 __sys_sendmsg net/socket.c:2582 [inline]
 __do_sys_sendmsg net/socket.c:2591 [inline]
 __se_sys_sendmsg+0x19e/0x270 net/socket.c:2589
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x90 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Update the policy to ensure correct validation.

Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Suggested-by: Cengiz Can <cengiz.can@canonical.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d2edb71f981..dd84fc54fb9b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -814,7 +814,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_LINKS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_policy),
 	[NL80211_ATTR_MLO_LINK_ID] =
-		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
+		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS - 1),
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
-- 
2.39.2


