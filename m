Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2FBED3B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfIZIRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 04:17:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIZIRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 04:17:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96F00611DC; Thu, 26 Sep 2019 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569485824;
        bh=bWQXun6meXPZPLzi08JnOdTANdQb1vSiCzyEkFjY/Jg=;
        h=From:To:Cc:Subject:Date:From;
        b=XLM9Q1CPiOBa7tJxl1AWduOPqHwoC1rtFGiEZm56Z1tXICULB+QkflwBQVGuN6Vdg
         bSGmW2smOfxaP/O4rLidlhURbU1oUIrLHxYdy3dnP3ufMxaOhr2LtVO4b+afORYgHd
         +K0rQt3d7rY7u/y+bD8qiHzYTzQWnlQpcjTWSxKQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C10860A05;
        Thu, 26 Sep 2019 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569485824;
        bh=bWQXun6meXPZPLzi08JnOdTANdQb1vSiCzyEkFjY/Jg=;
        h=From:To:Cc:Subject:Date:From;
        b=XLM9Q1CPiOBa7tJxl1AWduOPqHwoC1rtFGiEZm56Z1tXICULB+QkflwBQVGuN6Vdg
         bSGmW2smOfxaP/O4rLidlhURbU1oUIrLHxYdy3dnP3ufMxaOhr2LtVO4b+afORYgHd
         +K0rQt3d7rY7u/y+bD8qiHzYTzQWnlQpcjTWSxKQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C10860A05
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Thu, 26 Sep 2019 16:16:53 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] nl80211: fix null pointer dereference
Date:   Thu, 26 Sep 2019 16:16:50 +0800
Message-Id: <1569485810-761-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the interface is not in MESH mode, the command 'iw wlanx mpath del'
will cause kernel panic.

The root cause is null pointer access in mpp_flush_by_proxy(), as the
pointer 'sdata->u.mesh.mpp_paths' is NULL for non MESH interface.

