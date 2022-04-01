Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1844EF46D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiDAO4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiDAOsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 10:48:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE54F47D;
        Fri,  1 Apr 2022 07:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20E24CE2586;
        Fri,  1 Apr 2022 14:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FF9C34118;
        Fri,  1 Apr 2022 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823908;
        bh=XBEpcDax8qRSbttUHaQbFXCkJGe2sYnlZAoXEQznmhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpH56G7FtSzly23RERKPS+dCK6muj5kINO0RryC2U52H+3use60WmquQOT8W6bnLz
         g1aysAEJTeW+yEFtYIU/Dj3/W458yenxQqo5ewaCHvHG/LK/OZmA9r9E0x5s8UOi+r
         fQBWWtZKd5X8KALJtqak0Dc2vClnUoG9v00YU98/yKayGPD13gvkBH+vU0s2GIxqe8
         ohE/438RIY4kBbuR67+g+/21Ey5+hFcXfQ4pXa+JJ9jqeGBzPKcNrYi2JuQgkrAX04
         S+EoGHz1CRAs5KiEEtJXsFmd+oZwCsn1LhWkSHQ7foIS4NtppQUvn44DHqPsR5pFsk
         70yJc9S9coctg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/98] ath11k: fix kernel panic during unload/load ath11k modules
Date:   Fri,  1 Apr 2022 10:36:17 -0400
Message-Id: <20220401143742.1952163-13-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

[ Upstream commit 22b59cb965f79ee1accf83172441c9ca0ecb632a ]

Call netif_napi_del() from ath11k_ahb_free_ext_irq() to fix
the following kernel panic when unload/load ath11k modules
for few iterations.

[  971.201365] Unable to handle kernel paging request at virtual address 6d97a208
[  971.204227] pgd = 594c2919
[  971.211478] [6d97a208] *pgd=00000000
[  971.214120] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  971.412024] CPU: 2 PID: 4435 Comm: insmod Not tainted 5.4.89 #0
[  971.434256] Hardware name: Generic DT based system
[  971.440165] PC is at napi_by_id+0x10/0x40
[  971.445019] LR is at netif_napi_add+0x160/0x1dc

[  971.743127] (napi_by_id) from [<807d89a0>] (netif_napi_add+0x160/0x1dc)
[  971.751295] (netif_napi_add) from [<7f1209ac>] (ath11k_ahb_config_irq+0xf8/0x414 [ath11k_ahb])
[  971.759164] (ath11k_ahb_config_irq [ath11k_ahb]) from [<7f12135c>] (ath11k_ahb_probe+0x40c/0x51c [ath11k_ahb])
[  971.768567] (ath11k_ahb_probe [ath11k_ahb]) from [<80666864>] (platform_drv_probe+0x48/0x94)
[  971.779670] (platform_drv_probe) from [<80664718>] (really_probe+0x1c8/0x450)
[  971.789389] (really_probe) from [<80664cc4>] (driver_probe_device+0x15c/0x1b8)
[  971.797547] (driver_probe_device) from [<80664f60>] (device_driver_attach+0x44/0x60)
[  971.805795] (device_driver_attach) from [<806650a0>] (__driver_attach+0x124/0x140)
[  971.814822] (__driver_attach) from [<80662adc>] (bus_for_each_dev+0x58/0xa4)
[  971.823328] (bus_for_each_dev) from [<80663a2c>] (bus_add_driver+0xf0/0x1e8)
[  971.831662] (bus_add_driver) from [<806658a4>] (driver_register+0xa8/0xf0)
[  971.839822] (driver_register) from [<8030269c>] (do_one_initcall+0x78/0x1ac)
[  971.847638] (do_one_initcall) from [<80392524>] (do_init_module+0x54/0x200)
[  971.855968] (do_init_module) from [<803945b0>] (load_module+0x1e30/0x1ffc)
[  971.864126] (load_module) from [<803948b0>] (sys_init_module+0x134/0x17c)
[  971.871852] (sys_init_module) from [<80301000>] (ret_fast_syscall+0x0/0x50)

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.6.0.1-00760-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/1642583973-21599-1-git-send-email-quic_vnaralas@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 3fb0aa000825..24bd0520926b 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -391,6 +391,8 @@ static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
 
 		for (j = 0; j < irq_grp->num_irq; j++)
 			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
+
+		netif_napi_del(&irq_grp->napi);
 	}
 }
 
-- 
2.34.1

