Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56690BFD02
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 04:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfI0CDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 22:03:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfI0CDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 22:03:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A69EE60767; Fri, 27 Sep 2019 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569549816;
        bh=HBoowyETudlTCbIORUXxsOn1+fo9w5kl351Hdup6D6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5yScTP/oIva92BxXxTmSgJt88vNQWF8ch1uZbfe8JAaJORNqKQXtEAH4pefFjC49
         z+cTR+U3aWWCwBpZqmUb9zvrpdEXqbRuybdcyQeIB9e4wbRCAP0HFQy2K4M+zp9J55
         UtkSyi2afKH2r6LVyN9ODCo3tbfz5rj1LKCeclws=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B67160767;
        Fri, 27 Sep 2019 02:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569549815;
        bh=HBoowyETudlTCbIORUXxsOn1+fo9w5kl351Hdup6D6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=SMgQ9LGE7ZdRY0oyqkifKi2IIzL2v1GK26BXHX9oqgcVkS2z72Uh3qdrq8nP3GxWp
         q07zYPYqK6GwV1Gt+wG0E6ySN7KgMHZwZ03+ByjHwnUYctvGpV6HGsHExfu3ILcXxN
         xaEFVN97LoCxkLyIZf2uaLa0Cw5UitVdXfTuWEyM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B67160767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Fri, 27 Sep 2019 10:03:22 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] mac80211: fix txq null pointer dereference
Date:   Fri, 27 Sep 2019 10:03:16 +0800
Message-Id: <1569549796-8223-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the interface type is P2P_DEVICE or NAN, read the file of
'/sys/kernel/debug/ieee80211/phyx/netdev:wlanx/aqm' will get a
NULL pointer dereference. As for those interface type, the
pointer sdata->vif.txq is NULL.

Unable to handle kernel NULL pointer dereference at virtual address 00000011
CPU: 1 PID: 30936 Comm: cat Not tainted 4.14.104 #1
task: ffffffc0337e4880 task.stack: ffffff800cd20000
PC is at ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
LR is at ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
pc : [<ffffff8000b7cd00>] lr : [<ffffff8000b7cd00>] pstate: 60000145
sp : ffffff800cd23bb0
x29: ffffff800cd23c00 x28: ffffffc0337e4880
x27: ffffff8008a04000 x26: 0000000000000003
x25: 000000000000018e x24: ffffff80090f9d30
x23: ffffffc034b62000 x22: 0000000000000000
x21: ffffffc0335008e0 x20: ffffff800cd23c10
x19: 00000000000000c8 x18: 0000000000000000
x17: 0000000000000000 x16: ffffff80081ef454
x15: 0000000000000000 x14: 00000000f45c1d27
x13: 00000000ffab6710 x12: 0000000000000003
x11: 0000000000000006 x10: 0000000000000000
x9 : 0000000000000001 x8 : ffffffc0337e4880
x7 : 0000000000000003 x6 : 00000000f4498000
x5 : 0000000000000000 x4 : ffffff8000b7cccc
x3 : ffffff800cd23e80 x2 : 00000000000000c8
x1 : ffffff800cd23c10 x0 : ffffffc0335008e0
Process cat (pid: 30936, stack limit = 0xffffff800cd20000)
[Call trace:
Exception stack(0xffffff800cd23a70 to 0xffffff800cd23bb0)
3a60:                                   ffffffc0335008e0 ffffff800cd23c10
3a80: 00000000000000c8 ffffff800cd23e80 ffffff8000b7cccc 0000000000000000
3aa0: 00000000f4498000 0000000000000003 ffffffc0337e4880 0000000000000001
3ac0: 0000000000000000 0000000000000006 0000000000000003 00000000ffab6710
3ae0: 00000000f45c1d27 0000000000000000 ffffff80081ef454 0000000000000000
3b00: 0000000000000000 00000000000000c8 ffffff800cd23c10 ffffffc0335008e0
3b20: 0000000000000000 ffffffc034b62000 ffffff80090f9d30 000000000000018e
3b40: 0000000000000003 ffffff8008a04000 ffffffc0337e4880 ffffff800cd23c00
3b60: ffffff8000b7cd00 ffffff800cd23bb0 ffffff8000b7cd00 0000000060000145
3b80: ffffff800cd23ba0 ffffff80088e16e4 0000007fffffffff ffffff800cd23c40
3ba0: ffffff800cd23c00 ffffff8000b7cd00
[<ffffff8000b7cd00>] ieee80211_if_fmt_aqm+0x34/0xa0 [mac80211]
[<ffffff8000b7c414>] ieee80211_if_read+0x60/0xbc [mac80211]
[<ffffff8000b7ccc4>] ieee80211_if_read_aqm+0x28/0x30 [mac80211]
[<ffffff80082eff94>] full_proxy_read+0x2c/0x48
[<ffffff80081eef00>] __vfs_read+0x2c/0xd4
[<ffffff80081ef084>] vfs_read+0x8c/0x108
[<ffffff80081ef494>] SyS_read+0x40/0x7c

Tested HW: QCA9984
Tested FW: 10.4-3.10-00047

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 net/mac80211/debugfs_netdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index b1438fd..64b544a 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -487,9 +487,14 @@ static ssize_t ieee80211_if_fmt_aqm(
 	const struct ieee80211_sub_if_data *sdata, char *buf, int buflen)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct txq_info *txqi = to_txq_info(sdata->vif.txq);
+	struct txq_info *txqi;
 	int len;
 
+	if (!sdata->vif.txq)
+		return 0;
+
+	txqi = to_txq_info(sdata->vif.txq);
+
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
@@ -658,7 +663,9 @@ static void add_common_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD(rc_rateidx_vht_mcs_mask_5ghz);
 	DEBUGFS_ADD(hw_queues);
 
-	if (sdata->local->ops->wake_tx_queue)
+	if (sdata->local->ops->wake_tx_queue &&
+	    sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
+	    sdata->vif.type != NL80211_IFTYPE_NAN)
 		DEBUGFS_ADD(aqm);
 }
 
-- 
1.9.1