Unable to handle kernel NULL pointer dereference at virtual address 00000068
pgd = d2cf4000
[00000068] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
CPU: 1 PID: 4537 Comm: iw Not tainted 3.14.77 #1
task: dcfba280 ti: d83e0000 task.ti: d83e0000
PC is at _raw_spin_lock_bh+0x20/0x5c
LR is at mesh_path_del+0x1c/0x17c [mac80211]
pc : [<c021211c>]    lr : [<bf8c7648>]    psr: a0000013
sp : d83e1ca0  ip : 0000000f  fp : 00000014
r10: c08b3400  r9 : daf46800  r8 : d5f50f20
r7 : d8526500  r6 : d5f50f14  r5 : 00000068  r4 : 00000000
r3 : d83e0000  r2 : 00000201  r1 : d5f50f20  r0 : 00000068
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5787d  Table: 54cf406a  DAC: 00000015
Process iw (pid: 4537, stack limit = 0xd83e0238)
Stack: (0xd83e1ca0 to 0xd83e2000)
1ca0: d8526500 d5f50f20 d5f50f20 d83e1ce8 d9720300 d5f50f14 d9720300 00000000
1cc0: daf46800 c08b3400 00000014 bf6cdb7c bf6cdb5c bf86c868 d93b61a4 c05c309c
1ce0: 00000000 80150015 5d2f3783 000011b9 d5f50f00 d5f50f10 d52e9200 daf46800
1d00: c08b3400 d8a70000 d8526000 dd56a000 d83e0000 d5f50f00 d9720300 c05c2e28
1d20: 00000028 d83e1d5c 00000000 00000028 d83e1e08 c05c25d8 c08b4e94 d9720300
1d40: d3fcec00 c05c2e14 c05c2df4 dd56a000 d9720300 c05c1f90 d3fcec00 7fffffff
1d60: 00000000 d9720300 00000000 00000000 d3fcec00 d83e1f7c 00000000 c05c2420
1d80: 00000000 00000045 00000008 00000000 d2cf6db8 d2d242c0 00000000 000011b9
1da0: 00000000 00000000 00000000 d5a30900 00000028 d83e1f7c dcfba280 00000000
1dc0: d5a30900 d83e1e64 00000000 c05886d0 00000000 00000000 00000000 d83e1e08
1de0: dcfba280 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1e00: 00000000 00000000 d2cf6db8 00000045 00045000 00000028 d5a30900 c02ae84c
1e20: d83e1d94 d83e1f7c d83e1ec4 d83e1e64 d83e1ec4 00000128 00000000 d83e1e64
1e40: 00000008 00000000 d83e1f7c d83e1f7c 00000028 00000000 d83e1ea4 c0589f4c
1e60: dcf23318 b7c66138 00000000 dcfba280 d83e1fb0 00000200 b6e7dce8 c02228a0
1e80: 00003fec 00000000 d5f9aa80 dcf236bc b6e7dce8 00000000 00000000 00000000
1ea0: 00000000 bead2c68 00000020 00000000 bead2c68 c05b1498 00000000 00000010
1ec0: 00000000 00000010 00000000 00000000 00000030 00000000 00000000 0000001f
1ee0: dd4e4190 c02e124c 00000010 00000007 c087020c b6e7dce8 d83e1fb0 00000001
1f00: 00000000 bead28f8 00000001 c0208440 0000000e d59f1aa0 d5a30aa0 d59f1af0
1f20: dd401500 c02d3780 00000000 00000000 00000395 dcfba280 dcfba60c dcfba280
1f40: 00000128 bd943663 bead2c48 d5a30900 00000000 bead2c48 00000128 c0208e24
1f60: d83e0000 00001000 b6f30e34 c058add4 000044c0 00000000 fffffff7 d83e1ec4
1f80: 0000000c d83e1e64 00000001 00000000 00000000 00000000 b7c66078 bead2c48
1fa0: b7c66078 c0208c80 b7c66078 bead2c48 00000003 bead2c48 00000000 00000000
1fc0: b7c66078 bead2c48 b7c66078 00000128 b7c660d0 b7c67188 bead2d20 b6f30e34
1fe0: b6ecef8c bead2c18 b6ebaf94 b6e799e4 60000010 00000003 00000000 00000000
[<c021211c>] (_raw_spin_lock_bh) from [<bf8c7648>] (mesh_path_del+0x1c/0x17c [mac80211])
[<bf8c7648>] (mesh_path_del [mac80211]) from [<bf6cdb7c>] (extack_doit+0x20/0x68 [compat])
[<bf6cdb7c>] (extack_doit [compat]) from [<c05c309c>] (genl_rcv_msg+0x274/0x30c)
[<c05c309c>] (genl_rcv_msg) from [<c05c25d8>] (netlink_rcv_skb+0x58/0xac)
[<c05c25d8>] (netlink_rcv_skb) from [<c05c2e14>] (genl_rcv+0x20/0x34)
[<c05c2e14>] (genl_rcv) from [<c05c1f90>] (netlink_unicast+0x11c/0x204)
[<c05c1f90>] (netlink_unicast) from [<c05c2420>] (netlink_sendmsg+0x30c/0x370)
[<c05c2420>] (netlink_sendmsg) from [<c05886d0>] (sock_sendmsg+0x70/0x84)
[<c05886d0>] (sock_sendmsg) from [<c0589f4c>] (___sys_sendmsg.part.3+0x188/0x228)
[<c0589f4c>] (___sys_sendmsg.part.3) from [<c058add4>] (__sys_sendmsg+0x4c/0x70)
[<c058add4>] (__sys_sendmsg) from [<c0208c80>] (ret_fast_syscall+0x0/0x44)
Code: e2822c02 e2822001 e5832004 f590f000 (e1902f9f)
---[ end trace bbd717600f8f884d ]---

Tested HW: QCA9984
Tested FW: 10.4-3.10-00047

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d21b158..54d5c89 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6270,6 +6270,9 @@ static int nl80211_del_mpath(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_mpath)
 		return -EOPNOTSUPP;
 
+	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT)
+		return -EOPNOTSUPP;
+
 	return rdev_del_mpath(rdev, dev, dst);
 }
 
-- 
1.9.1

