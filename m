Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD66217F3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiKHPUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 10:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiKHPUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 10:20:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A3EA3
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5F4CB81B24
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE31C433D6;
        Tue,  8 Nov 2022 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920786;
        bh=rwQEXypN3h6kIbRyCrhWeIMhaVUwtzJxBfMeH9JViyg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZZw3tlynlbJeOpqD+rboaoMw9FJZzOzvLdoYjx5AJvSpVHodF9900aN5M1HqFzKFo
         Sqwr9IBQaU373ODdUS7nesaDD9fpl8KIbMyFHOcrUqa6IUgN3a2PXlXu81od7aAbHo
         dTMYaggeLxziT406/Wxo856wEBqq+XLPfFqOFZ9rk1aa7EiJvhJbOe/st2Nl3/Bhtl
         MvELyc0/Vlz7EWDtjeJ354BKX8hvpiQKFOILKPDctQDNo49TTU2v7T5znhdr/laMFF
         u8aWQrB9KR8SbvQAGZv/COO1wkgUP8sK9y+Key4C8uPCIh7D89xncjdMhR2vMrHxrg
         5wbin5BD0DoeQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     bjlockie@lockie.ca, toke@toke.dk, johannes@sipsolutions.net,
        nbd@nbd.name, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 wireless] wifi: mac8021: fix possible oob access in ieee80211_get_rate_duration
Date:   Tue,  8 Nov 2022 16:19:26 +0100
Message-Id: <8d0116580f2c5eafaea29acb2cbbc348ff853f5b.1667920478.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible out-of-bound access in ieee80211_get_rate_duration routine
as reported by the following UBSAN report:

UBSAN: array-index-out-of-bounds in net/mac80211/airtime.c:455:47
index 15 is out of range for type 'u16 [12]'
CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 6.1.0-060100rc3-generic
Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS R01-A2 07/18/2017
Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
Call Trace:
 <TASK>
 show_stack+0x4e/0x61
 dump_stack_lvl+0x4a/0x6f
 dump_stack+0x10/0x18
 ubsan_epilogue+0x9/0x43
 __ubsan_handle_out_of_bounds.cold+0x42/0x47
ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 [mac80211]
 ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
 ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
 ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
 mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
 mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
 mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
 process_one_work+0x225/0x400
 worker_thread+0x50/0x3e0
 ? process_one_work+0x400/0x400
 kthread+0xe9/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30

Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt76")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- drop WARN_ON_ONCE
---
 net/mac80211/airtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 2e66598fac79..e8ebd343e2bf 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -452,6 +452,9 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 			 (status->encoding == RX_ENC_HE && streams > 8)))
 		return 0;
 
+	if (idx >= MCS_GROUP_RATES)
+		return 0;
+
 	duration = airtime_mcs_groups[group].duration[idx];
 	duration <<= airtime_mcs_groups[group].shift;
 	*overhead = 36 + (streams << 2);
-- 
2.38.1

