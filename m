Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB01E1882C8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCQMA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 08:00:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27842 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgCQMA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 08:00:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584446428; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0V4JeM7uMHP3PDzj6H7teVS8H+e3C0yYmlguWTAzDd4=; b=tYH8UjY+CmJiH6GPseZDp1tFO83W0XZE38gwy2cvQW10Ly6Kuj0z5qKPDSaHDjEhkdp7fyY7
 XIa+nax7dlY3pVh1VBKlS2quF3AuU2G9VLNgR6FrbDCYvA8yst5mQfjVHsC4S6biWHf/sM0D
 oQEiCieKsmLDOS7A753u6V9J7UU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70bbcf.7f52d9b2fdc0-smtp-out-n01;
 Tue, 17 Mar 2020 12:00:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6BECC433BA; Tue, 17 Mar 2020 12:00:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kumarpan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCC39C433CB;
        Tue, 17 Mar 2020 12:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCC39C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kumarpan@codeaurora.org
From:   Pravas Kumar Panda <kumarpan@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pravas Kumar Panda <kumarpan@codeaurora.org>
Subject: [PATCH] ath11k: Adding proper validation before accessing tx_stats
Date:   Tue, 17 Mar 2020 17:29:29 +0530
Message-Id: <1584446369-7021-1-git-send-email-kumarpan@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before dumping tx_stats proper validation was not been taken care of.
Due to which we were encountering null pointer dereference(kernel panic).
This scenario will arise when a station is getting disconnected and
we are changing the STA state by ath11k_mac_op_sta_state and assigning
tx_stats as NULL and after this the mac80211 will destroy the
debugfs entry from where we are trying to read the stats.

If anyone tries to dump tx_stats for that STA in between setting
tx_stats to NULL and debugfs file removal without checking the NULL
value it will run into a NULL pointer exception.

Proceeding with the analysis of "ARM Kernel Panic".
The APSS crash happened due to OOPS on CPU 3.
Crash Signature : Unable to handle kernel NULL pointer dereference at
virtual address 00000360
During the crash,
PC points to "ath11k_debug_htt_stats_init+0x16ac/0x1acc [ath11k]"
LR points to "ath11k_debug_htt_stats_init+0x1688/0x1acc [ath11k]".
The Backtrace obtained is as follows:
[<ffffffbffcfd8590>] ath11k_debug_htt_stats_init+0x16ac/0x1acc [ath11k]
[<ffffffc000156320>] do_loop_readv_writev+0x60/0xa4
[<ffffffc000156a5c>] do_readv_writev+0xd8/0x19c
[<ffffffc000156b54>] vfs_readv+0x34/0x48
[<ffffffc00017d6f4>] default_file_splice_read+0x1a8/0x2e4
[<ffffffc00017c56c>] do_splice_to+0x78/0x98
[<ffffffc00017c63c>] splice_direct_to_actor+0xb0/0x1a4
[<ffffffc00017c7b4>] do_splice_direct+0x84/0xa8
[<ffffffc000156f40>] do_sendfile+0x160/0x2a4
[<ffffffc000157980>] SyS_sendfile64+0xb4/0xc8

Signed-off-by: Pravas Kumar Panda <kumarpan@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 872f3ef..389dac2 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -219,6 +219,9 @@ static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
 	const int size = 2 * 4096;
 	char *buf;
 
+	if (!arsta->tx_stats)
+		return -ENOENT;
+
 	buf = kzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.7.4
